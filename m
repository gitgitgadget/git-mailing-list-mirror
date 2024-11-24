Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96802500BA
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732481809; cv=none; b=OwqlnFGrhMrlEKDbAkm8xKdrTxFcH4kNZY9j6B4sf5se+g+jHi1dkzQ40OpOI5jGBeyMgaDs3si3zs7E+GZfo+W++gO8HrgLyBdiu3ao7DIYu95tGKeQimqAuZ4GhcUaBVjLd+rb7v/s3nzcmjy+zotZ6eVoKnVbSpsZXdtAOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732481809; c=relaxed/simple;
	bh=dC8aHsEUEaonQFyRlF9lzQjmU3zUZsSkn02bdC1zM9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jue0672oodgXGef2yJJdtJNMhPnKHX9DId9PcdhN1xTH+gHh1s0X3J+tIDKVkc0BXT3oozrn6wxjStS9CQ7sZ8MmmRvieCsC+qJ0Vltz3QKnCwHLdqLPlYeDNpWQltYflUj9TZ0OkRpOMxPQ0dlq3G64B7Q7Eui39hxK4vJPdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gdtICWlu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k0C24r9l; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gdtICWlu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0C24r9l"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5A5E2540161;
	Sun, 24 Nov 2024 15:56:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 24 Nov 2024 15:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732481805;
	 x=1732568205; bh=xkZDqqv8FPSIJ5LCLa1NUBlhmI2WwZYtOiK4pKIHVOc=; b=
	gdtICWlulbL9lpcjJicn/fgLoV7t3HUFYxd8Y1Ya7wOMlhiwmbwZdEXc7qsCrKy2
	MWC9R2uOOqFQ4y0/VZJSwmVdpM5ZqH5f3gBicMStGI17yVlRdjsO2hpoPt9wjyP4
	5qlKibIJ0WqyVSfVXiALmFQblmUagCfYk3VErzTVeHmBzHLLT9iaMyRTcDJa+LIS
	Jps7n9/UnBV9aAE18nIhWpU+jfA+vLeqILE4+099xhr0cFK0K6pCiCSZGw8gu2QR
	ZuvQ1Pcdv8TaDU3AR8M7CpMxleUNJO2pn7KYPryOyCUEeZg/lrlTQeZOhQczfmDP
	mjkJo+3Sx8/q85Y99zrN5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732481805; x=
	1732568205; bh=xkZDqqv8FPSIJ5LCLa1NUBlhmI2WwZYtOiK4pKIHVOc=; b=k
	0C24r9lVOe1B5q+AK8xq03ehAUQxz4ych6Qyn7CaVgaVO3b9E1OYV9GfptW5iaUY
	ykp9Np5ubMvtvWo613Ckxe2qQK9XDVK7JJ5GQA8YqZ0ns3unkXumKECB+eIeoVzD
	hlZvCYqUyqGTR14+towOnRJ2OCxGmDFv09DPbb4YBDI7EEQXKsqBQi5OxSzPT3RF
	vjd5MUV7drx7PvR3Y+RUVHl4VbbXWBBH8TMdPyy4lNmXUTuLZIuUC1NuVUXZfCO8
	9kfVE5ASaiXitQdnDkPx/SnzMGoGaKSaFC5C6281yuBz0bWSMjGgwW6rGAzShZVc
	TknvCd6Q/h89e3IcCwvBw==
X-ME-Sender: <xms:DZNDZ5O88aoGMRAhaKB35ePoxDNq0MPq74Ib3u2Y8U3vpK6yv5YCtTc>
    <xme:DZNDZ79405E71sLlh3ogI91lF-fAllUFu0txCwGOgDGUt4ZBhomxA_taLCpH_Sw_7
    FBT3xz5TqtFkJpVpQ>
X-ME-Received: <xmr:DZNDZ4Rb-v5_BKDPV17v9BG8rYjqk3CwYTcTRFsDD28CHbqe97FXUMPiHN3wRoXGJKQ_FYNrgN_Iqsm8ex1VeV2vHpDTe3KlYEW0F_tsrCykLZVSBI22HJGsUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeefgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:DZNDZ1v7ZJmhHJtI2Y4aFNQhpe4Ct1CGepT2dICaHIm6s3VPcsdkMw>
    <xmx:DZNDZxeM-uc3bAVZnsEDhGAInn1PywzGaC4N-uEVapLL66gKsDCh4A>
    <xmx:DZNDZx3spHfS1y0uAV3sEapy7R7AkyGw26dbBabvlZ-3Q8soUNr_SA>
    <xmx:DZNDZ98ntGCJ9gNwt9-90RaD5xSFW0EaxCkcq4d3DzzdiTW25IqeWQ>
    <xmx:DZNDZ6F9DUYM2PAcB383l_yN4NtRKwCvqQqqQqRltrM3tB1jZ7wFVjOa>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 15:56:44 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v3 0/3] sequencer: comment out properly in todo list
