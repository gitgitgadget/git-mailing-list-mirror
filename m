Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B321229B36
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979431; cv=none; b=Ta6nHQUhgi7R9fkb0geNhQFMVJu0ghuNRijnnvYzvIHIX4Nc6fIKgUSldFczLIyeyMGp0H/s6FMugoZUmHHifSdHN98rV8mLfHgyUn/ZtH6xwJ7lypXZ1JMD5qucq+XrHXy6OKw8Lau67uR1Jj5NOUpuepsK1wMA952LeArE3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979431; c=relaxed/simple;
	bh=ICiIQDLLPTZpBy0A7c7Bm7iA/Nni/KRYtOP7vtYkfmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6Ql5akGjd+o4Sag9d3RkJhZD7fzyX7DEOPUOLIxn1M7IUQd0Vhg8fGbv7Yp47LBGRGvgSADQx2kjy6U8HkuWCzLp64UxyfR374vdVN9IwJ/8lzOvCU2nZv/ezMDz5aIj5TMcvcDK4DYpvAeD5bkWvuq8GC1wpEHfQhqBR8u/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EkAN7yP4; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EkAN7yP4"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-62f9c2df5a3so910835d50.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757979428; x=1758584228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GECwwr4BB0FbNE/I2LUauygXRWXbOG5l3bppdi7MFBM=;
        b=EkAN7yP4puvk7ERFfXRLF8cD3e/7wDs3OC/ZRt6r/xatL32Xpm/Y2cgJj75hVs4iM0
         umabMzN4nlCgo+F1QSoNquimkchReiv1o36rbMplgKa23a3FmBxzuWMDOixhPs11KHK3
         PVfkuyKz/uuXYwAEBDgUr7d4XI1FhgYC1/a11TsHBPkIy2sWpzWYgXBMQ9wRdQxF5Pi1
         G8znHMOaTl5MOoL/JygJVWcvN3TuSZ+ZSHgXVK++doo04iLUcneU4uu8ndRfgZAyxzww
         liUtOhCG83WpZX5ljrfPxvhhJHNr3YugcJy9givXXup+yoUlo+tk4M56coZPeBwtyWPO
         dCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757979428; x=1758584228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GECwwr4BB0FbNE/I2LUauygXRWXbOG5l3bppdi7MFBM=;
        b=RcMrTjsfgGvzjt2quENWhRJ6M9Q023Lkpy4dCGJMsV6FeHl8niGLeQfmdZ8qqRyLs3
         JjNj+96tRu8KngRo2XQjpIbbi/FQaCoZqLNEfd2E0iX80h8QzRqstqouufQFpOnX7AmG
         npWkJ+tR/a3IomxKv64mTTYiQYKK6NGRVc+2nbiXp23/AXhdID1Dt4tLvin9KWUrEVdh
         0m0thvKOddEqbpI72Lx6R/WXoFN/iZ3GG0U4DeiEL5Zw2laCvQcl62ti0EmmAIBZbcmZ
         xJ5wbbvTFhN9jNl4tJCUxwY+sFXu/Pq2xcqF22/kJ+Wt7/XtzdD6z2FxxkheAnPmiasL
         +cqg==
X-Forwarded-Encrypted: i=1; AJvYcCVQlvoVq7mvG6bwpaoPfmbCRl3pokkd5rZFd2x32w/9tw7WphEmBouUhJobG0m8GQp6Ars=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxxxi8s53u5ZJ9qxXECPB4hF8Zknpfqa3d2PEFAQxyen2fle7w
	RXc5bNpVlNXdm3AQ+5oYFoki0A/J4+qBSTVjCvyw4gWlfZp8TLic10WKENbQreUrSW4=
