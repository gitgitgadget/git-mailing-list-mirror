Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E325A648
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100763; cv=none; b=q673gG8XxYJ/c9MeGKU3sFUj4uJ/CB5udXRu11/tkQG+pCFT8MFlEekEw3+dbNz2jp3wDQkTJIjNJiuuSjpHTltuvh10HZAdAhPLL4edUhG1VpYBj/D9W6UKgCaY8Dzi/nLPba8s6zcLCX8WPydSqC/v/toLcG3u3s452g2d77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100763; c=relaxed/simple;
	bh=zwVLB4Vq5UbdnfWVk1zoFhvI+KcWJuYuM8d0MdeHgpo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PIp/8nV5/dqcyglKJexZBtO7TPNiGUHNylvZnYysOf8YEKSqZCic8DhDhm36ocJHietD0DxFhGZi3jp/1ZUr2vDWJbvk1i6+wml58t+u4YdJUw5jBfaApj6VX1DsNbzxifTImwWT0oJd4Ok3U6zC7JOXpOkF1NygNaDGcF8GvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+QxcDX7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+QxcDX7"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21654fdd5daso30801525ad.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 23:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737100760; x=1737705560; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Asoh6Q+6jCltsKH1kdCb4DVFE6mat10+t92E43/NBxc=;
        b=V+QxcDX7hUet4jZS7DDHzZakIR4DOGeYT2vpA587i5qUcGJsdzov7oVi0mkotS704e
         Cnqp9SUgTM+zJBPwdWQjierC5BH/smh68GSXa94MoppdBhW/B4338D5tmG00c4bXgH3l
         ZedwgkymPjiEMy2ZTynIIu+6CKjBgS2+bKmiQVGzNsiEOy5NaeMu34yMe8AWHERwRaAJ
         W6J1syIeTfvsrpApbWRi0JDQ4cvAH9tJMORKVI6kysxCnLrgAvNZZWbANaEIybMvoKFV
         bqmj2AErx5XM6FLrT1jdxBKjyKCDbHGlfR9NSdho7wt33CoXaNvR27pkoqwnljgoh91X
         CVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737100760; x=1737705560;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Asoh6Q+6jCltsKH1kdCb4DVFE6mat10+t92E43/NBxc=;
        b=I5SbwJKzR05c3es7Nuc1UDrFI2amGD7cllaUfw/fT6FzLkyhlQSw3Imjt9szc4SGeB
         G8krHRy8BD+2M6XcoP6KPYGQq11NfXwCIjbrOgYAqPLh57gkUyAiM55yoU8WbFZX4JuG
         aklAe+8o2Tdy62gaS25RojQQiGHpF4Z5VkRnC+4Af5Wzu0gb0S+Xg6se25fNg1XfXlH5
         87eesZGMELML8DluutFtQ4Idkk15K3TNAs7bk/+JueSZ0vtqp3j/1DGAnYqk3cWEFhuN
         uzH1fUIEjQmXJraSDD18drs/r16JEvugCVgyg3KdwTJVTVXM5WQdTK9jKJD0y3nnn7BY
         akvg==
X-Gm-Message-State: AOJu0YxMF1vpHUituCEO2fHURkNwVogOUVIIyezDmEftLrJ0M3UZuPdE
	F4mTGkw8o9SYcfS282nmqXKPSCkimg0PXLGDifxEedBv3bQviAz8
X-Gm-Gg: ASbGncsDeDiYWcTVDNq9MeFBYbPtrZ+Xlsvwuc8d31QEhZ1tyZb3ad5viBRIIHHD4Hh
	U44S6nYardSHgWCggJPx1P8lW7eW7WuMdEpJFMHDhnJInX8jDZIlEg3waxr7MTn8r+r1V+EgG/6
	oaWBLRAimVMq2zMvLf48NaL+mq3j5ZQzrYRQUkJUszyaWXxBGYxVL6eJxo1QuOKHp8uQ8ck9FnW
	6Rs3chbjo/p5SQt1L5BNAWA2u1OBo/Q+77QUM5tkc9zqttAdEJ/IL0wRD4=
