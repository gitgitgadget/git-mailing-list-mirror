Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE82F8E93
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648363; cv=none; b=osHJkzlHUwupEA9TNCvFILRUPERJNuE46tsCtBpCpunFE2j0vXZwwgBTkVTqu44WunR10LRk6S0ago2Lg+115ZJwdAW7ImnUSt3ETuQct2YYYVAZf0uH7gCC7D5CWKh7Pe2h6h+tn6Hml17ieNqO21QYtzlcErqx6Ju84pFa5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648363; c=relaxed/simple;
	bh=OxlVO45XgAKxWGcABz/SAGnBowVmTDozevJErk7qRDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdppRkt77h62BSXQ9CIvvULHS99QlO8v5hsoE8PnfiYe3rIpu/hhyo9MZrQOb1yaYmNCJepiE9LGaNvOfnfJc8G0rEW9hiXReJ5ePAY2NdE8+R90vuGDm13wLMuCGJIGhqPvOJm8XDtetpZ55nVefjq5Ezbt6VdQUuaxqYWCRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rYa5PKrB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=koPwZnwy; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rYa5PKrB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="koPwZnwy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64EDA1400156;
	Thu, 13 Aug 2026 15:12:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 13 Aug 2026 15:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786648361; x=
	1786734761; bh=OPTJJWGFW8rfUSDqJr7+Vdt4LldfwHyBFnRFRinsAnE=; b=r
	Ya5PKrBPBrMNIDLxm8F/bLUdeapSg0L5x8zrBDdO6XlY2vFG5aE6Qhfzi4jsNSN0
	O0v//d7CvFpbsHgf/6ZhGw50BEEUAWRpUIqEUjJcAJZH8Sb00Etuu1lHDQCdND0a
	6emEG4qMedXWwPiuXzScJxrlPKqkIYUyOUW1IzymD373hWYq1V95Kbc7BTSOvRS/
	JyO9GI13ie9OlJSNOWJtSkIVWMTFNTR0XeHKWOC4ILplIHJsZB9TGjXOb047UbO0
	a8uTMVKPAnB4rFger87pX/sgLJ28wJvVtc/SLnlYP6sUVSGwRBVoFD8nBupvntRV
	nRqUtV2UYefhYUt+i0OHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786648361; x=1786734761; bh=O
	PTJJWGFW8rfUSDqJr7+Vdt4LldfwHyBFnRFRinsAnE=; b=koPwZnwyRGKCtO8Ir
	saBGkDS/Zz0StfYTfeMNDImQWkl0UiY836P2k1chq3ZXqKg+kkBv5O6qDyIZ9OK6
	7I9SUQnCuSwDA2W0b5H7tPjhlElpkItKohG5czExsXkLq6dbGL+hHk7RxwoRCgMo
	YTNmV9ZMQZNwzbGQ/68mvFwk55dWWsvcgbU57qpEbNRbknpRuo8m2lQclvyU9xBV
	tinUtYI6NwQZi5KznAyyPbcL5+EXMXI0PsRwK9y+o0b3DhNyWKe29ar1lTrdFR73
	LedpzYMPB8Fs1m6ARNaW9mcm0UkPkc3M0dMtAhSPLHERQHWLszdXKXI8xIZ5Cb8Q
	7h4+w==
X-ME-Sender: <xms:KRd-aimli4ZtzOQyPyRfqAmuezCc6rLM4WjwgD-e1x-EQxgi5cFF1g>
    <xme:KRd-ahQgdkGGHNwUTGD3cCgJ3ZI1X10v3y1hWumr9glPSSnBTe_XHN98LgGsqKGYO
    XPWcyE_nkg6ui7zLzXYKKv9j1QlubiSIT2W4d3ajNhOO9w-tC2c4g>
X-ME-Received: <xmr:KRd-auCoCx_gALIu2uK0Yrx2_B--BYrpmpEWJ_8JzZ_1wevX5G-WoZt3CIk1oLhAvWJDqZlA4opG-wJfF-eYAduuiPDUJQrvww>
X-ME-Proxy-Cause: dmFkZTFt2T4H0ql8unK31cAUawntRe4L9uhSWwbjsT2l3YnHK0SpRTGdxeOiiTih2AglYh
    9ZbJWlVMoJkT9AfZqSmQy755715yF/fin9yw6MKrbDfyhbd8VHyRMC0ksORtZayNIwCjcE
    ZVkNZSt8HpksrAROnfCq81Q6fUpaRBDUX/XKB0X+eTHnVlIiBOk7kAW/8pjQ9UMQPEp4R0
    7pC3Gva76dCEO4jZRmv4U3g33uyZSwhFsoHQuj2A1+0TMm7zlse7pPag/ckYX7HYOOJdqD
    RF3l1lmNbTVZJefxsGPE6b7njXw/YxF1HOgVXoknrLsE1/J16US2GVWRUrUzK2nEzqCOpD
    EQXDhInwiJDwDzwfbMiUm7OZVLFQ3hJRTkR5GUrXC7o+N88sYYjNOWssO+nEeb//kBQOfY
    8BPQcOeuytx6kX+/ndN6YU2fS7sO8apZMR8iHDixCkgWs6Dusdia7luo3INJqvE8DZIAbK
    HP7eZXDlMHjUa+JItBZC1NsScdWSwxfmVayMQ1SdPwC5QZ1lTMxt3pZYAeGPKAW9t72RRb
    4ocERPzuoBaAPGZsaQdoLAfQdzJ4Qp/7uE3LdqVONq3PITlOjLneUAJQv4m4jrZI+pqn+6
    HZSbzq6s0aAZyKZoGPjJzwYQwYWoOUY7VgtdDBO+mEWE5BeYvfek2IXPIfCA
