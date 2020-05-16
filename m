Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E029AC433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F5020727
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrUovbJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEPLMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbgEPLMi (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:12:38 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06034C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:12:37 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a5so2798357vsm.7
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcqQQil1oqVRaTieTzhvrYA6G5pWBn47IJt2OsbekLY=;
        b=nrUovbJKgbNMTRSimDzvr0/B2uKTmWw1d1q1813BzmW26HwjVk+NPYC3ak6txb9ueP
         KLRXwTmTaNtL0V4lDzFPWDmGBMTC/HLXgq/gsdMdUvE/K5e+kKsNQLKtrlNoo76+Mj+A
         /yzYQP8XwWajiJsYNCFpxq1PDHlPbtf2ZFKbnzVl1pIml0Zx0kGKGOTs9+6klPw1V8oi
         q7+l8hmhgBiKtiZrqZk475I6UK9kd9uL9OyOx8dmX8xmqVu4TBoCO3oSWqjgOP9+N53c
         zfBwziaka2m5I80aiBviig+MJTeG4NaS8xGN50ZAiWiXfwbfvODSpZbUSlwwUwmmVsvn
         duCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcqQQil1oqVRaTieTzhvrYA6G5pWBn47IJt2OsbekLY=;
        b=Yr9/qe1WFPOJaVZrhphP5xOr4bI+7RKwCMpLo0yoRKaPkVs49ZV5DG8OiPdzKkUBVR
         QpvQXkXt+8625dhiRXgC5GOFbqlekeLPCrIuPSIJt56C8dSmXtwp284Ih3XwkC7qztb+
         e+KCaFzjkBpaObcqOSNQ5lgMLH2ZaNe/GrW74vF4NcIJymfL6Gy/aYqBayP5hP5NeZC4
         acqv4Rg3YA4nqNXFiTJV0ppAKZn0++2gJlvVmu2nc0XG0BGBZr6uQJZAkcxYARG8Ltdp
         qgAepZxzWPdttoWWdB7xXoxcWv3XeApP7jBRZirAX8ZdQcMK8Aiv5dNu30WprmWWfxqk
         w/kQ==
X-Gm-Message-State: AOAM530t7AwaUGGNjchQ/0ZxYkzy8T/H88Qja2Gm+a6bD81VliRE7lR0
        +QLei3UpiGi977jMLYzcwb9nHcFrjEOiM6zEY8Y=
X-Google-Smtp-Source: ABdhPJxTLwgOCuuv8glsRZAH7DU8cLBI5iouCY1bGI1IWP4fwlPhB+HA1qyU5V5VLT8EX9pzWdCTaNAPjOX1VmA8jH4=
X-Received: by 2002:a67:fb4c:: with SMTP id e12mr5315205vsr.79.1589627557188;
 Sat, 16 May 2020 04:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-26-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-26-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:12:26 +0200
Message-ID: <CAN0heSoozYnTJpiz3VZGq6XvrpmXenaf-5FiF=uts4Jhfb5c4g@mail.gmail.com>
Subject: Re: [PATCH 25/44] packfile: compute and use the index CRC offset
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Both v2 pack index files and the v3 format specified as part of the
> NewHash work have similar data starting at the CRC table.  Much of the
> existing code wants to read either this table or the offset entries
> following it, and in doing so computes the offset each time.
>
> In order to share as much code between v2 and v3, compute the offset of
> the CRC table and store it when the pack is opened.  Use this value to
> compute offsets to not only the CRC table, but to the offset entries
> beyond it.

> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1555,13 +1555,9 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
>  {
>         const uint32_t *idx1, *idx2;
>         uint32_t i;
> -       const uint32_t hashwords = the_hash_algo->rawsz / sizeof(uint32_t);
>
>         /* The address of the 4-byte offset table */
> -       idx1 = (((const uint32_t *)p->index_data)
> -               + 2 /* 8-byte header */
> -               + 256 /* fan out */
> -               + hashwords * p->num_objects /* object ID table */
> +       idx1 = (((const uint32_t *)((const uint8_t *)p->index_data + p->crc_offset))
>                 + p->num_objects /* CRC32 table */
>                 );

This counts in four-byte words (so `+ 2` skips ahead 8B as the comment
notes). And that's why we need to use "rawsz/4".

Not new in this patch, but that outer pair of parenthesis just makes
this harder to read, IMHO. I keep scanning back and forth wondering,
"where is this whole thing going to get multiplied or something?"

  idx1 = (const uint32_t *)((const uint8_t *)p->index_data + p->crc_offset)
         + p->num_objects /* CRC32 table */;

The double-casting can be avoided with something like this, but I'm not
sure it's really any better:

  idx1 = (const uint32_t *)p->index_data
         + p->crc_offset/sizeof(uint32_t)
         + p->num_objects /* CRC32 table */;

> --- a/packfile.c
> +++ b/packfile.c
> @@ -178,6 +178,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
>                      */
>                     (sizeof(off_t) <= 4))
>                         return error("pack too large for current definition of off_t in %s", path);
> +               p->crc_offset = 8 + 4 * 256 + nr * hashsz;
>         }
>
>         p->index_version = version;

It doesn't fit in the context, but `nr` will be assigned to
`p->num_objects`. And now we can just use `hashsz` without dividing by
4, so this does the same calculation as the old one above.


Martin