X-Google-Smtp-Source: AGHT+IFFcvT+GWkwDeGMDHXEOF/qoxcD/oocZSP4q5n4mz3uVVY+tAUbkp0apnzOaGHjDu4x+5qK4Q==
X-Received: by 2002:a17:902:ea0e:b0:216:6fb5:fd83 with SMTP id d9443c01a7336-21c35563091mr24318245ad.29.1737100759905;
        Thu, 16 Jan 2025 23:59:19 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d4025f4sm10517595ad.204.2025.01.16.23.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 23:59:19 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/3] refs: small followups to the migration corruption fix
Date: Fri, 17 Jan 2025 08:59:11 +0100
Message-Id: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8NimcC/x2NQQqDMBAAvyJ77kI2WgW/Ij1Es6kLwYSNtoL49
 4YeB4aZCwqrcIGxuUD5I0XSVoEeDSyr296M4iuDNfZpiAbsesIlqR55Z4/KYXdzZAwpxvQ9MvJ
 suAue3GBbqJVcFTn/h+l13z+sVaTncQAAAA==
X-Change-ID: 20250117-461-corrupted-reftable-followup-eb0e4fd1a723
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, sandals@crustytoothpaste.net, 
 gitster@pobox.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=zwVLB4Vq5UbdnfWVk1zoFhvI+KcWJuYuM8d0MdeHgpo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeKDdRUaL7kuIABOmUPlxU5SvHrr+DY9JNuV
 DF5kzlrL+B/OokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnig3UAAoJED7VnySO
 Rox/ZmUMAISiL9w8BMJ3c8Cqn+zw1SDfkXty0bYlelAv5eQJgIrLmufmPhiQpeaigo2Ex/twAhl
 S5JGRmvQyJMkEED0YAbrLXTgRAQYyvdqjciDLxz/TJOraAXnFldwnaW+BhJE/AUwDiT5kBS2HQl
 BB2LH1BT4xv0OYIxnGZCJfHR9pkqj0BsO72YcpH5jzr1hn6UVD4COBDN3cFPZmoLzLZRbLeBsZw
 19HDVh3UYgzsilTmLwHYLGC6uHjeHCNl75mLH1jcLjQ5w+o9Q+ud6LR9MOIT21xhl7VVfDcaoOp
 FnoslSkO64sMGQoIgpw1B2SvOK5+/YKW9Bgwf+e8NzUAhQ+1qxeo0ACCHbapKE425W3mC1EXFom
 cAaLohYbh8Rk0ffQq/dpHeQdwOA++f1gD5AHXDndDHWlCMHQom4Q26y0js8heGFPX6gAmIdmVRc
 QgweXvGv9rrf9x62Dax9/lynS8SrpkTzo3EOmx1WW8UXxnBkCSvO5Dr86D7v6mP7l6dkz1RYNL4
 Xk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This is a follow up to the bug that was reported [1] around `git refs
migrate --ref-format=reftable` where the migration would fail for
repositories with reflogs with lots of entries. This was caused due to a
mismatch in the reftable's header and footer, specifically WRT the
'max_update_index'.

While there was a fix posted. This series is a small followup to fix
some of the topics discussed there:
1. To mark `ref_transaction_update_reflog()` as static since it is only
used internally within 'refs.c'.
2. To change the type of 'max_index' from 'unsigned int' to 'uint64_t'.
This would be much safer for large repositories with millions of files
and on 32bit systems.
3. To add a safeguard to prevent 'update_index' changes after first
block is written. This is a preventive measure to ensure such bugs don't
arise in the future.

This is based on top of master 757161efcc (Sync with Git 2.48.1,
2025-01-13) with 'kn/reflog-migration-fix' merged in.

[1]: https://lore.kernel.org/r/Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Karthik Nayak (3):
      refs: mark `ref_transaction_update_reflog()` as static
      refs: use 'uint64_t' for 'ref_update.index'
      reftable: prevent 'update_index' changes after header write

 refs.c                  | 18 ++++++++++--------
 refs.h                  | 14 --------------
 refs/refs-internal.h    |  4 ++--
 refs/reftable-backend.c |  2 +-
 reftable/writer.c       |  7 +++++++
 5 files changed, 20 insertions(+), 25 deletions(-)
---



---

base-commit: a5aa44e7930761cb900813d971b4105f901818fb
change-id: 20250117-461-corrupted-reftable-followup-eb0e4fd1a723

Thanks
- Karthik

