Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601EEC4332F
	for <git@archiver.kernel.org>; Sat, 10 Dec 2022 00:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLJA3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 19:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLJA3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 19:29:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F97B3FB95
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 16:29:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso9133711pjb.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 16:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEr6mZXiXyUbz+qFxGUXxMP8lfoZKaDBSaNiZbAe9yo=;
        b=Hb2uGrcOeULHsy/tTNye26GHvQc99WH+KTrjwhOhfMlIzg5Rq09IJsmyKLyfwzHZ5z
         NhQy+9F433QehQJ9nAiKm0M/hxjI/cfvW9lcnJDlvmRBgVzkFqRcGO8eiNCZyyS/ZUBs
         mcAa8qOntu1ZGEBFj8GAxC9A9rzc5McdF6pbDd7o66HlLTugfvfZbJcwxtMS01NW7Bq3
         KI5x5vDWjbIbt8JJYa7CMHzeH4KuwcuaapJRxrPT5DScosAgkZavsQ7tsFtTTlzXCxRx
         CNvLzBFndIQgDfku61+DKbaTGAXki/MkVkJ7NcxbBxYX503/7ClXTGBbepbmZBgsr2e8
         427Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DEr6mZXiXyUbz+qFxGUXxMP8lfoZKaDBSaNiZbAe9yo=;
        b=OrPoB/GpUhGHwC/Etph5sJZ20dGmMVqHBm5m3qlEzQi1zXYdwq4qf6DHKVUI/57x8P
         qcXP7ZYOCgPHKZuDVfNk8eMuBU9ushDgT420QopwXieV5FKkq/upSCbYUL9oUM+vO+zh
         kw1Zb8gq3TqCwpknJ6TeuDWfvd7CBIAW+KUpqh8JfDqI/7pD62BL9x+q6ni88X+8BrOl
         /9VdSqCrTy1hW+GA2uFdQzTaLoQ+Y46n0XkQXumYQrrwJJOVEfuHK6/IAl6i7DQd/B09
         Uzq3Vhv/xj8AqoTh+8pCojnjsf1unGxN1hEg4Af/ySrlmuO18TIgfujzKbGNlw5/Q9y0
         udxw==
X-Gm-Message-State: ANoB5pmlJFcj5N5sgzeoimti1sts624F7wxar1PPnIpX+VzCObAXDGH/
        b9XOwdbVKXdCitMQURXyNQQ=
X-Google-Smtp-Source: AA0mqf4AUbSnLbNaWNG+h5fdGBLdMtLi8RYYtTMxrY+wxuvUm5/sbvgEVT5235vXaTznFeap4t05ZQ==
X-Received: by 2002:a17:902:9881:b0:185:441e:4d0e with SMTP id s1-20020a170902988100b00185441e4d0emr7707107plp.62.1670632183553;
        Fri, 09 Dec 2022 16:29:43 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z20-20020a170903409400b00189667acf15sm1850639plc.162.2022.12.09.16.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 16:29:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] docs: link generating patch sections
References: <pull.1392.git.git.1670614892380.gitgitgadget@gmail.com>
Date:   Sat, 10 Dec 2022 09:29:42 +0900
In-Reply-To: <pull.1392.git.git.1670614892380.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Fri, 09 Dec 2022 19:41:32 +0000")
Message-ID: <xmqqk030xfrd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 3674ac48e92..5acffdd129e 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -22,7 +22,13 @@ ifndef::git-format-patch[]
>  -p::
>  -u::
>  --patch::
> -	Generate patch (see section on generating patches).
> +	Generate patch (see section on
> +ifdef::git-log[]
> +<<_generating_patch_text_with_p, generating patches>>).

Is this "prepend underscore, downcase, and replace each run of
non-alnum with an underscore" ASCIIDoc magic?  AsciiDoctor magic?
All such backends prepare the anchor in the same format?

I am mostly worried about relying on automatic magic that can
silently be broken when say the title in diff-generate-patch.txt
file is improved.  Whoever is updating the file would not know
it is being referenced from elsewhere (and it is hard to check).

Or perhaps you forgot a single liner patch to diff-generate-patch.txt
that adds [[_generating_patch_text_with_p]] anchor yourself?

> +endif::git-log[]
> +ifndef::git-log[]
> +Generate patch text with -p).

The capitalization makes it look somewhat odd in the resulting
text.  Quoting, e.g.

	see the section titled "Generate patch text ..."

may make it acceptable, though.

> +endif::git-log[]
>  ifdef::git-diff[]
>  	This is the default.
>  endif::git-diff[]
>
> base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882
