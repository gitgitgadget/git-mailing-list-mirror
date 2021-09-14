Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C7C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 04:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1AEC610A6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 04:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhINEPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 00:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhINEPH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 00:15:07 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE8C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 21:13:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id x10-20020a056830408a00b004f26cead745so16535295ott.10
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 21:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3morfb9mI3Um3Ku67np484+Wc1mfJwQIqWgJ9+VXVY=;
        b=CMcY3Oo1QrZ07nfdGY2ty0hYOeldi6rlzM8N7HocjpEcXGiUuS8HL4gstn1hS23I4F
         x8yAQ2TvZee+uMZZAbQ//vLJpFV4GtAKl8ZT6fyf85n6mDVFNZasixh0xFFDyR784HPa
         zJPPHwGP1FDVDYITUk7gf0u6n3U2GvwM040xE8HW0hVAAA5rUZDu8IGsBI3vVgRi7UxM
         m9nQfqBU7uOMpStPerk8WkxW9HAzDD99FiwUCEh3Kx6RL3nbwpy2tbLV3gHdz0mfoxS1
         nSc5waZS9Qqvw82iP33YBdtMbUye0rlUpUSzc/KCKuYyzy1i7X3UPxsJUkEsjFi8h0Hr
         lDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3morfb9mI3Um3Ku67np484+Wc1mfJwQIqWgJ9+VXVY=;
        b=er6f+VgG/OBZOkUzbuvDW3BppBRuWK1ubvIKQPgejCfnkw47RIKY9YjwBkkqQ/K6cl
         8Gjcy93tcf/c2TDjXuDQHgTbKGxACysN4as5G3WR150rZpwACtZRKyaMo/OgpD4YUNNN
         er1i7hvJUnxj+/xxlAnhtgq9YFwiKl0tZV+yVNiz04EjgqDzcGUnO90JPH1Ry6OfG2bF
         +9ST98Rupt3ea1LZGr612r6SCzCT1nStadW8ZqC55hUQpDy7dkQgJcM+X2wLgQciif3g
         N1B06e5cYVESCVDlG/UoSyeLyFdCN9meBayanJMjHQKot/JpOKdG9vlQd3im3S2CmaHk
         DKBw==
X-Gm-Message-State: AOAM531skGd1rTzaH1ljjwkB8UVMntYd9KSfS5RGnWaAaM0lhF0ctaTi
        k3M3NxbEKUq7Avmvxl8Ai0oTKWTApPEvfA4tnXLAtD/Wp0c=
X-Google-Smtp-Source: ABdhPJwauVnoje75rD9rMPVBLNH07FzKgStZDehYMCtSNuV5QgrrkwQhwdtCCIRHun754xPtqLOeBZeAbjx7+cwLeQ8=
X-Received: by 2002:a9d:609e:: with SMTP id m30mr12712040otj.174.1631592830407;
 Mon, 13 Sep 2021 21:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtuinc3tx.fsf@gitster.g>
In-Reply-To: <xmqqtuinc3tx.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Sep 2021 21:13:38 -0700
Message-ID: <CABPp-BEC9_vuv0vEoPMVuk-p4Wyd8Me246GPT-qPAxgCaMpTQg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #04; Mon, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 7:06 PM Junio C Hamano <gitster@pobox.com> wrote:

> * en/remerge-diff (2021-08-31) 7 commits
>  - doc/diff-options: explain the new --remerge-diff option
>  - show, log: provide a --remerge-diff capability
>  - tmp-objdir: new API for creating and removing primary object dirs
>  - merge-ort: capture and print ll-merge warnings in our preferred fashion
>  - ll-merge: add API for capturing warnings in a strbuf instead of stderr
>  - merge-ort: add ability to record conflict messages in a file
>  - merge-ort: mark a few more conflict messages as omittable
>
>  A new presentation for two-parent merge "--remerge-diff" can be
>  used to show the difference between mechanical (and possibly
>  conflicted) merge results and the recorded resolution.
>
>  What's the status of this one?

Same as last time[1]: tested in the wild, high level ideas probed by
you and I believe I answered them to your satisfaction, but only the
diff-merges part of the code got reviews.

[1] https://lore.kernel.org/git/CABPp-BGR3dfJE7TZ+jkjDdWyeXYowmJhtoFaQ8_Abn=ZROhB5Q@mail.gmail.com/
