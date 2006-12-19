X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Possible optimization for gitweb
Date: Tue, 19 Dec 2006 23:22:25 +0100
Organization: At home
Message-ID: <em9oi5$72t$1@sea.gmane.org>
References: <20061219205422.GA17864@localhost> <7v1wmvpmef.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 19 Dec 2006 22:20:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 33
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34860>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwnJi-0003iW-58 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 23:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933045AbWLSWUG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 17:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933047AbWLSWUG
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 17:20:06 -0500
Received: from main.gmane.org ([80.91.229.2]:37039 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S933045AbWLSWUE
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 17:20:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GwnJT-0000cX-1y for git@vger.kernel.org; Tue, 19 Dec 2006 23:19:55 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 23:19:55 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 19 Dec 2006
 23:19:55 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

[Please Cc: git@vger.kernel.org]

Junio C Hamano wrote:

> Robert Fitzsimons <robfitz@273k.net> writes:
> 
>> The new workflows I'm proposing would be:
>>      get/parse ~100 commit's using rev-list
>>      foreach commit
>>              output commit
> 
> Absolutely.
> 
> And Ok on rev-list part, but perhaps --skip would be more
> appropriate name.

The only problem that you can't use --parents with "history" view, because
together with --full-history it shows also all merges (--full-history
without --parents doesn't show merges which does not affect given file or
directory; the sequence in which --parents and --full-history are taken is
a bit strange to me). So you have to keep current parse_commit (or extend
it), and if I remember correctly you do that. 

I'm also for --skip (not --start-count), although... --start-count with
--max-count seems more natural; one place it can be confusing is that we
count skipped commits or not? I.e. we use --start-count=10 --max-count=20
to get second 10 of commits, or --skip=10 --max-count=10 to get second 10
of commits?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

