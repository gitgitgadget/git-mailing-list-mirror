Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFC221719
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571535; cv=none; b=D8CnWXRoe96uSGvYjEa54kelMJGLU4hoYw5nTZ4O8Syj58Nx6xyIQMRLXVnRF6yJMqCleDq8iYvGMLDbzvq9QkpHav8k1ljc+wAnjq0M4Pnpv+lJxME9qCwpEeC8Q6QJUtgjjvPWHODTZMlmhBpaAMhHzyw8nBdji9wzsMGBYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571535; c=relaxed/simple;
	bh=En76N5/1sH/pDaf2E23siJu9dZayUzDr3ZISFt7RUto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfmNS6q+HXma1N5gVNNASKFCmpZzDNkmGy/qYbq6219hs3a8Yj12l/iEuAybwtZ4XuataZW6Q0/zPS1a3CCXK/12B9kNTN/E2lVNQEu5oQZDNgVCSCqZSdlWHn1esIC6I4x28/G84vtxnKMpUqtGTKLG6l9VMCqHISvmVbG8UzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cG14WMNj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cG14WMNj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220bff984a0so142292425ad.3
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 04:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740571533; x=1741176333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhJtmo9kilV3uBYTAW/009sthd9xxS2ITz2H+ZYNoIY=;
        b=cG14WMNjpQ1v4wc2qWdD8bLPOSDhaYuiCXuPN2u5w7f06btkKMzL/HpL94xutrJ5z4
         uVfFcAQGI6JVVGa6TBp9yjRvCmNaRGgdED3mIczpzI9WsdtYqsdw3D013OYYR+UNHKet
         JnP/hvYBuSO2LFO7yqcfLfZdo0nidOOtBSqSoqsvoPnS1HcYKk0mJypoQM022cAH8U6j
         mxHPZge6+yNDpk+8XQkcDUqaBRDEJHJRJrWp7rxgisNoCxnzdITTvWWKirxZWu9DwWUl
         yweMDghdKROQsaKvvu0eeQQ26vhR+6AYp1XNZwwD/KQ8sY6WcxtK0W1nghzHy0h+5Zi1
         FxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740571533; x=1741176333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhJtmo9kilV3uBYTAW/009sthd9xxS2ITz2H+ZYNoIY=;
        b=iqhUkMICCo28dZEU4UI9+70zpJIdSG7GMp266pxdSNf3r7DhJPiFzlLanqPTIahBEu
         ezb8frbkQ9IWS6ddjMETUCNUATt991G2xjqm9soZIeR0rWDOJ7T7QRN3pLIzHUir6fTg
         AZny2BmS3/SBB0ovZMYS0LLYogr4U1p83vbimZyMP9hh23s6VEcULUuhzM82PdycF7eW
         0MS7/Pbn7IgWEJeLw38zZpDj1jNdmEYkIP/KS+61Qfdo/CS2TOlmvQmiUYCsCmzD+MeX
         +P+QguPfQNnC2VqStGzEorB5DP4YcoUQ/ypAj6CCSquEHfw18x6l7Hu3M61NJj2W51WZ
         Yx8g==
X-Gm-Message-State: AOJu0YyNiJ/NXDQRyLCfmFHZ3ot2Vr7GJx/41NxkJPjmeeKwAgJcTdPw
	hGqjY+qP03bgYAWajaDxFQIDLLgM3EZ85DPvMEe4BCcqzwJw7iWgDW7Bdg==
X-Gm-Gg: ASbGncuEy5HuPbvbe06W7LWUZ3KQ8OShTUJ/LEOEmEnufAd1TMN+J6TkO/k2xuF6dBH
	3WFZPMMmLKrqDF1KFUonYw08j5GQr6KobisL9bZJDDdYZ39RWq2l9cloZ5hDT41gfJkY4SJLmxb
	HaBgLiRFv5HSWrzfvK2GWxdqQh6FY3nkzyS6cyb3nqyLIQrk59H4oRPXv5/5crQbwvSwIZ0ZkmL
	Iv8aEvRnJjKedzTmgrkW8VyqYDqyEm5dqONJ8nMKq1T7+3IJvf0b2zOEz8bPXmvnMB5OXhMwLPh
	XV5zku+/2wAf2tnCkJHJ5tEmv5ZO0tdu4BQU1vKQ
X-Google-Smtp-Source: AGHT+IHPlDG/uU7m+MbBWeUk5VzY+SHIqNGrPB63XQuRkY7AkbntYYd3PxYSMg+uCFzNb9jFumFYAg==
X-Received: by 2002:a05:6a00:3392:b0:732:6248:ff73 with SMTP id d2e1a72fcca58-734790a7db0mr11162054b3a.3.1740571531145;
        Wed, 26 Feb 2025 04:05:31 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a81eb02sm3349638b3a.131.2025.02.26.04.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:05:30 -0800 (PST)
Date: Wed, 26 Feb 2025 20:05:39 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 3/9] packed-backend: check whether the "packed-refs"
 is regular file
Message-ID: <Z78Dk1WDdqnuPQhX@ArchLinux>
References: <Z73DTwr9RicKMINe@ArchLinux>
 <Z73D3PdEFk_nciH7@ArchLinux>
 <xmqq1pvlly1f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pvlly1f.fsf@gitster.g>

On Tue, Feb 25, 2025 at 09:44:12AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Although "git-fsck(1)" and "packed-backend.c" will check some
> > consistency and correctness of "packed-refs" file, they never check the
> > filetype of the "packed-refs". Let's verify that the "packed-refs" has
> > the expected filetype, confirming it is created by "git pack-refs"
> > command.
> >
> > Use "lstat" to check the file mode. If we cannot check the file status
> > due to there is no such file this is OK because there is a possibility
> > that there is no "packed-refs" in the repo.
> 
> Can this be done _after_ the open_nofollow() check you had in the
> previous round noticed a problem?  Even though we are trying to
> notice and find problems in the given repository, it is generally
> a good idea to optimize for the more common case (i.e. the file is a
> regular one and not a symbolic link or directory or anything funny).
> Something along the lines of
> 
> 	fd = open_nofollow(...);
> 	if (fd < 0) {
> 		lstat() to inspect the details
> 	} else if (fstat(fd, &st) < 0) {
> 		... cannot tell what we opened ...
> 	} else if (!S_ISREG(st.st_mode)) {
> 		... we opened something funny ...
> 	} else {
> 		... the thing is a regular file as expected ...
> 	}
> 

Good idea, by using this way, the code would be more clean. I will
improve this in the next version.

> perhaps?
