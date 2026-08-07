Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2B22F767
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066729; cv=none; b=dtF8VizyWx11d4SWHSbK/hY4DPe5wB8bQYQTGdGuD7s+ll8W7yFX90Ja20T/0I2AoUO4w27A1T4a5K5LDYQvdY0QO8nRXFB3EvmHoAeA8E9x8dKmSPiQNOUTmrXateW2i92EYgUkFWXcbEaOFx/PjZZTXO3Dc2LhTDbQIpr6Wt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066729; c=relaxed/simple;
	bh=FZm1sm9OHSWSQjdLVM+a7bId5W5XJ2X52g3fDquGuJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMtXZ3/Es/vASKbJ8n8S+nnDCu6LjiYm4i3dIB9x36b5veFuIi2gMtBHu3G/IWYDzIoYBmdlicN2MbMT7Opfqf+rkRgiEUnuM6+FmiqqTRvCPCnbn3dnbsTawrLPKU9MhOojvvsoHXv1Xx15RUJkndkUYS6EOeLX0PJHTuC1P3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DvwKat1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AuY/vfv1; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DvwKat1D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AuY/vfv1"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 0CD1B1D000E2;
	Thu,  6 Aug 2026 21:38:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 06 Aug 2026 21:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786066713; x=
	1786153113; bh=fOPlPwwQHXx9k5BS4bFcuMYdFXp4I5m3sVI4ArpT88U=; b=D
	vwKat1DJJr1pA0j0x2HMy4e+dW89nsiQG2IvrH7rIW+oU9WDozcBO6CLYfbC0m/m
	myL60nSXzxy0z+6wOPEK35W8XUfM9iyTl8YCnuKfO+DncsoCf4EZcF8pW1AN26+Q
	FSPRxjM/8vNTTOU8V233De/Ak/3/wGxRZVOlvzRwDXDVlj7ldeQCoOF8myOpMJCi
	ciSvOACTVBJhaR7YuWP2QGQBD9iYHMVh9XyZzy56+QD+DgOsRgT57cBHrURNMG5H
	OUGDxuiGYmA5eGt5s6MZABTNNSBYHbkkMmeSDfZUZ9sILkT75pk8NtwLoAzUZjlX
	v2dTYgd2ruEoxQ70PSTLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786066713; x=1786153113; bh=f
	OPlPwwQHXx9k5BS4bFcuMYdFXp4I5m3sVI4ArpT88U=; b=AuY/vfv151kbHIsnl
	RZXNba0Chg04nFw/VovyTQFq2EMoM0UyngSYsn1X994Wc3wGB/B2s+U6gnLsJIBI
	WHmvx2L1rZ70MRrbKbAeHyXXFxefIlqGGjQi+6fu/ijyUrCJm1ydpR17iHbyJHrW
	XshfxS48LPbRlIrvQ+ZapSzp5OwGa3wIpo+jffadGel2J1U+j1ddn3pvg5lhZXqL
	PCl4JU7Vrof35K9s+FW/WDNisuEHENMBfo0jq064++NOwvc09NtMNErupqVp9+Kf
	7n5olLm03i/QNCbGjMquh9YKTr0D0lPk72XoFRKA8aShm8D52cPypm6kS4X7nLxS
	Li6hQ==
X-ME-Sender: <xms:GTd1ahJ2kypwa6iS0-gr89oJrDhvo2UcYMmGFah4zgUwR9eKotgNzA>
    <xme:GTd1avtRKUTTtTWx_8rr94qM0tk81rkuWGOaNizqlR55z6rfsoS2I2xEVnqg4x8-6
    -UFB1l0qlIRgYPA8d1fdXqRfJRqJVcWVt58Cpgq5ll-WKVE3VKjYxg>
X-ME-Received: <xmr:GTd1atU-welLGLwrnPSVn6PbjrWSQ_bY4LwDkWhhc0oDHZjPbA6fX-g17rgTL4nmvqfVBuYLIS7zJwoX_cT1TnsooySPQn70UA>
X-ME-Proxy-Cause: dmFkZTFq7MzKWLxG+4X43Fk1A+9+V44cVi14HmRnlZI3MPpq0IXmpruKrxVv3EBIxIBKPP
    jGWkcZ1SfvzfgAZqhyYXPJhiexxo4v20CG8uf5ATK5plYBugOG7rVR9zbDzeeQ06XeAZ3c
    2xIJvlyaLhvEmLOoJVwNI1e9Eih3SPcNk+clOEydmVRIe09dtZs3cRi6WsO8rRs0leHQJh
    h0CD+jxxGRxSHYDfyAe4OoJPtMxecAcr0vz2jF5EWiuoyarsJe9bl9xfK7cGU+kvOkJLQr
    2xQfrEoMlwoHhIGtRjiKLNC9/olDxKb9Ai3/ZlxO1afrgzsIfdkKaWB2MkyVyhPZ0EiXs1
    E7ZtfobpolRL3lCY7uCO8QHoDoHFe1+pvL0TmWb6Ly8HpcFER7EeyJcNmO01JnMmH8q94/
    hsyh3ue7WVfSpMSvOcF6cM1TnqNTn/CPbDZjh2VhDYNhc1lMPm0/YuG5mLQckXDG5b0Pac
    JIzYZtA1SQWxkUN+QB52VICFFztzb9rSSAxRO0oAFRSmxI0+hRh1HHZnqsnBWeWfrML7XH
    NpydOam5xxlR0qkBfDa2zIjhwR9ilNDG22DaxoPk1swyt2xAm1QYkFqk/za6cJrzfHgY3V
    LAUvhCtM1PQ2q/ttgAcO2H5M2jhcu84mjWaVQdUEUzMSZhGwS9Zhxb0Lk53g
X-ME-Proxy: <xmx:GTd1aijUo9VNI6d0ifn5znf4LDdMUjsVqGtT5GtCK9yD2M0Yoj8YoQ>
    <xmx:GTd1atp0ve3kftPrWXstHqOHt7fFnqzOOW7gj8M3itOBaKnpMaZVDQ>
    <xmx:GTd1agFTQEelxYccyhw7FzUhqBvnlRZY16CNEXC122bTPhloq4_i7Q>
    <xmx:GTd1aq456Uyqd8kGiQqb6D0yjbZVdA_nW4LBSgHcac7ox-t4HsgQ4w>
    <xmx:GTd1anWXzYq7fwu7kvh-urKCQ8pCG8EstsLUIvSbE4OJFjnBAs2WFYPl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 21:38:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 1/3] completion: no-op refactoring of diff completion
Date: Thu,  6 Aug 2026 18:38:28 -0700
Message-ID: <20260807013830.698340-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-655-g8b87133eb9
In-Reply-To: <20260807013830.698340-1-gitster@pobox.com>
References: <xmqqcxw010me.fsf@gitster.g>
 <20260807013830.698340-1-gitster@pobox.com>
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
2.55.0-655-gb2c071042d

