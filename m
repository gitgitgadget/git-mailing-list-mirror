X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-merge-recursive segmentation error
Date: Tue, 19 Dec 2006 18:15:20 -0800 (PST)
Message-ID: <929899.78332.qm@web31809.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0612191709320.6766@woody.osdl.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 20 Dec 2006 02:15:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=WlXEes7dIhN6hFOQNvASkfwJjE9eKtF0bI0LLPdCvrQsepB3CxbPVbKknxILP8VSK/g+hnhj4p1JAE+Q8aCn5kLQ3J/ulWDuCqvgRrjCc9BkA/CSgn3+tK4DRONCFu2S+1WvXogWhDvE3voa2KfOp6OFWJh+UccB1bt+Ixqdx6I=;
X-YMail-OSG: xk4gGMsVM1l5Up1hf4YbGzDE3GlEa9SQr9M.a_AHOpa19LsbaBAX5h4sztC6ZaCfqQ--
In-Reply-To: <Pine.LNX.4.64.0612191709320.6766@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34892>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwqzN-0007x9-5H for gcvg-git@gmane.org; Wed, 20 Dec
 2006 03:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964777AbWLTCPW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 21:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWLTCPW
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 21:15:22 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:21267 "HELO
 web31809.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S964777AbWLTCPW (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 21:15:22 -0500
Received: (qmail 78507 invoked by uid 60001); 20 Dec 2006 02:15:20 -0000
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Tue,
 19 Dec 2006 18:15:20 PST
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

--- Linus Torvalds <torvalds@osdl.org> wrote:
> Can you run that by hand under gdb and get a backtrace?

Linus,

Auto-merging init/Kconfig
Auto-merging init/version.c

Program received signal SIGSEGV, Segmentation fault.
xdl_merge (orig=Variable "orig" is not available.
) at xdiff/xmerge.c:200
200                     t2.ptr = (char *)xe2->xdf2.recs[m->i2]->ptr;
(gdb) bt
#0  xdl_merge (orig=Variable "orig" is not available.
) at xdiff/xmerge.c:200
#1  0x000000000040322c in merge_file (o=0x7fffd4f762f0, a=0x7fffd4f76270, b=0x7fffd4f762b0,
branch1=0x7fffd4f77976 "HEAD", 
    branch2=0x7fffd4f7797b "cc016448b0bf0764928275d034e367753bde8162") at merge-recursive.c:667
#2  0x0000000000404e87 in merge_trees (head=0x12e4a00, merge=0x555328, common=0x555350,
branch1=Variable "branch1" is not available.
) at merge-recursive.c:1074
#3  0x0000000000405376 in merge (h1=0x5452f0, h2=0x545370, branch1=0x7fffd4f77976 "HEAD",
branch2=0x7fffd4f7797b "cc016448b0bf0764928275d034e367753bde8162", call_depth=0, 
    ancestor=0x5453f0, result=0x7fffd4f764e0) at merge-recursive.c:1245
#4  0x00000000004056a5 in main (argc=Variable "argc" is not available.
) at merge-recursive.c:1312

I also ran git-bisect twice over two well known but overlapping
good-bad regions and I get the same commit as being the culprit.
It seems to be commit 1510fea781cb0517eeba8c378964f7bc4f9577ab.

    Luben
