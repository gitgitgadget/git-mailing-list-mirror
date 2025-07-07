Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD619E992
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866640; cv=none; b=FMc7/Up2xU9afQM95cLK+3S/IlzjAmvCT4ik836TusEjh8jD0PfajseO5yCIVqNxybBjYXJff1i+RGQqeSaIspfueYPOF0Pc7mbXhMI1+Rr3pzuHMLO4RtPc66e8Z7XgO05y6joFfPKSs+t0gX+x8gho2RkO5qBupteUEnSy1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866640; c=relaxed/simple;
	bh=gQQ0B2A3d5Kms4SOC8VcZHw2JY9SvWR1jh0POVfgtL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2gPgbt3VgNYM92e3SNTxShh5c5mvBRSUS1vg+uPj35uxLga2J7InwHRBYw/hCe1yxJ+aA0Sq4DabARssj+8PqmgmO6+Vos+0vAUWnTEr5P4fZZw1zxeWPGBU0wsJOlBpYLVLgdyKRW2kiK1Z3GTUV126Xh0UmnGalPC/bEaSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvtuXT/5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvtuXT/5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2310592b3a.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751866638; x=1752471438; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnTdWtkKyZXeo2wKdcJ+ZoHLegI+yGLadnq4lWFAi8k=;
        b=NvtuXT/54duXllonlASYL4Bs2UPSiVBNq7TE7mVqjq4Z+GEsX5xzfhaNg0IKSXHxZq
         olbg95fHgPxzHmgzLCHZ2RSrtKG57at+6dG60UJ8Dnnb+wAOv6k+lnCO1ysVZ8tmWmPn
         NkZm6jmx1ZRtRgJZWmMPB7UxlWsumk9Tkqh/teDJ/lZA3AJq5rdiMWOgruW6omm9HCMS
         dIlQxHhFfnI/jrtw30SUarC0Ow5lY0O5E1+YWLLpKa1C3O0CNMrg1SLo4ZO+QF9lji8d
         +po9GiZlEXQ5a8SoWVNqcK4X09iLkSMh88RP2lqFuMoAfmPcD1nqE8YhkhAxhiCtYSJl
         nsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751866638; x=1752471438;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rnTdWtkKyZXeo2wKdcJ+ZoHLegI+yGLadnq4lWFAi8k=;
        b=EpKfrKRxEta3ahNC+6Y0LTe5r8uwOcpu5uI5sEszUhMM2kFoWwg0WXpY2hB8i1fkom
         Nfoy1ASOv2Uw/pDP1Gj4/f+uty41LqWW8mtJc1e8La4bylcj4D20+9q73lalYkqm1PQZ
         /FHJ7XuMbz/PUfX002OXp2pCuMKCJ70u+ZAyDH5nKpIzdOhn2hjRX80u971YLjGBNgX0
         95tbzaS5sU3GABb79v4rXEqNXN3cw264fQHd57gA53CI2+kNFCh07gu72zJxZvvZcSgx
         tS8pwfGh4e625cWpWG7leUPPb2SGrI1dWmpfF830RzMH8BcObYeA5wO0FD+tFUrjgJjx
         A3Lw==
X-Gm-Message-State: AOJu0Ywzgl9si5M4fd0Pr0HF2Efe0K0ljmZ8JTSkSu1IizFCRnTG3aHj
	MSIB0KS311IOkcz3c+BzHK0IgWXzfUEj4i0fvuWyDqunWb1ZQg2ve0os
X-Gm-Gg: ASbGncsE4n5JwrxoQc3ej5ykxFQ8UOiQBje7gQQIEeczVUZE62dt68vZMzVYCVE8JwY
	OdoEy96buSkRPWT25WryINeP6ofAg64FY6OFSMryoyQzYn2doDpvCM5IdqunZ+E0GF8ZbojAgqs
	0rX1fcczFr7koxMljHBc8txpKpbm4Pi7E9ccUJjshsH4cJkKXlxZtIv+lECXQtMZjE6NvMknF5/
	DSp4AvA47dFCVROZR09vcoAEaJxwoQ/rDXzkihQnFI1LarTEIOQJ2uQ1+F3VQxxw5QsNACE+mVW
	clmgAiozweUXmARfXFdTHtQursq34s1DdqkVWb0Nfh930HEaBXsFryVZfxhJGse9lp/lsk15F49
	OkakWVhvhWVf8iTm697k5mH65ynQ=
X-Google-Smtp-Source: AGHT+IEX6Cx5GbeokOkj0nIXAxSSawZDlMhWdT15DSWAEnt5GxO8UqGxsEYoMW2OuYIBRnjkn/Kk2w==
X-Received: by 2002:a05:6a00:ab86:b0:74c:f1d8:c402 with SMTP id d2e1a72fcca58-74cf1d8eefdmr13211096b3a.8.1751866638263;
        Sun, 06 Jul 2025 22:37:18 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce417ddf9sm7887545b3a.74.2025.07.06.22.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 22:37:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Karthik Nayak <karthik.188@gmail.com>,  K Jayatheerth
 <jayatheerthkulkarni2005@gmail.com>,  ryenus@gmail.com,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/2] Add reftable by default as a breaking change
In-Reply-To: <20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im>
	(Patrick Steinhardt's message of "Thu, 03 Jul 2025 08:15:29 +0200")
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
	<20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im>
Date: Sun, 06 Jul 2025 22:37:17 -0700
Message-ID: <xmqq34b8a7ea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>   - Improve the breaking changes announcement a bit based on feedback.
>   - Introduce a `REF_STORAGE_FORMAT_DEFAULT` define.
>   - Print the default ref format as part of `git version --build-options`.

All changes relative to the previous round look excellent.  Thanks.
