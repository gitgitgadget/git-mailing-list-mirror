Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9D32095D
	for <e@80x24.org>; Tue, 21 Mar 2017 10:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbdCUKRj (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 06:17:39 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:35696 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932311AbdCUKRi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 06:17:38 -0400
Received: by mail-ot0-f169.google.com with SMTP id x37so148991121ota.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=Pbj8YXrhWPG/J2mAbVi8wEuCxRK4/dcLzXNNKlOvu74=;
        b=VgqZyb8/Iqi+k44XsA+iaWm1a2c5G2jshGsDE78UhKdoFx1GSbPxguB3B+N0SmSkj2
         TzpZ12uduauGCl0uBjseeGTjqi47F54rm2nLVxKGc+0lX1dTcsN6W0v5c3MU/4xqQLI/
         URu19J9XNaGtnm9PJFXIjKCNziIRWVAJWA30TRywzjvSTIYy/CbbVc+9TysnNTOrlaua
         AlxxvnbZCOdHH+oQ5k8x6OS7ma0FbUrDHi6vSeX1H3mdFcvWkrleMKlnXHnArbL3gr/2
         jq2i6YGN4k4EvAXrfK8TvRUiJlP4CYx3QfHZgufziStxxRjrmC97QYL1dQQNPny9HoWH
         06og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=Pbj8YXrhWPG/J2mAbVi8wEuCxRK4/dcLzXNNKlOvu74=;
        b=c9V1W1lvw3g7mXwW/qmZQiTmy4hzLT1Hw2MHLR5bfqmRxuF5D28MIO/d1tzpeActV1
         RugwuT0Mwu2skkG4w3PYf+XXUWBOFa/160It1pFEPpf1lAabFpekDGLv3nFRl1xtoqjY
         ZkCHwZOv1yQLfg+aH8T6pRkadQgsxbTnYUKcwdNB0mDF5vT9REocxwcFL4xoWUgvIVOm
         OJHY385DG6HhpFwuOlR1pFKJIIJHg7zi3weNnOpHcygxHvhE/Y64vKahPerPNSD5JFtY
         CaI9DegsVdmoN91f7kFiQFzd+9bjuKItFd6lSDvL0elxO8eq+AQTXU4POUFGHscQnfG5
         43Zg==
X-Gm-Message-State: AFeK/H3gMymQKfQtYbps1mA9zZgchnaKVTt+bisncudKorHimPcYvR2oEpDom8ekink75A+wR9oHomxeTngJmg==
X-Received: by 10.157.36.202 with SMTP id z68mr10440070ota.271.1490091456301;
 Tue, 21 Mar 2017 03:17:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 21 Mar 2017 03:17:05 -0700 (PDT)
In-Reply-To: <20170320223250.vyzqyqejxrr4dfp4@genre.crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
 <20170318211954.564030-11-sandals@crustytoothpaste.net> <CACsJy8ACRgcE0SV2qa4bU+QdT7=WMcBRkV=cr4SR-bcXxTMj9Q@mail.gmail.com>
 <20170320223250.vyzqyqejxrr4dfp4@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Mar 2017 17:17:05 +0700
Message-ID: <CACsJy8D_9s7e4MuMVuWr2GJ4Y5FF_5bWSUCOxEc50NkrqdB77A@mail.gmail.com>
Subject: Re: [PATCH 10/20] sha1_name: convert struct disambiguate_state to object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 5:32 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Mar 20, 2017 at 08:07:09PM +0700, Duy Nguyen wrote:
>> On Sun, Mar 19, 2017 at 4:19 AM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > @@ -332,7 +332,7 @@ static int init_object_disambiguation(const char *name, int len,
>> >                 ds->hex_pfx[i] = c;
>> >                 if (!(i & 1))
>> >                         val <<= 4;
>> > -               ds->bin_pfx[i >> 1] |= val;
>> > +               ds->bin_pfx.hash[i >> 1] |= val;
>>
>> The indexing makes me a bit nervous, especially since diff context
>> here is too narrow to see. It would be nice if this code (at the
>> beginning of init_object_disambiguation) is converted here too
>>
>>         if (len < MINIMUM_ABBREV || len > GIT_SHA1_HEXSZ)
>>                 return -1;
>
> Well, I think that's the way I would have written that text at the top
> of the function.  I expect that we'll end up turning GIT_SHA1_HEXSZ into
> a global named something like current_hash_len via global
> search-and-replace, so it will always be the right length.
>
> The indexing should be safe because len is guaranteed to be sufficiently
> small, and I feel like it we would have seen it break by now if it had
> had an overflow.  i will always be in the range [0, 40) (for SHA-1), so
> i >> 1 should always be in [0, 20).
>
> Am I understanding you correctly and if so, does that assuage your
> concerns, or did you mean something else?

There's a disconnect between object_id (which goes with GIT_MAX_RAWSZ)
and the code here which still checks upper bound as GIT_SHA1_HEXSZ.
But I guess eventually GIT_SHA1_HEXSZ will be undefined and gone. This
is just a temporary state. So forget about my paranoid comment. All
good.
-- 
Duy
