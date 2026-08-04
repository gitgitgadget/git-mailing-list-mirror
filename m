Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D43672AF
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868210; cv=none; b=KmKpdZvDPhCcwiBLQCNM9B39IYfIDNLZz3xja9jbBpMNb3yQg3JwdDlktIjePW8R878p883qii5GqfhKbQU6E9k+6bRRAUHvEXXjDG4Y4Q2yuHLqC7Anm5np0MDPvZdJtdwZItUHJOGdvbdreDQkeQbhDCzxtKXoM3FXe1oTIM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868210; c=relaxed/simple;
	bh=aDjFYDtshh8omeOPfexTXNgQEYkPQnP1cF2ciSlndAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9iPBso1j2ASBofMpqQlF41JLN8XVzKj+v9JTQhtagf7Hxe1ZRK0hhbXix+AzBy7NVonxa1Qm8M4qU4W1Ro+zNf9BchsE+yHtCXYy+5XHH5coL2+7koH9UrAQS0a9W5tBXJ+T7Au5fyOYZQ/jlu28VuaVCZQfQ2TM9qUvzQLB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMfr417L; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMfr417L"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43bf9548df4so63020fac.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868207; x=1786473007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/eTuPofn1k1lTxXqFG3+T9l/SWaQjRqzc/EtmcryiSQ=;
        b=aMfr417LVHbLPo9WXgL0dOo166sQqbAE+rJN0OT9vcEztGuxRaSJ7C9wGOHQKx+BDm
         Jc+jql7BXCwUWkSTvlGRhFTtGI2qz4O+Pn5vRGFDZ4Cmsa7TbDkrlNm7OKDRmBV4qvSa
         IeUKu82zA0f6J9b15k7qLhCIxTG4TllbEPS3Yy58qPyMnyumGKl/An3txql5wHt0+H1e
         z7LCgadGXeRncBkhMdfhH9d8mxc+sOx0amRJe3lnCzNKvVRZm4/8w8TF6+pWuydhEhtM
         KCbGSD/gGW49z5GwVbFXsYZNX8mgdt6OaANBZTei6VlU47ypg9GHFpiYITGLvbtq8j+f
         iuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868207; x=1786473007;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eTuPofn1k1lTxXqFG3+T9l/SWaQjRqzc/EtmcryiSQ=;
        b=Ei7XEtcdjpSkgXGv0yqK1js44BfNjS/oWQcriDgwFsNzh+v5Sqnp6G/rNhzDrX46IS
         XabNJ0VS7d/qAFuiogxhveUDVXTVnuV+CFiYFUrTkagRcVtLEQabjW8Vh2LR571CIcTV
         rJLKFKz8a9khzoJm6WZjW3m4iUn73/+MkI4ttd3k2xCfPLJxLBKJ3ZoQMXtBW62/d/5A
         vr6FUSLZVmn3SOy9EuuVozww+PbNkVFiv6euADE2igYsOt2YExcs8CuSKcRPBhzhVoIX
         dC1+DSKOgPZD94i+fV23qtZ+K7J6PAq3k7O1GOflIEj9KDE89JvFRd27MzX1d6b4nWo1
         PkMg==
X-Gm-Message-State: AOJu0YxNE/HbgNjbBBzm210RDXpGNtsqzNKcpucmnaGb8PiiLruiiR1r
	ygPvHbM8TdJPscUBSbPzcHJ5xq1cpmn9uFqhdsiBGFTkwB00R0GXU+WP8n0lhQ==
X-Gm-Gg: AR+sD11G7dKGGYx+Jh+QtjDVVEJytvIsybmXe+emG2iakwE4lrUQGNybiP8/stn+RzM
	YSQv4gp4p7lOBmxWnc+Unwr5mCWWfr5/6fRHOc4lYQx8w2eSuBUfReBKTcxsBEqRgT7twnkna5A
	PQqdGWUw19TwTOIksrJcQSEr9QqtGgofvRswhieT25o6o4eD9IFfeikVrYTVQON+FxdcRT87qew
	Vvo5Fo1fXi7QyKYTVQNtpXC0zQ/PtAC2tQK9gGsKrQIAQtgkUe7GR9407eYcYUQaxlSrC+2Wd9j
	C5K4r45aPQfP2ZBE7AU4Zcc82B9VTg70tkTEJ00zL/4seiIH4yYZPBu4oE/nFaf5ANYxQF7VUzC
	etuNt2FlwSc+H9yw4PCIRc2MYg54tzhtfQnZVQyC791PsTe6O3COWsi3zbc6fb76TQ603jXvw9S
	QK9g3nAMqAcszVpCBOpchOGQQC/LBPhPW4uBlUS3+f5rGi9h8TP4CW7w==
X-Received: by 2002:a05:6870:8929:b0:441:f3f6:622b with SMTP id 586e51a60fabf-4599eb1f492mr473363fac.5.1785868207405;
        Tue, 04 Aug 2026 11:30:07 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599e24dfa6sm302818fac.6.2026.08.04.11.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:30:07 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:30:06 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] odb/streaming: unify function names to create new
 streams
Message-ID: <anIu8xOTtZdhDNRD@denethor>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260804-pks-odb-stream-unification-v1-7-86d70e82345e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-pks-odb-stream-unification-v1-7-86d70e82345e@pks.im>

On 26/08/04 09:25AM, Patrick Steinhardt wrote:
> Unify the function names to create new streams from different sources so
> that they follow a common schema. While at it, document the ownership of
> the file descriptor passed to `odb_stream_from_fd()`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> +/*
> + * Create a new object stream for the given file descriptor. This can be used
> + * to, for example, stream an object into the object database. This function
> + * does _not_ take ownership of the file descriptor. It's the responsibility of
> + * the caller to close it after the stream has been closed.
> + */
> +struct odb_stream *odb_stream_from_fd(int fd, size_t size, enum object_type type);

Ah ok, here we rename `odb_write_stream_from_fd()` to
`odb_stream_from_fd()`. This also addresses one of my comments from a
previous patch.

The renames in this patch all look sensible to me. Thanks.

-Justin
