Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AAC1B14E8
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645486; cv=none; b=ttEsQIQcD48Av2Z4/Ufp4wFLM05Tkwky5YJDk9W7DYoyLeRBKELkKhWEqHAFU83hI+a89UxlQPpjiS6r1nH2hMFJeEsKDUGiBqVB6Q2ToFn2xcvKpw+3v8jbyCuY/+PypgsxDhvA/e6E/9CpqTdiewgfYayf0tIGHAFr3wEgu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645486; c=relaxed/simple;
	bh=zLOGn+VIAEc8/cuDewO/zqEFpsXSexW3t6ps2X+P2ls=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KynscDT3PR+oelKc15nuhuIUscWV5E8MnDJg3M88MN6ojjrVCsv5eq5hEvMh72AQF+ZVRrKbr/Vn7vxVlLMy0MRvkv0ANO/Sf0hCFzo9OY3hF2NUwJtvcJgdFY5Zi5Z0t0SYdJIAmSESF/8XU3Sx8hagtPowzsWnQvvVsAVUREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDDtD4FV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDDtD4FV"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd640a6454so53016035ad.3
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723645485; x=1724250285; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLOGn+VIAEc8/cuDewO/zqEFpsXSexW3t6ps2X+P2ls=;
        b=XDDtD4FVpkVB7cxkv+cCP9ToSknhA00akFnjtmc2D2Id3o8I2HpW3YkKwdC7DF1TXZ
         Hq7u7gzO/e5ZMyj1r6J5+aegfbJ/uQNH4NB6wLcUqGOStoVM2X3zcEs3UqZETCst1+1N
         OBCRwYVz5OzDqdcM0jvcNIjCyPdwKUznkeD5/+Rxfnz+THslxNGU/LShMOATQy52GXGX
         NgJLru+It+vnY9k6D13FiJWidNHEMr4vFfYzaZyrbZjjHHbn4x6QiurrJy2t/mBRpbai
         LCEgdVP7bvAqfXNBz2a10o4aoGW8tvQnWa2wh0v2oOtxFwevENxphFwQH4/NAywd+Gwj
         4NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723645485; x=1724250285;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zLOGn+VIAEc8/cuDewO/zqEFpsXSexW3t6ps2X+P2ls=;
        b=ijyuGwr4sgyHbVR7wGETWUwMwcXUAoo2TIti6BxphJWuEMbuA9WEUV6W1Dxnfm+3Ez
         P3qMBZOW0DGri6VFqa/IFjuyqRh8V5BS7dQbzioZ0KkuvoONFo2ZrYNAaaktrO7oblri
         AynlmYwLY0iv/ya+UiWTggC9Rzm4Ghvh2Lk72gsBEE57OG6Hnk46JdyftzAUeYlwaWtj
         Fty0doCnA9pJxpqXcMxi7Tvtkzql18AUOBBXrecxC6z1jMZE3lnE6XqDENnTT8SJdA0q
         AFwtCnArxt2LFzIGc/BBUi4huE2uJnaOR6vDmIQImyVze2Nq3sZKYRvr0UIKSoPybTsw
         +/lw==
X-Gm-Message-State: AOJu0Yz+sdMg5WA8K2ttf+7IgPiWT7w6tB4gKHnfOPpmDcNr/MsOZoeO
	/havb+Ogs5WQyznoMP3p5aMcI9JqyISKBNMGVYa2qTdeFfN3Yawt
X-Google-Smtp-Source: AGHT+IHKyq0sNkj1vLe7E6q8pVxxZ0t6xJf+T4Fnuy8whKWCA+nIpvvuurbQXTtaCnMlclqAw5lZJQ==
X-Received: by 2002:a17:902:e850:b0:1fa:1dd8:947a with SMTP id d9443c01a7336-201d648ce5bmr33195965ad.46.1723645484533;
        Wed, 14 Aug 2024 07:24:44 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14ae84sm30353435ad.111.2024.08.14.07.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 07:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Aug 2024 19:54:38 +0530
Message-Id: <D3FPBTED647O.7JKO1P410ZEE@gmail.com>
Cc: <git@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>, "Karthik Nayak"
 <karthik.188@gmail.com>, "Phillip Wood" <phillip.wood123@gmail.com>,
 "Christian Couder" <christian.couder@gmail.com>, "Christian Couder"
 <chriscool@tuxfamily.org>, "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: migrate t0110-urlmatch-normalization to the
 new framework
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
 <20240813172432.55487-1-shyamthakkar001@gmail.com>
 <xmqqh6bo448j.fsf@gitster.g>
In-Reply-To: <xmqqh6bo448j.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> > With the addition of this unit test, we impose a new restriction of
> > running the unit tests from either 't/' or 't/unit-tests/bin/'
> > directories. This is to construct the path to files which contain some
> > input urls under the 't/t-urlmatch-normalization' directory. This
> > restriction is similar to one we have for end-to-end tests, where they
> > can be ran from only 't/'.
> >
> > Addition of 't/unit-tests/bin/' is to allow
> > for running individual tests which is not currently possible via any
> > 'make' targets and also 'unit-tests-test-tool' target is also ran from
> > the 't/unit-tests/bin' directory.
>
> Sorry, but I do not quite follow. The above makes it sound as if
> the 'bin' subdirectory is something that never existed before this
> patch and this patch introduces the use of that directory, but that
> is hardly the case. What does that "Addition of" really refer to?
>
> Do you mean "we cannot run the tests from arbitrary places, and we
> allow them to be run from t/, just like the normal tests" followed
> by "in addition, we also allow them to be run from t/unit-tests/bin
> directory because ..."?

Yes, I meant that. I sent a v3 which embeds those URLs from files into
the code itself, which should not require such restriction.

Link: https://lore.kernel.org/git/20240814142057.94671-1-shyamthakkar001@gm=
ail.com/

Thanks.

