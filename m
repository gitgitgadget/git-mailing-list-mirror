Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486642CB14
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551959; cv=none; b=BpbeduKlfoV/EjW/DcDoWcxF/DwwnEwjo1EQjkI2jEmHMCGqT0De5Oeg2d61osEmbDwbQBVlkywsh0DwsXAsTSrTREMjjV+QgVlbozODVObeo/fBl0v5KilQ+CkaNFNPZ1cC51bGQbXnFwQagGt4kji/i5RCJjnwASsuXG2ybYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551959; c=relaxed/simple;
	bh=VtstlN/aYyk5v8nmS9tTkoDAKlzCs3fgYcIaC4jX800=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNG3sIHivtzd2Up47X/00ucKvcdqnfVUg7f1XgGHtREjtznPC/JJhOY95WYzzOKJigJWT5++neTp3H8AsED7ZnIqOX8/44s9Cq2HK++EvZe1gVW6LHpsA9DVRJ+5/Dhw16l6e8er8fLHHwDDy4L8z8DpN5y+GApM7vYGFTaBTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rZqr2+GR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFOx9ilj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rZqr2+GR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFOx9ilj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 524B3EC0181;
	Wed, 12 Aug 2026 12:25:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 12 Aug 2026 12:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786551957; x=
	1786638357; bh=YXTGeTWDf0v9PmQavPplUXz50H0UUwzIhqc50oNXIAE=; b=r
	Zqr2+GRTFy0YCX8N98SsxMvsxWiX74aWjJ4+GOHsjmb21V6dOLaQ3CCxnoYkfKqw
	cY2LyPfaiEdSko0/wglcW5KsAD0Zl+Fyqiwy+t5NbEMawkabHrSR+pAfpL53nipZ
	DuhH6+Q0jJxoSV77/vVswvjhbh4nFPD/jiZ2+vf8XYiKUGNB3pnXR2Gcw9B0659g
	On5QHoMxwn56sW/URtvi+mkqtxqOBA/Q7kXuNdt6V4/Ho8BPev/Css45HFqiULjA
	hJzQ3A1ufEVUygV7ArblgrT75Sk1HIxtVKfL3eE4tedkFJZ/5hEmpsMK8W9tvwSy
	yxI0MpOGDVd1CF1iASSSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786551957; x=1786638357; bh=Y
	XTGeTWDf0v9PmQavPplUXz50H0UUwzIhqc50oNXIAE=; b=aFOx9iljJsUD7r6fX
	o3GjWHda/7hYxIkE7Y2/nNOwRNn4juo30eEI1foUn44lEejk7n4mEbZlfEuKG5Lr
	iXwsiWqnE7A9yVvGiwyFcDM4AhtylWSlRNifv4rBFKCkk43Yw24JSUME+pZlSuL7
	Seclpv7KeVXtVyQixm6FyexHrFCAZTiSkHWDghrNKhhedWEl9uDyxLUI4C1FbkTi
	fA+fLDVi5sy4YWZytwTKEr3ewkL27QvQVHuPLuDiWKKOkDEQQnpuIPiKAguPX41R
	1gAwQ5Bja0rFjWTe1KwKHenT4OmrEcE8PhqG63yp0juWmAiynL9asfxz+hBBvx4W
	XUgXg==
X-ME-Sender: <xms:lZ58au7KF77RlYi27kq2LmVsTYLB8nTDUxqmJXYZ7vl13nMJQKPnkQ>
    <xme:lZ58aqcbj_qWLsUqcmr1BvWMvzKCDvWQFzb1jIACht_vfS9mUPQ0BEI-SjjHFti7S
    wxN5dzx219QiU72KNFcL7aumEfSeMeldxFsRso-Ta5n8d2xUwoeLxY>
