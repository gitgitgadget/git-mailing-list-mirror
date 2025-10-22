Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F733F3
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164165; cv=none; b=Wv+w78ziYFMP/2tsufMGTyqshgKsX/GDfN1vfUTdTQulhqbQGkYAbIWHU2eZY7sN/xd+VtcYvTkNnMHYGtrk9ByqoNsCvnRYSmWo53eXBSxcei6ovbQtTbiKbFy388R6tSr3bNZ0aKnCJHYOdCILBjImkiTS0OOCyvDN1Hm5iQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164165; c=relaxed/simple;
	bh=r9g/3e7YOkeRXK2KphYPB/W7DGLXDrPNBS93JgKMQwc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MftrRZzkAbnb1nwPcRveecbqAp6kpCaqe4Svv+58OtbC4ByuaZXaon5MY4DEVSJbEeE6JWR7ftMubHW7aqZtVlCqNVCYPop9ThuIlkRwcWqMVL6zpSPHh8YQ/Pb/Zemj/jZ4eNJ0r2kdU5VBBbVrVwTL3/tvv28W76Yq0ZqFEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUofsxYJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUofsxYJ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so8513b3a.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761164163; x=1761768963; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9g/3e7YOkeRXK2KphYPB/W7DGLXDrPNBS93JgKMQwc=;
        b=JUofsxYJTjn4ifmUVaiGrzioI4jLesCVhXWDHL2ADUZkcedHdX4wt5lnxixbKKec77
         syuHCr/WyMCLjmEEGCvjSzjD41UIZRtqjgq19XaIYUPmFIpG5u0PC0Q+epfwj0s/vojt
         e/eyjvqztBoIELoABTwsiy1KFieqSJX0Qsn84PzYR08/2ZHPbPWUG/nHOIK2KLUq7TQc
         yHc5wjXHi4TATJ2E4VVo/az2Caa+Z9KKTyjGpD+6XjCF2JhluW+41mTtTYUBK4vq9ZA4
         czAybstLmGORDvpsM0aEYmGnIVybJEap8yeYIlePqbUqOvzHbN4ekml3ilKBRLooby2l
         4NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164163; x=1761768963;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9g/3e7YOkeRXK2KphYPB/W7DGLXDrPNBS93JgKMQwc=;
        b=rOOjRS3mD1EyXFAmJvQhZAy/6b3rs89JrU/vLsHaCEiQj/r/LFonNp3eusS6gnUF+d
         KpkXX+f1vEb0U5WeID9JnktNUq/V5UIrphPOzspsXKxAYuXNDtz7OZp3GrlHvZpf4S6m
         UyzXpnl2wcO/h0Fj4+dC76+A8APLy927AVqCbhilJhHFHDacVNubXcm4ppEZP3wVJ9hJ
         ImAaJ2Dox7WJ07AoIP4xxksM9Tikuu8Vpk43wDPuzm4PUi+QETBEhysQnSN/1p1KC4G+
         w1VaaW9EQwnbvZy1H+ErR+f4BfgVrcbAZA2SgcjvVPKsaS97/RTbdccznTOpD4VIUhI7
         1DkA==
X-Gm-Message-State: AOJu0Yxh23C3VwycPp7ppPwTUgCOJj8WP6zyDLG8XINkDVP8LTNCmYpo
	n5fQXWaXEtAQPHqf65MTegfdXt9jOSpkNDv4OkjnqrUwk4xT3XoEMeSj
X-Gm-Gg: ASbGncuxzbLhIGlWIxTZcYXy0u1WWcc6xpaI+AAHUKb9IDk63tLOch8joeFVt0tv/mT
	BCFZBh0FU7ARmfv94zQZG0XWC3r1/wrmxjt+fIA5mmHnZxLmD9whOc3I8RYh9n6+re3sp9D4ivN
	STRbal7ukSzxQmM09ZH0dUAPkGhNdLgps/zOLVqPyRO8Gr7smHhUspagLM1Nlp4+0otf/B7dEgZ
	/zUOdziHk5hDml5Z2Oxnk6dhK2XaU5mDZoz1RvXZJQWG1Q5qWdEz4k4uis1q6j2HMZIf74Pt1JS
	3iRiRBDYFbzm89o+rEVvmkEov98AffmhsFbwTkbjOVFnC2lKd0LLChEemGysyNIgH4aOeTJaimA
	B98Nta7z8lOHkbyabX1WlyzyBFzqzcGby63Xl6rfVVev1N4DrU4N+Puoec6Xrb7cI+up+k8MHDs
	jpHxROcbOVTHZXr2NOj7P0M1xxEfM+cWG+7JMbYf0=
X-Google-Smtp-Source: AGHT+IEqroHV2nHtcZncEAcSQNpBL94CSrSmpMWGZFPBWTY9KLYv4n2XYRUfJUp1N5bC3FDlcgpQgA==
X-Received: by 2002:a05:6a20:158c:b0:2ca:f345:5673 with SMTP id adf61e73a8af0-33aa80b9cf0mr5650690637.27.1761164163098;
        Wed, 22 Oct 2025 13:16:03 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b343sm85943b3a.45.2025.10.22.13.16.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:16:02 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v6 4/7] builtin/repo: introduce structure subcommand
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20251021182601.2687284-5-jltobler@gmail.com>
Date: Wed, 22 Oct 2025 17:15:48 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com,
 sunshine@sunshineco.com,
 gitster@pobox.com,
 Derrick Stolee <stolee@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <DBB5E6F1-D2C5-4A3C-9FA7-89147D64BCEC@gmail.com>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
 <20251021182601.2687284-5-jltobler@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)


> +static void stats_table_print_structure(const struct stats_table *table)

Question: isn't it possible to use the tables from column.c by
allowing them to use a cell delimiter? This table formatter seems to
be useful for other places, like git-repo-info itself.
