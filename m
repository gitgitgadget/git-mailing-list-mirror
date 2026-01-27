Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1937280035
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546002; cv=none; b=ii/3yPuI+e2QhfVMbAA6I27EQnlQozLybFy8h4qobNnCwFzmxebTmm6ugA1hpLBNRm1QkvgsJgXl3S5dmI0q0FNDCp/QiNZBlVELmByTwiKa1BWrV3EOjvsfT3X0KlP+kmUeh7u2IfuaF3WXzqlMEd7vdWPvqTxy2GInuP4vnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546002; c=relaxed/simple;
	bh=UyfLsQ+4yVJUh1H5jAXtqrnhZ3gENrY4QpUqIGwXW9A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bY7YMFKfShdHLiZ4MphxujSh+pMDcpkxbrZfFRGT4eKNey8SSlXG2v73eX2Xx0cR1UhmZS2e5bRfOR8PTL7c/JTB2YavrEhPEhA8U2djyPChlAZ3XVoc263SxSifJPOpDFmt2If5h4d8R+I3Ih8Yxo/z/r/s2KqOAqnTR+q8MQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKFt6Vfm; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKFt6Vfm"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8947e17968eso66349766d6.0
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769545999; x=1770150799; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roKqSobphfGW05eLd+StX15HuE05dRa2dePHpGBKWQA=;
        b=eKFt6VfmB4z4mcLL/e8G7lsr5RC0hDS8XiHqjovgAHZPitFerCkGxdo29LobBkHdLx
         EaHKPWp1Zr+VZ5E5UwbWfoL3960+se3SiWSrIXc5r1cJLEpwjzEpGeSgclvBTbKnMtCm
         r9onsZDx6Gcxu6BPyt32I75HMedCFpwArBucpJGgd3m1sDbn/3nWgzMYZafZ7/duiLus
         HtIBZYuIKY54lA4uCSyrb0LcOTVGw5n+ULjofWz16lWgH9X1+IF/I6VeImG4eClFzB/K
         tRazsxSRHLhGz7h3IYqDBwUZSs2wLPe3drfb3T7VBJ7x555Y+tvIjdHYY0C83bxvbT6i
         AQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769545999; x=1770150799;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=roKqSobphfGW05eLd+StX15HuE05dRa2dePHpGBKWQA=;
        b=QknylH0TDb2d305A8AoKqnDQM+K72vCcqg3/0u5LvUudbjWNDO5YwZjj/oIJ2uXTws
         v8y6ltFcazK5aBvDqxNKslBi8XS8dG5/sGnyLcbLf++MEx6Az8x48D73fGciMoBqar/j
         CtWqfuDnR7LvuqaZ4e17SuU+HyURAFQTTKD22i/0S4x8gkkdWyp8Mz4Z3ml1gSp2l6Qv
         +W5MUmsVglUvUz8rtOMRB3BRrmlikoMeA//B3XST5vHQmfQYaKVRsf1XIoT4KkHAqkjo
         Qe10HkA+4l3bMRhSDNlKBom2s/rdT8WaN9Vk6kCqiSjCFSuDczYHe1IhoURRCTnOBAeM
         sPCg==
X-Gm-Message-State: AOJu0YxzwDt/5f+TPox+bBXbzmljIeZt+SVoVIWWzRA/sGrf1Oq65JJ5
	6PvitZoF1/XuYACnxuEIid9upGQ0fe/BuXm5dmS7ab8dZtpiFZ0XwKrvMFUX56XU
X-Gm-Gg: AZuq6aIRFuMjGvraf291/ohIjOinTjRXKeFiLvofTh5ruweskgp2iN3ActPlT/lAZ5K
	s9RMMfk8/sgQTyqJRkp+qPERedZamchf4xNUH50KPpy261MhY4c0pvVilVMJ8RUyy/+linfBqjW
	6R/44sK/45bzfJ++q13jJNsHgQA6I6zx3nzqwot7ODnwZtRMq9edug19e7qSmhVZPlI+GqmVW4o
	/FN/ImD0LIvjB4BzqmGTWGnKZWT+JRXCwHKOSmT217+gNxX8efp6+Byj4vt2YPGonOuCRayst5C
	jw3OjRQFnZTMuHwoeX6PZS77V3tXriXX8sj4/WACOf1puSh1hUComJ3t0x0aqPIKray9EAD4LYd
	80JdT+f8BcOAKpTSBhPLmvnSeIf8aLcd3wD0lm1MFdE52DZqIxLXk3PkL12XUR0eX8gP9basONL
	K3rsIByfZWXHU=
X-Received: by 2002:a05:6214:f05:b0:894:6c5e:6b73 with SMTP id 6a1803df08f44-894cc957996mr44664576d6.61.1769545999399;
        Tue, 27 Jan 2026 12:33:19 -0800 (PST)
Received: from [127.0.0.1] ([51.8.121.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b8b4d3sm44000885a.13.2026.01.27.12.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 12:33:18 -0800 (PST)
Message-Id: <e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
	<pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
From: "Chris Idema via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Jan 2026 20:33:16 +0000
Subject: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix alignment
 instead of spaces.
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

Signed-off-by: Chris Idema <github_chris_idema@proton.me>
---
 git-gui/lib/diff.tcl | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 2e13f8c776..0f0951cc57 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -12,27 +12,6 @@ proc apply_tab_size {{firsttab {}}} {
 	}
 }
 
-proc expand_tabs {line {startcol -1}} {
-	# startcol set to -1, because in preview the lines start with a '+', '-', or ' '
-	global repo_config
-
-	set col $startcol
-	set out ""
-
-	foreach char [split $line ""] {
-		if {$char eq "\t"} {
-			set spaces [expr {$repo_config(gui.tabsize) - ($col % $repo_config(gui.tabsize))}]
-			append out [string repeat " " $spaces]
-			incr col $spaces
-		} else {
-			append out $char
-			incr col
-		}
-	}
-
-	return $out
-}
-
 proc clear_diff {} {
 	global ui_diff current_diff_path current_diff_header
 	global ui_index ui_workdir
@@ -516,9 +495,8 @@ proc read_diff {fd conflict_size cont_info} {
 			}
 		}
 		set mark [$ui_diff index "end - 1 line linestart"]
-		set line [expand_tabs $line]
+		apply_tab_size 1
 		$ui_diff insert end "$line" $tags
-
 		if {[string index $line end] eq "\r"} {
 			$ui_diff tag add d_cr {end - 2c}
 		}
-- 
gitgitgadget
