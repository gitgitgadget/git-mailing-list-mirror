Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48515C43219
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 11:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiKXLXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 06:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiKXLXv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 06:23:51 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27962442E8
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 03:23:40 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1432a5f6468so1617290fac.12
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 03:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6XyCjVwn8k3QTtTYnqdTeCcGKtow053KmaZ9vS8rt4U=;
        b=KpF2qkBqhXar9IrHEpaxyiZqOD5J/A3KLpB+29ZrxQUuMS/gqmpVttpiwWbsUw8qnM
         FIZ1soCGAkk9EnfWt9ht2cJbWBfEWUemv1+LSe7BtTODD/+OkDE54BJKTJLydLTlKMfg
         6IOC2T2b+7wHkTMGxOmqICO6jbRJwBaukYMyffZTsShmVvf+/GF5Qsu54pb1fc7d1g7f
         loigMpejFrNz+VVwOnWLNwWvJTad/hEVOLf1JQxA2UsKmadu7pVC7B05Rv5X4iM2XX2y
         qANoUV6BiPutu+KUxyuak//08Gt3daDOAedZAx3scgVrkgdRauqgN/q9vWuhnD4tNGVm
         wSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XyCjVwn8k3QTtTYnqdTeCcGKtow053KmaZ9vS8rt4U=;
        b=G6C4NzLwnrsL1BHPMEx8VIkZfGuzqkVR9N81SBG23lVGMQpQuxIs4vgFo+5QjAEynE
         l8LecTA9tq5vvuyBCndftiUCrApyEPkx8AkkvHcpkhdxeccnY/MiJ3IqA2Ec1+b0qtrq
         83ArEeHfcInpAqXFXIjG1I1D+Ev3LarSXY90R9y5FoeUCC8QAtr8q/+pKqsKs0voRtQ0
         ZAMSt/XhHcATOv0oqTcA+8gwTUaHutb7jmgR8ea3xavtZvOTogZjsY8fFuBBKQyIFAiz
         D/UqdlEqEW5ApVYKGzDSm28rHxN/KUNF0esubBhhCBWZuAheT3fjePdzgc5peN1alWdX
         7W4A==
X-Gm-Message-State: ANoB5pkDWJ6QyqWR28nR1KO0oJ7FkzRbuEjUe+T4ndtLe5KNGNO7LBIA
        JKtCcjtawS7KSSoYkYOUaiIoP6FQ1kIdA35EmRHBkzch
X-Google-Smtp-Source: AA0mqf4dP/Eu/H+ow9sXzZQ8Ta1BeXJCLbI9EyZQGSF9CPmkJfHXcH5paDdUshdGQ0jZfAJyf8dXjXdCFUenG8L4On4=
X-Received: by 2002:a05:6870:61d6:b0:137:288:b05e with SMTP id
 b22-20020a05687061d600b001370288b05emr18030189oah.80.1669289020150; Thu, 24
 Nov 2022 03:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20221123150233.13039-1-worldhello.net@gmail.com>
 <20221124090545.4790-1-worldhello.net@gmail.com> <2219s80r-q7s3-391o-o3or-7q70sn37ooo9@tzk.qr>
 <4oonnq45-s269-sr8n-o5sr-n214593nps8s@tzk.qr>
In-Reply-To: <4oonnq45-s269-sr8n-o5sr-n214593nps8s@tzk.qr>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 24 Nov 2022 19:23:28 +0800
Message-ID: <CANYiYbEbb4sgWtQRSEYJbzcAYTKDRpmVtL62HMR-QekhY_8-bQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix broken CI on newer github-actions runner image
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 6:48 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Thu, 24 Nov 2022, Johannes Schindelin wrote:
>
> > To build even more confidence in the patch series, I will now start a full
> > run (which will take *a lot* of build minutes, unfortunately).
>
> And it passed: https://github.com/dscho/git/actions/runs/3539451056
>
> I also had a look at the range-diff between v1 and v2:
>
> -- snip --
> 1:  ef80c39de1e5 ! 1:  6d4607a4ee46 github-actions: run gcc-8 on ubuntu-20.04 image
>     @@ Commit message
>              ubuntu)
>                  ;;
>
>     +    In this way, we can change the "ubuntu-latest" runner image to any
>     +    version such as "ubuntu-22.04" to test CI behavior in advance.
>     +
>          Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> 2:  1d0903c8b2f9 ! 2:  eba96648368a ci: upgrade version of p4
>     @@ Metadata
>      Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
>       ## Commit message ##
>     -    ci: upgrade version of p4
>     +    ci: upgrade version of p4 to 21.2
>
>          There would be a segmentation fault when running p4 v16.2 on ubuntu
>          22.04 which is the latest version of ubuntu runner image for github
>     -    actions. Upgrade p4 from version 16.2 to 19.2 will fix this issue.
>     +    actions.
>
>     -    Also add some instructions to show errors of command "p4 -V", so we can
>     -    see why the output doesn't match.
>     +    By checking each version from [1], p4d version 21.1 and above can work
>     +    properly on ubuntu 22.04. But version 22.x will break some p4 test
>     +    cases. So p4 version 21.x is exactly the version we can use.
>     +
>     +    In addition to upgrade p4 from version 16.2 to 21.2, also add some
>     +    instructions to show errors of command "p4 -V", so we can see why the
>     +    command output doesn't match.
>     +
>     +    [1]: https://cdist2.perforce.com/perforce/
>
>          Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>     @@ ci/lib.sh: ubuntu)
>         # image.
>         # Keep that in mind when you encounter a broken OS X build!
>      -  export LINUX_P4_VERSION="16.2"
>     -+  export LINUX_P4_VERSION="19.2"
>     ++  export LINUX_P4_VERSION="21.2"
>         export LINUX_GIT_LFS_VERSION="1.5.2"
>
>         P4_PATH="$HOME/custom/p4"
> -:  ------------ > 3:  8e432f13bef8 ci: install python on ubuntu
> -- snap --
>
> The changes look good!

Thank you for providing this range-diff.

--
Jiang Xin
