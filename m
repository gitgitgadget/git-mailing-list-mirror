Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC633B464
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122726; cv=none; b=kRTFRRTLQCiQEQ+k/OVbToMmwp/7CXyu0hQTuuy7UoHn+LhMclBzLJNweeTrmKMJT51cbgj9DVRE1nSvAOp4GJoC8xirEADeO1Rw9tu6aPjf1jOsrMqFVZJaxaFxDu0Vy8wEJKUB0E5n9/MkyCIT8N/slOugUcJhSr5x13Ny7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122726; c=relaxed/simple;
	bh=1N3/HGCJplYapGHDZdyxFEnZGp6Hr9CrHrxM8pkbLu8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=euYHg8YcFcgmEbH7rnyIQwnPyQKyo5dtuWFkpzZFPNWa0j9QjOZLjZcbhG5vE7uavtvd9jhyZBSrsaIMFnriGANTmKaZnxrrrbUpAgtCoiJ7VjKgxKdRgW6Uvo/VKa8kn5R34umdaTXZa6xp+OASthhQDbHx9Wvh11EJvlHvROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzRX/Sy1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzRX/Sy1"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b04271cfc3eso870699266b.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758122722; x=1758727522; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpYH8MmD1Tnw2VAYsYppoxLVWJugh79VVdOySql3izE=;
        b=lzRX/Sy1r/pPtZc9Ck0QZ4mIEPZ4MNDi7ypCawYro5Cef7ZDe2YZt2uddGbJeNtqpu
         9AcFlk9Ldozau3HSKcxM2QpgtNLHK5uKcn8q4f0dwQXbeksYQM+wOFsW3NA2hn1Nvbbu
         8jkUItg1ezl1jpO+1DkMyK9CZxF0Fil+aJyeoeikOEqvFzskZDFqWw78pQ5Ry6e+3+HO
         VMYgGbxD2S7soI/qmxecN1riHs35L/Mx4r7+CQo0d6/BWyc/KwFTUkjvjUdBUXc0hCzq
         RtRomHG7Zkelg9ZcL87iign5uI0gwObtsAJD4Q/M0h8x2DAmtD1mYvxGj7k1gzP/a+n4
         OG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122722; x=1758727522;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kpYH8MmD1Tnw2VAYsYppoxLVWJugh79VVdOySql3izE=;
        b=h3BpnKHBhkj89DZhybZ0ltWGcEHMcc8huKNVJ70UeNc9zj++byPsnRXFk9UPq2kQqw
         +bmReqf4ltDejUHJ/U+IsqoAg8G6cWX2Bu0iLgCpwQ5Jf9xWVkwe0/L82m/FUWI2l6iU
         99K/wzKsjzO/U86fCPKe7f5Eu2eBfaQebiJb3yeRPsmc+dtevBAp3M8BYf5e02MZnB3E
         7CS8XXKNrLVbAG620CC/dqXqqnQW8nxWV/H5rktldSh/pL6YgVVXzHqOnSQDXbWMl+VA
         aVSIUL+odV6rTa0KauQcxV4uGw/U+BJ4nl1FNRfe33ksyTsWOhx6JETn02UloxBedh9N
         nlAg==
X-Gm-Message-State: AOJu0YxIse/d1j7TzfhpvDsRCF8vsp0C+aPbTMqrO4tq5Tdb11eNLOoR
	BoaWQ6XqK/h6hZOJOcVA/If9EKqQRQH8QViTONIg86oJxcJlF2ueUYgr
X-Gm-Gg: ASbGncuYiksw5GiAK/Yf+jxyJiVhRqD+/z0GUWTXYqC6pgWHLR5IBICIQ4olXPZCTok
	3Gs/xhyOkbPMIgeT8+jXjujKNwfzuxm5u2KV4e8ULDcbBzzeWTNnTKjU4yODvWdXfYd0c3v38mN
	65kW6d7HaiC1R4tc6v9d6N2294MtWjbx0a82hSkP5Tik+nCXfW8t5gfGA2gINu6iLuLOO5tgQDC
	SskAlHvJQP3nDTSsg+veX1kGluOMoF5EZ0p/WLmyQt3TWR6i7eGwkcpPazg5rPCHB5qwrVnrTje
	8pOfp+PpMb4zUB/wX1AdlwdT3i6aN1wW9mk2F8uQhpWjAfPfSH0bA9CneSjAa1UHfkPbWbp8X93
	7onx3hpxFYiKLJDbeUwIb9f8Uv5Sy
