Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68553C05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 11:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBQLAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 06:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBQK7v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 05:59:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560085E586
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 02:59:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee31so4292458edb.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 02:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cs1EgrhzYdZEVCJVb+9NlQRtDMosA2SHo6ocCloafU=;
        b=WXRO7Ahg3bc8J6rD0PuqZlztfKqMzoFY0xN+kTdhWboPXSTBb1TcZ3URwgDTHOXHPL
         TRZp4AquXPOidtgqLmWK988U6ngx+XvGvGcTvIfOAB/6EM7weqwu1X5Jgdvp9zkpJpr8
         Sb3x2NnLVgjA4EwgNm8bVwXYgxLbqW7Cs3Sw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Cs1EgrhzYdZEVCJVb+9NlQRtDMosA2SHo6ocCloafU=;
        b=LJImPHKMS86rSLE1/AnUnygJ/zHdWouhIpGRUY96UVhVQNSUca0YJepylOLyywsdhJ
         UxAqWZDVhD9i/qrH3Or5JGhJs6elSemCP5/yAuZDizrPufUYZg6SGfh1uC0kviOVBuST
         xMTu5Al8E78lmd4eROma2gRfUcbIkx/vFya9rP6KnugeGicv88g+eo1vqbDK2ADVvXc8
         XPyNVPecPhlS4Tn6fFBqUc6tCytr5xmUcaVX2em7j4fMBrb5ePgUhnQnb4JmqbLLdgua
         pTgp3fANoHG9EfzGHJ2k2zzhOJ3iEnCEp3ESpkZAREtBfrTqoO4eSxFP3gC2Etf8i97o
         5q6w==
X-Gm-Message-State: AO0yUKXqSBnBcB6qysp51wSmzK4i64KfyUBWeb1Hh23x18voF426t1AF
        nJAM2hd2wLGVsJ4+M3ofPTNHEKFEoDPAvfGFwRrCeQ==
X-Google-Smtp-Source: AK7set9WErXDDLwLFDpc2GSAiHYRnWOcB8tektONMW0gdwNQuryDz5syjL0beVyQDvJTs4N5VR8Py3losKyJcXLIBPE=
X-Received: by 2002:a17:907:d94:b0:8b1:28c1:6b9c with SMTP id
 go20-20020a1709070d9400b008b128c16b9cmr3884827ejc.4.1676631585848; Fri, 17
 Feb 2023 02:59:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com> <pull.1381.v3.git.1666076086910.gitgitgadget@gmail.com>
In-Reply-To: <pull.1381.v3.git.1666076086910.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 17 Feb 2023 11:59:34 +0100
Message-ID: <CAPMMpoi8mbqSAYMbhgYRj0UTjxHnGy50Z3HKP6fOaDj7AcQ=mA@mail.gmail.com>
Subject: Re: [PATCH v3] RFC: mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2022 at 8:54 AM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tao Klerks <tao@klerks.biz>
>
> When no merge.tool or diff.tool is configured or manually selected, the
> selection of a default tool is sensitive to the DISPLAY variable; in a
> GUI session a gui-specific tool will be proposed if found, and
> otherwise a terminal-based one. This "GUI-optimizing" behavior is
> important because a GUI can make a huge difference to a user's ability
> to understand and correctly complete a non-trivial conflicting merge.
>
> Some time ago the merge.guitool and diff.guitool config options were
> introduced to enable users to configure both a GUI tool, and a non-GUI
> tool (with fallback if no GUI tool configured), in the same environment.
>
> Unfortunately, the --gui argument introduced to support the selection of
> the guitool is still explicit. When using configured tools, there is no
> equivalent of the no-tool-configured "propose a GUI tool if we are in a GUI
> environment" behavior.
>
> As proposed in <xmqqmtb8jsej.fsf@gitster.g>, introduce new configuration
> options, difftool.guiDefault and mergetool.guiDefault, supporting a special
> value "auto" which causes the corresponding tool or guitool to be selected
> depending on the presence of a non-empty DISPLAY value. Also support "true"
> to say "default to the guitool (unless --no-gui is passed on the
> commandline)", and "false" as the previous default behavior when these new
> configuration options are not specified.
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>     RFC: mergetool: new config guiDefault supports auto-toggling gui by
>     DISPLAY
>
>     I'm reasonably comfortable that with this patch we do the right thing,
>     but I'm not sure about yet another remaining implementation detail:
>
>      * After implementing Junio's recommended "fail if defaulting config is
>        consulted and is invalid" flow, there now needs to be a distinction
>        between subshell exit code 1, which was used before and indicates
>        "tool not found or broken; falling back to default" and other
>        (higher) exit codes, which newly mean "something went wrong, stop!".
>        The resulting code looks awkward, I can't tell whether I'm missing a
>        code or even commenting pattern that would make it clearer.
>
>     V3:
>
>      * Simplify C code to use OPT_BOOL with an int rather than a custom
>        option-parsing function with an enum
>      * Fix doc to more extensively use backticks for config keys / values /
>        args
>      * Fix more shell script formatting issues
>      * Change error-handling in mergetool and difftool helpers to exit if
>        defaulting config is invalid
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1381%2FTaoK%2Ftao-mergetool-autogui-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1381/TaoK/tao-mergetool-autogui-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1381


Hi folks, this v3 never got any feedback - the only reason I had left
it as an RFC was that the error-handling looked a bit awkward, as I
noted above.

Should I resubmit this without the RFC prefix?

Are there any concerns about the change here to better support mixed
GUI/console-only environments?

Thanks,
Tao
