Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E441ADC97
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923726; cv=none; b=ckfq42rLNcftF8chvJKodELylBCWo2MnSHIY/+LSKVRvk1xnCCTkfeGPGpoOPwocsMBx4C72ySfiPuVFcbQTXp1sgUiRJNDAnoayGq9wSSK4D8qIis8TjQTg5HO8tnATvSjeMfoyh7iyZOBqxk4EWZA/MKrwJhIY4SSdeZkvlhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923726; c=relaxed/simple;
	bh=v0XuNP5F94tBI7lIp0efHAOcYy2Ld1gCrNE2UAGRHV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7AZ8B4CVUwzp9Obah1y7HMi2C6ndSk2NgHAspZpvWikX7nnL216YleadpmK4yMgnXG+BkLa3N+F3ov6uBtRzq3OcOeMnygL367fnQCqICpkKUirYZzAgf/nPx1fmKXx0bGCGJHzWIhhYDUA4tk66f3+hiSPTcZVPfoeqSlfubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/LcdeIa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/LcdeIa"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445826fd9dso2875045ad.3
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756923724; x=1757528524; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxjsYWCq0igzHNkQsXV+7K6krVDi2mXei2hBfKQkWjM=;
        b=W/LcdeIagOfpT7rZ921z9Ts4YWuFBMlvJ6mNEfbR66/PS+39LYd0KN6ON2X4A+cozo
         29dv2wQnQi05860DIRbcc4iIbd/X9ty39XlTDOpzmVZTRTKEU2Cye4Pa8Frgjv2Kaum5
         XbKzDIjo/H6d3ynysqjacgeef5YyrS6NTnZQb+jX4GGOoTNDYS/daI6TxnXjxtXFESct
         dG4nzS6RcjhClbOK9RqN1g+Yxr9VnGZpjISL3kns7XRBTmMQCeoOe5yZxcx4D+RVDA4y
         vq+fqN45khFEx05WwKONBJ2i5wDCslwCy2lIlUao8gpopaotZINxxbG1upoBV9duwlXJ
         RN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756923724; x=1757528524;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxjsYWCq0igzHNkQsXV+7K6krVDi2mXei2hBfKQkWjM=;
        b=iDP0QGtDtIS6jYtmIHOe7S8E/qDEOrHYU9SGZOYR8lg4EZm1bAVZVR0v9EbKEkJaPW
         iGDWNRxptTbn4S8RFc5tOvwVRBH0tx3Vb+3LYr8HLiswbj8wCR01aTChWnU7W1jYwhFY
         9nf4WsyyVIjLqxmr1GCquvD9XEDSHbSxOKqWbpkUDrRpZD6WRpoacf1ZvEz1P5sKvyaP
         Ox+xj5Nk9W5Up3CExUPp6OC9tMvWdaxjJ32x8ID0gL3IOa91o1MKkSI/Sy7CNd8eXtkg
         vYOTPqrHDT1www6as2SOg7vVBt7ZMxrouHcBI9/LdwfT2jNSwggxzJReaJRp9mtCLXu6
         88Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVxo0QAFnXDDLieo1wEFBxF0xpjCHKbHYlie/3NovSM5q5UBSChuePm9du1oHfg4Hrn4Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WmoltvEhduzGqpDcQJUS/I5y0UNH5MpkKkPZE1GohryS3mCe
	hBCeROtd9hNFj5c83IQJZfNIg3jrqGEZjaLDWJOobGISTBqIT9jukMfF
X-Gm-Gg: ASbGncsVDnwN1XftBbVo27CDay1WtVTIcKmPf198mKDSOSEU28/QEaHXQh2/a18iREu
	6DO6TN3PABYuSnZhd4L1KEOhK+W/yJTPk7Vf6v7QxN8yOAxBDvca9hwUNr3mjC1XugCD6D3Iivx
	QisN9UYhLkFH8S71oGzefLSBOtpFW9vOhP5TvUvu6RAFBSMqizzrSF3PLOFcyaV2DPgYq8VM/Xt
	uXuSFSk1aEHGP9iCoc5CxGxUhjT1Yt06Qhrm9PdYpWtrRioS5IHNXPgKMWKjF9cTII0tBZvCD+0
	dvDZ7Q2+99TgtWO33DSrK9xqVxLfBH2HXy5bm16S/2urJw8biOIPc4NGz6KObnyYfVhkQ8/MAT+
	cZUJv
