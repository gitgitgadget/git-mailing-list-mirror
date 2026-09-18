Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A43DE425
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700626; cv=none; b=Mt7n9xK9hrPR85ZQ8oWIvsfkfVUqUMHH5d2xP4Wke0E8wln/woSdkId5JE0pCyAvvpfOf66WBijxp/JNm422RkM2W9S9xshEKZVnHRIiyrhhYy82ZZ9TfEhRcPaL13FfjvJzJPYzvSgV5Yd6ayMEz7q2T46vEJVafJDZk7Vxcek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700626; c=relaxed/simple;
	bh=tQU1DBJtBK76crRixbt0BwyC8QE/9X+yxfHdgJ1Sv1c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B6QdtiiWyIIVemFcZ+IaM1b4462lHOrC9bWnOYH7ZMJwHj2Nx5AjtTLlUhq6mLfOCntqBq0Ou67omOy+Jx8+og1JVEufJArSiu4zumTVRvjr/0jZNebWh0VDrd0sRKil7GhELjjnHz/mJ0/e3sErSEV23GXfBYP1bTcg5XCDbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihljAbK6; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihljAbK6"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb767cc7fso2490251cf.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 20:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789700617; x=1790305417; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T4dQSaIqCm668XucRyyMiJOi2E6UJHEgCM+rNC9Kajk=;
        b=ihljAbK6cFY+UhGtG7eA/diPRqfBrCt5sUW6rWsrIBJKc2YmqaGG32n5FovwNeAtts
         9gANseQPFhcjA9QJMdAcS6lfEaQvHj3gbu+7sh1zbkZAComxRH+skBeQ2obav0Y5psfE
         f/NRYtcnHvU/R+ATZ/iMTpA66Zm6/dc+5BhxM/+dWLzSAMboUB2XWz2I1ZmFt8TK2Aho
         XgeBl1eoM/6ILDPjW55Dr4Vi5/VjtESeQd3J9ZK0Fjhh7GoaehcKcCCM3bHZuqJxiTeB
         zDoYv76QqqCI3biWgK1gSF0jWJPI39tjOU9lwLNrKEI+lb6/adh9xq7x9Dg7JBg03dNb
         doJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700617; x=1790305417;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T4dQSaIqCm668XucRyyMiJOi2E6UJHEgCM+rNC9Kajk=;
        b=kWODK0Sr17L06RUnPrXRKLJbSTN2HOng3bKXDw92mknBSufazXbP1v0vENjOMqIwpm
         5K3wfEAvQ6B8Htbopk3liyHf7zOikStpqkEfbn/NuN0tRfyAbt/B+sOHR226w9PqjojL
         cLtJgdXt+eJP6wJUCXE46kxEM0BbKw5Pr+w+uAVCjLfyFJ38h8KL4+WnvYsOBPqodEw7
         KI9laisREOWTJqWFH/SCW/cXdX6w7GpJoz4s+HBBPV7fs/6oUt7j3qO/ASorP39sq0tD
         3wD++MEfdp6NuCAH30zeTz/micmpwf9P63j9Zi9UeQHmRxBqDJF2Q550aGf0ZYbIIBAp
         GxBw==
X-Gm-Message-State: AFuF++k54UHqAgjgWEpdbYEnnaF5qWfthBJeJogVEenBZnmrmICdlQDz
	n6qMlVDVPG/bEYq0jw2AdnYjY21x/tFBYvJZkPg4mN62RPvRx/m1xAgnmGdaBw==
X-Gm-Gg: AYBFou3DeROKRNRskOj1IXcufF9CJENZ7y76Fc56sIGzQyZGNiZ9WTEkjbwa74kRq9L
	w7EoNLvofETweS0FLxyjLKpf+ew4oUVOkgJ+TuDfgPF2bIpVhvlOuyQndMqjYjQbV2n1aiAF1AF
	NimuKY3ZpU6GD5jOqY/NfKaysTVWrYFm8t1K1H1ojgBL9HVp7V0xonCn21wX8uRErIYWGahPO6Z
	VyZan6C5ttA1beuxHmHuJQRnNZGA1PZcdnm/yqfaHijDMUbRKnPxPfgH3UqfI0nr1kTGDZ3sz9u
	50N2h+AANrzCXHrsdcEHXmhlKg2iPRoKNd4lE6X/VuCd0xoNN6p99jkbUp3Lu/drqCFZ3K/zSzK
	PiOAH6K6GH+uXyST8OcDQh7SW8a+t1eX6u+1XhGWTp5gmx1yMeGPNpGZiY7IlJg7QH9Cu/UcrAN
	tVvLKAPwEL5ILFDTS0klCYFZp6kxUJ+h+YbXGjEJJkE5G980MTLV24k0W8FTj83cQ96kPGQ0K/s
	g==