Date: Sun, 24 Nov 2024 21:56:09 +0100
Message-ID: <cover.1732481200.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731406513.git.code@khaugsbakk.name>
References: <cover.1731406513.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Fix three places where the comment char/string is hardcoded (#) in the
todo list.

§ Changes in v3

I expanded on patch/commit message 3/3. I also checked the state (such as
the proposed commit message for the revert) in the tests. Both from
reviewer feedback.

See the rest of the changes as notes on the patches.

§ CC

• Stolee for the first patch
• Reviewers on the previous rounds

Kristoffer Haugsbakk (3):
  sequencer: comment checked-out branch properly
  sequencer: comment `--reference` subject line properly
  sequencer: comment commit messages properly

 sequencer.c                     | 26 ++++++++++++++++----------
 t/t3400-rebase.sh               | 19 +++++++++++++++++++
 t/t3437-rebase-fixup-options.sh | 15 +++++++++++++++
 t/t3501-revert-cherry-pick.sh   | 14 ++++++++++++++
 4 files changed, 64 insertions(+), 10 deletions(-)

Interdiff against v2:
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index f61a717b190..711bd230695 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -469,7 +469,10 @@ test_expect_success 'git rebase --update-ref with core.commentChar and branch on
 	git checkout base &&
 	test_commit msg3 &&
 	git checkout topic2 &&
-	git -c core.commentChar=% rebase --update-refs base
+	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
+		 rebase -i --update-refs base &&
+	grep "% Ref refs/heads/wt-topic checked out at" actual &&
+	grep "% Ref refs/heads/topic2 checked out at" actual
 '
 
 test_done
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 26d3cabb608..43476236131 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -231,12 +231,14 @@ test_expect_success 'identification of reverted commit (--reference)' '
 test_expect_success 'git revert --reference with core.commentChar' '
 	test_when_finished "git reset --hard to-ident" &&
 	git checkout --detach to-ident &&
-	git -c core.commentChar=% revert \
+	GIT_EDITOR="cat | head -4 >actual" git -c core.commentChar=% revert \
 		--edit --reference HEAD &&
-	git log -1 --format=%B HEAD >actual &&
-	printf "This reverts commit $(git show -s \
- 		--pretty=reference HEAD^).\n\n" \
-		>expect &&
+	cat <<-EOF >expect &&
+	% *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
+
+	This reverts commit $(git show -s --pretty=reference HEAD^).
+
+	EOF
 	test_cmp expect actual
 '
 
Range-diff against v2:
1:  fc3b4438845 ! 1:  a46767263f6 sequencer: comment checked-out branch properly
    @@ Commit message
         `git rebase --update-ref` does not insert commands for dependent/sub-
         branches which are checked out.[1]  Instead it leaves a comment about
         that fact.  The comment char is hardcoded (#).  In turn the comment
    -    line gets interpreted as an invalid command when `core.commentChar`
    -    is in use.
    +    line gets interpreted as an invalid command when `core.commentChar`/
    +    `core.commentString` is in use.
     
    -    † 1: 900b50c242 (rebase: add --update-refs option, 2022-07-19)
    +    † 1: See 900b50c242 (rebase: add --update-refs option, 2022-07-19)
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v3:
    +    • Review feedback: check more in the test by inspecting the
    +      sequence editor
    +
    +      Link: https://lore.kernel.org/git/5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.com/
    +    • Message: consistency with the other two messages:
    +      • Mention both commentChar and commentString
    +      • Commit footnote style: See <commit>
         v2:
         • Message: “hardcoded” (more common according to `git grep`)
     
    @@ t/t3400-rebase.sh: test_expect_success 'rebase when inside worktree subdirectory
     +	git checkout base &&
     +	test_commit msg3 &&
     +	git checkout topic2 &&
    -+	git -c core.commentChar=% rebase --update-refs base
    ++	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
    ++		 rebase -i --update-refs base &&
    ++	grep "% Ref refs/heads/wt-topic checked out at" actual &&
    ++	grep "% Ref refs/heads/topic2 checked out at" actual
     +'
     +
      test_done
2:  710c5b1a3f6 ! 2:  7a452142666 sequencer: comment `--reference` subject line properly
    @@ Metadata
      ## Commit message ##
         sequencer: comment `--reference` subject line properly
     
    -    Comment the subject line used in `git cherry-pick --reference`
    -    properly.
    +    `git revert --reference <commit>` leaves behind a comment in the
    +    first line:[1]
     
    -    Follow the existing pattern and use the case described in the original
    -    commit message[1] as the `core.commentChar` test case:
    +        # *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
     
    -        If the user exits the editor without touching this line by mistake,
    -        what we prepare to become the first line of the body, i.e. "This
    -        reverts commit 8fa7f667 (do this and that, 2022-04-25)", ends up to
    -        be the title of the resulting commit.
    +    Meaning that the commit will just consist of the next line if the user
    +    exits the editor directly:
     
    -    † 1: 43966ab3156 (revert: optionally refer to commit in the "reference"
    -        format, 2022-05-26)
    +        This reverts commit <--format=reference commit>
    +
    +    But the comment char here is hardcoded (#).  Which means that the
    +    comment line will inadvertently be included in the commit message if
    +    `core.commentChar`/`core.commentString` is in use.
    +
    +    † 1: See 43966ab3156 (revert: optionally refer to commit in the
    +        "reference" format, 2022-05-26)
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v3:
    +    • Review feedback: check more in the test by inspecting the
    +      proposed commit message.
    +
    +      Link: https://lore.kernel.org/git/4c623fcf-01dd-4056-80c1-b3c860ab7f87@gmail.com/
    +    • Message:
    +      • Rewrite message now that we are testing something different
    +      • consistency with the other two messages (see previous)
         v2:
         • `strbuf_commented_addf` adds a newline, unlike the previous function.
            We need to remove a newline from the final `strbuf_addstr` with `This
    @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'identification of reverted c
     +test_expect_success 'git revert --reference with core.commentChar' '
     +	test_when_finished "git reset --hard to-ident" &&
     +	git checkout --detach to-ident &&
    -+	git -c core.commentChar=% revert \
    ++	GIT_EDITOR="cat | head -4 >actual" git -c core.commentChar=% revert \
     +		--edit --reference HEAD &&
    -+	git log -1 --format=%B HEAD >actual &&
    -+	printf "This reverts commit $(git show -s \
    -+ 		--pretty=reference HEAD^).\n\n" \
    -+		>expect &&
    ++	cat <<-EOF >expect &&
    ++	% *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
    ++
    ++	This reverts commit $(git show -s --pretty=reference HEAD^).
    ++
    ++	EOF
     +	test_cmp expect actual
     +'
     +
3:  86b4b485e0b ! 3:  4c342bc0422 sequencer: comment commit messages properly
    @@ Metadata
      ## Commit message ##
         sequencer: comment commit messages properly
     
    +    The rebase todo editor has commands like `fixup -c` which affects
    +    the commit messages of the rebased commits.[1]  For example:
    +
    +        pick hash1 <msg>
    +        fixup hash2 <msg>
    +        fixup -c hash3 <msg>
    +
    +    This says that hash2` and hash3 should be squashed into hash1 and
    +    that hash3’s commit message should be used for the resulting commit.
    +    So the user is presented with an editor where the two first commit
    +    messages are commented out and the third is not.  However this does
    +    not work if `core.commentChar`/`core.commentString` is in use since
    +    the comment char is hardcoded (#) in this `sequencer.c` function.
    +    As a result the first commit message will not be commented out.
    +
    +    † 1: See 9e3cebd97cb (rebase -i: add fixup [-C | -c] command,
    +        2021-01-29)
    +
    +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Reported-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    -    v2
    +    v3:
    +    • Message: Explain to the best of my knowledge what is going on here in
    +      the message body
    +
    +      Link: https://lore.kernel.org/git/711b59d7-e649-4031-8924-a16fb632b4d4@gmail.com/
    +    • Fixed wrong/subpar use of trailers
    +
    +      Link: https://lore.kernel.org/git/711b59d7-e649-4031-8924-a16fb632b4d4@gmail.com/
    +    v2:
         • Phillip contributed the test and the `strbuf_setlen` changes
     
     

base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
-- 
2.47.0

