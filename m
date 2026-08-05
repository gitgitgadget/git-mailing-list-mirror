Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E853D524C
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958977; cv=none; b=NXXuiKWzKtWWUx3RmLSQU2NzCa3jz6XCh3z53lOastt7f5LWPLL7mguMEP+ZHeDwg/NBD2GZLMonbUtGdFQSSpFpWwrx1Tp6CNh3+Bwixx6KBsO2jp2c5+DfmxAPJldRFfet/F+RNYKjFRYmNhZhPtc0Bez6Nz+uFADEjxOOBlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958977; c=relaxed/simple;
	bh=hZN2YdlyKFINOOoeutq3hY5rGAo40Pm4Cw9YoWYa1qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmY2newhPLUGnmu0rehYvD3ptHbdpFSFOZWfZdEqGYAFDIFVYzZ0JQxB6gzlFZD2yhspyCJkWp+IqPJuYtbw50cWyzAdeRfqNWt0VbAHN8J4oYjTtzQ6ooa7MF2Il+gn3BRSJVzhauZOP56rPSBy6sii8mAeey0QDBJFOjEgtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g9PaQMXZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QwyJckqP; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g9PaQMXZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QwyJckqP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1BE5F7A0096;
	Wed,  5 Aug 2026 15:42:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 05 Aug 2026 15:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785958974; x=
	1786045374; bh=m+kJbEpZmi+24CZeDnL7iqRF2IySqyZq7rmw7p6YT3I=; b=g
	9PaQMXZpoIKyWn5nd2yw8hG96+CNwaIKE9gpDpk+cqtFHh7PIR9ch5dcFTJkAiww
	f0uzi0cBgqHlAWPdtuYQTO7wbpQU8z0ADF+ez2wGtQ+kYsnwLfdkcecB7BLtMLnf
	F3GGsAt5ioipb43Vadklyr1QVsQ9NW273AfXBqVSU2HJdM4blHZlmLqms3NxTQED
	rjGYo4FK4ims7kdC6ozb3Ec6GqQZ8tnH6KZKcB7Vx+a7VXWMQakKza4Z/faKaVbj
	6pvlngX2yLprs1FXTNaQgU40DIMdDKu7xjIBZR6kx36F+S3WvzOCc6TM2p9coWx/
	A/nAZGSG3qJkbopx4gm2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785958974; x=1786045374; bh=m
	+kJbEpZmi+24CZeDnL7iqRF2IySqyZq7rmw7p6YT3I=; b=QwyJckqPTXiWAOzzC
	6c21hFzg4gbVtgM4avw3Ii43Ed80eewRetBLZRKpZ67fBbXCbTgxkWmvTDoFFhim
	b7B39JWav7g6xL2SrO0h/ue4HYn5kpLED41+4/Dhp8E0O0xzQ3q8aSpP9aNFixfH
	wwfEBLV8qSY/jw/9ZFMF4n5vNhUrmPWqTArBfKK4duBxvlRy8dpKcikdvbKEON5e
	q0WSLvJx7FMTSwlilwfzrO77ijMj5ReJDdm+szfos8JgNY+HbFPbR8QVw6rcogyL
	tE3CpEGc4ExZSLgXXktqq30vZOGMpHeBFPKaPYJMZQPNRqx0mMDctOhyHMBPm/25
	vhVwQ==
X-ME-Sender: <xms:PpJzar3vNKH_ypW38UMkkRYvq4ap_M6Udr_sxKiuYKekFipsRdFS0A>
    <xme:PpJzapLckqlSgyY1OF7vj8y35ewmsF7F6j0Ryu9fSJgmgWEBoIQ4G6-xEWxQPaOWe
    kf82y93QnE88I3k-H7D_XMZ98orT3Xs9XW50-YH1pv_kE1ti5X8lJs>
X-ME-Received: <xmr:PpJzaiHU16sS0AZswspj40L4q8hLb-4zkWCCziB_ZimJVSeWWiXbp9-ZdQNFH2DCtPezpEDgTzPpNQJWx3C3IiXFbULwzFyEdQ>
X-ME-Proxy-Cause: dmFkZTEnTKk4KYDyqnRoRBJmy2/UMGDifkBmrQI2+K4xM8TZ6536BfGReSZnfUjppMlF82
    e4lazL5A04wOv48DeqzJLY8S54PVLBg3cBd4wWQKdvSf+6nP0xj90+r674LdRRxjw3j51R
    A73abH8QeRk4lpQNWE3Su2N6jkl3zpln+TIPTW9Yy9NwE39pLpijInOAQQnzDuuoG9T1Zh
    JWDkXTjOgq1uANBb46PCQ5HYSltdHrCMT2coJTLMKYov4FP1AYbC+Ia9tIha+w0wb2igjO
    YimTywUMAt/aUUbStjxGCQ71L580CrJPk4J/F/sukELklkb9oRhcr3ie1jmSxT3Z3FNFcs
    C7NXnUZi241hwxsG1ZE9SXiKl+Y4oBMNwFWT0ID9gRCuVlXQqoLGOJEWLNheVkUSsweWYb
    cWTpAVmY6cNQvQDXYR+YR6gioJdBjNmJW2QSdnV6vByGT9liInmc98+5JoyukU3uTP2iR+
    xyCoS0X0YFaQXiXdhRsLm4ZoTakdtVHrq3GvAuOZ39cWFni8lnRo1+b1sgJtH8EuLr6oue
    8cwzVRoSgvPOx5HX+MHt76NGz/B0LrNBQ8GPGvgx6s5vgT6uYNgmUCXMLOyvSzrOG/wD/s
    nwK2MGVnxENEITTfztxxvoJqwPRogrlfKa9MvScxBrpIXVxhcATtpv0PJwSQ
X-ME-Proxy: <xmx:PpJzatUV0LQbasbt9_9-U2TqD58GjdiD5Pff14F-Me9rIl8msLVtPg>
    <xmx:PpJzaiw40e5DsqMCHkbEhVIE7kxxFgb8SUJERMMdsUETMSc8CclnZA>
    <xmx:PpJzaqRw1HjcFxL02Cpy_MCYu1KrMS_L9U65l0SSxquAdnvvsG85zg>
    <xmx:PpJzamiemuFlzuEgC1MEpMN6L4fj1gUmbIDi9EmnmhK5l9aPtK5C8Q>
    <xmx:PpJzauWW-R9ekzQwUnLVl1gY-vY1YSIneRohwhpzEq5opDU6Zvja3aS2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 15:42:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/3] completion: no-op refactoring of diff completion
Date: Wed,  5 Aug 2026 12:42:48 -0700
Message-ID: <20260805194250.3316220-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-653-g9745b9777e
In-Reply-To: <20260805194250.3316220-1-gitster@pobox.com>
References: <xmqqcxw010me.fsf@gitster.g>
 <20260805194250.3316220-1-gitster@pobox.com>
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
 contrib/completion/git-completion.bash | 61 ++++++++++++++------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e875787710..ccd3b2a372 100644
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
+	if ! __git_has_doubledash; then
+		case "$cur" in
+		--diff-algorithm=*)
+			__gitcomp "$__git_diff_algorithms" \
+				"" "${cur##--diff-algorithm=}"
+			return
 		;;
-	esac
-	__git_complete_revlist_file
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
2.55.0-653-g9745b9777e