X-Google-Smtp-Source: AGHT+IFcXohhfrf/sRcxgybCqOiwZdZBhJ5b/zx11CX/XEy+Wcg761SxISPZOTHN6RaXTQBxbXTEFw==
X-Received: by 2002:a17:906:c14b:b0:afe:a6d3:b4a2 with SMTP id a640c23a62f3a-b1bb8ca5edcmr292713666b.11.1758122721482;
        Wed, 17 Sep 2025 08:25:21 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:bc15:cb75:326d:fed1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm1410380566b.83.2025.09.17.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:25:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
Date: Wed, 17 Sep 2025 17:25:10 +0200
Message-Id: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbSymgC/6XOwW7DIAwG4FepONcTkFBCT3uPaQegTmKphShEa
 FOVd5/TXqJdc/Nv2f78FAVnwiKup6eYsVKhnDi055OIo08DAt04Cy21kZ3WYDoLAy3Q4xJHUNB
 7upd3wgI5QfSFl1LBVGihijDjlLnMmwPSq85G62OrUDAyzdjTz+uBr2/OIxWe/H39U9XWfdNOH
 qarAgmNwYsLIRhpb5/Dgy98xPwQG131nusOc5q5oDHo1riAffjPNTtONYe5hjnljLk428pg7J5
 b1/UPN6WBAeoBAAA=
X-Change-ID: 20250822-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-0a187c7ac41e
In-Reply-To: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com, toon@iotcl.com, 
 jltobler@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7967; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=1N3/HGCJplYapGHDZdyxFEnZGp6Hr9CrHrxM8pkbLu8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjK0t/SeMUrYs68m3SAsFuUqgVFaMawRIY/6
 1Bd97xlnR8bJYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoytLfAAoJED7VnySO
 Rox/HD0L/RtP3pVNhcvi2/IXPtBk7idU3AJvk+3J7u1GAXwdwSpuKw6OZnZdsPuKDnxGftmMQSn
 rexF/YHCmKcqIU9ysOH68sjxkTHxu1YYY3raSNIQssWp7EPr9tYOinkql8tpfXQjyC5D9m+Am4W
 TL9tlFre+1sX8BLKeNLEiNauocXyb2NWeUhmMw4H4aAitxdSqBcazZMy3vgI1LIL2ho52P2xPZZ
 HcX0Z632jrf+oWKsGwswY6pM0l9ZFt+7bjHXwAmskhhJD/MCF1Iu2waB2YafpwcZcHjRg3lfFy5
 1ffGdH82DJph6pSGSq6E2YwjkZ8qQOZsT+GclsBcUNyNJ6O/fDNwok1wlu+8jcBEElTsKoUFe93
 cB6/HaYVa9XT5TnLMQ65OrS7vntZRpbjU8c7dtxDLqWJ7raAH5gjJwcpmNAZNpObOJhfI71lA+Q
 Xx37KLfrcVZxI58mtsBMvIkK+mT/SIZuPxbRcCPMRxQwCM/vBHM7d9lOIwoV6vjUWY1Vg6KlNJ7
 rY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Hello!

With Git 2.51 we moved 'git-fetch(1)' and 'git-receive-pack(1)' to use
batched updates while doing reference updates. This provided a nice perf
boost since both commands will now use a single transaction for
reference updates. This removes the overhead of using individual
transaction per reference update and also avoids unnecessary
auto-compaction between reference updates in the reftable backend.

However, in the files-backend it does introduce a few bugs around
conflicts. The reported bug was around case-insensitive filesystems [1],
but we also fix some adjacent issues:

1. When fetching references such as:

   - refs/heads/foo
   - refs/heads/Foo

Earlier we would simply overwrite the first reference with the second
and continue. Since Git 2.51 we simply abort stating a conflict.

This is resolved in the first commit by explicitly categorizing the
error as non-GENERIC. This allows batched updates to reject the
particular update, while updating the rest.

2. When fetching references and a lock for a particular reference
already exits. We treat this is a GENERIC error, which fails the entire
update. By categorizing this error as non-GENERIC, we can reject this
specific update and update the other references.

3. When fetching references such as with F/D conflict:

  - refs/heads/foo
  - refs/heads/Foo/bar

Earlier we would apply the first, while the second would fail due to
conflict. Since Git 2.51, the lock files for both would be created, but
the 'commit' phase would abruptly end leaving the lock files.

The second commit fixes this by ensuring that on case-insensitive
filesystems we lowercase the refnames for availability check to ensure
F/D are caught and reported to the user.

4. When fetching references with D/F conflict:

  - refs/heads/Foo/bar
  - refs/heads/foo

The creation of the second reference's lock in `lock_raw_ref()` catches
the D/F conflict, but we mark this as a GENERIC error. By categorizing
this as non-GENERIC, we can allow the updates to continue while
rejecting this specific error.

This also applies to D/F conflicts in case-sensitive systems where there
exists a lock in the repo 'refs/heads/foo/bar.lock' causing a conflict
while fetching 'refs/heads/foo'.

