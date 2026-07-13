Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F13546C5
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783983334; cv=none; b=u3OGMowS4Sud3wMRTugNZ9AFyvthOAQAjOSPLQoRQty16G8+90iXbCaECTf8+yiYWFo4ktZeJvQ2ghsPqAKn9afwVtaQTDKOmzpw/SznKsVIAsRQ2Jcb8p9sjCiLKWc6RkNu80OzeIJ4nxkoH015mhxgyhRBvtCt7cNfj3Te89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783983334; c=relaxed/simple;
	bh=QMLfcr2ZfX4fMLJS4Gv9Smzs223dvFVTlZNfmdYvpek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9CRzcHrfrC18yqauuUELwlJXnQG3P+Xt6m7DbrN8wlo5XPh27pb9PTKVjn4QvH8AVqH1au4Dp3kcrBVVNcaWISubdSmExZlnA7RIp6byq2j8a+KLJIhAI7fGSOvrVpivRbuiBvh2pPYbR02AwCfMmFFDieyrmvLEInqMxQrmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=TIQCKR21; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="TIQCKR21"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e68de4f9aso35484985a.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783983333; x=1784588133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fmpn4JDwpvQvZWkvf/lfYpWJNRy9gwKd78LhILrkCk4=;
        b=TIQCKR21ONJ0i1Ek/2LknWNYrouha7DKQ/ZT3y8OKjZDvIeHk1JWoh2wAp9RkXiTRn
         s+r7/WhgfhVdWxvVtaXME8QKfer+QXMx/896y1U/Ifw1WUUywnti1qED/f5q7JPDusqh
         b5fvDMRm7GcIKZp9ZnzT2Afl875D+3AG2a2CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783983333; x=1784588133;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fmpn4JDwpvQvZWkvf/lfYpWJNRy9gwKd78LhILrkCk4=;
        b=cmdaQZlK7VPjCUvW5N4T/E/t1bTxIcVsH4miRFXVWE8dGadAxACXZmSyq4wZgFl+OZ
         rH5nlg6WbE8XA0/y6ymXnkde6L3UbAmZyz9wUR0oD/WEK336bWhnREQW8ABqlkvpVNh2
         NHnVXOOoELJrfJl95EL6OqbJ9ccRNx2h5x1rD2DSfFanJ+59kPdJ8ZDrMbFAK+1bIopa
         dZrEy73qQWppTCDOsd4NHQzbf+oOqYPTI2YvvxXZQYZErj/IASr7wKBi279bUuCIof7w
         gj+XnhtxUmcn/qs9yaC9Cld0tBE4A6qhg/hrDFmYECvoOWI0+zLJb9+Xs4EFAitCe0Z0
         UwdQ==
X-Gm-Message-State: AOJu0YxQ4/ZUjMzmpHdPXiU7SsZ1MgY1GjG+jyc9rVv3oq0TEUofiKAU
	Q5opsl963iIEGrNAS3CIvR5iT2hZkZqkSCZS6r97eHqXmdgT4+hQ80RkGYPJx3lkS8s=
X-Gm-Gg: AfdE7cm3clEpx5IyiMmk0Re3I46Wk9mNgoZcvE0G5FeNjRZKM6OXGz30C88ntJ/yB0v
	EdHyGBpBgiGrIEDHlr5N4eBtUcehe1SBdhDeJuuddPycFOIxMLrkYJ0pFrFcB2pgA3EcadbIIst
	3/FiItwdsc2h5CDvXYLteOsBMqalhNQ668s6AKd9BvZf5XLrVcPmoV28ekgy57KdL/1XI0zbpx9
	FMwE3ca9J8EjXN9KGcF5vYtma+KYiBpGi+ynP1GNwxwM5roxJACJotUkUUqDR3QWlCmS68hQE+Q
	S/a9Jt1XNJ8x38zExZwRFVgSgkPWbQ7fbBGFOgt46ZQM6lCZO8D2t/JHR4D9xsJcQTz49xAudMR
	1zD/HWaELPiBUFovO5gLUcwgk1clKWgyJ/X41jyCe3hFWrRU+gm7iSr1xsGfhpxY5PV6AcFsIx9
	X7sM3xuo2FWq3coNjTP/0/xoRwPQfwsITogJnIT/dEOMF6uBVdDbY59gsJPCWfwOFFpEEv
X-Received: by 2002:a05:620a:440e:b0:926:e8e6:3c28 with SMTP id af79cd13be357-92ef2cb409bmr752278085a.7.1783983332501;
        Mon, 13 Jul 2026 15:55:32 -0700 (PDT)
Received: from com-76773 ([209.249.37.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b88e40sm1207972885a.14.2026.07.13.15.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:55:32 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:55:28 -0700
From: Ted Nyman <tnyman@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/2] packfile URIs: support concurrent downloads
Message-ID: <alVs4JO9BNQrXsnO@com-76773>
References: <alVn7UWvdWRAG-Vv@com-76773>
 <xmqq4ii2wlo1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ii2wlo1.fsf@gitster.g>

> And "b4 am" seems to be having problem grabbing the patchset X-<.

Sorry for the noise -- Mutt rewrote the original cover-letter
Message-ID. The patches reference the corrected cover:

  https://lore.kernel.org/git/cover.1783982021.git.tnyman@openai.com/

I confirmed that this retrieves both patches:

  b4 am cover.1783982021.git.tnyman@openai.com

Thanks,
Ted
