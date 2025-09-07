Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70B18FDAB
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244267; cv=none; b=WIHr6yCDd36CwtZcNqqz56ecTr/z8pRSYniPcozy4ut8zCNcqe9T3dpuqvdNjmRR85JpOGsgp2I9xg/t6rU81Z/16RZlBI9toDTUwjIrxwzSmSJoV2rA/d3kk53kODTQp7XwNfcYLkJQs3L2i/MfhM1L1nRk6WTdEgDUYnWMu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244267; c=relaxed/simple;
	bh=BaJpZX/T9/qPQZbSXncTaFunGcVLCMil6L7JzLDHEzU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Qb5Pe0IN/DgxuX0c1dPmG/QdTDF28rRTOTIm++j0AGuCw8TM3spRgUaY/meqVftPwU2zYgVwew5SKVymLxZsjTjWibuHt2Kn+XfjVMnkHmjNrLpFuENm7beMLlurtE8n/NKzTssVAwXpHTyb/FlO8AL5HHdyJSR9CqUAmoDEs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDHATaK/; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDHATaK/"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d60110772so34021347b3.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757244264; x=1757849064; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BaJpZX/T9/qPQZbSXncTaFunGcVLCMil6L7JzLDHEzU=;
        b=lDHATaK/8uFDrxwRjtn35leV6itlbCGFmeO2+jui5kLEcydxxKRY3zMIe6rmjtjjNV
         6u1HcoK3ODHvaZ0FfWWyiLz2iW2H3BtzyDfFsuF0e2wbZdG4vSESQm++ub6yWOQgVJdR
         mU8g/BBrmNkNCaIzA8+3hjPeZB0nSKsjNl6S9ixEGNxKbvIh8Q0L0ztSCas2UaoWacon
         2N3wt8d1Fv3H8v+E0JCYzK81kOhvO+Dc45gy7NZrBmD24N1RMartj6o32M80UzDvCnq5
         JO4hM8QwIjmUDZDJzloMI5opFQeuM1J3DilQunyUOi6CNZ/pmZ1DrnL7GZXBI72llbmZ
         oj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757244264; x=1757849064;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BaJpZX/T9/qPQZbSXncTaFunGcVLCMil6L7JzLDHEzU=;
        b=YYBd0Q38MORPXqNXQsx2M7/QKK4qM7zeT2nfbJ/OhQJRdOLTF7IRNVMf1rZ+OVSf8z
         4NaUk9/H9l+Fyn7Y4KYF/E0xGKMYI6rQcCIh1S9ktvfgneDljDxDPAA1DWkkRxG2Kz8c
         TFjRYolpfjx6QQcvWPAJ6ZmvsRZ3HO+qSgZ4euWNNCaUnek/B8qes5NQGW1ZEiAoh1Wx
         iYvlEel5ZGME4RygCl251zooIe1X+1QY/1tRgXnmh4M8FpfdaAJBUbOvwIXAa8qsKmRU
         eF32OXLoU38k4fYrDBPiKCsifdfyu3Xihas3RycezczvUPeYgagxDkwcvnHCU9ZjF6+F
         F+Kg==
X-Gm-Message-State: AOJu0YyYx5Y6JTnShyDXPH6+VCbeUfl4PrDBAQrd0h2HE2742O+6gwxU
	Z3tc0mphZZreRyU4IgJoqs/45hhvq6IedM6nU8d94Zbytcigsp5n7Tgq3Hu6phAufTzEjvBeWQ4
	Dnllj6fAoCeLON7L56zPzLgg5NOO48do1xniVZuQ=
X-Gm-Gg: ASbGncsKbFT3c07odKpLdhBw0miG4UxXTl2n8JZaDdZ/1Df14V8ESO+09qntso6puxH
	1v8Hc0h0zLlpFnjFjXz15KCv3UVOXjUZAmd8Icf1cHq1R6eej1+sBmV/52gJX0E+H2HgS0Ok9SI
	sBdXdH1GV6kGolJB+m4VFEvfCXT47e9qt5DRbqwoUu9XSwUjzH2Oz+ntb1sFksDBvhDl8dmy5tT
	HIq9Jt4kA==
X-Google-Smtp-Source: AGHT+IHiNRSF5PZAob2aP1CJdkStX8xZTMZaLCBlK0haCfYL04jQF7RCKcqxRoe0zhUBXoc+Tbp6VHCtfCivxMOLV3w=
X-Received: by 2002:a05:690c:670e:b0:720:378:bec1 with SMTP id
 00721157ae682-727f4b62b09mr42081997b3.19.1757244264399; Sun, 07 Sep 2025
 04:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Milan Hauth <milahu@gmail.com>
Date: Sun, 7 Sep 2025 13:24:13 +0200
X-Gm-Features: AS18NWAiDkZORFH4jSAd8EhYZUNUzCGTJtewuhegSFccj844nWkhL7ez9k446fQ
Message-ID: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
Subject: Git dumb HTTP protocol should work without update-server-info
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

this works:

git ls-remote /path/to/repo2/
git ls-remote /path/to/repo2/.git/
git ls-remote file:///path/to/repo2/
git ls-remote file:///path/to/repo2/.git/

this fails:

python -m http.server -d /path/to/repo2/ &
git ls-remote http://localhost:8000/
git ls-remote http://localhost:8000/.git/

workaround:

pushd /path/to/repo2/.git/
git --bare update-server-info
mv hooks/post-update.sample hooks/post-update
popd
git ls-remote http://localhost:8000/

expected:
dumb http remotes should behave like file remotes



> git --bare update-server-info

that command creates the file
/path/to/repo2/.git/info/refs
but that is just an optimization
for http servers with high latency

my "dumb" http server
is smart enough to handle http range requests
so there is no need
to download all the files from .git/

but also without http range requests
this should "just work"
and the user should be responsible for optimizations



as another workaround
i tried to mount the .git/ directory with httpdirfs
but httpdirfs fails to mount git repos, see
https://github.com/fangfufu/httpdirfs/issues/183



related:

https://stackoverflow.com/questions/2085402/what-does-git-update-server-info-do

https://stackoverflow.com/questions/2278888/private-git-repository-over-http
