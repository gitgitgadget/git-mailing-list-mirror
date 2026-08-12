Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5C392C2E
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553334; cv=none; b=Ux69ir9mYGhlaaptGlnv1P2Uo7LMM8meGfFUJ6k1ajTL3PFPmIRvf6kd+VsCDlMs7xFY0kG55ZdGGyT37t2SzfO7krFh7RLZhQAuvjFGeMeCViQSD+PIsqvQ6ITVVxomF5LAmHe0IY/6SKmhjzzN4svRRrRzu3EEIACVasLTJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553334; c=relaxed/simple;
	bh=ICtlbHOEHodrbgLP+cQ2VcZcnWsDNAHO1McBwbQ2MWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlZVp5YMTW6lvaFWsMJVyW1JH//gZDfw+vaiucrkkApVLZ13uqePLRqxXP+xtDXqhUoy3GrCxGAie228ALtdLHtMY8oZOUBOKxw+UEJ4KUe8pOo/MwCVTTa0qIO+ubExwaZQer9kRvoS+R5rYGj+t0PPAjKFqHRvONVpMY7qKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G2wClebE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RYGc9Wqi; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G2wClebE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RYGc9Wqi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E5DFEC0189;
	Wed, 12 Aug 2026 12:48:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 12:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786553329; x=
	1786639729; bh=455zORQQIAaCNd+dptRBkBiCpIDDiKniiZOB6w44G/8=; b=G
	2wClebEizI5Q739Z+gAAqr1swvGePKSdX/FBv18wZV+C8LwLk0ff7tQ60EtmjQYD
	dcLPAYxcXeVVHjeLX3KIucBoHgXi1xsTSBW6GYvS3ahNCN7LCQWXtpY8Pierlxvi
	Vi6Ul/H5Gvp4Jw1xMTA525zzLOY6qPtWNH8jYMl2J39inwgqQ8m5LHOaQD4vNHiL
	Fymli1quQmLtbxaEWoNkpPHl6Ubaj421LfxxnYF9s5GOuPC/muTfcTq91/hW+14F
	en5KtJ+eXIhDCUKRxgXMpGVyK6VpK92KMEKsZZ+qwqoZ6WtotIAdRqEqLexfOrjE
	+JkNjdjdbcxeSEi5WCOvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786553329; x=1786639729; bh=4
	55zORQQIAaCNd+dptRBkBiCpIDDiKniiZOB6w44G/8=; b=RYGc9WqigPDwP+omH
	gVbMGsKO5DwoTNsUmo5qLmHFTfs79J0BD/3jj4j9My+zU9NLookzxFQ5rpAID1/g
	R7etBw8aYh86pc5uDTLsHMH6PrI4xs6NLrQ/g1xMAEYu/vOTmabNJRLlrYbYMRfx
	mrq3OSon+0RvXdhKOA86S13weNlZRdLtvOjn603blMn7acFrboJO2xsbW/5Cgmli
	QuILipAyU3o0jYN45s10T6L9Il7Cq1zutzd2YYEthqf5o1Gsfm5R5pAwR1OTViXW
	4G1GSNsef4LraToAVc24WlLx1nS7dbyLLFvPxw2t0xSdpOXBVXDHoWrlsinV1XS0
	JhseQ==
X-ME-Sender: <xms:8KN8aqdKoKwXjoJA-V6bQzpmdox1xtQs9yQDmBBy343k77eRUEusgQ>
    <xme:8KN8amyz-Vm-KDCbSbfe-G_uhDALSUMIJxWBSVG3qK4Dndh0SU0z2UwCqGdAOiapv
    zRNFECCAme-UUI2vOXhxgfIcHDNTrYXo_sfGBBooZHhpOcBHPOUj50>
X-ME-Received: <xmr:8KN8avJBMj1vCf3zL7NMu0sKwQH439qsy0NlaYxr8H7_GG42vtVUaUv0caNxdyxKJUB8sgTdlkD1CsKWRUQqAv2HDzK0UuhUZg>
X-ME-Proxy-Cause: dmFkZTF3QcuOo1/J/jjBCs9qDwUNlJukzvBIGyRFZ/lRI0tY86BF/pgFxuTdM1JI5yNnHK
    iCSeSLQyP0cNvxfsVzWiYwD0/jI9zN0FA9hoos/JW0/+sdn1o4jB7jvVGsLkLp9vjz0bOu
    omnwmQO61EhusO57+F23Cwj0NT8Nsg/txpt0M6Czh5kIKiZY5zATwgJ5s4RYlveOgPKRWm
    2dd/PXxMvcuo3aFzQBzpZj3rmxKy/RIADBe4YQGq7bh1O5Gx5mTqBt5XM9zBxmJBbkPseh
    0GS3Ivm19d8eIbF3gBQz4XopUwNk+DdWGGE/bbVOHLZ2H0ODaztM4acW8hLI2v1ZKGDZL0
    h5gxb+ugKZD/vPctc2ZVUzMkIKBM0VYgESPsCOG83JLfDlroOtHihu422Ebll28+6SiR5s
    ALfMYXoldYe1Od1rEbiNkIKXhRJahFZWTQjRJ1gLqyf91DrfMkfjKlbOICS6TARqxqydHg
    K/1Su4DVS+Xn2ATINYiSL730B0y7cHP+c7AL/ifwqtzTZ0RYRG+IQ6N8mJgeG4wrRb0Pg5
    0Hin/nzlvyfBWn+U7AHZxCQ0F3+POXyEaipTXsrxmoIhFo/RXZPDNVkM8AQ5YL2fFaHGHi
    QsCaUePVf4MRZZN4+WeClGDGetWpx2DLg/3cDBErJGH63U/XtuYUeJqBGCpg
