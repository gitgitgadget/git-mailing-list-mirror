Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DE6C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 14:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJJOd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJJOdz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 10:33:55 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF745FDE8
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 07:33:54 -0700 (PDT)
Date:   Mon, 10 Oct 2022 14:33:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1665412430; x=1665671630;
        bh=fEzYj2weo14VDzvk1FU1ECCEK+AzNtfWfAeHZzGJVsM=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=QwOJi2SLmBUkvd7pY/vGF1C/ZIW2x12V0iSEsSVfTashsUgAgkf7hp97yB2XMhRjB
         zBILSrDESmfNpjpTTGke3l5iCPhMumIc6a4AUwSHfcrUEdrjJP8dmbys3dGATHvzhE
         /B7PxW4Pou8EkI+jCEdgZEuVtcWt5eXW15xVaYicoSKeBQiw1bFKXMdk/pLaxMxD0S
         OIiiOnKdsP1npTiOx1asfJ1qMCzgHEf+iggRW6Igkp7TET5D0RqqbHFiJSrkM4GuQl
         kydMbfxY5kiEt6pcL3wvgoaCc0pBPN/eyX1z6bSdaoBppwK7Ta5ah6r09ZrzAbmMjT
         Jew0UJNQApC8w==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   orygaw <orygaw@protonmail.com>
Subject: Git BUG 2.37.3 and 2.38.0
Message-ID: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
Feedback-ID: 57245731:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=20


I found a bug with GIT with version 2.37.3 and 2.38.0

My system FreeBSD 13.0-RELEASE-p11:

command:

git log -1 --invert-grep


* thread #1, name =3D 'git', stop reason =3D signal SIGSEGV: invalid addres=
s (fault address: 0x0)
  * frame #0: 0x00000000004fe580 git`free_pattern_expr(x=3D0x00000000000000=
00) at grep.c:755:13
    frame #1: 0x00000000004fe501 git`free_grep_patterns(opt=3D0x00007ffffff=
fdc20) at grep.c:795:2
    frame #2: 0x00000000005edd16 git`release_revisions(revs=3D0x00007ffffff=
fda58) at revision.c:3030:2
    frame #3: 0x00000000003826c8 git`cmd_log_deinit(ret=3D0, rev=3D0x00007f=
ffffffda58) at log.c:353:2
    frame #4: 0x00000000003845ae git`cmd_log(argc=3D3, argv=3D0x00007ffffff=
fe960, prefix=3D0x0000000000000000) at log.c:883:9
    frame #5: 0x00000000002f8e8c git`run_builtin(p=3D0x00000000006a4b58, ar=
gc=3D3, argv=3D0x00007fffffffe960) at git.c:466:11
    frame #6: 0x00000000002f7783 git`handle_builtin(argc=3D3, argv=3D0x0000=
7fffffffe960) at git.c:721:3
    frame #7: 0x00000000002f87c6 git`run_argv(argcp=3D0x00007fffffffe8a4, a=
rgv=3D0x00007fffffffe898) at git.c:788:4
    frame #8: 0x00000000002f7521 git`cmd_main(argc=3D3, argv=3D0x00007fffff=
ffe960) at git.c:921:19
    frame #9: 0x000000000042b53a git`main(argc=3D4, argv=3D0x00007fffffffe9=
58) at common-main.c:56:11
    frame #10: 0x00000000002f6dd0 git`_start(ap=3D<unavailable>, cleanup=3D=
<unavailable>) at crt1_c.c:75:7

