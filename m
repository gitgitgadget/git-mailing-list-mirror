Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89363C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 00:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiGIA6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 20:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGIA6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 20:58:34 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75751057C
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 17:58:33 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 6so355974ybc.8
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 17:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTiZA1mUjKK5aZ58h4rBZSl7YGuBM1V8ZXvVDbiremc=;
        b=o7ilV0KFrRzoSwhtChneE4/Q8hdW9FaT4w71+dWQ1WCha9VukAi7xHkjDsDvIfDgot
         pfLU30/6S41f6ZeE84bqdFCPwcUGbEbFLJfCGk60o+fXSJ4HfIXqOMZpo+Q4Ank89in/
         I/8V+OdH3wMLRwYoLgkYWVvD+VKybfW8LMnxnHTksce3Ql5ZUv7F0V/EVBKPozZoNZDX
         YxTkmdOinF9h5tBgLzSxROIfAr7RXg4K9fBnj4j6CV9ZSoKAMwGbcPhNhmXe3/buaz/M
         +XaPGlkBfYbDFd6zKeEsxgGvmm5ZnEE4HZDH9kOHUPDL1nUz5RoOFaUFQYDAotKAmecM
         CCEg==
X-Gm-Message-State: AJIora9aJPf5wMNU5ODFXa+pTPQQfKnz8WARra5GSVGl6ZBWNJkcXuPx
        SGnlRNFlLFGRURw7m1QFgcvoBaLETLgOJuFlGXk=
X-Google-Smtp-Source: AGRyM1spfdH+kz0EQxB7hyqF5/HRttC0KxgvMLrTvlcIxngZg/tVhXzxzZxH830AmeekIVaEyYS3mjuzKiKmFtfXazQ=
X-Received: by 2002:a5b:982:0:b0:63e:7d7e:e2f2 with SMTP id
 c2-20020a5b0982000000b0063e7d7ee2f2mr6598118ybq.549.1657328312836; Fri, 08
 Jul 2022 17:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1281.git.1657202265048.gitgitgadget@gmail.com> <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com>
In-Reply-To: <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Jul 2022 20:58:22 -0400
Message-ID: <CAPig+cTX76ZMG_S-qOX_JDxYVWXRvtP2Ref4k8uM1KJaDwX9=w@mail.gmail.com>
Subject: Re: [PATCH v2] gpg-interface: add function for converting trust level
 to string
To:     Jaydeep Das via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 8, 2022 at 7:28 AM Jaydeep Das via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add new helper function `gpg_trust_level_to_str()` which will
> convert a given member of `enum signature_trust_level` to its
> corresponding string(in lowercase). For example, `TRUST_ULTIMATE`

s/g(/g (/

> will yield the string "ultimate".
>
> This will abstract out some code in `pretty.c` relating to gpg
> signature trust levels.
>
> Signed-off-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
> ---
> diff --git a/gpg-interface.h b/gpg-interface.h
> @@ -71,6 +71,14 @@ size_t parse_signed_buffer(const char *buf, size_t size);
> +/*
> + * Returns corresponding string in lowercase for a given member of
> + * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
> + * return "ultimate".
> + */
> +char *gpg_trust_level_to_str(enum signature_trust_level level);

It would be a good idea to update the function documentation to
mention that the caller is responsible for freeing the returned
string.
