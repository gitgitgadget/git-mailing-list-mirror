Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1BA411695
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102803; cv=none; b=q+GML80JsgHZDQhtVCtdnuotrPOtDQvWTJSnAF58z99Al9+wvaotQTZ8gt4dsL82BvRPXBd7QhkeAsvKrXxMaiHyJhswtKkgd9tgU6p4LipihaSNhWEDRNZ70sHjeHiD+iaBO1W/GlB0CJy5v4UIutXNs1k23/mf2dZY7HkhUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102803; c=relaxed/simple;
	bh=SOcauk/9griPtWaBBQQFAUIzdHiRx4NbcPCcZm6LgLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svUUs3bPs5LLAg12k694dPFBVCeOfrzyGQOK5efnk1p79zRjVoptjECOWbFyNuhBlGYj7tlpqd8e7wn9Ff1ZcBFDamVr1mYXxDxfobshKDt9OMGOtFpVvvu3FkyFmzdmdfrV5N1XY3PQDhu+Vtl3uxhOrDBVGzN5vwFSSQ/Q6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=C634rOma; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="C634rOma"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1781102309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=399Y+7MWFVJDq1pi7Nsbe9lSX1Elq88H+TGmiRgX2Pk=;
	b=C634rOmal4ddE32/ndEE7M8F47M0csFXG4EZdSi7saN87IhPQ78VDszM1lfxTFF604T3ZA
	cp6zL+mjHzE/YRyw9YTDYIWsO/og87FJQeVD2ayMRtSdpnDEr4uzP9AzlF8dZE73YiQdvK
	KfPJItwEcYNOPsNyGGBX6V41rIAzYX61OChUOhAedxgzJN+/RoNk8Hp91SCdBcT69MuP9S
	52LiedCMxX2WLTsOsogzBXC9vqUbovcOo78S3meeuWETw8T36EHbAuNe+6iI9O80G4BjaI
	9oriLjTvOlTe5gbOF0VxQ1NVBs/X7bWKY+SJ0qYGE9QPeRq8a0KlG/4dUTrRlg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH] bash-completions: add --max-count-oldest
Date: Wed, 10 Jun 2026 16:38:17 +0200
Message-ID: <a804828a046d8f12ef0d03eaf014807b079bb707.1781102091.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=mroik@delayed.space; h=from:subject:message-id; bh=SOcauk/9griPtWaBBQQFAUIzdHiRx4NbcPCcZm6LgLw=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBqKXbaWxDMt/IczOb7nJW6k2keZ28Mlt6XMT5Yw bZDCosq8vCJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCail22gAKCRBIeX6hnBm+ 0QroD/9R0JXHSIQUshsCKPld77PabQXWabQPqgUI3wmvZFjBxdQNphG+nk0wCALjNDMib+SIAyP aVOl1oQXZmaoDwb7ocKgLy5iAIUa6i0dsB6Yd7yNgAFbI5acQ1QxPSEXJS8vy+UB+G7aku3Lihe wvlRJXUXiA9VYiNzDea59XObMVylEgp184V1E3FnYEki2OlF1/q46NmUDAN6e7lPs9epM3UiJYu D0kGakQbdWxvUE37DYX5XZtL7qPEU7PRMAnGifbGdPdpVyWv8Jf2iHOINjprXg6vVPHxkc4ukPH e+c6SRmxsyWhym48vEGsXNU0Ua5EvUqY+3G3hexA//s1Ia89nIbYwPdQv72uCoRWTb8tDDlnXKd w3PdQrmDuS2hCFkb/+xq6zu9af2YpyRlhGwMWCnO04qklvzeWn06PNfjGa4A2imgXYBehJlmuit OLKH/O80YJqoNf7WvY/1PONiatRvAChp0B90bKyCmvMTvuTUtT/e/6QZeenpFKBI+YFhvmK6NVV bf5UtNvqOUqIvPAbD6uciaRJwJwjWorJ5hAi5PxaGoROI+XLcWG+H8jFNcne9aTkfWiyOWGeHLT K1sxPfMmlgcHnZr3W7eTG078lImtc1Bvnhuuf5U+fqEcahQixpQnWTXw3e7AcgtnKAhx3aF0GRt /5qajBSna3
 3Thsw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

Add missing completion for log --max-count-oldest

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Unfortunately I forgot to add bash completions.

 This is built upon 1ff279f340 (The 13th batch, 2026-06-09) with
 jch/mf/revision-max-count-oldest bb4ce23284 (revision.c: implement
 --max-count-oldest, 2026-05-19) merged into it.

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a8e7c6ddbf..e875787710 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2195,7 +2195,7 @@ __git_log_common_options="
 	--not --all
 	--branches --tags --remotes
 	--first-parent --merges --no-merges
-	--max-count=
+	--max-count= --max-count-oldest=
 	--max-age= --since= --after=
 	--min-age= --until= --before=
 	--min-parents= --max-parents=
-- 
2.54.0.505.ga804828a04

