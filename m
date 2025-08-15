Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090118FC91
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285153; cv=none; b=d+Lmxf+lv77zJdEt9072fL9bC6H3iSh8tpG3YnPcErppBO8iKS7sF4+lJgUNQHXqgHOFmIGoW35MRObnrJdHAgK8WZStJireCN+mBcTSqVCO5gfJ7NMz/uc914aWWnMo+WngZ9PXTHXIFOn4FLQ4Vy+MM7/6S1MQyiaGLEWujzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285153; c=relaxed/simple;
	bh=+TX+30ahre+Hrs+2FD6mdsqxsj3+N0avjIuO1UXBKnM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VFzi7Ml+HWciUpBFrWyrM9xuXI5AEYR98tH9JDZtOt5QXWWsOtr9eQbIqK1HMbu5u/SeoDGfxWydYnlHf+V8LkKFRWdHgtP/p4Mknn6vpleLFYBTVveNq3wx6KRoqBCI+Kao3Ab+okeYcqeUZqygJQh/gbHEAAnFvkdBUv1Cv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnMNYJZJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnMNYJZJ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2e614b84so2351008b3a.0
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 12:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755285151; x=1755889951; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TX+30ahre+Hrs+2FD6mdsqxsj3+N0avjIuO1UXBKnM=;
        b=JnMNYJZJ+5rBhwljmLhpuHZT90yXp026bYeUkMeq1J8h/SwAQyuo6FG9zI+M9qpY3f
         UwndcVo21nPh3I/UOkuHBqDmrEgc1bdTGCRyfBc4JXba2HwdoNglfSXgSV11v08BhtGz
         vyNxQil+uKe/V5YvZ9O1wHRd2sWQ11NzcEv7Gz/5Vi10YfFGsCCShnKWbU5eV2nla9Cg
         Cp8fWaZFpewYSb+tiRD67dVAcjr8UEwqMzs+sTEWXFvVY0MlKz81g6/YekREDRW5wMcu
         a8dP1X5YdHA44VouJ3REYUgTolhyU9iAQTe8wnHCWMqLF26NjIkgughsWFP7dGW1cqwx
         S+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285151; x=1755889951;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TX+30ahre+Hrs+2FD6mdsqxsj3+N0avjIuO1UXBKnM=;
        b=pgqpm7agrRHc16IY3bHZrhxa9vSWzQ7hQGtsXNQenT4ADixb0pI8boorh9IpvotuLY
         xzFDhBFT115Hgg1BQjM2+MgjtLIxMhBICgrDDOdft3Ox92b9URh93kTcs1gX4bwT9RX7
         sMF2gfy7liVhWWpoy+wNQ+XWc8jzlUiFp73pcCXEAhUizLH9S40P63h5Rf8QW9649mSo
         mymwQ/I6pBMoT1gsEJEhOBrW3jckLw+FAmausxCbEHjRryJuQDi0yLzFg9ePRMJbE+Bp
         outGlMe2XyRdLdtYfKULwUFBiBW2axzT+CjWGFhvWOsIsWW56KFDWgWR+2xS21na9np2
         5i6A==
X-Gm-Message-State: AOJu0YzF9FfyHOaTttFg9FwfrSJYzhW1kWEdaiO+fDTM35ugQVXoM0q/
	d9fZlgv7OXD5t6UB9QXPt2p5UnH2DLaDG/Rv7skf90SniHAUZPEyeOGVc65ltg==
X-Gm-Gg: ASbGnctAygfaYRZ3vHQMf79u1S518DssxGj1ZOB3iUPnFcALJUhDAed+H1EiZtEAedv
	OAcK0j9sCQnKNl2y3UsDtT9OxLa2BD7J8aY8BUQAX8hxKq+NU0OuL+LnHjCoTeFxUbX7riRIQ3b
	5Q7qz5b0TyH5Vib2aLWcc7SKKj0zxvUBfuWFBm89Xqs1WXNfSxlywnPIauYBm08qSxf9Tn8/n6y
	+f+A3PgXBDHLoUrdNOVgWlpDikmZYiwi2uxQXOQFImaKgr+6/bOG7wr6tJm5JukkKgoBD7eenDM
	SWsZPFNnwPeVDEiz6mo3irI8lKrKmucrROde5kCy37+1g154M+51YCqX6gew08wXMnw1cVH70+4
	fw9vsXPdr0BqoWuNvPkp6LCdWvDc0LymaW7t6p8D0cxqxmWaGP5udP7wxc6GsJgfQaw==
X-Google-Smtp-Source: AGHT+IFescR5TZcocVUCoYZFqlBpDR4qna7oJQSEmuVsc4EX0NpB7PoDrzlER8cpGAhP6AUK9lwq4Q==
X-Received: by 2002:a05:6a20:3ca6:b0:240:252a:157c with SMTP id adf61e73a8af0-240d2e5b6afmr5282916637.11.1755285151217;
        Fri, 15 Aug 2025 12:12:31 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e83:7089:f932:3359:f50e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45565617sm1664399b3a.65.2025.08.15.12.12.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2025 12:12:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH v10 2/5] repo: add the field references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqfrdsqvi1.fsf@gitster.g>
Date: Fri, 15 Aug 2025 16:12:13 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com,
 jn.avila@free.fr,
 sunshine@sunshineco.com
Content-Transfer-Encoding: 7bit
Message-Id: <5F0AC8F9-8B0A-457E-80D9-0AAC07D6CB41@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250815135521.44044-1-lucasseikioshiro@gmail.com>
 <20250815135521.44044-3-lucasseikioshiro@gmail.com>
 <xmqqfrdsqvi1.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)


> I know it is tempting to write a helper function like this that
> looks overly generic, but I've seen that we end up either tests that
> are too hard to modify (because such helpers are not flexible enough)
> or we end up adding more helpers to cover different cases, and
> either case the presense of the helper does not help the resulting
> tests easier to read or modify.

I understand... But in this case, most of the tests would look almost
the same and there will be a lot of code duplication, since I'm
testing both output formats (not in this patch, but in 5/5).

> If this were "test repo-info for ref.format only" that takes a
> single parameter (format), that might have been more palatable, but
> I'll withhold my judgement until we have tests to handle more keys
> in later steps.

I have already done objects.format here, which follows the same
structure.

> Also, unless we capture both standard output (in actual) and
> standard error (in actual_err) from the command being tested, and
> instead are interested in testing only what comes out of the error
> stream, it is more common to use the usual "expect vs actual".

Ok. Should I send a v11 or is it ok to keep it like this by now?

Thanks!

