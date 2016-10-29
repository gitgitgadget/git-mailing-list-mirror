Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BCEE2022A
	for <e@80x24.org>; Sat, 29 Oct 2016 22:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbcJ2W6s (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 18:58:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33955 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbcJ2W6r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 18:58:47 -0400
Received: by mail-lf0-f66.google.com with SMTP id i187so4894429lfe.1
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6B/i0lz9k9tVbH81I4qgqHiXaqJlXpfHOemNY6f/eQo=;
        b=Oh1ZtvQ2KTI7sZpqYPatWSLk7sTrwrT6NRVmhVGlOIzw79K9Vj1JEhejgBnIM0ZuFZ
         8ko20kJvWt6Se4NHlfq82Dx5Ub8ylCFJNw5kubh00RR20ItTvlcdW++n+1n7qYShmXge
         0unjba5rdhm6TSycR4jbsZQD0QPCemWXSDXX3XDWjmV6by+rzqoGXgSPCX0fHszOVdRN
         /K5KoI8IhckdlDVw49zcFFMnMstmQRYvoLGCPUMxeULrAYCcdRLAG23clsTc26YPQ0Iw
         rfGjRY7aSQnGYN4y7A9/GpsnoqiQJ9c7lIV1g4vf3Y37dl6eq1I67Ktn6LM3wEIBs2QF
         bnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6B/i0lz9k9tVbH81I4qgqHiXaqJlXpfHOemNY6f/eQo=;
        b=M42Me1Mvfu0Djr2Rqt9nPcl2QIhY4MdV3LnujDgRFw3+gpteZfLOJVvXqUA6yqgQQv
         Ts0XfWrSjKLKsYickcGjQdULRLiC8fxIU3sNa1ahxRZlqoS47q8LhfA4BUWYCCUmpT02
         SnwN3XJhb3zFNC7J+aFw0YwoPcOThDWBZ1RDxJwVv8O5o24exYHlbwmn9w6BEoLZss8Z
         c/q7aL3v5wqsCcGZftEHQp8Li4ssW+vUDy/E02J9qxyNdQsbP/KkfgSSp9smwyDkBplB
         dUfYizWvdvo30JhjvfcD0b7uSY0RFMOW55VOnZ5BUZ1bsHTepnUpytRob0Qkzw+Sgj5K
         e2QA==
X-Gm-Message-State: ABUngvd2Lh0F8JckO5B9gXIFlCtuOgZ3IPSrOLiwGmY5TiA0Vc8ISdqhOntVDEHLmt6vrLye41bDka2GzTmF0A==
X-Received: by 10.25.74.5 with SMTP id x5mr4117410lfa.154.1477781925574; Sat,
 29 Oct 2016 15:58:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 29 Oct 2016 15:58:45 -0700 (PDT)
In-Reply-To: <CACsJy8CfQ6d3Q74W4rm=rJD69EAzuUe7PdrW-5NDo0vHuDSNpw@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-11-chriscool@tuxfamily.org> <CACsJy8CfQ6d3Q74W4rm=rJD69EAzuUe7PdrW-5NDo0vHuDSNpw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Oct 2016 00:58:45 +0200
Message-ID: <CAP8UFD1qTeppaW2NRWhAxz0tJ7EtwmiOjKUnQt8q89FdC8kXWQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/19] read-cache: regenerate shared index if necessary
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 12:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> @@ -2233,7 +2263,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
>>                 if ((v & 15) < 6)
>>                         istate->cache_changed |= SPLIT_INDEX_ORDERED;
>>         }
>> -       if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
>> +       if (istate->cache_changed & SPLIT_INDEX_ORDERED ||
>> +           too_many_not_shared_entries(istate)) {
>
> It's probably safer to keep this piece unchanged and add this
> somewhere before it
>
> if (too_many_not_shared_entries(istate))
>     istate->cache_changed |= SPLIT_INDEX_ORDERED;
>
> We could keep cache_changed consistent until the end this way.

Ok, it will be in the next version.

>>  test_expect_success 'enable split index' '
>> +       git config splitIndex.maxPercentChange 100 &&
>
> An alternative name might be splitThreshold. I don't know, maybe
> maxPercentChange is better.

I think it is important to say that it is a percent in the name, so I
prefer maxPercentChange.

Thanks,
Christian.
