Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505F35B64C
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119609; cv=none; b=YztqfNbMm7k8vvrwxccwOK3rljW10tW2L22Imok7DkAGOf0dr/PO2O8zB0tgtFPhyb8N8Q9YJ5kiz8oPKrzc+nDNgLYLZ7wJFKLKqQt4wmGN2JQo/toMzvQ1sCBYuPuiM96v4mzn4/OM4V3Wx7z7QuVl0xGN4g4ablwGZYen6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119609; c=relaxed/simple;
	bh=Ut3yTQngkKvL4WS7nQuNW2pqm4wX+uFdcPhy/lFrsw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6B3b7AXGDYtkE53fta+hkdkgA9DY82G828cJQAmAGXvTGP/air3y5iP50fCSumHdIEYY/xukubRvtQYopaKS0yE5s60TmY63GqjvQMkK4ZbLKQJ3jBHwoYCoLs6v/WuTgWC+xNj39zEy67Wmz57y8+0jSbqpiWPZfUsVik/kU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P/fpTbF+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MHjgZZJB; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P/fpTbF+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MHjgZZJB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A18F47A0135;
	Fri,  7 Aug 2026 12:20:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 07 Aug 2026 12:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786119606; x=
	1786206006; bh=B+IaCcITEo+39jZLap0eyW7HsYG8DMxutJuJjagcCGQ=; b=P
	/fpTbF+v8FYix2zNasOYdYM2YfZ5eXyQ6slwcsEZKS5rpkHPeUP2JdsQtChMHT4e
	73Y6i4XzhIa0zT+9o2/VyvxhMVNYbd8eoti6sos0YY4qZSJuqCdWkYQCqR4tmN0H
	Vvu+WPZRv5AR1hveKIvSQ9TsUkKp0yLYex+1PYP1QhuBNGYQUMcAQmrhkOySl1NB
	x3rUajFTs4T/2baYE9rCol4s/vudvViUQPrIEZZWJ0nzTwmjVo4giC3RmWa01xPU
	nkrURegNCxP9ucgYs0xyiNo+tbT2P9KQLmT7QZuLrT1Xcmvt/EHpmL5iKsw446nP
	0h4BykPVB4dxQ+MqVg5yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786119606; x=1786206006; bh=B
	+IaCcITEo+39jZLap0eyW7HsYG8DMxutJuJjagcCGQ=; b=MHjgZZJBJ+iltiN6Q
	rcCdSry0DnoMfhBR3k3tay4rACTbH6vumKp6/AFDv+xde6gprQx6nhkPM0yJjXuK
	QLUphA8oxDAdZOZkx/tqCx7b3ffUk1wVCVoz6tBKzfAif6phq/KnJlTmeNWX8/bN
	Abr1NppzPIsYCB/W0wcpRIeLdir5UmVs4wKmU7YPudoITFRO7xB7Dk1PA0octv3e
	fPI8liECuY1lCYvdVRYqs/ZavNGSo1ibTfg01qgWebUH/U5CB0O0KIIeWTGnRrhc
	2H/eecl+0dDEFQCFdX8qNFbTF882v9iP6ZCSneV9lLEbZEjru4HkvD5dSgsT+WjE
	mowKQ==
X-ME-Sender: <xms:tgV2amJ4xmN1yVQo9q-Jjpfn4VVoE9ERG0YWaz_5yEYPvKbM8McoEQ>
    <xme:tgV2agsutfTps5qdPf82zElegFn7hI6vSw1elrSRx6mDh_umMwNnxrZ0B2BtH90As
    IYxXui-IE90RCeUaD-4CbjXsetWS7HspLT2pu1aWfbgZ8hynIQvWA>
X-ME-Received: <xmr:tgV2aqVRxHuAKl9LreQhJjmgyHcI5P14Sq4vFOkZQaEshpx7tn5D0yhzv5ifNfU02xybt1_pqzWSb_0UJlcFCa0FfjpiUNla7w>
X-ME-Proxy-Cause: dmFkZTGY2oQVM1ElNjpR7MhXjT5LBP9VS2L24XAqboTHS0xz6oiVPj2HvwnpconRjOwTOB
    sOPQICMTovmcNiTYQXeIRF2vLszQuNJ/FfJAcX1e9ODJqoCCVeRzq99XTftMkeo1jTKXjh
    bqBKVfi8maQbQLiTu1OT+83vUEEsqOOslohU88PDTu0Y9/ZuO21yYZXxN42QFHEesyM5De
    2c0VTU7l5Gcqry6DHoKq1/rxNHwxzjtgqFsmEF16Uh7TOtAHg3fRfeqqajJgS4/n4qaj1i
    C6xzrNJ7oseFK6jgGIujIqu7jyLkBK0+CYKz2+ftX4A/f3cUoYM63zDWKsH1zzETt342Hq
    hOiU1LFCPOuItJ7uTD8UgEWTsLgUl1VWPR/q+wCnwuTl4gZVR7Ga01ugNXp+mJ4DmOJzFc
    UNZHKITA3hx+vGc6KXFrJsn1fB2byW6Vgp9WGrLPfjUqIW0IkXN23P+2ABsU6BqhGh+phU
    HSFT9UFLZOGISBiADEXRKZOjiv5nM6zsAf0R6JTfHLtQkawk1U40SUgQMxjb6piCddyWHR
    SlurTLHihFiQgRkoEvpgr8aHeL83UIHmUroiI+zBXmQTKoLZK2BpjIfgNYSR0XIdyxorSL
    b58ekJMmQZa/cMlgxNxD9WEqTSAMHbagUp7OmxF0n6Uum7QWN8Wylhdx0eKQ
