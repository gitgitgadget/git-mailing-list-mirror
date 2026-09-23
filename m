Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185B415F32
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202436; cv=none; b=D/ePWO+laYEdKTMx/027JEwbnaRnjHyzCleCgNAb377Kzk55cipy6F1lVNbJPM0FUTaQu+U+eCBNIGYSkyPUXHVadNmdBt0Gbi02129r4Ev87z48V5iPglKmtRzEwDa65oC4ri8tPrIqxcIWUsJ0JsBSqs8GOKByBBu5gAmLJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202436; c=relaxed/simple;
	bh=+LeSOCG2glzIMs1W8T/8Zw1BlPzAZeH1PHJpa7mq+yY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=XL736TyHkV6ZKIWROHgjgIF2XWo9fYcDzcnvB6YWarQPGnjySnNtHLdoG8694e/D6NQbrRhxMbcSynuhpfxdCm+qBhugwUMFINir6ez36YrsRLjKE/zlyZAYd5Cg5QtrmGFP9MchEH7I/ZSQpBMfJGOLBVkn47PSQb7scRLC33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCPE3dsb; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCPE3dsb"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-804ef461aedso874552a34.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202434; x=1790807234; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+BqvTC0JPSmSKXlFifcRTztsF3Rj4R32lAqOI0nRew=;
        b=SCPE3dsbHuBiQMvnoVngTf0aAxtPz0snEzhLFFhmYzqldNMg5TNPMIXwYf2hKXQfai
         Jau7ty632a0Qa5sOFJRk8onL8YJ83pVfbuPLhacCTU5wN/ChZEW5PaYqXTHDWRllgvnb
         EUwmGemV6rJIaIdRx6mOnN6EsnIgwMGzDQzqccbyRgJ0eIz0oZcuoUOXjAjGwdbumuhc
         6t6mBVhFZV6HiAvvb+MJT4WcfM5p40l5c+J/sAcnpsoQkuyuWW+dm+uORqFdOe/5rhx3
         NPu1oDYUaMNwVZH8sCi2KRlS+usm+8ZdD2IhjVTaSC7D46hLnRNaJ0J7IDhaooI2y5EA
         DkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202434; x=1790807234;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N+BqvTC0JPSmSKXlFifcRTztsF3Rj4R32lAqOI0nRew=;
        b=2fSq0SFVMX0w+2fZBy93YMuMxZKNvUpxal+ZbXe9HWJUXDzefR6oB4Y1vYoMjP6kCq
         VmrLr1A6cn5+cs/2oYntNZfGs4SobN7NWoWslCDCN1BMFYmKhBEuqyH0RrcJzORFx5D1
         z/B/oLrBifvvObbTmNOZVoXWGHFD9PdaIR8wDiqmq0YQg1wkpGmC+bdQz4+VxUJDQvvW
         Nb0eONS5lkA2nBjRNd9IfrzT46IMaNJg248RyvCkyV5yZ2+9fKVhcdJmix8ZptWCI93e
         os0u9yNwyALyZFyLaroETO7D4Dq3vpa27JT1AKN/bec/+qcPti9oY5OVpF982sfqIO1L
         X72Q==
X-Gm-Message-State: AFuF++lT1mlZi0OI1FFT5aqvlhHMfC2VMpmno2qCQHQjCkhf45sM6Gxo
	UfZU/8j0QXkbFQ/uGLvTWnC1rAfRXDy0mGnOl7WLjtxDVRIx7lK/bNWw
