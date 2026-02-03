Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D243395D8C
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112507; cv=none; b=WFmx3Zvw4JxKNaya6XUAA1jg2xbdm/F6sAAxrUg/d9tCNQ+lJTbCp8NS5T10WXciAUlTXWeUoM+n/PKOCgpsa7VZFm3dQY+rJqDWkf5Zvy8ITrSII4DvMrQI/T60688UcxVjBGrkB0jwUyee9wUCyAJbnGeN3w79qimsXu7bxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112507; c=relaxed/simple;
	bh=ApPp35bV5DP9ooT9DufrvCqiLwlT3tuHfSZYAV/XLss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jp5lkyj8n7PLNoPo8iCJ4azJRjRSfo976JTZqK6mgEk/u/318vrRXeUXGt/onX+8+Lbkxcea0G8Fnk6POwmchQm4jFUlK7TLjAkUYwaSKSlOK8DOHzYcErKCa/oVwUHXriwgB+rGfLQ5DTarlGCFoEIhR2BcxM/crGTFDAIKD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LH2PRMsh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH2PRMsh"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81f39438187so3157126b3a.2
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 01:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112505; x=1770717305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ8iA/uj18ahyPPCFYa4NIOhuZck+w0G0n0xKlP6s5Y=;
        b=LH2PRMshtL1fLjXDc7JP7B96CcjPI+0aRaYqLCbvmrPy5rif1MRtCO36eW2Nqb4tDK
         ohgtovDLzFxoLTbZzpFdqouKu704A6kkYPfJNBqiDjXJttWfIWMpn4Vv/zJmN7d7mVvQ
         b1EdCPtN5NHrHQBZpm24QZ+AeCK0Htbt6ZWgRcxfllFK8umKGn/0bIIy8uJj34DNG2CZ
         PKcdiUDP027kGXpCS5Biiowpb8VYVOpdSyy+oUIncREHavHKIapl9Rblo29jbkR67Kd5
         b0ntVbnIQYwAQsMAEvu7CkxILBEKYFW9xj1cBWupDL5ocOzXS1CbCZc3CYo7n6P2AFRP
         Uxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112505; x=1770717305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eZ8iA/uj18ahyPPCFYa4NIOhuZck+w0G0n0xKlP6s5Y=;
        b=q4HVfQnmuQchwzJDtWioAUfNvG1uy9S5KzgUpbOQ3CcTKe1h1Y0bG6SpBoKKXSpBRs
         Fc3ef7M0HXonmWPT77U3i0l8oCj8DhXcGMx8XH75IFYFS+7pV3D5xPe9cxszojztPXju
         0xemgb8h2T/9/ORqgJTw31kg6yZJ0WEq7j4byz40MAsXOaAq+3Id/AHuyUiL0JbIJm2D
         HOoYC8i1BGK4+Hqz880xDSYYubZpXjf1ROOAEUYcaGdlkS2fDIcoiv3rDhoGLr+aL+/C
         TKsNfQ9gEo7PlokxPcM64atdXzGA4VA26lEU4/QTqfDYIh3hP4xAskK9kmIY/wHDUiZ9
         70UQ==
X-Gm-Message-State: AOJu0YxJsEQvcXEnJHC0Jyt/XdoF5AyDF6Qn3tE4PoorRFobzw8Wb4lx
	mHdbs1Miy6IvAwzqUG2ra+ur9nUD7nZn1IcQQlIPP8uq3U5r4jVfEjFQ4dWbSg==
X-Gm-Gg: AZuq6aItQyNgDZGn1HfX09dSJRqVU/g+KYFAFsZUafxehzRO/XlwsHYSC/CbLb9iSvA
	IOswsmVb6woWLb2gUMvZ56luc0nQPbiaFw9hkIvEftyb97EK6k9BxDo3IKnBTXW4t18sHICOfxA
	T3CooQsxBoLku7J4XcTzGfUsW1+Xi1eXaI6r+WOvwjhMHzyT9c2o2qnwM/PEeP0yAnqxcCEQTWV
	upxCX0YixpVKqIFr8mmZV9GsTbiYcF5/iR+B++2Om9/eux09U0RjM9n9NYYSo/HiSiz5npF0X59
	oRNFnLuAzt5zYaIKth5HXr0Phx0PtLcpndyH9HGB/5A1gU9Qi2omFHcHoPhPnQZ7+vW/6l2E/gn
	9rJ+0cGogWnJVy6LB3i73k0hhWMo9rwVuWxJ5wgOfWu4/pBmHORFjN1C/WleWEbECNrSLPyPBfb
	Gpj06pbJ2l3kUto25UtQPdyjWd6bR4Vd45sUTqV+1XMTqQwQ==
X-Received: by 2002:a05:6a00:240d:b0:81f:4e0b:324e with SMTP id d2e1a72fcca58-823ab66fb69mr12952736b3a.15.1770112505395;
        Tue, 03 Feb 2026 01:55:05 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:97ce:ef38:b9ca:7f92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcaadsm19942437b3a.37.2026.02.03.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:55:04 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 1/3] wt-status: replace uses of the_repository with local repository instances
Date: Tue,  3 Feb 2026 15:23:11 +0530
Message-ID: <20260203095446.10971-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq4inywxx6.fsf@gitster.g>
References: <xmqq4inywxx6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> >
> >>> > diff --git a/wt-status.c b/wt-status.c
> >>> > index e12adb26b9..9f4d8fda7f 100644
> >>> > --- a/wt-status.c
> >>> > +++ b/wt-status.c
> >>> > @@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
> >>> >	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
> >>> >	s->use_color = GIT_COLOR_UNKNOWN;
> >>> >	s->relative_paths = 1;
> >>> > -	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
> >>> > +	s->branch = refs_resolve_refdup(get_main_ref_store(s->repo),
> >>> >					"HEAD", 0, NULL, NULL);
> >>> 
> >>> Wouldn't it make more sense to use the function argument 'r' here?
> >>
> >> In wt_status_prepare(), s->repo is initialized to r at the top of
> >> the function, so both refer to the same repository instance. However,
> >> using r directly is more explicit and avoids indirect use.
> >> will change this in V2.
> >
> > Would we benefit from further clean-up, either before or after this
> > change, to lose the "struct repository *r" parameter, if we know
> > that we can depend on s->repo being the repository we are collecting
> > the status information in the wt_status structure for?
> 
> Clarification.  This function is like an initializer for the struct
> wt_status instance at 's', so it has to take both "struct repository"
> parameter, but what I meant was other wt_status_foo() functions that
> take both r and s as parameters.  Once s has been initialized and
> s->repo becomes valid, passing r as a separate parameter, as if you
> can feed a different instance of "struct repo", becomes confusing
> and a source of bugs.

Actually wt_status_prepare() is the only function which is taking both
struct wt_status *s and struct repository *r, because it has to initialize
's' with the help of 'r'.
But all the other wt_status_.. helper functions only take one of the following,
i.e. either they take struct wt_status *s which is fine, or they take
struct repository *r. 

If we trace the callers of the functions with struct repository *r,
they are either being called in wt_status.c in which s->repo is being passed
as a parameter at the end so it shouldn't cause any issues,
and for any other file callers, the_repository is being passed,
so to remove struct repository *r, we would have to setup struct wt_status
in those files as well.

Best,
Shreyansh
