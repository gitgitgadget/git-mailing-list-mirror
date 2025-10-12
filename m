Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B92192F4
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760301609; cv=none; b=sUuAY4ZkNfmyLaoxeISZCyDQ7tb8eF2GHi963Ovd4wahLe0RiZAu+B9sYKIQwPqHKstzWMH9WpCmY/r5/+HcyxjXhAI+mI5clRaHpp+3Qwzgw86VGiwTo3NHiW+8vu3M38fUk5A2MZXIiTg5IBIaNgP6UgYMMA4uGoBUJzgLYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760301609; c=relaxed/simple;
	bh=VEtUP59UynVVX8qiJji4f4kDbBLqvXw+Syby7xu7+cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wfa6ULiR1AeZV/UHu+dHcEEBIaxxn577b3Ob6Rk2OYWed8dXcBatQgSwpt2Ow+RpaNGugc74YNNeEhSPdnsPmTInqrqjyX+9M+fZn0qDCjWduxihyJUkFrFEUWD+EIE4Y+oEN1h2iEQHusiSNx418fqV629LPIkdMdehskV12NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxZv6oB2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxZv6oB2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso21763605e9.3
        for <git@vger.kernel.org>; Sun, 12 Oct 2025 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760301605; x=1760906405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEtUP59UynVVX8qiJji4f4kDbBLqvXw+Syby7xu7+cw=;
        b=mxZv6oB2+RHxxgKnlxPLgj0osgigspUgUKty3N+hUoe3Rb2zSnmnQy9pkiPZhXXU6G
         E1Qpo5OoYk/mj0WpYrEqtsTB+N0kmVUWg4S1HOf1YuG4jZcJKrshigExS3iDCMs5dJZN
         jeq5QO31ymABVKGOTvruzCkueM3H+ksm0TXH7VKD03j7J2E9ks4sPTRd+DA8giRiTuLm
         OQCqnolTgcqwFcvn789lgoAnrsWmCGubh11cdY3l3mqGpt8iUqg7wQhpRXIQdW+tuO/4
         xT156frJ+fb9KJVAiUMsCLS8lZnj68WCFWXY4z7pX6XL+CCHnmXU3IJpzHzFpag7E6C3
         A9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760301605; x=1760906405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEtUP59UynVVX8qiJji4f4kDbBLqvXw+Syby7xu7+cw=;
        b=NwkmLaeJEncZl3jSignfGChaTYVsa1rayvoVXgCDGboBI9mWLOGt6nNlkY+stBceSa
         5gN0Vh7AaMU+pBqtZRnB1cxlODgwS9o1n3XmjmEPUHbRc0g9nff8llW4U9lKtzJPnNxb
         6Fkjuy5L0CxaLFxtr0T+1tP9DX+f4j43D/KI0XMH+J3rxguPBHwycCQQnhpRGV6ftCfp
         O9hU9t7Lu+6vO3TXVNCRWRUjBgIuOQRxBVV0DgSKrTag2hIGZbnqQSeeIkvEdnWQBIKG
         ihbdyXgmQxokNOe5Y+97vZoP2n7eHDwjpIypYcv8Zp/DSqJEt6wMoyldU9Eoq0LnQyee
         oWww==
X-Gm-Message-State: AOJu0Yz3s34rKj7UkCr3NNtalDcVG8g0x/AydGZ5ZeHZVgGnrrB8Cv0r
	3Tg+Oqs/+qKIzKx6GJmQH47QpmXCq0FfRHE9OPYCkgrKkdB+GVMbONcB
X-Gm-Gg: ASbGncv9aRw/Pm4nZd0ZW4fgJAUBIdFFWUNroHnnxaEA2z+v7UH9giddHRq582Mr8R5
	Z10Vuw75se/VMmbBYFdwNiYQ7ykQvchxxyUYKNv6dyWH+9ctUZLgashpa2B9TJ2T9eLH/YJdYOO
	7Tw+Ls++xLbcxdOLM+pI1HV1ggTRr7rbJqp6w5HYfxlInNUTX66kqMbOFbSMWQZqdRUuO9wfT/4
	O6wANJO1RJ5vUE04F+wkvVw2HAKt1yzx8DFRQVz9VVL33ZycYfxxG8lIhy84jdORFJxW+uBhsH3
	ZC8tTcJoIXM2rVVcBzgc/kjQV03O1KiJpAyFHzxFIn+XcyTFjxw32jFm1mLUC+zJdJUcwfdBRCF
	rCxOEek3x14r1DjZHxpDp9PNdtQM/nuycXWvhHItiapaYf4TdHnt0UCj2
X-Google-Smtp-Source: AGHT+IFLUlSC7cbcJPhosgIUNiQggklBer7gLu/7Gm31HMwX/GXZvhxAuhNGP/n1QmT0wbB3tljoKg==
X-Received: by 2002:a05:600c:3b07:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-46fa9af80aemr125451205e9.21.1760301605433;
        Sun, 12 Oct 2025 13:40:05 -0700 (PDT)
Received: from void ([2a00:a041:e51a:4700:4251:b04a:92bc:8ad4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d4bbsm14895482f8f.2.2025.10.12.13.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 13:40:04 -0700 (PDT)
Date: Sun, 12 Oct 2025 23:40:02 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] t1016: make sure to use specified GPG
Message-ID: <aOwSIgswyQwr1FGy@void>
References: <xmqqsefq7947.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsefq7947.fsf@gitster.g>

On Fri, Oct 10, 2025 at 02:14:00PM -0700, Junio C Hamano wrote:
> Go back to use "git config" to fix this.

Apologies for the mess!
