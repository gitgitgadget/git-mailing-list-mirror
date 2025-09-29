Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2B523A
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164186; cv=none; b=OsPxi8ZY1CGgDCXUrSBCDQNqGlS6cjmzdYwRLLJMCmTmcAFuVSjiBeUU6Gskuv6LjWEZLs1wdfkZKqU30Vk+8LzMx0dUAPmKKLQRxMbeh4bUKdHxUsEHN8g77aKCQjK/OHFFL2mGP7x2CKY7ZRSKwCoU+LhB1Uj6WA9foOdZIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164186; c=relaxed/simple;
	bh=ImsYA461pqCkfporsscGmaTwFGCyc4Ot9DyGaQfHXQA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=NsY02pp1R/ENVcWj7AiyfmtvGeiC/u9L9mMFG+7l4s0kaFqjfUnBff2XFIFHgt6JJbm8ty0hA8dZDbPSKoSnHASVU+HIIgnPQ+bxBX7+NDfpOcgU4oxFlOzznCCw5/TROs/QEa3S1Gdj0M3hrp8hFiqwQyxOdAztCnc+SNItJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nldhUBaV; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nldhUBaV"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63497c2a27dso5092189d50.1
        for <git@vger.kernel.org>; Mon, 29 Sep 2025 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759164184; x=1759768984; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZVz2kQp5q7FVImxOPokSK0yByyrvjlFrDszF8DzfMo=;
        b=nldhUBaVXWHoTSZhyLyNOBzuLm23+N9RZLhcN8NT0MOpgkG7YA1sDmWYkbLLuBQbmy
         k7iMDg+uhkKqniYMbiXfGvsKA/X5iTefwjd2VTFkDZcUcnMlUrA3EwN8tJvf4iRmM4QM
         6ZRIQyKsNZ+khDYycrT5sxbHdJm2KhkJ6Hw6NTu9Y+EDwFt6ZVEPRKPTTuloXr54uWM1
         7lGjFcLJxSFIYWjDapTrVrRxuXMmu8LDAkm25+mG1MN3nkHNUX+7/uRcFg+HuHctDwQs
         8t4avK7L+R7d3RaxmsGxp1oQUAFyskw0egOWjvN2OEXa+SKAsDfviTd7Lu5FsaPkmtqZ
         4rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759164184; x=1759768984;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZVz2kQp5q7FVImxOPokSK0yByyrvjlFrDszF8DzfMo=;
        b=KwbSV+RjA5ar3cZnPqMQQujJlvoS7QYGALTYao+v+TPUwwXOHKm7vAcwcTB7oXjCTi
         NJJV7geLGJvDac3e8gZPWiB7ml6U1OaaVPRv9jJJM/KE2/yPea4O2uHlw7trlfskLiq6
         uC+MSEvw4FzaJbxP6/Y/IsBEe1cTlal8AZ9ThyCJqQGP0ocgggWqbxyp2vOfk1R4KBg6
         lG0l90VhGRgJZr4Y/IBzU93+C3B+QlQVqquhtpF5MiXlylcKZnYz5XUhNjKy5pLXwWy/
         TdamDa/3wIxZnOihhcHzpqgWuE5hJsHI9uhUM2r9CxB/vIiL0Mu39OmGwBYhL4GrQWyF
         NtoA==
X-Forwarded-Encrypted: i=1; AJvYcCXR6nWtnxWDJpzRMJgtmQRWqXx3qiRxYCLva0XtYYHJ8ci4WL5xzmFgw38Gsi7327ifeAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxADKbP/OG2669FfRkvKVFZ1EdjggjbfcNP37EEBbY9PXVRu2BI
	T5yCRDZuvTFK948VvUAH2/KB3CMbZ7lmbHFMpaz+G4/bFI721nFwPoYka77Sg3/2
X-Gm-Gg: ASbGncvfU2u57ouoQByKJrqTOND3UZksSDTfn1Cu1K18NS7tMK4PULILKUuAPT3ppVr
	cCNAaNFkJjc815R9wqWlv3nuS3Tus7/MbiOmlVl6yeaoUI05P//UZwJp72AwBPWjPwpCJbqgdER
	+d5bYzXrVVQK2Hwlbj/cBtwkk1tg5mND9juy9rgZXcc/JGupL88/MB4+OKwu0ALbp4DQ8g73QTp
	6Xl8kCCbLfr8Nxj1IOzkRzsd/GM9FpdI1/WGLL+yS5trz3gRDkg2reXZIPshd/1TzUIh2FfMB5w
	XuyyxO4pq1Zt1qn140ri9TLO2wEFKOz+ewPKTOwSCmLiQ9/LdsQUsbfu0ktP/b9X3vKI5FmUQEB
	PRbmRI9RRodpWKVK9apDz0AY+Y4nLnhJwCgWwLjO21yx9kqUva8i+E4AInBtGdA==
X-Google-Smtp-Source: AGHT+IEp5yp+/5Kp+2BKNa/+aGCDlS2i50nZNr71hze2Zkpefly7FM0v2R9a+FQ0uChJRAg7jS65Eg==
X-Received: by 2002:a53:e004:0:b0:62a:2327:9feb with SMTP id 956f58d0204a3-6361a83d903mr13457078d50.34.1759164184057;
        Mon, 29 Sep 2025 09:43:04 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:e8c8:f46d:5858:5703])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765be19ade9sm29906007b3.27.2025.09.29.09.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 09:43:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/3] Support :(optional) filepaths
Date: Mon, 29 Sep 2025 12:42:53 -0400
Message-Id: <6646024D-319D-47D9-805A-CEB3A620E4BC@gmail.com>
References: <xmqqh5wm5hgu.fsf@gitster.g>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Noah Pendleton <noah.pendleton@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Thranur Andul <thranur@gmail.com>,
 Michael Grosser <grosser.michael@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <xmqqh5wm5hgu.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 28 sept. 2025 =C3=A0 18:40, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>=20
> Before "notes" you would want an overall description of what the
> topic is for those who no longer remember the previous iteration,
> or for those this iteration is the first one they see.

Agreed, thanks.

>> - I'm least sure of the 3rd patch and am happy to drop it in support of
>>  the first 2. I think it might be better to (a) integrate :(optional)
>>  support as pathspec magic and (b) use pathspec magic in parse-options
>>  when getting filenames. But I'm not sure, and this has other
>>  ramifications I'm not prepared to deal with. (For example: `git grep
>>  path <file>=E2=80=A6 :(optional)non-existent` could pretend like
>>  `non-existent` was never given?)
>=20
> While it might not hurt, I do not see a need for such a support.
>=20
> Pathspec _is_ a pattern.  If an existing path does not match the
> pattern, there is no ill effect.  In other words, in this command
> invocation:
>=20
>    $ git grep -e needle -- Makefile no-such-file.txt
>=20
> neither Makefile or no-such-file.txt is required nor optional.  If
> there are paths that match these two "patterns" among the paths in
> the working tree that are known to the index, the contents of these
> paths are inspected by the command.  If no paths match the patterns,
> that is fine as well.
>=20
> The command line parser helpfully offers to notice a pathspec
> pattern that did not match any path when you do not give "--", but
> that is up to the caller of match_pathspec() API to do so.  The
> pathspec machinery only reports if each pathspec element matched a
> path in its seen[] array, and the caller can use that information to
> report which pathspec elements did not contribute to finding the set
> of paths to work on.

I must have been thinking of the case without --, which triggers the usual a=
mbiguity error. Either way, for now, I think a smaller feature is better :)

> Will queue.  Thanks for resurrecting the topic.

Thanks!=
