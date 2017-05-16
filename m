Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60A31FAA8
	for <e@80x24.org>; Tue, 16 May 2017 16:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbdEPQm0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 12:42:26 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35518 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbdEPQmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 12:42:25 -0400
Received: by mail-pf0-f180.google.com with SMTP id n23so78201188pfb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DetSH51DrKiBzxzeb1k1Nuzp8m8/AvEB3Pf1v/uBZZc=;
        b=a0+ORY8fLN5tWUDtcwYb4KI+4PMrSqTXfQjAhQWGYqqzRZA2apJxWZ9dKkmy5/QqUF
         qbJTskQMaMxNFa68AwcpBsu/4STsY3EggvJJX1ooWh9bRATE/BWpC9lU2xU5jU22yiPx
         A55ZEPJrYjbBeSJ4K5B8MbOGNY2Viyg6ec7hdA4PM8DkAgqFduZzx1uflhO6tfacgyjD
         9vkpZ+hTvaf0C8Rf7WhHr/78Yc3migLxWPS9Ixi2qKhPnecTxSKdzDSM0r8SLMgcRDOD
         wYst1LAXTxrV9RWSLw5mfRj6AQfuBRUY7oT/6/5Dlx3yDakwuh2J0aGMjAzF/j7bm+MI
         cBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DetSH51DrKiBzxzeb1k1Nuzp8m8/AvEB3Pf1v/uBZZc=;
        b=jjPoSRgqoWSC3kfqgQGoL15k991nQ0vZpR7cHa/DtJ3SLAtWwTnN3SuNr8Tk24oDm9
         ExvfVZXWA3D+xtfIVW9HBAvPM2TjBED+axzH+4IarxiM9Vd0fZ3th1GJ+hUpPo1BbjzS
         ZkndrhpWmgp1UEwlPlrcPVoEgBwJQprlPCI6uqBhrfcv7wVn6rxr47JD5hmjfLF0aB0f
         WgMKpntZWyJBexiqb2aohcuyVl5uo81ABUKPhNJ2OzG2jmmQXfoWcEVSpt1Xr1P6UcRo
         smzE8r6AND1R4U2U2Zjmv/EB9pRlcytvEcTm0arTifOhtjDBXIDxy8XjPBF+oRsOATp5
         oKKA==
X-Gm-Message-State: AODbwcDuurKBVUHG7GlZ76hNn9PJjYq068NOXGW7Xug3Zr7YyqQkd+0a
        njCaVmOBY3J9kAADIcG28FdzDnCbNFdwIa4Bag==
X-Received: by 10.98.205.65 with SMTP id o62mr13176409pfg.105.1494952944127;
 Tue, 16 May 2017 09:42:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 16 May 2017 09:42:23 -0700 (PDT)
In-Reply-To: <CAGf8dgJP+i5RL3FaGSYZyVKkt1ttSnnPd924ebs=4xJb4Fhc6w@mail.gmail.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-19-sbeller@google.com>
 <CAGf8dgJP+i5RL3FaGSYZyVKkt1ttSnnPd924ebs=4xJb4Fhc6w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 16 May 2017 09:42:23 -0700
Message-ID: <CAGZ79kZQBG0AmADWCQ5yj+sRMtwiy8HOnD3SLFS_-yPPoRbfTA@mail.gmail.com>
Subject: Re: [PATCH 18/19] diff: buffer all output if asked to
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 9:14 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Overall, this patch seems larger than it should to me, although there
> might be good reasons for that that I don't know. I'll remark on what
> I find unexpected.
>


>>
>> +static void emit_buffered_patch_line_ws(struct diff_options *o,
>> +                                       struct buffered_patch_line *e,
>> +                                       const char *ws, unsigned ws_rule)
>
> This introduces a new _ws emission function - how is this used and how
> is this different from the non-ws one? I see BPL_EMIT_LINE_WS, but I
> don't see the caller that introduces that constant in this patch.

See emit_line_ws, which makes use of BPL_EMIT_LINE_WS.
The difference between BPL_EMIT_LINE_WS and BPL_EMIT_LINE_AS_IS
is that _WS is emitted marking up whitespace differently (e.g. 8 continuous
spaces instead of a tab or such), see the core.whitespace option.
Relevant hunk:

@@ -557,9 +616,12 @@ static void emit_line_ws(struct diff_options *o,
                         const char *line, int len,
                         const char *ws, unsigned ws_rule)
 {
-       emit_line_0(o, set, reset, sign, "", 0);
-       ws_check_emit(line, len, ws_rule,
-                     o->file, set, reset, ws);
+       struct buffered_patch_line e = {set, reset, line, len, sign,
BPL_EMIT_LINE_WS};
+
+       if (o->use_buffer)
+               append_buffered_patch_line(o, &e);
+       else
+               emit_buffered_patch_line_ws(o, &e, ws, ws_rule);
 }

>> +       switch (e->state) {
>> +               case BPL_EMIT_LINE_ASIS:
>> +                       emit_buffered_patch_line(o, e);
>> +                       break;
>> +               case BPL_EMIT_LINE_WS:
>> +                       emit_buffered_patch_line_ws(o, e, ws, ws_rule);
>> +                       break;
>> +               case BPL_HANDOVER:
>> +                       o->current_filepair++;
>
> If we're just buffering the diff output, do we need to store
> per-file-pair metadata? (I assume that's why you need a special
> handover constant.) Clients can already read what they need from the
> diff output.

Currently we keep only whitespace settings per-file separate as they are
defined per path (via attributes).

So I read this comment as if you consider the per-file buffer unneeded and
we could just detect the next file via the line

    <line-prefix>diff --git a/<file> b/<file>

and then re-read the attributes and remember only the current files settings in
the output pass. I'll look into that.

>> +        *
>> +        * TODO (later in this series):
>> +        * We'll unset this flag in a later patch.
>> +        */
>> +       o->use_buffer = 1;
>
> What I would do is to add a demonstration patch at the end of the
> patch series (which is not supposed to be queued) to avoid such churn
> in history, but I'm not sure how the Git project prefers to do this.

ok, I can omit this part in a reroll.

>> + *
>> + * NEEDSWORK: Instead of storing a copy of the line, add an offset pointer
>> + * into the pre/post image file. This pointer could be a union with the
>> + * line pointer. By storing an offset into the file instead of the literal line,
>> + * we can decrease the memory footprint for the buffered output. At first we
>> + * may want to only have indirection for the content lines, but we could
>> + * also have an enum (based on sign?) that stores prefabricated lines, e.g.
>> + * the similarity score line or hunk/file headers.
>
> This would be nice, but come to think of it, might not be possible.
> When requesting --word-diff, control characters (or others) might
> appear in the output, right?

That is why we'd have even more states. ;)
Or duplicate word diff still, but lines left intact are referenced via offsets.
It's a hard problem to get right, so I defer it via this comment.

>
>> + */
>> +struct buffered_patch_line {
>> +       const char *set;
>> +       const char *reset;
>> +       const char *line;
>> +       int len;
>> +       int sign;
>> +       enum {
>> +               BPL_EMIT_LINE_WS,
>> +               BPL_EMIT_LINE_ASIS,
>> +               BPL_HANDOVER
>> +       } state;
>
> It might be better, for simplicity, just to have one big buffer
> including everything (if we decide that we really can't add pointers
> to input later).

What do you mean here? (Drop the other structs such as the file pair?)

Thanks for the review!
Stefan
