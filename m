Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519FA3655FA
	for <git@vger.kernel.org>; Thu, 14 May 2026 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783879; cv=none; b=PsOmpC7LkyePVx+U/czv8WMGAyKtAVrS3kpEzyi3hCIfKYyEoF8K3V4MtY0d7bCXJMDnNnSqBFvReqWWV229KgIvpkciwFqDJnHuCwQJXuejQIVyUjccoe5KMfAgSwZ7SNJya3DK5S/RzWHxxbrXlu3gAUr6Ak4GSLMbVzdlzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783879; c=relaxed/simple;
	bh=gbFwAMd5fLBLWceJNGKeIlux3GJEu7vQ1JKuTVSXWec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3zHih4EY/OLF73pRYuIL240Hz3qBk/Yu35x1wSwDaOqtvVJqrAgPlyaAyHjytf4fQRTWCf4ZQb72it9KaQVNRwTgk5QEzjYA8vcL1hIvvXQEsiKqgSnGiThnnd6Ou1i/1xLszo8hbW50j860kwsJwlE0fvEmtq/87Q4N7bwZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7EyWVSJ; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7EyWVSJ"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479d9b155deso3014647b6e.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 11:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783877; x=1779388677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvqbjUSdHnlH+fs87s5Od+odS7IStX5+s2Z2egUkx+g=;
        b=K7EyWVSJ7d1FxyLEUbeufmxMOTeGOYYXTxpIT8yMoPWn9TzIydiR+IrG/Z5QAmM+MX
         O3L0el0sR2vc+f6Zp/zNwM1c5kDdpqKF/9CDlNpop+HEI+BdUYg8+T04pTJLZ3jJ/auC
         HUsPdPQ5OKd5i3HPgSV4RNReMYhVyYsUrN6Q6SZ1xeTLDubblEj5UvxFNO4Mt/kFRbvs
         FK1K1naUrK5Z9eDQo3FRREnveGUxBd9SY/AWYeqnY/q1fmXa+30GD/s6KfDd3R3W5Da8
         MHxbPGD5OtZcl8RBwmVMYiW/vKcK8eApMuJdihXXZmB+1MAvBLISqbtx2XqrJdhjys5x
         2pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783877; x=1779388677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OvqbjUSdHnlH+fs87s5Od+odS7IStX5+s2Z2egUkx+g=;
        b=jpNMaIDzqH7s3RGYxc+zZi+kuywuS/ftd1A0Atl1U6EKYu+PYEV4qFmwnMbROC2JJJ
         elSPsR73edJAvEERVRzaWSgAsh4LhpsQnxLbxBUJyXOxZElaFH+BhhkU4jQMFJZcjZ9K
         yCEQmVPnEFucDUSxKd0d2p2wEqzLQxFjSWoahn4KOC8WlUzAxAAbfoW3Dp2Jbs9QP216
         OGYhw44E7sABEuVFC0vE/LNVY1zGVHXdALNjziBAspCZfKmczmyw5ixfpgOAOvxliPYK
         Ey5SX5oFp/9gLagMrqt4UmBv8OY9rt3lD4YtXm7kBdZtpJBtUwyzRDimzwOjyKiD4SWO
         yqnA==
X-Gm-Message-State: AOJu0YynWdklVxYsrVZKQlVQSpqBy90wCavKDFVYBdxaMaiJnTUngv7a
	oSYBuFqKKIMmt+zLASn3HKW78g6hhNYYZUVzDZjtzyRP/8/Y2SN9X4Si4QQB7A==
X-Gm-Gg: Acq92OHfzhW/jFymKXW0QvguQu7gZlVLA8KFJm0quhtS5ERlr/Qbo8mpvLt8kA/R9UF
	Lft75ANqYHA6XQCGJQCha2Xi9cTLMVAJH3L5KpCWGZDFkrMMBvvaQmKbK7L8ZeXhtU0drVWfAPT
	mPzIYG5Os8If1jILQilNY1TCK0EmLAPh+i3CzXo20Sl2YvIUpr5yiU52K2AVsZEMgysX6pL8pcv
	kEouNTyASrGXEr0ZAvE7+YLwzszF/lBaB0BedEdp45f7+YRERX0ZcH+XNS4u3q08L+UcoWUOTdU
	yjj3Vbq51pc30FyCGhAfRfaCWvgA3/xuP9ceGynwOzCIHrOm639XZBBbeo/GpFQFk5YHV81Keyy
	+VQHfXL2dmKgJqiZg1/ZIFpTTQ05qrS3y125bSXzQ5KPH95Q26+j8j5DkamgCPR1M/wOXOLHsYB
	oya7xDoXeWG5iPW3JecZd5vQXNm96BCdY=
