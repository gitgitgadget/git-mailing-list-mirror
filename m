Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7619C4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 10:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDB560ED5
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 10:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhHOK2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 06:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhHOK2y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 06:28:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1721C061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 03:28:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b10so17988942eju.9
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fgizymGkzmM5fx7HD7YxTz0pUfejyFpd2jPIXq5Dz9k=;
        b=e5esY8kLZTEZXUGz6fg3d5BeQu6MlxI0IRmC1bnHj3vLMMHhpARNzmSNn8b7mWr86x
         gFQD5N6njAV5fBuQk/EPzvcMxkWIhKcCLQQii87vkSYY8nBBSU994Sz2FDzy8lCR06LR
         8OMksYUPsie0lQPjliveNvfgltT6U8pHXIV0zjBvxHmyckErrsIAhrrnOjdDDmXpAFfm
         J4E84TBNSIeocc17YmFFRENrswQIsaCF68ZJGxfTce/RuMcP5VpPetAmBRqoRlcPwlCt
         wu3x+AHu66GaHGpqygfC1o5qJkxOOTjPcD9r7SoIgDShs/0Qq+zu/IuM00085AGOlDQI
         JnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fgizymGkzmM5fx7HD7YxTz0pUfejyFpd2jPIXq5Dz9k=;
        b=QwhMaWI+MS8Ik7LMD1t9rst1B48VzN8QQO5VauCDcJ3ynVoSutUeWPFD8wi46Z+hE8
         2a+8Ji3/TCvrvDHH0VEAJ9w8zO6GjJAe2QtA3JoWXFvJM9CIeHqGlPl106+vOaONfJ/K
         VQI0y/wPGlTHP/0n/rVHvm4/pzM2+yzlkvIN0+apk/bx0LKB5H9EmDzjB9etbEIN7+Am
         eVI1yzd4JD4Jtkbto0eXMducCPNItX538HOKDxM6KD4xldAb1LxF3W59O9sOC+UK3x6w
         EDX0++87UY4/j2qiPhG/XNJrCFIeyl8tYfio+nBggcdcAbKJqWf9EmqRVrA7hrcMLp0j
         +ZWA==
X-Gm-Message-State: AOAM533phLLRo29QKl3qaL6NLMNvq7dcBVlYAEQKCqh2obkj7mKQr0pA
        fQCuKBKHFOzryKPujpmR+YcCfKIjWmcjjR4jmF0=
X-Google-Smtp-Source: ABdhPJwl6GF+fZoInzYW1wjKDBxK14AD3n9vPFPH+8QpWj3xdBjPZKU4yNXlHtMdfHVIy+p5NhgltmOms/UWAY7m9yg=
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr10892432ejs.197.1629023303447;
 Sun, 15 Aug 2021 03:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8Q6f-B05bQ+XCDuGGk5KTS1o3QatGbeJ-FQiqFCYGW7Og@mail.gmail.com>
In-Reply-To: <CAOLTT8Q6f-B05bQ+XCDuGGk5KTS1o3QatGbeJ-FQiqFCYGW7Og@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 15 Aug 2021 12:28:12 +0200
Message-ID: <CAP8UFD3FpnmOi50iUuFa9qMzi=PVP_Kcod6T+8BzJNq5X-cmgw@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 13
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 15, 2021 at 9:08 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> My thirteenth week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-13/

Thanks!

> ### Project Progress
>
> This week I continue to try to optimize the performance of `git
> cat-file --batch`.
>
> You can see them here:


> Test                                        upstream/master   this tree
> -------------------------------------------------------------------------=
-----------
> 1006.2: cat-file --batch-check              0.08(0.06+0.01)
> 0.08(0.07+0.01) +0.0%
> 1006.3: cat-file --batch-check with atoms   0.06(0.05+0.00)
> 0.07(0.06+0.01) +16.7%
> 1006.4: cat-file --batch                    0.48(0.45+0.03)
> 0.50(0.46+0.03) +4.2%
> 1006.5: cat-file --batch with atoms         0.47(0.43+0.03)
> 0.49(0.46+0.02) +4.3%


> The performance of `git cat-file --batch-check` is very close
> to `upstream/master`!
>
> The performance difference of `git cat-file --batch` has also
> changed from 25.0% to 4.2%!
>
> This result is far better than my expectations, I have reason to
> believe that the performance of `git cat-file --batch` can be
> improved again!
>
> Good job!

Yeah, great!

> I think the key to continuing to optimize is still to reduce unnecessary =
copies.

Do you have data or hints about this?

Have you looked at why there is still +16.7% in the cat-file
--batch-check with atoms case? Maybe solving this would improve things
in the other cases too.

> ### Additional advice
>
> During the optimization process this week, I found that I might want
> to use a `strbuf_move()` function, although I did not adopt it in my work
> (because it did not allow my work to be greatly optimized), but I think i=
t might
> be useful in some situations: We don=E2=80=99t want to copy the data of s=
trbuf,
> but just want to move its buf pointer:

Yeah, if we are sure that it improves performance, that might be worth it.

About your patch series
(https://lore.kernel.org/git/pull.1016.git.1628842990.gitgitgadget@gmail.co=
m/),
I wonder if it might be possible and better to have some performance
improvements before the commit that uses the ref-filter code
("cat-file: reuse ref-filter logic"). If you are going this way, it
might make sense to add a few performance tests, if some don't already
exist, to show the effect of these performance improvements on the
ref-filter code when it's used by other commands like for-each-ref.

This could show that these performance improvements are worth doing
even if we didn't want to reuse the ref-filter code in cat-file. And
then perhaps these performance improvements could be merged as part of
one or more small patch series, before the patch series that reuses
the ref-filter code in cat-file.

Best,
Christian.
