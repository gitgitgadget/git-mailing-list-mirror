Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBE31AF1F
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967851; cv=none; b=sb4UzbegI5z8LbY/pCfuFQcOr0sBlP+0LsQD3Xj8e6CMCzEeZaMB2p5ilKIxRvjTf/MOqueXZ9VlNKB+eneSrajmdUrqQQfN9opocnsT8HI3Gn2bevdAltUHttJCEhEItzMWFmIVWn8h0ClEZScQKgKOFvDGG87AGOwUG30nx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967851; c=relaxed/simple;
	bh=ga1XY20p+fT5SiBmbt+VjePyJ6x0wxevHzhcCGRBCLg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=N7iUTHNis5DAjJblQiQcdfS3XO6jO4tTNQrduvuqrummKktONm9h0t0xCNIEFHWGa8N65Q78Os/Ziww+HaAHXh7QMg6K3FA7VQF0cNCmG7EmcM4jPGLZaWw30N3vCsrbsqfFr+QyOxuMVB3GYfeYbhjX4+xY8zSkNnUcFJTVs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7VbKT8b; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7VbKT8b"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-784826b75a4so21211817b3.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760967846; x=1761572646; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ga1XY20p+fT5SiBmbt+VjePyJ6x0wxevHzhcCGRBCLg=;
        b=J7VbKT8bYYyHeo3bEyJngVAuFfYof/rSFuOn6O0ALpsU8mmUUeYt8w2QyPI0I6J1kK
         b+73AxaY1uNpdoWzaPd2nVWVI6uOA4NGXjgkCmZrY95YNlkqGNGMCw6Ia/hzO9HdC8hC
         x8dGE/BJ/8Xtk5ECHagQJMvFLj2oVpRlMyB/1D5ZBtWetd3HEwZ9sxUWrfDlajphcE9a
         0ww6ETGQTgs+OOx5v4/vesUamB4gIv6cEQvWq/ZCChvvgOpNo8aSzzzEhYlIpq6Bn+N9
         iJhg5KCgVd/feWiG5+y6G8a8f13SY9uYu2GFuv4C2vgWD2TOqrIdfhcoItmX/jQ++/ll
         aFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760967846; x=1761572646;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ga1XY20p+fT5SiBmbt+VjePyJ6x0wxevHzhcCGRBCLg=;
        b=W79KbNSg4OxiaYr5E87mDJudsFRs2uC6ita7O77hWecYk/PbBRKbxCGcSkEtXY5jPN
         qhq9j5/A3ezBEc2drPlvdI+DMW6DxPp3hS+M5SjQcKWB8YOoqbRYzjvMBt9q4DDGeCMf
         N9wGe7QPik3dk9zVWSC6+ipRB2v1yVD/oNa1qRB3PLp6n1+p0gW9U/HusWrgPLAHXShT
         DPYb6FCfdk5DsmNLg96zThKAkrOwK7N/j7+PBEDrA8oCT2d1yOTK53DDcD9en8QXjLgv
         6eLpgrLBR264xVt5fMkz0kKxaULlgEHMlJD3eqMuz0WqLtlamMzmCIUhcyDIiX1+Shga
         uL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmxTAHtFH/AWGm2mCfmnK0Urg1hEFKrxSYFMEjOruS3u2l5tBZnZIQK131GM2xzIrwAYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZ7x84ZZlVAbXdaXFgdb/HTqcZp54rNlyADVuJWT4sH/AF//P
	XoykqJcXNhKQvv6l4AsbWueIEof23s9hHNaO0VkvmO6v/6jUVJ5RKfXC
