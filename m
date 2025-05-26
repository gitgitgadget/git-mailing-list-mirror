Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FC41C64
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255620; cv=none; b=u8S7lxKeBD4wF2Z6Cu4f9VegmRR/4sQ7N0Twt/IKj1r/kqlOmlkx2qINLzmZ+/c/6qcTC76die1tlZ2HbS4rNYrWCb5lo54FRxX3kdfGTJ+3ylj6Nj2WxgBnpHwPh+b80Pb8zu6FgwCigVeIGTxxksTzPpyZJNI3ryNIxzRsdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255620; c=relaxed/simple;
	bh=3wWRVU7LMPlJjx4PrdXQLBASl5s0qfg9G2KWsF/GDIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZQBkd9Dco5Pj8y33h//o0qulJJ6gGbKLMpL3LDq0VTgRdxz2b1I4tpvKa/NTAzmskynS5iqtKlMVO/MxHXQykYHzm3mfMTwMSrdRnFnfFoyMozLTeGg8Dv2jmxZV2DHMtrNgIg4GdtXEKzGRsizIcimYF72e92pNlWnKINusFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqS7/xQU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqS7/xQU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so17313415e9.0
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255617; x=1748860417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6jEyjkpPU1NEvP7A9s+oQOwS5ATIVcb3wr8bYCqAfU=;
        b=TqS7/xQU0ZwjWJQ1/yAHYScMgk4oqJwjBelQCuTgPVAxUYL2j3jrzohBYj351WLuZy
         V5hesNKduvzDbjG66zE3sIZKajnLf2i0QmkMpvfpwcIKlV0kB25WVv8+TqSTrIYOVRrC
         +D9P34KxTcbgLIZocyRIM2BsPz1LESYaQu9igRXQ/M085xLNRF1jZjm/ht+lL8Qf7Agl
         mSIvYvpJCk5hG0UGXl0PJRZr6BVhV1uadwuzaJA0VWklIjPBH7KV6M/WBYppu48NzCSB
         FXzOHXxdc138HsNsiz5yJY/michIG5MOcqQvKNym55qhKy6s8cWXFS4LHdEdEzl2Rov9
         HeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255617; x=1748860417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6jEyjkpPU1NEvP7A9s+oQOwS5ATIVcb3wr8bYCqAfU=;
        b=FfBU953chJTIj25xwk4ygI7Ob6s2maWkjRiTQ9ELsCjtRf3/aP3o/3S6R3TzkwIX0L
         spJhbtdsP5ZGS2vqeL7OCbt88/Ca2s5aJSZSHyNR7nNwj/ofYmmzszhIA/9644LgR8Jk
         buJcOaSvxwPEssgLK+UrMqqY1SAB7RrlmXPeyKaZepMhFk4btXh5sdvbMlf95LOtW8IT
         m1dfm9KAOaYCvmLzFR0krsomh9WaBtp6uFanqrIEy5VHdddRExUITjSqTozKmUmOLxEZ
         WmdV+qq5/TPz2DyNJGwbmIGbkWQuoSP6ET8fSznmnJg3q3wH5nkCT2Q/jXJTgwg9Mvhm
         BJ+Q==
X-Gm-Message-State: AOJu0Yw+RmgTBMEddoQhazkWYCgWnXYdkA/RcUSmk+oZCza2eCq6RL1N
	0vcHbxr1r5372qY+hl7k3Yw3S9EvUReu1UunaQzsVWfGopJVWufdIkrFD1Hr0v6s
X-Gm-Gg: ASbGnctk+u/F6PW55SgrVmvGdu8YTjFR5r+vX4JeFBkRSzv0fho+k0zNwSQhVhPR60n
	4bHl0gOIgu2GHSXh4qBXkZn67bpPgP/4o5orwqcWVJ92ByzipIelyGJr1GdoqbJYcvgtFt1OIGt
	g51Q6b+Y4W45xzIqczY6CgSP18Hzef676a4ncVEp4mG4r+e8zwWbE3cUjDcMBkWO/iDrmKkIjvT
	QmcUOGBMn1B4tx1SSSstX8HPvfaBsjZhn24oYytJVRK5HZ/zYq8N9UsFor0HaXYlEiuFpWYZVDK
	FLNs4gwNyz8j4kn9Xtfx/gm0bKtQI/6oZ2Ty+jb1Fp5o7uaURdB54BMPhZ+tHKFpZfMoWpyQYNr
	/g1MKk/05sK4Vmn1Zqiph6iA8dR4f33SOvbGr
