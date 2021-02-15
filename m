Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE87C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 03:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FA064E52
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 03:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhBOD1K convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 14 Feb 2021 22:27:10 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:39099 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBOD1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 22:27:07 -0500
Received: by mail-ej1-f53.google.com with SMTP id u18so6816690ejf.6
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 19:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2g3cdbiHUldny6WLq+78wuwVOmU2JynIoB61OeA1w3k=;
        b=ehMeojxGb8jCHv1PSWhbp3XEhzfLotrLI7S/V4N50J86xqRCPT09B1vjIV+LSBajLQ
         ytGZsSazTkjF/sN5gal+gur+WPhNCi3J8emgKxg1AaPXDFpnJs8EoQuEuBpgUJ9QZtPj
         SKCTvcZ6oh2T7ZQ/fPA5W5Kgvnfvv4XlOajv4oPNHzOW9XSMsI2H9nAJGBxNSFfJqlhR
         mpCopPZODJCVe0Y+76CtBYELsl7E+rsBXZ4KCoK/jgVLde6HWj1Oi2GFxG5euJleBaOB
         epRwB1d+eGmp16ctArBx6b1J/6o1QqKNcoET3BUQjeBpZCrcmRPGBzOt/+rIeTYGXYdu
         w+3A==
X-Gm-Message-State: AOAM531d9KiVahmLOlLV/ann31y+jtoli9Ajus0snxwtjeRZjxz7TwGT
        fGgMoegTXUspt5zWtlf3hgemMa9cnfihR4iEd+U=
X-Google-Smtp-Source: ABdhPJz2UUpOJ3XuDbixrZyLcqv9zFrXUpIkb5OYa6alcwlXTp49HIWoAo3AhdHE4uOxEd0QPcskERq2qhD+OsDRiRI=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr14021399ejb.138.1613359585724;
 Sun, 14 Feb 2021 19:26:25 -0800 (PST)
MIME-Version: 1.0
References: <87tuqebj6m.fsf@evledraar.gmail.com> <20210215005236.11313-15-avarab@gmail.com>
In-Reply-To: <20210215005236.11313-15-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Feb 2021 22:26:14 -0500
Message-ID: <CAPig+cThGFFzNFxVo-Vdoq2HzonndrvHPjbCUznuBbMGvvLuAQ@mail.gmail.com>
Subject: Re: [PATCH 14/20] gitattributes doc: reword discussion of built-in
 userdiff patterns
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 14, 2021 at 7:56 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Reword the discussion of the built-in userdiff patterns to make it
> more natural to precede it with a discussion about the semantics of
> pattern matching, instead of assuming that it follows right after the
> "diff.tex.xfuncname" example which now immediately precedes it. This
> will make a follow-up commit smaller.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> @@ -794,11 +794,17 @@ backslashes; the pattern above picks a line that begins with a
> -There are a few built-in patterns to make this easier, and `tex`
> -is one of them, so you do not have to write the above in your
> -configuration file (you still need to enable this with the
> -attribute mechanism, via `.gitattributes`).  The following built in
> -patterns are available:
> +There are built-in patterns shipped as part of git itself. A more
> +advanced version of the `tex` pattern discussed above is one of them.
> +
> +For built-in patterns you do not need the "diff.tex.xfuncname"
> +discussed above in your configuration file, but if present it'll
> +override the built-in pattern.

The literal "diff.tex.xfuncname" now feels disconnected from what is
being said, especially as it is preceded by a reference to generic
"built-in patterns". Perhaps it would make sense to generalize it a
bit to `diff.<lang>.xfuncname`. For instance:

    For built-in patterns, you do not need `diff.<lang>.xfuncname`
    in your configuration file as discussed above, but if present,
    it will override a built-in pattern.

> +You still need to enable built-in patterns with the the attribute
> +mechanism, via `.gitattributes`).

s/the the/the/

Although you're simply re-using the existing text, it also now feels
disconnected. Perhaps:

    Nevertheless, you need to enable built-in patterns via
    `.gitattributes` for the pattern to take effect.
