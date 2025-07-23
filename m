Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6672626
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288143; cv=none; b=Y9Q5PeTKYHAgmOWIZlmh8HqWndnW9bRcTeTNw3oHIb96KZPkvdBikFMIhmty2mD1XRHA2WIKczfX4p9DlgLVR3nBQiffsTXUW1lI2bP0HCQ0pdwG6KN5lb+zuz/LkKEsJnZJezrF/QCBxe3bH2e4jKO2eF/W235wFzKA08dN35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288143; c=relaxed/simple;
	bh=8f77/Kiy2ECu56MbdFwuMsOVSBrh2jdxp42YqL6Ugmc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pIUDmp5r2OLBCDC4sUlNDNE+Itp9/y+SS0N6bYcvUg27BAlFHKzg4GBSM3dXZcE2iiEt3t0NqOU9jWLFGAuIvkPSBw27y/euAt7sIy/4FexEgGaFYMhKDr8Au5J3HQTKv5qJcUjsGgn8mKy0HsjQ6F/68v5et9+jsf+HLgvzMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BN60iR4W; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN60iR4W"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23602481460so162875ad.0
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753288141; x=1753892941; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f77/Kiy2ECu56MbdFwuMsOVSBrh2jdxp42YqL6Ugmc=;
        b=BN60iR4Wp3fK9inHWr4WPtYN1HqKy/ixRovokAlcnERHxZL6BN5AqcTucOxtI7LexD
         TTZShoWSjJF/D5mvIBhGT9LHnxiH+JdB5qUa1wn0kQqYW7xTfeyBSC4s06btgo+RWqpp
         XTW8lJC+ZivO6jsjROTej9YLh8upt68Rt1IN4/DCU5HMLKrtxnpebKi/rI81sJ1fiVyP
         hDeb8nTiJ0mT1yf7G9YVgIDAOaSeqLawpvKZa0l+lqCOnUeQo08DNNFSe5zLQBfNq9bQ
         FkmYfQZ423oIINOp1spkTJSEB6Qgr4uvCfkVnSr3EZF1jEVxcTA5O0VCoZ9NenKXeFKj
         NYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288141; x=1753892941;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8f77/Kiy2ECu56MbdFwuMsOVSBrh2jdxp42YqL6Ugmc=;
        b=RtFFzOSJWNdFFsN4xOVbccdS3rMkTWviChc5HFb38cnFgPKbWsKiQnpOL4IDqB011g
         RNB+xopOjHZfbl8AFg9P+5K5GktsGRNXiN0ioGx7lwKNU1LUbT7Ht6GIzHSwgifjjg5o
         e8iZ2i/Ihwr0mzQhUfyAp7DVuxZz8g79z8SqKi/2U1JLA9/S2rjZVp7w3YsVVU54ne5k
         bmxMlPuwCg2AMz9ZkK+m0hnYCN3Eja+N6HllBvYiXOsoN9ITtHewezVdk70h2wIE7ZKq
         4zMiwZh7lVwHb0oENz4W/fv0OecFj+86xSSOpWhoYGFK8Wq2f8qptg6y7q93TEivr9jx
         Q2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVg1scWRBhoazQ17k4rFJKP6pzJYuP6m2FWVRPyU4OIZj8qdkQyJcIJwY48FwHzu/LyaW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRwMeQV/1AgjdW6mXMIvn9zbTtm/+jEkFPSWo6MneMjwjdji4
	Hb+HgxwhYTXbGFGn+wGl3EPiJTdbNj47g1dKjTUIqvggQzN/nX5hro3p
X-Gm-Gg: ASbGnct4D3itXaYXUXFhO+6S+Xp0dbJ+nEqAN70b+FX3Bdd8VuRJkUp3k6CnLFXva2S
	cBtvWSRC3vhFRbOKcbWmipurAcUHYyqp21Rczj9osfYgUc7BqCg9uvgYxbuiI1AE1AUwt1LYytd
	aQa9vQu1Mn03y9Rfa/xThOMjep5PnYnJ99CN/xl+OVfAc2+gj89BrqvzFoZhP/RH09v2NZub2Tr
	uGu2DzwZg3A/claTCT+PSE7d7uI6zHdSqBQaRbB3bakshcsWTE2h9NN2j41MgutfJ4Kt3XRn1IU
	mL/TYQM9DQYlU/lisUYFBUZ72EuYy6mgqwUkp+/MPVEmYzHi4N1PvvYcPbOe2NaH+ZaZU0TrcBE
	ZROMVf9F6FeE1B5tdmVf+CNQd+vPWIPuuFFNaS1RfOJBsVsiagkYRNX/f3CFMjQ==
X-Google-Smtp-Source: AGHT+IFGhJQ2V2+DzOLyHhI/sSiunbcWDOYd4Flv2lz79C0LCfmCWyzY8ZC+xu2AAMUUmQ/E6v9MMw==
X-Received: by 2002:a17:902:ef0f:b0:236:9726:7264 with SMTP id d9443c01a7336-23f98161fb3mr49893115ad.5.1753288141330;
        Wed, 23 Jul 2025 09:29:01 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b48e5sm99608955ad.101.2025.07.23.09.28.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 09:29:00 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqtt34tfna.fsf@gitster.g>
Date: Wed, 23 Jul 2025 13:28:47 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 ben.knoble@gmail.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <ABD6739A-EBE1-4228-BDAA-600104726808@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-2-lucasseikioshiro@gmail.com>
 <CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
 <xmqqtt34tfna.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> I also wonder who it helps to use <LF> as a field separator.

Do you mean the <LF> between the field and the value? If so, it was the
format suggested by Phillip [1]. I accepted the suggestion because:

1. It's easy to be parsed
2. It's easy to write (then I could drop the json_write stuff)
3. It's already used by an existing command (git-config)

> Once we require consumers to properly handle <NUL>, it does not make
> it easier to write such a consumer script if the format uses <LF>
> there, does it?

Not much... Since the keys contain only letters and dots, any other
character would work here, but I wanted to be consistent with
something that already exists.

However, to the best of my knowledge, we have several null-terminated
commands (git ls-files -z, git status -z, git ls-tree -z, etc), but
few commands that use LF as a key-value separator (I only remember
git config -z).

> Besides, wouldn't it possible that field may have to contain any
> end-user specified key, including <LF>?

In `repo info`, no. This way, it's safe to parse everything before
the first <LF> as the key and everything between <LF> and <NUL> as
the value.

The value may contain a <LF>, however, the first <LF> would still
be the separator.

Thanks!

[1] =
https://lore.kernel.org/git/223c7cbd-610e-49e2-90e2-5914cbc0f1d7@gmail.com=
/=
