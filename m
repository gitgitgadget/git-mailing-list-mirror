Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CE5BACE
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528136; cv=none; b=s5rjPieqH92gx3A7VRWqeo5sptWH2TqQB6yDqalZO2RYjG5+mqXdjpmtc0rL/RTUAmMS0cPg3eM92rAgMiXdHuQ/+cWXXGjza9Rj5wtdM0pIGjNjzSLyzK0UuuD3fflszHtWteHQ6e5lzHI51C8s2iiAzAkG4/VB3kMEUtNCRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528136; c=relaxed/simple;
	bh=u45Z3Ri8Y4mAPUg+TlckLMZ+de+4ghUD7ekSr4VJ76Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duq5SXG9rJ4b+Fx/IYa8xiRznJXJwKOWqwLzkPU1sNmfeEfSSDCeN1p1hsWvTWPRLj/RO9W85UG5HodUr2ifPKYrkHa80bmXcHVSHhx31CrSncgnrI8eZ/6l9iAmk5lx4hO6mWIttbBNkso/IvW3NaT6uanaR7w+1IQwv2FVyXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5mxd2Vt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5mxd2Vt"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3566c0309fso161184166b.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 03:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706528132; x=1707132932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PPaBWCFuFc7taOIm6qw4vtRT3uzdm7wj0WTRvg7pE4=;
        b=P5mxd2VtE/F/LjO3UU7sokZ+snwYVJGUza0n7OiOFRCQRkJV3UkcVJMcc6LLH9lB9X
         VvgHGgF3XtTUEgvP0bVF5tNd49v1yZC0dR6QT0JdJyPbC/acWh2U30KlzLkst+P59PK2
         bCzsRUUJBz5iHKJgYUwYMBogeNVIbOo06xCZMZ5Tu6dQt9/PBdkrCxoaYJ/ZRfgDP4mK
         +uetmXU4lj1t0/EBxzQx1Tbnp3ajAo7iwCl9HxJL5WvYU5QMnowLuC3ukxqeMfGDaIJ7
         I1U/mKsNhU6vCzb1KigiEz0v5vuapA71YpJ7RNDGOWuF+2VwBnEXdVHbNiL4e6KQZPSI
         s61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706528132; x=1707132932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PPaBWCFuFc7taOIm6qw4vtRT3uzdm7wj0WTRvg7pE4=;
        b=VyYe5rae1KoIgM6a84B5zVWthBbQFcZYs1Z3WogvOY+zx9QH39OjAF7cMKNYQNluQl
         7Y/Bk/pqppk/luYP0G/7XbeW0XUg5j5fSBJ7Npd7+PMtR6rUoElv5WMiK5Yc/fFKQjPU
         CL8ud+cgGliq6iPi3zKF7Grxc1zuFS1+2fWqIei1e1zDXazun00APw7EkKihyTl5VUS2
         KcAFhr9WGbCgwyNfOBqSYGKAQFdWyEt3xLn8CKFtm43G3Zb7mctZPhqfZowC4uYGMST7
         Q3ltWcWE6O2hojkHd/i3+4S+aI/EAXPbDh3UDASbyFiXEpH4za0QG34SYDvzSa+NDLaX
         GHFg==
X-Gm-Message-State: AOJu0YylJrg15xVTL3X/0txlIPK+KSZL0KrKbno1jVEaNhcd0OImZpO1
	I9UDKs6+YOEol908mvtzfXN3rGV2EP1COorA9ztOqs0VzeR3rPaHhjYwbPVc
X-Google-Smtp-Source: AGHT+IFidci1FEWKfKDGm1SUjYZlrnS+ZEUYoWX4sdZJa7+yAVRLs/sM8k26MdYuYBHy1ytfc7xUwg==
X-Received: by 2002:a17:906:b0d:b0:a35:dafa:a5d8 with SMTP id u13-20020a1709060b0d00b00a35dafaa5d8mr920652ejg.73.1706528131617;
        Mon, 29 Jan 2024 03:35:31 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:74c1:f49b:306a:744b])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906070900b00a35a3e2b90asm1370325ejb.149.2024.01.29.03.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:35:31 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/4] for-each-ref: print all refs on empty string pattern
