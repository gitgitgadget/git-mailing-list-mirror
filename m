Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555DA3D3339
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958981; cv=none; b=pjvFrbnKxlDqPhJw35RYRj4tY+CCjaRwKZXuoK6vCZFdZDBcG6/MzY8fO/5Q3PddhheJDNjc/hoJRweJu6XvQLW1SMAaCL8VRXc0GUveAorQ9rGpJgieNcqV1SYriD8gr9ODOFz71lLGiQk3JE1VjG3gNF93M6bltbgQNLvasWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958981; c=relaxed/simple;
	bh=vkujFTsxeLmopQqrFIeMS2qtm+0+BMbsJSvLJjkYy0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql+XXX7gV+XC2A4/vpO4vLdLomyxxmTtaXg/EbphRrwNgoyfe684L0G20MzsHdQIYTWGCg5o80LdS5lPA1AdFWjM8s9/ZKVny3xN4GGNINnTrArdMHi+TWyjz0G50vwwe1sKlAqopX8hIQGJWYP+zVFKz+KfIrf+BQbz81jnqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jdK1FJU9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDlc2J+p; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jdK1FJU9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDlc2J+p"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79F927A0097;
	Wed,  5 Aug 2026 15:42:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 05 Aug 2026 15:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785958979; x=
	1786045379; bh=yoIPWGpeaGu1mfOCxtJnkcAoPyJJTfM62z5OUbUNOVw=; b=j
	dK1FJU9Ab+AfUc3BLkq+0WPCE/rYExyG4Cf09A/InM2x8A4D9/PrqWUo5LXCgAyg
	9vr5Txq9gP1afpcG657ShAL7mM7IAOOQ/1ZAkvM6NrQR6KtF8FeO19IdSXBRHJ5o
	M/keny8QIr+Mx714Vm0TEndvfor9FgwGMZyPwiRxRoVV0RNcLGFqjjRn0rv7NTn5
	J2uAQQ6iY/GGGgu61gvVgA31evYDyWlLOWYqUvSBCIPOvKyHJBPSteXpsvYR0AvP
	7Q94+44MocjMfXZVMdGerikmwSlzGYJ0VyvP7lcJNNY+G+5H97efCmeHFCguuYNT
	fHgWK4eUTtY6vH3CppSYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785958979; x=1786045379; bh=y
	oIPWGpeaGu1mfOCxtJnkcAoPyJJTfM62z5OUbUNOVw=; b=CDlc2J+pDbsPC57Fb
	+784vTfCLr59k9hshW4I6RSpzQ6aGJMDw/7ZN/jtdRdn6md/CbLAkz2iRoPzC6IV
	LfAP5lQe4T/dnSlNPiWUp4dqMV+SVKi8DnANdVB9PNIFEuhFLOXlOyrsSrOg1RZX
	jNo0zkTwlMBDH7g23bKvqLeBnTu4CUjWki2uC2BmPPXy+iyC04t1zjS8WWjoSRl0
	iDurfjXOqYt4grDSnqWTyk/RWad/3NoXDKzbUqnk2HG6OH9v+oH6VwTCI+0TFzHq
	dcbdUR/ONu+pUZTF/PlvluRtHJBjfWtroULU/ilWUQFNXKlt1RCf3H0gzeQsq0eQ
	VVWrQ==
X-ME-Sender: <xms:Q5JzapNG1GqIx4dYJf_EtAoo0JawySUR2HYViVhEpagy3F4iQefFqA>
    <xme:Q5JzarAZt0v6u0oATU-al_dVabgNxeDHsf5ZOKlhEzldGWLwBnpRqYn17X69-5M-t
    uzTJTVU8RDMgpvSfvqatNL9yubJSRMJqwY-Yn6bHIIbNupQ3oq2GVk>
X-ME-Received: <xmr:Q5JzaufN1p9fRUWxrDBXRnS9grngKik9oS4XypCkzwD2MUJ7DfdiNnpRF6zDuwyZa_8sal5uUjmz8TsG6aD-2RTcoQMNH-y3fQ>
X-ME-Proxy-Cause: dmFkZTEnTKk4KYDyqnRoRBJmy2/UMGDifkBmrQI2+K4xM8TZ6536BfGReSZnfUjppMlF82
    e4lazL5A04wOv48DeqzJLY8S54PVLBg3cBd4wWQKdvSf+6nP0xj90+r674LdRRxjw3j51R
    A73abH8QeRk4lpQNWE3Su2N6jkl3zpln+TIPTW9Yy9NwE39pLpijInOAQQnzDuuoG9T1Zh
    JWDkXTjOgq1uANBb46PCQ5HYSltdHrCMT2coJTLMKYov4FP1AYbC+Ia9tIha+w0wb2igjO
    YimTywUMAt/aUUbStjxGCQ71L580CrJPk4J/F/sukELklkb9oRhcr3ie1jmSxT3Z3FNFku
    e/UF1/NY+ddbbF4kBlGYLBPqCerpA1D6NU9CCIO+c38+fvNwHEwMOLI35Z4RaiaTnUgy4m
    HUmfX2oZ+VH0hE6KMfPbHpkvLKb3yFTfu0ZMYRGOkpzVUeDLAMG+oI2l0BGrGk46cROSuF
    sIqUuk1seKvKVGK3S9b5uxmD4Z95UCgiInf0l5KMxCnlGQJ810Zizy7BS/sqDHNnZHLfwF
    QNqSK2jFBJ+Jxg3t5XyBzsNV15/210mOdaaB5AqUKZNs7pZI2MFhJK5/BR98oK9QBqIoaG
    HifDBt0bjTcXi43v/hLvAxaQVI+kZEgq4/Lg/vR3acZfD7/uL6+XYDUslPKA
X-ME-Proxy: <xmx:Q5JzaiNTUKPZYClXzpLPKiiLT3VBplMobdnqsLZqITbyHhSLWi1ULQ>
    <xmx:Q5JzamJmZ9oP0QGMqCGQJ15ytIi1RDPkecgTUaZJ8ylEo6jK_qg8ig>
    <xmx:Q5JzaqKhEiNcZ3VYowV6D6jQTVrpZxWqs9KJQ0yx5B3w7RmpZQeuoA>
    <xmx:Q5Jzao6uQaxO_k51s6h3OaggbmmT6HLUr0qCw00ITdgXPA9wJoycxA>
    <xmx:Q5JzaosSImi0iNhkyeB1S0ScLe1AIHFpJKrirGR_N1HwGMsOD-qRwumO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 15:42:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 3/3] completion: 'git diff' completes untracked paths as a last resort
Date: Wed,  5 Aug 2026 12:42:50 -0700
Message-ID: <20260805194250.3316220-4-gitster@pobox.com>
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
index 845fd19f70..7741789e41 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1985,6 +1985,10 @@ _git_diff ()
 	if [ ${#COMPREPLY[@]} -eq 0 ]; then
 		__git_complete_index_file
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file "--others --directory"
+	fi
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 10ac690e21..53a2bfb2ac 100755
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
2.55.0-653-g9745b9777e

