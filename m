Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB546C433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936D622D01
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 17:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbhAERg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 12:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbhAERg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 12:36:26 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B6C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 09:35:45 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id z16so343242vsp.5
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1IzhQqrT9u7u42FQyQszJISdVDlJebUCR5YfXDop5Q=;
        b=T+KFD0U7NjXoHF43UutLJLQfVoWtSsBdAfJjKnY6EPBkQsKtmM5HnN3mhAVLsjMKUV
         rd2tixKGU5fcq4+9KchEuBy8DQFRI2aiYM+i9BVLNEOuYAx2pxvHoKsqJKB4wuXx6GAU
         gZllV9j0LHUst5Kgs0Rr49rZ4Ey/1JiOIG16Ts8I2ynQq+H6O+SHW4Xv+y6f9Lmi73w9
         2y+r7Jjb72sOxFzPNejZGze0DffD7z4jeruSdU+6/i2AdBGOxoYZaMnefgUlM7HoGtpS
         22TFro+6LR6PrvwDu3mTz4/ZipbgCEp5LHEpLm7jpynEzwlDAIYUx5CTLpMI1e+SzG8N
         uz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1IzhQqrT9u7u42FQyQszJISdVDlJebUCR5YfXDop5Q=;
        b=K6LvZgybxPxhiFPtqEWpet1ayOErUHb/yAlPsXfzbCXVdHtpW8S6eAGfGvFspARCtK
         uOQUUJsZuDxblvY9iybjuw5ULb4oReKzhG6i1Kj3Omf94Ue/rtGd8vKNX9yMTza3UCVx
         1h4DkqHVx4cXkOZuuN9qltBjE0TlUFUlg2bMnhit7dmDrH+84kiJJObrB1BCQ2mQzhFd
         GuQcXXpRJxjvAe4mBdxmydcAymlGqoV7pQX/ZYD6yb00LdafW8qdoI40icCDJmQ160Qt
         VBHvd0qWD6UXZf28REKiAw6vEgyFLtbMoBelWdWHbB4gsDXxf/TvIlNdUDoEN8w0xdS0
         GPbw==
X-Gm-Message-State: AOAM531z3beRJRieTIDyhv1VPpChaAGPwHVAZVMXV7so+meJ3cOaRYnS
        Pa+HHQvHuMdLyrcnbQoqFs11F2sQnZhQWN2E44M=
X-Google-Smtp-Source: ABdhPJzhGpLN6H8ljtThCMJ2lUpCnAPEErnxNIFwHqOFD1lkdXUFZ+ixfqo5t3YB1mCyhP/4orOheXMuogquZdfbNso=
X-Received: by 2002:a05:6102:9c2:: with SMTP id g2mr438047vsi.35.1609868144830;
 Tue, 05 Jan 2021 09:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20201116102158.8365-1-alban.gruin@gmail.com> <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-7-alban.gruin@gmail.com> <44c9189d-9d2f-c437-d0d6-9529708d2c99@gmail.com>
In-Reply-To: <44c9189d-9d2f-c437-d0d6-9529708d2c99@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 5 Jan 2021 18:35:33 +0100
Message-ID: <CAN0heSrOKr--GenbowHP+iwkijbg5pCeJLq+wz6NXCXTsfcvGg@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] merge-index: don't fork if the requested program
 is `git-merge-one-file'
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 5 Jan 2021 at 17:13, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/24/2020 6:53 AM, Alban Gruin wrote:
> > +     if (merge_action == merge_one_file_func) {
>
> nit: This made me think it would be better to check the 'lock'
> itself to see if it was initialized or not. Perhaps
>
>         if (lock.tempfile) {
>
> would be the appropriate way to check this?

> nit: this could be simplified. In total, I recommend:
>
>         if (lock.tempfile) {
>                 if (err)
>                         rollback_lock_file(&lock);
>                 else
>                         return write_locked_index(&the_index, &lock, COMMIT_LOCK);
>         }
>         return err;

FWIW, I also find that way of writing it easier to grok. Although,
rather than peeking at `lock.tempfile`, I suggest using
`is_lock_file_locked(&lock)`.

Martin
