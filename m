Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855C468C33
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553336; cv=none; b=uLTaPztdjdrF5T2FtsrNP9jnFW2Vn5gN9HAucom8x+x8Ljq1bsu6xTnOCQpfa/S2Vs2tCvl6HImx3P9MX0o7H7WDa0NVWUx8UV4OqcF2XApshBghkgMKo2gVFpgVzqJA96V6oQi+wL6H3qlFjILhVXo8cA7fxXQZr7CV1VeSYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553336; c=relaxed/simple;
	bh=IOhggzoJq5EnhGHzxqcsB3X09EgkLkMpo3QKw2VlFyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkswHuT/ueNtMrKJv6K/qs+5VMJSgqpG0EO5Dx8iLXDgG8p8xfaMYPmUoTMz7btDCka4vrbYq/7cxXQbbq3q1ua6OmRo4wgdo8NA6UFHiIwXbTcQinUgt6BlqiwSEwuCW1waJWAIr9FByWiSNg+AAGCjezHhA3XdBSryIY1h58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N1+5HgOZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lj+Kpb6L; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N1+5HgOZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lj+Kpb6L"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id F3374EC019E;
	Wed, 12 Aug 2026 12:48:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 12 Aug 2026 12:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786553332; x=
	1786639732; bh=OVf7vbhDWD4UIoT4+1ucLYs1mFrTlc7pIN+9Y5ujxLI=; b=N
	1+5HgOZfXOtML+Y/vVzbBCZfItGlQPL1UrCgfXfshW9gPj7vvfAkzUQz8SrzU9s6
	0/TswaKJMf9Z7uD4X1qji5UtilEELKM9b9S7ua9k8YNkCsufY3djvnCOCLUFpFjY
	sPIknFpnsj2fV9bjCCqmOHS6ahHbVxdlV+pJYgjn44B9nIlEa3M3/9e3kJdIwuky
	vscY1cWtPoJJjbNk26NcLFEDSfczvIWwOmPEOBx+AzX8ByfWMOuxtWlGseXfSDcH
	caCv6ktQFkEjCJqwtitSLuQ0zGMQBpfshYls6GQvmhqIIbpNdKWykQKTnMY2OWd4
	h7XvjZdI+vo1k5O9UItNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786553332; x=1786639732; bh=OVf7vbhDWD4UIoT4+1ucLYs1mFrT
	lc7pIN+9Y5ujxLI=; b=Lj+Kpb6L0TTuyfHxMPFxUsP8/j4ub8fLwf4pHv3j3PJq
	CwLcRmJ60JMLf8JpaWeh9zPqJMNuNFclyGXNACsWLwvyyNC4siGTjHn9nzHV9tS4
	QxgGR14pZDomIUchGLQmNs+kaazJ5zhRdzJIl+ESEVZzDD2Q7Z60scbSdHc1Jq58
	FGSgprJUsyYhVrr9ccuYGeWvFSM54sHtxWIrVs1JosBO0EeAVALJk8fr0GjkUqM5
	kVFTljcrjopoBbdQ/DGbCQIHdAU0Y+9XH1wLEA7oXHPWlTM77l0hiGi/mpDyshP8
	CKCTBUuRTL6jl69bfcOWHv7FOXuH7tCwxWstdBPVsg==
X-ME-Sender: <xms:9KN8anRFhe-RdzWZ7dj4n0OtFLq5TABXxi6VDkHPYwvcu4Zq9LQ9PQ>
    <xme:9KN8auxpqC87g1anHuocoP-1vMJvY-l2EjaQ258M5ZSRlpZckIuhvl4fMCOKEnQNl
    qK6CHqAwR12rCoqhpV6gH8BumvNGbeYImyKVZdZIyp99xl6Uv_7>
X-ME-Received: <xmr:9KN8aqcXuBsT5pTZmymuccSV5bamFFeT7Rk239GzKydLE_SLG0OVtiOWIc5fKX9mZdIFzflRFpWV84Ln73Df_tqCwnfwSBbyBg>
X-ME-Proxy-Cause: dmFkZTGbcGMnreNzUhovU1JHNbOQQAcr1IH07N1gMlNTXpRddP5CnwwPu/+ceMOh3NJeDg
    YMUhqjJyTfW5iB3PdXoE6SyePkR3aSlnfVemmbXL/p+LQJ1UaRNUdhna0fSeFIotbMBXXB
    95aca/RSXBas2r9asOD8G4/n2Z0nXIwCuvo11SzdCN8Jg45He3BRrJCoJhTuhBSRKhbefE
    f2DmN6bOUvHUifQzUbDVLg4JFhw7fdVweAs8Yp79re15IsPnZqhhRsJBraMpdyf+JO3Xy0
    UtixG9JlpUE5cCoeaQ5CA6pWZTBCCUN0hlnGHVciH0PVAmmmfE68bWJLI2Znl2rPlcEMJT
    8BZzIrCKr0chPGTKahYoCMEAKi3ZKPhioC3zsXQspIxpPPCbzrf+HOQa1fuHWHMUPGmbeO
    0Lm515t/+42PTKy6Ns5hcW7PqdMWukjk1Ef51I8P+uQeaXAt4NsoM/S2eBXipXq4iGQl0f
    v5v7SjNr54CbssvNuGz1XZrsq3x5MYjveDSCxK3paFxCRpMllBWRxbvW5c3RmnXi6N639w
    LKnHUehReyPJOceAtIzz/BgQczVa6XotreDiXtaK4cIbSLtn9I417ZGOcL+461lMRZkwa+
    tJpAm7/o5hpfG04M/uV0mW7G6/O+hKU8Oog/oKIYmFzw4gD/NIeQ89m4UZEQ
