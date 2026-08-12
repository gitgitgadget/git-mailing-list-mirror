Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DEF38F64E
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551956; cv=none; b=cOZd41Puj9vTXbFH3ffyvnqjDLSeQ1NnllQS+fLHgQ+z4HEprKcb4n+o3a20By128O1coiAc3RpLJdQamtxb990qF6xFhm4LAsUDpGbISsSdt53mvU3TWgCa6H0WhqzYBVgztzyxPwdwGIGEXqDS+Tz4i7ioF3co6krHzeS5p8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551956; c=relaxed/simple;
	bh=GA6RtbctVXDd2k2N9iJ8zjev9l7ziEqQy2MbB4X9dgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gq/8Gv7Vv+dMdAiHCPL3QLZQ67kht0m4S0l3jv73+vA/s3FzjzHySSm8ndrt0YfQ5pZ8O/qzMwPl/1Px6tXCVLZi8NGZByG3XvGK7eHMP6c4SWg7l0i43FfIu1fgeanp3JcfU8Jk0/NdBtlIBkFNSE8fYDSIAhYwdxWl78onz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lo4cRn0V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dd4xXUea; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lo4cRn0V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dd4xXUea"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04A3C140009B;
	Wed, 12 Aug 2026 12:25:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 12:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786551954; x=
	1786638354; bh=kK64yWk9GUR4OBwCDETN5V+/npQs/DhQg56jp/9ZNNk=; b=l
	o4cRn0V7lBQSLgst4FswTJw8u0ujgSMn0t5cataKgqb7cn5bhRGqL8EA7TSX6jgB
	yaYwgH7wWZEkkZuQUtJQbMN4kGBjlz2fwD0J1GX0Waw22mnpZV2JQFybUvu8fQn6
	1MNI9fPVyI+Bu9azPE9REgYPf++fsW4meutdobqJWstKAhW2vwNQIdVX0OmdTK4A
	DDTFf+n5PLhWyXiaNbd6NCxvTS6KUbpF3G6ZSRjREXslX1GcAS4MHleJ4E1+8AW/
	LA+lrNa5B9DOR1O5UCEQWWzXNTpv2XZN+Fo6Jh3NOslJWs3GWi7cM58VTZE09Hey
	BOK8UTp+OtKbEd0I3MBlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786551954; x=1786638354; bh=k
	K64yWk9GUR4OBwCDETN5V+/npQs/DhQg56jp/9ZNNk=; b=Dd4xXUeaKNz5G8tw8
	VOW4zMRAorSL9/0zarl021HcOt3aQ5aU/ySSVweEXP94tAbhcYKpqbSpZmK1DVGo
	CvHTwnx6QTORp6KA86wI8M9WQ2lkHLn1ymakWuC14ZNBjefcKAs+x3wEOnEU1GH7
	lNfLB/udrhouWU6FG35tm+rugO8tPVgBWdhpW88oVehdErNo7A6sPNOcqVKeZqDy
	ej1afxbhjxIahhCRoNnige4FyUU7gYteGo6iXBJGTnxan2eJiHrCWvbQCjZ8fYP9
	+2T/Gpm3UDkQBtZbftUqg+wF7PMdmWaGtj+moZfBXF43XN0U3/VqwwRecUSnqJUh
	QUOTg==
X-ME-Sender: <xms:kZ58al6IC03t7xWB1S2GesaQJ9S4ed0XaQk2mLpfZjtOLHxl3WwsYw>
    <xme:kZ58aldkyZcS246OhNwwImbMz4wOorXT3eT61kaAg1SrYSLvAi9Zv25V_wnPLkrIe
    grJifdhe79RiyzmD44ZQ4eEfdIbeS2qlUrm2h3FcxvwK3Yqlg7Jbnk>
X-ME-Received: <xmr:kZ58agG4NwqLrR5Y_m1vuZq5SIgoZYGnKM0MwUPKFECNzY40v365zV9zzRCsowv1gMd-G1fce1ycN8EXJoBwdtk4qfIULO84MA>
X-ME-Proxy-Cause: dmFkZTErBTy85xPWlDOo3AeTjUsGtPFPpMgexOhK3X+Iu7DBaRsmzQJzSiwFq9Q39ZsiKu
    pJnQ0PXpPY1aPPTDjrkmvsFLRTXpOn87SSQQ90j4/UWhjVKNZwkA9CdCHEdB3Sz3NJe1pR
    2wF/1tJEi1hVhHsHW0rW9uYxQFTnT+Yg+nFCz4QHWlit9scUfUsz9W3LnTgrLwZAkf5vl+
    UqVL9zPiNEUjjM2xCdm8/AIUpNGj0I50Z9GlNJqSjY7fV37ERB55HjoPYam1DtSmif9BR/
    THQecmrUeX4pCv2H4YuLwZTITlnGOnzmaGjF6HhC6MY/J8ka/8JxV74gLDaxeOR8Q2UOia
    fXIA0h3p2Io6Pxlgc1mcICctA5tB7Le2s4JSPQgXKjCUZuq0A12L+iSu0dNPHtKV50SIo6
    lCcEU/d+H20U9HSO+XoMKgcsnMKYqVnZyw8bv8/cn3Apw3ozLUQrsy+2u7T8saH6YkmStZ
    LUG3z3/R6bNIbGl7KzJJaf+A+1usf2/3Yuffl1GBi9Wc4qb3Bx3t5OdFEgnnVaPksE3AbO
    31mCuN5+TkL1q2FyYgmXdT96A9Dn8PmAXr8fymxpFc2jqg7KWFAix8P4c2/y8A/YbtThde
    8kEYkLwjiKXW3cU6FN7rS9pO+tMYwrOvmt1fTC5RdeYtrGtsbMv3GnxHx19Q
