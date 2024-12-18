Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46E9154BF5
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734554596; cv=none; b=TYnqXl2WUcPz5tu903CoXIqS0T17WcdWF+9hyJvx2OG+PuAVb6S0on5U4p23SfbMlAkmjj+Pn0Bm+nTA3fVRqrdwH4DM0HS9PrA3DtH8hzTpSw9pywU/T6rkPfWtSC87cU8lvWvJgjU9LYjZZy0SfC4Yws+lF1zA5G5pEjiJVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734554596; c=relaxed/simple;
	bh=WA1c2cgrwFdHRvQ/1v4nVTHgKfhFktknCWAMkCsdWRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru2zykPNJ0wSKHwMi6ZKoxFCr+oPbjUHAKEu0YgCC+7Wzeny5hELI/MWB409WBqnJtSxvwUd56YNMm7ilZIum6D09GNkzQu3sCbXnqQPmJE1jP3HMP+EAQSjcDgX1rgbazgfxFWsTCP785JP5mj14LRlJB61lJYF0G6Kw0uec70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En9NEqcu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En9NEqcu"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3ea2a5a9fso5383a12.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 12:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734554592; x=1735159392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WA1c2cgrwFdHRvQ/1v4nVTHgKfhFktknCWAMkCsdWRA=;
        b=En9NEqcublG2IjGErysbvDHzzcq4jMvBqj5VWzRWXAKuahGN91U+fynbiapru32vaK
         b8d3irLxcBbUmKKSFkoc3OhgN6xuQlVx4H3TCa/GopCGiSihVwtWpoit8vs3ieN97slA
         yoa45xDXctB8DTO6hLAEA8mDEPtHP04w+EfYXvN6CfsS/U4c5cHaBvUBsssaO4YlZ3iO
         4GeuRnbcgsOBe2y+cZ1TsVUJZiABPqLFn0gfHuac2QbMIn9mEiHQ0rAmA/6+EcuM/CbO
         ZAv8Mj7zHYKFdunPMs007ghVXUxFItjuVFvTBDMRVJSTc8NcVEhKHPtsGlw0TuLzx2KW
         zdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734554592; x=1735159392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WA1c2cgrwFdHRvQ/1v4nVTHgKfhFktknCWAMkCsdWRA=;
        b=s+jM4x0DgsJbxHPpAbPre5N7aBTwizjruikDbbaOb+VAYgWYW66Cq6lF9IG1Cf812J
         ztvHftot7+26vBmu6b98vuZ2lrR0ssc6LlueYMOUCD0uAeBUF6ho/vY61Q7FzelH1KTj
         SWVN13u/J0SJ+ANo5KpfZZSfB42z0wrbpt/A7/A6/nKBgAPfBb+T/8j0lOe6w49lgMxY
         LSy8A5avM5LXlTGTd1/JZWRKXX3aG5T2qzSUVPUwDHlFXhIqPj+lUJAubQl54e0G1UxS
         p8Ns9eU0tGCbk9owzzaYvKzqDYJz3SXABAtVyD5hkL9nM2mrJiq5LmjC0U4Kds3DFhS8
         zU9Q==
X-Gm-Message-State: AOJu0Yx0YD55qy9ZxVO+OWW4zafLPMqudQ7RvQ/JihYI7FHZX/tEOetY
	w2mUCAyxXKgCOYbDv/W2zYwf+jT5FjHlk8diq6MioH1rNE8STxUZC3wSoUGvW+aaXorgWmnmE5d
	UYnVOVzp3umMbvQRmV6TyVOjNqmmlnv3s
X-Gm-Gg: ASbGncv/cLr9sXLRHSS6B4ben6da6SFCsG9ndjlXDtXN4rIBDnlBL1AZFKbC26yRnVB
	GNh0hYYRUVGKBXx9pbPVgCpDeq8JTl/k1aCYA
X-Google-Smtp-Source: AGHT+IGhvvsakEYPrJ5mKBrmBT42DBgAP1NH3OL5Zx7OMs3kNcsGwRDwpkFII2qri7JuCJnnVQEyTJ63TKRFGPbluYc=
X-Received: by 2002:a05:6402:2349:b0:5d0:bcc4:8af1 with SMTP id
 4fb4d7f45d1cf-5d7ee2db679mr1589407a12.0.1734554591828; Wed, 18 Dec 2024
 12:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqs=ksKqY2M8Px3uv6ut=MBwkmpPUqp3xVzVpNMJ0YBrBww@mail.gmail.com>
In-Reply-To: <CAGJzqs=ksKqY2M8Px3uv6ut=MBwkmpPUqp3xVzVpNMJ0YBrBww@mail.gmail.com>
From: M Hickford <mirth.hickford@gmail.com>
Date: Wed, 18 Dec 2024 20:42:31 +0000
Message-ID: <CAGJzqsnAO_vDSYOC7ZbYUQHJ3fT10JuQ2RrC2cvY4hcPMnZ=bg@mail.gmail.com>
Subject: Fwd: [Bug] `credential fill` prints incomplete bearer credential
To: Git Mailing List <git@vger.kernel.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Hi. Is this a bug in git version 2.47.1? Or am I using it incorrectly?

# erase existing example.com credentials
printf "host=example.com\nprotocol=https\n" | git -c
credential.helper= -c credential.helper=cache credential reject
# store bearer token with expiry in far future in credential-cache
printf "host=example.com\nprotocol=https\nauthtype=bearer\ncredential=letmein\npassword_expiry_utc=2147483640\n"
| git credential-cache store
# try to retrieve credential
printf "host=example.com\nprotocol=https\n" | git -c
credential.helper= -c credential.helper=cache credential fill

Expected output (complete credential):

protocol=https
host=example.com
authtype=bearer
credential=letmein
password_expiry_utc=2147483640

Actual output (incomplete credential, no prompt for username or password):

protocol=https
host=example.com
password_expiry_utc=2147483640
