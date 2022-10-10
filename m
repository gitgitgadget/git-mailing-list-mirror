Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E97C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 15:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJJPkj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 Oct 2022 11:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJJPkf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 11:40:35 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA54B0C7
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 08:40:33 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 29AFeNJC075261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Oct 2022 11:40:23 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'orygaw'" <orygaw@protonmail.com>, <git@vger.kernel.org>
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
In-Reply-To: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
Subject: RE: Git BUG 2.37.3 and 2.38.0
Date:   Mon, 10 Oct 2022 11:40:18 -0400
Organization: Nexbridge Inc.
Message-ID: <037801d8dcbe$9d585b20$d8091160$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGxyxHc9Fz8efWHIvamv9p9NmCcHK5V5lUQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 10, 2022 10:34 AM, orygaw
>I found a bug with GIT with version 2.37.3 and 2.38.0
>
>My system FreeBSD 13.0-RELEASE-p11:
>
>command:
>
>git log -1 --invert-grep
>
>
>* thread #1, name = 'git', stop reason = signal SIGSEGV: invalid address (fault
>address: 0x0)
>  * frame #0: 0x00000000004fe580 git`free_pattern_expr(x=0x0000000000000000)
>at grep.c:755:13
>    frame #1: 0x00000000004fe501 git`free_grep_patterns(opt=0x00007fffffffdc20)
>at grep.c:795:2
>    frame #2: 0x00000000005edd16 git`release_revisions(revs=0x00007fffffffda58)
>at revision.c:3030:2
>    frame #3: 0x00000000003826c8 git`cmd_log_deinit(ret=0,
>rev=0x00007fffffffda58) at log.c:353:2
>    frame #4: 0x00000000003845ae git`cmd_log(argc=3, argv=0x00007fffffffe960,
>prefix=0x0000000000000000) at log.c:883:9
>    frame #5: 0x00000000002f8e8c git`run_builtin(p=0x00000000006a4b58, argc=3,
>argv=0x00007fffffffe960) at git.c:466:11
>    frame #6: 0x00000000002f7783 git`handle_builtin(argc=3,
>argv=0x00007fffffffe960) at git.c:721:3
>    frame #7: 0x00000000002f87c6 git`run_argv(argcp=0x00007fffffffe8a4,
>argv=0x00007fffffffe898) at git.c:788:4
>    frame #8: 0x00000000002f7521 git`cmd_main(argc=3, argv=0x00007fffffffe960)
>at git.c:921:19
>    frame #9: 0x000000000042b53a git`main(argc=4, argv=0x00007fffffffe958) at
>common-main.c:56:11
>    frame #10: 0x00000000002f6dd0 git`_start(ap=<unavailable>,
>cleanup=<unavailable>) at crt1_c.c:75:7

I can confirm a similar situation on Cygwin at 2.38.0.

$ git log -1 --invert-grep
commit 5385d4b84047b3c42cde36f1fab83ac57df17ca8 (HEAD -> topic, origin/topic)
Author: Me <yesme@domain.com>
Date:   Sun Oct 9 22:26:47 2022 -0400

    rms.yaml: add path variable definition
Segmentation fault (core dumped)

My history is extensive.
-Randall

