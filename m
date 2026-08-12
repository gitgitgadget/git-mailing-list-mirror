Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164E442FD4
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551961; cv=none; b=moGGFiwtI/Q0P4UChNcFqA+tg4nSZMdaRXn1pBSJt5Pk3w6dMHT5b15d0oblq/kk6Poofbw6t+7884uH/wHDzbPGFcHI79GOrt8aKUV/ZhUNFlPV0nk+Bu02ag9cK+vWoWtZv0nFE5uYrK1/QpPjbl97DLBsldgvgLMHMDlY80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551961; c=relaxed/simple;
	bh=qFZbs7Czu/J5NBcsiRm1IFtgu2/xt7JaqvhR86eI2M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaHyetRU2UKwsUM16kDMaXnT33zGC3yMbIlT1OUPMisvCL12ghXYzNR3w4XOjM2bbet+fFpgJXdlY8KZpboxHltpYaMtdAu9F2DpUrmqdqFyKdAFXXO1akGAWBwzzdLrtSk/wsrJ5oKt1jON+0sXfpTFsmFI76YL1rX5te74W1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ey010zY/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLdFSEJo; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ey010zY/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLdFSEJo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6B69140009B;
	Wed, 12 Aug 2026 12:25:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 12 Aug 2026 12:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786551958; x=
	1786638358; bh=5t1KLbAzoAx63Czbvv7OF0zqifNBXKJ/eagsGJkWBqU=; b=E
	y010zY/tlx0X5jleu9/hNPs7ibLCwy7ez1ojlt/82MU48mt2VFBh79WQw2hi7mak
	LPaP6cqY02z4/9DE4zHHT3nYC1sXvZ5dySrcIrADCjebXvkbTMl83eVx71i6C8Tx
	SESgE6Resquwhqvtd44qnxu0xV6IFHtxOlxUO9kHfW6K/jP223QdGo18vH7Mwk4d
	AI8tM2LNsdN0F61qCWkD8+sK8eqHMq0hAs5no+LzNS3d0DyLOmtZEna1K3tfA2cy
	TQaQS+FeNdwceDaBG6LfAiFYJL09MsvOcoEGFBtWOEe/QuG+fdmFmsE+LuSeF+CB
	wWb6qG7GlGCZh/U+bTPzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786551958; x=1786638358; bh=5
	t1KLbAzoAx63Czbvv7OF0zqifNBXKJ/eagsGJkWBqU=; b=gLdFSEJoKo6Tcxac5
	H43o4BWOEeiVnyBZHYsAGfmu6vsbKROgcnQzAAxje5VLPw4K/sC9GdXjADTOh8uQ
	3UcuBuCuZpwLsYi6ICKDR3GENILDVIXpyAWAzixm+7JoOkCm87csPFEiUMQutwq+
	XxNDqfQ+DmmtbyuaO/Y6Xd1y6PbOWMsZfxnyAQL+kZYaqAIMcWW/iVN29LATpUuG
	tv4K2/oy3/wsqbzqL4as5voQ12AbqJU1ij/F33cAuKGJlMCA0GPF3BOhdNxlkjl4
	8oWrxh3ejDx4i1yzGVQIJHkatlTTqMu124uEfizC1jBgvugE3GC7lZbAQDve3Q4V
	F8wpw==
X-ME-Sender: <xms:lp58amhe0aDjCaJJKS5Tz2ekvae0uhTxdQ6RIgL4zShl--yYLWdMuw>
    <xme:lp58apmCiv4NRKRp2G7bo9YlATWdGM4kjm4Be74bKep_BDS4UH704n2h7jyyn2__j
    Z9OJfp8nxMGaZlfW2TyDcz-96zdK2vKVZGgF5AHKVlQ_Ua3zAyPEFw>
