Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8663B2047F
	for <e@80x24.org>; Tue,  1 Aug 2017 16:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbdHAQLM (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 12:11:12 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:38297 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdHAQIr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 12:08:47 -0400
Received: by mail-ua0-f171.google.com with SMTP id w45so9063158uac.5
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/uXFECaHo3h5bafFAaI26ItSSdVQAdoX9ZRKYPFybUU=;
        b=BvsOAB1Uw+vyj8zgEuKC9N0Fx3JtlKZmCbZFuELQj9XGK1oH1EvuUKcMeOszX2BkwB
         myYizHTQNJwgVS8A2WNkJzaNs0J6zqPcXaW2g/Z7APNmeJjtkz/topHMrcsMiJw1OMfT
         SYhudtJyEvC1RDa/ZI6WTIWWFHGJeuYxrK3hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/uXFECaHo3h5bafFAaI26ItSSdVQAdoX9ZRKYPFybUU=;
        b=cSCjRawChaG6yalO/v8/zKMmPF/5KOj3WzOKevAyCxVyLG+B4G1ijR7YQyVGGIz7eC
         YFSaG8iGcA3IIidhM2U8M6QFCsfy2wxKWlW3+e0ktJ7j/fZdsvtXsUwQQi7ZGpAAT+PP
         L4PcEZHarye5HfgW2FfI4xTVqLR1gxfHylrHqj8t4wZsMuAxG6RESeckPVeWCO/UWldU
         iWuwjaj9iyr10FYznqs+EUTh7h4LipzSUUdqXGyNFk6cGFcBdft9WppqO2pijPx9aAwK
         Z4owfeXgLnNTRBO9Akfpo/j4EXv4dTouIvZgA5DIkB7YOrNjfqIA6ROjBIUfmYtOBPUa
         7dzA==
X-Gm-Message-State: AIVw110LZaHYGWet1d6fPNS2ds6Uzo0K8RBiTRQ/np0nCtfD7wja5JlS
        Hy5Xl1KeodLv3Ociq1KMc2JiMVqBswfY
X-Received: by 10.176.75.167 with SMTP id v39mr14099219uaf.11.1501603726757;
 Tue, 01 Aug 2017 09:08:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 1 Aug 2017 09:08:26 -0700 (PDT)
In-Reply-To: <CAJo=hJurMO=eQP3xctwTX9cO3yTZogJsw5HMztWjB8JHHtJ=fQ@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <xmqqlgn4ieaw.fsf@gitster.mtv.corp.google.com> <CAJo=hJurMO=eQP3xctwTX9cO3yTZogJsw5HMztWjB8JHHtJ=fQ@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 1 Aug 2017 09:08:26 -0700
Message-ID: <CAJo=hJtVat6r6WCghSr3M8PBmEzdjpGt2tgdObvGFKPqQ=myOQ@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 4:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Jul 31, 2017 at 12:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> As a block cannot be longer than 16MB, allocating uint32 to a
>> restart offset may be a bit overkill.  I do not know if it is worth
>> attempting to pack 1/3 more restart entries in a block by using
>> uint24, though.
>
> I don't think its worth the annoyance in code that has to deal with
> this field. An example 87k ref repository with a 4k block size has ~9
> restarts per block and ~19 bytes of padding. Using uint24 saves us 9
> bytes, yet the average ref here costs 27 bytes. We aren't likely to
> fill the block with another ref, or another restart point.

I thought about this more. We can fit an additional ref per block in
some cases. It saves ~20 KiB for one of my example repositories if
restart_offset is a uint24.

Given that readers have to deal with these being unaligned loads
anyway, its not significantly harder to work with uint24 vs. uint32.
So I've changed the definition to be uint24.
