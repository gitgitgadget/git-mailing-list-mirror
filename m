Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A620C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044C12083B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgD2Wxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:53:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42159 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgD2Wx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 18:53:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id j2so4529346wrs.9
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77jsuNGa8Y1m9MmFJKsutPKKHDgwhVYo/NqhVYAL+rE=;
        b=Pxiwk9oAKZjj0AXNd5Dw7klLCVduNEBzpEH6Nxs5zD6v/KuDnpEUuwX+XrplJoH2aE
         gwJXfqoxWVUcRQDV/+WBTxxtxb/TOmDIpk5i4FesZQQF2VJZdcaNtAzTFfs++b+6xs9x
         SiLsAKTz2CeNfQHLmjXhWymRwXQ7fh2kQWnn07iLmS88HW1iihORQPF6huzHhFhy3lRy
         QXK+9aJhn7piIEuPJHx3fUqrhuX8Kcg+hMvp7P+e3GLZothF8oQ4tLwSZeDu+ls+IcLY
         Ada4ddKjhso2tXZCT4//Erras6QoTIytXJg0/+S5lxX91nhbWffWlmk7XKmlAvrCBm/d
         Ojdw==
X-Gm-Message-State: AGi0PuYSrst9yBTBCMjD4o22dpQs4fO/cCY1PrZqXVcl2WXICgN7cYX6
        fgjKIjF5Ea2VLFsQR/GLcgTtE3vPtG1Ots3opvg=
X-Google-Smtp-Source: APiQypJfOjZEUk3JRkT2pmDmty2hNhj8G27Yj3AL6C88s87JxPWojlsvQoPyOAyoWyfs5eHHwYkKBAQjeAnq9M3XtTg=
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr214201wrs.415.1588200807840;
 Wed, 29 Apr 2020 15:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588199705.git.me@ttaylorr.com> <7828def924a767e54dd43b6c107e8f98c1698f55.1588199705.git.me@ttaylorr.com>
In-Reply-To: <7828def924a767e54dd43b6c107e8f98c1698f55.1588199705.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Apr 2020 18:53:16 -0400
Message-ID: <CAPig+cRd4cfig5N29hkKTS8jnD+Vr96a0Tx5p0=DFZtg9KpXLw@mail.gmail.com>
Subject: Re: [PATCH 4/5] shallow.h: document '{commit,rollback}_shallow_file'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 6:39 PM Taylor Blau <me@ttaylorr.com> wrote:
> When 'commit_shallow_file()' and 'rollback_shallow_file()' were
> introduced, they did not have an documenting comment, when they could
> have benefited from one.

"an" seems wrong; did you mean "a" or "any"? Or, rewrite as: "...they
were not documented...".

> Add a brief note about what these functions do, and make a special note
> that they reset stat-validity checks.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/shallow.h b/shallow.h
> @@ -10,6 +10,10 @@ void set_alternate_shallow_file(struct repository *r, const char *path, int over
>  int register_shallow(struct repository *r, const struct object_id *oid);
>  int unregister_shallow(const struct object_id *oid);
>  int is_repository_shallow(struct repository *r);
> +/*
> + * {commit,rollback}_shallow_file commits or performs a rollback to the
> + * '.git/shallow' file, respectively, and resets stat-validity checks.
> + */
>  int commit_shallow_file(struct repository *r, struct lock_file *lk);
>  void rollback_shallow_file(struct repository *r, struct lock_file *lk);

Or, simpler:

    /* commit .git/shallow and reset stat-validity checks */
    int commit_shallow_file(...);
    /* rollback .git/shallow and reset stat-validity checks */
    void rollback_shallow_file(...);
