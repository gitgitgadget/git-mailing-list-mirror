Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4D531F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeKNFwg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:52:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56120 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:52:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id i73-v6so7928572wmd.5
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SDmk2gIViibyOEn/yTIA9tvQ0NiPR9eAgdqzbkb5Tk=;
        b=Jgi6EJ6KxFiw2bNK1I7KMTVte5Ut8cgvB4rEqxkLvVNQRtcCmUlM6jj6rbyFwTBldm
         ULskkmNrMYWk86P/FNhhLG6BtU8CRmOgy0tRb7wWtKfkk4xg/HW9XeZyC9wCnvI5dxp1
         M/gVchE3dnjOAAPUmdH1cKpkX01tk3GOtNuomceLVO/25BjA2nR43i3OkEhtLFfFp7yE
         gn17iM+bzanz4QS/Oy1+qbpS6uyQTvNi0/5k6o6WKNsO45uCiN5S3FwJhWB9DyRb2OxS
         d5i7uwaLBJjXEEY7XdBJIGd1jOVllkyV4JHZQmYHzfP1nv8yub2EUzzznaJKOn2ERb6E
         suRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SDmk2gIViibyOEn/yTIA9tvQ0NiPR9eAgdqzbkb5Tk=;
        b=eS3ouATnW0td3coe+kycipOnRhTBAmw4TVAwt9tis9oogLF+4Z5zLEsys8MLFpq74T
         h+pTww7TnDdmd5wkTbahQ390r6F5QgjY9MwfdxqJdLHKteXZzEjkkhGBlp7klgfxb5tT
         oRRDiop9MZgz2agT6R3ys/xIvJRaXRqlUJgiM/f9/PUOTb1fnzHLQExjHIFJLxSvsXo2
         HVNMbhrGTtb0d5it4Mt6rA+wArxG28eOPVJ8pYl84zsm1+QCYRl8QaDpStbTxoiNKMyX
         7KFykfbNHtbvrmCRoZ7dMXc/u3usPeHualvFJdcxR0mdgUChlMyKNo6bSCyVrUq+3CYA
         Otdg==
X-Gm-Message-State: AGRZ1gJTsQ8PD+bj2SEpe55h4pW4X1JT5VH/bkwTUevMcMECX2INQOdt
        rjF/4+POjb3drOpE80vuisbmzcipdjo=
X-Google-Smtp-Source: AJdET5e2TLutUvJOpz8v7+GpU28vJrgNSUaQoJEOKdsqzOnV2tDqG2qdor0/3koKYgDYDh59zYGWAA==
X-Received: by 2002:a1c:750d:: with SMTP id o13-v6mr4440994wmc.100.1542138774969;
        Tue, 13 Nov 2018 11:52:54 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y7-v6sm13828560wmy.27.2018.11.13.11.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:52:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/7] fixes for unqualified <dst> push
