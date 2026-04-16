Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8D3B19D2
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382605; cv=none; b=P60i+dE24lahYkOulAotAZImqu0vNkhfi8p1J+HvBCtCHDgelOHvGtK/rKyZ9ANlPNQwmeLmYRsM9/ld/IAsnd3s+HkTznbz+boRBfDnbjL/K+Mp2qDXBC0xH3lwx55JyGl7/vNJv6+zhk5ymv/YALfkIUpmh2Sfa9VSA1LPpWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382605; c=relaxed/simple;
	bh=vp72Im37D0QPJisbCQMeNlg/Zy/8nJTojrBFqPJCiMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j1T4zd3ztH1R/+PQtfXDqfrvdeCTgs4GO73JoSdcUVQ7A0RESjsk37Q0k1HO3xdJjwHAiv2Aj7VKW3gvXJTQ9oNUOAIAM/f9e9Xwh8NhoDW3WEAkSmvQueuAjK8qVQm1Vz2VPQTiYpbEwGRuRZ1U6LEw97AzDx6V9Ld4ww5Bp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfQpkx0M; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfQpkx0M"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c565dd3a7so251274c88.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776382602; x=1776987402; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTB740yULBJhnplPpPfjUpeawHHIN3aHmsqtRpf2pn0=;
        b=lfQpkx0MmBIEdclKvSdM+8NE3gP9wmPIQBRYu5rLKRrT6/bC2S084N9PeG57tiBF/U
         OECJ7U1gsm/GOzmdO0TJUs3K8t1MmRz4BnIOexq70VtmQIT5z44oqkj1RleXgh/hkIuD
         TTfWrwx3FX17EG0M/v98GMbfNJCq81CTEOh92+D8CvccqPvklWcXEEfeQ3Y5iJn+C22J
         j1Kz7Rei63A1oizWE/y3tbFZYk6EIp0VLyCk88jf0Y3edTM7t+JdDgWigC9j0SvabNnC
         mhNsG7irZbt7zspGTwi7HSWoUI6AYEEKkM0jKr+777X8yDB55sOT11MdzzsdYKLNvNnS
         HE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382602; x=1776987402;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTB740yULBJhnplPpPfjUpeawHHIN3aHmsqtRpf2pn0=;
        b=lvltMTWr+yPii3UayowY0gHjipy7VFQnH612j6M59IBmGGOtABtR3PceSliJOuyUuX
         +3YGfTpL91DbFDVnUuGVv3drJZfQxP1L6gGjQ07W2qZ+BOw25FSZSzbOrWtXZbeDV8uh
         bGtpwq8ptYoyE2Z+kJ8inzTvFcnMfmXGONczlS0XLYvgO9plLgB7Y6b4gD3wlLDL0c2F
         gAt+plknoVgkT7csFhbFcGvftKlLm6Hklft/uoxQg/qc9+43sIrHsRvu7smczFg3I0fC
         cDqQWcx5111bp7NGzyUhK2yHGwd1PW1bWJEqczxEo7wf4XF4ShNVmQoR8/A7seKfbZD0
         c/eg==
X-Gm-Message-State: AOJu0YzRzgNbHpT0ukFu/IZ71z/996r8BHk3OnSeIHXM/zH2b5ItFWMM
	BDlxrhUy6RcDVb6IdWabKeUJIE8IZ9Vz4wHya7gUKOoE6EyjfL9FFktdprUVnA==
X-Gm-Gg: AeBDiesd/xgvQAQ/TMEvpi/FAlUqfULvFkn6V1HkdKTDxXg5WV1RfKloggrP8ZddAGc
	SsdRMVfwJsgLAxCxnMNsdcj+uxDoRYQL8zP0ikFisNOcCZlPf1oPQr6OT9qIsYSCap4IW1DwGwb
	Tr8g6LXQhrObqPpR6OCuRCU4XZX/Cou4H3TCC2id5Fz3AxuKKfabawjPV+IXYccNTBwcwFlm7eF
	5pTeOEE7tKYPpSnJ9eojJuUsw1doXn5MTW2wHTGDpzJg7vSiHmuMjFsqObg//CX2bEBfcqKz7Xf
	udwpP+kB0z3Jns+HRJszLFbxyYCe1lyJDkJ5dTqwA62u1kVlQ1tvi84uh+I4O4Xcrn8I20j/XiU
	1cS0I+VQXhvVk7s8HcdpMsSlJKJhoLifPp0raC+JBulG4Rm50u74K/fzDyXGxIAei0QzgXFrcC9
	Ciba+tD+uJ0gmEaLl+lSm0j7LBr3Ol0q9KQT836DZY8exOvg==
X-Received: by 2002:a05:7301:9f10:b0:2d4:532e:7e45 with SMTP id 5a478bee46e88-2e47930fdf6mr191329eec.23.1776382601517;
        Thu, 16 Apr 2026 16:36:41 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.51.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e4c473d584sm185095eec.12.2026.04.16.16.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:36:41 -0700 (PDT)
Message-Id: <5ec9a3d20f0bda5a8c5f518b93b288d5d618406f.1776382591.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
References: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 23:36:31 +0000
Subject: [PATCH 6/6] doc: fix grammar errors in submodule description
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

6cc6d1b4c699 (Documentation: update add --force option + ignore=all
config, 2026-02-06) added text describing both the ignore=none and
ignore=all behaviors.  The former had minor formatting and grammatical
errors, while the latter was a bit garbled.  I have tried to tweak the
wording on the latter to make it read as I think was intended, and fixed
the minor grammatical issues with both as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/submodule.adoc | 2 +-
 Documentation/gitmodules.adoc       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
index 8dacb852c7..4c424017b4 100644
--- a/Documentation/config/submodule.adoc
+++ b/Documentation/config/submodule.adoc
@@ -40,7 +40,7 @@ submodule.<name>.ignore::
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
-	When set to "none"(default) It also show submodules as changed if they have
+	When set to "none" (default) it also shows submodules as changed if they have
 	untracked files in their work tree.
 	This setting overrides any setting made in .gitmodules for this submodule,
 	both settings can be overridden on the command line by using the
diff --git a/Documentation/gitmodules.adoc b/Documentation/gitmodules.adoc
index 3792da96aa..fd96639806 100644
--- a/Documentation/gitmodules.adoc
+++ b/Documentation/gitmodules.adoc
@@ -70,10 +70,10 @@ submodule.<name>.ignore::
 --
 	all;; The submodule will never be considered modified (but will
 	    nonetheless show up in the output of status and commit when it has
-	    been staged). Add `(new commits)` can be overruled using the
-	    `git add --force <submodule.path>`.
-		The setting affects `status`, `update-index`, `diff` and `log`(due
-		to underlaying `diff`).
+	    been staged).  Adding a submodule with `(new commits)` can be
+	    overridden using `git add --force <submodule.path>`.
+	    This setting affects `status`, `update-index`, `diff` and `log`
+	    (due to underlying `diff`).
 
 	dirty;; All changes to the submodule's work tree will be ignored, only
 	    committed differences between the `HEAD` of the submodule and its
-- 
gitgitgadget
