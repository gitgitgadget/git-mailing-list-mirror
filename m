Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C315817A583
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604546; cv=none; b=XvZoNbcBHZojDue5oQeUJA7gYSwulbDTO77ItiCmNARZBKo7Bixg6OuqCxSh2NHsusLH2GAlwjZ5+1qGFO33VzRZEtGbGqjC8xRXtudGS1ohrjgCUP+e02O1ot8QKJbSGHc60CPNs0WisTj5fQeKWp1QddzjVg1Y+9r0Xy7iwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604546; c=relaxed/simple;
	bh=pxyl4YODei3PQJFGUi7kZps0iHz/XC4cl24odzvTLPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGhgMWkcoVJ0EN0rSW4W655ls6E0BviSS2XTWJEoZeqSWfJp/dP4Wy9UKvc+Q8cFL4lNFoDhBwdiX0yIP8X2lQXbqfpUthWMxfCP/OrK3rbhcoFkb/cOGoqsLvt2BsmjaIl0Ujh3SfduikA8R3OAdBG3bKqZtewJvec5eUo4Pv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrPH1xET; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrPH1xET"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e5a62031aso684292b3a.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731604544; x=1732209344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yX1ctbeo28+FVZhHm1exPAhhxCYNjnwJ2QKHbMVupjI=;
        b=TrPH1xETGLqU9oesaQ1Ax/aQ0L05vVdogz3YTN0+pA+kvbpBNpmIh1D2tqlqhiljAN
         yADcXGfoH1ES5c+vc4z6xA5wxAMJ0oAQvFvyX/4k9BWcyAmw9symocmlgo/fU0SHTtNI
         Mcc0QtOa7m39ygftg4d8xtIQAo+CWTWkvM2BJAhabnUnP35ntV8CV3+fB/oIOGDMz89W
         66YD0R7lE0UYlvWH34Ux0TOSx5BctV0JTsu4iGTpNZUwVUCso/4JwUYL/3glwI4Xxffb
         ODbu/aDy+dk3RRi9UK4Y8nme701YHwf/dM7gPkuLT/XQumYdT39PJkJVSA2w6m+jnXUT
         Q7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604544; x=1732209344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yX1ctbeo28+FVZhHm1exPAhhxCYNjnwJ2QKHbMVupjI=;
        b=tnH5OVaGlR//AGxn9Agx8ercwDaKu1SJmHsSDJ+Z/V48UhYXKauXXI/oZ7U4L7Z7fH
         XBd3lWfCgD/0/i6zEghevgJ9KEEIDn0N8245mKEvlt0+sC2w0PEksT4zMQ/wLmNsbSLu
         pYIWz2Y8q6HFBo/6G988/7DaS5kGdrqm3Twm/fYtVbJ0zWWc6NpuiRpRanGleBjsNfM+
         w/kqr9ETgdbof9jIf+K2atVp4oT6nA+eyOmYe50lvS1OLqehHcLE36e2GljUBSHaTrlt
         vf/dGmtmCKaBqKQJVysR3+LmO8RKp26IIi3NvXrXM/W4XhjaTbZqr4B3kex5D0JPf2wq
         c8yA==
X-Gm-Message-State: AOJu0YyGkDGEIfZOl3qYY1IJajn8y5RTfGnY/aiAyDnWLy/Ptsrli9Cl
	cJf2f6LiJOgBJeIGpshOAgxiUCJZAL608KF9z5ilhRh/0mYIrWwp+/Jbpw==
X-Google-Smtp-Source: AGHT+IHGIO/y9V2b8ZXbZ73BMR+ecKkZH+yQroypB0vt7ZdhfyDF/R4hRTPRz/mhmdJvEbNxNBI4og==
X-Received: by 2002:a05:6a00:178c:b0:71d:fe5b:5eb9 with SMTP id d2e1a72fcca58-72469cd2921mr3555735b3a.10.1731604543659;
        Thu, 14 Nov 2024 09:15:43 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9bab91sm1539883b3a.149.2024.11.14.09.15.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:15:43 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v2 0/6] fix behaviors of git-push --porcelain
Date: Fri, 15 Nov 2024 01:15:31 +0800
Message-Id: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When executing git-push(1) with the "--porcelain" flag, then we will
print updated references in a machine-readable format that looks
like this:

    To destination
    =   refs/heads/noop:refs/heads/noop [up to date]
    !   refs/heads/rejected:refs/heads/rejected [rejected] (atomic push
    failed)
    !   refs/heads/noff:refs/heads/(off (non-fast-forward)
    Done

The final "Done" stanza was introduced via 77555854be (git-push:
make git push --porcelain print "Done", 2010-02-26), with the
following behaviors:

 - Show a "Done" porcelain message if there are no errors.
 - Fail to update a ref in a --dry-run does not count as an error.
 - Actual rejections in non --dry-run pushes do count as errors.
 - Return a non-zero exit code if there are errors.

This patch series try to fix the broken behaviors introduced in
commit 7dcbeaa0df (send-pack: fix inconsistent porcelain output,
2020-04-17).

--

Jiang Xin (4):
  t5548: new test cases for push --porcelain and --dry-run
  push: fix the behavior of the Done message for porcelain
  push: only ignore finish_connect() for dry-run mode
  push: not send push-options to server with --dry-run

Patrick Steinhardt (2):
  t5504: modernize test by moving heredocs into test bodies
  t5543: atomic push reports exit code failure

 send-pack.c                                   |  13 +-
 .../test-0001-standard-git-push--porcelain.sh |   1 -
 ...st-0003-pre-receive-declined--porcelain.sh |   1 -
 t/t5411/test-0012-no-hook-error--porcelain.sh |   2 -
 t/t5411/test-0014-bad-protocol--porcelain.sh  |   9 -
 t/t5411/test-0021-report-ng--porcelain.sh     |   2 -
 ...est-0023-report-unexpect-ref--porcelain.sh |   1 -
 ...test-0025-report-unknown-ref--porcelain.sh |   1 -
 ...est-0033-report-with-options--porcelain.sh |   1 -
 .../test-0039-report-mixed-refs--porcelain.sh |   1 -
 t/t5504-fetch-receive-strict.sh               |  34 +-
 t/t5516-fetch-push.sh                         |   3 +-
 t/t5534-push-signed.sh                        |   1 -
 t/t5541-http-push-smart.sh                    |   1 -
 t/t5543-atomic-push.sh                        |  30 ++
 t/t5548-push-porcelain.sh                     | 335 +++++++++++++-----
 transport.c                                   |  21 +-
 17 files changed, 316 insertions(+), 141 deletions(-)

-- 
2.47.0.rc1.21.g81e7bd6151