X-ME-Proxy: <xmx:9KN8aiJlcPococ4gQR5s7DNeWI3yuJeF68JpZ0RzileAervZT-tnQg>
    <xmx:9KN8ajEZ1j2nBKHSWkVw-m_nLBfK2MBcUZpwawnUE-7m-KTBqj8NNw>
    <xmx:9KN8akqrjgMkTM8g8J3QA5Erks0oIWzerog22cCT_jf52kIBt43lqg>
    <xmx:9KN8akQdcKFxMMmuFbP2VRhH2s7kuqOSZ0uN4T4U0_t3RzQRPG2Bfg>
    <xmx:9KN8aqodTpYFsUUU9DY-erz4D9oVjKIJ0hzZ9174vjS6eETneT0sLsd1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:48:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/3] completion: complete tracked paths for "git checkout"
Date: Wed, 12 Aug 2026 09:48:45 -0700
Message-ID: <20260812164846.2236221-3-gitster@pobox.com>
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

When completing arguments for "git checkout", _git_checkout()
delegates to __git_complete_refs(), which only completes revision
references.  This is good, as mixing revisions and paths in a single
list from which the user can choose is confusing.  However, if no
reference matches, or if "--" is given, _git_checkout() leaves
COMPREPLY empty.  Bash then falls back to the default filename
completion in $PWD.

This fails when "git -C <path>" is used, as $PWD is not the target
repository.

Update _git_checkout() to use __git_complete_index_file() when "--"
is present, or when revision reference completion yields no matching
candidates, so that tracked paths are offered as candidates.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |  4 +++
 t/t9902-completion.sh                  | 39 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 38dec1cabe..0eecfcbf8b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1780,6 +1780,10 @@ _git_checkout ()
 			;;
 		esac
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file ""
+	fi
 }
 
 __git_sequencer_inprogress_options="--continue --quit --abort --skip"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b889ec8c77..13fa5c65c3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2714,6 +2714,45 @@ test_expect_success 'git -C <path> checkout uses the right repo' '
 	EOF
 '
 
+test_expect_success 'git checkout completes tracked paths when no refs match' '
+	# file1 and file2 are tracked but file3 is not
+	# there is no ref that begins with f
+	test_completion "git checkout f" <<-\EOF &&
+	file1
+	file2
+	EOF
+	test_completion "git checkout -- f" <<-\EOF
+	file1
+	file2
+	EOF
+'
+
+test_expect_success 'git -C <path> checkout completes paths in specified repo' '
+	# otherfile is tracked, oops is not
+	# lostfile is tracked but lost
+	test_when_finished "rm -rf repo-for-checkout" &&
+	git init repo-for-checkout &&
+	echo content >repo-for-checkout/otherfile &&
+	echo content >repo-for-checkout/lostfile &&
+	git -C repo-for-checkout add otherfile &&
+	git -C repo-for-checkout add lostfile &&
+	git -C repo-for-checkout commit -m otherfile &&
+	echo untracked >repo-for-checkout/oops &&
+	rm -f repo-for-checkout/lostfile &&
+	test_completion "git -C repo-for-checkout checkout o" <<-\EOF &&
+	otherfile
+	EOF
+	test_completion "git -C repo-for-checkout checkout -- o" <<-\EOF &&
+	otherfile
+	EOF
+	test_completion "git -C repo-for-checkout checkout l" <<-\EOF &&
+	lostfile
+	EOF
+	test_completion "git -C repo-for-checkout checkout -- l" <<-\EOF
+	lostfile
+	EOF
+'
+
 test_expect_success 'git diff completes tracked paths when no refs match' '
 	# file1 and file2 are tracked but file3 is not
 	# there is no ref that begins with f
-- 
2.55.0-721-g26b8014fc4

