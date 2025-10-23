Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A786340
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761257006; cv=none; b=FoQq5ypo/7L4tiyJMVIzbYwOyGsimyHXbiJAMk4ndnB7/LoZRJxhVKYn+BHWhs1MljQ2LxDtVvU7oKcP24jMykUSiAOIjofd+P8fOHfjGke5T5XxdaQky3huqORY5slGhdQh0T3QbvmE4XbhymE+VzDqmhE6vZ0wmBvTvHpezzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761257006; c=relaxed/simple;
	bh=HtXBpVTMLk2C/R9wV6VKBihlVP4bE2F2NL2MjLzs1P4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=L8f6N9iAn9u8gSvW4J8qodTLOMsy0znz43KJB+S8qOuaL3QSWUj/er94zLn6fIVthuHZk7zEhfkEH0cTAFwbJGtDiiWs2tiLdVur4rY01fq6ckxHwvoRQRoBhc9Q1iGkmAR2wRPHTkCjdVb9poM5tpvwlgbPDLk6RRpcfF2ki2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/5fYPP/; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/5fYPP/"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78378cb66d6so11677357b3.2
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761257003; x=1761861803; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFXAkk8fqG8yieV2Xz5X83J4d90xwNRM4la9nHv9AlA=;
        b=h/5fYPP/yqCWcK/a0wt2OG9DNJ0jTn31Vn9FWYX26+s3aMC98SQIB7HI+uCmVNkllc
         d+qRr1OXBGRff7BTKa3hx9FX4XIXy1/TG2WIA1IJfgdJAFTHXIF4FHSyqbCQxxEbLJoA
         PHMdzs4oUao5CjMN9jUHk4Cp8bD7XHRUfafQxQk7d6o5uzvUZ/SlCcbhLChOwpHMO4o5
         hEypmz4lwk/TIlaEVJ7DhHgCcvHdykrhdAVG+pS/Fmh55mxAo/e1tW3qaqwyxs7eSuMD
         bowMbccA/AcDLY5/WVEVAd+/v+sC9m9I8C80MhKLT71jmFiYSUpjUu2BTcnaaXkXiYZl
         D+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761257003; x=1761861803;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFXAkk8fqG8yieV2Xz5X83J4d90xwNRM4la9nHv9AlA=;
        b=CyUC0X5CO1bV/b1DWw1kikTmqUZHvM6jRt9ACSAo9VUNevGFj/09vJzmOAIo3/liLw
         p8TDKMoRRS8Tnqr55OH4Kg/k4ZgbcPF1CPEO6SBabOw6SduGfW2v9+Wf1Zy24U7wZTYa
         g6kNe71aerEu8KLRKfcOZyUGQwdiKFaKdWzLtHr+URg02GdVsKIZ769B1uLj5E+9iEX4
         LWY8XELhE96SY29vR4aIyEXQQHXyARD0Qw0qSUzRa0rOYsx3mcydu5DLvV3KRcU0O+mS
         2tpal+NVBHvXbeGqv8HjX0CFlHLtqjVNbO58Db33/3w3zf9Z2KvkilACABBPekufJ959
         KPyA==
X-Forwarded-Encrypted: i=1; AJvYcCU+r+yY618h0dWw6rsjHclxYa9E71IciPBWZvxcxSlaMmNNYmJz/ApFDdFILhj6NkoFbWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOkQMHUW9OlTlj6SDtrhO3T7jX4fTi13zCJV5fM7Widw6tP1ji
	x1JCBPQEXQu1f8Q1xI78WLQ5TgxYdLW2NXIyyYFnRC9RiyfrWEYetofVTQDhTnsH
X-Gm-Gg: ASbGnct1CC69GY5NqvD1vCS4DsGMAUuCothZKtNEep30SialJz23KVano7KPKX08Yud
	xAxiu5AfxIXXJKgYgCFSUsvrvuZXz4+VKyfNduc+9gb8siKREypo2VOL75VuueUl3dlm2loEzo9
	gLzRl7zBqnvfUMabJD3lV8A432TlwXUANgqGdDL/4XuhPDS3aZQZ6V0I4J5dTXmYrv53fldOLdh
	jPExo0luBTjOSOHriSxL7rtGg24XazGhfU2pBVQLCgTRbfS5Re83PvWyeypnmdw938PHPg8+Tq0
	cAPW2AsFkqfbvioKkS1Rwk1oXwPzeEfzBBjNPAwJ67QibzwNxZQp7l4DkcUxRvaam4oIsFByRmZ
	iitPmG5bAtutbu8R9lXPHIUuKF/pIhS1IIbkNGgpN1cEvlOHcAJzHeflVlKCMrpmO6gCsfk3elE
	TYLlyrn7RC8mQV6KKo9Z0K71l5HxlP3kF9Mg==
X-Google-Smtp-Source: AGHT+IGhDlYoKg+q76bwaLBENsjHyU7ZNhOLFciJvBrdl/LbWyET8Ub9UKSJQ+bexdw/l++H4brAvQ==
X-Received: by 2002:a53:d251:0:b0:63c:f5a7:401 with SMTP id 956f58d0204a3-63e16215840mr15131850d50.69.1761257003518;
        Thu, 23 Oct 2025 15:03:23 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:e533:8431:ab8d:e62d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f37a36164sm1008771d50.19.2025.10.23.15.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 15:03:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
Date: Thu, 23 Oct 2025 18:03:11 -0400
Message-Id: <EFDCC7CA-EA06-4149-AD2F-5CE4DF336E1E@gmail.com>
References: <xmqqtszptnco.fsf@gitster.g>
Cc: Johannes Sixt <j6t@kdbg.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
In-Reply-To: <xmqqtszptnco.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)



> Le 23 oct. 2025 =C3=A0 15:44, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble@gmail.com> writes:
>=20
>> Was this intended as "another todo list item to work on"? If so, I'm
>> afraid I'm having trouble decoding what the issue that needs fixed is.
>> My nth re-read suggests that the sharp edge here is "delete/modify
>> conflicts often need re-resolution favoring delete" and that doing so
>> is not easy today?
>=20
> It meant to add to the list another sharp-edge, which is that
> 'rerere' does not even attempt to help you deal with delete-modify
> conflicts at all.  Either it needs to be communicated better that
> the users are on their own with delete-modify conflicts, or a good
> support needs to be designed and documented.

Thanks!