X-Gm-Gg: AYBFou1+NPre+YagXZ1AhxL0HFLhP6+OniMECtHgLpx4DDrCl0fXxwH/wjlF04SpfpZ
	iBazTk9/1J/MvS509wznkxwDiZimKC1VUtBQUKypRSEkELnEdRQWtejHKedPTdQSCe/g3pLR5st
	lyG/9DRiQm1NuIN45BPHL56EPxoigBjZhjszznLY1Wl0H8swMwzHr9VOkrEVNChKreJBr8zto50
	DNnu8zhcLXVnDvayJzIH8tpN4Qb64kt3PLtbbHbZWpEf9WWc9RL7y+YuLbnkwEJ8eqtyXHpVDOy
	4AlOWjNyQH0IA+b3rudJYAZmGmkZc5nhp0rVSTPs8sHu17zuaMhQFH7/ty4NQgr7/LuFD1cBUzk
	8cPOvn2dfGOgEWeOVTdRTu/LfPeyX2E3EJ3ILGXFhEOFutKDF4yehbxq6sfX9AOgxRhtEtOafQh
	h1Lhy5GzI3B94tpAcyvfiqk3LOgUinLWIpgDDyqUQl/QTNSeAEQNvvlQRpBB+klVqS9dNDqtRCQ
	nW967T49OkrIQIuteSnSVNyggJNGbjRT03753FmM/1IK1lQN+LS422RNmNKBOncDjDBBRL9HYQi
	rXXiX/HXswevPlOTME+baa2t0ATdDBNDnPun4qtFux9EGpjzuiejd8dw+yviGwM7tascNUeMeDq
	si5F7EhzuvfIlFHgXwW1gfx4fhQ0m0TK33yYqB2R1b1k/D+z7g7OUMITkzW4=
X-Received: by 2002:a05:6830:a90:b0:804:8fef:42d8 with SMTP id 46e09a7af769-8178468a955mr669435a34.16.1790202433905;
        Wed, 23 Sep 2026 15:27:13 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81603ad0f20sm4727670a34.9.2026.09.23.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:27:13 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/3] ls-files: reuse and update the untracked cache
Date: Wed, 23 Sep 2026 18:26:57 -0400
Message-Id: <20260923-ls-files-untracked-cache-v2-0-d7ee33476eb8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBBGr0Jm7Zi2iBFX3sOwaKcDjPJjWiAaw
 t0FvIDLl7zvfTNEDsIRrskMgSeJ0ncrmEMCVNuuYhS/Mhhlzio3KTYRS2k44tgNwdKTPZKlmjH
 NstyxV9qmDOv8FbiU956+Fz+Oo3swDVtvM2qJQx8++/ekN++Pm0mjQnXx7kSkufTuVrVWmiP1L
 RTLsnwBjW3q3dIAAAA=
X-Change-ID: 20260923-ls-files-untracked-cache-3559bed01a3e
In-Reply-To: <20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com>
References: <20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com>
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1790202423; l=5991;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=+LeSOCG2glzIMs1W8T/8Zw1BlPzAZeH1PHJpa7mq+yY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH6+ilqPi8OUw5kgxeuN9dHZ9ZWj0u3Rm/qQW9H6M+VXPBfJ5FH4lC0vPTfBf8mGqNyuSHraCCx
 VGZnOVsYz6gs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Repeated queries such as

  git ls-files --cached --others --exclude-standard -z -- "**/pyproject.toml"

walk the working tree even when status has populated an untracked cache.
This series lets ls-files reuse those listings and save the work for later
commands through Git's existing optional index writes.

The first patch fixes inconsistent ignore-file hashes that invalidate an
unchanged cache. The second lets 'git status -unormal' and
'git status -uall' reuse the same cache. 'git status -unormal' still stops
scanning an untracked directory after finding an untracked file; a later
command requesting all untracked files completes the listing as needed.
The third lets ls-files use the cache and write pending untracked cache
and fsmonitor updates back to the index. --no-optional-locks suppresses
those writes.

For wildcard pathspecs without a fixed prefix, apply the pathspec after
reading complete directory listings. A first query can therefore scan
directories that its pathspec would otherwise skip. Fixed-prefix,
attribute and exclude pathspecs retain their existing traversal.

A new dir_flags value makes older versions of Git rebuild the cache before
using it to list untracked files. Changes invalidate cached entries in
parent directories as well, so updates can reopen more directories than
a cache populated with --untracked-files=all before this series.

On macOS, with 100,000 files in 5,000 leaf directories, half tracked.
Each group of 100 leaf directories has 50 tracked and 50 untracked.
Each binary populated its own cache using the indicated status mode.

