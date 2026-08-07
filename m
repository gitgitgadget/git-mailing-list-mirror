Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D52EFD9B
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 01:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066735; cv=none; b=ZSz0+SihhqXoHhXVnDCTiBSYaR51q+ReB1KUvoH5qyI2O5MyFuJpDVcqOIV5ZcgOJCwLGXTXuI5ixvVTnrnQnKUJ8PK3FazXHZTei/POxbMQZFa1++8qB2ri7PMrk0SGj6FHl2jB9KflNwoyISSX0wewzKIOvxWgwMQA4Iae734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066735; c=relaxed/simple;
	bh=mCIJReE+uPUctvDvgeK3nNe+u0ML+aBrlUnp744+pJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZn88ycPQdBulbm+YrwbyeIuZ95Nn6aQx+PWQT/auiOdBzgxcChvx4GL74DqSzrmfZ5MFBLhmxVHmQrIZYEt7ESzV/DGvipG9vm+//O1v/syaxHJ+m5l003XR4kCwlGrWmrVz3aISkHWuZGBnzRP0fZ8A+02u7jTA7nw9vTddXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cMsXq71v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j49MzGnq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cMsXq71v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j49MzGnq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A12721D000CF;
	Thu,  6 Aug 2026 21:38:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 21:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786066716; x=
	1786153116; bh=yfLuv+Jdacjh53Mmw5JGELJ4mEzLwqWdcPBqkXwBno0=; b=c
	MsXq71vLB00jrF7gqdoQCJ1VDxiJepwsSKescafY1qplbbjIk2Pkg9HIkyGx17Vl
	ZMO0USiWH0zaqfn9OEbf7lDs+ewmJpW/qIeqhbQh73jEwUfk5cqXQqCTcnmchfq9
	aln7BZQ+Nip2SceD1UjVZtlWja3Z0tBvXjahOcYEwY9/Xq3sGKbrfpkiuBdkm1M7
	cLXGF6Mv2ji+hwm/DeYcXEktL78OVaS6hjLU8zdHz254d2U+/+5Qd3/nNSejHxfK
	7XfvXm8Tctc7thjtujnZuMs2iIXKCQEKwDawegKx+OBY6nS5VbDYOL+TrMoiTrsG
	oOxUY4MGrNIcQAxlUUfiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786066716; x=1786153116; bh=y
	fLuv+Jdacjh53Mmw5JGELJ4mEzLwqWdcPBqkXwBno0=; b=j49MzGnqKq7JBcF09
	Knq1+VXeVcUwAWTjLrMbIpyW5TUB6QqiE1Ujgpqi+QUIsgc3CfHD6PfqTaf5Qt8B
	e5rRFXI/v0zjwkWkzNN/LH+vo4p2hEEwR+x/bctRS5ychOIgwVf2V/S8euS58+ya
	9YN+g3KCHXaFBdMkovWxL/po0zf//GKGN5FAtjeNB+xWcafNcY47uxpTFuHjEUkn
	JJ2TRGnthPU//NbBUXdIoPo0EshuqdrcbcOH3NFYBLyeL9xWTrBBgttoxOs1dhhT
	h/cOtvfQ523flnhhR92HXk2hFGS2HZlR9FhTr0Tg7QPdtib2+2gveQqJ5kRu769T
	ezDgQ==
X-ME-Sender: <xms:HDd1ar8s7qGZYWpEVBj437zQ_GORYc5gSH29MDkVM8mSc6vl4VvLdw>
    <xme:HDd1aqSHZAOTUW5tKlCjFHsflm2YcK7EMc8zdsXHa1Xy6xfBhob1yoJ2PQDG98OGO
    C36rOqQv-LuFeTQK3IBMSvdEfz-bl5iphi0OWRKyoCnZB6hS9oA1w>
X-ME-Received: <xmr:HDd1asrt-I0zyywXqRLJbfyMeTYCZAYZjviUMVzmiTfQsvRdIqDiApZPYEeOH1hi6v9kpzQ2thmoZWy5WxMqa84HxG57zOJ_nA>
X-ME-Proxy-Cause: dmFkZTEjc8wDCDVEICS84IWTsMaN15oqok9/O3UkxynRtRGk9EG3D8R/Mie2Ce5fiNqCso
    FBGDDLAX7jozFN5sQfaWOtVPCXn9g8armP1gIfPuyvCCpbC80A5YwyfyRmgtboxMit/XlM
    9M83BJTGKBAREdfOu3SBDox+8d65efAw4zvTAUEsqndyXgw4BeVpsbsiKdrKCmoj+jDP4R
    3ipPl/HirLb3DkKy45PiXtvEhEIb7SDEZAZ7Suh42KWSXHlqWhhQw+Txp+TKabMt9p6Osc
    vh60MbHxqeqFGH0/V8pZEnvPkVdcuJDY+y6Nxpa7oKGVK4T0uaNWcSxYCbEMxiehl/ysfN
    A4sUfE+V7iLnMBBOTDj+M+TxD7Fd3izugOnBmB09AZXJleRfoiROWi6KJpMaRNUlh8kYSF
    tFOV1FO6Ng4Z/pB9DUXAHVCx9m0NAt0/IisBjMR4WqytTSMIzMMGljNpXzzYZkx0IXGgVu
    jSFtVMC8d6bonkka8vz/oenzgYzzZFQYu5tOxI+A2xmDCV8AINS59iQPt6eCVDGGwDpFuk
    j99sZzh5CRKiweengb0H8wN/tt69oEpZjrDhsTIXEokAINVLxoMLC3wlct/o7I0p6UizkK
    iFl6JWnkYTGNSnL1xyK8sHXXKKeqoZvGHv4qEMYNW9/l7+sZh8jM47vSRvNQ
