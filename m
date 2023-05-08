Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6D6C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjEHTv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjEHTvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:51:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C68F83E6
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:51:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51f597c975fso4649220a12.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683575416; x=1686167416;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9UXYjWjHkOOgZd2PUsAPtaNDi4+TrDs2V1gMAUPrRA=;
        b=EZaKe741N6iqGramfOPAyVoUUV2m3CO2VupVePPCViyVuxU0m7sWgfgoErLEYZ5J0L
         ax1THzECwOrEuMYQpi6ChxODkjF2QnbzUWX0/J53oDa11GquTmi5a5XDJn5U44VwbQe4
         vkZzZyZ2qC8qFxpdHso9vkRf7oh+41JD6SnX/wghkCVAn6jprUNkIUohvWHyqa/qe3fB
         wciff3+XWsxbVDjSqGyUp7I8AbjK5D4rs4dHsPbDoNLdd/9+9uQ/5PHkFhRO2e8rCoaK
         lXC0siW3J+PnV9lgrCkrA6IIBcU4H5SiyRMX+5sS/FZqqWPNKjyit6f8GF3MEyUym4IT
         p9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575416; x=1686167416;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z9UXYjWjHkOOgZd2PUsAPtaNDi4+TrDs2V1gMAUPrRA=;
        b=jMeUD3yNihblhRHB8NtbTJx5GTbQRYVJVE5CJZ0jH+4y3qfJRKoUl0RGZcvkxxSK1F
         JX0jCwPGVA7HifNK6CO1czooOdCX4TG0vvSgPL/MU0DspDyWxhXTQLgca7fmSeJIhiLo
         bA5yViylWaT3Y6p5SFs1BrioUY9Qyrdcc7AQfrerjwRmpjBwhEnWIsfSfrbbNfHbhGlU
         E91nbmjkyKGGH5RozThpcN2iefhjWMelveY5J0OgSejCdGwoh7sTR9yyM3GuWhNlqWT5
         LirBpWLr+vx9Worc5zBDpXD7NTCuoFMr4MROY+c/Z2aC24lEyiA/fRhnXG9SC85VJbAN
         jY+w==
X-Gm-Message-State: AC+VfDwdiZvaBXDIqPn4Thcu4HzLU9KUD+YpJk9gRjzNmjAm0PU06rTj
        S59y7EDHr0MWsu9PaaZ7rB+UY/KwDdo=
X-Google-Smtp-Source: ACHHUZ4sc64P+60HOcgIoF1N//ust6PNRt7rcZqwXYTFZN09Ye+kgRCDH8PeNqrx2ONWFcFoiaNNEA==
X-Received: by 2002:a05:6a21:789c:b0:100:607:b986 with SMTP id bf28-20020a056a21789c00b001000607b986mr7536811pzc.56.1683575416547;
        Mon, 08 May 2023 12:50:16 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090ab29600b0024e49b53c24sm10181611pjr.10.2023.05.08.12.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:50:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 11/11] doc: trailer: add more examples in DESCRIPTION
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <ea483b364b460819c727da5c65497de6ecd4b04f.1683566870.git.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 12:50:16 -0700
In-Reply-To: <ea483b364b460819c727da5c65497de6ecd4b04f.1683566870.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Mon, 08 May 2023 17:27:50
        +0000")
Message-ID: <xmqqmt2emwlj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Be more up-front about what trailers are in practice with examples, to
> give the reader a visual cue while they go on to read the rest of the
> description.
>
> Also add an example for multiline values.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 119dcd64f34..f31b94a6823 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -16,7 +16,18 @@ DESCRIPTION
>  -----------
>  Add or parse 'trailer' lines, that look similar to RFC 822 e-mail
>  headers, at the end of the otherwise free-form part of a commit
> -message.
> +message. For example, in the following commit message
> +
> +------------------------------------------------
> +subject
> +
> +message
> +
> +Signed-off-by: Alice <alice@example.com>
> +Signed-off-by: Bob <bob@example.com>
> +------------------------------------------------
> +
> +the last two lines starting with "Signed-off-by" are trailers.

Excellent.

> @@ -68,7 +79,12 @@ When reading trailers, there can be no whitespace before or inside the
>  between the <token> and the separator. There can be whitespaces before,
>  inside or after the <value>. The <value> may be split over multiple lines
>  with each subsequent line starting with at least one whitespace, like
> -the "folding" in RFC 822.
> +the "folding" in RFC 822. Example:
> +
> +------------------------------------------------
> +token: Lorem ipsum dolor sit amet, consectetur
> +  adipiscing elit.
> +------------------------------------------------

Excellent.

