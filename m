Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A51F5842
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722798; cv=none; b=gnHVD5vui/Q8Km0QrNbBvS/xRs+E/0SQB1FzKl9t0vPCqqYRMGd1GZ/JlVdaFr/xBnR5HQKidSfgYKy5BU/o6ohpA1KcwZEVRtFZK3YLNYV0KtAPBXZyA4huMHu67GrAAx/kG9Y7SsUi8bqBc5BZDI8A1NARhu2MBYtKCECtE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722798; c=relaxed/simple;
	bh=aShVkd122AhZfQ7M3E6N3lYXKPGS0WvgwlBkFiJhh3s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=u0XeiiAyuywQLXc2ak6K3P36QOV3UBOfDP4OwEwZCD+eFcV2YD9bohqLQET4tIPLj2FVoNUUUcU3Qe1E9lYmsiPT0jE54NswyYKu6Fxsr3xJmbyUY+iZ0CdJ8+brEt7O6A/LHZ8ffbkD0VyS/wzQ+3g1Rm3+hvP5XPBz9KINtNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiGH96NN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiGH96NN"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bddba676613so3830225a12.2
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 16:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722796; x=1765327596; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aShVkd122AhZfQ7M3E6N3lYXKPGS0WvgwlBkFiJhh3s=;
        b=ZiGH96NNbZ/7dq+46++tZmqLJuEBvFkn9FHkM+s+Hl0Ha1hj54LCPDF/Pxa3L+uGrw
         WnzkOSw/o3Tm2FV1+gMwrOAyJCC1/Qmox917jsIEp818ufCYi6LKTrW7S9IVD1WyY/Ck
         Z/dAS/HTFEmi+DNXEvMmiTxncRjlr9Oo+CMqR2M4S8QXeY6Hf3jh2ffKoLYh8HASYl23
         dDvIH6/rirVInyjifsEvCjZ2kET5mtuKeQBo8miO6OoR8Xdljj1AFnOYF4n4QaMCsVz/
         7TyoZcXxEZvZC6lcmKw0wLFNxXig7Kg0kCOJmImQSSpwydHmEwHyXnVjw0XxNiRWm+k+
         W+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722796; x=1765327596;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aShVkd122AhZfQ7M3E6N3lYXKPGS0WvgwlBkFiJhh3s=;
        b=CsFaKdRVdMe58NFI7zZJDe9b6afrdfvS4xFysQLooJD8UtNGBI7V8CGH00iJmoC8YF
         KAWbgyA9x39uT5bUDzSuyURDQ4SiWYgOsiHknrHWIM4oi+yPLvKpiYd/yxngNu2I0pIm
         3Xe8oGAtsIvlpBJsfnMs7F+Gb1Yv6+hdh4KX2Tu6I/oDJqb2cTPSVGNwYkgtnxOGDGwL
         syESxkYu0ddrh+xVP0Br1xQKXscNiwe+P+ckLxfaJCMz9/QRznzhCWCOhKgOhwNmRKnp
         hnGxvZrqo9Bkh2tLMKe9LyZjx4XbHg5qlhfnDTH2t0IeaxmKlO908zZ7CxqMVUwG6OvZ
         PbZg==
X-Gm-Message-State: AOJu0YydoEIQpnTRcp+GLYaGjCzH2mZn4wi8ZRt0aQJpjskcM9oWWe7H
	z138vvjbQOfc2iGd/2UEb10oyGIX3rm+15Unp4rf+dgLq+MeBp+a/jk2
X-Gm-Gg: ASbGnctQxE4lRxxKdiuqRw0Y6uvtCw96irSa6kOUNg/zCQ9T0OXopvYR22I0RZXQsBy
	RjCJfPc9mdvtPtWy5NmZtihok9DOELwG1e4j6ff7psjY/jhfDv51gIcQjvv6+Dza9SuarVz3mo5
	hoKpftJ1T2kXFZxw5NL6QIgih389P9Wb/bTsUcQTCS658V5MUdAEff4KVagBMbs17avwqF4DOfj
	wtuvupuRUsvIAzGs4AdPM9Rv6jpZDjZtzcM+PMf8FEvzAklvBxpxtCS9+JwgUIyogdtffpC58Vf
	3lXK3pufJ/ii8ViwMw83hreKZ5yg23LEE0uHk5DACkqBOOTmRMGEytKNcp7YMGJnBUD0xrrHsuX
	7dKe3/MO86iffU6pSLeMsxW3zfrrBumyOuk2g5Iv1rss/S/r4yHNy4QbYG6k+cHazQbluOrxmVD
	RYq67vlUSNbbLEO0oAYgmP0e+iuBxQCyriSdSWfc2I
X-Google-Smtp-Source: AGHT+IG6iBopwE89IgImx1DjGE/ghVRyEHEIuv6HGZzVupfJ6mZ3H9V7Yc4EdbiHwvlbIIQPlFHtJw==
X-Received: by 2002:a05:7022:4281:b0:11a:c387:1357 with SMTP id a92af1059eb24-11df0bf7989mr472761c88.16.1764722796434;
        Tue, 02 Dec 2025 16:46:36 -0800 (PST)
Received: from smtpclient.apple ([177.103.85.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm85869820c88.3.2025.12.02.16.46.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Dec 2025 16:46:36 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [Outreachy] Git Internship: Refactor in order to reduce Git's
 global state
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAD=f0L_-b5d5qVdL0TASS5iA8rWQxianT4_2zmhMtwN8p_TYbw@mail.gmail.com>
Date: Tue, 2 Dec 2025 21:46:23 -0300
Cc: git@vger.kernel.org,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Christain Couder <christian.couder@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <2C17EA98-FAEF-46D3-B366-1C41965B934F@gmail.com>
References: <CAD=f0L_-b5d5qVdL0TASS5iA8rWQxianT4_2zmhMtwN8p_TYbw@mail.gmail.com>
To: Bello Olamide <belkid98@gmail.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


> Hello Git Community,

Hi, welcome!

