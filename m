Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640C52018E
	for <e@80x24.org>; Sun, 10 Jul 2016 18:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692AbcGJSlO (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 14:41:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53677 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbcGJSlN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 14:41:13 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rncW9099Fz3hkxl;
	Sun, 10 Jul 2016 20:41:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rncW85dvMzvkHx;
	Sun, 10 Jul 2016 20:41:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id BPQSWQog-GSH; Sun, 10 Jul 2016 20:41:07 +0200 (CEST)
X-Auth-Info: mjpebDpNoJ+7NEOTsTagZ5ls4pKz9p9WgiWDE2tSMhSq1ojM+ntKH8elzw+nfvmf
Received: from igel.home (ppp-88-217-3-50.dynamic.mnet-online.de [88.217.3.50])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 10 Jul 2016 20:41:07 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 90E762C2DBB; Sun, 10 Jul 2016 20:41:07 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Odd git overrflow bug?
References: <CA+55aFz=sZnABJr6F2yF_xvx6J6fZod6BbiL2OwszEnjjn-dEw@mail.gmail.com>
X-Yow:	This is my WILLIAM BENDIX memorial CORNER where I worship William
 Bendix like a GOD!!
Date:	Sun, 10 Jul 2016 20:41:07 +0200
In-Reply-To: <CA+55aFz=sZnABJr6F2yF_xvx6J6fZod6BbiL2OwszEnjjn-dEw@mail.gmail.com>
	(Linus Torvalds's message of "Sun, 10 Jul 2016 09:02:44 -0700")
Message-ID: <87eg712v5o.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.95 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We have an odd bug report in the kernel, where somebody had trouble
> bisecting all the way due to
>
>   "git is failing with "you are trying to use to much memory"(?!)"
>
> which can't be an exact  error message quote, but the closest I can
> find smells like the "unsigned_add_overflows()" check in the strbuf
> code. Very odd.

I've seen that too, but only at the end of bisection, when it tries to
display the bad commit.

For example, when running git bisect on git://gcc.gnu.org/git/gcc:

$ git bisect start de4fa746271d39d490b59bdfbbdd2cf5b54c0521 dd58bf212e9a250300e64d78748418b01d0035cd
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[f529d395184700e2404f4a293a2198355ab7ded5] Daily bump.
$ git bisect good
de4fa746271d39d490b59bdfbbdd2cf5b54c0521 is the first bad commit
commit de4fa746271d39d490b59bdfbbdd2cf5b54c0521
fatal: you want to use way too much memory

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