X-ME-Proxy: <xmx:HDd1anlwZYiZp3xaU4Vt0mNVr2n1aNaWxQqqt7pq2ota2uL7G7Dl_g>
    <xmx:HDd1alfJSVUO7pG-iBh65OFgkG0PwVpzQ5hca3pGcTWjKuR11y4UBA>
    <xmx:HDd1ajqaJLsdMwnNviwEAD7rfzK2vTfPLI0pRcJOMg2qGitlwJr35Q>
    <xmx:HDd1avPCpNM_jkdGZn54Bc2vOWuhVQRbcl0hdQmJeQ3AZFL-skvQsA>
    <xmx:HDd1ahbroUhS9F9wcty6yAxfB0sri7JMOvge-LneVGQQ6l09mg67JAd7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 21:38:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 2/3] completion: complete tracked paths for 'git diff'
Date: Thu,  6 Aug 2026 18:38:29 -0700
Message-ID: <20260807013830.698340-3-gitster@pobox.com>
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

When completing arguments for 'git diff', _git_diff() delegates to
__git_complete_revlist_file(), which only completes revision
references.  This is good [*], as mixing both revisions and paths in a
single list for the user to pick from is simply too confusing.

If no reference matches, or if '--' is given, however, _git_diff()
leaves COMPREPLY empty.  Bash then falls back to default filename
completion in $PWD.  This fails when 'git -C <path>' is used because
$PWD is not the target repository.

Update _git_diff() to use __git_complete_index_file() when '--' is
present, or when revision reference completion yields no matching
candidates, so that tracked paths are offered as candidates.

This changes behavior even in the case where '-C <there>' is not
used.  The new behavior omits untracked paths from suggestions when
no revs match the prefix but matching tracked paths exist, which is
more useful in the context of 'git diff'.

When run outside the working tree of a repository, or when nothing
matches from revisions or tracked paths, Bash still falls back to
default filename completion in $PWD, so such a use case would be
just like completing paths for any 'diff' command, rather than for
'git diff'.

[Footnote]
 * In https://lore.kernel.org/git/al%2Fw2qgBfhe9qMg6@szeder.dev/
   SZEDER made the same argument for "git send-email 0<TAB>".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |  4 ++++
 t/t9902-completion.sh                  | 31 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ccd3b2a372..845fd19f70 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1981,6 +1981,10 @@ _git_diff ()
 		esac
 		__git_complete_revlist_file
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file
+	fi
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 55dc9eabfc..adfaf414fd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2663,6 +2663,7 @@ test_expect_success 'setup for integration tests' '
 	echo content >file1 &&
 	echo more >file2 &&
 	git add file1 file2 &&
+	echo untracked >file3 &&
 	git commit -m one &&
 	git branch mybranch &&
 	git tag mytag
@@ -2712,6 +2713,36 @@ test_expect_success 'git -C <path> checkout uses the right repo' '
 	EOF
 '
 
+test_expect_success 'git diff completes tracked paths when no refs match' '
+	# file1 and file2 are tracked but file3 is not
+	# there is no ref that begins with f
+	test_completion "git diff f" <<-\EOF &&
+	file1
+	file2
+	EOF
+	test_completion "git diff -- f" <<-\EOF
+	file1
+	file2
+	EOF
+'
+
+test_expect_success 'git -C <path> diff completes in the specified repo' '
+	test_when_finished "rm -rf repo-for-diff" &&
+	git init repo-for-diff &&
+
+	# otherfile is tracked, oops is untracked
+	echo content >repo-for-diff/otherfile &&
+	git -C repo-for-diff add otherfile &&
+	git -C repo-for-diff commit -m otherfile &&
+	echo untracked >repo-for-diff/oops &&
+	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
+	otherfile
+	EOF
+	test_completion "git -C repo-for-diff diff -- o" <<-\EOF
+	otherfile
+	EOF
+'
+
 test_expect_success 'show completes all refs' '
 	test_completion "git show m" <<-\EOF
 	main Z
-- 
2.55.0-655-gb2c071042d