X-Gm-Gg: ASbGncuhK54Fm/B8rFXxAv/0MQK+NpLXMOHpLHgOxdePx8kVRFgtWnw0jQC5YPqxB/B
	pIxEXRptB/Dm/ZfbynmtzXW8WuHxtMFLM4g96AGaTc6LOcjv6U9wd3tusjLD1kMBMj9Iqd6f8vT
	aOqdSHr5mDUytKfhewjKFGfdvxaIMpOPMn4/0vfJMQ9yjFDxbZc/YRKdyF5yDgrl/jAd9E+9FgT
	PoVie7uaB8GWtn0kuWjbLTyX/p9E1gCQ+P4Dr9KUnbkDL97EjK3Bebp2Hghu0Xn0nYb4p6cOLAe
	zrvY7AwitRZfjupf2F97ax4CehvJzP2ULI5WBqDcmWKu8KqhYOx67QcCLUPRGC2gaz6Cckwfhrl
	lPjNG63YSqaEDWc63B47WDhZDkxHpU7vD6P5eoUtiCeqZfC3j2h0l2FGd6iRaSNk8ln8KofD7tP
	HNLXdPJXjNOr40PNrA56RFbxgIUezbAWn6LBtFtygzqf3Y3WIQ8Q==
X-Google-Smtp-Source: AGHT+IF7L/aAcXkXIWbszch/JSKTX1HLyseyQz/kqDw+xIhU42AzEVC5JDK/SQvHDb460MWxJyBkhg==
X-Received: by 2002:a05:690c:6010:b0:720:bb3:ec14 with SMTP id 00721157ae682-7836d226ffemr127345437b3.25.1760967846215;
        Mon, 20 Oct 2025 06:44:06 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:b8e0:19d9:4bc8:fca2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7846a6c70easm21373917b3.59.2025.10.20.06.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:44:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] t7500: fix tests with absolute path following ":(optional)" on Windows
Date: Mon, 20 Oct 2025 09:43:55 -0400
Message-Id: <A563E028-19E7-48A0-B538-82ACE821DB67@gmail.com>
References: <6a83c7d1-7cd4-432e-a0ab-7b18ce3af08d@kdbg.org>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Noah Pendleton <noah.pendleton@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Thranur Andul <thranur@gmail.com>,
 Michael Grosser <grosser.michael@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
In-Reply-To: <6a83c7d1-7cd4-432e-a0ab-7b18ce3af08d@kdbg.org>
To: Johannes Sixt <j6t@kdbg.org>
X-Mailer: iPhone Mail (21F90)


> Le 20 oct. 2025 =C3=A0 05:40, Johannes Sixt <j6t@kdbg.org> a =C3=A9crit :
>=20
> =EF=BB=BFOn Windows, the MSYS layer translates absolute path names generat=
ed by
> a shell script from the POSIX style /c/dir/file to the Windows style
> C:/dir/file form that is understood by git.exe. This happens only when
> the absolute path stands on its own as a program argument or a value of
> an environment variable.
>=20
> The earlier commits 749d6d166d (config: values of pathname type can be
> prefixed with :(optional), 2025-09-28) and ccfcaf399f (parseopt: values
> of pathname type can be prefixed with :(optional), 2025-09-28) added
> test cases where ":(optional)" is inserted before an absolute path.
> $PWD is used to construct the absolute paths, which gives the POSIX
> form, and the result is ":(optional)/c/dir/template". Such command line
> arguments are no longer recognized as absolute paths and do not undergo
> translation.
>=20
> Existing test cases that expect that the specified file does not exist
> are not incorrect (after all, git.exe will not find /c/dir/template).
> Yet, they are conceptually incorrect. That the use of $PWD is erroneous
> is revealed by a test case that expects that the optional file exists.
> Since no such test case is present, add one. Use "$(pwd)" to generate
> the absolute paths, so that the command line arguments become
> ":(optional)C:/dir/template".

Thanks! I probably assumed there was no meaningful difference between the va=
lue of PWD and what pwd computes, so (prematurely) optimized for a lookup ov=
er executing a command.

Going forward I will probably stick with using pwd, given the difference in p=
latform behavior.

Is there a doc or test lint for that? If not, might be useful.=
