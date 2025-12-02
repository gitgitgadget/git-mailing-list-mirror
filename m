Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881D2E62D0
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764713168; cv=none; b=RVWX15bSof31WAxTdbPy7XSOhFocTB6vrW54inIYFyC/a2Zo9N9HMV4P5ZtF0PP1m7vyduWHjdAPcXoZnqTcKRq+mJgquVdW8OSeNOEIt404WGgdHXmbCjUv2EUACsl6ANz652aNq0hxTEnvI5PjKS8JbZIiZqbG18TpRu4ZbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764713168; c=relaxed/simple;
	bh=vJkJuF39Q2f6/udTqVs3whhzTA832SDDMbf+0TeGeks=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BBfLDNNTWfhNwlKCXicXEz/85f1h1hurmt0lHQMXjyPS9sfIheIyT0o4DvBw491k8Bhls+3CZFZEPn9NuVWzWixxJ573wEWcVkCtHZgSevhrWRnDP4z3CY7BcFrDRk7ilaErvsWhBTp59VG6B7MRSJrPwTxr+QAcZ4jzbj0FL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9jEMF5s; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9jEMF5s"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34361025290so4950119a91.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 14:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764713164; x=1765317964; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ao79+M+XS1FMbSnBisZY5q12qZFhUB9ORl/B8CIro4=;
        b=l9jEMF5sFidFn8o//1Z7Mn10h5dSUpwqkJaPM6xGmJNGlbUFnW+Q9YmOF/dxoKiJ2K
         IJmPi2XE2ZJ/9j+733awZNLcOYfOqP/nbcYG0tiOFA4wCxi/vOKDyvJh0RKlbMOhoT2U
         FcSSRQlbkbvC0u/B81EEcRao5RYx0LvOQQU+EyBkWpu1BcYKLU+QbtCiPh4bpVI45Q4N
         NO0RYN3f0FR58rjN4eLUnKrUglvI2eXHv8QqRBdrbg0G5mO0tJd31SdOkL4am5ak6QSe
         BPgfMqDdSBnOuzfvimvbOSrHz5IkxearU6NSm0TDongj7k4FQRFAp7usctel5M1Pdoan
         ZSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764713164; x=1765317964;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ao79+M+XS1FMbSnBisZY5q12qZFhUB9ORl/B8CIro4=;
        b=Api9/iSiQqZpEhXRxKdooIYJk/YKJPL3clEQqTI9RZnw202sYDB1MHXk7/OVd+dtm9
         IZMUjlOwm4S8ZuwKwo1tCZWKznoC3TjTCG5V6ycGTTVrtXi1WsNi5KssqTw6vUYW+mXb
         xmBn0MYrx/vcWbRfL6hOxsAQXkaTXLrAdEcNJvI5lDkdtIPV2Ubi+UMg2Ocx1xbTKVIU
         FBiGcV5gN7gZFHLT8Q91hWCdkEX9aUFtLYyl03t/D7WKWwvWge0aZGph0ePcZK6JrGxv
         AeT3Q/rXC/vS1tYEZTt792cYVGpdEY9SOyUYDQ8HM3vXO6xpudRUBoGAL8ERBRFM5IBH
         fu9g==
X-Forwarded-Encrypted: i=1; AJvYcCX8GNygJF9Vt5AweKc9uMAkizKFr4hi3XjwK7nrifJCncOVsi1FBjaUU3ttKmwBGGB1YEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+E0V/m6/Srg/4jpxrQQVNPsJ3PRWchX0DwGM/03yn2TkF2tV
	F5Wg+Pur98zZtclun0vQ998kmvsOkbdYXEAN1gqLqU0/C9mUebc7NgtI
X-Gm-Gg: ASbGncsT/V6iIElQGQ59dfacphqLmbJPn8wcORZfNDUs2iiG9KF1dr4p55EmrXNlJDz
	+ERbPirdPLz8qk35hURx991mT4eicAa5B3KnJ2hSp2Ivs7oK47tWpt08ZRtToMgxS4MCaG2w/Kf
	jJVdihSW4Am75ucygnLZ8FKo6lGTLTCgp95ySBwynTkZqNYJnqa0H3zdB1m5SIIoPTF6nL/0Vzd
	E+9QfPkRRfAESoJAdhv9pJLATEK+jKnjUyRvPefWXQMAIrSX4AF/H0YSTUf3wtL/mx3qldssOak
	SsB7WwYeJIkhu9eRQ9VMmUzfrcB/48W+grmydDDo5o3nb5bT2VHso6xcspl1WYP0mqUmWbuy+6D
	p5DmxgNbV/j8i2BVHSUtzWvndqHMNdr5b/YddM/D5ExlYN+9lAcC9xqCIq50iWpHto0vjvJ9Xtw
	CBqJqeDKrhmItLyZrJ7TSC3VFHWfDKTXD6hGzrYyY7
X-Google-Smtp-Source: AGHT+IG9eAWUVzNDeo6va9X6Ui9HO7oqu3zsY56fvYczKcguTX85qu3+heeP+5WdpJBRwlWQMFPFRg==
X-Received: by 2002:a17:903:1663:b0:298:efa:511f with SMTP id d9443c01a7336-29d683bb5efmr947395ad.39.1764713164053;
        Tue, 02 Dec 2025 14:06:04 -0800 (PST)
Received: from smtpclient.apple ([177.103.85.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be509f4ee3fsm15917620a12.34.2025.12.02.14.06.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Dec 2025 14:06:03 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH] repo: add -z as an alias for --format=nul to
 git-repo-structure
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqsedt8s3g.fsf@gitster.g>
Date: Tue, 2 Dec 2025 19:05:49 -0300
Cc: Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org,
 jltobler@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <D71DC18C-03CF-49A3-8833-DED7E326344B@gmail.com>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
 <xmqqms43aqn2.fsf@gitster.g> <aS1Rvy9J2KjWrQb4@pks.im>
 <xmqqsedt8s3g.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


> I thought the final comment on this was in
> 
> https://lore.kernel.org/git/6186055.lOV4Wx5bFT@cayenne/

Actually, the final comment was [1], after the version where I use
`[--format=...] [-z]`. 

But actually, I don't have a strong opinion on using `| -z` vs using
`[-z]`, since both work here, but if `| -z` looks clearer, I can 
change it in the next version. However, I'll do that for both
repo-info and repo-structure, since --format is parsed by the same
function in both of them.

[1]: <xmqqms7cltak.fsf@gitster.g <mailto:xmqqms7cltak.fsf@gitster.g>>
