Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA14EC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A78A46522E
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCIS3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 13:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCIS3B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 13:29:01 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C12C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 10:29:01 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id f8so8740346otp.8
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 10:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x2hOcevlt0DibqQvjhu9oq+Ex9ihX8prspRGiddJCSw=;
        b=A8r7H1pxEaD0ps9RSth/PhW6wdtfv+LuVxETUULqu32l1hB3CPOo/hE3dr1miGywnN
         D5pXNwpdzV6nSJvM+epdG9DUw8QZCogovypPciqlAxtmlLCSoW10n7JJw0L7BEDFKmuR
         A2ehvA+SoUcn8H/wF9jlSv6h9r0WnzKOByHlz0piESXSdmO9L9/AUDpcVbT4+K/GfuZ3
         aJuktHt/ntlCdo7Rt7WMCGbcKTs9hLKgeO6l5qhwjUoL7pOk/JLYOz240F28U0OnrqJM
         m/VUKpTZl6Cqo8ew+y27uwLPV8Y4FQL2zBhzBhac0sEdoZDNl5IquSG+eGcydLCxkOpt
         sUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x2hOcevlt0DibqQvjhu9oq+Ex9ihX8prspRGiddJCSw=;
        b=gSedYv22y64yQFvRa5kNd0Y17020gHTwtg5EmXip8qYNIpY3GedT8j0JmgWVG5DhjJ
         OuSeChHVRgaleP84H7IFL+J+mHuzgU9Za+nc8+yVUynGjQBN2o2Wop1Ad9LP4/hBpPZa
         dUCwGpm7oKUam37Pbxk5zNL0gFRVTirUjsinJUpMX7gegG+ZDu47yt3XGwBG0t2yC+zj
         qDg5oDQkG04JWUdsOmLEN9TTsY9itZKN3oogTr8PISSZDKjF2vroRJW0djpdKEvR5I6C
         ilSPvT0On8lmpb+zY+JNSGRSz5+Iv2fRNnGBZizTa94Wi3xp/oy5FnAjheFqCEqUfImb
         6UMw==
X-Gm-Message-State: AOAM533mCPV9e487Ebj77pA2Sh/BOOP7wYCoAtM5sXYCOYdc1Zuf/nMy
        MkNSwA76zMP/jKwH/B9WCrx54loUcwyIRVrz28U=
X-Google-Smtp-Source: ABdhPJzZ8ejg2bNtFzZnGtRN0SGpVEDLYPbTWmbYOEsB/VsXdsCtZhiTTiP75w9F3IuxuxgAnzVbVBNvAZIFVExFbIg=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr24913801otf.345.1615314540493;
 Tue, 09 Mar 2021 10:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-25-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-25-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 10:28:49 -0800
Message-ID: <CABPp-BFBK=iT8uupa15XMJ6kfTfPFUgyJ59byRcd8e1Eb7cA1g@mail.gmail.com>
Subject: Re: [PATCH 24/30] tree-walk.h API: document and format tree_entry_extract()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Document and format the argument list of the tree_entry_extract()
> function in preparation for adding a sister function.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  tree-walk.h | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/tree-walk.h b/tree-walk.h
> index 1bfa839b275..61fdcb166d2 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -40,11 +40,17 @@ struct tree_desc {
>
>  /**
>   * Decode the entry currently being visited (the one pointed to by
> - * `tree_desc's` `entry` member) and return the sha1 of the entry. The
> - * `pathp` and `modep` arguments are set to the entry's pathname and mod=
e
> - * respectively.
> + * `tree_desc's` `entry` member) and return the OID of the entry.
> +
> + * There are variants of this function depending on what fields in the
> + * "struct name_entry" you'd like. You always need to pointer to an

s/need to pointer/need a pointer/

> + * appropriate variable to fill in (NULL won't do!):
> + *
> + * tree_entry_extract_mode(): const char *path, unsigned int mode

Indenting this over slightly might make it easier to read

>   */
> -static inline const struct object_id *tree_entry_extract(struct tree_des=
c *desc, const char **pathp, unsigned short *modep)
> +static inline const struct object_id *tree_entry_extract(struct tree_des=
c *desc,
> +                                                        const char **pat=
hp,
> +                                                        unsigned short *=
modep)
>  {
>         *pathp =3D desc->entry.path;
>         *modep =3D desc->entry.mode;
> --
> 2.31.0.rc0.126.g04f22c5b82
>
