Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D72C25B06
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 04:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiHOENK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 00:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiHOENH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 00:13:07 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72B913E3D
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 21:13:03 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id k12so10563992ybk.6
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 21:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KijTMB2Aq7iJcftEvRnRNmnJ/mYC6dIq2visqxQCxnA=;
        b=z2nycvhYmifOOHKEhmKjEvkWodm7tnS/m8YD3q9nZ7Tc7uj0C81DIuA8iHca8lQ+Uc
         OG1ntm6sYj0wnLU9iFbExsyUPpeB3dyq51SovRzKlKnDH0KwttnJeVcZ7X1RwCc5aZJd
         9qo3LkA5GqE/4saijX9MnuFdD26PsJHkqdArdocgxIXUfgd4zptNcgjSnEo0iI7TzJrX
         gGGPYqxQKICTg4tr6WCPgfP67QHoeozCTLp4piPuolWiHiKd88+i8l0OUUtS6i1gA5ub
         cNIOF7l2oBaGtW/e613BDCuBm169r1jS47+1PwA7melwkJjIaHIVC0EbaYF054EjSKr4
         9xpg==
X-Gm-Message-State: ACgBeo2tlI+Jjx8NJjeVx74QFpEdRzpEJAAJu4lSHbvm+alGcvj/XtGG
        qb6qr+gP/GDEBaPvtdSR3Wziiih4vc0WbC+v0lLPP8od7MI=
X-Google-Smtp-Source: AA6agR47NU70JIj/ZngeChi5/t7l8L1wBso4kMhbkvSUeyJ8pTXeaj4YK4qeySiIevWmaxzE/PccoYYe44JzsyGSTa0=
X-Received: by 2002:a05:6902:124b:b0:67b:5d4e:c98d with SMTP id
 t11-20020a056902124b00b0067b5d4ec98dmr11506164ybu.475.1660536782781; Sun, 14
 Aug 2022 21:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
 <pull.1301.v2.git.git.1660524865.gitgitgadget@gmail.com> <e737997eb31088a0ebe58c1db0e393a45170eabb.1660524865.git.gitgitgadget@gmail.com>
In-Reply-To: <e737997eb31088a0ebe58c1db0e393a45170eabb.1660524865.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Aug 2022 00:12:51 -0400
Message-ID: <CAPig+cQ4isWWEkfasdENzZWgUZzmBF9vXMTpM2XcxYaPgQbzSQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] doc: add documentation for the hide-refs hook
To:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sun Chao <16657101987@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 14, 2022 at 8:56 PM Sun Chao via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> "git upload-pack" or "git recevie-pack" can use "hide-refs"

s/recevie/receive/

> hook to filter the references during reference discovery phase.
>
> Signed-off-by: Sun Chao <sunchao9@huawei.com>
> ---
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> @@ -249,6 +249,54 @@ If this hook exits with a non-zero status, `git push` will abort without
> +This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
> +during the reference discovery phase, each reference and will be filtered

s/and//

> +by this hook. The hook executes once with no arguments for each
> +'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
> +a version number and server process name ('uploadpack' or 'receive') will
> +send to it in pkt-line format, followed by a flush-pkt. The hook should
> +response with its version number.

s/response/respond/

> +During reference discovery phase, each reference will be filtered by this
> +hook. In the following example, the letter 'G' stands for 'git-receive-pack'
> +or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
> +decides if the reference will be hidden or not, it sends result back in
> +pkt-line format protocol, a response "hide" the references will hide
> +to the client and can not fetch it even in protocol V2.
> +
> +       # Version negotiation
> +       G: PKT-LINE(version=1\0uploadpack)
> +       G: flush-pkt
> +       H: PKT-LINE(version=1)
> +       H: flush-pkt
> +
> +       # Send reference filter request to hook
> +       G: PKT-LINE(ref <refname>:<refnamefull>)
> +       G: flush-pkt
> +
> +       # Receive result from the hook.
> +       # Case 1: this reference is hidden
> +       H: PKT-LINE(hide)
> +       H: flush-pkt
> +
> +       # Case 2: this reference can be advertised
> +       H: flush-pkt
> +
> +To enable the `hide-refs` hook, we should config hiderefs with `force:`
> +option, eg:
> +
> +       git config --add transfer.hiderefs force:refs/prefix1/
> +       git config --add uploadpack.hiderefs force:!refs/prefix2/
> +
> +the `hide-refs` will be called during reference discovery phase and
> +check each matched reference, a 'hide' reponse means the reference will

s/reponse/response/

> +be hidden for its private data and even the `allowTipSHA1InWant` and

s/and even the/even if/

> +`allowReachableSHA1InWant` is set to true.

s/is/are/
