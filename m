Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D811201A7
	for <e@80x24.org>; Mon, 15 May 2017 16:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934849AbdEOQNb (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 12:13:31 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33615 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933278AbdEOQNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 12:13:30 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so65393760pfh.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B8DJOumm9SupffUBlwU8vR4m4Pg10yazDlUguZN5wKA=;
        b=pligxw2vsNR7XzWCTc52jUYHz3ps35fz1F2cin4NLA+TvYKTQF6sUqXUk7yCyH9+/j
         NFmOmTeiEt0pE4u72anZ4OFLyPlW8nbSoT3KjDdiIWJWfGRQ8qacLWP6aFqibVnj/OrE
         +EYN1XNO4iNlk9O0D6GRmQd16c7WGDqeYNDHvUeB8IKWcjdmcLvcAjR9C7tmfYhmpzCB
         tOtTobwhTx3m/joEEDe296zY+DNln/B1/RAc9Pk51LINNf8hBPLJZnRdufGbuk9V4rwW
         Jm6tPbJ+gJPQubzWPNaeyjaf24Cw9CiOyJMbW//ixN0MCBFYmezc3fZlRSFYP58LwA9q
         s/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B8DJOumm9SupffUBlwU8vR4m4Pg10yazDlUguZN5wKA=;
        b=TQqkfyVp8cu84+NFjLxeN5m3+Pet3PPLF49xap+vnpjZtDbdN6v77zQJgMjrlvVxoY
         ah27cWUoy2A5k4V4WoO1CIw6x7xxXal5huoDSCrZqxIttHr/bQshVMw5M36RTu9jwoju
         pPmaMVqW23nGRdQzcS5Caovio/au/a7Kj1PqDL0chwbvp4GYSokdUaVSNBvbadTaeTnF
         HLvEQAzbZLnMAa667ZCERpXbZDm0oaJ7B25fMCJOdnUTrKBnw/p5cWvoLFDpMbkuIliW
         g3S/xy/zGr3QwI8RQPPmm5YPHqgXC306wGjzKMxZxv+y4pLzB2sR/1aexKzJD5XS/riF
         nyAQ==
X-Gm-Message-State: AODbwcBJrllN1frswtVxjOG8oDRSgtO5rzo2+0oE7deHweB91Ypq8Vwz
        7yelWeBtC0Bi7T+zz9/uKC947bB2v2Ad
X-Received: by 10.99.56.66 with SMTP id h2mr7261334pgn.40.1494864809848; Mon,
 15 May 2017 09:13:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 15 May 2017 09:13:29 -0700 (PDT)
In-Reply-To: <xmqqk25ivcnb.fsf@gitster.mtv.corp.google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-3-sbeller@google.com>
 <xmqqk25ivcnb.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 15 May 2017 09:13:29 -0700
Message-ID: <CAGZ79kYLNojFHE7mhgmy84-tRbNN66Kt=DFQoMAKz_p4=_m8fA@mail.gmail.com>
Subject: Re: [PATCH 02/19] diff: move line ending check into emit_hunk_header
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 14, 2017 at 11:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In a later patch, I want to propose an option to detect&color
>> moved lines in a diff, which cannot be done in a one-pass over
>> the diff. Instead we need to go over the whole diff twice,
>> because we cannot detect the first line of the two corresponding
>> lines (+ and -) that got moved.
>>
>> So to prepare the diff machinery for two pass algorithms
>> (i.e. buffer it all up and then operate on the result),
>> move all emissions to places, such that the only emitting
>> function is emit_line_0.
>>
>> This patch moves code that is conceptually part of
>> emit_hunk_header, but was using output in fn_out_consume,
>> back to emit_hunk_header.
>
> Makes sort-of sense.  If I were selling this patch, I'd remove the
> first two paragraph and stress on how completing the line inside
> emit_hunk_header() is conceptually cleaner than doing it outside.
>
>         emit_hunk_header() function is responsible for assembling a
>         hunk header and calling emit_line() to send the hunk header
>         to the output file.  Its only caller fn_out_consume() needs
>         to prepare for a case where the function emits an incomplete
>         line and add the terminating LF.
>
>         Instead make sure emit_hunk_header() to always send a
>         completed line to emit_line().
>
> or something like that.
>
> Note that I am not saying "buffering the entire diff in-core?  why
> should we support such a use case?".  I am saying that this change
> is a clean-up that is justifiable, without having to answer such a
> question.

Right, the first couple patches are more cleanup than preparation.
I considered sending them on their own, but then decided to rather
include it in this series.

I'll reword the commit message for a resend.

Thanks,
Stefan
