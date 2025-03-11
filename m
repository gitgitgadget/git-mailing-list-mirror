Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94B264A88
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728314; cv=none; b=He/8wcbcvQghYWmhFGoB7w/lSiqaURvycWulcQy6DDRTVIzeaPhOpTbdcaWUjcVxroRpzPxMuOhhvhJ+V+Uny01REJnMShOYyZAdP7x/GSwquV7PmPKMs9uS8hat4IW1IcQ5i2Zecc8foSwhLLJbsTN/q+e6KRtLjWBucWFX+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728314; c=relaxed/simple;
	bh=rJMz2Swxauio+A/vmwiT1WyxKRfvpBf8QhsZ2Fx0ySY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXKwOThsL3T5WzFHBFxsKyiiiCLtMs3G0Xf1jJ0eqDH+3bwJDxaPuIgGA9TLrYJXZb55OTfO99pdgLWi8aZkTUC4aUldohuPdYxQdq6uA2l5Kfrk2OEd4n+OPjpcFIHbeA1HKHZ4ve7i0DhIwQjBX0CREqll8/UzvcueTmnszls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r/tl5f27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MAYX/oDS; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r/tl5f27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MAYX/oDS"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E30C31140172;
	Tue, 11 Mar 2025 17:25:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 11 Mar 2025 17:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741728310; x=
	1741814710; bh=+Uy09orawCujF9qrZlnpUaqrlZYYnNwPzRbbwmy0QxY=; b=r
	/tl5f27yItGHSSjxn5X644Dz6xpVEhM3T5aKph7+seA1j0mtutxj1Q5uTz9GKzHB
	n4bQj8BV5mlJbvsGg4JBTFvEu2Yks2yv9Zsx2n6f3YSQVWZPwE4ITeLNDm3e90wW
	a3lROmmZrPzGrfzsl3Pfr6GdFs0fRML6TfvZKs6adm6dSvvJHr+qtuVjMBGW8kL3
	0qx1Pj2KhRXoDeWIRpSJJ/SSZznqs0oDDKaFUTwGP3Gncy0fX8eeDOLt2xZct99r
	FyDh8xVwUXIp2f/mc65TOWshwZ3uBHOuyhBtdaY1D8930kxFoMTvPyJ1wFwR3CgL
	T0cOsxaFnAmL0gfasFz8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741728310; x=1741814710; bh=+Uy09orawCujF9qrZlnpUaqrlZYY
	nNwPzRbbwmy0QxY=; b=MAYX/oDSodwT1KyNUEWOFVrRStXvd6RbH65AtgGLaoW/
	c1Gm2MwCv221MkF+aLzMoC2KiC7tiPVx3s1U31J7zz3IBilwG1aswh74/r3R6fVS
	7y6c/E5yynTUcrg5Y9Hzv71x02yrgRWf4GoR+Css8dqFLuVNIR/VrLR+QNfD79sa
	Dgvr7/YwoyfQOKbLKHIU/Nc+sbOAIAc+B9wGHij6UqxZXTuToVzqSqmo5SJdGX6d
	R1rzYVEPdzYvc+lCBk4/0y5wfBHLGmnGffr5AkhvYTnLZJQIn0qv5unRXwILyND6
	bevfek/GxybWZ3Gv5NGJ58DmB58ijglnxsYfQlowzg==
X-ME-Sender: <xms:NqrQZyKeevH1pgXhnbYvan7v7gZkpQ14STMn1kHn72WRKEPAB6Bbog>
    <xme:NqrQZ6L8lYZwCoERiYyTVoQJmCRjiLTJkNwhYonSblYLRytvdk4Uq6MlZz6R0zV4X
    KuKWOlMJl81S24o5A>
X-ME-Received: <xmr:NqrQZyt1jmc6CZn-mtxIke0qwFDG8Rf82TvhBfGT0kVhW3JdZXqI7zoa3SVh7R85hnk4xXunyLShvFACwcvny507rxoC9v2UDg_9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NqrQZ3bxc6fL5AvWBcT3rDgtzxpGf1yNnMqGLKiXcvsgQdhu75y_tw>
    <xmx:NqrQZ5aXWaAivuZyJa_0pJTzgaSGYyQh06TYL6x_phMlTAWFp60FMg>
    <xmx:NqrQZzDrhBeBnk7bWemJ09s3vZ8dnxa0FfVecLkCt2JrxXo33NkO8Q>
    <xmx:NqrQZ_bUwlFPXez5GvFPR3NYNmbxIRY7g_Tr0Q4HsP_0yFLffi-Ohw>
    <xmx:NqrQZ4nBKyAgHusgwoiIUv71Hu6rpf4yc0_FBr86UabWgZVTiwZ2Um-8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 17:25:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/6] t: extend test_lazy_prereq
Date: Tue, 11 Mar 2025 14:25:01 -0700
Message-ID: <20250311212505.2920181-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-181-g28e223d67e
In-Reply-To: <20250311212505.2920181-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
 <20250311212505.2920181-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow test_lazy_prereq script to signal a programming error by
exiting with status 125 (like how bisect scripts do).  This is used
to signal a deprecated-and-then-removed prerequisite that should
never be used in tests anymore.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/README                | 6 ++++--
 t/test-lib-functions.sh | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index 3ce9f5a393..e9ffd9a81c 100644
--- a/t/README
+++ b/t/README
@@ -983,8 +983,10 @@ see test-lib-functions.sh for the full list and their options.
    SYMLINKS ...".  The script is run in a temporary directory inside
    a subshell, so you do not have to worry about removing temporary
    files you create there.  When the script exits with status 0, the
-   prerequisite is set.  Exiting with non-zero status makes the
-   prerequisite unsatisified.
+   prerequisite is set.  Exiting with non-zero status other than 125
+   makes the prerequisite unsatisified.  Exiting the script with 125
+   signals a programming error and is used to mark a prerequisite that
+   should not be used by test scripts.
 
  - test_expect_code <exit-code> <command>
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 79377bc0fc..16eaaaf4c3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -773,6 +773,8 @@ mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-'"$1"'" &&
 	rm -rf "$TRASH_DIRECTORY/prereq-test-dir-$1"
 	if test "$eval_ret" = 0; then
 		say >&3 "prerequisite $1 ok"
+	elif test "$eval_ret" = 125; then
+		:;
 	else
 		say >&3 "prerequisite $1 not satisfied"
 	fi
@@ -811,6 +813,9 @@ test_have_prereq () {
 				if test_run_lazy_prereq_ "$prerequisite" "$script"
 				then
 					test_set_prereq $prerequisite
+				elif test $? = 125
+				then
+					BUG "Do not use $prerequisite"
 				fi
 				lazily_tested_prereq="$lazily_tested_prereq$prerequisite "
 			esac
-- 
2.49.0-rc2-181-g28e223d67e