Date:   Tue, 13 Nov 2018 19:52:38 +0000
Message-Id: <20181113195245.14296-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181026230741.23321-1-avarab@gmail.com>
References: <20181026230741.23321-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've finally re-rolled this. There wasn't consensus for the change to
add DWYM behavior to refs/remotes/*, so I've dropped it, 7/7 is still
there testing the current behavior of what we do with that now, since
we didn't have any tests for that.

This should address all feedback on v3, except I haven't reworded the
"this is what we do, even though you didn't do that now" message Junio
wasn't happy with in
https://public-inbox.org/git/xmqq8t2h5opm.fsf@gitster-ct.c.googlers.com/

I agree that the wording he was critiquing doesn't make sense at that
point in the series, but I think if you look over to 5/7 the final
state makes more sense. I.e. our message is of the form:

    Error, you tried to do X. Sometimes we DWYM, but only in cases:

    - A
    - B
    hint: Did you mean to do this thing that'll give you DWYM behavior
    like what we'd do for "B"?

I think in that case it makes sense to mention "B" in the message to
call out what exactly it is we DWYM on, why we didn't do it now, and
what you should do if that was what you meant. Not mentioning B would
be more confusing.

But maybe there's still disagreement on that and we can work out the
details of the wording, but now that a bunch of bugs have been fixed &
the controversial part ejected that'll be easier.

1:  ca8eb6dc28 = 1:  a6b6a5bba5 remote.c: add braces in anticipation of a follow-up change
2:  b0e15b6ff1 = 2:  3335fcedc8 i18n: remote.c: mark error(...) messages for translation
3:  052fc5860e ! 3:  18a5a685e7 push: improve the error shown on unqualified <dst> push
    @@ -22,10 +22,10 @@
     
             - Looking for a ref that matches 'newbranch' on the remote side.
             - Checking if the <src> being pushed ('v2.19.0^{commit}')
    -          is a ref in "refs/{heads,tags}/". If so we add a
    -          corresponding refs/{heads,tags}/ prefix on the remote side.
    +          is a ref in "refs/{heads,tags}/". If so we add a corresponding
    +          refs/{heads,tags}/ prefix on the remote side.
     
    -        Neither worked, so we gave up. You must fully-qualify the ref.
    +        Neither worked, so we gave up. You must fully qualify the ref.
             error: failed to push some refs to 'git@github.com:avar/git.git'
     
         This improvement is the result of on-list discussion in [1] and [2],
    @@ -73,7 +73,7 @@
     +				"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
     +				"  refs/{heads,tags}/ prefix on the remote side.\n"
     +				"\n"
    -+				"Neither worked, so we gave up. You must fully-qualify the ref."),
    ++				"Neither worked, so we gave up. You must fully qualify the ref."),
     +			      dst_value, matched_src->name);
      		}
      		break;
4:  e6aa2e360f ! 4:  a10d286cf6 push: move unqualified refname error into a function
    @@ -34,7 +34,7 @@
     +		"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
     +		"  refs/{heads,tags}/ prefix on the remote side.\n"
     +		"\n"
    -+		"Neither worked, so we gave up. You must fully-qualify the ref."),
    ++		"Neither worked, so we gave up. You must fully qualify the ref."),
     +	      dst_value, matched_src_name);
     +}
     +
    @@ -59,7 +59,7 @@
     -				"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
     -				"  refs/{heads,tags}/ prefix on the remote side.\n"
     -				"\n"
    --				"Neither worked, so we gave up. You must fully-qualify the ref."),
    +-				"Neither worked, so we gave up. You must fully qualify the ref."),
     -			      dst_value, matched_src->name);
     +			show_push_unqualified_ref_name_error(dst_value,
     +							     matched_src->name);
5:  dcf566e16e ! 5:  6f34c6f753 push: add an advice on unqualified <dst> push
    @@ -18,7 +18,7 @@
               is a ref in "refs/{heads,tags}/". If so we add a corresponding
               refs/{heads,tags}/ prefix on the remote side.
     
    -        Neither worked, so we gave up. You must fully-qualify the ref.
    +        Neither worked, so we gave up. You must fully qualify the ref.
             hint: The <src> part of the refspec is a commit object.
             hint: Did you mean to create a new branch by pushing to
             hint: 'v2.19.0^{commit}:refs/heads/newbranch'?
    @@ -34,9 +34,9 @@
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - diff --git a/Documentation/config.txt b/Documentation/config.txt
    - --- a/Documentation/config.txt
    - +++ b/Documentation/config.txt
    + diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
    + --- a/Documentation/config/advice.txt
    + +++ b/Documentation/config/advice.txt
     @@
      		tries to overwrite a remote ref that points at an
      		object that is not a commit-ish, or make the remote
    @@ -107,7 +107,7 @@
      	 * <remote> <src>:<dst>" push, and "being pushed ('%s')" is
     @@
      		"\n"
    - 		"Neither worked, so we gave up. You must fully-qualify the ref."),
    + 		"Neither worked, so we gave up. You must fully qualify the ref."),
      	      dst_value, matched_src_name);
     +
     +	if (!advice_push_unqualified_ref_name)
    @@ -158,6 +158,7 @@
     +	(
     +		cd test &&
     +		git tag -a -m "Some tag" some-tag master &&
    ++		exit_with=true &&
     +		for type in commit tag tree blob
     +		do
     +			if test "$type" = "blob"
    @@ -172,8 +173,10 @@
     +			test_must_fail git -c advice.pushUnqualifiedRefName=false \
     +				push origin $oid:dst 2>err &&
     +			test_i18ngrep "error: The destination you" err &&
    -+			test_i18ngrep ! "hint: Did you mean" err
    -+		done
    ++			test_i18ngrep ! "hint: Did you mean" err ||
    ++			exit_with=false
    ++		done &&
    ++		$exit_with
     +	)
     +'
     +
6:  92ff753437 ! 6:  86cb0bbd95 push: test that <src> doesn't DWYM if <dst> is unqualified
    @@ -4,14 +4,22 @@
     
         Add a test asserting that "git push origin <src>:<dst>" where <src> is
         a branch, tag, tree or blob in refs/remotes/* doesn't DWYM when <dst>
    -    is unqualified. This has never worked, but there's been no test for
    -    this behavior.
    +    is unqualified. This has never been the case, but there haven't been
    +    any tests for this behavior.
     
         See f88395ac23 ("Renaming push.", 2005-08-03), bb9fca80ce ("git-push:
         Update description of refspecs and add examples", 2007-06-09) and
         f8aae12034 ("push: allow unqualified dest refspecs to DWIM",
         2008-04-23) which are most relevant commits that have changed or
    -    documented the behavior of this feature in the past.
    +    documented the behavior of the DWYM feature in the past.
    +
    +    These tests were originally meant to lead up to a patch that made
    +    refs/remotes/* on the LHS imply refs/heads/* on the RHS, see [1]. That
    +    patch proved controversial and may not ever land in git.git, but we
    +    should have the tests that remind us what the current behavior is in
    +    case it's ever changed.
    +
    +    1. https://public-inbox.org/git/20181026230741.23321-8-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -25,30 +33,29 @@
     +test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
     +	(
     +		cd two &&
    -+		git tag -a -m "Some tag" some-tag master &&
    ++		git tag -a -m "Some tag" my-tag master &&
     +		git update-ref refs/trees/my-head-tree HEAD^{tree} &&
     +		git update-ref refs/blobs/my-file-blob HEAD:file
     +	) &&
     +	(
     +		cd test &&
    -+		git config --add remote.two.fetch "+refs/tags/*:refs/remotes/two-tags/*" &&
    -+		git config --add remote.two.fetch "+refs/trees/*:refs/remotes/two-trees/*" &&
    -+		git config --add remote.two.fetch "+refs/blobs/*:refs/remotes/two-blobs/*" &&
    ++		git config --add remote.two.fetch "+refs/tags/*:refs/remotes/tags-from-two/*" &&
    ++		git config --add remote.two.fetch "+refs/trees/*:refs/remotes/trees-from-two/*" &&
    ++		git config --add remote.two.fetch "+refs/blobs/*:refs/remotes/blobs-from-two/*" &&
     +		git fetch --no-tags two &&
     +
     +		test_must_fail git push origin refs/remotes/two/another:dst 2>err &&
     +		test_i18ngrep "error: The destination you" err &&
     +
    -+		test_must_fail git push origin refs/remotes/two-tags/some-tag:dst-tag 2>err &&
    ++		test_must_fail git push origin refs/remotes/tags-from-two/my-tag:dst-tag 2>err &&
     +		test_i18ngrep "error: The destination you" err &&
     +
    -+		test_must_fail git push origin refs/remotes/two-trees/my-head-tree:dst-tree 2>err &&
    ++		test_must_fail git push origin refs/remotes/trees-from-two/my-head-tree:dst-tree 2>err &&
     +		test_i18ngrep "error: The destination you" err &&
     +
    -+		test_must_fail git push origin refs/remotes/two-blobs/my-file-blob:dst-blob 2>err &&
    ++		test_must_fail git push origin refs/remotes/blobs-from-two/my-file-blob:dst-blob 2>err &&
     +		test_i18ngrep "error: The destination you" err
     +	)
     +'
    -+
      
      test_done
7:  58eeb0f3f3 < -:  ---------- push: add DWYM support for "git push refs/remotes/...:<dst>"
8:  bc171b0312 ! 7:  d5e800cb87 push doc: document the DWYM behavior pushing to unqualified <dst>
    @@ -39,10 +39,6 @@
     +* If <src> resolves to a ref starting with refs/heads/ or refs/tags/,
     +  then prepend that to <dst>.
     +
    -+* If <src> starts with refs/remotes/ check if that reference refers to
    -+  a commit or tag, then refs/heads/ or refs/tags/ to <dst> as
    -+  appropriate.
    -+
     +* Other ambiguity resolutions might be added in the future, but for
     +  now any other cases will error out with an error indicating what we
     +  tried, and depending on the `advice.pushUnqualifiedRefname`

Ævar Arnfjörð Bjarmason (7):
  remote.c: add braces in anticipation of a follow-up change
  i18n: remote.c: mark error(...) messages for translation
  push: improve the error shown on unqualified <dst> push
  push: move unqualified refname error into a function
  push: add an advice on unqualified <dst> push
  push: test that <src> doesn't DWYM if <dst> is unqualified
  push doc: document the DWYM behavior pushing to unqualified <dst>

 Documentation/config/advice.txt |   7 +++
 Documentation/git-push.txt      |  23 +++++++
 advice.c                        |   2 +
 advice.h                        |   1 +
 remote.c                        | 106 ++++++++++++++++++++++++--------
 t/t5505-remote.sh               |  55 +++++++++++++++++
 6 files changed, 169 insertions(+), 25 deletions(-)

-- 
2.19.1.1182.g4ecb1133ce

