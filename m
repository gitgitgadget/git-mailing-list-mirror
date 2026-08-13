Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2B401A0B
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648360; cv=none; b=niZY4xppNwUbtRqN+dNVszae7ExWp/CMRD31aHB1Hai0UYZVuVV5lNTnDvz2Q6FTY1JKPPis6zb4LJeri4QFJW+4wJuuHugV7EttgzxCe5Yj+EI9TVvXjTWi8ME10Tc4PKyFuv6u6R4IIfciMOUdQbuH6PvQJvZVEiwXoGqARgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648360; c=relaxed/simple;
	bh=fhdPBH2oSMUlKgVY59EySdSZBJR5PVHcsQZvDRlkUB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWvKvc8HrjQUnG4LlG8lN1R6sf49sUrhg1+ytlrPyvRa7ov9EnQ1BvyrTMvrrs8zRcqcFqxhxgS+vWQR0QpvL4Ln2n2KciZhWxs4vSLGRNZeJ2JNm//ar/2zJUOaxmCqRIEHEb+Um6U1HcDcWoVlmbos9jkllOrnUGFRj8jGDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=btsZza9c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcCb527v; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="btsZza9c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcCb527v"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 350D6EC01D8;
	Thu, 13 Aug 2026 15:12:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 13 Aug 2026 15:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786648358; x=
	1786734758; bh=WWoUf6iNuXxSVmy+Tl3b7A0J7dJzX1W395jtTZJlCzk=; b=b
	tsZza9cd2af1/OA77v052lYKcnH16EEt7yFxUkvJCzx9571YrZ1V2QanZEcvPqVJ
	Nlw8SYE2pVgdgujxnf0hX+dz1D2F0Fst2121TmnzAQJ+xtuvubnIwiQ5UwI09uTM
	Xjyga9CbvRgItT2Q89WJZHDRiNiY8RA/9J4h6DzY5kL5icp/rKEXyX0V1qOJmtOt
	/w2hOtdf9dIi+mkvW/IDXkZw0gZft1tbwV5hfziTENcYuWIMamtlJ82orIGeY9/n
	Iy63l5Osu5S5PJHQW6cInOFjIZOPi/FP8b1AdRqvmD1JNG62Es2uZ9wDV01PTwxe
	pbd0ts0mds/vSzzfqSSjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786648358; x=1786734758; bh=W
	WoUf6iNuXxSVmy+Tl3b7A0J7dJzX1W395jtTZJlCzk=; b=kcCb527vZiWQN972z
	hmUT3STJWrGsABDi8tIf/xzEBBoP5Qpdsay+J25T8ueUZVUfHuE2nrrBVMfNiLAC
	Xq0DlD+a5wKBi0KnJFAy4Pox2+OnMA8z/D+HASJmUpubCo6w7MDgWz9K/iHtOzf1
	vmKnw9G1BboF1XN12S1Ej+ugcoCKv30zuIMo9I+ulDD+QLOLoLL2fSlFc39Fn60T
	ZDOAfvWtB8X+yl3Hu9u9oYt2ASh8sXsVQpTZFx0+cy0NoWb2ncTCy3iTMIG9/kEO
	4qKE4O7MxmusZKyj5tqpQTSn/V8BxiOU375OemSIrSQ4MTUMmf1cWdTyYDpLXzPC
	Ey50w==
X-ME-Sender: <xms:Jhd-aoYSuhJV-dSfcaWT4wMFSokJl3AQ-YMQMztb3WoCB6qBucEj3Q>
    <xme:Jhd-aq0-OB8FADhq_I7y0rE0JjN6qTVwak0vlpXYZiKafTHbojCwDMEDBCf0z7gQf
    4MquL3GsS8crKmsY1xf7iX8r4fCkhxE5XWaxfGcu7b5SMgdNhBQ2Q>
X-ME-Received: <xmr:Jhd-agUmPNU2Uws9ATzoEZZyaeKZrWuxqIreEiqgN1iKywPEVE6GqflHvCPRgsky4Dj2qt-bjA4YbR2OEC8miXkd9wX5WmaJEA>
X-ME-Proxy-Cause: dmFkZTGVo/fISZo4Lx3HK5G8K/1BKX3rHaUfQ1GhyoRRdn6Nithie5qYTfeC9KFsFsj9IO
    FfIQhTWNZReJIExNHeaNCqaGUYHXy0AzBu+O9KE2pAHOOVVYHIcLuLUH3VVk+vTyVQXZrH
    iwFYVSjAus7MHuU0HHGX8CNfaUc4skXRllj61lrG0APnG1vXDhaQY4hAJT7T2PQyIshaMo
    a1vMRS+lfCMDBPndDILWWaow50Mg0ab9BWmQ+AtT01rsr2Zm2thSQgFXM3Dr0rir7Qbi2s
    6f/mtC25y1Fu8n3GWKoUoCLmuDqaHOsdT09qPtCRd3qbBx0YbGruOiVwWwn70VHy0sB9Uj
    +87JGWxvyFFB/2Omp/wvuGpAUdwivXyEJRxnjsjxLl3hHHI9uksRGKvKm9CpKHM5dL+i4d
    4ps732crinvCN7PZe5V59s+hhzyO4jTdD130o32vPV1MSpQFnehEz3QnfEMKVh//2JgqQE
    YucIDK3TxbWRld7PIqtGbNmYDnSN7nr86tQ0Gxzebml2988Um2EntU0U+tMrS7b9I0Bcp/
    Swlix5tEXZ+uiwmgutbN3HRrAV/RRsEDjBgu/CflK/L6bYHsLQjAGW4ktRMUGy05RRJyhH
    kLIUek4epZRJ+KcCVC1LBE+rSX6NToZstTFa3X8FNaRmjrkFjbINsUKqPqqQ
X-ME-Proxy: <xmx:Jhd-asUxKyDcDrl_dlEq-MkLcdVEw-HztPUXU5-8w1ZdKnGx6CrSKQ>
    <xmx:Jhd-aneqGKMiiRBjFsIBx2BsDyC3uWH8nV1PQMeo77h-vtHkZW7Kiw>
    <xmx:Jhd-atX_7PzfY25pFm9_4T65a1LaOJzsTgOwxGHBH0V78se_rOvzzw>
    <xmx:Jhd-aodV8Zp0b73EK4XSxw70_pTZ62gVUAi1tN980l3pH5vSLX4TaQ>
    <xmx:Jhd-ai0j2W1vKdZF06uETSsSk0dSYDqlA44qFGMREqWtSQJKhLhRAYgE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 15:12:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 1/3] completion: no-op refactoring of checkout completion
Date: Thu, 13 Aug 2026 12:12:32 -0700
Message-ID: <20260813191234.1066662-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-759-g9dcc51a0fd
In-Reply-To: <20260813191234.1066662-1-gitster@pobox.com>
References: <xmqq7blx5oor.fsf@gitster.g>
 <20260813191234.1066662-1-gitster@pobox.com>
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
2.55.0-759-g9dcc51a0fd

