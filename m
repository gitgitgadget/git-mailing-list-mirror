Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B11EC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49FC64DCF
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243452AbhCAU31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 15:29:27 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45]:37126 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243064AbhCAU0W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 15:26:22 -0500
Received: by mail-ej1-f45.google.com with SMTP id bm21so11884413ejb.4
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 12:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0xMxNDRP7hsWiWYi4qNrsmWz6KIVMWJGVpv9KgWy/M=;
        b=hq7wle3yksUxOcoarIQNsFuYWnXfGDx0Jljs+rfcscaUxXMn463pOjTr6MW/gyhhHl
         uJATvz0CdRi2KkNaGciD3LOEfDDERDHJMbFD58RKlVmcTmWl/qytaLphkzRm1a3utDq0
         X9DPM25CYeYLyll86CgbHAU+d9JxaOSwCtz/ZkL0Wihuyk5w2ZRgcczIkcKwEH6KWUmg
         T8w5JhVs9Zg9t9z+onqml+lbX+QaoRzGUj3kuBzrYUuuzDdVegjnbQCsW52gxpL4+YI8
         xIY9s/7PfB9CZmzBTa+hBgOtM3rCJOUDVJajjg9xL1riEH9qtdOCZ5Ylm9rxdqU8ryRh
         qiTA==
X-Gm-Message-State: AOAM530+Jl1lkArmf05VTCwnXdWpXpkYWhl4TkE4BEdcbDSW8v+K9HhF
        QqUFWrpQOp8azJ4g/QszftAXR7CloPwqu9XNnDffWODE
X-Google-Smtp-Source: ABdhPJxjZ8P1bujioOvkpFkmJB2rlVGrY/IQgLW6c5ZM1923jUlT78hwFG3U2tx1J2GKGjezyFF8d7kql0XrGJ6QV0E=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr17933236ejb.138.1614630334203;
 Mon, 01 Mar 2021 12:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-2-charvi077@gmail.com>
In-Reply-To: <20210301084512.27170-2-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 1 Mar 2021 15:25:23 -0500
Message-ID: <CAPig+cSaZ+i+2P0x67BiHLxAGZaggNFK=dHxLJkmOfY8uafS5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] sequencer: export subject_length()
To:     20210217072904.16257-1-charvi077@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 3:50 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> This function can be used in other parts of git. Let's move the
> function to commit.c.
>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/commit.h b/commit.h
> @@ -165,6 +165,9 @@ const void *detach_commit_buffer(struct commit *, unsigned long *sizep);
> +/* Return length of the commit subject from commit log message. */
> +size_t subject_length(const char *body);

Now that this function is public, is the name too generic? Most other
functions in this header have "commit" in the name. So,
commit_subject_length() might be one possibility (assuming the current
name is too generic).
