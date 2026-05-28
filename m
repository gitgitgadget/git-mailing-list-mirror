Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500F34389E
	for <git@vger.kernel.org>; Thu, 28 May 2026 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946927; cv=none; b=MiiZ0br5cYeUHvMsgzxa3plgQ2rs5hj7+6OPCzUSZcqqzW9Kw0jOlLaXghT7+k2Fq2K0bSdfmUUvL6JfWloXGX0XTD5QGTyfd29eQ42ZUGTI8Ny561H3dD7ZLPIY9Ef5Wl/DZ2HSwVZcS3+vgs5h2Orz9YWujoJynqugVPWq6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946927; c=relaxed/simple;
	bh=ZILsq6KUpSUBDrEMqERn4glDRXwEqrbl132DBjuZ0I4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=BLow1QAVw9rZJJTeD4CQkxyu1yHsx9DfCWevVM3uiSrS0tTPWJR7y5cKjxXgZQiaisqtKZmnVbNF1RV7Xn3Txmxhl57onFBVSaZmYK8PwJ/6TgygW9wirhAb+wwjtA1mHdeR5eHwWpRop7lnp3N2MXWUUzt0c1K3Oim3vKcZYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3qmOQ39; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3qmOQ39"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4855003f70bso4147838b6e.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 22:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779946925; x=1780551725; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vgvYRCNyA3Mj0XaIpTmIaliowI4mxEvo6obOI85VtBw=;
        b=W3qmOQ39C/1S0YH8zHQhSaHBaot7sy2ezyaeuARqbVKvx7U6RF8YgQv7l6fcCcgm27
         HsZ24nShGJw08RTc4/DoSuMj2ibqahUN7+ybT+fighe67wE2pXVeKTVmwfYoBJ7OUxs2
         x3RRIBBAVyU33CGKYtMyVic68qcZwiiPbXeWBshcsfYLW0XYmmGcFITerTRHyJyFwy/i
         zOaeL3kuF9pOCvnuPp/amF+WLZvBFEKqORGzf5zzyLjgHW3/ZL1AuAp00XK4UONXZ+z0
         fyS3mtlQOjhqSLVF1L62k7UXhsq9JZmlAw6AnHZ+fz4G5vwMg+4jIBbAVE2IUsGhROuy
         UzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946925; x=1780551725;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgvYRCNyA3Mj0XaIpTmIaliowI4mxEvo6obOI85VtBw=;
        b=cT9Ix32XaCGaLYvhGM5JwjASSszYUyBhf1WnqN05L06mt/dDDKjWjzn2Ts/Zqt8x9x
         JCdrs7j7Q0qlDCbSYp1s5TmYshH6t3lwoErwxG7BtgDPpWbKD4YxBPed6NGZTmUMsOVI
         /n8vowpdMadl8jVt+ibcaPhmvhSxNKRf9NiFO13cCqApyRv0NRf6F3aO5fhld8x9nE11
         A8Oxg3y2TTCMO/5LnBySsarfL9Tg1BsJr5YKWs45VTmiO5iy72mFwFkPy8sEJo+7uauf
         tlByLZNUP9SqBvXpzxfaXSkkSLU3SvaiOfF8Cn80wrFRbosCvG2gts7DIEPQ2aPznGxb
         FrAA==
X-Gm-Message-State: AOJu0Yxnln74GZtUbP6qOuoU8FpDX1Ueef2g2s6neaWKTuw87CbK26V+
	G+OE0jJb1gVoXf91x+4Z5B+PpQkutgiCeMEVxAJfvToYVx1e6OEpUOEQVuSP4A==
X-Gm-Gg: Acq92OFJyvRVSBryHz1E/IGrmMrAxojpSQZPS57G80RLNwShDglcqrrkDd3HhVdq5sp
	oPePU3QEO4D1PH+SMo2A6+3PFYHvrbrnO37P4A4NXtXLJM1ac7GnS+zkuccd8MhaDQqAYr3XKmR
	9Ikt8GrsWnHX4ksISGeC0UdKh9xjdP7N21+z0B+r1ArAetMlJhMQwoMYm4lYoV8biSIqacrNFE/
	5CNHmmkJnRtWc/9xh/awh3nyl+Y3/nbjZDFXjhxCC37kC0q6ymU0v0ZSbB8jgSn7Dil+x9muxOY
	H+8ONr048SBCvjfmZNoUHzMhHFW4s5gbarThEHpdCOjZMtay7CYGTFpRl9/T07HSDcrO4n9E/Qn
	qsnY6AhhnRN/1dkIYbwUFDvRJ4iUTETLC3oygG6YXSlBQdXVYrjq6l+wYMwEUt7ZEzfo2ZZcR0L
	O9AN6XMOsRHWFaz4yvNmTIxAcr+/AMXHmaRtI=
X-Received: by 2002:a05:6808:4fe7:b0:479:fc87:27ee with SMTP id 5614622812f47-48549ed0b14mr14857160b6e.1.1779946925044;
        Wed, 27 May 2026 22:42:05 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.21.50])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635d26b5sm18790451fac.6.2026.05.27.22.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:42:03 -0700 (PDT)
Message-Id: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
From: "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 05:41:59 +0000
Subject: [PATCH 0/2] rebase: handle --update-refs branch symrefs
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
Cc: Son Luong Ngoc <sluongng@gmail.com>

git rebase --update-refs can fail after the normal rebase path has
successfully updated the current branch when another local branch is a
symbolic ref to it.

One practical way to arrive at that setup is a default branch rename from
master to main. While the migration is in progress, a user may keep
refs/heads/main as a symbolic ref to refs/heads/master so that both names
continue to work locally.

If pull.rebase is enabled, a plain git pull can then finish the rebase of
master and still fail while trying to update the main alias. The reported
failure looked like this, with line breaks adjusted for the cover letter:

Successfully rebased and updated refs/heads/master.
error: update_ref failed for ref 'refs/heads/main':
cannot lock ref 'refs/heads/main':
is at fc2c7bd5f17abec7861ef759edcd33a1e16662a1
but expected 531cabdfb49098d6ffa502ed4bf91d1b35edfcfa
Updated the following refs with --update-refs:
Failed to update the following refs with --update-refs:
        refs/heads/main


The sequencer builds its update-ref todo commands from local branch
decorations. It excludes the current branch by comparing the literal
decoration name with the resolved HEAD ref, so refs/heads/main is not
recognized as the current branch alias. The final update then dereferences
the alias back to master, but master has already moved, so the old-OID check
fails.

This series keeps that failure mode explicit by adding a known-breakage test
first, so that the behavioral expectation is clear before the fix. The fix
then resolves local branch symref decorations before queuing update-ref
commands, skips aliases of the current branch, and skips duplicate
referents. That keeps the existing old-OID protection on the single real
branch update. It also avoids teaching the final ref update step to treat
this race-looking mismatch as success.

Patch overview:

 * Patch 1 records the branch-symref failure in t3404.
 * Patch 2 flips the test and canonicalizes sequencer behavior.

Son Luong Ngoc (2):
  t3404: add failing branch symref test
  rebase: skip branch symref aliases

 sequencer.c                   | 63 +++++++++++++++++++++++++++++------
 t/t3404-rebase-interactive.sh | 25 ++++++++++++++
 2 files changed, 77 insertions(+), 11 deletions(-)


base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2126%2Fsluongng%2Fsl%2Frebase-update-refs-symrefs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2126/sluongng/sl/rebase-update-refs-symrefs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2126
-- 
gitgitgadget
