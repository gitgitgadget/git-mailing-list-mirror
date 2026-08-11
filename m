Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8002239E9B
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418464; cv=none; b=Yb3b3UWw9Ns4YXJFkc2aOtIr3HnGxGSJHGredS3jtX9cp7fZUem5JY1boiWdzEoTWK98gqy1+zu5LUhDk90S90moRiV3EQtEI4Lym6otzT6T0ksu7bRFgZVIZdPWbb7E0HXC15j/03/nCjndFKus9vcNwFwFl0t8Z9Vhi/eCM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418464; c=relaxed/simple;
	bh=xR76b24Luc5PX5evsEgaMqpt11uDg9bdEOukUFfNaC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lpKo5TFu1UWO0coUEeJJ+B/6lhqnoVr703QpT/pGrsvjHt7G+HyB5E0Ls8nbmHtNDSueOzArJKUjR8mdDh0VaS2SpIwefV6Duwd2P2fSzQAzVbcGr640wiOvgpiUVO56cka3rmGMSlbly+P4umsksmWJUQ40f4xKsFOQYZYLBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GcEXEQaK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I7izfPUJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GcEXEQaK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7izfPUJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 118071400171;
	Mon, 10 Aug 2026 23:21:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 10 Aug 2026 23:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786418462; x=1786504862; bh=9x+0MLS3rP
	r/bPyKiyWxvuAvAQIIvAYuxTwDkESd5B0=; b=GcEXEQaK/mrDTsQH3h5A1xTR8v
	aEXJgP7bNvD+q5PLlBPz3DuzNH7zwV7FqGcTXvORRpIguwgVVwes5xtC40rrjhPR
	Ff+gdPVWtGnD8Y7ucOnm8xbf5wn0gRcIIeM3FDkaIB6Q6ldWhowDbZZ9Fg6amWJT
	c/vhoItYamVtFfb+IpquSwrcMiMySs3vsUM28XwjlS9daiSSgvr2dNiRJxqbkxpk
	aC62ntuhdzbFsnbRpt3a7nRfR51j3mCvgenJ7iObFv0Bi3au8oyq04W5FUXgV4XD
	uE8Fdp+/EjUiOadQUpgiAJXTbAcym62xcVJ9/key3wAt3tPNhRmtyj0PZawQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786418462; x=1786504862; bh=9x+0MLS3rPr/bPyKiyWxvuAvAQIIvAYuxTw
	DkESd5B0=; b=I7izfPUJ0ukjwd3Is9jOXWeogcMBTtGvA8mAzpQTmpEhJDZ343d
	xBJZ8IfU96kr9wOaQvvblouaiznpVbFqhu0dClGQMKpe2S49G44hdI2wXvW199Vx
	y5ZF7Ecykz76w6ZYcX+M5GSkoI0eaxJqQvbGrTI1wQh27Bs2m/qbIMCT7sYBYx64
	dCK3Xn8WgL4TZ/nZRazzxX6kUPIvub8NHCT2Rp5Xajm0iGG2HyLyQbZ2wBEN6yD6
	fB+1ribhp9/3svi2ApOSZR3RFV5+vu5/vyHKiTtjpd1ovwvTPx1wxRG1FDlPmOlb
	/g4V39DPNIQ1BLIYsplV0xkapZ28qKUOzNg==
X-ME-Sender: <xms:HZV6aoMkZdEPqsuGCkNtoloO3cOJCGmWTre2wK-LYpAudC4f6a5DLA>
    <xme:HZV6ahgeVnwhlqZ4ynZeQae31O7c-1A9YSFwZ5ky2AnI4Wr-I20ScyIZHJKPEA2IO
    SDurv40DArBzni20_2dpaNaeAXjNGulCsYyclbwGNRlC_1OoIpmXYM>
X-ME-Received: <xmr:HZV6ai418mS3TVeCfEUast2fqPzCIh4yZDKpEWdsJDSG1YkEGa4i79uXADheEA5At_ZsHADel2N0wAC7YfFAcKer3XORv3bCEA>
X-ME-Proxy-Cause: dmFkZTFt2v20ZcOsOi+Km1cvhhM03CpKmrWxDO4ov88+/EhRDxL/l69Y1RQy4u/dqr0RJd
    0fZM7tTSIGNzkab4SeDgRJqzldd8P9InobH6jC8aoKlzk2nTgHvRVaeOtS3M0U8HlbwkEy
    wfafUzo9zOJOK+XQhQ0Hy5rD14r3zFlH7x55h7fQpWlZxpe5/Sq+K4qCqUEbGCtJzKSmKe
    rQKtzRUOX1AexMBz0AMCfOtBVNvh5SkwRk8RmS6FIRzz7L2KVhkJejaRCulLgHKUT+P90A
    wgzkp2uVuE6zby74I91KyrWQfqeoz5xQyVyBddInzPi1mK219BrJQYv5u0LGm0C9Tmrogn
    jHE4yO8cAXnHQJk+uzF1iXPVYEoEvdaQCZZlsMmlFwsVauN4odpgCMYPtQKW+FDFkSQFoc
    CjMsBxXn5HV13MNFO0+y0uZsj8hxXNoJd/3OR7Zx0dF/1X8X7YDdOuKProW1chOdMHYHZz
    JHBUeaWW3+HncRQnGFYKcFsdol0bqfZ82/ZxpXoRIPT+nIIFQtdZiw5Gq9nju+85DHEhzr
    uYWmDBKjgjY7Uhtl8rIdIYsOWQzbGcErFXI3KZNgBAR18f2bSfbJfuUCAqs69nPtAFyPiP
    +GhP6jqerGEXM9OEKy+YkWOFQAwAhOZFUYr/k7FX+w15Ghh8lMPcIkBcKyvA
X-ME-Proxy: <xmx:HZV6ag2u3I5r6MKGa_SzPQxuu_nnzcDLwTE4kLKa0a6Sj4ot4rWzZw>
    <xmx:HpV6alv50VMlfzocznASOoNTtQNHlRxO83RbSVb90mFdyR1-ufkv1w>
    <xmx:HpV6au6j9DE1Z-WMZTqMSofLN5JH5WqhI3zN57vaIjdTr0nz8ShUqQ>
    <xmx:HpV6apec4FyiodP8tB69s7RRWnRePSkJyY3RojM-Hj9ZKXDKNAN7Rg>
    <xmx:HpV6auo-05ulZM9qHXxILY5OLhaGJXlk0g_dLPrvB_YvsHc85aFyDwbF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 23:21:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Britton Leo Kerin
 <britton.kerin@gmail.com>,  Elijah Newren <newren@gmail.com>,
  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: [PATCH 1/2] completion: no-op refactoring of checkout completion
In-Reply-To: <xmqq7blx5oor.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	10 Aug 2026 20:19:32 -0700")
References: <xmqq7blx5oor.fsf@gitster.g>
Date: Mon, 10 Aug 2026 20:21:00 -0700
Message-ID: <xmqqse4l4a1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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
2.55.0-698-g3e60a4dc4e


