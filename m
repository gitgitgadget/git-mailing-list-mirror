X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: should git download missing objects?
Date: Mon, 13 Nov 2006 23:52:39 +0100
Message-ID: <20061113225239.GA9411@steel.home>
References: <ej7fgp$8ca$1@sea.gmane.org> <7vwt60bggs.fsf@assigned-by-dhcp.cox.net> <20061113194532.GA4547@steel.home> <7virhj6rj7.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 22:53:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7virhj6rj7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-ID: Vge+0BZHZebWRHNK5Ig0tea+ZCztShLVKrIcnbNQfXutA47CqveLQz
X-TOI-MSGID: 76a11ad5-12ba-42d4-b0f9-2d7c1504cf19
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31328>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjkfr-0006dt-AS for gcvg-git@gmane.org; Mon, 13 Nov
 2006 23:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933121AbWKMWxD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 17:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933122AbWKMWxD
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 17:53:03 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:8685 "EHLO
 mailout08.sul.t-online.com") by vger.kernel.org with ESMTP id S933121AbWKMWxB
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 17:53:01 -0500
Received: from fwd27.aul.t-online.de  by mailout08.sul.t-online.com with smtp
  id 1Gjkff-0005g4-00; Mon, 13 Nov 2006 23:52:55 +0100
Received: from tigra.home
 (Vge+0BZHZebWRHNK5Ig0tea+ZCztShLVKrIcnbNQfXutA47CqveLQz@[84.163.84.190]) by
 fwd27.sul.t-online.de with esmtp id 1GjkfR-1Vdyd60; Mon, 13 Nov 2006 23:52:41
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id EAE1B277AF; Mon, 13 Nov 2006 23:52:40 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1GjkfP-0002TI-TF; Mon, 13 Nov 2006 23:52:39 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano, Mon, Nov 13, 2006 21:05:48 +0100:
> > Junio C Hamano, Sun, Nov 12, 2006 20:41:23 +0100:
> >> Since this is not everyday anyway, a far easier way would be to
> >> clone-pack from the upstream into a new repository, take the
> >> pack you downloaded from that new repository and mv it into your
> >> corrupt repository.  You can run fsck-objects to see if you got
> >> back everything you lost earlier.
> >
> > I get into such a situation annoyingly often, by using
> > "git clone -l -s from to" and doing some "cleanup" in the
> > origin repository. For example, it happens that I remove a tag,
> > or a branch, and do a repack or prune afterwards. The related
> > repositories, which had "accidentally" referenced the pruned
> > objects become "corrupt", as you put it.
> >
> > At the moment, if I run into the situation, I copy packs/objects from
> > all repos I have (objects/info/alternates are useful here too), run a
> > fsck-objects/repack and hope nothing is lost. It works, as I almost
> > always have "accidental" backups somewhere, but is kind of annoying to
> > setup. A tool to do this job more effectively will be very handy (at
> > least, it wont have to copy gigabytes of data over switched windows
> > network. Not often, I hope. Not _so_ many gigabytes, possibly).
> 
> I suspect it is a different issue.  Maybe you would need reverse
> links from the origin directory to .git/refs/ directroy of
> repositories that borrow from it to prevent pruning.  No amount
> of butchering fetch-pack to look behind incomplete refs that lie
> and claim they are complete would solve your problem if you do
> not have any "accidental backups".

It's is not about preventing this from happening. It is about
recovering from user error (which I plainly did). The discussion about
"git fetch --recover" sound very much like what would helped in that
situation. I'll just try not doing it next time, but if I do, it'd be
nice to have a tool to help me recover from it. Not prevent, not
seeing it possible, just help.

Anyway, it's kind of too late for that repositories. And not very
convenient to work with: the branches in the slave repos come and go
often, they pull from each other and push into central (aka origin)
repo. Maintain the borrowed refs in sync would be nightmare (as is: "I
promise to forget doing it").
