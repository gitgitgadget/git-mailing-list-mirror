Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86A13C81B
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135562; cv=none; b=IUQxmvA8kb5rhwAPqAZZPvGSt1leeGRr8n3iEUWwdaMt1PdunL+u+s0QcpvZ5EJHHUvjfEntL7lUBrYJ2Io/cFwwuAklEx7cOD1B68lA/RIXNfSxQIe33A1dxULnhq+Rxn3Kxs9tmr2Odsme0mZF8HOHN94S0M6EPKp864sIvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135562; c=relaxed/simple;
	bh=4cYbcf/G+7XnsliJgz7EDzo41/nPDW9DC5DvzS8g1lg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aPaZ1PzZbNHoF+O71SV8PfaMxFqc3E9OiivioSNlXejM/wbmXQb7Vyi1gHrCbBzJBIeb/krD4JSrP/Qp9LB1rgHbr81BTaci/ozDGjf0YqVZQCKL/MhfWS7CvSwTHsJiLN7oan4hv21hLmwpXuiMYxD8/LKeOzx1Z2X5OaS1fFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7ZGnJJx; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7ZGnJJx"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e9c6b44477so513552137.3
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753135560; x=1753740360; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN+uKTMWwCrdSsyN6pZQnGh5SWX3+f80m2S2GnQuDmk=;
        b=X7ZGnJJx4DL9NbQSqyGiprDUw7etCjDg8g5X/w/+r3BQrd5CeicpIv0AJ9ftzR0Ges
         HaK2oy2vVot2HeFvrOddp21npPouFq8bpKJeVFtsl8ePS1dYJ7OynH2wKsiqQ+svN4+B
         qCfUSqVlkN7jDhgCJ0IjCFWBhPeewTO3TqWO5sRtDFlzkMVOV6lG3GzKgAywIbxyknST
         t/bxouEak5P0bUVUeYz102d2/e/UBfoHqULrbkr3J7/+AttBNu1d6/TBXtL8KTvafemB
         N1IvYug0gXZkeDjw3MLyWWOitjNiE1c3ixaATD4AN/ZaWt/4cBzcmCEARg9xr8VfVLSk
         oLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753135560; x=1753740360;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN+uKTMWwCrdSsyN6pZQnGh5SWX3+f80m2S2GnQuDmk=;
        b=GE1ZRuBhKWPrCmBi1DFP4qv0SVWNlQVO6Gg5LRLV8yrRjV/1mff1/5DqaciVGRGxVH
         ubR7HXufGY6wLA2HI7qWpTxMaferr20jeK5gmX+5y7eZq+Oi5CFTiA25OxJEmhAdi7Cy
         hyKHMLv9yBmpBm4dzXTAmxD7FsLGyVSZIFpSAn6WxspukdleHINuaiOD+Hg/KP3uo8mn
         o2bdo2ZegvnDjod2H8Z0DoIw70zpwt1W4zshb47OZR4TboZgN7zuhquxOkY+++xAyyY8
         2sHTflDtIUy7KS2zsDH7LPJ1w21r6G3X4u0y3bKMYM51DTtpmSCkbVyGIOToZfeLIeYv
         syYQ==
X-Gm-Message-State: AOJu0Yx0/QHMoYeggP9gYGbQw7MvsnOcNwUMFwRjUjPsPC12asaLv0WJ
	rkY0hvbaHDTQpQIkpwlmpfnPwhCX4tPEEVHblYdI3abE1NM0A4v/8Z+g
X-Gm-Gg: ASbGncvkPHDlqhEz+Y+X7FagIYZDPTdi4w21E2MbdRihl6D1+qvddlTtl0PoJsTJSXu
	HsIUaoGSfO8YtnekMrX7nmGVyOXKFxeSB2u6xUVnB9RYHSEB5Y6bFVDhaJQXCFgrRpjZxt385Hq
	0Ah/flPNhNOcNw3Kt/6QRZMbW9qQdAibtl9SGU0+f/vSIMTWeC5J9VjXl7zOqgtvzLKwaKXviHN
	hT2QtRplMjnQgWdHxpUQlYXvMtvaSJM8mU1dWpzkv+RC1l7X/fbLJyDAymfjNpcqSoqwu2+Qns3
	slohdgby2AIGhgYN0pgrj04K7/MuQBlc8wPAV63kjWdd3xS13bnyi5J+Y5qNcg0Eq5wRE8MtBev
	/j0qrqIiQnrGLwi6RnYUBXlFDRBeocRywtWKb/tmsAaxpR6Hp
X-Google-Smtp-Source: AGHT+IFs3+lHgSGgD4y1sLQRLLbYx3ZUEpiS+gPo2jNfQeU1ojxVoSnKCQRajYOzXmRs/ht3WvvE/Q==
X-Received: by 2002:a05:6102:3f90:b0:4e6:f7e9:c481 with SMTP id ada2fe7eead31-4f955aafcc1mr11995950137.7.1753135560265;
        Mon, 21 Jul 2025 15:06:00 -0700 (PDT)
Received: from smtpclient.apple ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0abfdc57sm2967386241.6.2025.07.21.15.05.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jul 2025 15:05:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving
 repository info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqq7c07c2fu.fsf@gitster.g>
Date: Mon, 21 Jul 2025 19:05:46 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8F0E5C1-4664-4A95-AE5B-0C692174222B@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <xmqq7c07c2fu.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


>    $ git clang-format --diff $(git merge-base master HEAD) -- =
builtin/repo.c

Thanks for your suggestion! I didn't know about it, I'll use to check my
next patches.=