Date: Mon, 29 Jan 2024 12:35:23 +0100
Message-ID: <20240129113527.607022-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119142705.139374-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the second version of my patch series to print refs
when and empty string pattern is used with git-for-each-ref(1).

With the upcoming introduction of the reftable backend, it becomes ever
so important to provide the necessary tooling for printing all refs
associated with a repository.

While regular refs stored within the "refs/" namespace are currently
supported by multiple commands like git-for-each-ref(1),
git-show-ref(1). Neither support printing all the operational refs
within the repository.

This is crucial because with the reftable backend, all these refs will
also move to reftable. It would be necessary to identify all the refs
that are stored within the reftable since there is no easy way to do so
otherwise. This is because the reftable itself is a binary format and
all access will be via git. Unlike the filesystem backend, which allows
access directly via the filesystem.

This patch series is a follow up to the RFC/discussion we had earlier on
the list [1].

The first 4 commits add the required functionality to ensure we can print
all refs (regular, pseudo, HEAD). The 5th commit modifies the
git-for-each-ref(1) command to print all refs when an empty string pattern
is used. This is a deviation from the current situation wherein the empty
string pattern currently matches and prints no refs.

[1]: https://lore.kernel.org/git/20231221170715.110565-1-karthik.188@gmail.com/#t

Changes since v1:
- Added missing comma to the end of the `irregular_pseudorefs` array.
- Modified `is_pseudoref` to only work with non symrefs.  

Range-diff against v2:

1:  116d4c0e6d ! 1:  2141a2a62b refs: introduce `is_pseudoref()` and `is_headref()`
    @@ refs.c: static int is_pseudoref_syntax(const char *refname)
     +		"BISECT_EXPECTED_REV",
     +		"NOTES_MERGE_PARTIAL",
     +		"NOTES_MERGE_REF",
    -+		"MERGE_AUTOSTASH"
    ++		"MERGE_AUTOSTASH",
     +	};
    ++	struct object_id oid;
     +	size_t i;
     +
     +	if (!is_pseudoref_syntax(refname))
     +		return 0;
     +
    -+	if (ends_with(refname, "_HEAD"))
    -+		return refs_ref_exists(refs, refname);
    ++	if (ends_with(refname, "_HEAD")) {
    ++		 read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    ++		      &oid, NULL);
    ++		 return !is_null_oid(&oid);
    ++	}
     +
     +	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
    -+		 if (!strcmp(refname, irregular_pseudorefs[i]))
    -+			 return refs_ref_exists(refs, refname);
    ++		if (!strcmp(refname, irregular_pseudorefs[i])) {
    ++			read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    ++						  &oid, NULL);
    ++			return !is_null_oid(&oid);
    ++		}
     +
     +	return 0;
     +}
2:  4d4ca1cb26 = 2:  c96f0a9c83 refs: extract out `loose_fill_ref_dir_regular_file()`
3:  a5c0c4bf31 = 3:  d165358b83 refs: introduce `refs_for_each_all_refs()`
4:  a1c6537815 = 4:  a17983d0ba for-each-ref: avoid filtering on empty pattern


Karthik Nayak (4):
  refs: introduce `is_pseudoref()` and `is_headref()`
  refs: extract out `loose_fill_ref_dir_regular_file()`
  refs: introduce `refs_for_each_all_refs()`
  for-each-ref: avoid filtering on empty pattern

 Documentation/git-for-each-ref.txt |   3 +-
 builtin/for-each-ref.c             |  21 ++++-
 ref-filter.c                       |  13 ++-
 ref-filter.h                       |   4 +-
 refs.c                             |  46 +++++++++++
 refs.h                             |   9 ++
 refs/files-backend.c               | 127 +++++++++++++++++++++--------
 refs/refs-internal.h               |   7 ++
 t/t6302-for-each-ref-filter.sh     |  34 ++++++++
 9 files changed, 225 insertions(+), 39 deletions(-)

-- 
2.43.GIT

