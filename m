X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git fetch slow as molasses due to tag downloading
Date: Fri, 15 Dec 2006 23:27:03 +0100
Organization: At home
Message-ID: <elv7av$n0$1@sea.gmane.org>
References: <elrr8j$a02$1@sea.gmane.org> <Pine.LNX.4.63.0612141701440.3635@wbgn013.biozentrum.uni-wuerzburg.de> <7vtzzwn7su.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 22:26:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 34
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34567>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvLVa-00025r-Ma for gcvg-git@gmane.org; Fri, 15 Dec
 2006 23:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030217AbWLOWZu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 17:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWLOWZu
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 17:25:50 -0500
Received: from main.gmane.org ([80.91.229.2]:42494 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1030217AbWLOWZt
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 17:25:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvLUW-0002HF-KJ for git@vger.kernel.org; Fri, 15 Dec 2006 23:25:20 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 23:25:20 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 23:25:20 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> IMHO this should be solved as a filter: "git-show-ref --stdin 
>> --show-invalid". Thus, git does not have to traverse _every_ ref for 
>> _every_ incoming tag.
> 
> That sounds like a too specialized hack to me.  We should first
> speed up the general "--verify $ref" case; as you corrected me
> earlier it still has a useless loop.
> 
> If it is still too slow (which I suspect it could be the case,
> with fork+exec overhead), we should _also_ pursue the filter
> approach, but even then I think "filter out the valid ones" is a
> specialized hack, if you mean "show only the invalid one's
> names" by --show-invalid.
> 
> It would make sense to do
> 
>         $ git show-ref --show-invalid v1.0.0 v2.6.18
>         f665776185ad074b236c00751d666da7d1977dbe refs/tags/v1.0.0
>         - refs/tags/v2.6.18
> 
> (and its equivalent to take refs from --stdin) though.

Nice idea. And having '-' is probably better than using
00000000000000000000000000000000000000000 as for non-existing objects.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

