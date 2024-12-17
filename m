Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272F1482E7
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449052; cv=none; b=o/RmK7Oes4+7tJi8PBB0u6M2Ox8Aqzu0nFdq0rOiIsykhI/RkvDT1spvN6pONBTHrZp8c2U7zXLzXvjH0A+L/uzl/g1wmDiLMo2yrjCA+jH4O04rGYMETqYfQKSToAki8QavgIXz6mUlxzOkBuDTCLW5Q6qg5G0je7sydvAP51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449052; c=relaxed/simple;
	bh=KKBJBMlbiVfobnmjMDpVxPbgEWYXc+3jSYOJDATFatI=;
	h=MIME-Version:From:To:Cc:In-Reply-To:Subject:Message-ID:Date:
	 Content-Type; b=Kp0M66GwemJalDaAXODUxpP9qWDz5HM8Ys+AcytIl2Y7h8aL9KhjZrsbYJaczYvKyfLOow8VC75xkj8goSerTCs3jOxe79XWOUPZDuxqQJkPCtopLiZDQjeZ5nLx0HK9+DX3SJloASOEBIe5InyqRltP9xQhH6GoG2HuWcXxHAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9XlGSAA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9XlGSAA"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2156e078563so41221635ad.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734449050; x=1735053850; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KKBJBMlbiVfobnmjMDpVxPbgEWYXc+3jSYOJDATFatI=;
        b=V9XlGSAATeH5Wfz6VcZV2yD1//O+py8IyJJ+pW+g5PsgRgO79GyOLYE7Oob6iEgugZ
         kBjjUUCVdqXsrPa2m1KDEPGsQZUZvm6QnMTvdnYEUTLfQALWBKNpGAjrEPkNNtAMvLPw
         HT0sAueMn0CdDAlpqyZV/UahX9SXw+RAqSRWpH2vzF2HYvN5c+iJrzSHWRE37qJnADJi
         rM3LL6Qy7hO3JmgqQB1i0Fl1/5iOvnnUbkVpfe3Hbw0FE0vtLlHkhYn2Zyu4Hip6rqXK
         bWpB3LOEjpjz8ajWTsaWLRd7or2q9vz0tezM8LEwlmS6d9cRfxu5n6LGgb5jJ9iju3ZH
         722w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734449050; x=1735053850;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKBJBMlbiVfobnmjMDpVxPbgEWYXc+3jSYOJDATFatI=;
        b=T8c6+rQ2fsH2t6n8eNeoryxl+mGKH9XMO0DJRLzMpdj7VyWN+K9ZWUQObdWWi25+GL
         9D/ss/jlp01kMlTQJKTsB6nlJ8Dr6xP+OgiHd8n0I+kEPWu0jparUpT/4RWf0qseqWaU
         IU9Rtis/Sq8/rUadxxrMLbGaXLLLju0fSSP0vLs/lWQCtOxNgxgCTYaFjiVYhz3ZpoJx
         gs4JwNqSEwHnsbkgKyxk0l+m94kiJt1Y+j9addGuvpm2Swm/YOwzqjJdauvv06wtPnmp
         bHGUDnIs1/GhXOyybV4PJsv9qKE3mjswGuNUDdbccwWu7DA39ftohq8ZF/t+rxQtmzms
         STzw==
X-Gm-Message-State: AOJu0YzQLkTrlQYukfC1nJL6ORl2NHaTOg2UonI5JJkGgQu6FVOxVMMk
	EvNbyVuskMCQL/Z9772/TGKBQFjm8gcoCaU93iizWnPMFuqLyBfVBP+l5Tj/
X-Gm-Gg: ASbGncure5kPqnWPUAAN/g1yL8feVaq/UFDVnuC7+lAwuyCZzKP1fjX3s8ZO0+91qRh
	Vf8f5F5cRwHbtwygop3TckorlZPL0I5Y1PW9l89A8dVT0fAuQMrwpC4aShSqcmY+ieilcbu8p0Q
	lLkfGP/1ajxmP/m8As4xRG8bxJsE2NxfDOAa59i/URiUDZy8Ktw9TaETJ2F8HJT1kChGbXu5VUz
	yNtYVb8Mw++K0cWdC2N0wX97XzqsfPutnaK7ZfO/GucLcVClKgallaK5b30mkgxQ+gqwU9ZJRUU
	9wcefQ==
X-Google-Smtp-Source: AGHT+IG82C/wde4jcnvMUTCnXl8Z7LOfBj33ti6kiFPgYxrFfhiOW3I5gTKC8hc4Jo61HLCixRnVWA==
X-Received: by 2002:a17:903:247:b0:216:2dc5:2310 with SMTP id d9443c01a7336-21892a692c3mr269259415ad.48.1734449050332;
        Tue, 17 Dec 2024 07:24:10 -0800 (PST)
Received: from host (36-230-86-110.dynamic-ip.hinet.net. [36.230.86.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5d7c5sm60583545ad.199.2024.12.17.07.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 07:24:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Wang Bing-hua" <louiswpf@gmail.com>
To: "shejialuo" <shejialuo@gmail.com>, 
	"Wang Bing-hua via GitGitGadget" <gitgitgadget@gmail.com>
Cc: <git@vger.kernel.org>
In-Reply-To: <Z2F7VAsTjfBCVCrG@ArchLinux>
Subject: Re: [PATCH] remote: align --verbose output with spaces
Message-ID: <1812003825ec9aea.c3843a5641fc0dd3.ac43970f069a1446@host>
Date: Tue, 17 Dec 2024 15:24:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 17/12/2024 21:23, shejialuo wrote:
>=20
> Good enhancement.
>=20

Thank you.

>=20
> Nit: we should use "size_t" to declare/define loop variable `i`
> because the type of `list-nr` is `size_t`.
>=20
> Recently, Patrick has provided a patch to start warn unsigned value
> compared with signed value in [1] which has not been merged into the
> master.
>=20
> [1] https://lore.kernel.org/git/20241206-pks-sign-compare-v4-0-0344c6dfb21=
9@pks.im
>=20

>=20
> So, here we traverse the list to find the max "utf8_strwidth". However,
> we should not EXPLICITLY traverse the string list. There are two ways
> you could do:
>=20
> 1. Use the helper macro "for_each_string_list_item" in "string-list.h"
> to do above.
> 2. Use the helper function "for_each_string_list" in "string-list.c" to
> do above.
>=20

>=20
> So, here we call `calc_maxwidth` in the loop. That does not make sense.
> We should not call this function when we are traversing the string list.
> I think we should firstly calculate the max width outside of the loop.
>=20

Thank you for the detailed comments. It really helps.
I will address these issues in v2.

