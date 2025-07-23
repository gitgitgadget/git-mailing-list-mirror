Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A8221F11
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292708; cv=none; b=KhA93PMflbZt1ZIBvTO3+T+zvaxrz8Z/NFDvGxG438SrzA566NlRtMPWJBxpZxACmDmVf33enFSww55sLOuUlqsuPwQ9/7TQseMTs2mzldAl3KWAmf1bhRydavTPmsSaLSwQb4csoiBXhiTz4YAWn+FOaOoHoEn6kQCk3heB1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292708; c=relaxed/simple;
	bh=qtLXJ9ZYsmFK+OulaX1oIiQDFs8iVhyJ7kLf5IaysyM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y4xdwehANg2a73dETt2rGJWWSGJWOgcuJTwvqA6iO/sc3ec7eK3eKR2xhfmNN4bDaQuYrX7dklpPZePccxKdydMmhELvfxLy/6UQs1YkDK19hU5rwUOa1zo8+PYfo98bBBk+A2bT/8kuDlZySa6FBA1B3g/EKHmjQnr4vQrv3us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWV00/to; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWV00/to"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-75b5be236deso210281b3a.0
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753292706; x=1753897506; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtLXJ9ZYsmFK+OulaX1oIiQDFs8iVhyJ7kLf5IaysyM=;
        b=eWV00/tozjwXrXWB145ihue8XcXd3cPf3hAo6EGyxctF1r7VoiJPgF0fnIZ61j/f42
         60RT2ubZ/5lkTzqJI8CZdz5YbOR4Z7OTRm9KVjdb8/BhSzQ2eMKTlxgmzp3s3nFtjcq2
         io5aiyHQmCYAtvloYaSlRBxgx2Daq1r67p5wFlfr7UnPsyAelHWPtYMa9ofNC8axbGay
         D93OReC1+p5T0bsAivO45LyGZytq8HbyjDBatN19OlfnlplR8xFX8vjHnNRDcgJq22Kp
         ycrN28jN4pssNSxwzLCGqoiJFGjNFFG0dnz+r1ih49xyZRdrOonBbghtwrWkkG4xrSpZ
         /M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292706; x=1753897506;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtLXJ9ZYsmFK+OulaX1oIiQDFs8iVhyJ7kLf5IaysyM=;
        b=G4jQRK/IV7ERXyiITKxNE2A6HHNhPpEleMywxA6xGUwcngsj5wLruiZLfZdtdpCq3Y
         Cp1UoNcfaB8mr0wpKU7fKCG30KaAyrWrkThXdsOx5JSAY5oGqHVXRvWZW8GicFOItP/u
         JenXFfd4n1O5QbOXWjYmjRjENNONfl+ZWMgwzgSriZsV8nLhYBAHOB6GTPsGIzSiI8Xq
         pB3lSHxuQjaVQ4Lk9ntq0wo7tDMSplKfTRav00LMnST2GduBXmi+/5Io69/48CgM2l8R
         S7KIXhisH4LULUC4lXwjzBIGkP0BkPAkWpmLcbIzTkWrd0FO9cM1Jj3VFgBM9aUnvV1a
         gJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe8UsaxXnKumA4drgU1JYSbVX6HZXZCZHGhmn3pON0RdeD9d2aj0/bL7AHgm3wWYGyRmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbghwC9CiNTbO7aodU62wM1SFx9mCBSjm4BR081zPRFKFGD2j0
	2vK//iZeBw9aRzRNYWRnbgBxA69zixmHjzoHr/y2rZ12J6WsM2kI7UsU
X-Gm-Gg: ASbGncvWr8VhvZvaNqKT588PedQLJ3Cbyh+6GfyPjy4Jz4+L/1tBQUUilUNIs7pnCat
	6PZ3ZDAgIbakp/c3Udt4g0kkK5Jl2ZhFjognSWxyEGQADzMSh5CDUo1Yep1khj549DfRqYONN3m
	ms7KKuPe3cI72Cim6m3oUW8X0/MBtJtpSeaBJCpsGT8SK0VdoraxeKm5arvKZWiEa0P57zE34rb
	GTvewb1wNZfLrzE4BOLgsP9bdvxCPwTrl8fjQ88eCcTjl+7xjnAIKGlyeEtwfK8M7IXT2iHXXOb
	bUe+Z1mu5YpVs8dWq0LKc/aryWycLXn9qjUv8cyIVxIlhqZxHcZkBqXLuXJX5nZNKMov4qK37e3
	xlLIGhb4383EIbxD4LKnmoXJuj56mb5C/9w0gAvM/ra1AyFl+Uf8oWbvU
X-Google-Smtp-Source: AGHT+IFebuHTOZz2jox4c5M3NZdMHi5shQuf1FLoRJs7xsOV6RbkbC9kitBZIeARytBgzts5vOeQgg==
X-Received: by 2002:a05:6a00:1989:b0:75f:7fc3:41f9 with SMTP id d2e1a72fcca58-7603450a7bdmr6399038b3a.4.1753292706533;
        Wed, 23 Jul 2025 10:45:06 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb678fecsm9946947b3a.118.2025.07.23.10.45.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 10:45:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC PATCH v5 2/5] repo: add the field references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <7d6ad7cb-e25a-41de-9588-6a3c1b0717e8@gmail.com>
Date: Wed, 23 Jul 2025 14:44:52 -0300
Cc: Justin Tobler <jltobler@gmail.com>,
 git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com
Content-Transfer-Encoding: 7bit
Message-Id: <4A044F64-8C3F-41FB-B079-AE10B42539ED@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-3-lucasseikioshiro@gmail.com>
 <ldomqfgzts2fs3zuzuyfpsp4jsuec7a6ooisztqx6pe2373jzx@mqzh62weo2jm>
 <7d6ad7cb-e25a-41de-9588-6a3c1b0717e8@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> I think the fact that git_value_fn returns 'const char*' is a
> concern as it means we cannot return an allocated string.

Yeah, I was thinking about that. It is not a problem by now, but
after the acceptance of this patchset I'll start to work in the
`path.*` fields and that would be a problem.

> It would be better to pass a 'struct strbuf' to the callback and
> write the value to that instead.

When I was working on this version I was thinking about it, but I
left the way it is to make it simpler, and refactor it when
implementing the `path.*` fields. But now I think it would be
better to change it in v6.

