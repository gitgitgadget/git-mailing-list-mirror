Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20130C157
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723241; cv=none; b=QsAOXP3tSVRFhrNBO6/Cv18Tv0GET/1xxfcv5ULWLtqTM7W9VIG0G379CD8qdx0bWoIKsIgUofvNsOsIflgElbNJReFyPikx4ge9+D5CFoynNa/3hxYZjAdiQfAJDfz32rwsPUx2Mj7VnNycte04ZnDfwbzLK5HWElkO05JkbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723241; c=relaxed/simple;
	bh=gwl3RTMKsjuTecOQN/r3Oet8IEzDaM4KJYQ/qv9Fg0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJL2q8NqTMo0ZdZTjwSAfNPBb/FurmyB3pdzKACtVIaEO5BhhL/fuZ1hp1Mctof5rlEkaRr2ImfFtL/HAKu9RmjrxZ4f+ZpRRVUNN7PTHNzGQyKBvZsMx65MSqMBQhOoiu+BppBTSTRfnopRZRn9bQMeaYfo+WXOTu56i5EAQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=RNP+FVPB; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="RNP+FVPB"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e7632b193so91059385a.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783723239; x=1784328039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ll0Piv6waoOAIdVIIK/2CnA03Z+CFVKOhV7JOcH00u8=;
        b=RNP+FVPBqeKc1uPxuXkNK7wu1xamY3V2wy+7N5gcyGdqKB57URG1y6lv/34/bp+S+y
         /LSDn+6mYD/a61sa1S51ALVNACaHr8o95qbUtk6cImsb37BwLgHh4GkXHrD1ijqHxK7N
         crCjl7lSc/+cwP3uLwVULGXIPvpRl8cmeoJIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723239; x=1784328039;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ll0Piv6waoOAIdVIIK/2CnA03Z+CFVKOhV7JOcH00u8=;
        b=jF/urb4ZzmwWDjFJq9OPtGGDp/pxd0qaD+Dzf1s4WQTc6oSsrHJ5dfJNNMiS7GiQNa
         ErXuairzLPthheEEZq6Or1r7X5A6rkitN1+dqtpZRCx8alHPLOTeE1d50eyvYHkTjbxf
         ffSAl/u2p/JdCYbpXUqmVgLGOeiBNxgCydUEx+mDsp3FXaqsrSd7X6EiroMGN8c+lcsw
         U+i4TqAxE3UWFV+ehJ2lbXFu88nYNMAH0f3a1+SNWITYLjZdt00CTeKx3b++D2Qu0xD+
         q4xFIf0RpIQwpskf2Qe4+jU0mi6McBNs8duij0wq15Myn0MCDDSlmfk/nXxr1OBf0lYG
         cCcw==
X-Gm-Message-State: AOJu0YwggjioDLFyPDFWWanT5Cwkak7Li6eKXbmCl8ZjHtb9fZolmE27
	8yPRTz/dmHU6+id2n9R17g2pLb6Dy4bBnht/I6YBIniLb3JnB3eZy47JjRehOedozoY=
X-Gm-Gg: AfdE7cnHF6bK/NKvncZRZdrzctG+cegDkuZWIN1X1LdSozeKFji4FyPJcaqmtpYZdwC
	1H0+KEMkd0PSC2xv/9GygWnCxjjgWVkKnhQavqUG7nMhVt+6cEUqSbBEwRILDCxY637RBcha2/R
	riAht5YoWlnngYZNzX4fc9KprPy++G6aQzgEwR44DtEBNtEALX0p7x9i2FF4Pue3LU9rKTkyptp
	T/L/3A1bP/aiAF3BNEmoEZ79hJZ7oG8B8k+NqPtN160TfwaHSt8geJrf45Z9ZUl/PspPIwSzLSi
	LxvcxOsx76gJ+yDUGOmiLGcTd7Ytx5EHzUgikb+SonjlIbPINQLMU1TAh8OwBSny/yoqeEez2R9
	HXCHk+1TkPov4Xo80mNSH4IpxM7EU+jGVh9HMWREIKgmBmn583upG1qLp59GZwbgzpuZ6bqTyQL
	661BBI1QWAZ4YTg8k/5+uZHFQX
X-Received: by 2002:ac8:5889:0:b0:51c:4eb:b586 with SMTP id d75a77b69052e-51cbf16f378mr8955741cf.3.1783723239489;
        Fri, 10 Jul 2026 15:40:39 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf9f7ffsm24947521cf.28.2026.07.10.15.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:40:38 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:40:35 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] pack-bitmap: iterate object sources when opening
 bitmaps
Message-ID: <alF04ypsYm01y1Cg@com-79390>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-4-3710a9cc165a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-4-3710a9cc165a@pks.im>

On Fri, Jul 10, 2026 at 10:48:56AM +0200, Patrick Steinhardt wrote:
> When opening a bitmap for a repository we perform two steps:
>
>   - We first look for a multi-pack index bitmap in any of the object
>     sources connected to the repository.
>
>   - We then look for a packfile bitmap in any of the packfiles of any of
>     the object sources.
>
> Both of these steps thus iterate through object sources themselves, one
> via `odb_prepare_alternates()` and one via `repo_for_each_pack()`. This
> layout makes it hard to introduce a way to open the bitmap of one
> specific object source, which is functionality that we'll require in a
> subsequent commit.
>
> Reverse the loop so that we instead loop through all sources in the
> outer loop, and then for each source we try to load its bitmap via
> either the multi-pack index or via a packfile.

This makes sense. An individual object store should be considered to
have a bitmap in the abstract sense if it provides either a multi-pack
bitmap (or an incremental multi-pack bitmap ), or a single-pack
bitmap.

> Note that this changes the precedence of bitmaps in one specific edge
> case: when an earlier object source only has a packfile bitmap, but a
> later source has a multi-pack index bitmap, we now pick the packfile
> bitmap of the earlier source. Previously, a multi-pack index bitmap from
> any source would have taken precedence over all packfile bitmaps. Given
> that object sources are ordered such that the local source comes first,
> this arguably is an improvement, as we now prefer local bitmaps over
> bitmaps in alternates. Furthermore, we already warn about repositories
> that have multiple bitmaps, so this setup is broken and thus arguably
> not worth worrying about too much.

Yeah, I think the existing behavior should be considered broken, so I
think that this behavior change is a positive one.

Thanks,
Taylor
