Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698923C39A
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332203; cv=none; b=F0Um8XrlbZEEEIcPoEOY+/1rp+0u/B+zGGAp12ykM40SHsup0oDnpYZjj7L6XPGDrWNXIouvcweMTIozr7iJCuwEyFBiFosslHl+MkbHhE5wgI2woymAstSG3tIPYjHRpRsGGU0MOjFLzw7rZefKAAdr8uhS6wnUZ0SZDCp0hR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332203; c=relaxed/simple;
	bh=N1BeQESXVc823dj66xtUEgDBbdoAuDBtL2UwjFZSrLk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jmRppHkySHtmp4BNCBgtSUXknE/scgzyhz1EUqiH7uFt1i8+4wtNuQtN0JSf9PzOTPsf39VKrPf3IlZ2rJqqHEL3iBFJcSUi4s0sHbgvJ23RwOcqMG45O2tC1DPy5NK5W+L3dtY5rMO26j7orKjezm38jytkii7qdYZgw/HnXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Axc7VsSa; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Axc7VsSa"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cfc3ca1922so385580585a.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332201; x=1775937001; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDCvNhsw8FfrYHO3qOBtcamTF8GOzlMOJSASJ9HGgkw=;
        b=Axc7VsSaHMN4l7nNC1/3jfi73vfmFpETbANinxzq7vtW4lMkk1lhYsaWW0cI7aBE56
         RbV0UNP4/99OKxRGN28r+hA+FMNaSjWWOZVE1EsQQYxiYWQtLMEF6mznaUmPHFDOhGng
         r2aUrszNroj3uTRJHlJK7n/LRuZRohqkUD4sL0XCOky4XEEEvHYbsI7TeSLSh0fq0scq
         HnUJzGL+i95RITrZu8s+BNUOcCKA4NdeR6bZi3Te3kdlbzQ1YgWO3Mtubs06uzBLedVw
         8qubVUsazUDngfrExlkA0hsGOAGXEhmlXiC4dmorczAAKWxwDx/kJXQbqWpc3D2RoGiO
         BMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332201; x=1775937001;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDCvNhsw8FfrYHO3qOBtcamTF8GOzlMOJSASJ9HGgkw=;
        b=LzU4pDxDxx8w7kqPSWorDo1fr6rZ8ksZUWSVZLkGJbUmq69X/sWcJDESHzJUg2pIKE
         v52DHPgZ3Q07nrkJx7jHbQfwcXs2agYiOM5xOJIeoCdSqELjX157pR65mHd3VEeRhiLJ
         ltFltBmAom7bmoQRjDnHo+F4PLb6s+555P9iFIZzdINgoCWkvTjZT69HOmEMpEOqV2sK
         pZihJpCJkUUqMDKEHchyf6jBDSnwS1dyQ9et4xdBpe49ehCbI8GMs9TISUX0X1Qt83Vo
         9VOfPNMHaq+PNKAtv0TxWwq05yjvPgV68EqddhhJMK6xnBOGA0pjNQr4UJxU5XVClSv+
         toWg==
X-Gm-Message-State: AOJu0YxIo1KnY8vD0bub4INxF2LjxemPg1c2TMmxwM+5ebjBPzUMRMLj
	Qsdhqk7f3/ghhbrKur2cWG6xLmk3wnalVBeh/Rs2U+LcGtmEnWC9c3LRQA9lkIG7
X-Gm-Gg: AeBDietO38olH2bu0GF7s6cXadG03/a4B4/H2qaaSBTXddBapyrDImXt5ZkrPcEkfR8
	n1RfUkozseWpt55/+stQbQyQN/OsmjkGe8hFfPpCCAQZ+ABLCEhejDpVul0MOSiwg1jOrBa5vwO
	xdhDMn8E27WAHyLuGVV9sNpqBkj1iNGsU68/x30IitGOym7vK3JJXwGOWvN3I3h0afhQptUy0qH
	ESyXoUNXuZNKf1+59uu7Fu2xbj/CfckzWO0+M3TRPRoOXxOTRDzWZ8kQ41Qr+pg3w1tO8Ac4RUR
	OpsO5EFo2nLGBIGvaMXgD+LuI71eY/6k0zpM0k7u1jJ3xDkWZdyC3fnn/CYF35ePRlF9w1AFuTF
	kSmtYWLI6d8PrAdHuFIR1zZDFuNgrifKDif320ZPHOGAz4QHl3g+GPwJNzzOrH5EbJcwBqtyjom
	YYrm+JeRGhDwgPV17Y5gO9LFiwI5s=
X-Received: by 2002:a05:620a:7009:b0:8d6:6db0:88de with SMTP id af79cd13be357-8d66db0985emr243441385a.44.1775332200611;
        Sat, 04 Apr 2026 12:50:00 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d5336aa9f0sm287402085a.28.2026.04.04.12.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:49:59 -0700 (PDT)
Message-Id: <78744602fb33978a9f674f5f9860c58e7734d2e8.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:42 +0000
Subject: [PATCH v2 02/17] t0001: replace `cd`+`git` with `git --git-dir` in
 `check_config`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To prepare for `safe.bareRepository` defaulting to `explicit`
(see 8d1a7448206e), replace `cd <dir> && git config` with `git
--git-dir=<dir> config` so the helper does not rely on implicit bare
repository discovery.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 6bd0a15dac..db2bf1001f 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -20,8 +20,8 @@ check_config () {
 		return 1
 	fi
 
-	bare=$(cd "$1" && git config --bool core.bare)
-	worktree=$(cd "$1" && git config core.worktree) ||
+	bare=$(git --git-dir="$1" config --bool core.bare)
+	worktree=$(git --git-dir="$1" config core.worktree) ||
 	worktree=unset
 
 	test "$bare" = "$2" && test "$worktree" = "$3" || {
-- 
gitgitgadget