X-Gm-Gg: ASbGncscqlEMtYfQY59yPDSnuuh4rTHMn0fUXLBiOkT146TYWZArbhUPelm3G0pe+64
	KHqsdufOaJ8tJT7MgHswG0yRAPQHs69QM8i0tLuxgEZ8m55UY8KiEHAMsQ0sinkcxYfld0oreRB
	NiPsFAoG5CSBmnft+2PyiIMhGY1163eAsIbBlyFwVq0jfObXpRamGBCNcXjaYCktSnjU1M5GDs5
	TH8lLW1EvDfzWywwh1mbsU3BQN3n1vrdUJA8ji4C2tL+Q3zOnuC/oS/JM+xXUchgrpnCoaN0jT/
	U0wzZyMzHLK+JFcYUUxTFAfjeyKYaA3TBYHS0mbhLBBAVkh2tWZyUodYLBebf1hnPzvJQWknvcd
	+jNvdJYmsR/p1MXNle8lbW37fWYoDZSeayN8CCCHe1oeM9EmJbdRMlfkxIpA1gn7sjwNYzpbxbN
	UKMgRpu1iV/qmKRJsESAMotKcWuI7F/GLodrlw
X-Google-Smtp-Source: AGHT+IF57X032NERwneQxAnve4SoJ0633kueWYIQRfrHbvTG8d1Agpzaxv6rPhC2gdaP9LvOuroV1Q==
X-Received: by 2002:a05:690e:424a:b0:631:9db5:d501 with SMTP id 956f58d0204a3-6319db5d687mr3539331d50.26.1757979428030;
        Mon, 15 Sep 2025 16:37:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-72f79c78dbasm36086357b3.73.2025.09.15.16.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:37:07 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:36:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/6] bulk-checkin: remove ODB transaction nesting
Message-ID: <aMijGE2CveYcQaWc@nand.local>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-2-jltobler@gmail.com>
 <aMJu4yoO5-Xp52oJ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMJu4yoO5-Xp52oJ@pks.im>

On Thu, Sep 11, 2025 at 08:40:35AM +0200, Patrick Steinhardt wrote:
> On Tue, Sep 09, 2025 at 02:11:29PM -0500, Justin Tobler wrote:
> > ODB transactions support being nested. Only the outermost
> > {begin,end}_odb_transaction() start and finish a transaction. This is
> > done so that certain object write codepaths that occur internally can be
> > optimized via ODB transactions without having to worry if a transaction
> > has already been started or not. This can make the interface a bit
> > awkward to use, as calling {begin,end}_odb_transaction() does not
> > guarantee that a transaction is actually started or ended.
> >
> > Instead, be more explicit and require callers who use ODB transactions
> > internally to ensure there is not already a pending transaction before
> > beginning or ending a transaction.
>
> I think one bit missing in the commit message is to explain what this
> buys us. Does it for example enable subsequent changes? Or is this
> really only done to have clean ownership semantics for the transaction?

In addition, it would be useful to hear from the commit message *why*
this is safe to do. Justin's message suggests that nested transactions
are noops, so doing something like:

  begin_odb_transaction();
    begin_odb_transaction();
      write_object();
    end_odb_transaction(); <- object not yet added to the main ODB
  end_odb_transaction();   <- now it is

only results in the object being added to the main ODB when the final
end_odb_transaction() is called.

Instead it looks like this patch pushes us towards having callers check
whether or not there is a transaction in progress before starting a new
one. So it seems like this is safe to do only for callers that check
whether or not there is an ongoing transaction before beginning a new
one.

(I think this is what the second paragraph of the quoted part is trying
to say, but I think it may be clearer to say "To preserve the same
semantics, callers MUST ensure there is not [...]").

That's more work for callers, and at first blush feels a little more
error-prone.

Specifically, if some new piece of code is written that does not first
check whether there is an ongoing transaction, it could result in a
BUG() either at the time it is written, or worse, later on when that
function is called in the context of an outer transaction.

So I am not sure whether this patch is making things simpler or safer.
Certainly the bulk-checkin API is a little simpler, since we no longer
have to keep track of the nesting level within an odb_transaction. But I
think it pushes more burden onto the callers in a way that I worry could
create the potential for BUG()s later on.

I think that takes us back to Patrick's question: what do we gain by
simplifying the internals of the bulk-checkin API, and how does (or
doesn't) that justify the added burden on callers? Looking at the newer
version of this patch in [1], I see that you addressed what we gain, but
I am still curious about how we justify the added cost.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20250915202956.3784935-2-jltobler@gmail.com/
