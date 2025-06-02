Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D2225397
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875312; cv=none; b=EFnpeOSTbtXLeqXnuv/xzfv34OQwZoHZAzwgLHzmfPp0K0ZMrUXU2c4DoyQdnWAWZrVbNmnUK1ydvpaWLvX43qx/dSU9Cvb6b+cPwlg8Jybsm16a1qXZgH2Ifb/+JGg1faI+C75teffQjeiZ+LEMmotmRSAoLCwKhH1Mxct8bxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875312; c=relaxed/simple;
	bh=F+gdb+6hwL4UPsiLzlxwn2Z4LfYS3TWoH3/EGnMiZS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ig4XUx97ZxDFMd603MkQgxkgUX3/zCjk8BqogzM2kk68L6a0Wjw+c8+IrQLWKqJDban4UR/mpr9NKMJDO6oXbaSp6oYt8bySXdzAR3qs8wDVn2uSTRfDdd/ydM19GS7pO1Cq4Eo+X3MVnQYpqBJHerOZcs21/RlpVzkQlpNY9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uxc/pYws; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxc/pYws"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30e5430ed0bso4449195a91.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748875309; x=1749480109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZi1ALTfDXfyHDwmUV83tlM9ne+GzsIJO4fPTcyZTKI=;
        b=Uxc/pYwsArZ7DvNDrOjceAoOI1GAdkgCD+FHj9IvvbAL0JPphGW2Em9r+ahDXwEcoV
         kvn3ihR6Lc0xlfYsJqG8me8uBK5OhJEV35mZ2i5Pag9/mxHbCwrdoo1RHcWOe5IYW7R/
         M+ulJqjnhLYjeXv3cpQ2WqVxQV7TXo+mdL+TKhkEeQCRzPFI2KrCtrRLAoEfqBcL6SyV
         Alw57ZPmj1uO1d6+0NurhtByDy7XckILYKPNgasvTJPOnXa9djdqizV6ha0DBu1QHjLj
         5rY7YGnF6wKE9vtpkKMinlGSnr4qKV2vUmM7vwPUtzOgadTLWjybgQyMZq+B/p2QyxZn
         OrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875309; x=1749480109;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZi1ALTfDXfyHDwmUV83tlM9ne+GzsIJO4fPTcyZTKI=;
        b=udS4DpsCLIGJIVIy1QMjtNMmXRUkXzEnpY0rx62B4nVDCTAKXjJ2WB5i8ccxsARfUD
         0RrqbaQ4KNRd0g/xNcJbOIMnhhvk2ZmkTVE1X7fT2XQUCU3MRIMn7FI7HXCeSNbdTjT7
         Ts4rRlYrJ0SNPUMz/YDDkgXzht2gAH71chLtTcSBorTOUhCxSzBkYkKSIKvCZUjMmzsU
         SqFKYXznwc73ne8XVYV77en21VvWrgYtyXf9YuXjiQYUyOMfCH8H4tPsNQ5PolKsfyys
         2MRJJI0jFZXKvCOMhhvHIWxMyjvJfSox/2Lv4VfuFOjZJYaTB7oOztrAqTO1NK/BYHT8
         z0LA==
X-Gm-Message-State: AOJu0Yz1bH0R4Uumj912C7FjV3B6cYUlj3aMW9Emr7fpszOWrSewvToT
	HEFaJPUkeJFQk6onMsT41D2CGS/92dsmc9LKb/297RF3GTdDkAcXVenqXdYKy3QG
X-Gm-Gg: ASbGnctsPCaFFiM8SRpTuLXS8GRVFPGiO0VU1ybRqy0ivxEnpXoQxZ1ONuQaow5Vzg9
	lWhjAnmeVf829YVQRbwunKRKSG7Bqsdz9QncUPX2GFAv+SVgciCxSQeDoY7c54eo7Vc7o9zCbeN
	xzktIp9GPWljTndOgzdnw2gUUkzNpk157dWQUIjTtfN3nll0UXfuDm4pzBotAe8Mt4gvuCveWU0
	Tyeo9/1huq9taVxvN5RuXtdbUPprtUaLZXNlnDvRRQMxC5GbD8/pDl4GDWgyoW0NXQULx7/tFJd
	NYnEcNxgYhKNZ2WvJHJZUsCM+2DWFeQkrmo6ylTmQNTU+yLfQ5HAxyo7HA==
X-Google-Smtp-Source: AGHT+IExg2hj0ls/fCwRVMiuElHoaaxcN89ejVrGfzvYOYyvOex+3d8i/3HV9Etq/y8RhgNdTTweRA==
X-Received: by 2002:a05:6a20:6a0e:b0:20b:a75e:fa32 with SMTP id adf61e73a8af0-21ae00d2c7dmr21688839637.40.1748875298217;
        Mon, 02 Jun 2025 07:41:38 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2eceb0280csm5682925a12.4.2025.06.02.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 07:41:37 -0700 (PDT)
Date: Mon, 2 Jun 2025 22:41:35 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/1] fsck: ignore missing "refs" directory for linked
 worktrees
Message-ID: <aD24H3nVTwTq8JDq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD23w6-szFjKQGSj@ArchLinux>

"git refs verify" doesn't work if there are worktrees created on Git
v2.43.0 or older versions. These versions don't automatically create the
"refs" directory, causing the error:

    error: cannot open directory .git/worktrees/<worktree name>/refs:
    No such file or directory

Since 8f4c00de95 (builtin/worktree: create refdb via ref backend,
2024-01-08), we automatically create the "refs" directory for new
worktrees. And in 7c78d819e6 (ref: support multiple worktrees check for
refs, 2024-11-20), we assume that all linked worktrees have this
directory and would wrongly report an error to the user, thus
introducing compatibility issue.

Check for ENOENT errno before reporting directory access errors for
linked worktrees to maintain backward compatibility.

Reported-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     |  3 +++
 t/t0602-reffiles-fsck.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4d1f65a57a..bf6f89b1d1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3762,6 +3762,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 
 	iter = dir_iterator_begin(sb.buf, 0);
 	if (!iter) {
+		if (errno == ENOENT && !is_main_worktree(wt))
+			goto out;
+
 		ret = error_errno(_("cannot open directory %s"), sb.buf);
 		goto out;
 	}
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index f671ac4d3a..0ef483659d 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -110,6 +110,25 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	)
 '
 
+test_expect_success 'no refs directory of worktree should not cause problems' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git worktree add --detach ./worktree &&
+
+		(
+			cd worktree &&
+			worktree_refdir="$(git rev-parse --git-dir)/refs" &&
+			# Simulate old directory layout
+			rmdir "$worktree_refdir" &&
+			git refs verify 2>err &&
+			test_must_be_empty err
+		)
+	)
+'
+
 test_expect_success 'ref name check should work for multiple worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.49.0

