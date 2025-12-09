Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E858302CBA
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765307006; cv=none; b=NkT8pRWqBbhB5QNhGLiZU3s33EyM2n2GvY+1Y/jDJU78s9FEX3MNpVKw6CP+wNPaoBE8k2R2JXcl6mZ12TB1XDseDEi9cvZ40O+TT3id+0+ip8nHVnxfQ5e+M6Ec/kh03z1SPb2C6Os8US9Z1uSqN1+3n1QZ9KoVMBILXI4zaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765307006; c=relaxed/simple;
	bh=3K/p3Wdo5ofxYrSr/Ser77Pe1WB1PlrQ7RLSq0T2ung=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=f2qaAEAE4CQJkJ2CwqlXRfe6OmXZFQDvQ2+XgTJ2q2KKgiiWYVJ/hWmKk66TDvOjOXzs4KDw742DEWgZvxv1XXlOEeaqzgSnbNAXumE3jWyShtOkq6RBlvabJbAh9+5P8vlhY9xPf0GACm3r6fLiBvt7nrkidwfgHxVNsSbu5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsWUBqlu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsWUBqlu"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso6887683b3a.0
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 11:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765307005; x=1765911805; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3K/p3Wdo5ofxYrSr/Ser77Pe1WB1PlrQ7RLSq0T2ung=;
        b=MsWUBqlu7Nvjh6/xO/+vlUIAnklL3pTCp85p25ZyWIIOo6OqKI04W8n3ubF57mhEUC
         TeMZj+HPwfNzlRKf+cMHLAwBxZ3zutq1P6hylU41gEL9Ld/ah6cEozUEYsV69N2IdNjJ
         D7hM3ER4XtN3CRx8ihwvc/JgjXWVo6gT8hxXfNQUnSvjRCfyk/lpY+Lwd7ogz4Inqetn
         dNmJyIa6FblBZWa3yWzT+W2SwKGwYpVITYUfMiEFObpMfQ6EGnVBm06zV/zynr2DyqkH
         FmX1UYa8KkawlcXSfBRu5JoQfC0j8yJQSk0whvkiJ8tus4s4CiGsQR7CW/MrzivmQ0IU
         nXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765307005; x=1765911805;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3K/p3Wdo5ofxYrSr/Ser77Pe1WB1PlrQ7RLSq0T2ung=;
        b=thCa8LYZdGC2JfS1CDC88N0l7xmX9dPSBlVz/+sqrsLExdvgmCm8InrWXIy1elUCr4
         41XBTt3P/GcSJOCWkGhSV39qBvK06YgwwUmEjVeNblSQ4pUqSyFYdFzgswwmnNfnQ5wg
         DkE2M6YCb8N8YvOpkzz/ovh2Xk/04LbveHIeiJ9KXUuSaYf3O1PYd/ryasWYWrQxi3wH
         3CEqDnp7urgMjq293C1QEOme7i5KI2X3KoyHxdbJNYgmgD/KPjx1EYdFxcykJabfhOc7
         t/bE3Ce/LaDphmVPdPK97dJWYkden3a2TUVyLAkuFu7VHM5MiuyOSY/inBaTVo6ZGX3N
         lw5w==
X-Gm-Message-State: AOJu0YwEQuiA28f5fzUNMjwAnq27mxFsHsjLKCXTM9x9x6j1nqBV12sZ
	Yw4uYoYpAfIKPWO5eNMUUEeZetaMGzRdLlCtfbmYG3hQBIxNI5aZYPJp24Duxewh
X-Gm-Gg: ASbGncs3gjM1OJ5c/CrKIeA9zbIcMBysSRllaNckD7qFFe9DQHAl5WAUMLLISqtDTMC
	oxM34y7wNI6q15xbnQiaVOL4cnCM8ZNHxh9pEC2IquyYjmDCddBVwVcWrNUyTJLd+G3OU3IHjlJ
	7T+PbbsfsCXjKJikKDEiE+GlAG5NFujy1EFqKiDT9HGd+6q8Cd6Q/f/F3gLUREBnO5dS/moLEPb
	lIDl5EjH6YmrI/FWziNcmDWgsxSFPiD+LOV5KDh1osXffBotGTaGFZagTpW5J4aaiI1ossV7UOZ
	C9uR4Nzf8HZ/Px20pTJh1yxRKcv5X9HJo1ux4U2L5I1zlK8snPEpM/ERyOf+D+Uv30yo5FV88en
	LAZ4ih2ycUsfbfFYxp3Cwd4ebAWS0MpkXqcfzV7A8TIsMKUeeQBOVdU++h+rxFJDx1GomV3LLCm
	SYllzu7WmwC58X8+DGBmpWDumkD3Dhg6ediryo9Q==
X-Google-Smtp-Source: AGHT+IH0lAnwQdsbnXA5UAx/p0YcWgD2eWHSkA1RdNIamgbRTIv+ZRlsybmpyBCHqgkpsr2ErlPgBA==
X-Received: by 2002:a05:7022:670e:b0:119:e569:f27d with SMTP id a92af1059eb24-11e032ca01dmr9649700c88.38.1765307004549;
        Tue, 09 Dec 2025 11:03:24 -0800 (PST)
Received: from smtpclient.apple ([177.118.148.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7703bd7sm75948360c88.10.2025.12.09.11.03.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Dec 2025 11:03:24 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: About --staged ang --cached
Message-Id: <FD2160CA-DD56-4BDE-92B4-0859C3BD2396@gmail.com>
Date: Tue, 9 Dec 2025 16:03:11 -0300
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3864.200.81.1.6)

Hi!

Even though the name "cache" is considered obsolete for a long time (for
example, gitglossary calls it "obsolete" since 2005 [1]), there are some
commands that still uses the flag --cached to operate on the index (e.g.
git-rm, git-grep), while newer commands (e.g., git-restore, git-stash)
use --staged. git-diff is special case where both flags exist and they
are synonyms since [2].

Personally, I'm used to type `git diff --staged` instead of `--cached`,
and my muscle memory often makes me type `git rm --staged` instead of
`git rm --cached`.

Do you think that it would be relevant to add --staged to the other
commands just like [2] did to git-diff? Perhaps this is just a personal
issue, but I find it curious that those commands still have a flag named
after an obsolete name while newer commands are using --staged.

Thanks!


[1] f1671ecbfa ([PATCH] Assorted changes to glossary, 2005-08-18)
[2] 2baf1850ce (git-diff: Add --staged as a synonym for --cached., =
2008-10-29)=
