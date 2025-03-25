Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E919AA56
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927713; cv=none; b=hDsQr4jc7pJ/Z6EoUP809xl3hHzx3/W3oqrQVYCltSNkW7TQHD9/n3HCCr8PLzAeculU6doPB+BgsZ71nRvGfldEHmWAhGMy4F3Mb10JUcELiZr4Jb+L84PB0I9+fHDRkK1IvI9LHJEfq0VilR7UIkRiv7vXNiEbuNlF9+pm1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927713; c=relaxed/simple;
	bh=7Lk3fE4/CDuhAqEGyecgSVgQ8OscmyhAzOcfcuzuUrY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ll+ZZQjyrdltXJQZ0XRth1zKV7yMRFOzLruMcNWo+b6a696UASP3qlfCv255bp3x2k7yNq1sybKmX7nWAGKKo4dgR8KePGLsDnWdi0HgJOMJak/1ms4IvapyqFfJFHI1shw7uDZ9Q+Q0d+TDKkC+nihORlgwugbuGJ4ftH93mLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzLnIc4I; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzLnIc4I"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227aaa82fafso66973415ad.2
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742927711; x=1743532511; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmcl1oMLqk4fj5kjoQV4u2AFpfLXsfd80C4fFbAGQH4=;
        b=NzLnIc4INwIMbuoZOEkw86h1oRQB4xMN+peYZ0MTMDZAT/o14r9y/WJDfPZZEDpI3a
         EQb9yYXGcKeqNFKgrklvIbIYR54gQ9NzwKHrqk9xersPWFCgjTpRKXmhdbDncpGm/nmb
         3RnD116Xz05nJpjGtkNY6UIvcn3qsZXWkudc9YWKhONBgva+e+ZNmNM36SWl2Q/KTaZF
         YEdmZc5KHeZDWOo/EIGNTv8IDdd8hA3MNuqtX8E2ZDOYGe8IfvxxcePgufxyuNFtt1gd
         /2+aNkz08Hk+43+4OAd9hV3VbuSsDtoid+A64ecdh0Voevg/arHOZOn8JAh8VH8c2Hwg
         O6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927711; x=1743532511;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmcl1oMLqk4fj5kjoQV4u2AFpfLXsfd80C4fFbAGQH4=;
        b=bs5OvMpcU4kMmMUJz2URsB7hvI//575WREZv0CYQXPYZ6r/zdUn0PFZkoE/SwrQne3
         eCcZ5bh5VfP/VE8KygAsExuKqxAWHswGSNx3dMD4EYzM9Ies3qTpX9yKOZu4do5Utq/n
         kz5DpkREyvxMUDlRMZuCZxWcsT9jqjmouOGzcn+u/4mle6Bzx/75EHW/cGszqFnkfzsm
         1upjo2GOLQVbImgh+H/yyJ4OM28F2bFcZUULneOwQndjNZFhlLpPRTmQzNGwkLSevAIq
         +fnrnuJ5a2Fn/PIqhxfFijupi2/WrAwHsFuCjoxT21piY/79PkDtWBBiVReKpj3iWpxs
         9xUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYUEMFd6aXzEsSCMXGZEFrIxrDNg3d2BjE5aPo/UrF6s9Ce5wYFOxwQrHOzeMoSl/rHnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHUv90VULmvXdJH7QQkwW8m1hlGH6bq30Y1nKHU7mdRTGZK9v
	Lj/qnJyawQeIWFjpkoXroELUl6AuAWZnehixvSZEb4rZKJrNSfFT
X-Gm-Gg: ASbGncs/eFcTfxsq7l9nQ6EULqt6mbuK+1Mf1KqAS93rX8v/wQ5SZrPRJLZHgxdCzg2
	1fLOmVvKMTd/u4WYT5RewQvsKtXTtVqG1JjiVTrwOumTIYBmtYF89gWdPB/PFsWzQ7ZVsvtIb7x
	i5E5Pa8qs+7ExfY68fwBblSkI8sqSUSdu9hY2q3r9lZxR8ym9zAcYSdrTEQavbhijCzS8PPky91
	GIQHHIqJ0mAOdc9AQTTqqD/3q7/QM7II64fvkxuVGD0mFoNcKOtXDcS/ZYS7mAqHJPKSrRVHv9M
	YI4JsGg5DQ7Q/FTh+cN7nXo7W5OtfQ5MooiHFgXXuyQL0Cs3+DfP8lI3hU+ou8XnoV7D
X-Google-Smtp-Source: AGHT+IEG/1m7oyGQybzKAxr0OAoA5yMTcvzqkEVgtY1GRFypSa9nDD3GcYk0GSJQUUaWwrsAc4xvIQ==
X-Received: by 2002:a17:902:ce89:b0:224:6ee:ad with SMTP id d9443c01a7336-22780e1f4dbmr247860845ad.44.1742927710828;
        Tue, 25 Mar 2025 11:35:10 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45e1asm93637895ad.80.2025.03.25.11.35.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Mar 2025 11:35:10 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [GSoC PATCH v2] userdiff: add builtin driver for gitconfig syntax
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <d4c0c9a4-0402-4456-9fa0-3102b5bcc3dc@kdbg.org>
Date: Tue, 25 Mar 2025 15:34:57 -0300
Cc: Patrick Steinhardt <ps@pks.im>,
 "D . Ben Knoble" <ben.knoble@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FE085EEC-0BCC-43D9-9F17-1A7060DC4D6E@gmail.com>
References: <20250324021101.7483-1-lucasseikioshiro@gmail.com>
 <d4c0c9a4-0402-4456-9fa0-3102b5bcc3dc@kdbg.org>
To: Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> Can we please have a more recent reference? The difference of config.txt
> here and config.adoc above is very surprising.

Hmmmm... My idea was to reference the last change in the paragraphs
of the documentation, but I'll change to the last change of this file.

> The file format of .git/config files isn't specific to .git/config; it's
> called "ini-file" and is already very old. Wouldn't it make sense to
> generalize the format? It would be just a matter of choosing a different
> name; the regular expressions would not have to change.

Indeed. This is was written having the gitconfig in mind, but perhaps I
could use a different approach and make a little more flexible for other
INI flavors and perhaps even TOML

> This could test two sub-sections in a row and ensure that the later one
> is chosen.

Nice! I'll do that.

> What happens if there is an *indented* header after the "RIGHT" one?
> Should it be chosen or not? Can this happen in a valid file?

I just tested here, it is valid file. I'll take indentation into acoount
in v3.

> The regular expression can assume that the syntax of the processed file
> is correct. For example,
> 
>   [!not a section!]
> cannot be a section header and will not occur in a valid file. Or can it?

Following the gitconfig syntax specification it can't be in a valid file,
and this regex won't match it.

> Therefore, it would be sufficient to just take everything after the '['
> at the beginning of the line without further inspection.

I can't see any harm in just dropping the section name matching and using
a generic /\[.+\]/. It may be also useful for more generic INI files that
you mentioned before.

> Furthermore, a valid file can look like this:
> 
> [section] key = value
>  another_key = more values

To be honest, I didn't know that it could was a valid file. I'll include
that in a v3.

Thanks for your extensive review!




