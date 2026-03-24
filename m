Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53E3A75A7
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389334; cv=none; b=ns0KO+WzOrAyL3lJjxaReTJHD36oS3N3PNOzMqUzApcqL3It0UsfDAHetkxN7JdOyYgnZrli4nOGaVACBgYtXUfBxs1kpuCPIa9MhM/+Jsu4EBPV7QZc40NaKUXyQ+vc9ugqfBa7AIOo595bFeV5hn9glhcnb3vWVYETZ3uvfoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389334; c=relaxed/simple;
	bh=TMeLfwLz97Lob5grlYwDOGIbxtHeZ+ftFfH52xe//ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aS6x8G//zPzi3Hu9cYu0nHnjbsU2BEW/t5ZMnRC+5uCMmo0lwELBvA5FFPJpZrxGw1KUY7VOjdoNQgGi2xBmcnXqirqi7QEUdxiNtb2aodsjA3FNOJVGmUWBPXG8LzDJla9qsA8N57PMM5Ri3dbC8tHy+hNwr/ofi8czwy/n+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADw6YUdL; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADw6YUdL"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4094b31a037so4169157fac.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389330; x=1774994130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXKWiP6dz3BJbftEQwGg/9IFiMWUP8WoCDwW1h+h0O8=;
        b=ADw6YUdL1nYVTYoAA7pmyjCPEirGmJ3h/1HTJGQ4gpg2VM4cOTazYW26fiGDpvl3zf
         G7/b42pKO8Cbmw1xTuDQw5jWJZ0IJ9FWRkC+FKRltXaEjbcrpTk3IuOXDGB8xIZz8vdY
         Hq2VwzFlFv+rcb/kEcNKW5TVYbjZ1m7VHSyPm8o9mKxb/C6aHMeAPf4azixqd8Pur3hK
         f9HBCxMPbrqOl3CY33TdC1Gvs06qSjl+lB9gzwX3BGJR9EA2VJlSDJQc+rDkghh3oLHk
         LSqFoeZCZhWipEfWcbvkq8ix5EyAaGkAceUO5Amj1F3XQeMm9eHnTpTHMM9mYJGqBfx3
         4U6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389330; x=1774994130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXKWiP6dz3BJbftEQwGg/9IFiMWUP8WoCDwW1h+h0O8=;
        b=Pjgo7OyGkOeRlKBek1MAilYkxj0xz3gQZ78jRlGk1C4m/01hkmQ4G3NVrkWGNsOD8j
         sJUlSTp8h8isT8PDtS5wQieOMN5vtUgTMfeJvw1Cu6LGSrft4C2wnn4W8T/q9CtLOs+N
         z7DrvF+W4OG2mmPLtySIHWFAP+tJh9ebzJrFr7JwF+hh/oA2czxIzdUCCLzINIG8Vg4L
         J5+OxI2izJk+Zvg3BOdVdY1NUCTVbzU00GtFK1fti/JdNS9y+gh4noTir7iv6g+obtij
         1wAtHbvfkrrGVQ/rM1RlnY1h43q4iAFHAgjzYJ2Gx8YrVk0KD/d6NZkwBAGVP+s6tnfy
         XgiA==
X-Gm-Message-State: AOJu0YxxfV3Dd3fRcaADEkRbrdOzLdciIAO8lOxCBmnRKwAf1/VzBlX7
	Z0eRF5CZvLLNp3XTMlGyr5aatGV2UEVWPC9zcxRE/SsFVZEFCVIfToEkFNAqjQ==
X-Gm-Gg: ATEYQzxLaftNNVClumM/BzIC5SzsduZ6fvIDOvNjmZUnzgrXIXTOfflBUyDG9OGNE/Q
	Bki+eRxziVWQd0IU48CH2vq96WbcMKk0cvIKdHklK5hGYaUR6frIUKevJW+HTK0qdSXfza/jSoL
	V3jYKI6sAhkPs4oSYsaxK0CBAwql4In8MvMK6jv+XVndTm3gQiDSWxecUHVD+M/WSh2wy/KKUHN
	XGewwRiOLyeRPyE5hN/6y96ilsAtlmfOnjH1u3RBWA2siic606xxSkEKRDfhI1w2oZYnNggQoGc
	Q1xKqMKDzwQur6kY7lhAYk4y4GDNzm9KBoYyGVNqY6OiwBSg+YJEXmKnQtRynBLzc2Pd3VLBMNg
	zfuPh1iQVKH7+bNRjGin43JAT0J5I/UvhY3VErahZSE5DvJo+Eu2fDzWMk8dQ1C6fCmkbSUWLkZ
	83Z8zUprk+dvmHlTFBVAmguUOjbw5txsE=
X-Received: by 2002:a05:6870:16cd:b0:409:784b:cb6c with SMTP id 586e51a60fabf-41ca6e28092mr777168fac.17.1774389330080;
        Tue, 24 Mar 2026 14:55:30 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c149103b0sm12391697fac.5.2026.03.24.14.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 14:55:29 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/4] fast-import: extend signed object handling modes
Date: Tue, 24 Mar 2026 16:55:09 -0500
Message-ID: <20260324215513.764739-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The '--signed-{commits,tags}=<mode>' options for git-fast-import(1)
allow users to configure how signed objects should be handled at time of
import. With c20f112e51 (fast-import: add 'strip-if-invalid' mode to
--signed-commits=<mode>, 2025-11-17) and ee66c793f8 (fast-import: add
mode to sign commits with invalid signatures, 2026-03-12), the
'strip-if-invalid' and 'sign-if-invalid' modes were added for the
'--signed-commits' option only.

This series extends '--signed-commits' by adding an 'abort-if-invalid'
mode which aborts the entire import operation when a commit signature
fails verification. Additionally, the '--signed-tags' option is brought
into parity with '--signed-commits' by supporting equivalent,
'strip-if-invalid', 'sign-if-invalid', and 'abort-if-invalid' modes.

This series is built on top of 1080981ddb (The 19th batch, 2026-03-23)
with ee66c793f8 (fast-import: add mode to sign commits with invalid
signatures, 2026-03-12) merged into it.

Thanks,
-Justin

Justin Tobler (4):
  fast-import: add 'abort-if-invalid' mode to '--signed-commits=<mode>'
  fast-import: add 'strip-if-invalid' mode to '--signed-tags=<mode>'
  fast-import: add 'sign-if-invalid' mode to '--signed-tags=<mode>'
  fast-import: add 'abort-if-invalid' mode to '--signed-tags=<mode>'

 Documentation/git-fast-import.adoc |   9 ++-
 builtin/fast-export.c              |   6 ++
 builtin/fast-import.c              |  71 ++++++++++++++---
 gpg-interface.c                    |   2 +
 gpg-interface.h                    |   1 +
 t/t9305-fast-import-signatures.sh  |  10 ++-
 t/t9306-fast-import-signed-tags.sh | 118 +++++++++++++++++++++++++++++
 7 files changed, 201 insertions(+), 16 deletions(-)

-- 
2.53.0.381.g628a66ccf6

