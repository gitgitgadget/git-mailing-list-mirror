Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363C32022A
	for <e@80x24.org>; Sat, 29 Oct 2016 22:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755258AbcJ2WGe (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 18:06:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36235 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbcJ2WGd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 18:06:33 -0400
Received: by mail-lf0-f66.google.com with SMTP id b75so5521763lfg.3
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jFdGh6cxMp4jaoqTB44AbxOArN4cRSsiUAyIqBngW+o=;
        b=n6NnWlC/VzJI24aAeH/nZAeLGJbtg6egkkFfywhTT6o+9DuVbBKa2xjp2wUd411NaC
         DC8i5xDpevIn0TH9F/ZKJXjJNNjB407DGX1V/wOSwGqFlTtgoxpu3JkfwXZYLwubU1RX
         pGO5Rhw/nuoOqARLlk9vMLP82s/vGujkD2gL9UAA9Idvy8N/bC1I2R/Qbm+/doTp5ELg
         ApxPy/Je53X69M39DhClXQjn8wWsa6SJxdhhEYDScKblprb9sjfFvAbspM+V0pywPFQH
         o+bEg4eSE0hMUq8mfYqC9FajAGf8CtFptbqlwlPWN9PDTrWTbTWGs+jm+0OGDd8SxYpf
         nVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jFdGh6cxMp4jaoqTB44AbxOArN4cRSsiUAyIqBngW+o=;
        b=VSgph0ObfPiNHoQ/V9Vi0a/OQOQb5kB2heHSwuTv3IuI7+Dr9PCdQD8iXjDgB4gc6Y
         5g1IdXvKhG4w3X0xza2FUixO2Xu47iIlJQnGYvfqllABaRzkAiNJPTjuO6zKl1UxKooM
         KafYCT3AvnV9KhRHo7K/NK3ona/JC6V2dH69VQ396fjpwQbIXoabzAjxMaC7QAf1cNjw
         9FbT5+7zNRZh02w2trMSbjkrUfRRTSdnFzZfsJPRTgGr4kvjZjW3MGJWSirOxyCD9rLp
         MaP96EVTHDFfsNkxYijZdMPkIMdTuBY5p6afvCS9oSnWr+Z0a0YnVthqR19E3nM4CJv1
         EBiQ==
X-Gm-Message-State: ABUngvexEjMEaTCJwg2DYldeFGBYlcNWZYl938c+nQ/ArrOhuvpNfLR91ekb2h0r/puJshOeJ4kmgPG/tWxJxw==
X-Received: by 10.25.169.146 with SMTP id s140mr11694873lfe.24.1477778791320;
 Sat, 29 Oct 2016 15:06:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 29 Oct 2016 15:06:30 -0700 (PDT)
In-Reply-To: <CACsJy8DPt3EJoSTVEZFbH6xXbh78MbLZ4h+50K4eoFxPYSaN=Q@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-4-chriscool@tuxfamily.org> <CACsJy8DPt3EJoSTVEZFbH6xXbh78MbLZ4h+50K4eoFxPYSaN=Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Oct 2016 00:06:30 +0200
Message-ID: <CAP8UFD3hNEU_UeVizU6SVJTt4hqJPag9XWqZOM3FKCGJZXOthg@mail.gmail.com>
Subject: Re: [PATCH v1 03/19] split-index: add {add,remove}_split_index() functions
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

On Tue, Oct 25, 2016 at 11:58 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> +void remove_split_index(struct index_state *istate)
>> +{
>> +       if (istate->split_index) {
>> +               /*
>> +                * can't discard_split_index(&the_index); because that
>> +                * will destroy split_index->base->cache[], which may
>> +                * be shared with the_index.cache[]. So yeah we're
>> +                * leaking a bit here.
>
> In the context of update-index, this is a one-time thing and leaking
> is tolerable. But because it becomes a library function now, this leak
> can become more serious, I think.
>
> The only other (indirect) caller is read_index_from() so probably not
> bad most of the time (we read at the beginning of a command only).
> sequencer.c may discard and re-read the index many times though,
> leaking could be visible there.

So is it enough to check if split_index->base->cache[] is shared with
the_index.cache[] and then decide if discard_split_index(&the_index)
should be called?

Thanks,
Christian.
