Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFD7C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 17:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A856A23B31
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 17:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhANRBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 12:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANRBh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 12:01:37 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F8EC061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 09:00:57 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v5so3979509qtv.7
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 09:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PhjiS5jtzUfBlCpMHeVbiEmJ0Wh0tAt3rZeEP4rs5Ss=;
        b=hliIptL5bfd3KEpsIAiGemvDwdFW3htgFXtWHOw0A6NlEtkVL4/ByOU4SW13eulR70
         /9XCq+QTRRJxDBd9q6v8jXzjRR6qqhgi6jbrLGQITB88GMzX453eV6UpyCdjsrNaIr+j
         z5zEVJGJPRemF0jkDn3H6wvRNPIR8LoqNdGpZ40pBhn0yLsb7IPSQc/52Pg/slWtqByJ
         Vxyf5aVGSm6C95jQuz4dZK1WmEd4njVLsJbOWrxokMInRGQe5jepC3zVqxQU+Gj3Rc0k
         rkh6uJKog8iZs+1p05SFya9s/i8kmo+oszE9GeXE5wp/xVCCH+xfJf2Kc3nKNm1mJDua
         jprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PhjiS5jtzUfBlCpMHeVbiEmJ0Wh0tAt3rZeEP4rs5Ss=;
        b=ZNJTGW7WNNtuBb2Uit7L9UlQB/41H3OiMAUle4nZLf75904zbffWslMzrlxtlm9pIw
         41M27rqT19PQLfoxefhP0JRYdInJP3PDuEv2KuQfjTqXliV4hW+m0IC/WwnTc6a0kgpP
         UFwxWP80/UiqFi8upprqXd8BvFIxvSGXLhjeFKVdfEKBTtjxR9uCUt+Cr738Whep8y7W
         P8S83LXhh7okoYuq7YDZ4xaa99ILSoFmFcMTqxZP/2KExOdUHskK4x2EN2ViNfpsvpTZ
         dnX5waxZFOYXrhbuTN4eYeaEZB1lW0X8FYikA350WUZN8p1CgCWX3VCVDabGd4EyWJEP
         eQHw==
X-Gm-Message-State: AOAM531sxqa21gJr3mmI3wK1qJ7dlEhduG+0/fdcSDnkOXDt4UdyFF/R
        Y+6Gdx05uaTJrZTgqWylD9+EJg==
X-Google-Smtp-Source: ABdhPJzWQ8j92e09PTzL3efSNLVaqr/v5oMSPi4l8h9txSM8YZw74YcE9wDJauX7udYjw32tDVx45w==
X-Received: by 2002:ac8:6f4c:: with SMTP id n12mr7752238qtv.277.1610643656530;
        Thu, 14 Jan 2021 09:00:56 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id r190sm3421759qka.54.2021.01.14.09.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:00:55 -0800 (PST)
Date:   Thu, 14 Jan 2021 12:00:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 15/20] for_each_object_in_pack(): convert to new
 revindex API
Message-ID: <YAB4xfoPK7z5pmmW@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <e7574763513294b71071b032d5cd3aa0976969dd.1610576604.git.me@ttaylorr.com>
 <xmqq8s8wyq5i.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s8wyq5i.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 10:43:37PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Avoid looking at the 'revindex' pointer directly and instead call
> > 'pack_pos_to_index()'.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  packfile.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/packfile.c b/packfile.c
> > index 936ab3def5..7bb1750934 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -2086,7 +2086,7 @@ int for_each_object_in_pack(struct packed_git *p,
> >  		struct object_id oid;
> >
> >  		if (flags & FOR_EACH_OBJECT_PACK_ORDER)
> > -			pos = p->revindex[i].nr;
> > +			pos = pack_pos_to_index(p, i);
>
> It wasn't too bad before this series formally defined what
> "position", "index" and "offset" mean, but now this has become
> highly misleading. The variable "pos" here holds what we consider
> "index" while "i" holds what we call "position" [*1*].
>
> >  		else
> >  			pos = i;
>
> Perhaps renaming "uint32_t pos" to "nth" would avoid confusion?

I agree that it can be confusing. Unfortunately in this spot, this
variable really does mean two things. If we set the
FOR_EACH_OBJECT_PACK_ORDER bit in our flags, then the caller really
wants the index position (and the objects to be delivered in pack
order). But if we didn't set it, then the caller wants it in index
order.

> -	if (nth_packed_object_id(&oid, p, pos) < 0)
> +	if (nth_packed_object_id(&oid, p, nth) < 0)
> 		return error(...);

This suggested diff makes me think that you understand all of that, so
I'm mostly saying this for the benefit of others that haven't looked at
this code closely in the recent past.

I'd be happy to send a replacement patch if you would like [1], but I'm
hopeful that this is clear enough since there isn't much code between
the declaration, assignment(s), and use of 'pos'.

Thanks,
Taylor

[1]: I understand your general disdain for single replacement patches,
but I'd like to avoid sending the other 19 patches if possible to avoid
delivering more mail to list subscribers than is necessary.
