Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F736DA15
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308681; cv=none; b=P+doEIP3b75AMlmXa1TPAoNEwsRvLssY/X/lPD7Dkw2vFk1dJQSmLZaZtYvXSKrhdKMqj5iCaSOxpniGw5lhl4sh5tbXnklGuRbcaA1Vvfi51Cr1y94ggur8fWfP8WCRtyc5AAQChuNy/PjW71l1dJ0dmB0XYpqcBy9Ss/eJVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308681; c=relaxed/simple;
	bh=OagvURLsyR5vU/huFePHr83fSAS+gLLCirWHjiuiZjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRXD3a/vEkvSMWJZoxzKAUjcBKfPCZz+2P+9vjolppWMK4OC2u2hTiw2cTqt1Lnh2i5ldwAZXeYSVirKCCbJaDt3Nj2I6nrDIEkcNwsP8fjqmKqdNFNyW3IvZzebpIFFCPCS5ldbjiVNwEVTRzYHR4bgY201qL/eytF5eED2nj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRNprxM0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRNprxM0"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so57280916d6.2
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308678; x=1779913478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH6x5xGsGyK0l7bQ+MLdsBF+fCTLq/EEMHQovP5XNB4=;
        b=VRNprxM0ZoHx610soWgayDw2yE+Ays79KJNjzq2kN1rYfbnkrPPRs93UPpwPHYMnTW
         F9L530ygQ/mza9pcFw3loDU9qVsD4J4wa93PnTzqawQFLvBDCq4rzBriU3cm1uf96ITI
         PWFMgF1lQK9M6/7W/ohUMpTHYXXj+hE1J1mLyXFoOkK4jkW1wZ5nYesHXiXQqdpuAheR
         f2u7cywDw2fdVbs9a0LRoEZTBWWspsALjuyx12tjrRZDx5D7sMSbwVSEPJitfTIZn0xR
         +r8pqGjIS1cO505PBd0EmXTZ82iLQ+/eJzvDUD84nshC5OKxTYVC/0D8wr0wGhiAAlpe
         CHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308678; x=1779913478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gH6x5xGsGyK0l7bQ+MLdsBF+fCTLq/EEMHQovP5XNB4=;
        b=tEkKiypY9FIVyJoKaZqfjTnLP12NiOQMhbsNj3eLW10bbnqAZjWyG4IWSqSyl/KiVi
         CtMRUIia1jSmXlTb0JWdS59bHaSwHfphvJudWV2UfoLfYnwdLjGL3tmv1+M2qFR+/ZzM
         h3jJCIBWLhTX7Bvrf1KoN8mk0c2to2OZ4aeu/HWiDh7XJJY9UUyJxZR6kp6S/123VgVl
         U/k6JPhVIYSe+ux1Hvz7KAee980njkkbfWyKdQLn0ih4iS7pvUjTkf7bU7s/6Lk/+4um
         grdTtz7Xc2U8QpO8v1r6XarLK1OuXqIuCJ/tVLtqquZBvaDw6S6vTIP7Lgu+dmXTNSiw
         3SZg==
X-Gm-Message-State: AOJu0YzgwH1UDvoDCHBfA6DtZxGbQL3Pt8cCgLf1Cin+XQ1yPh2/hIQb
	+cC3kEfQ6SNLHfxNm1azBiv78EG2NXXKWpob5XuRiUMafF0SFF4gu7P8ziWLHOIy
X-Gm-Gg: Acq92OHqwaG2GU0gvwmwAm4b+P5YDysHVaAT70HbnBL2vwHx5ew7jw+/iQ7AivDX+yV
	Ko4AqLOFhNfASOxuTE25/K9o0yHwoLiZByepoJTC1pKR0O5ytKVF1pfINuXL0GK+VWSPCvCGXTY
	7HzNjJMWiF5hde6fK87xJ1+30Abp/MxozYHAXLpwqHiuquXMObFV9IBZQpCMUmF3NmfIH5Bqt+p
	3N1j4mdjU4Ujim1aD7v1T6Bl0vWOcOTxlTxQM7sn4yANsDfBJcQ/AK8PorUz8i/BfDVPPqzeRlm
	ejakzws7vvJ0iRRNvMpRO5BqMwFiVvUCFEg13vWBLZIZw1TPvFL8grVTH8EFylu01rPGRjuxR/I
	JhyVDINlUUSK+H652A0AqY38vVRAzE3eGRyuhdG1osUTYGv7zrqnKa/cUq7Ao6NgGzsI/lds3X7
	pXcqEf5DzwHZlL3LLQDwy57JOtmA==
X-Received: by 2002:a05:6214:2682:b0:8ca:165c:1a3c with SMTP id 6a1803df08f44-8cc6e2d37aemr686466d6.10.1779308674519;
        Wed, 20 May 2026 13:24:34 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:34 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 03/11] git-gui: use --absolute-git-dir
Date: Wed, 20 May 2026 16:24:02 -0400
Message-ID: <20260520202411.108764-4-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260520202411.108764-1-mlevedahl@gmail.com>
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui uses git rev-parse --git-dir to get the pathname of the
discovered git repository. The returned value can be relative, and is
'.' if the current directory is the top of the repository directory
itself.  git-gui has code to change '.' to [pwd] in this case so that
subsequent logic runs.

But, git rev-parse supports --absolute-git-dir from fac60b8925
("rev-parse: add option for absolute or relative path formatting",
2020-12-13), and included in git 2.31. git-gui requires git >= 2.36, so
this more useful form is always available. Use --absolute-git-dir to
always get an absolute path, avoiding the need for other checks, and
delete the now unneeded code to fix a relative _gitdir.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 4a736190a9..233c975786 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1146,7 +1146,7 @@ if {[catch {
 	&& [catch {
 		# beware that from the .git dir this sets _gitdir to .
 		# and _prefix to the empty string
-		set _gitdir [git rev-parse --git-dir]
+		set _gitdir [git rev-parse --absolute-git-dir]
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
 	load_config 1
@@ -1155,7 +1155,7 @@ if {[catch {
 		exit 1
 	}
 	if {[catch {
-		set _gitdir [git rev-parse --git-dir]
+		set _gitdir [git rev-parse --absolute-git-dir]
 	} err]} {
 		catch {wm withdraw .}
 		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] "\n\n$err"]
@@ -1175,13 +1175,6 @@ if {$hashalgorithm eq "sha1"} {
 	exit 1
 }
 
-# we expand the _gitdir when it's just a single dot (i.e. when we're being
-# run from the .git dir itself) lest the routines to find the worktree
-# get confused
-if {$_gitdir eq "."} {
-	set _gitdir [pwd]
-}
-
 if {![file isdirectory $_gitdir]} {
 	catch {wm withdraw .}
 	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
-- 
2.54.0.99.14

