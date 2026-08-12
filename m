Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF339020C
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551958; cv=none; b=s/LjlErIL4Ns86clghMSjjy1xRxRewLY1KbKWlr+sSDbsVZtp6yUee2rrdrbXQhIiiuMaSVxcQujHVCanA6+FIu2Lg+2C6h7Y1vf/gqYVSWHIF6c3nQQMsoZYhyW3BBNth9Fd4SIGEXcFpMvxIrcQ/54VTnNTKTN6w43EDo0jxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551958; c=relaxed/simple;
	bh=iPVVPss1KIh+HJapqhj2mWf1DhBH0Bq04VkOl83S/yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLROrTniEslwSBbQ+seHF3g/n2bOTzkh9+cMUfK0J0MhnybVEdbAQ7ZzRgU3QlBWymAzaJyrOyROcJXa0tSiJI34wjJ13sEFjDdpzqZRCSmCphR1fkUoCVgJUBEh2muiCvSDbX3pm92zNKz7/UKEqsh3+oDYfgr8qNoqvJnHUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lhceANDR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ewi9Ctrw; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lhceANDR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ewi9Ctrw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CA9BDEC018B;
	Wed, 12 Aug 2026 12:25:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 12:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786551955; x=
	1786638355; bh=WK42RZfq/lKu1UoS9gIkY9/OR/F12J4Puy6rypuWDks=; b=l
	hceANDRIf4mczM1cxUSit0TFVXlHojuo+m3MJl2rrFNqzrLOD+nuv8Lr+A3s5pxE
	8/xJ3Nej8uOrsLG7b2AC2mxgxgu/zXBoCKpbIl3ucsuXxsmchy0Pv/S9ujS/W25+
	V2baYHzH4qA8rPLtmUULXYPXm8ZPIviSzL75hYEOKroKR6PZN38mKk6PsgsqwVOa
	czvplF6h3hvF9wiUf1eToukIa8EhvAEPlS2JIZb9/Pn5DCrRRgBITczrP+K/ps1H
	PytjEpYx2JFv0oAM9AYPmTY4cp1+iCTp54tRmjJLP3oz/EL8qhX2zCE1AdqUgH4A
	dty4j1Ma3YriCMUcjuwnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786551955; x=1786638355; bh=W
	K42RZfq/lKu1UoS9gIkY9/OR/F12J4Puy6rypuWDks=; b=Ewi9CtrwigI8QFkg1
	MrRZjbFKy0K1wWJxW3jV1zqRegjiekeQrlFKFI6wt6wzUxuHxa597r1pvxe7zLOL
	glXOn60pjqtcTauRhr8PIq8kUNaqxyUXuN1hCLRDEnH6CtWT/sctqsxvG9cPBUMW
	KKzNVs+mvnNSbOXPM4nt8qHV8IgUIb1IWhAcKVbRW5N/jDSexMUB5D4VyoBAJGC9
	gxXFttHBZLWgMTjkrw7nJP5Qa+kObcbYeO6AfHvNoYtLDNGAENciCJt4o0AbJnVg
	xBh3XophBHY0nerBjMdzwLOijVGskDHHbdxlV2YFY8yVR0w7N/sJZ4pQbEOUWnic
	RnHoA==
X-ME-Sender: <xms:k558auQ5IKzEPZ29f0_q7WSYDoucq6OlwjK5g07WV--DLDY2w2prvA>
    <xme:k558amVen4ZOt6-LYuwqZZhjmxHS4smPIg4GLxiFSIaknN-sQk2CZeMuYVNYigEe8
    jh0jIYfFOPGR526wminLBsgPaGigX5Qd_gXtAzx3TrYCfRbeSXNfZ8>
X-ME-Received: <xmr:k558avfD46K1TDu_tWYDDz-eHG25GgvG6XHLXX9jFnQ88JYYlkQbYMpFgF_q_wSun3OkFRPr-qWwYbSwob92boNCiUG0Phy5LQ>
X-ME-Proxy-Cause: dmFkZTErBTy85xPWlDOo3AeTjUsGtPFPpMgexOhK3X+Iu7DBaRsmzQJzSiwFq9Q39ZsiKu
    pJnQ0PXpPY1aPPTDjrkmvsFLRTXpOn87SSQQ90j4/UWhjVKNZwkA9CdCHEdB3Sz3NJe1pR
    2wF/1tJEi1hVhHsHW0rW9uYxQFTnT+Yg+nFCz4QHWlit9scUfUsz9W3LnTgrLwZAkf5vl+
    UqVL9zPiNEUjjM2xCdm8/AIUpNGj0I50Z9GlNJqSjY7fV37ERB55HjoPYam1DtSmif9BR/
    THQecmrUeX4pCv2H4YuLwZTITlnGOnzmaGjF6HhC6MY/J8ka/8JxV74gLDaxeOR8Q2UOsh
    78/I+rPBZ5tQEX8J8hSwcvQxr5LvhILG8y6Jw1Yg2VjdKoSh4Xofcx6rEyvvn7Y+rcGEYU
    RCielZG8r5Z17eoTz0zrCbClkWoQg1I4xSF/oDQBEDUwK3LsJuo2W+gqu/BE0NEWN239dU
    FJ0MSyU3fck8m3krFDz3s0iCB3Qys8FDbqKb/Arn0sAs1MlTUwjAUCUG2tluPD5OAgeugH
    QMP+JlJ1rRUZ5D59TD5R0ZfdRi+OwE3PMwpHJe7p5G11y0cnx4Jiqj+xkjY4ovGIn6hRWE
    KsHshUcQNOnHeqUFQ1qyvJ+ICdrXMvISeoMNQ+coO8aziPbdWO9b6G2Xx04g
X-ME-Proxy: <xmx:k558aqIPS-ST5PAuesh2A1FGPRqdS8HFRkKKhM3xBz979mddGAiSxQ>
    <xmx:k558asxj2Qq8a1nU_sjMu6Y3Y1fAena194a14vkfcLgRNG3JXYUzeQ>
    <xmx:k558agt86uehLeHk-mgV7STYVXDyesfLltNJwDeO2G_aXxcUZNIa2w>
    <xmx:k558avCucxdmBl_TdFToEx_CiRzJmNrFMECqC6LaRANRyHSNapDV1w>
    <xmx:k558ag918RFB2g0jSRlyjE_6mJcGy7KtRWMls5x418-um6MmYKlwS8E5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:25:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 1/3] completion: no-op refactoring of diff completion
Date: Wed, 12 Aug 2026 09:25:49 -0700
Message-ID: <20260812162551.2229680-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-721-g26b8014fc4
In-Reply-To: <20260812162551.2229680-1-gitster@pobox.com>
References: <xmqqcxw010me.fsf@gitster.g>
 <20260812162551.2229680-1-gitster@pobox.com>
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
2.55.0-721-gd75157efe4

