Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A3324B31
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564327; cv=none; b=C7jhmtPfRiOnx5sn5bZNbUdUnNLMxs+1bATrnDtPWWO80uTyar68frcq4RuhIncIbTK5968IX021/638t88wIU0m7Gr78ISK3BfOTZY4RMJlUXw0LRf797Rm6Ph7sonOAytNxRX4RK5GVnMNFAMq8h8nOHIvJDOyIa+C1wlasog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564327; c=relaxed/simple;
	bh=usQWTEJwGKHQLZ5cdVFLHZ3OvxiW9ez8kCQNiMhgQPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrUNxs8ldP7gL90hxlrXsL9Oh4PXXs/SQJi0w3XO5XO84V/vnZMLN9nAE25zhp3+Jz7F0BHoKjg7lDrIuHqxY45zRrQyvhFTKs3SKW6egbNT6lhoCeqBf6XWHelmhRSIgE4YvEKp0lE3e2WqOXMLkiVpIMiyVZ82DFtQdRVEe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cs7obo3F; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cs7obo3F"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7947cf097c1so15998547b3.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774564325; x=1775169125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg61OVwTnSLWBYTika2ELOR+dYq5eS9hyupuLKrHNLs=;
        b=cs7obo3FYr0UA0SF/HW+C6aG6WDkpbiGBnMAAXh7siHVqtKJZrLxY7Pry6mfprDjDo
         SBYURxNvDDHnjRChJ8xfOAi4BZODBzYyCmLMZ4VZ2LmZmk+1iKvjrque5j4RfCDnRZ2R
         ddpDY+SCjhxmFDU8AJHQsoTI6L876qT2eZV3UcqYImA3g0uPBb7mE8I5E4f/ZlaOTIoC
         RaVvajvIamuuzegQ97+LnqQdk4DfEcqz35HrXXTJeDgQPx+lu+Xe9OfK7xYSDd4TAra4
         vAS4gVu38Hll2mTysBk5zH7M2tY2L01Ow6Xwd4UIpY9dbZPbFGoUlYn61YAyYdk/pgut
         w9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774564325; x=1775169125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qg61OVwTnSLWBYTika2ELOR+dYq5eS9hyupuLKrHNLs=;
        b=BZOWr+R2cFA46l/gUSQJtVeTPuFe4SZ7uK5xd/g8WTOfWUOvmLIX+DHLxgTGzgW4Am
         9MsR5TUAJw2ZmKati0z8GaJCHouzbs2aPKN9KQYE9O6AOhBrsS1Rdqlhm59hxtlKsjL/
         CfGhVt1d861YZ6U19///4DsgJ/AzaqJYAhfaxwKieKPr7IjXCJbl/DKz8Reim20XxST4
         HTjV48PdHg9z3DqXAMtfWern8xCUuuglmTAx1dfrQqZfonmLs5GJdGksjm1/n02F11Lx
         LGCxIXgHRf5MGFvE/tGL2TPraH3OSjwQLbX8T3O+M5nAgC4YLeQWnyesOf9ILDJLO2F8
         bX3A==
X-Forwarded-Encrypted: i=1; AJvYcCW9X6CZkpWPqMs2YisLRYdnLxZ5hV/mtZ0FTVMII5r+qtKogEuLc9Wl46U/xl4jKZpAdAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GaTAPa7E1ith6VT++TDQfbMspEB6yNjZpMgQXe//DDy2IAYu
	LdnnV5dNg3YXNhqjH94Ou6wN5sBZiKnWGYvj4AbpzFm+zriGk9w+NeR54G/k/2ATsM8=
X-Gm-Gg: ATEYQzzcrJcKzWs33pLfjNa2hPc5p1cCbzd48x9CbZKgDAqs6b5Wetj3U1f6qU89xOH
	I/2oW786zwVbT6mjYkVYlmaxxHvp8TjW0OxPyUDnwVJKWY/Kcog36yFyRxMbKmnZqUshWKLtn+K
	Oj4JzJeQ+tSUiczYmjM42ummiEc8wQ6u2L/MbVlT1eanOITq8eCZEwgmYB8iQc0kgTVtwOi8Hal
	F4QLPBmN9G+TOeLizQrFAXZXAuugl9C6GP5TUwjVl3Ai0ud+eSlWGooVV+75tnacdfpDPP9g7SX
	g775tTKZFSp5pti8ZUdYLfYWcHFSELYUjMydCjcTpK73qhyCMvp2KEDFdhVAhGo/sGuSMyt47tc
	rWupL+hcsSekdSEbJgRoOTdgqE2Wg2Hj2QIgPSCOac8NO5sSL3vWv8fm9W1+pTG//DM5kVpYwxg
	effLhUz/FANqx08bKXYPEYEi2cfGqS/hdnvpXq9RhUNb4/I3ng8f2pPxFQ7wJcvfxmmjxBv99M9
	w94TcEpOW1Ogns2jHMnqb9mot9d8A==
X-Received: by 2002:a05:690c:660c:b0:79a:b69d:cef5 with SMTP id 00721157ae682-79bde05fdacmr994057b3.47.1774564324770;
        Thu, 26 Mar 2026 15:32:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e3bec5dsm20858597b3.25.2026.03.26.15.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:32:04 -0700 (PDT)
Date: Thu, 26 Mar 2026 18:32:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
Message-ID: <acWz48NfB+dlbHAz@nand.local>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
 <9e320604-7367-4f48-a943-f7d22feb2672@gmail.com>
 <acWoqXUwVUB2/65T@nand.local>
 <xmqq8qbensw5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qbensw5.fsf@gitster.g>

On Thu, Mar 26, 2026 at 03:11:06PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Thu, Mar 26, 2026 at 04:40:00PM -0400, Derrick Stolee wrote:
> >> On 3/25/2026 7:51 PM, Taylor Blau wrote:
> >>
> >> > -static void read_packs_list_from_stdin(struct rev_info *revs)
> >> > +struct stdin_pack_info {
> >> > +	struct packed_git *p;
> >> > +	enum {
> >> > +		STDIN_PACK_INCLUDE = (1<<0),
> >> > +		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
> >> > +	} kind;
> >> > +};
> >>
> >> I kind of wish this enum wasn't anonymous. And it matters later.
> >> Let's call this 'enum pack_input_kind' for now.
> >
> > Hmm. I don't feel strongly about this, but I'm not sure I follow the
> > reasoning here. The enum is truly only meant to be used within the
> > context of a stdin_pack_info struct, so it felt natural to keep it
> > anonymous above.
>
> The only thing that makes it beneficial to have a name is if a
> code like this one ...
>
> >> 	const char *key = buf.buf;
> >> 	enum pack_input_kind kind = STDIN_PACK_INCLUDE;
> >>
> >> 	if (*key == '^') {
> >> 		key++;
> >> 		kind |= STDIN_PACK_EXCLUDE_CLOSED;
> >> 	}
>
> ... that uses the type to define its own variable outside the
> context of the struct needs to be written, right?
>
> If these STDIN_PACK_* constants would ever appear _only_ within the
> context of talking about the .kind member of the stdin_pack_info
> struct and cannot possibly appear anywhere else, then there is no
> point naming the enum.

Yup, I agree. I'm inclined to leave the enum anonymous for now, since
the only place we would need a name for it is the suggestion Stolee made
above, which I think does not correctly handle an edge case where packs
are specified multiple times.

As it is currently, the enum is only used in the context of the .kind
member of the stdin_pack_info struct, and we don't ever declare a
int/unsigned variable to hold the kind outside of that context (which
would be gross ;-)).

Thanks,
Taylor