X-ME-Proxy: <xmx:tgV2ari2mXvWwngQdAtzJgVum_t8nePLn7R_IDee5iyekX0N387S-w>
    <xmx:tgV2aipMvD0Z_2s82WmTe34svkAYBN0OAga4ALb6vaRLWFAikyfh-A>
    <xmx:tgV2ahHg8yl2_CpLrXkvfJdwB5h6tNLSBRI-ducDiQY6tflGVVd-JA>
    <xmx:tgV2an6p2A4viiU8h6mIK21BbFlRt1zEgX6sNzSqZF_NmT48Ks-pjQ>
    <xmx:tgV2agUnPQi-A8PWz0YblkPCIdT-SuQR2y3oP4Wl6sOWDPjqm7JWMSrq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 12:20:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 3/3] completion: 'git diff' completes untracked paths as a last resort
Date: Fri,  7 Aug 2026 09:19:56 -0700
Message-ID: <20260807161956.1004889-4-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-655-g8b87133eb9
In-Reply-To: <20260807161956.1004889-1-gitster@pobox.com>
References: <xmqqcxw010me.fsf@gitster.g>
 <20260807161956.1004889-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We taught 'git diff' to first try to complete revisions (unless '--'
is present on the command line) and, failing that, to complete
tracked paths.  If this yields nothing, it lets the Bash default,
which offers paths in $PWD, kick in.

Teach it to complete untracked paths before giving up and letting
the Bash default kick in.  With this change,

    $ git -C another-directory diff un<TAB>

finds the 'untracked' file in another-directory and offers it as a
completion candidate.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |  4 ++++
 t/t9902-completion.sh                  | 22 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 76181e8714..d35b4f3024 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1985,6 +1985,10 @@ _git_diff ()
 	if [ ${#COMPREPLY[@]} -eq 0 ]; then
 		__git_complete_index_file ""
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file "--others --directory"
+	fi
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 55361a89e1..85f92c552d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2663,6 +2663,7 @@ test_expect_success 'setup for integration tests' '
 	echo content >file1 &&
 	echo more >file2 &&
 	git add file1 file2 &&
+	echo untracked >ufile &&
 	git commit -m one &&
 	git branch mybranch &&
 	git tag mytag
@@ -2728,6 +2729,15 @@ test_expect_success 'git diff -- completes tracked paths' '
 	EOF
 '
 
+test_expect_success 'git diff [--] completes untracked paths, too' '
+	test_completion "git diff u" <<-\EOF &&
+	ufile
+	EOF
+	test_completion "git diff -- u" <<-\EOF
+	ufile
+	EOF
+'
+
 test_expect_success 'git -C <path> diff completes tracked paths in specified repo' '
 	test_when_finished "rm -rf repo-for-diff" &&
 	git init repo-for-diff &&
@@ -2744,11 +2754,21 @@ test_expect_success 'git -C <path> diff -- completes pathspecs in specified repo
 	test_when_finished "rm -rf repo-for-diff" &&
 	git init repo-for-diff &&
 	echo content >repo-for-diff/otherfile &&
+	echo untracked >repo-for-diff/untracked &&
 	git -C repo-for-diff add otherfile &&
 	git -C repo-for-diff commit -m otherfile &&
-	test_completion "git -C repo-for-diff diff -- o" <<-\EOF
+	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
+	otherfile
+	EOF
+	test_completion "git -C repo-for-diff diff -- o" <<-\EOF &&
 	otherfile
 	EOF
+	test_completion "git -C repo-for-diff diff u" <<-\EOF &&
+	untracked
+	EOF
+	test_completion "git -C repo-for-diff diff -- u" <<-\EOF
+	untracked
+	EOF
 '
 
 test_expect_success 'show completes all refs' '
-- 
2.55.0-655-g8b87133eb9

