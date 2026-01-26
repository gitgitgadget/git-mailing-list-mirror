Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5632F740
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424306; cv=none; b=Kj7osHSIdLrpUfyopwaFVeYV3T2DxbJ+LuYduKvVBm6hUIbiA7atHq/eOrK93JpQjOk8B6ZnmBy+ED81V4OHQW15g1n8bWSzJ/JcVNkuH66YAwTMLAzJp24iadhJ0BS1x0rwqglc1THZIkfJjQtJEGmsbUNXLO3GoeRmKiJ/fO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424306; c=relaxed/simple;
	bh=znj8ufIseHjjyhgT1Jnjk7+c5XgT/n0lh0kTKo7re5U=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=AdiF3BAr32WfC0X0Z+Y5GEUfpuL1P6Axf7fb1UDKfAlVx6vlWnQqFLHk+ZCfS4qiveT9oDVTOdsvr973W3CUqMxNWWa9jfr6+0VkLyD4KnciwjHEz06BASpsuUNSHuSjLvqec37dtPYYoiYwtkSuFw0OZyzS5NKTLRxpJq4q9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKs7Tl6J; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKs7Tl6J"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8946e32e534so59399586d6.3
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 02:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769424303; x=1770029103; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ycTNfnIRK6rIYqerJUkogVO9YlZ4dDhc4QOOIBMLD0=;
        b=HKs7Tl6JaiMGGXjC3TamwWhDU8Qk5ayvgfLKRmAWwSFS1i/gmj7OgmFEhrEt1FDGoy
         QVZFUIiPbbIxeTW64R6PLHeMC2ByG3juqBRh+EjGF8j2msGYmvQkI1wevbAV5MTysbrR
         pxqmIWWN4VrpHwptCGUgj8LxeBKfTNe44Z6TwZQvri3f8kI/ME2O255BjRNPSiLkFL+k
         N44kd27S1/+8tUvZU2ktDCG+sQBjG3xz5ViTqPRt5wmxDq1lGpHZFi1Of3P+UuBsIWNP
         UoAdzQuIValpVYzOWzkVyc6BRHcTjjWmYShFTL1Im9Dybo95qyjgQNJ62L9KqJDHYAZU
         knBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424303; x=1770029103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ycTNfnIRK6rIYqerJUkogVO9YlZ4dDhc4QOOIBMLD0=;
        b=WqovFLIxaSEWZkI1Be9czTmaAtX3C7Vmey3fEX+HNiHLu6Vl+reiNUhK1SR/rzMSMQ
         ZuMv/Onqxtwna7FlCQvhfYbEFBQ4RznpLT8HDHKylh8c21Iv8OyQARq6qCQXycsZu9X6
         NXrGb+HmZLuJsyQZQktJPr+AY1XR5/ohE/McK/N9ySExGrntodFMfY9gdDaUWHDb1mqx
         31q0e2ghOGjpymeWbGT+Zf204KuhNzFxAbqDjov786gKW78OSrtmJFefVf/LIdRhmYzf
         3kuP6nrjQVfzOjmwLpZuRSFwE1Pf3i3CZOJi2PjrA6KDyydDGp1mp0dZz1v+cPJSb0Gz
         XKXg==
X-Gm-Message-State: AOJu0Yx/vnOZZiGyryPU9YkBwJYzP2wEMD1VNfIt7mG2tve31zf/xXwN
	4LmaWun01zJ6TLKNwVjxSacFW7/VjjdEb5SSCITpX3YrqDkMzVbjCOI5HqTqoQ==
X-Gm-Gg: AZuq6aK9R50vLxrx9qPX1T5OIK3S+L8Cjmh0tgh/02a2SJjNkpxhsqZ1ZS6fWahBIaP
	Jepu3tVyh/WyEac4doBuWwhOBSfUlYJGAI1zkmuJjCPTdQVt/PqkZ0b///+KiI1Mk3E6DRIVJFU
	cOptOg26qvDE8rx7mDCQb/qD+jyzXZZNiU8OAp/7SmSK73suwI1Ac7zF1gcTuk5RnRvD3jEHzki
	9jTqwRgAZaalKLkP6egGt4aBMJx0jjLS6+8qZVPL2FFL6JSVOpdHGv6hQp0y9QFMSlN5errob72
	GPYJMgW8K8yk9TnKZFZ4HXz/c09KGQbft3r8lWNzBW7eBg20LiIbfKroq8Tmn7bl2ht994EdLx6
	nYZ/jPrNGXNEFhjbbTItkf9lRBrVjEvEU8vSrHZXWJhmz72m8OB5XEKhJV8cUOJ3W/J9uEA9IXV
	YAYHph0Itnqxk5Ew==
X-Received: by 2002:a05:6214:21e3:b0:88f:ca79:844a with SMTP id 6a1803df08f44-894b0782eb4mr50357286d6.48.1769424303452;
        Mon, 26 Jan 2026 02:45:03 -0800 (PST)
Received: from [127.0.0.1] ([64.236.134.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491844d6asm91592756d6.21.2026.01.26.02.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:45:02 -0800 (PST)
Message-Id: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
From: "Chris Idema via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Jan 2026 10:45:01 +0000
Subject: [PATCH] diff.tcl: fixed alignment of tabs in git-gui diff by using
 spaces
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
Cc: Chris Idema <github_chris_idema@proton.me>,
    Chris Idema <github_chris_idema@proton.me>

From: Chris Idema <github_chris_idema@proton.me>

Tabs were not properly rendered in TK regardless of tab width settings.
Converting tab alignment to spaces before rendering in TK fixes this.
Does not fix alignment issues in gitk.

Signed-off-by: Chris Idema <github_chris_idema@proton.me>
---
    diff.tcl: Fixed alignment of tabs in git-gui diff by using spaces.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2179%2FChrisIdema%2Ffix-gitgui-diff-tab-alignment-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2179/ChrisIdema/fix-gitgui-diff-tab-alignment-v1
Pull-Request: https://github.com/git/git/pull/2179

 git-gui/lib/diff.tcl | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 442737ba4f..2e13f8c776 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -12,6 +12,27 @@ proc apply_tab_size {{firsttab {}}} {
 	}
 }
 
+proc expand_tabs {line {startcol -1}} {
+	# startcol set to -1, because in preview the lines start with a '+', '-', or ' '
+	global repo_config
+
+	set col $startcol
+	set out ""
+
+	foreach char [split $line ""] {
+		if {$char eq "\t"} {
+			set spaces [expr {$repo_config(gui.tabsize) - ($col % $repo_config(gui.tabsize))}]
+			append out [string repeat " " $spaces]
+			incr col $spaces
+		} else {
+			append out $char
+			incr col
+		}
+	}
+
+	return $out
+}
+
 proc clear_diff {} {
 	global ui_diff current_diff_path current_diff_header
 	global ui_index ui_workdir
@@ -495,7 +516,9 @@ proc read_diff {fd conflict_size cont_info} {
 			}
 		}
 		set mark [$ui_diff index "end - 1 line linestart"]
-		$ui_diff insert end $line $tags
+		set line [expand_tabs $line]
+		$ui_diff insert end "$line" $tags
+
 		if {[string index $line end] eq "\r"} {
 			$ui_diff tag add d_cr {end - 2c}
 		}

base-commit: 1faf5b085a171f9ba9a6d7a446e0de16acccb1dc
-- 
gitgitgadget