X-Google-Smtp-Source: AGHT+IFP59YqAGEICl+upQzL80ecw6bFMVeyeONKsSRnx67F54abda0DkwecwHG1A/yJ6gIsySuqCA==
X-Received: by 2002:a5d:64ea:0:b0:3a3:7753:20ff with SMTP id ffacd0b85a97d-3a4cb45f1f4mr7269803f8f.35.1748255616363;
        Mon, 26 May 2025 03:33:36 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d26caf92sm5071512f8f.66.2025.05.26.03.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:33:35 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/6] extract algo information from signatures
Date: Mon, 26 May 2025 12:33:08 +0200
Message-ID: <20250526103314.1542316-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.614.g649fb04ae6
In-Reply-To: <20250424203904.909777-1-christian.couder@gmail.com>
References: <20250424203904.909777-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Around one month ago, I sent a patch that tried to improve on how `git
fast-export` handled SSH and X.509 commit signatures:

https://lore.kernel.org/git/20250424203904.909777-1-christian.couder@gmail.com/

This patch was showing a single string for the hash algorithm with the
following possible values:

* "openpgp" for SHA-1 OpenPGP signatures,

* "sha256" for SHA-256 OpenPGP signatures,

* "x509" for X.509 (GPGSM) signatures,

* "ssh", for SSH signatures,

* "unknown" for signatures that can't be identified (a warning is
  emitted).

brian m. carlson however replied that it would be better to show two
pieces of information instead of one: one for the hash algorithm and
one for the protocol.

I have tried to do that but there were a number of issues. First it
seems to be easier to extract information from signatures when
checking them. And if you check them, then it might be interesting to
show the result of the check.

Also for SSH signatures, it's difficult and not so informative to get
the hash algorithm. That's because the hash algorithm is often
specified by the key type (like "RSA", "ECDSA", "Ed25519", ...). For
example "Ed25519" has SHA-512 integrated into its design, and "ECDSA"
and "RSA" are typically used with SHA-256. So for SSH signatures it
seems better to just show the key type and not the hash algorithm.

In general I am not sure what users might want regarding commit
signatures when using fast-export. Some might not need much signature
information at all, and for them checking signatures might just slow
the export process for no benefit, while others might want more
signature information even at the expense of a slower export.

To address this, I decided to focus first on extracting the hash
algorithm from OpenPGP/X.509 signatures and the key type from SSH
signature when checking signatures.

To test that, I thought that it could be interesting to add a
`--summary` option to `verify-commit` that shows a concise, one-line
summary of the signature verification to standard output in the
`STATUS FORMAT ALGORITHM` format, where:

* STATUS is the result character (e.g., G, B, E, U, N, ...), similar
  as what the "%G?" pretty format specifier shows,

* FORMAT is the signature format (`openpgp`, `x509`, or `ssh`),

* ALGORITHM is the hash algorithm used for GPG/GPGSM signatures
  (e.g. `sha1`, `sha256`, ...), or the key type for SSH signatures
  (`RSA`, `ECDSA`, `ED25519`, ...).

If we can agree on a concise format output for signature checks, then
maybe this format will be a good format to be used in the `git
fast-export` output for users who are fine with signatures being
checked.

What do you think?

CI tests
--------

They have all passed:

https://github.com/chriscool/git/actions/runs/15248563563

Range diff compared to v1
-------------------------

No range diff as this series is a completely different approach to the
problem, and running range-diff shows completely different patches.

Christian Couder (6):
  gpg-interface: simplify ssh fingerprint parsing
  gpg-interface: use left shift to define GPG_VERIFY_*
  doc/verify-commit: update and improve the whole doc
  gpg-interface: extract hash algorithm from signature status output
  gpg-interface: extract SSH key type from signature status output
  verify-commit: add a --summary flag

 Documentation/git-verify-commit.adoc |  53 +++++++++++--
 builtin/verify-commit.c              |   4 +-
 gpg-interface.c                      | 111 ++++++++++++++++++++++++++-
 gpg-interface.h                      |  16 +++-
 t/t7510-signed-commit.sh             |  24 ++++++
 t/t7528-signed-commit-ssh.sh         |  28 +++++++
 6 files changed, 224 insertions(+), 12 deletions(-)

-- 
2.49.0.609.g63c55177e5

