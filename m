X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 15:14:50 +0200
Message-ID: <4540B4CA.2050502@dawes.za.net>
References: <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>	<200610251146.06116.jnareb@gmail.com>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<20061026111338.GA15179@coredump.intra.peff.net> <87u01r9rz7.fsf@alplog.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 13:15:26 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Original-Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
In-Reply-To: <87u01r9rz7.fsf@alplog.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30210>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd54f-0005ec-Bm for gcvg-git@gmane.org; Thu, 26 Oct
 2006 15:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423499AbWJZNPE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 09:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423500AbWJZNPE
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 09:15:04 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:47805 "EHLO
 spunkymail-a12.dreamhost.com") by vger.kernel.org with ESMTP id
 S1423502AbWJZNPB (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 09:15:01 -0400
Received: from [192.168.201.65] (dsl-165-1-60.telkomadsl.co.za
 [165.165.1.60]) by spunkymail-a12.dreamhost.com (Postfix) with ESMTP id
 8A1AB7F9E; Thu, 26 Oct 2006 06:14:58 -0700 (PDT)
To: Vincent Ladeuil <v.ladeuil@alplog.fr>
Sender: git-owner@vger.kernel.org

Vincent Ladeuil wrote:
>>>>>> "Jeff" == Jeff King <peff@peff.net> writes:
> 
>     Jeff> On Thu, Oct 26, 2006 at 12:52:05PM +0200, Vincent Ladeuil wrote:
>     >> Ok, so git make a distinction between the commit (code created by
>     >> someone) and the tree (code only).
> 
>     Jeff> Yes (a commit is a tree, zero or more parents, commit message, and
>     Jeff> author/committer info).
> 
> The parents of a tree are also trees or can/must they be commits ?

This refers to the parents of a _commit_, not of a tree, and the parents 
must be _commits_. The parents allow us to determine what changed 
between the previous commit(s), and the current one. If there are more 
than one parent, then we have a merge commit.

So, a commit refers to a tree representing the state of the code at the 
time of the commit, as well as to any parent commit(s). If there are no 
parent commits, then the commit is an "initial commit" (i.e. the first 
checkin). A project can have multiple "initial commits", typically where 
two previously independent projects are merged together, c.f. gitk and git.

> 
>     >> Commits are defined by their parents.
> 
>     Jeff> Partially, yes.
> 
> I buy that this "partially" means "the other parts are irrelevant
> to this discussion".

Yes.

>     >> Trees are defined by their content only ?
> 
>     Jeff> Yes.
> 
> So it is possible that : starting from a tree T,
> 
> - I make a patch A,
> - you make the patch B,
> - A and B are equal (stop watching above my shoulder please, or what is me ?),
> - we both commit,
> - we pull changes from each other repository.
> 
> We will end up with a tree T2 with a hash corresponding to both
> T+A and T+B, but each of us will have a different commit id CA
> and CB both pointing to T2, did I get it ?
> 
>     Vincent

Yes. That is exactly right.

 From there, we can either trivially merge CA and CB with a new merge 
commit referring to T2, but citing both CA and CB as parents, or simply 
discard one of the lines of development, depending on how much 
subsequent development cited CA or CB as parents.

