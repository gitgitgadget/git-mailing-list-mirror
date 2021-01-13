Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A25CC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2418F23339
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 16:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbhAMQYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 11:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbhAMQYO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 11:24:14 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEDCC061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 08:23:34 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id y15so1455906qtv.5
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HbRjjfwE1nvXNTJo/0Jng552T2rIVkZ76TzZjHMC3uc=;
        b=AYi1ZIBoIL1P++HPobRusUM5aOggrc6r5pt5OhJ92W/P5Dp3iKw3+FhGnsAzhnsozw
         130aMI/6UBwD9JecGAIpvqrk3mpVbUUD1T36SvlEzicfzXpvLHoLRmPS6SlnWHsul7QL
         W0aMIMwMisJCs1KERTNPq1yFnJme8YK29j0ZlR7eDQNxpGDk29xZ61o4OTKs4hnl+14P
         0VythUAITUCksbSy79ZD9GlBJE6GDoBktE/aX4sA2dGg3AfEecveBAJh4vpKlYAiNstm
         B8RWI9+EZCfHQtvzMVnwZFgCgHHGhW98kf1bDtcwEX9bXd/pNSKIKT/J5F1FU36IylQR
         5arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HbRjjfwE1nvXNTJo/0Jng552T2rIVkZ76TzZjHMC3uc=;
        b=sGgeKWScagttqyjSNfQkYwDvzdoqyEgnBG58d2KM2/miQo+dx72AS5aS2QnmvrTKmV
         MFKT/+V4OSiguxo13mzw5kOdPC2V2UXaC07frI77CDZpX8NY7K6w/QZcz9l4MpBh/iZN
         CuqXJ13enUxnu/IEdE+t8/nQs3rXq2OTnrAMQZ1OqEfnka/+mui/LmfKX283nXzDbTJc
         xI32YwOP0OqkXZzBeKX4rrl2pWqgaJND9TnaRazfr9VNNgKe2R2tNmCc2aECWyXsVK+v
         PcVYag5Q/WRcMlBKx5f25USvvsO6J4tZPVY6pTw2Ba6hdPQS0GHBa/bxuyIUK0uhylla
         T2Og==
X-Gm-Message-State: AOAM5336+WBt6gO49QWiRWA32rLg4/4fBHupxkkT8AABt2eWQgKO3tRW
        lDbExMBMiexJ87L3TxA76reWjQ==
X-Google-Smtp-Source: ABdhPJwXQad/TMIokdovp64nFsKi5WH+X1WR/CgzVFPU7Q0AkrBKbanTKaQ3hcK8fRWnvYpCU63TQQ==
X-Received: by 2002:ac8:1009:: with SMTP id z9mr2911418qti.347.1610555013285;
        Wed, 13 Jan 2021 08:23:33 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id k187sm1307773qkc.74.2021.01.13.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:23:32 -0800 (PST)
Date:   Wed, 13 Jan 2021 11:23:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        jrnieder@gmail.com
Subject: Re: [PATCH 01/20] pack-revindex: introduce a new API
Message-ID: <X/8egmj9Tno3pvhC@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <fa6b8309088fd04410ca7276c5cf14db0fb82fb2.1610129796.git.me@ttaylorr.com>
 <xmqqa6tdz2fo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6tdz2fo.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 12:06:03AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > In the next several patches, we will prepare for loading a reverse index
> > either in memory, or from a yet-to-be-introduced on-disk format. To do
>
> Does "load revindex in memory" (as opposed to "from on-disk file")
> mean the good old "read the forward index and make inverse map
> in-core", or something else?

Indeed, that's what it means. I've made that clearer in the patch
message by saying it explicitly.

> IOW, is "We will prepare a reverse index either by computing in
> memory from forward index, or loading from on-disk file" what we
> want to say here?

Yep.

> Without knowing what exactly "pack position", "offset" and "index
> position" refer to, the above three are almost impossible to grok.
> Can we have one paragraph description for each?  Something along the
> lines of...

Yep, and I see later on in the thread that you want to discard this
suggestion since Peff has suggested similar changes in pack-revindex.h,
which I've applied.

> >     Unlike some of the callers that used to access '->offset' and '->nr'
> >     directly, the error checking around this call is somewhat more
> >     robust. This is important since callers can pass an offset which
> >     does not contain an object.
>
> Meaning "offset ought to point at the boundary between objects in
> the pack stream, and the API, unlike the direct access, makes sure
> that is the case"?  That is a good thing.

Indeed, and I've called that out directly in the patch message to
highlight it.

> > diff --git a/pack-revindex.c b/pack-revindex.c
> > index ecdde39cf4..6d86a85208 100644
> > --- a/pack-revindex.c
> > +++ b/pack-revindex.c
> > @@ -203,3 +203,35 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
> >
> >  	return p->revindex + pos;
> >  }
> > +
> > +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
> > +{
> > +	int ret;
> > +
> > +	if (load_pack_revindex(p) < 0)
> > +		return -1;
> > +
> > +	ret = find_revindex_position(p, ofs);
> > +	if (ret < 0)
> > +		return -1;
>
> Why not "return ret"?  We know that find_revindex_position() would
> signal an error by returning -1, but is there a reason why we want
> to prevent it from returning richer errors in the future?

No reason, I've changed it to 'return ret' instead.

> > +	*pos = ret;
>
> The untold assumption is that uint32_t can fit the maximum returned
> value from find_revindex_position() and "signed int" can also big
> enough.  I guess it is OK to be limited to up-to 2 billion objects
> on 32-bit systems.

Indeed, and that is fixed in a later on patch. I'll make sure to call it
out there.

> > +	return 0;
> > +}
> > +
> > +uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
> > +{
> > +	if (!p->revindex)
> > +		BUG("pack_pos_to_index: reverse index not yet loaded");
>
> The previous function lazy loaded the revindex, but this one and the
> next one refuses to work without revindex.  Intended?

Yes, and discussed a little bit more here [1]. Obviously that discussion
doesn't do any good to those reading the git log in the future, so I've
summarized the important detail (that some callers are equipped to deal
with errors but others aren't) in the patch.

> > +	if (pos >= p->num_objects)
> > +		BUG("pack_pos_to_index: out-of-bounds object at %"PRIu32, pos);
>
> Personally I find it easier to place items on a single line in an
> ascending order of magnitude, i.e.
>
> 	if (p->num_objects <= pos)
> 		BUG("...");

More readable, thanks.

> The assertion requires pos to be strictly lower than p->num_objects,
> which is in line with how we usually count elements of an array of
> size p->num_objects, but the next one allows pos == p->num_objects;
> intended?
>
> p->revindex[] is an array of two-member struct, so if an element of
> the array is invalid for its .nr member here because pos is exactly
> at p->num_objects, I would imagine it is also invalid for its .offset
> member, too, no?
>
> Ah, perhaps the "offset beyond the end of the pack positions" is a
> sentinel element to give the in-pack-stream size of the object at
> the last pack position?  If that is the case, it deserves a comment,
> I would think.

Exactly. I added a detail about that in the patch, too.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/X%2F3ODgaa9wr65M09@nand.local/
