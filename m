Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44806474258
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553335; cv=none; b=Vc6MbrtwMrxxHn0Y27Z0+F8t/ED8W7gkiYtMqPcWFic4/4ZnYQOiPrJ7XDHk6uNC6YicvghV9Jsuvigm4msJ0OR3xdzFAAFJyFuirytWJGdt2IvtBwZpWqIW4uGsCPyycGSdTdCLYgNCyVj4a/Gt7tWjkyt/oaiCgPB5L31Mv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553335; c=relaxed/simple;
	bh=oTy5iv4pmoZEkgPawZd9nB5G/mzuQhY1DslzGqAYOTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi5Kyjb/zO9F35xcVwlh9Flfk74jZCDN3/VV1ZVhXM2TSgLbQr3DO3ruuedPdDsxPjJzcPs49Yn92Za3R8fhz/AuFJrn5SbpYNwHzg9FQLD3gcW34olHJNZW3Jkt3ub/YxduAL8Zd8lPcGSVgbDz0lT0RnRpAOB8nTiRn2SIejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FtL/ifXT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=etuSnajy; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FtL/ifXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="etuSnajy"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B15FEC0227;
	Wed, 12 Aug 2026 12:48:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 12 Aug 2026 12:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786553330; x=
	1786639730; bh=biEctt4Y7RpiGL9QozyOt5hru5xk14z4hlJHAYnwQm0=; b=F
	tL/ifXTStFSrAwfjkCC+rUty9iYswdcSaTf1J4LJ1n79xwVdGwULnQOys33TH2zN
	gg568nwIZF56TddpICy0DbKGR2mrDUUt0YP/FSR21z2cRP8kCOnudj48MT8iOe7j
	CDCgy2L+LfCBwynGzN53bRi6HGaEjFpru4JXIgEQMJoM9uQ5lD/HzBe1qQ8Su0pj
	YzA5ze4CCGSp0ojW0tPpeWvkWCx6cE1dFKH46nDS+dffKhrT8btZOY3IxNivz728
	M2N/PZmH5If1EtO9zuwhSeJZLKMESW1vLgsnUAsn5/02LN3i3DiIEltQWAPr+RED
	FKbX7SFACjf7EBiA9Uz3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786553330; x=1786639730; bh=biEctt4Y7RpiGL9QozyOt5hru5xk
	14z4hlJHAYnwQm0=; b=etuSnajyOUgjeL+gkqtrvoyy6ZL4Jp+jOSNJ60BlXpPG
	NIMZWaInXUo0C+4iWOs4oZbsC3onCNVOoYte68JO7zS8ZaFynDbq2E8eoDr0PNvx
	yLeicGNRgINg7hfDdh6zSN+GZSoigOlLi3aWTxkk5etblJ4V+OZryzAfO9ea5Q47
	fDYGcPij5GO0sUoYcGsIYbJSih78Vmran/Lk52DY9bwediOG5K0uVcKUyUrxlt3U
	+GREX+KE2/tmF7gBoJDUj0mxKdgdYVLBxdsKJE+Ak6ktrpa3e/UUp3B0Cid40gDn
	YQPTXmA2dLoeZKFeAHwc2x4eVsL7fv9EGMdOZJrRoA==
X-ME-Sender: <xms:8qN8avyzn6UXAUHIzksTDbAqBOL2vsY50XTzOQqcZLxHvvKS6E2WDw>
    <xme:8qN8atSpl00CCOTb0Wso6qBGJ_XJURIYWNgoAhYXul07vM4wo1ETDRXYdYQnDh70r
    HsrAvPkKhDm02WXhuyzElpFJ2S5-rztqec7kFXjFkOR6ZOScSQB2A>
X-ME-Received: <xmr:8qN8am-94Oc5GqDWm4PUTtF5tH0oTnlqvCqrQM7BFYfZuHm2A64n626UJSXgXKsrN6vd_Ijjn6KnC4zxs9ide6F5XeWysPDygA>
X-ME-Proxy-Cause: dmFkZTGbcGMnreNzUhovU1JHNbOQQAcr1IH07N1gMlNTXpRddP5CnwwPu/+ceMOh3NJeDg
    YMUhqjJyTfW5iB3PdXoE6SyePkR3aSlnfVemmbXL/p+LQJ1UaRNUdhna0fSeFIotbMBXXB
    95aca/RSXBas2r9asOD8G4/n2Z0nXIwCuvo11SzdCN8Jg45He3BRrJCoJhTuhBSRKhbefE
    f2DmN6bOUvHUifQzUbDVLg4JFhw7fdVweAs8Yp79re15IsPnZqhhRsJBraMpdyf+JO3Xy0
    UtixG9JlpUE5cCoeaQ5CA6pWZTBCCUN0hlnGHVciH0PVAmmmfE68bWJLI2Znl2rPlcEMNj
    vrVb9uLz3/WPitHsuFOwKaGKd3hVDtd/Bqg6Nog5FqMcy2PRFO+RJ+w0rZTqlG223BtNeU
    hKDSK2/0YGcgD/4UQik+Gh25fqOyZju029UM7/n7BfxTqLGdD7iLppA12JF7FiXRXJMvLu
    TJf8AUojNdgvricZVbnNnF/o/0e4tOClA6ysoJ2+SLWbpGIojJFlU4ijZvSo+qrRy5ptml
    8LA3A/u+UvtSVpcyFBSkPYiS3fodesP5Xm+GHGUj/dKWxlOdQ8uqW/H1DH6WtWXbsUJs/h
    l23RoYaqAABQc+/jC25bRhR5L6uoExSndsTtSb2zaZ8fIJr017klVLRTwTlw