X-Received: by 2002:a05:622a:e18c:10b0:532:9eb6:83a3 with SMTP id d75a77b69052e-5329eb6997amr12950161cf.40.1789700617397;
        Thu, 17 Sep 2026 20:03:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.198.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9125802c8d8sm2438636d6.23.2026.09.17.20.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:03:36 -0700 (PDT)
Message-Id: <pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
From: "qeesung via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 03:03:30 +0000
Subject: [PATCH v2 0/5] repack: don't lose objects to a ".keep" that appears mid-run
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>

A concurrent push or fetch can make "git repack -d" delete a pack whose
objects were never copied anywhere, and exit 0. We hit this in production: a
ref pointing at a commit that no longer exists, on git 2.43, and it
reproduces on master.

What happens:

 * repack scans for ".keep" files and decides which packs to delete, then
   spawns pack-objects with --honor-pack-keep, which scans again;
 * in between, an index-pack --keep finishes -- a push migrating its
   quarantine, or a fetch -- and installs a ".keep" next to a pack that
   repack has already decided to delete;
 * pack-objects sees that ".keep" and leaves the pack's objects out; repack
   deletes the pack by its earlier list, with force_delete.

The fix is to stop the two processes from scanning separately: hand
pack-objects the snapshot repack took at startup (5/5). Patches 1-4 are what
5/5 needs to be safe:

 * 1/5: under --stdin-packs=follow, a --keep-pack pack stops the traversal
   like a "^" pack; on-disk ".keep" packs never did.
 * 2/5: the cruft walk goes by a stale kept-pack cache, which
   --honor-pack-keep happened to mask. Pre-existing, reproducible today.
 * 3/5: look --keep-pack names up in a sorted list; it gets long.
 * 4/5: --keep-pack-from-file, since a repository can have more kept packs
   than fit on a command line (32K characters on Windows).

Every fix comes with a test that fails without it; the race itself is
reproduced in t7703 by having a ".keep" appear as pack-objects starts. The
full suite passes, and the series merges cleanly into next and seen.

Changes since v1:

 * Dropped 1/6 (odb: don't remove a ".keep" we never installed). Justin
   Tobler is going to fix the receive-pack side properly, by having the ODB
   transaction create the ".keep" itself at commit time rather than reading
   back what index-pack wrote:
   https://lore.kernel.org/git/aql8Wt2q9RnQpjEC@jtobler--20250820-SHC54/
 * The remaining patches are unchanged apart from renumbering.

Qin ShiCheng (5):
  pack-objects: keep --keep-pack open when following
  pack-objects: reset kept-pack cache for cruft walk
  pack-objects: sort --keep-pack list for lookup
  pack-objects: add --keep-pack-from-file
  repack: tell pack-objects which packs are kept

 Documentation/git-pack-objects.adoc |  8 +++
 builtin/pack-objects.c              | 71 ++++++++++++++++++-----
 builtin/repack.c                    | 15 +++++
 odb/source-packed.h                 |  3 +-
 packfile.c                          |  9 ++-
 packfile.h                          |  7 +++
 repack-filtered.c                   |  3 -
 repack.c                            | 34 ++++++++++-
 repack.h                            | 17 +++++-
 t/t5329-pack-objects-cruft.sh       | 40 +++++++++++++
 t/t5331-pack-objects-stdin.sh       | 87 +++++++++++++++++++++++++++++
 t/t7700-repack.sh                   | 43 ++++++++++++++
 t/t7703-repack-geometric.sh         | 72 ++++++++++++++++++++++++
 13 files changed, 386 insertions(+), 23 deletions(-)


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2219%2Fqeesung%2Frepack-kept-packs-snapshot-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2219/qeesung/repack-kept-packs-snapshot-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2219

Range-diff vs v1:

 1:  932e8e425a < -:  ---------- odb: don't remove a ".keep" we never installed
 2:  9349ea48b0 = 1:  8cf72312c5 pack-objects: keep --keep-pack open when following
 3:  a1b85c0a25 = 2:  77aec8941f pack-objects: reset kept-pack cache for cruft walk
 4:  38070935dc = 3:  b76e06a467 pack-objects: sort --keep-pack list for lookup
 5:  f8e27b7aac = 4:  20a051cfb6 pack-objects: add --keep-pack-from-file
 6:  a18e354e73 = 5:  4684fd8552 repack: tell pack-objects which packs are kept

-- 
gitgitgadget
