Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B031815D
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045644; cv=none; b=TwxPj/Zs/jgkiCeWwiSiRzjFKDm5s3Shpyih+9iXhriT920XS0MTcCFdXWQ6TtSBERovcKlkbFcF8O1p2hTxYkQMyB7SH3aUToCAMWQjgSn8GMWNe3czfUbjQwQ2PinEepLPrKabYCF2fCpEAwMdh1bhy0TybBveUlPHgNtw3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045644; c=relaxed/simple;
	bh=/8kjQFZp05wZFA3oz5RT822e+CoyqUwv8CJf5NSRw84=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iTq/k7P3JWMfrtrKyd7SXJQLVjryFF1e5TLfJTOSP0qg2SW2wsjVAE1RPwsooaDqIeEqL2em7iZkDz73vu2hSZwFZws/Fz2k+kS6o9Tl67GLu04MNujPUmLLzowqUWFJPbqn80vW9oBlON1lN5FgIribn6vf0X+qeUJjQDe1VMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBmVQly8; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBmVQly8"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94dda16ff9aso11591241.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045642; x=1772650442; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8kjQFZp05wZFA3oz5RT822e+CoyqUwv8CJf5NSRw84=;
        b=MBmVQly8hqNGJ7x04pYi8TQyZ2d+ZD2Y6vQjhx7fOq7RqJLTByPufCb4EGvex0P5ey
         9etvv1eGrULHKJzcU7ihlFEYR8Oonw00V9sT9gGtFGl91xrccxjY6T44V+WkUF9pd4Gd
         TAIj5e5L+pPaP1vIujBNPL+Y3lQCnBhak9ydoR5KE4RXblaCQxXjK8KXu+364Z7PxXkR
         FtD0JXuYmuh+go009L6Kdpdf7Cc5Ngb+Wazn92dtt/Fb450fHpU3nm+gd9bFhvyHrV2D
         CicKRAlCGTHm4w7fTsL31Nj/EicDejsmWXU9FRz3nSEulwCXugB2sFIzLpJY+WuYjOyv
         7exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045642; x=1772650442;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8kjQFZp05wZFA3oz5RT822e+CoyqUwv8CJf5NSRw84=;
        b=WdnCq3W8tcRL8oHfkzWztn0SyjdgzDXrL101246UDYIAb0cHU95LFAy9puXKlhU5/f
         GNnqGKfcvOIIP3uNJEyAymy2QwDpYhtFsxL59zCtecv18KYAple46VVnToN2oKUrXJIZ
         ba2H12SHK1F38uGy0HKRFQ/V+iAjBNbH7chEEkfv07VxiJlEUD0Vn0H9DKs+uot6QDOs
         wqfK7myBsziVF5NB+3uhK/yI6vKRrD4+JpZQcHrbF88uUALXdYeyGojPu2JeTtziS77t
         PgtEUa1oVhKSEsh4ZwZ+JAQOXNxtjddrJ8Zf/yZ1FJmgFCdT9XVKh94AjNkri0Rfy93u
         HTtA==
X-Gm-Message-State: AOJu0Yzk5H1gJwwtAoQjH+bEJG/IlHc6ZDNqZB98VuiSzalyuAyfS5UF
	WrlCHMUJ4JZ8S768OrwgI87J7JvHizQ9QSbonI55O149eGwWMyw+FdqapHG/yQ==
X-Gm-Gg: ATEYQzy/U5AT2dy3CTCFOCA+GGFMDeR+AhCqS9qB/d9+R2sx72ny07F65TpFAu65P7q
	dyvhhcw196TojVMojYI0WYEJwZA7seYITMDr/rkFwIhPHx98H3TdMkweSg8DP6J6at8F+pDHC7h
	WKKzlOi9Q8HcfsOYaqwMKpPKrjkNMQG6ruZSBY+je/SuPBQS8l0I6uCm8H0uVgUUlEpAFX2uv2S
	kkugN7WLPm42Ju+mtW3s45n4QgVnSMiP6XTuZrKokJR/9rliYl5JkDIqWdJrD3OxNNY3wc1O1cn
	S1abDFtNh91jm4CoPr04s05v/PfZyJ5zluYcJXKXfBT9vIiouWJK4g0ihxa5pc1wqHSRF+o8UPh
	naRbZobq5xIUyxEAsa0hbMKsziXq6m2ZDIPN1CXVYuT/RQ4N7X+WrYiznPruDGQumHelZELI1Us
	zJMWH2yFA+LVJOOr+BMlL2XcIZj7CHqDeWdNXrYGyZExMVXLqyC+6TQA==
X-Received: by 2002:a05:6102:c54:b0:5fe:b030:ebcb with SMTP id ada2fe7eead31-5ff140aabaamr747514137.26.1772045641740;
        Wed, 25 Feb 2026 10:54:01 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5feb6245d40sm15388354137.4.2026.02.25.10.54.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 10:54:01 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [GSoC] Introduction - Mansi, microproject t7605
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAO_P5U2i5aqGWu9woUPS8GWB1VHpHfwNKUBXoTaQg3DSn9YOLA@mail.gmail.com>
Date: Wed, 25 Feb 2026 15:53:48 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8E443FFE-7C61-4C37-94EE-CFF7234C91CC@gmail.com>
References: <CAO_P5U2i5aqGWu9woUPS8GWB1VHpHfwNKUBXoTaQg3DSn9YOLA@mail.gmail.com>
To: Mansi Maanu <mansimaanu8627@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> Hi Team,

Hi, Mansi!

> All 4 tests pass. Patch submitted via GitGitGadget:
> https://github.com/gitgitgadget/git/pull/2050

It's perfectly fine to use GitGitGadget, but given that your patch
will be reviewed in the mailing list, it's better to reference the
message [1] instead of the pull request.

> Thanks,
> Mansi Singh
> GitHub: https://github.com/MansiSingh17

[1] pull.2050.git.1771911268805.gitgitgadget@gmail.com

