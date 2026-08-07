Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF942D758
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119602; cv=none; b=tjMPgHNJO8I/Uz/DZ5SCyMA2nCq+MljLy0Q/RO1ayReBiNCOkKziinvHGkVvkFt/Wz22hDKeE21T9sfWZ4Z96SI/nYt6fd5+ZZ2cUUWvqkhtqth3fk6/iP0bRhAe/aiZhxVAOCM52hTRiWwCSC/e99g89oUIncsD+/qwON2tSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119602; c=relaxed/simple;
	bh=LpA+b6/2xpDpT8DyPzvejEhL1eCYbMo/pb64MJPMDf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFePNgaDgnNTPY0ca0IHJQHOond86Eh5Un7yxskrg0uDZdFH99dCbqHAPIZZp1oJpgzBgS10AIgvHr9rvHnExCpGmN2NczH2sm0WBeRu7Ei6Zcdh3PaLVyugtACcLqG0UKDxt20GUyHc9mQky0L8Jx5+fLvdHgJ67HMDpI5qa5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p+5x/uWz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hcuX1KfZ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p+5x/uWz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hcuX1KfZ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 145237A0137;
	Fri,  7 Aug 2026 12:20:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 07 Aug 2026 12:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786119599; x=
	1786205999; bh=UAN3+JFR9yRb4RNdwoORU2BWFtxVQJ3WYb73HJKCvh4=; b=p
	+5x/uWzkEK5vVJJFcdVM0isTq5O4BCAeVHyYh58oNcZ7EYqMwIG42sf1kCK/mIs8
	VgSc4a8ODzvwOycZKtcc4MU9r0rDdUIOqWAI8VtCqocXfZxYSHCdPvEqY1o0vNqi
	g5o3U9HDP/kmZUwYkgj5U3ZAkYdAFTSsb+1wZLELOlzBTu75glkL7c3iGje0dSKY
	5soz5DJcxOSwfNrI+/b1hjYsLPcrh+7YwBoIu7fRK1WWMANOzSm8hAFn+hV4eBav
	NTsjzQGUvnD0qlaN/cBL4f/5uVZ/UK9Vv7ZrOKu6WNjC7Ig+mdZU7J7j/4vCYATv
	/R1/7uJjnwtygSbic2+Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786119599; x=1786205999; bh=U
	AN3+JFR9yRb4RNdwoORU2BWFtxVQJ3WYb73HJKCvh4=; b=hcuX1KfZVVsAlKc3e
	bcb52jPfyy0TE59Y0PPRpeuyLLIatZJN5x0lohagwYVXJkMV4EVO6yaUqZfebmBx
	IBcjSojurJm19oqygcXEt13+BEtEUr0CvGuJf0h+gq0QV4OYfyehDDvVdsCPmFZ3
	ra2R+0Ov9LHB5xXNvdwy1EEpoQex+82GkzyYeNapmQc0GQi8XGpUM1tWCAZ40eUH
	gvemksBK7cwrJAsu+tg7/lWhSs1TB2I2qGsarZ/VjMvJYVmPjObvyoX1O3sUI3Bg
	UGpevlfWnyV5hlHhUXS/jyVMQ9qSAv6M61y0l4/WoOkU4zg34T2nQuhfX2RxJByJ
	LkB7w==
X-ME-Sender: <xms:rwV2agLDtITIITFRUXZbf3NxAOVvta6nWgo8mhn2-1B2Yr8Zxkid2w>
    <xme:rwV2aiu0tpzkG_AWJKtDUYcsGmpwyh9cQJIS789UfsapFkDDDJr8h9_sPlGYcbLWs
    h4Y_dmBMpTA-ypWS_sXB13CY_823TIhKVJDRjp6LjOHbw7PovLMtg>
