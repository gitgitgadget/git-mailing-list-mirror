Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB32E041F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070681; cv=none; b=DA7KF+NGB0cbjHYPqHvzuVhoKVFO9Y/qFH1e0aSr77WJnHn9oSRnygaVxQyqol/yGJftEnPa9mJk7G+CAM+eup3GwRD21SBzzwWtnPQc5XkkM9Wr50CVPxL4nJJsNYNHk9uKEy/oZ3MV/oXxSOsA1CaGPJF9sb/hgggLGlCi+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070681; c=relaxed/simple;
	bh=xsnxFaEv8pfraF0U4E0fIHK4iwwdUcQK9Jet/4NRBTs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ev0wOfKtMY3nfJDLBnrJdA87vF+rpNngR5aiq4gfBf68snfa5cmRyqSCmGbYhhrdfdZsiD7rw9Wyhh53gt+uZLfMheH3ArMIJTmn1hMrzySTKegbqAdaBUHiyw4IUNogeOU7ylkkgwFgopMSFtoVz2Zyte60sfNrZkiE7wsF4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV8DzCoC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV8DzCoC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4531e146a24so36548055e9.0
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752070678; x=1752675478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFu3rpsiBMZvGSht8yi4EtTCvzfeTKtOGJQzn+B0AXc=;
        b=HV8DzCoCQqVdgSelIIpD9tTnTXF4aTyBs7IEkerjKsovR+wpVnGAiFSG8tLFX4/wAB
         p3HjK7sROirUKDEPKJ9epVcY19gRvADwsR0I9YxEwrRqIoAvxL91AYr6pjbF13nQgZ6O
         m7nn1MfrUkFMXewLAhbGeu6Hw7v1Erse5WhZO7WVrw+oS3aGzj5eG7v5xdQv0S9rES1L
         e1UPGhoZO049yMh78ct7hV7b2tCgX1Vf3iPNy4yiQawFShufEfVsMPlIeetgmVRg9h/C
         ASQRONwJCMGhTIJmuqw1INnNRFGcJzhYiFMaz8DBfCloDxT7Rs6mcYOEzgBg6adn9VOR
         i/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070678; x=1752675478;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFu3rpsiBMZvGSht8yi4EtTCvzfeTKtOGJQzn+B0AXc=;
        b=HOrWDZCONmu7e/WdEbTVikojczoU2I6ipTEQNUNv1qPHGNyuk30aFs1K9b9RZcXZcz
         /Ci8743aNfMu7ShlWJJVTMIDvrpiLZ55wuKB2lwUs2PUzvyg/q1v5Z2u8q1DnDjSS6Kw
         +QsnKWjIv/Ya0x4UWTRjg3IKMfMyIdwnUxh259pkLYzqCFuS6i+s/eX/yg5t1muyPTPF
         E6kp1HEA/sxz3w5ZB/h6qRksb4Lk9wrWHr1mIak4w+z3K/I9n0veXOaIqB0hM7gU/iZ9
         E9XjgVAvUIzQ6M4ROcAqfwwKgYBoLhY5H+Vqm8F9RSu2YPQJBJSUNdX1rPlxfYzqrhyQ
         zjUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIZainnGlTb4Pojehcb7ZhfrRNwvZHYpTDsoyW5q0qxqW2OdwyOPz+vgN0OGKxAmfa7o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxES2Ap65O+TAwXRG0XsxfYVUCIyIuV7vneLvLUS5pJ7pHH/HmI
	iWh5fyEY8AN2Vu+flADjB5NgHVjjPPZPAHUoKotnDBKVWK6jdIkMyt0K
X-Gm-Gg: ASbGncsi7lCm4DXOzJ1qAnaaRFaPwi1Sb/9c616SCMN4ZpgLAiu8jAOty5J+wzPis6L
	qHtL1wfSsh5dHsjrDlOLzon8kXnlkupi9rmlOjMqapxO4EzR1W1xyg6l54AqP7bV4dcz/PWMl/T
	DuKxwsMDAkBQQq0PyJQKJOOHIZy3fasUKIa5p6x7fA8jEtI1SVfsU1/qGcxdXPbdNbLp6zmMvQH
	9SpZzNaXk2N1G5IVYfnsy2TkPFJ/x9Y2A6Zq/PG0fykBP3/nJ6/Y5ABu8dgHvEye2374UEph2OG
	CyvL9uwpVERzrjJF83VBR6AMMhPcNH0MjJj2myJczOgU1MWNDJR6xiP3kv/yyLIzJOvAyp7l9bh
	SiVZh3hH0zm3H32elJFz/g2PJFLre4it9TtpWvQ==
X-Google-Smtp-Source: AGHT+IGb0BawC39gDPiN0DRANnRsCBIIr2Pd/U3ECYKk/cG+9RnbqN9e3aficJJbBBCX0aBprOmEpQ==
X-Received: by 2002:a05:600c:8b88:b0:441:ac58:ead5 with SMTP id 5b1f17b1804b1-454d53f34bfmr29514165e9.31.1752070677585;
        Wed, 09 Jul 2025 07:17:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50329d5sm24738805e9.6.2025.07.09.07.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 07:17:56 -0700 (PDT)
Message-ID: <0570c2fb-115d-483d-ad7f-35786994f5d1@gmail.com>
Date: Wed, 9 Jul 2025 15:17:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v3] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Ayush Chandekar <ayu.chandekar@gmail.com>, phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com,
 gitster@pobox.com
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250630182527.69167-1-ayu.chandekar@gmail.com>
 <f22e864e-669d-457c-838e-961bbc977c4b@gmail.com>
 <CAE7as+Z7GXMB4LJGwESK3Pj63ppfFMKDq-xw46YCELJ7E3p+DA@mail.gmail.com>
 <9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.com>
 <CAE7as+abNzqbGSCWsuYe8D_c5dBUuRdDEbHL0pVW5j3kTMER4Q@mail.gmail.com>
 <062e7abd-97b1-4806-9753-338906642265@gmail.com>
 <CAE7as+Yp9GWRohqe4oHHmYa1MfuKbyg9qKRf_z6N50bCSZ8vzQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAE7as+Yp9GWRohqe4oHHmYa1MfuKbyg9qKRf_z6N50bCSZ8vzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ayush

On 08/07/2025 16:47, Ayush Chandekar wrote:
> 
> Now that we're planning to get rid of the 'auto' keyword from
> commentChar [1], do you think it would be better if we just ignored
> the keyword when we detect conflict comments? Also, how is it that a
> user will end up having lines starting with the character being the
> same as the conflict comment's character?

Let see if Junio agrees with depreciation and removing support for 
commentChar=auto first. If we do deprecate it then we should still 
support it until it is removed so I'm leaning towards fixing the config 
parsing to reset comment_line_char to '#' instead.

Thanks

Phillip

