Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE51494C2
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761179285; cv=none; b=VK1GrMmyLR384dLxoneyS+7VfO+KSPg5e9oAF/K0wEaDiupjB3N/LzPvg+4YVs6HF5tKdgbvCbh9Y9oQqWvEKSAL9ermQxOYT33DJAfPYdUTIlVL/U2ad7gb6WWSJWH9P8tNX9znr6iJbMKnwb054sfmWJ3ChS9lgxK1TmufS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761179285; c=relaxed/simple;
	bh=tFlSarlA4d0eokwSXBdumDOMF4UfSH9Mhnvtx2vMudw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K1DWy5A/6rft/bswZ+QvxsEpq7Gbj4Eje3VymxklmRYDd/eyfRIy9MutVLEPFpAzJyWNq8r6+e2hG0n/JhDrWOV8R9f8r4rP/qHWICt0DK8CJe8AW+wk+wHU190lpSn6v8drKCwjpCHt6uO7tRiyyFahNQg36lHNjri+PHpjC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHXh6Y+v; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHXh6Y+v"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b6a73db16efso119770a12.3
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 17:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761179283; x=1761784083; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFlSarlA4d0eokwSXBdumDOMF4UfSH9Mhnvtx2vMudw=;
        b=cHXh6Y+vRkmeZxcTcqiOB2RXYN8U9Lp5oX0C3aWvEfDvgo16fufQ7SkDu3IlL1n5Y+
         F+ANNM0v0bmMo349C3TTRF1a8cXLur1oBYXZoQ4SG0s2CMurSRQm78+dgzImv9XdCb2M
         qkCHwttNBh9Apm3aNDj9T5JkzL09tXNF7V5f2Ys2+dwa9ilcizXus0O9KS20VdQXbjoo
         LR7yPO7s2yCuEQGAAonBfyuJsnex9W6M6oPPs84oWDa5nl8OKkiclXra5qpIUKE+p3Z9
         swT7S5kfQnqwcGWo/lS8DBigMHR6irU8bpz9XQMaCYKP5hKQK5SYFCwhGXraK4vccEcA
         FPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761179283; x=1761784083;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFlSarlA4d0eokwSXBdumDOMF4UfSH9Mhnvtx2vMudw=;
        b=Gh/VXgXHQH6qjGIyqKpn+s3RBolpCyj/OJ8+t3fJg5e/SKGU9ocp8DZ1ZAJKsx1WdD
         q2gw9HidpJpJTC17q9+XHyGLw7CmyzsOArC1LVssIFjbpk2sJWaF5P4aZu1T8s1ZGL60
         ny3YilVZUNlutX55bmr9+eJcsbKQSPsaXKbs78f/cu6dsmPsOrrH74/3V/S41TYSpNG9
         ROXqx+MgOM6lilisLZrJtWUQNiO7Gm/WDFjHyNgJZuqUYbIpF4cSiCLHJlIyAio8cqvR
         X4s8uGkgzDA1OSbHKJV9KuEzB/2G57wFi5OIpLZUOYjnXa9g4URtLDy/jyMHmJnNvqyc
         AWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhP2iBLPBMuDHZ7a0oVrweSZtSEMm3x70aCLMPwEIqms1Kg7/Fb4sltH2YDspQL3ZBOBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJU+uRpcvayruTa3OYL5Y49ZZST4BHNnDTpXUs8gr2pCAQTQ5c
	oIKd59bxar3tNx3I71UHwaBAcAzBSBXX+9VCfUgVJzPwMSktncykf2FargObicUkjLaMTg==
X-Gm-Gg: ASbGncsaldWM9ixaa3zsnn40ElWD4gnMczuviEJtkyXZvjaEZaxxvhiZ4/fxIChXaDl
	I0YwFATTaVX3x5Yjik81YMHmsim/UdKh78iabMRsgfKT/WyFe6Bd3b9gsXA0JwJ1eRGFjL2iOuy
	sJXWKg9AwlwbIcve8CO+gW/bdMTZSB0p711xlNhQpNyOa5j489TWvEKKCwhjRWHukccte9MmyXk
	/P2VXObAG/hQv8X6hpFPJxYzkQld5/itc0iy0TI85ssWMekZTE4PeYU6LZHbfBLT9B+knXE20L3
	bQbmGZmMrdw65LchgbVehTZV+2sf8SMKJAlyXVDdpcQXwPrNiwT7wMXjdQAPmd+PErd7XKOOq56
	8yHIjR9aGIjVLEo2amzmEiD8Zyz62zgjugIE6Qr65i3Y3bXcVKFyvkhiTEr2ZY1sHPHvsVWiwwk
	y1Hhj71DIlcDJd5LLrZDctjMUROYKRXdt4F4zaZts=
X-Google-Smtp-Source: AGHT+IH5UPgLCPGtlpL8OUTXbEEYpEH+iBOgkKSIVlSSAjLqI34ghx4dUeV2zf2M12QcFYQE2wyMBw==
X-Received: by 2002:a17:903:1c3:b0:26f:7db2:3e1e with SMTP id d9443c01a7336-290cbc3efc4mr318060675ad.47.1761179282840;
        Wed, 22 Oct 2025 17:28:02 -0700 (PDT)
Received: from smtpclient.apple (n119237241194.netvigator.com. [119.237.241.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda819dsm3984685ad.12.2025.10.22.17.28.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 17:28:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4] diff: stop output garbled message in dry run mode
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqwm4mwrix.fsf@gitster.g>
Date: Thu, 23 Oct 2025 08:27:49 +0800
Cc: gitgitgadget@gmail.com,
 git@vger.kernel.org,
 Johannes.Schindelin@gmx.de,
 jake@zimmerman.io,
 peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CB69AD9-2A1B-46FE-88DA-B98CF81C528A@gmail.com>
References: <20251018094823.31173-1-yldhome2d2@gmail.com>
 <20251019163024.18939-1-yldhome2d2@gmail.com> <xmqqms5iyap5.fsf@gitster.g>
 <xmqqwm4mwrix.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> t/t4013-diff-various.sh | 6 +-----
> 1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index d35695f5b0..c0a558da55 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -683,11 +683,7 @@ test_expect_success 'diff -I<regex>: ignore all =
content changes' '
>=20
> test_diff_no_content_changes () {
> git diff $1 --ignore-blank-lines -I".*" >actual &&
> - test_line_count =3D 3 actual &&
> - test_grep "file1" actual &&
> - test_grep "file2" actual &&
> - test_grep "file3" actual &&
> - test_grep ! "diff --git" actual
> + test_must_be_empty actual
> } &&
> test_diff_no_content_changes "--raw" &&
> test_diff_no_content_changes "--name-only" &&
> --=20
> 2.51.1-638-ge1c807bd82
>=20

file1 is removed, file2 changes its mode from a regular file
to a directory and file3 is unmerged -- but the output is empty?
I am just a little confused why the =E2=80=98actual=E2=80=99 file should =
be empty.

Thanks,
Lidong=20=
