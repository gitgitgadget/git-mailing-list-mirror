Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9D3BAD80
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784330776; cv=none; b=ktOD/RC0y8eugeaW2NUYU97MilEejhHYlTGtLchrjTPPCv6uoUnEgr1rJD9Dp+NQXbDh3fZvr8dhE3KCKOC5ARwWDfU7d9pdSiL4E+nS1oz6Da+vyMfTTS9yR4F0fuzUF8tBSnoxMb9N/7FDB7a6gNCxZboncvKV70mE+rzedQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784330776; c=relaxed/simple;
	bh=2zMDg/heas/QhUJWCFf677QS2cCzXxyYOfiVQeNhTY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=askFZvgHZkGJd8vu6HkzeEmszD1qSdORvvSdZTFCQ/U9HemKxLCw4UPJFkwISd8xossTPSy7xWtKnT+5tBvfRjfTE6v0VCePj+YRK1dMpYaTSAbiOiWXVxBMpZ9qbSz3/YbtZWUGauf9wZ1qngnQa4fm0neJUdvOiwxB8n39BcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=UieMrRF6; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="UieMrRF6"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6611669cd16so5076468d50.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784330774; x=1784935574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=exkZ3zGx5vGiyMNfMwqT7YV8nxtP4FSZicqh8sVhCrk=;
        b=UieMrRF6NIK2QFDMLpE/FomaC4YL/XAaDy/nUlLyO/uAyX6dp2dkcrVxg16hIHGC6s
         NbglrvjJEvz4xJDnf6YCcqiWUqKVbd2CZWtuq9FSERD1tii7pCmvgkZM/N2Y81i9kocQ
         3SeJKS7gls5PyZ6XDLS/43yzpyDbXsx61nfa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784330774; x=1784935574;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=exkZ3zGx5vGiyMNfMwqT7YV8nxtP4FSZicqh8sVhCrk=;
        b=draeZ0VeAcMmb/TXtCq2evQ1VW/o4XlVdjgXuSRyEq4gswt0nMvqdZp+G7QouByEVQ
         tM+BDimLtfomndqWyZJ1Ve4nppT7Ri1EPEG0G0l7e3AWOZ4WoeENGy+8SulcLXCFIBA6
         OYppg2K4brdkidjORGZm3kRY5v/mld7fQ8YwVquv1Li6QQ9oDnfFXHld5keiRw1Fgrmm
         nRxEb/jthyTa0KmqveJaukEpjzUlycYzpnzskvo8CmZzQ3TeJr95tdCR0OY2JeemF8y2
         zbgbnQnJP0KR0OcQFruGTQJ5zKqZTn4jVZpHdy5mnyM3XqQQy/7sm59fbDwSIRTUTQz2
         7Iuw==
X-Forwarded-Encrypted: i=1; AHgh+RpcSOAr6ABiozxem5xj5uPb6tDjhABy/XNYBZNacuEUeCReLlAqlrIij8hptbEYC2eGt7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuO59LG7lDcWewF+UbyEMtPsOALDxZ8BMlzUtlZp22NN90HaGk
	4tPMBRgQs6g6y+8weGmOXjfn6pksAWPmammxS+tbefJ1Le6edWB3izHVbB7N9/0ril8=
X-Gm-Gg: AfdE7cmjxS7wjRFtGOc229TdVwFnpp1F3xVeObSfZhWAzJpwQrx8DnzGXUbQgOANoQy
	E/i+L5KTgJ1oYDU7iO6wKU1BgJdJU9q2dHR60t5B3gGmoygfgUxeLmT5OJ9JE2AQOJlVv+sVstG
	saiyUQSuyerOq8HK/c7lrtvXghmTZ0IP+mmwCm6w49z5djPpaQUyFypKxEOzmFyHh6/8iH9IHR9
	Jubgqh1u10ow6oLj/lk9HuQLRs49QNOzAD3++uoM05AGlSSbev4e8tkdgCVMKQTjl/y9mYYMHT5
	ZNBUPT6pn1wgToEHmWNovff/505hUkc6xKhb+GJIstUvM5sWQwAwdNO45GOVdNr2qSxcKmE9deN
	uj4PTwhMZo6AZ4BPKgG3pspMRokRdqNkyin4LlzdfVRvXP1r7soNM5z8lslijc2tHj/T6VBBNnb
	FQVUsW2/icwXQOOvJPWsoIqsmQrvIt++NLZnkxzOo9T7QVG37ApXRDkx1B24qWPWo9UFM9Nw==
X-Received: by 2002:a53:dd4a:0:b0:668:3a:8f48 with SMTP id 956f58d0204a3-6683bd2ffb6mr1060748d50.66.1784330774029;
        Fri, 17 Jul 2026 16:26:14 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6684f400823sm132236d50.8.2026.07.17.16.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:26:13 -0700 (PDT)
Date: Fri, 17 Jul 2026 18:26:11 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] revision: expose check for paths maybe changed in
 Bloom filter
Message-ID: <alq6E2oFH6JyYAay@com-79390>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-2-410418f18614@iotcl.com>
 <xmqqwlut1gzc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwlut1gzc.fsf@gitster.g>

On Fri, Jul 17, 2026 at 01:47:03PM -0700, Junio C Hamano wrote:
> >  	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
> >  		return -1;
> >
> >  	filter = get_bloom_filter(revs->repo, commit);
> > -

(This is an extreme nit-pick, but can we please try and avoid stray
changes like this? This one is not a huge deal, but it does make the
patch more difficult to read than necessary.)

> >  	if (!filter) {
> >  		count_bloom_filter_not_present++;
> >  		return -1;
> >  	}
> >
> > -	for (size_t nr = 0; !result && nr < revs->bloom_keyvecs_nr; nr++) {
> > -		result = bloom_filter_contains_vec(filter,
> > -						   revs->bloom_keyvecs[nr],
> > -						   revs->bloom_filter_settings);
> > -	}
> > +	result = revs_maybe_changed_in_bloom(revs, filter);
> > +	if (result < 0)
> > +		return result;
> >
> >  	if (result)
> >  		count_bloom_filter_maybe++;
>
> Doesn't this change skew the stats?

I believe so.

I had the same thinking, which is that without any key vectors, there is
no Bloom query to perform or account for, so that guard should stay
ahead of the generation and filter lookups.

> It could be that these two are intended "while at it we fix it too"
> improvements, but then they deserve to be mentioned in the proposed
> log message.  Personally, I think the first one that increments the
> _not_present statistics when keyvecs is empty a bug, though.

It seems separable. It may be worth fixing, but I would mention it
explicitly in the commit message.

Thanks,
Taylor
