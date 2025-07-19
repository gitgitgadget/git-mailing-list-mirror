Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B499881E
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939093; cv=none; b=V20O6SgJY8zPFmDzC5cq1p+9IMLRgzZYKg7i2uCmr9aC3LWHbE2n2U1I3x6Om3w29NOCINd/1rJl6jwaIVN6/4gMnEyUqXyl8xGvLPiDLTu36gF/LZxU5G5xQqlTnyyuWW1HosHAu9/mQN7RLTVNq6o4TiV1SMD0f7F99+gPXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939093; c=relaxed/simple;
	bh=oY3AwOR/JWM+NhduzteM0IagZa+UzEggMyn2ze8xXik=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KKyHP2yG7MD7wOeor2sbQIqZSCmHhu8pLRa96/ZgxsTYBE7kIGchFgvEPNs7GvhIT8vftFr4VMvQztB+NRLPZ88cbdzp188Wzkax1b8Oo4q19XKvyFw8E+mdwOOP8wQF6tftN2WmgcHu+8kLg2baagwhbV2VEF+1TS1bCrcpaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhRUcG5/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhRUcG5/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23e210ebd5dso29576145ad.1
        for <git@vger.kernel.org>; Sat, 19 Jul 2025 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752939091; x=1753543891; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oY3AwOR/JWM+NhduzteM0IagZa+UzEggMyn2ze8xXik=;
        b=RhRUcG5/K7Zp9v9TuEgLSORm0sIHwuI7SBa980XGzB8JkGQixkHOVO27PfMmFY7ZJ/
         wA+jJwGwjsx0lJwNNTnmfVWRIuVhACcORNhzpAjbpBek66ZLEBC7TakcKlX5bv/PbCHk
         B1aVbfvmeUH8TTtoGQNSofCSZN41lh2JaBcHDmaKYOGQZD3ykxs91KZIZONSrK92cfUt
         QPREIiNmnlpmh/zY7vKFhRRQB6wIkxIXC6D2EIwOChMU04X6r6JLPMQ/2bmbaJ8GWtmc
         /fqEOmv3r6CxEKRbQLP0d5eGHo17eUh+Hsu21HXHjy0MmsBkwSt71IlpV9jSdefx8pTY
         8eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752939091; x=1753543891;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oY3AwOR/JWM+NhduzteM0IagZa+UzEggMyn2ze8xXik=;
        b=d4lAcWgidoX+kFYKMSAoVU1nz0tZnBuxIaxNggW/3y83/Ea560QVPD9zkhnlSU449i
         VjQyKKoMFK4N8vut2yzRZk3vix7Hml+UnX0XBt3+Je9dliBD98jrvetnj+sO232uTtD8
         18oInE9lGzFE7qtXZWCBgSVInwech6tA+jGPIY5PzypSHGejnuWXqOeWAzeBmozzRnIr
         1VTFrW9LooITJ7l+gp/tzbO6f6Or6EHR6+au2lb8cjX2IRirEVlp8EVFMuWt34T0Qcvb
         seqRWk/oTd0W8wLho0uNsoK07ghmm7rxUdkOI0ySNn84d1bwl0MaOdThrEJq0AnpaFMd
         klTQ==
X-Gm-Message-State: AOJu0YxxCIf7gLZg7UfMidJD25FVpY/Y9Q62Na1n/RwQUEEOlBeoEilu
	xantLa7OMeecUl8Gwe/DgXoVDyXa+0rqWo3Bc8YrSPLgo089mTVnCx1t8rUJERwPABnk1wMz/E+
	r8fXEiqB7bNxsEHVJ7+bweehBt4C+tUKc4gaF
X-Gm-Gg: ASbGnctKrGfb1ZfbRYbIKAsRelfalLnffaS8zQoSMXTSX1Qb03qWBxgsOFRsCXUpk4l
	P7LmvF9bJICm99/CgTuRt+JUP6W3lTj3ZOfNm4p9CQS5FyQsZNTOJzL2IR6ru+xavuD/h6i7k7f
	8i19ahAVzSsmNmdiNCsbJjT0wrgeWUMLM7/3fI17EHrzt9OfkNHNEorViQQxoDfJFPbx91M3Ndv
	LBNShvN
X-Google-Smtp-Source: AGHT+IEdq4Qf3847uIWi5Lexizr2jkudt6jVn0vxIXycZY/jNBEFinpNX+x3uCq3GWGFIusXyfaHrxp5ZlJ+hb8at94=
X-Received: by 2002:a17:903:acf:b0:234:24a8:bee9 with SMTP id
 d9443c01a7336-23e38f1f85dmr111213665ad.4.1752939091159; Sat, 19 Jul 2025
 08:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Begad Habib <begadhabib989@gmail.com>
Date: Sat, 19 Jul 2025 18:31:19 +0300
X-Gm-Features: Ac12FXxxx8Kzh-Ty6RhbXWR9N0NdwWI3fb_ZBysNqHvSBG0QPwHn0J1VhRkSoY4
Message-ID: <CACy3CeRjyGb-T=hJURJbXXcR+_KtCsRsMzyw0EvusCZOpWb4Xw@mail.gmail.com>
Subject: Possible git bisect behavior issue when skipping commits
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Git developers,

I've been analyzing the behavior of `git bisect` when dealing with
skipped commits and noticed what might be an unexpected result. I
wanted to share a minimal reproduction to understand whether this is
intended behavior.
--
## Environment
- Git version: 2.43.0
- OS: Ubuntu 22.04
---

Steps to Reproduce

```mkdir bisect-bug-test && cd bisect-bug-test
git init

# Commit 1 =E2=80=93 good
echo "good" > file.txt
git add file.txt
git commit -m "Commit 1 - good"

# Commit 2 =E2=80=93 skipped
echo "middle" > file.txt
git add file.txt
git commit -m "Commit 2 - middle"

# Commit 3 =E2=80=93 bad
echo "bad" > file.txt
git add file.txt
git commit -m "Commit 3 - bad"

# Start bisect
git bisect start
git bisect bad
git bisect good HEAD~2
git bisect skip HEAD~1


Observed Output

There are only 'skip'ped commits left to test.
The first bad commit could be any of:
<commit 1>
<commit 2>
We cannot bisect more!

This output is a bit confusing, since the bad commit was already
identified (HEAD, i.e., Commit 3), and the middle one was explicitly
skipped. Including the good commit (Commit 1) in the potential bad
list could mislead users into thinking it might be faulty.

Question

Is this the expected behavior for skipped commits? Or could the output
be more accurate by excluding commits already marked as good?

Thanks for your time and the amazing work you all do on Git =F0=9F=99=8F
Best regards
