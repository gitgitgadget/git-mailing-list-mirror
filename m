Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6719A28D
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547161; cv=none; b=f7YSUQm4b5DV8xmZBs80bF9oHwQ0n+SGPfeEI5gG/D7fqDookJarGzh3kFpQ5/43TetC1KV5TjPj3VoYAr8WBOlm/+xdG+iKhlEK/HEtZHfaAWrCCq9FLOOmYciO9dCP1QcNAdXdDa+pLpaIdk1RBChrqPXR5NzgQOEGyGfZutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547161; c=relaxed/simple;
	bh=Ta6HnEGIDHMJJCvdsS1KHFcFErWjeN3n+klbtzpJYWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wfs8HEpALzGE0AU5EP7O+WYbqrF20MskbNKmHaEaejx/lCRRw/TdtGGgH3M2Fa0upIqMjEhjlmhV+JToHc6Hic8NfC3DlW8yEdQ3NTHp4UF0nnxgvDo6Y2o0fv6j2SCB6v8sq5fBHrSMffFz8Uld+4uDJt/7x6nxeOGAl0rlMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eqq4r/GI; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eqq4r/GI"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e5ef7527deso20592477b3.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729547158; x=1730151958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ldb0JksbJOWydsdDg7UQBMHJTBMh/W7CQXsSDywcRXs=;
        b=eqq4r/GIR2CLNvNMX8FAlWD65uigaOtuDUgRFYgQOPP4y7E+ShWVZJchNditXiauuv
         YlvoE/MyOurKv9cZ1synCYqQgUPQIud/OrgqdygLc1g8VRmsdd61sHYNjKxCQk9awH30
         ACyp9SCnPc8yeqQjUByExJzBWrp10ExL/qrnGOewpzTTZNVGaK1/Od9YDSUAz6yCzmOf
         NKtTZ8aeEtw0nSuiRw8k6VlcrC34QECTk1Ni1RbpEcp37W7kMj+YGWKPawPwd9grm00l
         6niF0J0z+D2dQxDO7PEk0YIKUoxpRynC2BSFVSvDjXukdoiHmmA3/DJH4+msqOFtxd43
         YvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729547158; x=1730151958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ldb0JksbJOWydsdDg7UQBMHJTBMh/W7CQXsSDywcRXs=;
        b=uILbnRuv/256tQrJ40gLdA4b60ru6QsUFUCoChcOYO4NF/7IK7lSumo/d+MgnML1Su
         qvedBFfwNvozn+YTbZkSR2s1HTAfZtoDJ1l90rPndH1jDYOSl7BVFPp5AYggyBq0vB9L
         auZjL8v1hYaykFwOUW30ySGIB4jWH4ihwACCouT+qtLKCXZHXoRgvy862A6i5PY8m4h+
         byoFWgytEysdUJZf5H3rUuACB19avO1vKxwAMtJgVRsuq3GYf3exr8Fr2SlBWXnAGGbO
         hU55A1ToHD+5iU2k9cE2Lbk4ZD2m7PwFbKt0/BKM9QJbr6d06MpqgK4t8pgoez4Gh4p3
         mftQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoW0ehgusssV/6G29FMBxOQfM0woR2k932afzS/ZOXOlO39+6bkBZjcAOipjY1Lauibkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrG/pbduWAAitiwqv7jebw71WebHJvhZg5tOA18hhmq1+1modV
	gr3+V+isDy0pig4ianIw6cilXupJSaj9tI5c6GTJaJ1JhLmzjkQRjbAoGaZCp9k=
X-Google-Smtp-Source: AGHT+IFv6XtqrSrKgfbVXxbLYj6XeVb1oQjLUDOo8UI8vMFKzHgb+D45Ho5YAGTHG1usMRGtqzTo6A==
X-Received: by 2002:a05:690c:91:b0:6e3:1e6:d9c2 with SMTP id 00721157ae682-6e7d82aa0camr5553847b3.33.1729547158399;
        Mon, 21 Oct 2024 14:45:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d142f4sm8372537b3.115.2024.10.21.14.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:45:57 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:45:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t1016: clean up style
Message-ID: <ZxbLlA0xbuhP7DJK@nand.local>
References: <20241020121729.27032-1-algonell@gmail.com>
 <98c5e44f-42c9-47c7-9fa1-e6cc3b35cdb4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98c5e44f-42c9-47c7-9fa1-e6cc3b35cdb4@app.fastmail.com>

On Sun, Oct 20, 2024 at 02:46:18PM +0200, Kristoffer Haugsbakk wrote:
> Hi
>
> On Sun, Oct 20, 2024, at 14:17, Andrew Kreimer wrote:
> > Use `test_config`.
> >
> > Remove whitespace after redirect operator.
> >
> > Reported-by: Taylor Blau <me@ttaylorr.com>
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> > ---
> > As discussed in:
> >   - https://lore.kernel.org/git/ZxFyKXDCJkRZYYQY@nand.local/
> > […]
> > -		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> > -		echo "Hellow World!" > hello &&
> > +		test_config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> > +		echo "Hellow World!" >hello &&
>
> What Taylor wrote:
>
> > Thanks, both. [Andrew] -- it's fine to do this in the same, or a
> > separate patch in the new round. Thanks.
>
> You’ve posted a new, standalone patch.  But what Taylor asked for was a
> new round on that typo patch where you either squash these changes into
> the original patch or have the typo patch plus this one.
>
> At least that’s how I understand it.

I said originally that either was fine, but then revised my statement
after remembering that the original topic was already in 'next', so any
further changes would have to be done on top.

Thanks,
Taylor