X-ME-Proxy: <xmx:kZ58auTzgvW7C8LV1KfAw2bx0c7xFbnORV9Yo017UTr7uIvrna9CkQ>
    <xmx:kZ58aubfkD9FfU3zt21PgxWOJB6ZmTnwMQv2WbVFoqtmT7lBpKsUmA>
    <xmx:kZ58ah2vgSdUOuHw2a2aislpwN2-WGYP2866ULFDRaNYUspYEWgcFQ>
    <xmx:kZ58apqZTrN3gLwWw2bjzgp7TH2IsHANCnuxJThV5CB75axVeL1lOg>
    <xmx:kp58avEpfQUULQXNf6Z2QJBm9GgFd19UoihjfyV_rz1XVkxLMZ4_3j0G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:25:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 0/3] completion of 'git [-C <dir>] diff'
Date: Wed, 12 Aug 2026 09:25:48 -0700
Message-ID: <20260812162551.2229680-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-721-g26b8014fc4
In-Reply-To: <xmqqcxw010me.fsf@gitster.g>
References: <xmqqcxw010me.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary motivation for this topic is that the command-line
completion of 'git diff' does not handle paths (unlike 'git status'
and 'git add') and instead relies on the default behavior of Bash
command-line completion, which completes files in $PWD; this does
not work at all with the '-C <directory>' option.

This series teaches the completion machinery to complete revisions
(unless '--' exists), then tracked paths, and then untracked paths,
before letting the Bash default kick in.  This way, we correctly
complete 'git diff' command line even when '-C <directory>' is in
effect.

The changes since v5 are all concentrated in the tests.  They test
the same thing, but organized in a more logical and regular way.

This round hopefully will be the last one (famous last words).

 1/3: completion: no-op refactoring of diff completion
 2/3: completion: complete tracked paths for 'git diff'
 3/3: completion: 'git diff' completes untracked paths as a last
        resort

 contrib/completion/git-completion.bash | 69 +++++++++++++++-----------
 t/t9902-completion.sh                  | 58 ++++++++++++++++++++++
 2 files changed, 99 insertions(+), 28 deletions(-)

Range-diff against v5:
1:  74bfe67e24 = 1:  a5b2bdcd21 completion: no-op refactoring of diff completion
2:  f6892a66e9 ! 2:  cb84c1407c completion: complete tracked paths for 'git diff'
    @@ contrib/completion/git-completion.bash: _git_diff ()
      __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
     
      ## t/t9902-completion.sh ##
    +@@ t/t9902-completion.sh: test_expect_success 'setup for integration tests' '
    + 	echo content >file1 &&
    + 	echo more >file2 &&
    + 	git add file1 file2 &&
    ++	echo untracked >file3 &&
    + 	git commit -m one &&
    + 	git branch mybranch &&
    + 	git tag mytag
     @@ t/t9902-completion.sh: test_expect_success 'git -C <path> checkout uses the right repo' '
      	EOF
      '
      
     +test_expect_success 'git diff completes tracked paths when no refs match' '
     +	# file1 and file2 are tracked but file3 is not
    -+	test_completion "git diff f" <<-\EOF
    ++	# there is no ref that begins with f
    ++	test_completion "git diff f" <<-\EOF &&
     +	file1
     +	file2
     +	EOF
    -+'
    -+
    -+test_expect_success 'git diff -- completes tracked paths' '
    -+	# file1 and file2 are tracked but file3 is not
     +	test_completion "git diff -- f" <<-\EOF
     +	file1
     +	file2
     +	EOF
     +'
     +
    -+test_expect_success 'git -C <path> diff completes tracked paths in specified repo' '
    ++test_expect_success 'git -C <path> diff completes paths in specified repo' '
     +	test_when_finished "rm -rf repo-for-diff" &&
     +	git init repo-for-diff &&
     +	echo content >repo-for-diff/otherfile &&
    ++	echo content >repo-for-diff/lostfile &&
     +	git -C repo-for-diff add otherfile &&
    -+	echo untracked >repo-for-diff/oops &&
    ++	git -C repo-for-diff add lostfile &&
     +	git -C repo-for-diff commit -m otherfile &&
    -+	test_completion "git -C repo-for-diff diff o" <<-\EOF
    ++	echo untracked >repo-for-diff/oops &&
    ++	rm -f repo-for-diff/lostfile &&
    ++
    ++	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
     +	otherfile
     +	EOF
    -+'
    ++	test_completion "git -C repo-for-diff diff l" <<-\EOF &&
    ++	lostfile
    ++	EOF
     +
    -+test_expect_success 'git -C <path> diff -- completes pathspecs in specified repo' '
    -+	test_when_finished "rm -rf repo-for-diff" &&
    -+	git init repo-for-diff &&
    -+	echo content >repo-for-diff/otherfile &&
    -+	git -C repo-for-diff add otherfile &&
    -+	git -C repo-for-diff commit -m otherfile &&
    -+	test_completion "git -C repo-for-diff diff -- o" <<-\EOF
    ++	test_completion "git -C repo-for-diff diff -- o" <<-\EOF &&
     +	otherfile
     +	EOF
    ++	test_completion "git -C repo-for-diff diff -- l" <<-\EOF
    ++	lostfile
    ++	EOF
     +'
     +
      test_expect_success 'show completes all refs' '
