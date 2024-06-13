Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5EF137923
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319164; cv=none; b=MIeTBFzSaFXC+LyBYE4eRanSsPJjuC2EMhXCFjVfYCB3XiZZeKzWZ5BKHUJySKI7aV2S9zqbCAwejN4mcY1jqlDM2HafBORHhxOrquON+ItMRxFI/ORu0rof9CQ2FW9aOSue6c6EPPv5Rhb823h1FwDhzcvLRtRvqCu6HQ0Axow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319164; c=relaxed/simple;
	bh=JMJj/uSKqAMjWrZt//nmzov2CdRF5gBsrKrVB6WWvBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ll9pZS7PV6J54xU4ERcbC9XSwF0pvwVlBG5kT75VrVrVuPkBmoayLgVl40f6SyQ3Klc/1IVepMtJmNOtQh482jIBoeDPCstmULzwTFbSvr8sZWSvgX+RFXMQeRqtj13Zl7Sd5oXXXpjRuNRX1lBtB6FrwJ/w3zF/YCKUntfeT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ef0b5vav; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ef0b5vav"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfefd03184cso2030851276.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 15:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718319162; x=1718923962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ax2kTASF93qFz/iA59pOEUGw9xtYidxEA/Y04uGWkN4=;
        b=ef0b5vav/tLlTxytf5Havk+j9yW+NNLidqFhz7IZT5fLwktiFP+5KtHiL4LFJ/uSBn
         hUYuxKNjP1PzGRKvj/3BFOyJ2k8QbP3ljtz0xdBix7LZcehuBBLhJ1ewwHS4HOUqlvZe
         Tj1oCMvEVzGvkYHEJ6TEFUVjp0k4pRLJPPx+RqsG+9i/VSlpkvx+pzXQrmfPgHs35h/H
         Zm7o8JqBhHLeqH3EpbwaO1R71aFeBR22JeEkXKm5kbih3lqGLGgrCZNQDf7BOf7WrBNy
         DdwqGf2T9HpjBqol0lz8qgjgzyBYXn2R1Yisg56CNTcPX8tSAyk+SrYLGdZl8I6CLR4C
         uTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718319162; x=1718923962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ax2kTASF93qFz/iA59pOEUGw9xtYidxEA/Y04uGWkN4=;
        b=cvt2SbBPYc5Umvq1C06z6G74UY09VYQkZN/rkLOowd1mEe/OUs+OfMx++r8TjcXQSU
         nIbti1r5p8pftIJPAsy4LDKBo6koDD5oyvJjOroh1YD3ac9tBZM++Fg/xTy7q3SlXeJa
         OZyON1/j65BZIGSMLiuTklCwdpR83F2S/jMcejGPZk48SE2PoIG4ySrCocXHAao7driR
         W7CNo1rqOXLzL9nQFt6QXSa9O/2PyvXGYvuNYP9K2rpCTnmTWjLqbdTnXdK6oTTJg7dd
         1370Scppytz7Yps6/vyo6iVGlRTiB72PqeaYuKbWqNV91Fjs7zkkx/OTa8X2bNgPLsZx
         c2xg==
X-Forwarded-Encrypted: i=1; AJvYcCVySSnGXdOY7y9smXnBgMFbR46X5v7Pkod9AzAunX6aPThqWPfnndSEMdhvaZs07+Qfo1voyeLBBNtB37yd53JedFFm
X-Gm-Message-State: AOJu0YxO1d5Xkqg+ptPBgsCNcMvapwtyC4wc6KYNHs/vh9ZbhY+X027P
	l3GNOgdT3d7sKi9ASakMFyIuMs8xnjGJ3k35wlvSjrCE+pptQLL2vOdztlwap98=
X-Google-Smtp-Source: AGHT+IGm7vb2gb2TyyAgel2nCxIBcyiRcWAcGqKMD7t6cKuCJDNSC8Di6dy74zFelk9cFfRLV3CCPw==
X-Received: by 2002:a25:bf91:0:b0:dfe:73d8:4593 with SMTP id 3f1490d57ef6-dff1548fccamr916271276.48.1718319161998;
        Thu, 13 Jun 2024 15:52:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ef988csm11449496d6.133.2024.06.13.15.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 15:52:41 -0700 (PDT)
Date: Thu, 13 Jun 2024 18:52:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/7] merge-ort: extract handling of priv member into
 reusable function
Message-ID: <Zmt4Jat252KkQApg@nand.local>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <d4ba1fccd9145db9b3fe1530881052315cfa16b8.1718310307.git.gitgitgadget@gmail.com>
 <xmqqjzisimnj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzisimnj.fsf@gitster.g>

On Thu, Jun 13, 2024 at 02:00:00PM -0700, Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +static void move_opt_priv_to_result_priv(struct merge_options *opt,
> > +					 struct merge_result *result)
> > +{
> > +	/*
> > +	 * opt->priv and result->priv are a bit weird.  opt->priv contains
> > +	 * information that we can re-use in subsequent merge operations to
> > +	 * enable our cached renames optimization.  The best way to provide
> > +	 * that to subsequent merges is putting it in result->priv.
> > +	 * However, putting it directly there would mean retrofitting lots
> > +	 * of functions in this file to also take a merge_result pointer,
> > +	 * which is ugly and annoying.  So, we just make sure at the end of
> > +	 * the merge (the outer merge if there are internal recursive ones)
> > +	 * to move it.
> > +	 */
> > +	assert(opt->priv && !result->priv);
> > +	if (!opt->priv->call_depth) {
> > +		result->priv = opt->priv;
> > +		result->_properly_initialized = RESULT_INITIALIZED;
> > +		opt->priv = NULL;
> > +	}
> > +}
> > +
> >  /*
> >   * Originally from merge_trees_internal(); heavily adapted, though.
> >   */
> > @@ -5060,11 +5082,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
> >  		/* existence of conflicted entries implies unclean */
> >  		result->clean &= strmap_empty(&opt->priv->conflicted);
> >  	}
> > -	if (!opt->priv->call_depth) {
> > -		result->priv = opt->priv;
> > -		result->_properly_initialized = RESULT_INITIALIZED;
> > -		opt->priv = NULL;
> > -	}
> > +	move_opt_priv_to_result_priv(opt, result);
> >  }
>
> I have a feeling that making it the caller's responsibility to check
> "are we doing the outermost merge?"  and not the callee's problem
> would result in a better code organization.  If we write
>
> 	if (!opt->priv->call_depth)
> 		move_opt_priv_to_result_priv(opt, result);
>
> then for this call site, it is still crystal clear that this will
> happen only at the outermost level.  The new caller you add in the
> next step would also be simpler to reason about.

I had the same thought. Calling the function
move_opt_priv_to_result_priv() seems to indicate that reuslt->priv will
definitely be updated to opt->priv.

Another approach would be to rename the function
maybe_move_opt_priv_to_result_priv() and have it be a noop if
opt->priv->call_depth is non-zero.

But this is all fairly philosophical ;-). I do not really mind or feel
strongly either way whatsoever.

Thanks,
Taylor