X-ME-Received: <xmr:lp58ahvmeGxX-GE1-UZ_HAiPWyMAYfGRNmgWgMnFECurGiAB0Oy1H4vfbjqE06Zj_X-Ta25jhOsBPvitdgjsJph8WXTHvmR_6w>
X-ME-Proxy-Cause: dmFkZTENLHcf6bCT8FlV/0uvtjxpZthdqTBcR/toLU+8urnjlr63rUEgrSR5YeKeqJaCoC
    T18lHmLtsPNmTFIgs6rJzX7rSgJeHkf/4GVzHa9o18yhFJTTHYO9KodAZ6g07r+0Cdz3E5
    TaR3yYvOjj99Kz31myZmqeDHbMoO8mH2ZRSuH7pNRYM5k4HZLdUud0MP+q45jHz/SJ30v2
    PMzrTmRaFCV3x009vsXUakgQhf9u0+OuQptx+ol6TM6n2QqDQeMge6W0j0BQTGD7fxsw1L
    tGev4TDdmythbBezjgAlx9OpbD1mfkFHFJToOW6H7zjQ5Cdhvi8I69fzhUNb2sc7CiDWFc
    rRbHJTMASxjC4btf0wkJEQ4LJ48C+jX/jDr3wuuyA2l8ZykgUKt0PyOXXqWieCYas40pGm
    UMp5sFXNoJPsjMxfwYYZsZf+s9hsrUgembIAgGdaAJFFREpkcon0k4ddq0t6AqdBsH4cf9
    mZ/FZK+3WsU2LKrUAru8L9duxx6sQnYUKR8xJ66OHbP5CStxbg9urzP8LmTCQsyAPOsmti
    xH6eEXwgz4KDm5oPfsyCThx7KFaFtFdT3LPRW6AFm9kMItKppokVVy7r1eZyY3I2vhJwZW
    r+vbYJzJOSP7kHdHaGlI+u1j+vDXIQK2KA+8XBCSPyHXjGP4LJmFLBaTZM5A
X-ME-Proxy: <xmx:lp58avbwpmYmOEOtJuTJcMOz2DLV_D_E5IVrZ4H7ZGL5lfyaD-XwJA>
    <xmx:lp58apDM2akLkmPlV4iSWZa1KkaF_TEMGoVipGCrvkoY7X72DzGTMA>
    <xmx:lp58an8v54WT4n8QcZp3BzJb2Mxs1DoQCsKHrkt3JP9kz4PrU7G85A>
    <xmx:lp58alRPNmyt6euwL1jfEtz9hd_Bx-jxcMpZfBzo3f4dH9IUgN6R3A>
    <xmx:lp58aqMYk6iZ20maFjEDq_LwvtICzKWDl8tvRnshDedRKVcnFIZoJUKp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:25:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 3/3] completion: 'git diff' completes untracked paths as a last resort
Date: Wed, 12 Aug 2026 09:25:51 -0700
Message-ID: <20260812162551.2229680-4-gitster@pobox.com>
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
 t/t9902-completion.sh                  | 20 +++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

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
index 32e5d484c7..b889ec8c77 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2664,6 +2664,7 @@ test_expect_success 'setup for integration tests' '
 	echo more >file2 &&
 	git add file1 file2 &&
 	echo untracked >file3 &&
+	echo untracked >ufile &&
 	git commit -m one &&
 	git branch mybranch &&
 	git tag mytag
@@ -2726,6 +2727,16 @@ test_expect_success 'git diff completes tracked paths when no refs match' '
 	EOF
 '
 
+test_expect_success 'git diff [--] completes untracked paths, too' '
+	# ufile is not tracked and there is no ref that begins with u
+	test_completion "git diff u" <<-\EOF &&
+	ufile
+	EOF
+	test_completion "git diff -- u" <<-\EOF
+	ufile
+	EOF
+'
+
 test_expect_success 'git -C <path> diff completes paths in specified repo' '
 	test_when_finished "rm -rf repo-for-diff" &&
 	git init repo-for-diff &&
@@ -2735,6 +2746,7 @@ test_expect_success 'git -C <path> diff completes paths in specified repo' '
 	git -C repo-for-diff add lostfile &&
 	git -C repo-for-diff commit -m otherfile &&
 	echo untracked >repo-for-diff/oops &&
+	echo untracked >repo-for-diff/ufile &&
 	rm -f repo-for-diff/lostfile &&
 
 	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
@@ -2743,13 +2755,19 @@ test_expect_success 'git -C <path> diff completes paths in specified repo' '
 	test_completion "git -C repo-for-diff diff l" <<-\EOF &&
 	lostfile
 	EOF
+	test_completion "git -C repo-for-diff diff u" <<-\EOF &&
+	ufile
+	EOF
 
 	test_completion "git -C repo-for-diff diff -- o" <<-\EOF &&
 	otherfile
 	EOF
-	test_completion "git -C repo-for-diff diff -- l" <<-\EOF
+	test_completion "git -C repo-for-diff diff -- l" <<-\EOF &&
 	lostfile
 	EOF
+	test_completion "git -C repo-for-diff diff -- u" <<-\EOF
+	ufile
+	EOF
 '
 
 test_expect_success 'show completes all refs' '
-- 
2.55.0-721-gd75157efe4

