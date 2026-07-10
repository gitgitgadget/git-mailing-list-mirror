Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A0425CFA
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722316; cv=none; b=SZKD3EahAVx1R74EgIOE7yQATshws5LDV51l7Z90oLklp9F0dvQpqCaO9cwXXHqD3ZIWgQqbkp1hYE/rC5Uca9eTv4dbIjx54YPMuTdNO/Mu3/CIaCKVM4A6yFSqZqp8tkFwjkVRkvQzGiHWaGD0iGt+cTQ7sw4zdHe93LiK0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722316; c=relaxed/simple;
	bh=48xa+zQACisg0wqM21wWiO4n5Ozq8k/QW6MqGbdHX6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5BSuy6OhSHXhhF6RynGIaBCsg6JtrhsHJxVvFtzDabUi0ktuWrhclzhpMEOPF1Uue0z3bvj79X6Nc5clzoEmwAE2bTdk3aLSrPHO/PNi2VlSZHQts7xv/HfOIwuEkeyFV7/HlgKvCEeWdq7cK/aQj3xsRu3aEgfgguNGNQ0LWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=aYtLSPsy; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="aYtLSPsy"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c2a76536bso12972721cf.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783722314; x=1784327114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=48xa+zQACisg0wqM21wWiO4n5Ozq8k/QW6MqGbdHX6c=;
        b=aYtLSPsy0YXmVzGV7jqj11J/Sn16XCSDDW+9IT+DC2taBDQofp6aQ0C9VqTy0kNV3d
         HwBWRpXOWQPPze804tXvWZlH6FQDBtbrp6venmN2KW4Ylu8DgqwWgQ687UvkD0+kxX0I
         CL2RkiZv1WxaPHUu7cJ9I80A+E3oktSghJWwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783722314; x=1784327114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=48xa+zQACisg0wqM21wWiO4n5Ozq8k/QW6MqGbdHX6c=;
        b=dmn3uDl9A25k0mClqUDyd0fYytPNVdHUzVOVvdiXDc99t7T87C2+0gIwtfSW7kesy8
         brHa+0Z1BKUpNZ75Z17YEoSq3pnEOYIFTcN6lcTD6t0PB+TKDMEc/IjHq2BE5r8vv9q2
         P3W0ncnza7tU+DzA6ExCQwHJaWGWq7acim7I85LXve2N9HJOjYr16R4DASvAMC6YoVXl
         OrqRjifLXKvithFGvgGeTqCR2aWC+Ylx28xS9dgDj3vNXISwDkjFql6Os4p00gdw+ZfJ
         VKImEHyx3ZcYMCiH6H6fJlVT3rNge2WUqYl6pnFR3dr9DCrMMtBBP9/MYjO9OSOLcRsR
         gL/w==
X-Gm-Message-State: AOJu0YwqpTEsZzXIcqcTwbwA0N+IG9xgjzexzkeYoDm4AbfRGai+H8oM
	vC2qfgWAHi1P1LVYTY9Muw63znldAPPLGNgXBtClw8Rs1E+pJiWNDq4nzEb9cEOlWZ4=
X-Gm-Gg: AfdE7ckpsUIt0qIXVcweX3MzKzh9qsN6qVX1VSNNskphLocG1VRlBgi0ym1NJHu1dkM
	g4Yn5r56GeEaybSZUxO4nzDRpX6/OGMkVit6xywus/n4OcWag7WoCt/9Zuv2d7eXyXJikrmDfbR
	lKm36SXoCBV/bckihZ+91alWxlw98FL5FQqCmEDudryOOFoHlZESQizhLqRr1Pac0+koAOnf2/B
	hS2Jyolp72WJe8FoC09ILtmHdBpFE8guB3ySlrIfxr4EKadiMjdqPdyqqs7iQW+Na7DC5HgyTgq
	dWnI8hMAylUKPyrakkKlFvKACe5Hc9trZByqMWwVcnZKFsiblPQYETx/F8ztCNkdY0H9s+oLLc+
	TwHZzyuCALYQYOQIgUE/o9r65L7yz/vdHtc1gbwmtvPVZp4txB8l7AEEoiVYYTZilrjZanSpqFk
	7Z7X9+rSnDuHtQaO/HdCbJeVXm
X-Received: by 2002:ac8:58d2:0:b0:517:6350:ed4f with SMTP id d75a77b69052e-51cbf14a7b5mr8224591cf.34.1783722313824;
        Fri, 10 Jul 2026 15:25:13 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacdacf7sm25898781cf.11.2026.07.10.15.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:25:13 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:25:10 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] odb/source-packed: improve lookup when
 enumerating objects
Message-ID: <alFxRvkfNgJRCQTB@com-79390>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-1-3710a9cc165a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-1-3710a9cc165a@pks.im>

On Fri, Jul 10, 2026 at 10:48:53AM +0200, Patrick Steinhardt wrote:
> Fix the issue by using `packed_object_info()` directly.

What you wrote here makes sense to me insofar as I understand the
pluggable ODB code.

However, I am confused by the way this function is written in general.
We use `bsearch_one_midx()` to locate the first possible MIDX position
in which an object matching the given prefix may exist, which is
sensible. However, we go from that position up to "num", where "num" is
the total number of objects in the MIDX!

Functionally this is not incorrect as we will happily discard objects
that do not match the prefix. But it causes us to waste CPU cycles
repeatedly calling `match_hash()` (at least for the first byte of the
prefix) for objects that we know will match.

How often do we call this function with a prefix longer than a
single byte? I have no idea, but I would suspect that it makes up the
majority of calls. If we read the OID fanout chunk, we could narrow the
range that we enumerate through, and only compare the second byte
onwards of the given prefix, if one exists. In the single-byte prefix
case, this means that we shouldn't have to do any memory comparisons at
all.

> While at it, rename the `store` variable to `source`.

Unrelated, but please keep these to a minimum, as they make the patch
more difficult to read than is necessary.

Thanks,
Taylor
