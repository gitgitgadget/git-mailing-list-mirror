Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335BC1F462
	for <e@80x24.org>; Tue, 21 May 2019 20:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfEUUEY (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 16:04:24 -0400
Received: from avasout04.plus.net ([212.159.14.19]:52779 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfEUUEY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 16:04:24 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 16:04:23 EDT
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id TAsUhLGLoticRTAsVhZmva; Tue, 21 May 2019 20:56:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1558468612; bh=Z8OAzeLPpYon/bQ8EUyBIXJ8Wwj0c9gjOTuC4WI6AAY=;
        h=To:Cc:From:Subject:Date;
        b=K4tBn6gtxbrqS2uHfsECcNfse4+aT425tJrIsxvqnJm82wirCPgbd4WpJy7fvqTax
         jHQvZDnWmoyl0qpSPGBaaQZsdiEpJm0qrpP0E4DJL7fbeYZRuvlDtX6AZb9dgRk9zp
         Bt3dFQRpUtHY9CZVD/3k/jq47Lm8sJerOM2acnBszNIJLJYrARAWZxhHYwz5q1KUn0
         4GcTu2hbGM4JW8+cfHkbbQxL65v0oAeoS9JRBGUp+ENjAMbMDFBzSAQlQ+y4DdgC5y
         kICsd9I+wU35PKVH8d4RuawP0actjVMGZT2aHoiGLevM4ZlwQxtBKCLNGOYFYUsqY6
         vDGG5mjLY2JgA==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Gs88BX9C c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=IkcTkHD0fZMA:10 a=aPe93lQ98jRI3aBQuFcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Incorrect diff-parseopt conversion?
Message-ID: <82f79cd9-5273-b9a4-744d-f5fa95dd1f47@ramsayjones.plus.com>
Date:   Tue, 21 May 2019 20:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK+x1KoYGKboFy9HvB/gkUzjGwBll85Pj6NkWeB0kslrfBh0TwAdETpYWWXW4oXJf7jCBQkiNDQuK6LJ2i27v61YPTY8qz34Fud1MM5uIhFNsZ5nWpRY
 6caW059obVSF03EZIsYu342ychNsCaN0cluB6AsSBUQaYiN3u1X0umCIcyNw+uK4p8FeFlUNFueMXw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

I am in the middle of rebasing a long running branch onto
current master (v2.22.0-rc1) and noticed something odd with
commit af2f368091 ("diff-parseopt: convert --output-*",
2019-02-21).

As part of the branch I am rebasing, I have defined a new
OPT_LL_CALLBACK() macro[1], which I had intended to apply to
the 'output' option to diff. However, commit af2f368091
defines that option thus:

+               { OPTION_CALLBACK, 0, "output", options, N_("<file>"),
+                 N_("Output to a specific file"),
+                 PARSE_OPT_NONEG, NULL, 0, diff_opt_output },

Note that the 'option type' is given as OPTION_CALLBACK, not
as OPTION_LOWLEVEL_CALLBACK. Is this intended?

ATB,
Ramsay Jones

[1] Yes, the reason my branch is long running is because
we keep changing the same files! We have both defined new
OPT_() macros, some with the same name ... ;-)