3:  dcc5f881f2 ! 3:  d73c18e876 completion: 'git diff' completes untracked paths as a last resort
    @@ contrib/completion/git-completion.bash: _git_diff ()
     
      ## t/t9902-completion.sh ##
     @@ t/t9902-completion.sh: test_expect_success 'setup for integration tests' '
    - 	echo content >file1 &&
      	echo more >file2 &&
      	git add file1 file2 &&
    + 	echo untracked >file3 &&
     +	echo untracked >ufile &&
      	git commit -m one &&
      	git branch mybranch &&
      	git tag mytag
    -@@ t/t9902-completion.sh: test_expect_success 'git diff -- completes tracked paths' '
    +@@ t/t9902-completion.sh: test_expect_success 'git diff completes tracked paths when no refs match' '
      	EOF
      '
      
     +test_expect_success 'git diff [--] completes untracked paths, too' '
    ++	# ufile is not tracked and there is no ref that begins with u
     +	test_completion "git diff u" <<-\EOF &&
     +	ufile
     +	EOF
    @@ t/t9902-completion.sh: test_expect_success 'git diff -- completes tracked paths'
     +	EOF
     +'
     +
    - test_expect_success 'git -C <path> diff completes tracked paths in specified repo' '
    + test_expect_success 'git -C <path> diff completes paths in specified repo' '
      	test_when_finished "rm -rf repo-for-diff" &&
      	git init repo-for-diff &&
    -@@ t/t9902-completion.sh: test_expect_success 'git -C <path> diff -- completes pathspecs in specified repo
    - 	test_when_finished "rm -rf repo-for-diff" &&
    - 	git init repo-for-diff &&
    - 	echo content >repo-for-diff/otherfile &&
    -+	echo untracked >repo-for-diff/untracked &&
    - 	git -C repo-for-diff add otherfile &&
    +@@ t/t9902-completion.sh: test_expect_success 'git -C <path> diff completes paths in specified repo' '
    + 	git -C repo-for-diff add lostfile &&
      	git -C repo-for-diff commit -m otherfile &&
    --	test_completion "git -C repo-for-diff diff -- o" <<-\EOF
    -+	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
    -+	otherfile
    -+	EOF
    -+	test_completion "git -C repo-for-diff diff -- o" <<-\EOF &&
    - 	otherfile
    + 	echo untracked >repo-for-diff/oops &&
    ++	echo untracked >repo-for-diff/ufile &&
    + 	rm -f repo-for-diff/lostfile &&
    + 
    + 	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
    +@@ t/t9902-completion.sh: test_expect_success 'git -C <path> diff completes paths in specified repo' '
    + 	test_completion "git -C repo-for-diff diff l" <<-\EOF &&
    + 	lostfile
      	EOF
     +	test_completion "git -C repo-for-diff diff u" <<-\EOF &&
    -+	untracked
    ++	ufile
     +	EOF
    + 
    + 	test_completion "git -C repo-for-diff diff -- o" <<-\EOF &&
    + 	otherfile
    + 	EOF
    +-	test_completion "git -C repo-for-diff diff -- l" <<-\EOF
    ++	test_completion "git -C repo-for-diff diff -- l" <<-\EOF &&
    + 	lostfile
    + 	EOF
     +	test_completion "git -C repo-for-diff diff -- u" <<-\EOF
    -+	untracked
    ++	ufile
     +	EOF
      '
      
-- 
2.55.0-721-gd75157efe4

