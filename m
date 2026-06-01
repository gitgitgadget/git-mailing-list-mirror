Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6C343893
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351132; cv=none; b=UJmHDEa5sc3nPT7wdPtqMVgCqhLK2TQYjtWgLRp0wX49mc21RiKao84b0yOMGVJjB+D97pt/mobOp9GewE0MyaQpHnbIvn231xNXX6lh+p9c5/FT2ndscPrlz1WP6HXzVe2pm3tk4GRAoZqfRob6dUedTf88tZ48V8sfREYrwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351132; c=relaxed/simple;
	bh=+WoMz93SBPgmaMB/p6V3T9XTuzsDhYc/7nICs2kmKB8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qyISPaIJYZrixcjureR26ZFYNFyA+3KPkPKp9YZXtIAHx+ObTGb33bKl3qSor58/KNMq+T3fxfbNpLmjryuJYor4uuQJhb6GCpc2xVwVNwN7qIEpFZ4IVN9IS/Yb5JqdTxLTo7rs054HDJskIw/MH6hi7iop9UNGlJLvQ4SBpvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoYUGKPU; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoYUGKPU"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59c9b666822so1720652e0c.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780351130; x=1780955930; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qSKB6L+/8gmILB/2p5ONBDjdgD5YxniTDU8oZ6bFDo=;
        b=EoYUGKPUa27nd5dknzGu7j8XyBZCJyN62/ws4sKE4IMDq2GBhKLnruaUHVCaLwkotu
         JGOPS4w/zDDsXGTIm6Hkq2wL/7UhstVjAAGFUWWdCZTYyyaymfosv71vQZ0o/oNbdAuf
         SY5rsZaRzPfKTZrSwj61NPUJZasApvnSbE4b2Jb59yWJOvAipwy/7d2jTHM8IC5KrqUp
         THEdRd9v7IvAzEPR8V5pJhKs+SoBxi4V8Heq3ePe/QnRE8qKF8/dOlNP+0KIdQePuuwF
         evyg0JBHv/kRqtKT+FDYbo+EN/1DoxVbqjUL5hoCZwXB1fp4rQuKfH3xusHXfh8D980y
         KPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351130; x=1780955930;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qSKB6L+/8gmILB/2p5ONBDjdgD5YxniTDU8oZ6bFDo=;
        b=NMaNh1bp11lu0Ntt1G48iivtddz3uSenHq/jw8+pcIHLS5ORHdUzTZ/iWRkqITQMbg
         YLp9BMmoHOUvMDczuMf//grJ0/DETKTmAkvuLA6ds90UJhJ5Ha2oNz0iyU0rC313YIKN
         6ggEDWjaASJQDRJUroiUgUuNmCwRHnr8ovYdSEL5sU0Wxe+BMh76I0SPfVRakZIZLMVo
         X53aJV2gf+V/aDFcJZyMqjgGmjlEB2jQg7aiCiD9D8hn6w/fkuk1Jpi9eQfibOq3Rlqy
         +yTXxeVkNOrSx6rznu+/EU8Fbg+fW41cHNc5eCmJAdnz+GWA9RPNeNIt9+XdhA6hvMSq
         YOkA==
X-Gm-Message-State: AOJu0YyfSPlU2RNQvF60il6DMqwCBq5z1d+VxuTc1OIviQknzaVZMHav
	rpBp35aolsQdYBuMYxFzDBpp7ghwOjR0HjTZT4Mcrf2muU1q31XQNz/M
X-Gm-Gg: Acq92OGFXF3KO3CRzKvgx4WHOz3/LoqgpM991OgHjUD7uUKACRlvD27NMqJYOyU4UUX
	NBgCvKRySnsIKo/kRyW5KIinqF9CRcW0myY6Ii9+7myHHwrnMopYpGj9aHYX9zf0Ferq+ZuTFze
	JBlaMD5jM18PGCYkYjF0LRrI1UFImRHOR7U/gSsdEFg6LJoevLKPo3/RnSeuoaG/FmKE02EtPB0
	gJkVBqu27ubZZJTAsFjH5V7fhLk/8qNOFrlO1JTPkOF5WT5ddGZKT+pLa6pr/a9dWxxbU10Fjou
	cqXASIn1IroCLGQ04sJOgERw8iIW5jL1kYLmUqHCdsg9lP4g2bomz4jnODlsnsG4mBQXchhxl4l
	+wxnWlOA/mfm9Z/puLiSbbm0NEaAeF6nQkRUIvoikABdFOXE9VCz5rj8qm1YSt3OCrEMaNFyhz9
	CS/5KK2IoACbrDs0vdLTqYaZgOscVMYh5E4hX76QtndmHCuX5cMgMFPuzu51za+/Q=
X-Received: by 2002:a05:6122:2891:b0:59e:f727:4bb4 with SMTP id 71dfb90a1353d-59ef72781dbmr4688996e0c.1.1780351130483;
        Mon, 01 Jun 2026 14:58:50 -0700 (PDT)
Received: from smtpclient.apple ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-599d4754259sm8394393e0c.7.2026.06.01.14.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2026 14:58:50 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC][PATCH 4/4] repo: add path.commondir with absolute and
 relative suffix formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260601151950.30686-5-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 1 Jun 2026 18:58:35 -0300
Cc: git@vger.kernel.org,
 jltobler@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com,
 a3205153416@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <81475C6C-3E0F-492D-BC20-45518BC00FE8@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260601151950.30686-5-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index 7c7dfbb052..dd2706e1f7 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -184,6 +184,7 @@ test_expect_success 'setup test repository layout =
for path fields' '
> mkdir -p test-repo/sub
> '
>=20
> +test_repo_info_path 'commondir' '../.git'
> test_repo_info_path 'gitdir' '../.git'

I was thinking here, maybe you need to take a look at
git-rev-parse's tests and check what are the corner cases.

For example, `git rev-parse --git-common-dir` documentation
says:

    --git-common-dir:
        Show $GIT_COMMON_DIR if defined, else $GIT_DIR

This way, you should take a look on how git-rev-parse tests
test those two cases (GIT_COMMON_DIR and GIT_DIR) and do
something similar here.