hyperfine --warmup 3 --runs 7 (mean ± standard deviation, milliseconds):

  cache   fsmonitor  command          upstream        v1             v2
  normal  off        query            241.3 ± 14.8    132.7 ± 20.0   33.3 ± 2.4
  normal  off        query + status   292.7 ± 11.2    187.0 ± 10.8   92.6 ± 3.3
  all     off        query            231.3 ± 14.6    29.3 ± 1.3     34.7 ± 2.0
  normal  on         query            223.1 ± 17.8    111.0 ± 13.4   33.8 ± 1.5
  all     on         query            216.6 ± 12.0    28.0 ± 5.1     34.6 ± 0.8

"query" is the ls-files command above; "status" is
"git status -unormal --porcelain". These are repeated queries with warm
filesystem and untracked caches.

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Share the cache between --untracked-files=normal and --untracked-files=all.
- Write ls-files untracked cache and fsmonitor updates back to the index.
- Test alternating modes, cache invalidation and optional index writes.
- Replace the v1 measurements with results for the revised implementation.
- Link to v1: https://patch.msgid.link/20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com

---
Tamir Duberstein (3):
      dir: hash ignore files before appending newline
      dir: share untracked caches across output modes
      ls-files: use and update the untracked cache

 Documentation/git-ls-files.adoc    |   4 +
 Documentation/gitformat-index.adoc |  13 +-
 builtin/ls-files.c                 |  40 +++++-
 dir.c                              | 251 ++++++++++++++++++----------------
 dir.h                              |  16 +--
 t/perf/p3010-ls-files.sh           |  15 ++
 t/t3001-ls-files-others-exclude.sh |  20 +++
 t/t7063-status-untracked-cache.sh  | 272 +++++++++++++++++++++++++++++--------
 t/t7519-status-fsmonitor.sh        |  44 ++++++
 9 files changed, 481 insertions(+), 194 deletions(-)

Range-diff versus v1:

1:  896f1aea52 ! 1:  bf5e5eea24 dir: hash ignore files before adding parser LF
    @@ Metadata
     Author: Tamir Duberstein <tamird@gmail.com>
     
      ## Commit message ##
    -    dir: hash ignore files before adding parser LF
    +    dir: hash ignore files before appending newline
     
         add_patterns() appends a newline for the pattern parser before computing
    -    an ignore file's object ID. Its fallback hash therefore includes a byte
    -    that is absent from the file. The fast path instead copies the original
    -    blob ID from an up-to-date index entry.
    +    an ignore file's object ID. Hashing the buffer therefore includes a byte
    +    that is absent from the file. When the file has an up-to-date index entry
    +    and needs no content conversion, the function instead uses that entry's
    +    object ID.
     
    -    Switching between those paths changes the recorded ignore identity even
    -    when the file has not changed, invalidating the untracked cache below it.
    -    Compute the hash before appending the parser newline so both paths agree.
    -    Update the expected identities of the untracked ignore files accordingly.
    +    Switching between these paths changes the cached object ID even when the
    +    file has not changed, invalidating the untracked cache below it. Compute
    +    the hash before appending the newline so both paths agree. Update the
    +    expected object IDs of the untracked ignore files accordingly.
     
    +    Assisted-by: LLM
         Signed-off-by: Tamir Duberstein <tamird@gmail.com>
     
      ## dir.c ##
    @@ dir.c: static int add_patterns(const char *fname, const char *base, int baselen,
      			fill_stat_data(&oid_stat->stat, &st);
      			oid_stat->valid = 1;
      		}
    ++		/*
    ++		 * The extra newline is only for parsing. Like do_read_blob(),
    ++		 * keep it out of the file's object ID.
    ++		 */
     +		buf[size++] = '\n';
      	}
      
2:  fc65e91309 < -:  ---------- ls-files: reuse cached untracked listings
-:  ---------- > 2:  ae86ca623b dir: share untracked caches across output modes
-:  ---------- > 3:  126241f862 ls-files: use and update the untracked cache

---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20260923-ls-files-untracked-cache-3559bed01a3e