X-ME-Proxy: <xmx:8qN8akqrELEPuV_66Y6zZjxfXjo2LQ6TxxC1lYEiOMyZ6gSKdo6ibg>
    <xmx:8qN8ajno-1tmNA7zpfSXL5S8DojPhRM0Q-6iHbeC8cGsaAtVaofJDQ>
    <xmx:8qN8arIBCZ2SZ--S5RWsLHWybdjuHLbQliiY8x3mMHbR9_Kf5sjALw>
    <xmx:8qN8aoxXCLxMdLUK1wLsybEva9rNm6RMWNbHmvkATVtUeN0JyIBVuw>
    <xmx:8qN8ajJwKg41Tfc0R_6hxSHquFp2WHBPXiRZTXiW8p2v7HNFi0zGFVK6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:48:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/3] completion: no-op refactoring of checkout completion
Date: Wed, 12 Aug 2026 09:48:44 -0700
Message-ID: <20260812164846.2236221-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-721-g26b8014fc4
In-Reply-To: <20260812164846.2236221-1-gitster@pobox.com>
References: <xmqq7blx5oor.fsf@gitster.g>
 <20260812164846.2236221-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'git checkout' completion function punts very early when it sees
'--' on the command line, as it indicates that options or revisions
can no longer appear.  By returning early, it allows the default
Bash action (which completes files in '$PWD') to kick in.

In preparation for changing what happens in the next step when
option or revision completion yields no matching candidates, or when
'--' is present, reorganize the control flow to avoid this early
return, and add explicit returns to the option completion branches.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 84 +++++++++++++-------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d35b4f3024..38dec1cabe 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1735,49 +1735,51 @@ __git_checkout_default_dwim_mode ()
 
 _git_checkout ()
 {
-	__git_has_doubledash && return
-
-	local dwim_opt="$(__git_checkout_default_dwim_mode)"
-
-	case "$prev" in
-	-b|-B|--orphan)
-		# Complete local branches (and DWIM branch
-		# remote branch names) for an option argument
-		# specifying a new branch name. This is for
-		# convenience, assuming new branches are
-		# possibly based on pre-existing branch names.
-		__git_complete_refs $dwim_opt --mode="heads"
-		return
-		;;
-	*)
-		;;
-	esac
+	if ! __git_has_doubledash; then
+		local dwim_opt="$(__git_checkout_default_dwim_mode)"
 
-	case "$cur" in
-	--conflict=*)
-		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
-		;;
-	--*)
-		__gitcomp_builtin checkout
-		;;
-	*)
-		# At this point, we've already handled special completion for
-		# the arguments to -b/-B, and --orphan. There are 3 main
-		# things left we can possibly complete:
-		# 1) a start-point for -b/-B, -d/--detach, or --orphan
-		# 2) a remote head, for --track
-		# 3) an arbitrary reference, possibly including DWIM names
-		#
+		case "$prev" in
+		-b|-B|--orphan)
+			# Complete local branches (and DWIM branch
+			# remote branch names) for an option argument
+			# specifying a new branch name. This is for
+			# convenience, assuming new branches are
+			# possibly based on pre-existing branch names.
+			__git_complete_refs $dwim_opt --mode="heads"
+			return
+			;;
+		*)
+			;;
+		esac
 
-		if [ -n "$(__git_find_on_cmdline "-b -B -d --detach --orphan")" ]; then
-			__git_complete_refs --mode="refs"
-		elif [ -n "$(__git_find_on_cmdline "-t --track")" ]; then
-			__git_complete_refs --mode="remote-heads"
-		else
-			__git_complete_refs $dwim_opt --mode="refs"
-		fi
-		;;
-	esac
+		case "$cur" in
+		--conflict=*)
+			__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
+			return
+			;;
+		--*)
+			__gitcomp_builtin checkout
+			return
+			;;
+		*)
+			# At this point, we've already handled special completion for
+			# the arguments to -b/-B, and --orphan. There are 3 main
+			# things left we can possibly complete:
+			# 1) a start-point for -b/-B, -d/--detach, or --orphan
+			# 2) a remote head, for --track
+			# 3) an arbitrary reference, possibly including DWIM names
+			#
+
+			if [ -n "$(__git_find_on_cmdline "-b -B -d --detach --orphan")" ]; then
+				__git_complete_refs --mode="refs"
+			elif [ -n "$(__git_find_on_cmdline "-t --track")" ]; then
+				__git_complete_refs --mode="remote-heads"
+			else
+				__git_complete_refs $dwim_opt --mode="refs"
+			fi
+			;;
+		esac
+	fi
 }
 
 __git_sequencer_inprogress_options="--continue --quit --abort --skip"
-- 
2.55.0-721-g26b8014fc4