- Karthik

[1]: https://lore.kernel.org/all/YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM/

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v4:
- Fixes to typos in commit messages.
- Use curly braces for if..else clause with inlined comments.
- Link to v3: https://lore.kernel.org/r/20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com

Changes in v3:
- Rename duplicate_reference_case_cmp() to
  transaction_has_case_conflicting_update() and add comments.
- Improve commit messages.
- Add an additional test in the 4th commit to showcase D/F conflicts in
  case-sensistive file systems.
- Link to v2: https://lore.kernel.org/r/20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com

Changes in v2:
- This version fixes two more issues:
  - Fetching while locks already exist in the repository
  - D/F conflicts while fetching
- Add a specific error to the first case, so we can nicely show a
  relevant error. Also check explicitly that the issue is due to
  case-insensitive filesystems.
- Cleanup the commit messages.
- Use `string_list_append_nodup()` with `strbuf_detach`, reducing the
  number of allocations.

---
 builtin/fetch.c       |  21 ++++++++--
 refs.c                |  11 ++++-
 refs.h                |   2 +
 refs/files-backend.c  |  78 ++++++++++++++++++++++++++++------
 t/t1400-update-ref.sh |  53 +++++++++++++++++++++++
 t/t5510-fetch.sh      | 114 +++++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 262 insertions(+), 17 deletions(-)

Karthik Nayak (4):
      refs/files: catch conflicts on case-insensitive file-systems
      refs/files: use correct error type when lock exists
      refs/files: handle F/D conflicts in case-insensitive FS
      refs/files: handle D/F conflicts during locking

Range-diff versus v3:

1:  ec89ebee70 ! 1:  203a32f814 refs/files: catch conflicts on case-insensitive file-systems
    @@ Metadata
      ## Commit message ##
         refs/files: catch conflicts on case-insensitive file-systems
     
    -    During the 'prepare' phase of reference transaction in the files
    +    During the 'prepare' phase of a reference transaction in the files
         backend, we create the lock files for references to be created. When
         using batched updates on case-insensitive filesystems, the entire
         batched updates would be aborted if there are conflicting names such as:
    @@ Commit message
         This should be an okay compromise since with the files backend, there is
         no scenario possible where we would retain all colliding references.
     
    -    Let's also be more pro-active and notify users on case-insensitive
    +    Let's also be more proactive and notify users on case-insensitive
         filesystems about such problems by providing a brief about the issue
         while also recommending using the reftable backend, which doesn't have
         the same issue.
2:  e231d44125 ! 2:  f06c1a89b9 refs/files: use correct error type when lock exists
    @@ Commit message
         reference exists, then `lock_raw_ref()` throws:
     
             - REF_TRANSACTION_ERROR_CASE_CONFLICT: when there is a conflict
    -        because transaction contains conflicting references while being on a
    -        case-insensitive filesystem.
    +        because the transaction contains conflicting references while being
    +        on a case-insensitive filesystem.
     
             - REF_TRANSACTION_ERROR_GENERIC: for all other errors.
     
    @@ refs/files-backend.c: static enum ref_transaction_error lock_raw_ref(struct file
     -				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
     +			if (myerr == EEXIST) {
     +				if (ignore_case &&
    -+				    transaction_has_case_conflicting_update(transaction, update))
    ++				    transaction_has_case_conflicting_update(transaction, update)) {
     +					/*
     +					 * In case-insensitive filesystems, ensure that conflicts within a
     +					 * given transaction are handled. Pre-existing refs on a
     +					 * case-insensitive system will be overridden without any issue.
     +					 */
     +					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
    -+				else
    ++				} else {
     +					/*
     +					 * Pre-existing case-conflicting reference locks should also be
     +					 * specially categorized to avoid failing all batched updates.
     +					 */
     +					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
    ++				}
     +			}
     +
      			goto error_return;
3:  0100f5a48d ! 3:  e1b3f8106c refs/files: handle F/D conflicts in case-insensitive FS
    @@ Commit message
         lowercasing all references sent to this function when on a
         case-insensitive filesystem and operating on the files-backend.
     
    -    To do this, simply use a `struct strbuf` to convert the refname to a
    -    lower case and append it to the list of refnames to be checked. Since we
    +    To do this, simply use a `struct strbuf` to convert the refname to
    +    lowercase and append it to the list of refnames to be checked. Since we
         use a `struct strbuf` and the memory is cleared right after, make sure
         that the string list duplicates all provided string.
     
4:  64def2c0fb = 4:  5c4886a1fb refs/files: handle D/F conflicts during locking


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250822-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-0a187c7ac41e

Thanks
- Karthik