X-ME-Received: <xmr:lZ58ahGl2BgVlfRehLKSt5v_OW-Q9nClhjJwBlR_ON8AtYYVI97YwgGVUhjggzV4ZtN-OaJumxWhMB7Qd58Au_OEhy8BJUOwug>
X-ME-Proxy-Cause: dmFkZTFL76UNW+shOJjD+EyZo6Ci/mgpRcmphxsEqDUMUxwdFlwcEpfTIc/tL4/YUQFBML
    SEHl6cbqeRwtTMM+MgbMJg7lIKHDygeR8NrHKMZSbtDC5L3xytc/uRInEMgsUTAEzyD9qX
    iCG1a5arljBNSewDUq1paC+PpDVE9+efp0IbessgQwKSbcIRvEzu2FGI41lTq1aphg+rrs
    VaduroNdnZmpYJlz2+Fq3rrivUAUDytZP6LSEqCX0PVhCU/RCSHL477oOg5QrJ8X3mqaQd
    NvzuWJ39TjWN7YKCFvOF0L/tQOXO6fFLezLTFwP4CBshDeQzdJGmiNFRnGx+8vjxCR92mK
    TxZAYx5jq6BbRyoLzLzNe33F+JtMOLSKKmECugcvmYIbEsOovAZzAdbK+mbmvyrLXdDjbO
    eWgC8L4ruFn1Ny9rcDZX0dWQCVwCTIxl8ZdAFYYOH1ezpS9i6BsuIyl7im4hxsA6H8twW+
    oQ+WlS8fOR/RmNdPuUn5UzYJ+2qL+KXt+aLALD0fhLgeR3zDzu9/njFD4+VjjfLLuH+gek
    MVVAnaoL2SvmpKUgKUlieWVNhl5rk30k6EyVMMi2GEPMixyptp9cf+LaW83mUV6U7G2ETD
    sx5yXKt13JZpG99kflsu7FLXELcLalbyl7YkQZ6IbcZjKwwVfixtq87yjeag
X-ME-Proxy: <xmx:lZ58arRDxC-yrfLjLTO-9Z6H_784ERR7JGKixC1DoggIipJFGUkghw>
    <xmx:lZ58ana71K5BWV7V4bRQaUKrystTZ2vX6iyUYp-2Oy2W_Rh0dMKQmg>
    <xmx:lZ58am2LaccQaXS7ui5Ou4CoP6n0y21_Zzy6GsjYH2klq0Bg3dCG4w>
    <xmx:lZ58aqpHt5KQAszKW87QsI93HTO3lfx_eDalDfAIE6qvLMRR7NmQdQ>
    <xmx:lZ58asHKDymhpCrsfVhJwe-FcVE9Wkk4ylM0MkaxyEc5Z-NuNvpTv0wU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:25:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 2/3] completion: complete tracked paths for 'git diff'
Date: Wed, 12 Aug 2026 09:25:50 -0700
Message-ID: <20260812162551.2229680-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-721-g26b8014fc4
In-Reply-To: <20260812162551.2229680-1-gitster@pobox.com>
References: <xmqqcxw010me.fsf@gitster.g>
 <20260812162551.2229680-1-gitster@pobox.com>
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
 contrib/completion/git-completion.bash |  4 +++
 t/t9902-completion.sh                  | 40 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a61b6ed59a..76181e8714 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1981,6 +1981,10 @@ _git_diff ()
 		esac
 		__git_complete_revlist_file
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file ""
+	fi
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 55dc9eabfc..32e5d484c7 100755
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
@@ -2712,6 +2713,45 @@ test_expect_success 'git -C <path> checkout uses the right repo' '
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
+test_expect_success 'git -C <path> diff completes paths in specified repo' '
+	test_when_finished "rm -rf repo-for-diff" &&
+	git init repo-for-diff &&
+	echo content >repo-for-diff/otherfile &&
+	echo content >repo-for-diff/lostfile &&
+	git -C repo-for-diff add otherfile &&
+	git -C repo-for-diff add lostfile &&
+	git -C repo-for-diff commit -m otherfile &&
+	echo untracked >repo-for-diff/oops &&
+	rm -f repo-for-diff/lostfile &&
+
+	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
+	otherfile
+	EOF
+	test_completion "git -C repo-for-diff diff l" <<-\EOF &&
+	lostfile
+	EOF
+
+	test_completion "git -C repo-for-diff diff -- o" <<-\EOF &&
+	otherfile
+	EOF
+	test_completion "git -C repo-for-diff diff -- l" <<-\EOF
+	lostfile
+	EOF
+'
+
 test_expect_success 'show completes all refs' '
 	test_completion "git show m" <<-\EOF
 	main Z
-- 
2.55.0-721-gd75157efe4

