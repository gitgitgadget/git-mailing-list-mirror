Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C81C8605
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757265822; cv=none; b=IgXrkDaarLoGKgAcB6SPOrVB1Ok4/dwdMMINSkDWuzb5hpAxwN7mFqZAm2B1UNVzt1aQAUfpzzd63QzIRPznbIWRONtIv7oArbIGHhtV/zVKs8j8TYErtfeCHAlnUaqGVWRm+JUDf5FfS9jcIufxNq08/8PF45ETz8d6Qq0z+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757265822; c=relaxed/simple;
	bh=inmtY1nGjfPKToT1yPeM2sMH7SiwwHJgOKPR+2Z1hPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OhZ92e4+YHv4+iDX8FfzamC3Bleq5/8covm4g00R3z88sp92KDjTZIVuwQvMYdmwRBQ3Ken2qFL9YG6V89L3GBvW+Y3AMhmR2HnLfiae40vamQYY3WOR2A7gNhVBjIqtRz1X2TsE0xEVg3LoXYa0l1pzMDRY8EzalTzi9X1Amkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZG0xrf0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZG0xrf0"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d60504bf8so35600487b3.2
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757265820; x=1757870620; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inmtY1nGjfPKToT1yPeM2sMH7SiwwHJgOKPR+2Z1hPY=;
        b=EZG0xrf0pEEH39E3eZOYrwZkd5THh2S1lBKzvCw2YBMui/Pxf85ghDAVJfat9Im7Z4
         uozhD1jvhJ+k7+MrHoQR9Mfm3x62CgIDpDhqAASMwiCiTnQo36wMZUpAXkqlGatm/IkM
         5FsnIcqYVX4rwa8G5xl67hee/j0J8/xc4/DCaLwPqWmTxP68gV9W9Q8ReQjpgRqJ6Zd/
         7ueWa4FN+hTNeRIxbAqtcUShkGbtB80Rj9zGRxNSNExvIaK6fyp1gL+3M4m3V34GQUfq
         dHV3RT6LTCL2t+I6MI414AxBoEVAboFX5COPeAVofUZN9TUzYiKFrMECMnkJA60PuRv/
         RmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757265820; x=1757870620;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inmtY1nGjfPKToT1yPeM2sMH7SiwwHJgOKPR+2Z1hPY=;
        b=GDRT8GNxoMJhCWANx+JqPrTePNDG76uVzUB4/DPE+AYem8BBLFb6I27NhhGyny0dlw
         53iX7LOeSXfyuGOCxff5O7QiZguJT8J/HEnfgsdLr6Yf/nj/GI4jNryMVZaPQIInUK3c
         3/r1VAcKslcmyn/wpzSkNzAnvZ+smIVtExjWC8cZ5Q5H+09UzQEas7qdmg4SNOjyhb0U
         iyE/Jm3Cd2yCNt19+xLXHpSCcCeF0vZILI/9p+A23dEUpiTBDvpTBNEPVb1OmtAuUPVk
         lOgX5Nw3/2bd2+2mEU8ZR5sZ8zsQkLUsmtLv6YEAlCAVogqZN9W8lREBuTD30k1rnb8x
         58CA==
X-Forwarded-Encrypted: i=1; AJvYcCX91Y8T7Sx6tV9P63Ft8lJW5QevtmMLF/7mxUDHARCFnpzpJZ7ZPBWf/cTYm9e/kY38e2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYn1OfIMZOGveeiKz2P5Mp4yAZx1jSUxcpqwq4k4KNnc3PKhs2
	i1eUGkCTAK491abGDfBl+g6j4qLE4L6lWes2lkb2Ahgo1QQMTMPgLlLn79dwXxnN2RJdwDdrhx1
	ixn7FzGYZ8RsNQb6PSB3myNwHc63HE3s6yziql6A=
X-Gm-Gg: ASbGncsM7vrZRp+KwYBHe8vAEIkJO0rViZbsScCRVymHhl9flTYo8Gb6aJ6V4kYAxe4
	pbE/2WdfWlP++DnTqX7hnBDZvCm18iKIWNXFz6EjADKvtPuPI1ZOVfy2Hcu3hUoy9gM+0O5H9t3
	FWDhXMpf9jAlkThEtvZ9FXvkRDMVWpMADRZKoWEbKgp8YzMu8OOiMaf4oz12KDYFJ9MjY9Kdif4
	/d2cTKyw2Y17NQb
X-Google-Smtp-Source: AGHT+IH9jIhIPNnYtSGYBTPS97JlfsU5FvFMViHheegJ28kjHFdV9zouzhjdPQVVa3YG0Z08RifNKC9ZjrfmKfkgAIc=
X-Received: by 2002:a05:690c:6912:b0:720:c65:eee0 with SMTP id
 00721157ae682-727f3e78c77mr54555607b3.19.1757265820070; Sun, 07 Sep 2025
 10:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
 <aL2fn4j5uhrVWrDp@fruit.crustytoothpaste.net>
In-Reply-To: <aL2fn4j5uhrVWrDp@fruit.crustytoothpaste.net>
From: Milan Hauth <milahu@gmail.com>
Date: Sun, 7 Sep 2025 19:23:28 +0200
X-Gm-Features: AS18NWChv4hC3GDe1l20L9w1CBHkmoi1VwBRn7XJzLNGj-LZH3M-WEdO3JjRcOM
Message-ID: <CAGiEHCvFnhZRXwNVRyzQ4ABi3p0Opdo8+draXoDu5p1R6HZn1Q@mail.gmail.com>
Subject: Re: Git dumb HTTP protocol should work without update-server-info
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Milan Hauth <milahu@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> HTTP push

im only talking about "read" operations:

git ls-remote
git fetch
git pull
