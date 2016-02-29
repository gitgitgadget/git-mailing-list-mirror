From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e
Date: Mon, 29 Feb 2016 10:56:22 +0100
Message-ID: <56D415C6.2040203@web.de>
References: <56D3E56A.5010608@web.de>
 <20160229092816.GA23910@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 10:56:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaKZM-0006o8-SN
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 10:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbcB2J4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 04:56:44 -0500
Received: from mout.web.de ([212.227.17.11]:64595 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbcB2J4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 04:56:44 -0500
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M0yiR-1ZlfaJ06Zz-00vA1X; Mon, 29 Feb 2016 10:56:24
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <20160229092816.GA23910@sigill.intra.peff.net>
X-Provags-ID: V03:K0:klifu7byIla6GxSwrBVMmiBUKbkocH4l8+aRuSo4LBCu922I4C5
 YQ4dxKPT9RuOtlNOjnL2GWOuw71VRnbiWaqXnJotmMMgAPE96hBXWzed+iGZGTpiTBHzU4R
 pghbsz4VqQDgjantADaB9mNeDE0SpnGsYHhpOMVWh3bFQ9A55cHIwDSNyWh6OZqUUUwoqcE
 wWvUvEU9bBO09UeAvpCbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W5Y7o9bCrh8=:0XdECKY7Gtwo67YgjfiWLo
 xaEf/HIUe9qbo5mY5gPFf5l+4MNAgW3IyaZEnpV03zCECfiUYlHZ1xG/kRBs1HHG+N3XK4STu
 ZCG5UYBMkzEcIoLsMuwCE915Y9BG7liWNIUyHa45BPyi42IuW2on9PXjfxDeEgLYieNpuuNnc
 aDmIxBZYpIKk+6Y98PKTGebf6oUNK6tWFkwgUcwlaomF6/JTRSwHMnX7ciy8E84Qpa9QwwjYj
 BzYsUdui7hRtaWdrrLcvcoy8VYHKfgAZuOzqYlc0cC9h4DWqHqHO3OgEz98FCTBgMEcifr30F
 TqvyvfoswnBanD9stQ1ULzZDZOrvo0QdG9UC5BJ+TNQYooIw/5Yj3T466a6Oqcdz8KLJf+/ql
 +Lq2CVv+lFyPOTUQZAzMnfMwwlVn3+u/zIFzN24qsPTHtX3pjhpu3FdaTqxZenLIz0WiLYxK+
 WUy6BhdEE7TfsCGhJyDGJtf/M65kG5DWitFYKJm0FJ3wTT1cQYJ4ZrRg/Pd0KrM77uax4m+bX
 Sk/2pGXlhF74CFncENCkqdCZPAFuaMt5aCQAlejvYMxuQVsANLKde/d4IEUTdNcAwouF4ZTN/
 gdEwFPsZobjjf5+8pHfGCjV/z6a5gQPb0lM0g/0SYROpI1Q0iJtVwEcKPda9PvlByM/1kBh9R
 3MPIVXdga4BAfveIelAfx5KtzwdT9GnfnMgGHW3FfMkJLz1eiAx/Im+vZFeoz4v/ckyKmLIV8
 sCxeQFc8DGuxETVFoghOuCoPFQbsLtz2dD6iIKDFDrHqyJOYiGetmJ8co5s2Wx0TvKsLvWOv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287816>

Thanks for the fast-patch.

I manually copied the patch, But there are more probles, it seems.

$ git diff
diff --git a/compat/mingw.c b/compat/mingw.c
index cfedcf9..b1163f2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1069,7 +1069,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char 
**argv, char **deltaen
                         free(quoted);
         }

-       wargs = xmalloc_array(st_add(st_mult(2, args.len), 1), sizeof(wchar_t));
+       wargs = ALLOC_ARRAY(st_add(st_mult(2, args.len), 1), sizeof(wchar_t));
         xutftowcs(wargs, args.buf, 2 * args.len + 1);
         strbuf_release(&args);


tb@torbogwm MINGW64 ~/Users/tb/projects/git/tb ((2273582...))
$ make
     CC compat/mingw.o
In file included from compat/mingw.c:1:0:
compat/mingw.c: In function 'mingw_spawnve_fd':
compat/../git-compat-util.h:769:60: error: invalid type argument of unary '*' 
(have 'size_t {aka long long unsigned int}')
  #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
                                                             ^
compat/mingw.c:1072:10: note: in expansion of macro 'ALLOC_ARRAY'
   wargs = ALLOC_ARRAY(st_add(st_mult(2, args.len), 1), sizeof(wchar_t));
           ^
Makefile:1948: recipe for target 'compat/mingw.o' failed
make: *** [compat/mingw.o] Error 1