X-ME-Proxy: <xmx:8KN8aoE1SuoeHeJUj96kEjaeIS6sDHQ6Uo2gYP1RniH6ZOa3t0y73g>
    <xmx:8KN8ar_dFiAXk7Ms-KYNNxajp4UiLcNmiAu7tnTiSrDSA3VZMD5Sgw>
    <xmx:8KN8aoK6q1R7JfZpap3zC4gVBtfN3BQA3UAjxBF8gWuFp2L6cIUOBQ>
    <xmx:8KN8apsxjst_zqDrRaCIf8Ie4x5y9PKN_0H6LH33mhRSv-bRV3D_ZA>
    <xmx:8aN8ap4yDj0VdJK1MIbF2jJPMIQ2mXlGM1_7uiCPMKNb9IsBqnlx5U0o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:48:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Philippe Blain" <levraiphilippeblain@gmail.com>,
	"Britton Leo Kerin" <britton.kerin@gmail.com>,
	"Elijah Newren" <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	"Patrick Steinhardt" <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/3] completion of 'git [-C <dir>] checkout'
Date: Wed, 12 Aug 2026 09:48:43 -0700
Message-ID: <20260812164846.2236221-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-721-g26b8014fc4
In-Reply-To: <xmqq7blx5oor.fsf@gitster.g>
References: <xmqq7blx5oor.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continuing from the previous 'git [-C <dir>] diff' series, these two
patches correct completion for 'git checkout [-C <dir>] path<TAB>',
but without falling back to untracked paths, as "checkout paths out
of the index" is by definition about paths that appear in the index.

This has been rebuilt on the v6 iteration of the 'complete-diff'
topic to give the tests a more structured and logical organization.

Additionally, [PATCH 3/3] is new.  It teaches the completion
machinery to complete untracked paths in the working tree, which may
be of limited use, as it is unlikely that a file tracked on another
branch (and thus capable of being restored with 'git checkout
another-branch path') would be lying around untracked in the working
tree to begin with.

 1/3: completion: no-op refactoring of checkout completion
 2/3: completion: complete tracked paths for "git checkout"
 3/3: completion: 'git checkout' completes untracked paths as a last
        resort

 contrib/completion/git-completion.bash | 88 ++++++++++++++------------
 t/t9902-completion.sh                  | 56 ++++++++++++++++
 2 files changed, 105 insertions(+), 39 deletions(-)

Range-diff against v1:
1:  f35017f5c9 = 1:  d3b022ac73 completion: no-op refactoring of checkout completion
2:  20d57f0336 ! 2:  85019fbf97 completion: complete tracked paths for "git checkout"
    @@ contrib/completion/git-completion.bash: _git_checkout ()
      	fi
     +
     +	if [ ${#COMPREPLY[@]} -eq 0 ]; then
    -+		__git_complete_index_file
    ++		__git_complete_index_file ""
     +	fi
      }
      
    @@ t/t9902-completion.sh: test_expect_success 'git -C <path> checkout uses the righ
      '
      
     +test_expect_success 'git checkout completes tracked paths when no refs match' '
    -+	# file1 and file2 are tracked but ufile is not
    ++	# file1 and file2 are tracked but file3 is not
     +	# there is no ref that begins with f
     +	test_completion "git checkout f" <<-\EOF &&
     +	file1
    @@ t/t9902-completion.sh: test_expect_success 'git -C <path> checkout uses the righ
     +	EOF
     +'
     +
    -+test_expect_success 'git -C <path> checkout completes tracked paths in specified repo' '
    ++test_expect_success 'git -C <path> checkout completes paths in specified repo' '
    ++	# otherfile is tracked, oops is not
    ++	# lostfile is tracked but lost
     +	test_when_finished "rm -rf repo-for-checkout" &&
     +	git init repo-for-checkout &&
     +	echo content >repo-for-checkout/otherfile &&
    ++	echo content >repo-for-checkout/lostfile &&
     +	git -C repo-for-checkout add otherfile &&
    ++	git -C repo-for-checkout add lostfile &&
     +	git -C repo-for-checkout commit -m otherfile &&
    ++	echo untracked >repo-for-checkout/oops &&
    ++	rm -f repo-for-checkout/lostfile &&
     +	test_completion "git -C repo-for-checkout checkout o" <<-\EOF &&
     +	otherfile
     +	EOF
    -+	test_completion "git -C repo-for-checkout checkout -- o" <<-\EOF
    ++	test_completion "git -C repo-for-checkout checkout -- o" <<-\EOF &&
     +	otherfile
     +	EOF
    ++	test_completion "git -C repo-for-checkout checkout l" <<-\EOF &&
    ++	lostfile
    ++	EOF
    ++	test_completion "git -C repo-for-checkout checkout -- l" <<-\EOF
    ++	lostfile
    ++	EOF
     +'
     +
      test_expect_success 'git diff completes tracked paths when no refs match' '
-:  ---------- > 3:  56aade8759 completion: 'git checkout' completes untracked paths as a last resort