X-Google-Smtp-Source: AGHT+IG2EXs9Di2/Eo2lUqilpKmsNs/BNO4+0FVBPwncJ34daNtkPSAz0tO0NL9TQBiLo8ENlP0fNQ==
X-Received: by 2002:a17:902:d4c1:b0:24c:92b5:2175 with SMTP id d9443c01a7336-24c92b5262fmr35134745ad.24.1756923723324;
        Wed, 03 Sep 2025 11:22:03 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::cccc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906598815sm163976965ad.117.2025.09.03.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:22:02 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Sam James <sam@gentoo.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Patrick Steinhardt
 <ps@pks.im>,  Junio C Hamano <gitster@pobox.com>,  Taylor Blau
 <me@ttaylorr.com>,  rsbecker@nexbridge.com,  'Elijah Newren'
 <newren@gmail.com>,  'Kristoffer Haugsbakk'
 <kristofferhaugsbakk@fastmail.com>,  'Josh Soref'
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  'Christian Brabandt'
 <cb@256bit.org>,  'Phillip Wood' <phillip.wood123@gmail.com>,  'Eli
 Schwartz' <eschwartz@gentoo.org>,  "'Haelwenn (lanodan) Monnier'"
 <contact@hacktivis.me>,  'Johannes Schindelin'
 <Johannes.Schindelin@gmx.de>,  'Matthias =?utf-8?Q?A=C3=9Fhauer'?=
 <mha1993@live.de>,
  'Mike Hommey' <mh@glandium.org>,  'Pierre-Emmanuel Patry'
 <pierre-emmanuel.patry@embecosm.com>,  "'D. Ben Knoble'"
 <ben.knoble@gmail.com>,  'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
  'Ezekiel Newren' <ezekielnewren@gmail.com>,  'Josh Steadmon'
 <steadmon@google.com>,  'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
In-Reply-To: <87plc8lmjf.fsf@gentoo.org>
References: <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
	<4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
	<031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
	<CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aK5mJI1NfVQDmDXN@nand.local>
	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
	<xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
	<xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
	<aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
	<87plc8lmjf.fsf@gentoo.org>
Date: Wed, 03 Sep 2025 11:22:01 -0700
Message-ID: <87bjnr5rcm.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sam James <sam@gentoo.org> writes:

> I still think adopting Rust is a compatibility break and a "breaking
> change". Again, keeping in mind that for adopting C99 features (!), the
> Git project used "test balloons" very very recently.
>
>> Nobody else is currently working on the interoperability code and we
>> expressed that we ideally wanted it for Git 3.0.  Being able to use Rust
>> means I can write that code faster, with fewer errors (and hence less
>> debugging time), and better tests.  Otherwise, I'm afraid that it will
>> take longer and we might not have it fully upstream for Git 3.0.
>>
>> We also have this series right now, which we'd have to abandon if we're
>> not going to support Rust right away.  I'd like to retain Ezekiel as a
>> contributor and incorporate Rust, and I think the best time to adopt
>> Rust is now, not at Git 3.0.
>
> I think there's going to be various issues that arise even on platforms
> that support Rust that would make it fitting for Git 3.0, at least for
> the first few releases that incorporate Rust. I'll note that the series
> isn't currently using Meson's Rust integration as QEMU is doing.

Just want to voice my agreement with Sam here.

It seems strange that we have a test balloon for compound literals,
something that GCC has supported since before 2001 [1]. But at the same
time require a platform to support Rust. If a platform has Rust support,
it certainly has a compiler supporting compound literals.

Collin

[1] https://github.com/gcc-mirror/gcc/commit/cedd825f0f18088f7235f02136021bd63a2e12df