X-ME-Proxy: <xmx:KRd-agSr-oiAV0eZc5ejp-cCRAvsQ7SRaiGvlQ5IQBVPNNfl5aT4rA>
    <xmx:KRd-akrkcRLFBfV2aO8ftB1IWfG4pDDHLCNX6yHJrJwih4mmBCBDKg>
    <xmx:KRd-aqwwYticlBrCMzmdOnrX0myLRjbl3TwjaRm7QZyxNTNt7XTAhA>
    <xmx:KRd-ahJL7M1rt3gUeZFC9bTyBIUpuo9OqcuIEpf2iBqZc9aAXg4fsA>
    <xmx:KRd-alQr8WNThY1C51JknLLmcyF6em2WmI8XnPyFzAhWEtUXzQDj2xu1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 15:12:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 3/3] completion: 'git checkout' completes untracked paths as a last resort
Date: Thu, 13 Aug 2026 12:12:34 -0700
Message-ID: <20260813191234.1066662-4-gitster@pobox.com>
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

We taught 'git checkout' to first try to complete revisions (unless
'--' is present on the command line) and, failing that, to complete
tracked paths.  If this yields nothing, it lets the Bash default,
which offers paths in $PWD, kick in.

Teach it to complete untracked paths before giving up and letting
the Bash default kick in.  With this change,

    $ git -C another-directory checkout un<TAB>

finds the 'untracked' file in another-directory and offers it as a
completion candidate.

Note that this is of somewhat dubious value, as an untracked path by
definition does not exist in the index, so checking it out from the
index would not work well.  Even when used to check out the path
from a different branch, it is still of dubious value because it is
unlikely that a path tracked in another branch is lying untracked in
the working tree, as switching from a branch with the path to a
branch without it will normally remove the file in the working tree.

A better behavior probably is to detect the tree-ish argument on
the command line and offer paths with the given prefix as candidates,
but there is no __git_complete_from_tree() helper readily usable,
so mark this as #leftoverbits to wait for another day.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |  4 ++++
 t/t9902-completion.sh                  | 21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0eecfcbf8b..e6dce62d3c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1784,6 +1784,10 @@ _git_checkout ()
 	if [ ${#COMPREPLY[@]} -eq 0 ]; then
 		__git_complete_index_file ""
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file "--others --directory"
+	fi
 }
 
 __git_sequencer_inprogress_options="--continue --quit --abort --skip"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 13fa5c65c3..e8418f069b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2727,9 +2727,19 @@ test_expect_success 'git checkout completes tracked paths when no refs match' '
 	EOF
 '
 
+test_expect_success 'git checkout completes untracked paths, too' '
+	# ufile is not tracked and there is no ref that begins with u
+	test_completion "git checkout u" <<-\EOF &&
+	ufile
+	EOF
+	test_completion "git checkout -- u" <<-\EOF
+	ufile
+	EOF
+'
+
 test_expect_success 'git -C <path> checkout completes paths in specified repo' '
 	# otherfile is tracked, oops is not
-	# lostfile is tracked but lost
+	# lostfile is tracked but lost, ufile is untracked.
 	test_when_finished "rm -rf repo-for-checkout" &&
 	git init repo-for-checkout &&
 	echo content >repo-for-checkout/otherfile &&
@@ -2738,6 +2748,7 @@ test_expect_success 'git -C <path> checkout completes paths in specified repo' '
 	git -C repo-for-checkout add lostfile &&
 	git -C repo-for-checkout commit -m otherfile &&
 	echo untracked >repo-for-checkout/oops &&
+	echo untracked >repo-for-checkout/ufile &&
 	rm -f repo-for-checkout/lostfile &&
 	test_completion "git -C repo-for-checkout checkout o" <<-\EOF &&
 	otherfile
@@ -2748,9 +2759,15 @@ test_expect_success 'git -C <path> checkout completes paths in specified repo' '
 	test_completion "git -C repo-for-checkout checkout l" <<-\EOF &&
 	lostfile
 	EOF
-	test_completion "git -C repo-for-checkout checkout -- l" <<-\EOF
+	test_completion "git -C repo-for-checkout checkout -- l" <<-\EOF &&
 	lostfile
 	EOF
+	test_completion "git -C repo-for-checkout checkout u" <<-\EOF &&
+	ufile
+	EOF
+	test_completion "git -C repo-for-checkout checkout -- u" <<-\EOF
+	ufile
+	EOF
 '
 
 test_expect_success 'git diff completes tracked paths when no refs match' '
-- 
2.55.0-759-g9dcc51a0fd

