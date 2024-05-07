Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0617BA1
	for <git@vger.kernel.org>; Tue,  7 May 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105248; cv=none; b=kkU9vmFDU2XL9DkXT07dlXl503iVKPVUFMyWbnPcFR87WAiJ4pSnass8qcKznQ9lOL0BefcgpX3KlEHRvMh63I5piQXo0xrq8yjLNqNL9jW0vEsj/bgzdb0rDm7Nl68aZ6zOBDrk+L/w3yKt7otSExAv2yUX9tiG5DH9JKV2SDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105248; c=relaxed/simple;
	bh=pzyic22ZXMCX1zQB9qP86r2zgDHAT5jGd6yDgQEgxqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi3M8/RUtoYmoyuYktHiWtB0HsCX29SNv7jYe8fLZCii6nUMvkvvsm9zi6FX8G7SBXThzkSrOJjR9Oowoncl806fYPpADtVCcELezfj4iB8A+VcgJP1tephDGdODpjYxuciUrs3UtPIv4FmR0avKLuuTmAjHfgMEg4NHIFaQSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMjxGlCg; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMjxGlCg"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ef98eee195so875386a34.1
        for <git@vger.kernel.org>; Tue, 07 May 2024 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715105246; x=1715710046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJKQkymuiY6eqLtT8hS78+kXRGt4/3TPRKVFR7BVPMs=;
        b=UMjxGlCgKrwPCYb+lZC2nyKRGJRiOV6/607CV7Kq98+v4QZa1zCImB7ZrCQT8wRu8M
         FdQzJtMqvzo3Ah3vwS7GrBaQl7zJMzkdak82SXUxCNBnMlGHNDQYWP3qDGjnJPLwOBKL
         mmBJ6NFgPM0aR59Yil5IK1ARLN31VuYc3ooXnGasVtEV9n/wsuDSigDWfiltE9K8BmAy
         MvV+/WTLUxgdZ+8m/xBBj3bsutUXSikUjii5nsjJUrE+MTuXzmH413SNs6jCpXGW+mWS
         9boBtmmCBQBJtWl+uuxsqpnQtCpCDmujy5xVkswfN2+dFttQi1VzcgfHK6XEpPNsnUDd
         C0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105246; x=1715710046;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJKQkymuiY6eqLtT8hS78+kXRGt4/3TPRKVFR7BVPMs=;
        b=B40Gq5+5jka/muFvpHfn/poIVtQ4qsgq20mPhyl/GaHW//BzMZqBObO93jE4bU56zC
         kgRJCqIIriZEJ5AAQrApBFbvB0soMGwAbegQ4fQmLjUUsEKWTT/DguxoENBypx+xJgnL
         uel1kZa8ONPyx68fprdBoCU0rGguNZ0uz6fi2IZqdUUpDEts/onkwdCTI4oAdIZpxOOe
         UNPcEyyxBDq8ZcnBR1VtyQpmbrvZY7bLSHiwqnWwMAlf1Fa3eSYn5IYVwi/SlAJGtc4x
         4g/88zk2sfI5mM3XooaU2/pFA4ITFguMzNVnD5B1A+9U/SVSu680be1zDo40w8eJYppm
         3iEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvTvhQnTByYM2EGG3114VqQwetREZCmUlVi8XSJ+7QWUQ0+wju3PAv9aEmjaTRq+YzEDlDNpC1HYgjpNHZBIVwbZfR
X-Gm-Message-State: AOJu0YxP4fPp9Taj2+wfxopBD50lEhoVFV0Ai9ojNcOZZizR+79YJ8gF
	K3rQjzuTC/7ZmuS94rhA8icvvzNg2xO6auWlg9Q7M1zIZFfMFDtJ
X-Google-Smtp-Source: AGHT+IHftlpLvU9jep+Xo2/+k883cGN7RX+YEvNJjVgu+FjQa/rUw89V+tDF8ntlCBGROvdUBuqFrA==
X-Received: by 2002:a9d:7f16:0:b0:6f0:952e:2877 with SMTP id 46e09a7af769-6f0b7e8e776mr218221a34.26.1715105245816;
        Tue, 07 May 2024 11:07:25 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id ed11-20020a0568306e8b00b006edfe06ee55sm2576577otb.36.2024.05.07.11.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:07:25 -0700 (PDT)
Date: Tue, 7 May 2024 13:06:04 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] gitlab-ci: add whitespace error check
Message-ID: <lkd7hxcwnepjgyjhz5nl46h2igve2ttdoajtjgnene56qau6gh@dec6ticwjfqu>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240502193840.105355-1-jltobler@gmail.com>
 <20240503172110.181326-1-jltobler@gmail.com>
 <20240503172110.181326-6-jltobler@gmail.com>
 <Zjh-3dCL2-MnV-PE@tanuki>
 <xmqqle4mzwp8.fsf@gitster.g>
 <xjp247ji6zjyacniodws6jbdms7tr7726h6spsn7jvx3axqd4a@k6xhzf4v5akc>
 <ZjmqEEB2gXU_nKHz@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjmqEEB2gXU_nKHz@tanuki>

On 24/05/07 06:12AM, Patrick Steinhardt wrote:
 
> I just wondered how GitHub Workflows manages without installing any
> dependencies at all. Is Git already part of the default images? If so,
> there is no need to install anything and we can just execute the script
> directly, which saves some time.

Git is not bundled by default in the "ubuntu:latest" container image. We
would have to install it ourselves. As for why GitHub Workflows do not
have to install Git, it looks like each runner has a defined set of
included software which happens to include Git.

https://github.com/actions/runner-images/blob/ubuntu22/20240422.1/images/ubuntu/Ubuntu2204-Readme.md

> If there is a need to install Git we could either just manually install
> it in the `before_script` or leave it as-is. I don't mind it much either
> way.

I don't have strong opinions, but I think I would prefer to leave it
as-is and reuse `ci/install-dependencies.sh`. I'll forgo sending another
version unless there is addional feedback. Thanks

-Justin
