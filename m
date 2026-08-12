Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35633A014
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553337; cv=none; b=m0XYAU58uGBnImyYQc/xvlrMRBkeC2I7VijGsJkPLeTbocp5f0cGI/jrP6K9n1/cSx4rp+n48oBchOiYOk6pqS4lg3xBpDR+0wKZV//V8jB3dwc1plRcOUIcFOBuB/WbVFf8hX83s4zzm4h25q6IkGjlsU8UOPY98cvh/VrXsko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553337; c=relaxed/simple;
	bh=j5hExFLz/Nxkt9sf+gT+v0+U9BwUBaTtDTbI2iiYlSM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRuAhB/Ogm5jb79dxb+yEhKtDPu8zLx6pp5twBWSL/aWJNPMc/bvRBWE0leZQv9ZETnj7SB3cDDMLIBG72jSl4DH8y9yTvy3CsArEwsg6To9eV1u0Ud3nRQ0F2vD2mb62UK07XsDuW8qFaCbrQAUgSl8r/08oV1tIJfvVn7cx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0FrF3yWm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJzGHKW4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0FrF3yWm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJzGHKW4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F18C14000F6;
	Wed, 12 Aug 2026 12:48:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 12:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786553334; x=
	1786639734; bh=ZUbK9hzhgrsFtjZuGofimnbuehxsvkli8437VvGIli0=; b=0
	FrF3yWmzOahJoyxbB0/cKj6y074kAfF387Pt+wlrRCTui3GqUdZTbkVUSkZT2McQ
	wJfkEfAyMJSSqsO9i0xZPL0H5CW7ETVSdOSBgvpuE2o0Bq4csi8thXJn3Dm/EKAt
	Gi1o8mz+cTdCOjktkV/PQQGI7Bz7jA+pB5dJEFGDgtvvmDYlTnZj+kbCsY++Uwbg
	UnCRyQ0ZDwCL9wEMgw1QgM0nX7LJ53Kw9J8UWh0vYsfdWf7d1mYoqXbcZHOxioNS
	bdfZxd0h8d3nrc+0Z1quG45W8+miO3qg2Z0D3UaV5iES523eELj6xW9kUZyhuWNk
	usL03PlY31rKjBuWD6rSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786553334; x=1786639734; bh=ZUbK9hzhgrsFtjZuGofimnbuehxs
	vkli8437VvGIli0=; b=PJzGHKW4fs/SM3tE8eceadWZJQhvOPy9+eUv99zJ59wX
	bvlIqRjyeZHBCqaraLbxolCxptiz//Xkoe4APmx7STdMGGVuxkhyzhyPgElbczfn
	qK/iVxp71Y8HO81wlxYXorYB1HCpiXTZne1B1Ua5TKiWD4JRmwlmf+W5NDAeNmRB
	lVID+/E4g5oYUwcXYi7RrsGAkK1l0CZuFfx0oeRnLfxgD4s7z2KKf/71IbYBV2k2
	XBbRSAgNthwfX3eY/59Z0IGJs/6n5lL3JHvAnSVQ7fp/ZCtGF195B1nsr1xo8OoF
	DgnQWj6IQgTysXBNphfl3Eg4XT9QtF/J6CdMfQao8Q==
X-ME-Sender: <xms:9qN8arRUqTufWpDnco1Ox6eoq1DWMQdOuQ-05TbuKLLKvb2uV_iCDw>
    <xme:9qN8aixoto86QL0E7lGqLA5Ht7157lh80HeX7aIZjA7ehiDkdGrpHmNW76HbQ5pGL
    OOezEB6FgShaDOAEzOo0WeJwHZXob9loIhSmRb-pb1osNjsrKZ_MA>
X-ME-Received: <xmr:9qN8aufYGnfQA91r_Tdvz3Fa48KrrjlJR8ZKmBgKoWMLrQMCEFhLl4UzkyKHPWFgiV9KIgDxsxiHFLGymd7E4ocYbokTiVcEaA>
X-ME-Proxy-Cause: dmFkZTGbcGMnreNzUhovU1JHNbOQQAcr1IH07N1gMlNTXpRddP5CnwwPu/+ceMOh3NJeDg
    YMUhqjJyTfW5iB3PdXoE6SyePkR3aSlnfVemmbXL/p+LQJ1UaRNUdhna0fSeFIotbMBXXB
    95aca/RSXBas2r9asOD8G4/n2Z0nXIwCuvo11SzdCN8Jg45He3BRrJCoJhTuhBSRKhbefE
    f2DmN6bOUvHUifQzUbDVLg4JFhw7fdVweAs8Yp79re15IsPnZqhhRsJBraMpdyf+JO3Xy0
    UtixG9JlpUE5cCoeaQ5CA6pWZTBCCUN0hlnGHVciH0PVAmmmfE68bWJLI2Znl2rPlcEMlh
    Jx3mVXduF2x1vVEYa+KYafBopGTlbZ8jUGBI5kldKDEAxKpRlsTGQqUtEy+tJ5YhURSZII
    OBDJFqJiX/FdUOKSAzMd0t9L0B0Gw/53Zt7n3kz5mrFkIY2SGY2KQrbkMz/0DGj8pHQgC1
    B+5g3tFsVSRRIzV7x0+g+6aZlzSUYDTqbW7UQKM+BAYar5ddWOk3JShWE+SVGQ3ZVUKaCw
    Fbkres3BVJaxJZDn8VV13ECEI+A6TwwA4Tbw0zPtKRv7jVVA7Xc/s/h2tAGRYQB+E7W6up
    czLMztZK7vTUjUATLYqxoVeEA6aA0DFR91iUz/p/ODWoO+1vLPLY9xVctN5A
X-ME-Proxy: <xmx:9qN8amItHERlIj4T1JZiUJWL_22PeORVMWl3GeQkanmvXpVktaOjFg>
    <xmx:9qN8anHc4wxBKi4m7NQY_FeVG1_h4W0egHGLTJi8kA42Art-cekb6A>
    <xmx:9qN8aopN1ghQd6yzVAt0oiLRwE1wfPwQTnFO7gLATlgskfwTeUiIxw>
    <xmx:9qN8aoSytU-hgBIP_hEGktRp91Xkk_4gHezRt4nBv8LQn_912sKQHw>
    <xmx:9qN8aurM6mMOvCsb_f82V3kLGDlrfmKW0dmVwXz3Nj2MHSDp9cU08FZb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:48:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 3/3] completion: 'git checkout' completes untracked paths as a last resort
Date: Wed, 12 Aug 2026 09:48:46 -0700
Message-ID: <20260812164846.2236221-4-gitster@pobox.com>
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

We taught 'git checkout' to first try to complete revisions (unless
'--' is present on the command line) and, failing that, to complete
tracked paths.  If this yields nothing, it lets the Bash default,
which offers paths in $PWD, kick in.

Teach it to complete untracked paths before giving up and letting
the Bash default kick in.  With this change,

    $ git -C another-directory checkout un<TAB>

finds the 'untracked' file in another-directory and offers it as a
completion candidate.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |  4 ++++
 t/t9902-completion.sh                  | 21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0eecfcbf8b..22c53697ab 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1784,6 +1784,10 @@ _git_checkout ()
 	if [ ${#COMPREPLY[@]} -eq 0 ]; then
 		__git_complete_index_file ""
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file "--others"
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
2.55.0-721-g26b8014fc4