X-ME-Received: <xmr:rwV2akUta8gJtzjX-4yZmejWclKZT2r_4kYev9mnZSGzO1JuiKNllI99M2KrUNuPugFU2pO2PW3iW4tNbOa_UpfC2CDO5cE4QQ>
X-ME-Proxy-Cause: dmFkZTEJHuVEstLDdAlOrrWjTIWdUA9quoxA0GV5FCGAe4XBYM7Z888qo/hU7NnNePIuz4
    rQHMSqQYQLb/Ym0RUVJfFi4Dv5CcciN2hbH5SWtoduqhzhRnj3sdJTxUYxAlvLRCJNR/KN
    hjRViy8aPjLbfjuaNjmNP9Ho20ae79z8cHu10U64OR6NOPmEeZkJIjSoJwuEf2ITSERc10
    J8ESxDecb3D3Shsvwq0USUM/DWEcqWRuFN9G5iDud6LgIwjItzePX4hie1vl3QlazsG6hx
    5XR4Mamngqoa+SytwKSA8Ry51qN7m3NIouxeWJGf0iN5wprEWgOKHjxOAcyFP6rh4GCPPT
    7S/N0j8ht5QzebE+2XoAUrijiN4U0WKVF3S2+57H+VUDNYMSEuiMlyyWwi7G2YpNdkWizV
    xS7eOtuUCzvAe/NTDhBlE8xn1TFtP/xasVSPsJEIm+fGBFPBqgJcT8MA7DCdKt4yHbN6oO
    KmbBa7BvPEYpeJG8pEF+zZUFy5RjwNedJj6G0N5R/N36Z20cqMdHs+Mo0+pk8pWYaCDHDj
    MNp4c/sgt6faOCtan+1LmGocRK0b+QNcMMQzpiv4NAU55fYghBu0SbnAqDgiH26q1G+hMH
    KyteFC2bjVK91hrnYEh+87Rh2pI6bpbm4seEhZI+r83i5xagGw6x1usY7Tfw
X-ME-Proxy: <xmx:rwV2atj5dj__X-7DfM2GyU-lfAMAllkRsJ2X-uZqSLRUlfOOJhnPmw>
    <xmx:rwV2asqgwA7mRza-a0_GA9_RnkBdrWO56DYLmbgwU_bBB4pBcslgHQ>
    <xmx:rwV2ajGoU9BCXl1zPBBt6PiOrk5pJF38wxO0-TdwuXSGxgP5yyJorQ>
    <xmx:rwV2ah6f7TBqGdHVAxx93X3mAbpAX1m-AXbP2FVs6OFXr3wtaXmKiw>
    <xmx:rwV2aiUkic5TJ0RVurjFsgU9urXi0bNs8ovEg35nTrd4RqyPpL_Ji12C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 12:19:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 1/3] completion: no-op refactoring of diff completion
Date: Fri,  7 Aug 2026 09:19:54 -0700
Message-ID: <20260807161956.1004889-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-655-g8b87133eb9
In-Reply-To: <20260807161956.1004889-1-gitster@pobox.com>
References: <xmqqcxw010me.fsf@gitster.g>
 <20260807161956.1004889-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "git diff" completion function punts very early when it sees
"--" on the command line, since it is a sign that options or
revisions can appear and the current completion does not need to do
anything "git diff" specific. By returning, it lets Bash default
action that completes the names of the files in $PWD to kick in.

In preparation for the next step to change what happens when we
"punt", arrange the code flow to avoid this early return.  The
behaviour at this step is unchanged, but the control flow just
falls straight to the end.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 63 ++++++++++++++------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e875787710..a61b6ed59a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1947,35 +1947,40 @@ __git_diff_difftool_options="--cached --staged
 
 _git_diff ()
 {
-	__git_has_doubledash && return
-
-	case "$cur" in
-	--diff-algorithm=*)
-		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
-		return
-		;;
-	--submodule=*)
-		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
-		return
-		;;
-	--color-moved=*)
-		__gitcomp "$__git_color_moved_opts" "" "${cur##--color-moved=}"
-		return
-		;;
-	--color-moved-ws=*)
-		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
-		return
-		;;
-	--ws-error-highlight=*)
-		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highlight=}"
-		return
-		;;
-	--*)
-		__gitcomp "$__git_diff_difftool_options"
-		return
-		;;
-	esac
-	__git_complete_revlist_file
+	if ! __git_has_doubledash; then
+		case "$cur" in
+		--diff-algorithm=*)
+			__gitcomp "$__git_diff_algorithms" \
+				"" "${cur##--diff-algorithm=}"
+			return
+			;;
+		--submodule=*)
+			__gitcomp "$__git_diff_submodule_formats" \
+				"" "${cur##--submodule=}"
+			return
+			;;
+		--color-moved=*)
+			__gitcomp "$__git_color_moved_opts" \
+				"" "${cur##--color-moved=}"
+			return
+			;;
+		--color-moved-ws=*)
+			__gitcomp "$__git_color_moved_ws_opts" \
+				"" "${cur##--color-moved-ws=}"
+			return
+			;;
+		--ws-error-highlight=*)
+			__gitcomp "$__git_ws_error_highlight_opts" \
+				"" "${cur##--ws-error-highlight=}"
+			return
+			;;
+		--*)
+			__gitcomp "$__git_diff_difftool_options"
+			return
+			;;
+		esac
+		__git_complete_revlist_file
+	fi
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
-- 
2.55.0-655-g8b87133eb9