X-Received: by 2002:a05:6808:c2d8:b0:479:e75e:e3 with SMTP id 5614622812f47-482e57cf36dmr468362b6e.43.1778783877122;
        Thu, 14 May 2026 11:37:57 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4d7ff3sm2405955fac.9.2026.05.14.11.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:37:56 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/7] odb: add write operation to ODB transaction interface
Date: Thu, 14 May 2026 13:37:33 -0500
Message-ID: <20260514183740.1505171-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260402213220.2651523-1-jltobler@gmail.com>
References: <20260402213220.2651523-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This series lays the groundwork for introducing write operations to the
ODB transaction interface. The eventual goal is for all object writes
performed within a transaction to go through this interface explicitly,
rather than implicitly relying on the transaction to reconfigure ODB
sources so that writes are redirected to a temporary location.

For now, only `odb_transaction_write_object_stream()` is implemented and
wires up the existing logic for streaming "large" blobs directly into a
packfile as part of the transaction.

Most of the patches are structural refactorings to enable this, but
patch 4 introduces a behavioral change in how packfiles that would
exceed "pack.packSizeLimit" are handled.

Changes since V3:
- Fixed leak due to an fd not being closed when exiting prior to
  close_loose_object() being invoked.

Changes since V2:
- Renamed some variables to improve clarity
- Make `odb_write_stream_from_fd()` fully initialize the underlying
  `struct odb_write_stream`
- Move `struct odb_write_stream` to "odb/streaming.h"
- Make the `hash_blob_stream()` helper more generic by operating on a
  `struct odb_write_stream` instead of reading from an fd directly.
- Introduce an `odb_write_stream_release()` helper to free the
  underlying stream data.

Changes since V1:
- Fixed some typos
- Improved error handling
- Removed unnecessary guard statement
- Documented in comments why inflated object size is used to approximate
  if object write will exceed "pack.packSizeLimit".
- Updated `struct odb_write_stream` read() callback to support returning
  errors and using caller provided buffer
- Updated the `hash_blob_stream()` function signature to operate on a
  `struct odb_write_stream` instead of an fd directly
- Renamed some variables/functions for better clarity

Thanks,
-Justin

Justin Tobler (7):
  odb: split `struct odb_transaction` into separate header
  odb/transaction: use pluggable `begin_transaction()`
  odb: update `struct odb_write_stream` read() callback
  object-file: remove flags from transaction packfile writes
  object-file: avoid fd seekback by checking object size upfront
  object-file: generalize packfile writes to use odb_write_stream
  odb/transaction: make `write_object_stream()` pluggable

 Makefile                 |   1 +
 builtin/add.c            |   1 +
 builtin/unpack-objects.c |  21 ++--
 builtin/update-index.c   |   1 +
 cache-tree.c             |   1 +
 meson.build              |   1 +
 object-file.c            | 238 ++++++++++++++++++++-------------------
 odb.c                    |  25 ----
 odb.h                    |  37 +-----
 odb/streaming.c          |  51 +++++++++
 odb/streaming.h          |  30 +++++
 odb/transaction.c        |  35 ++++++
 odb/transaction.h        |  57 ++++++++++
 read-cache.c             |   1 +
 14 files changed, 312 insertions(+), 188 deletions(-)
 create mode 100644 odb/transaction.c
 create mode 100644 odb/transaction.h

Range-diff against v3:
1:  eee372b426 = 1:  eee372b426 odb: split `struct odb_transaction` into separate header
2:  57ac075560 = 2:  57ac075560 odb/transaction: use pluggable `begin_transaction()`
3:  11321ad607 ! 3:  d53ad95712 odb: update `struct odb_write_stream` read() callback
    @@ object-file.c: int odb_source_loose_write_stream(struct odb_source *source,
     +			ssize_t read_len = odb_write_stream_read(in_stream, buf,
     +								 sizeof(buf));
     +			if (read_len < 0) {
    ++				close(fd);
     +				err = -1;
     +				goto cleanup;
     +			}
4:  72d4656eee = 4:  fa7a3ad5dc object-file: remove flags from transaction packfile writes
5:  e4896101ff = 5:  1ca08e0590 object-file: avoid fd seekback by checking object size upfront
6:  b3cb0a707c = 6:  a548401057 object-file: generalize packfile writes to use odb_write_stream
7:  e1d292a7ed = 7:  4765b1024a odb/transaction: make `write_object_stream()` pluggable

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.54.0.105.g59ff4886a5

