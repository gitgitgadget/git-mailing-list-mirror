Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C219D8A0
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110070; cv=none; b=O2Txt/8gbh/1rV+qfgfPHlnrc5Out0vW5XjmuNSSEUoX2oG6cIKXzQX1mEUjlTYW6NPQjhimYwlRY0f7hqe6wXFX63HeVjHBGfJYHKAW7A+xdzWrJ5F5Uv50lb8DEg5rd6Lc2hweGwFaWicXpUzFsli2AbFeN6gA3Wm7zqDJQnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110070; c=relaxed/simple;
	bh=jfVJy5xa93Zq4L/l/u3cVbqNaTIDzMMpdldw4EcGNm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN2DenC5fATwln6NBJVawjBCh1aALeTPElDhby5k1PSMJYuwuNlViK45EMZ/kxL/lvUL7KT4/DzpKd3IwSkDQrsIXp4MjKzezg509iNOb7KEK61lw0fSHUBIeoiD50CC3ymWKWGXpPhrKWtbcWhKD7h2qnM8X53yGvNArq5LuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmX0Vv/B; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmX0Vv/B"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so1553510a12.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 05:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732110068; x=1732714868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8J8hDlvT2bqhXGQtpS3NIGqb5WLl3Zv+bKi00GBuC8=;
        b=VmX0Vv/BK0BtKO6R09K7WR3Pp89KT8iZiFyxmLwUqKPlNzcg6DMoq5nhkAmU9XjmnB
         wdsb9f2+m20ot97qUopR++aBjyggV7jssVN98hBPPI3OWG7yXnGyRhV1NLNFcKaz/4//
         F5KjVsaDMP63Ew7DBIaiRalwfWPb5o96bLkdLfQ4uVY7T+y/zIp9PjHbMYKCcY8qgORT
         SQuKW6TUnRZrjL53CtOEM5DqYiKJ6yhR4eMjoI51ayPxlxrA2cf2yyH+Oz/1Rtmm+t/y
         RYgAaYFpsQq8NQ6JU1EOb2fhFjXngaC3puclnb14f+vTICe+9hz0XrBHrZvN+uxGHchp
         rBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732110068; x=1732714868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8J8hDlvT2bqhXGQtpS3NIGqb5WLl3Zv+bKi00GBuC8=;
        b=Gx1DZZPiRPaJyEQrHd28TyTveW8WsnbRPqlQ2qTp07pozfb9pmHyVJoD2kw6MOHNbI
         ZFPpIhxzEFd2fut/ygkSLa7TNDTw8ywtB/5GURoNWKzjypb5Q2/FYQSrv17ePt7BqyaC
         F9sJ3xsQ87vmtyZ+V9PwKtbD8ikA3ZG9EfHOOrILq8xxGxGXNSZu+tfKtiEINztBaqGM
         WzgZAZ7mLN/NwCpDAI9GV22+kTjz+q1FeLbh2cRDZiBAmzhcmh7ds06YQpgVgOBm+lS1
         cr166UclQvaqs8uVKTwmTA3S44BhvpW49wkR0Rq2xIC/XXOz0iCabOKU9iFiuNY1AWqm
         ckog==
X-Forwarded-Encrypted: i=1; AJvYcCUFmo1TKWzKkjPchh+F1tJYzFi1TM0JHvyAIm9yh/VzunXJtBcd4bW596FP6/Y2YZ6XTkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySDDtlMZFaRnKpmQBPAuGR0CZ0eMUJtnnznSw5y1qcyOg/Mi+k
	b5egogkD/lua3sAm/X7ICqYe7Sr+oGpniZUCLhsZhmY/G2r8KgCe
X-Gm-Gg: ASbGnct/UB7E9YvnSW3ZSyJxUfhG4/EYJ/YTjCrQpVgPsEPRcJRwE5pzrAxsV3jvKUU
	pWFsB6EcNTzuUNBze9fIDl4uezhO54oS1n6N9Nk5TYVA/mm8eUYsQyxGkF8+KQbN6uH8crUISeA
	NR5N8B4xZYEciF6jqZw4C1l4lZdI0L8cWmGjBOGQ1pxfc6odyghjezufy1SCklI+CpCgnSuslbm
	iOt5ZxpTiN7PvoL1NriiURxlYD5GnIA+O4ugC6aQq4Unw==
X-Google-Smtp-Source: AGHT+IEHV2MwyfX5Q/rfG4PcfOWIH6rm02i36rXVmFyY39kZvwXQQwFVZK1W5QvfKqWdgdgxis5/Kw==
X-Received: by 2002:a05:6a20:4321:b0:1d9:c7df:3b1d with SMTP id adf61e73a8af0-1ddae9b9e88mr4228823637.12.1732110068352;
        Wed, 20 Nov 2024 05:41:08 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bef8e718sm1654838b3a.105.2024.11.20.05.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 05:41:07 -0800 (PST)
Date: Wed, 20 Nov 2024 21:41:17 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, a@archlinux
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
Message-ID: <Zz3m_aKFz1s9DAg1@ArchLinux>
References: <xmqqo72ai929.fsf@gitster.g>
 <Zz27kX159PKAmBOb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz27kX159PKAmBOb@pks.im>

On Wed, Nov 20, 2024 at 11:36:10AM +0100, Patrick Steinhardt wrote:
> > * sj/ref-contents-check (2024-11-15) 9 commits
> >  - ref: add symlink ref content check for files backend
> >  - ref: check whether the target of the symref is a ref
> >  - ref: add basic symref content check for files backend
> >  - ref: add more strict checks for regular refs
> >  - ref: port git-fsck(1) regular refs check for files backend
> >  - ref: support multiple worktrees check for refs
> >  - ref: initialize ref name outside of check functions
> >  - ref: check the full refname instead of basename
> >  - ref: initialize "fsck_ref_report" with zero
> > 
> >  "git fsck" learned to issue warnings on "curiously formatted" ref
> >  contents that have always been taken valid but something Git
> >  wouldn't have written itself (e.g., missing terminating end-of-line
> >  after the full object name).
> > 
> >  Comments?
> >  source: <ZzYqoai8X_Wdtbmt@ArchLinux>
> 
> I've already reviewed this version and expect a (probably final) reroll.
> 

I have already being waiting a couple of days for more comments. And I
have submitted a new version just now.

Thanks,
Jialuo
