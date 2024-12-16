Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C91FF7BE
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352423; cv=none; b=h2/OalmIYD3fD02e0xrP1S5mdzz+GB3mkGlGC6c/Qc57PB5WlRUjeCu1Fyy/xBFAQOGxp6j6o0RuaKk7HMdTXH1ud0fAqhLUMbMN+COiUwSayHyjQ0UsEXlIwsoWbF3PgAuFTHNH9eBRoIX08ozV3suVs0uqeAa2mPRxK3oZNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352423; c=relaxed/simple;
	bh=5gK79rFqKTmvuuEooB5+lUcC/3XeL6w2s9plPg1EryA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i7tEAJkjpfkl2l+ULtJSG/i1wrUew1aHjhxxpydB6OD228SxPKgK2sqY3k0g7bzgSqI54QeI6U3Aghz44Cw7F/8mqAqCWTU0RDiB1CpvpuTcJNrAlCRR3pB4R2oBUrQMyDjHAmNYiYiA7BQ2Mu1JNm0aetRQJa8W9krSWMEgjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMAaSLBv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMAaSLBv"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so2381122a12.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 04:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734352420; x=1734957220; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5gK79rFqKTmvuuEooB5+lUcC/3XeL6w2s9plPg1EryA=;
        b=eMAaSLBvKBJmfpxuIMnoxdzPvQ3FbS0wLegFXv+VJyGz2rumuVrLZAJhkQmoOA47XR
         3ymx/vajoqgqUuEf+/gstDeKhJYi+LOaPtTqQdBDFtFi5xeM+AJszWSn2IbkGdVzrLK4
         +Wj7vqsavvOKwEQEpp4s/SmYibsrPOYBDp9Iji4203o8HUDWbGUPG2O2PH6yHKiWznvk
         FGLdlF4ER3x/D2R1dZ/tzJ9/1csuXXcxLMlgBU7TrBdBrywWOjSPjlhQdrs6wfx8PHzv
         92p6axwmEWJl59CePGZym8apfU0oW9CBEaQ8pIcxfDjdnql8NVndamyCyy5XG4EL2hAl
         GmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734352420; x=1734957220;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gK79rFqKTmvuuEooB5+lUcC/3XeL6w2s9plPg1EryA=;
        b=neHuVx9TqeC+LEAQAS4CQrsrh+7KNVqaQQgzWtp4mqO2BXg1zL8gdmvR51qEmjDLot
         LdFWpCwN2SWMG+6KM50sP6aIxAM92P0Yv2KJ5tGQcQen1rRFnDtondjinxG2Z4yP3Vmr
         jxuRORp9Aug9bd0IdIotswH7JBWa7vSc34mGyKwepH3NWhEVBXjmC14zcDQoM8XQPA0G
         VmIoiWkOK1F6jJbTq0qVhzgMjBmqAr63EsXfbttpvP104I1BO23k5sjr0hyywJejuMaz
         uxTpCmafSVxv4s9K/B5mOrk5NU3YWJ4Uvsdd/zbwxhrL6cLAZ25Igscc04kvV2ejG2LP
         CXug==
X-Gm-Message-State: AOJu0YzkIUptIAyN1F7UDCdCkaTspk0saHtWX6mAYfeXahMRuEu4E2DQ
	MDj2Fnb7SBfY5jQtNICFbLcvfHEe37yMKkvoixqVxhzIUMxMb3+aw2dLBaICNw6m/YIx7hh7UFP
	EqFCF7fJx+gnSFQ0Pncq5MBBg2Q7mCwZd
X-Gm-Gg: ASbGncsTFlelz9SFc2EiEn++yL54e8uQjrpo1UUEa01CMTFLKhPZaRL5J+Bv6OdDpNv
	dDGUHs+BZ1c2G9XZPahZHG80+8pRD3adrJnx6WV8=
X-Google-Smtp-Source: AGHT+IEJ+ic8KQh2G3uqfD0wBb56lyx7cswSbvShke9oWtqNcVavgJK1ZFqE2wKHX9ax4ZJnbI/UlOMPtXDsNGXOo8o=
X-Received: by 2002:a17:90b:1d49:b0:2ea:5e0c:2847 with SMTP id
 98e67ed59e1d1-2f28fd733dbmr15662971a91.22.1734352419701; Mon, 16 Dec 2024
 04:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Mon, 16 Dec 2024 18:03:03 +0530
Message-ID: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
Subject: Consider adding pruning of refs to git maintenance
To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Remote-tracking refs accumulate quickly in large repositories as users
merge and delete their branches. While these branches are cleaned up
on the remote, local repositories may retain stale references to
deleted branches unless explicitly pruned. The number of local refs
can have an impact on git performance of several commands.

Git currently provides two ways for orphan local refs to be cleaned up =E2=
=80=94
1. Automated: `fetch.prune` and `fetch.pruneTags` configurations with
`git fetch/pull`
2. Manual: `git remote prune`

However, both approaches have issues:
- Full `git fetch/pull` operations are expensive on large
repositories, pulling thousands of irrelevant refs
- Manual `git remote prune` requires user intervention

Proposal:
Add remote pruning to the daily `git-maintenance` task. This would
clean stale refs automatically without requiring full fetches or
manual intervention.

This is especially useful for users who historically pulled all
refs/tags but now use targeted fetches. Moreover, it decouples the
cleanup action (pruning) from the action to fetch more refs.

Happy to submit on a patch for the same unless there's something
obvious that I've missed here.
