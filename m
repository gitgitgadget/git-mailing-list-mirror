Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F593DB65A
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369635; cv=none; b=iDIEgLICkTY5JSq9mBpoTG8IBJaNwI7G6oTmLKVR2t+j7zdZjJvblKynh+d8gyDma8bB3SnWbbxkm+udZQlbqPs7NmDp3ASuZuYR5vOUpEDnNaisfy9LmEw20IIKofJ5WIKRGYpqUylqX+hGSbFt0as/oW81XXlI3XrUgS/sHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369635; c=relaxed/simple;
	bh=glidZv+ynfUXVInp8Rh0wlr8TH1CnDGBp2ofI8yK6ls=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aMd58aqI7SYb/WOnET43xTa5Bco6F04d6jv2vlw3B2PMesXeOBy0B/VOnV3GPg0S7/zP3bUuki7+ocLW0g+yDrNBLyxu2bDt5jR3XqK0vGWmcWV0QmwNvmpoQ+lkZF2z7DIcaGitCqEXakbEhaq/zG5lU0tlIaRMQnFGqh1LBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmonette.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfCq4z36; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmonette.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfCq4z36"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-532ed858775so37330081cf.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790369632; x=1790974432; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5d3Z3C+EneRxcgejPkRLFgykjihUJuEA4wP3TH0g1dw=;
        b=dfCq4z36fySEwyRrh8PHo+blJFRJtUyQXQuDecfLpuMlc+lCcfiRw0YpC81Kr5Y3xe
         y772Pnl0v3absbOjKbtaHBnbeEWQo2AYuj/DcUuTkPbHPlD+sQXstWJedvlm/CblAmLK
         S9vxVl2X1lMxIx1rYPp05wHEHB9xcNvToKRhUZh4bHTfG2k81cwQ0U7xjGwKKKcvqa3Q
         vAcqxUbVG3LsfWA9pm4n+zHyzWwiUJqKzH5eOcKq02okl7JLEVvDM23qNduddbp8LIk6
         HfgkPDAKbeOSqVnyMY9Pto7UYm4B/jVRr5FA3oQXmHMQErY46cz6KhU23WAp8iudVqfc
         qlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369632; x=1790974432;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5d3Z3C+EneRxcgejPkRLFgykjihUJuEA4wP3TH0g1dw=;
        b=ScOXaMI8uFxEFVaNf7sA/M78Pgd8M3S7gorj0mQMvvlwDZjwACzL5J6nrkjf99he3G
         Fmi4aar/5ULUteuzQwRUsN7LvYfncCRwVqcuoUDQsckk8e4/hLAn+sGbnsC7N7BPIFKt
         NWohPtHtSnX4FJbLNpCk4ewnBwbL3bdLgnXU35aXtducXMJdqkwCO7V9SyQjsqwWCmuo
         JcM0qg4JV/ToCYrHVuquJ21+/9P59LHDnDkz1Ingq9oJJnSvAzZd/+klH5i0gOKMp6O1
         JiEQZu/mkASCP4fnAo6iUTZnJbaWhq7iQa6HDvCqU6BSLlZJJP+w0zkY54FC8k/8UBPM
         Rtbw==
X-Gm-Message-State: AFuF++lXoL0YjaG2i0fd8nW570mBEPffr2c8eYddDDE7LFugFdz3XMAQ
	wcC54WgjMz+67bEkDfGq1kDlh2wxBaZVuEoM9OrePv3K1CdJHTw8k43ztElMgp60eeLFKUbNlft
	dRn/MOr+yVK7LinDvx5sp5ot+veGmV8uOmiv/tFcpmQH3cwKLA90rIPMkhpsQiP/CCBlvRAMbkf
	jf0ssbLaVQk/+qB6k0I/pamEUah3j22Ikdz03eHdjtEY0=
X-Received: from qtvx16.prod.google.com ([2002:ac8:4d50:0:b0:531:1263:381c])
 (user=pmonette job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f8e:0:b0:530:f3bd:d5a3 with SMTP id d75a77b69052e-5330b6ca837mr63675301cf.22.1790369632181;
 Fri, 25 Sep 2026 13:53:52 -0700 (PDT)
Date: Fri, 25 Sep 2026 16:53:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925205348.1210154-1-pmonette@google.com>
Subject: [PATCH 0/2] replay: add signing support
From: Patrick Monette <pmonette@google.com>
To: git@vger.kernel.org
Cc: newren@gmail.com, ps@pks.im, toon@iotcl.com, 
	Patrick Monette <pmonette@google.com>
Content-Type: text/plain; charset="UTF-8"

This pair of commits fixes a FIXME in replay.c. With this, it's possible
to sign commits using `git replay`.

To follow the convention of git plumbing commands, where they must
behave the same regardless of user config, `commit.gpgSign` is
intentionally ignored.

The first patch fixes pick_regular_commit() to ensure failures to create
commits are correctly handled, which can now happen more easily because
of signing.

Patrick Monette (2):
  replay: handle failure to create commits
  replay: add the -S option

 Documentation/git-replay.adoc |  10 +++-
 builtin/replay.c              |  12 +++-
 replay.c                      |  17 ++++--
 replay.h                      |   6 ++
 t/meson.build                 |   1 +
 t/t3651-replay-gpg-sign.sh    | 107 ++++++++++++++++++++++++++++++++++
 6 files changed, 146 insertions(+), 7 deletions(-)
 create mode 100755 t/t3651-replay-gpg-sign.sh

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

