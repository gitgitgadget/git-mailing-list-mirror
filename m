Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F6C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 21:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLFVVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 16:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLFVVe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 16:21:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5587D47324
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670361685; bh=5swQm91QFkzfslWcQjQekQkt3pzPI52LwM+vJOtG++4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=pJTlFIH5ev89QHudmZajHRct9slnWwcB+XUXF/bJWZqQShbnIoiOgVO+syqsKSQYE
         BQZIA3isoc8CuPL94WQRKnWXg9bbL6mSJBUN/hNw5zj4ict/yoQLZGgep77jzu3XiB
         JSFMiDCN3HK0azls4T9ZJpsn9dSiFeItuCpxiN9GNXhvDkAxyWKhsPGny9hWTV85fh
         FD49tnW1Tnmot+nRbQou0k5UIUHbr9MFmamr5VxFUXlp3xE/aVuTQyY/LqoMAo1a/B
         IASFnTqrHTasqQ9she21L7DNS89QmPw6QR4Vr/EQmSZODWl++NuMMQC4QOjQq7IYnW
         aVl+mvdpN7MaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.24.155.134] ([89.1.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdebB-1oT3e00NXd-00ZjxD; Tue, 06
 Dec 2022 22:21:25 +0100
Date:   Tue, 6 Dec 2022 22:21:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Oscar Dominguez <dominguez.celada@gmail.com>
Subject: Re: [PATCH] ci: use actions/{upload,download}-artifact@v3
In-Reply-To: <xmqq1qpd9bys.fsf@gitster.g>
Message-ID: <2s9ppo74-r654-231r-7ss7-o08464s2so6p@tzk.qr>
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>        <pull.1354.v2.git.git.1670234474721.gitgitgadget@gmail.com> <xmqq1qpd9bys.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G1rOYHUOQxHQB4lrGyQ1eVq8VnvaM6zTiWeTVngzxVZTD3/9InO
 Ssx2R0fYEu02lv9wxedjCZQuaQHUrP6nRGolj9KqNSBlx90ijVgst/cecv0tEcmEbaK/dTe
 ayoSVYv6g33QdUT2TgUa4Ol8aRNW4ShnI9EAOjF0vyOL8uB2i7xiDRQnSIS6bIfcyMPgIwu
 3WpzAUyctuZdvQbl0lHeA==
UI-OutboundReport: notjunk:1;M01:P0:dIfgfpeWD8A=;L1pD/StjHd5HuxgagkMjgv05IXv
 KEKsSiedk9PDbWS8wNGDK1IVHDz2ejKJXfhDuqx6gB+1Xjopq8uK8+GkpAi83b91TFMPRlV2+
 cfZI+vUpZPYSGomvdlhq9Bd6T/fgOp8MIm5P3QPw4unQ253pFCIb0RBu+pQLhbeRi33xp1+lu
 amYza+yS4w6gscABY9Soq72vxHVsTLI/mdaVkH4zcJORXiMqMggJkNdrHf+SVR2auycDZLrHW
 b22PRA7qsxeJ6ay7ianyJdZFRzw7PPmGnJ0fq7XHUDUwH8+wxxrE5+DCF4g9SOqHcAbxw7iI8
 4hyuA82J6rNG3083y8DJ0SsZ0ydFNc/Zi1neHfKRp1r9CTdKI3vIZbY0Cfuf3iWH4b5aiHTgQ
 Vm6vFt1SirEZiwlBIJcvExHGjvDZIzh6uhb3JhiXX+NEkNvC+7bjxlzm1Y7K4W6Ie+V/E9JZY
 CI5MkXleX+In5XVnrG01T+nltuZAbYHU8QKkwjHjZIWP4JZu+WIXTJTWrvn1sDsyqzYruS6n6
 DDsQ6LONwJ2CxHuVb5SCwelfH4mDALcMHP8eav4Ams8uR8ywGivgcPU4qkBdcDL/J+15u1pkd
 UKmLW/FfWHdqyq5e9a98QZefxTLptSdtYtu/okpt0QU4t5zDRDGxQm21yhGKcK72x7AuO6TmB
 3uILF57xCvkWBNmzeYZURkj5EZfDBAqKiy1JQg4Z0cNrrHiqbL/ntUo4W4fsQkE1ro5T780aS
 pK3dBjhNwgpe3MK9aabb8YXFf9N04hTpkLSbl3cZysppv8BK9hcMDLlmCry7/o6FSlSUYKD73
 gu1Lv5a3wUtRHMe2GTmyibcHEMsxUut2nh+gokquQGECvZ8tY5yvMnNfJy7Hdlr0x0WhE6FMj
 oKJGO+IPz4+gqiB1Ohnb0gv1kbdd/MVjdaxKLJG7+FczjnMlm+w5Qz/6Nqv19N/uERmPhG5i6
 PVtwQfqxmLvWPwGNLrWF7qaFp+4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 6 Dec 2022, Junio C Hamano wrote:

> GitHub CI jobs stopped complaining about use of deprecated actions
> that requires deprecated Node.js 12 for some steps, thanks to a
> recent work by Oscar Dominguez to upgrade actions/checkout from v2
> (which required Node.js 12) to v3 (which runs with recommended
> Node.js 16).
>
> Upgrade actions/upload-artifact and actions/download-artifact from
> v2 to v3, following suit.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * The CI run hasn't finished, but it seems to be doing well
>    https://github.com/git/git/actions/runs/3627513480
>
>    We are also getting complaint about our use of set-output command
>    that is deprecated, which will need to be addressed, too.

See below.

>  .github/workflows/main.yml | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 5262823eb1..7a24c6613e 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -94,7 +94,7 @@ jobs:
>      - name: zip up tracked files
>        run: git archive -o artifacts/tracked.tar.gz HEAD
>      - name: upload tracked files and build artifacts
> -      uses: actions/upload-artifact@v2
> +      uses: actions/upload-artifact@v3
>        with:
>          name: windows-artifacts
>          path: artifacts
> @@ -108,7 +108,7 @@ jobs:
>          nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>      steps:
>      - name: download tracked files and build artifacts
> -      uses: actions/download-artifact@v2
> +      uses: actions/download-artifact@v3
>        with:
>          name: windows-artifacts
>          path: ${{github.workspace}}
> @@ -125,7 +125,7 @@ jobs:
>        run: ci/print-test-failures.sh
>      - name: Upload failed tests' directories
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      uses: actions/upload-artifact@v2
> +      uses: actions/upload-artifact@v3
>        with:
>          name: failed-tests-windows
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
> @@ -177,7 +177,7 @@ jobs:
>      - name: zip up tracked files
>        run: git archive -o artifacts/tracked.tar.gz HEAD
>      - name: upload tracked files and build artifacts
> -      uses: actions/upload-artifact@v2
> +      uses: actions/upload-artifact@v3
>        with:
>          name: vs-artifacts
>          path: artifacts
> @@ -192,7 +192,7 @@ jobs:
>      steps:
>      - uses: git-for-windows/setup-git-for-windows-sdk@v1
>      - name: download tracked files and build artifacts
> -      uses: actions/download-artifact@v2
> +      uses: actions/download-artifact@v3
>        with:
>          name: vs-artifacts
>          path: ${{github.workspace}}
> @@ -210,7 +210,7 @@ jobs:
>        run: ci/print-test-failures.sh
>      - name: Upload failed tests' directories
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      uses: actions/upload-artifact@v2
> +      uses: actions/upload-artifact@v3

This is probably incorrect, but you wouldn't know until something failed
in the `linux32` job.

I already have a correct fix in
https://github.com/git-for-windows/git/pull/4112/commits/b59c1e33fa62029f8=
d5dca801a8afb480514140c
and was only waiting for the patch at the root of this here mail thread to
advance further so I could contribute that fix, along with other
replacements for deprecated operations.

Maybe we can move these changes forward in a more orderly manner, with
Oscar's patch advancing to `next` once it is done, and the other patches
following after that?

Ciao,
Johannes

>        with:
>          name: failed-tests-windows
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
> @@ -267,7 +267,7 @@ jobs:
>        run: ci/print-test-failures.sh
>      - name: Upload failed tests' directories
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      uses: actions/upload-artifact@v2
> +      uses: actions/upload-artifact@v3
>        with:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
> --
> 2.39.0-rc2
>
>
>
