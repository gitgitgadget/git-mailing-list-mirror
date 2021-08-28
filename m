Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3607BC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 05:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0804060C3F
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 05:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhH1F0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 01:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhH1F0t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 01:26:49 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A2DC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 22:25:59 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id e9so6274878vst.6
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 22:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=li63xj5eCJtjUymITrZc3/ra30b44gDECn2TBGVFNl4=;
        b=b9zCw82QUt4mCzDvpJpkeqa9knV3twcBR6Fv7tNzUhTO82hjruqloHiZsPhdKSYq6Z
         aWXWZkZtJD70WCcWmSFNkqHHVcbZAKh2In0f+yFij8jKL0o8tv2/8m/FUUOzP2fWPcYJ
         SlQCrQ+MRgwEfK7Y75SbxHJ32FqG6x21GlB90u3r3e/TOmkfJCrWajKHZhWcguextOO1
         yPxzGKU90TI1XcYU6zfulkOvPEni06+boLM58IbCL7ZmJtuB2q7NEvVgBZOFMsbjBXOD
         Cr9qUFcM1/yFCyRj6Ua88yTn9Jt0iva6P3ckepeq8IEkbPQ/3AJE6Czs85E8QbJilOqe
         XtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=li63xj5eCJtjUymITrZc3/ra30b44gDECn2TBGVFNl4=;
        b=IphWhZMRpYRZh32FRvxk9Q5x0I+CcFnnvmGU+moj6+ZY0sHq8e4w7+r0BZBnt73QWs
         yR05k/n/ELUQM2o4WEYBnN5B347pEvxALjLajBQh9d8q/puMiAWlVj+3wT51cydyozNs
         Qk3IQDuQUFaOr1W8y79wlLRj123BD+XI0p9k1AFqzHu5r1g5CTDhHrUhRafacwqmDqsi
         PX1tX29JMPRPguImeWPBzZSNVks61J/OzdYCogXcSVF+93XKLAee0At1q+I4EviqJ/j9
         9+cTIfZMWhm0WUWVdgmSvh/lkEODbkTfWp2Tmk3DGOaS4nRndDrdqKS/eadlxq2HuWNJ
         z+VQ==
X-Gm-Message-State: AOAM532uI6anw5yG3fe7wBG4/07QJNe60SmAr+BJ7HYnLjmciP/cdxqb
        FjwHIwatDvDIkgYH2P/XMfwLAAw1sC2uudOxqbLle+8Mc0Y=
X-Google-Smtp-Source: ABdhPJzl/YxKUiiyEXxIrpyDQar+FT3B+zdIascLd88UONBc4K3VF2k/pQ9lxuPjawwzIv+mhPhEcnCGE0XmcbsX8G8=
X-Received: by 2002:a67:cb0d:: with SMTP id b13mr10159345vsl.5.1630128358243;
 Fri, 27 Aug 2021 22:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmtpbub07.fsf@gitster.g> <20210828030839.2989-3-tbperrotta@gmail.com>
In-Reply-To: <20210828030839.2989-3-tbperrotta@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 27 Aug 2021 22:25:47 -0700
Message-ID: <CAPUEsphYPqaZueCcZ-SJx9HabuesSyx8MJOhkEjAJjWGGrzxEw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] send-email: move bash completions to core script
To:     Thiago Perrotta <tbperrotta@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 8:10 PM Thiago Perrotta <tbperrotta@gmail.com> wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 4bdd27ddc8..1b73a4dcc0 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2359,16 +2359,7 @@ _git_send_email ()
>                 return
>                 ;;
>         --*)
> -               __gitcomp_builtin send-email "--annotate --bcc --cc --cc-cmd --chain-reply-to
> -                       --compose --confirm= --dry-run --envelope-sender
> -                       --from --identity
> -                       --in-reply-to --no-chain-reply-to --no-signed-off-by-cc
> -                       --no-suppress-from --no-thread --quiet --reply-to
> -                       --signed-off-by-cc --smtp-pass --smtp-server
> -                       --smtp-server-port --smtp-encryption= --smtp-user
> -                       --subject --suppress-cc= --suppress-from --thread --to
> -                       --validate --no-validate
> -                       $__git_format_patch_extra_options"
> +               __gitcomp_builtin send-email "$__git_format_patch_extra_options"

13374987dd (completion: use __gitcomp_builtin for format-patch,
2018-11-03) mentions
that keeping these in the shell script help with caching and that
moving them to perl would
be better done so that the list can be maintained programmatically
instead of manually.

FWIW it is missing several options (ex: batch-size, {cc,to}-cover,
{8bit,compose}-encoding)

Carlo
