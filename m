Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811C5CDF1
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754456022; cv=none; b=JNdh2l2Ghtp6lc8gP05SGItYttSUTBotc/T0rK6YJXoNAF/ynClWjhOfH1bpQ5SXZXoOKRJuFYx1HapheLsFf8qinCS3W5baQA++8+U/P99y6C3O1jUCGqdTkRYtbZje/mYvS2UxQbOphRuTADh9X2JNzGASWCxzXi40khkPHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754456022; c=relaxed/simple;
	bh=SqwqPFeSqY0zIDG5U6dV9qEMnIKCKmZ1yO0HdoWayf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emaMBlSs2EQwOq3kPD3GmPrxAWC//nh4ZgtXlJoEXZv0NXmqcYgaieo33dIC6gCyFDTNTlkSQE0VB+ZYr1/C2OwSS9q3ohbnfvRb1NwpH5xJdjW2GepNsvniP9OnKDkLf2ubyLQ87SCA6NIs3yYz9X7lzDK1I7sMiOCQdfBSF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov/KYn6z; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov/KYn6z"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3badf1afc0so1019156a12.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 21:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754456019; x=1755060819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZtnu+q1JFPhY2z5/vBNdku1+jRDoTRI/PdLPWARaaY=;
        b=Ov/KYn6zOXf03qEfaK9EgJLV/eAtFx0nmKnWI6n6R9Kzgxm5EmVDjzhZ8B4FIcubp0
         BEBUHxDMFoLYWw424m3oXSV4/fuTKxqRzzw8diiSqa5J3xnCTDPvnnqrLP74vCTjPDdw
         tnWe0fxZqF8qO6wjBczeJ9+HSv9Q8nYjZ/x2RsE6hSWXourFWBEoWXNtckXScj1h5jwB
         EG2Z4Jdg/msflsDG3vAWBRmdTyjXXv4w9hAl/OOaygTmK2BCR94rHG+KH+RRjpbG99jC
         6JdR8p6AS6gq+tAJOtdZSOOY8Zai5JdnrN8tCUqqHfjB3+dXzSbEpypDEuAETq79n5VU
         dOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754456019; x=1755060819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZtnu+q1JFPhY2z5/vBNdku1+jRDoTRI/PdLPWARaaY=;
        b=txCtRFJt6us7GyORpFJTKFk5w67qyUwUieOkR5ZblO4YQLO+pXh5Ty1xexYdzsOwzf
         oaxmvMx0k8ivI3ZRROPDAOg42SWqx0MMrrdh4T1jONoAzWN0sGZ6V0QpR5g4v8tMamIJ
         ulozpkIMSd1xXYgaIvDVz80e7Tbj72bf3bI0w61O1ArG38rJcnoek0ZypSV3jieQH552
         7fx20bzGJCsaukuV3QvTSxNDjrni4iXEUK5PpNM4crFNwTyTMr4SbaigMLZTIYIlJXjb
         MyRQgArZLnXSmD/oCixNFQDSfFm4H4xGperbleWHlR2gHsQXS2RXxysvgfC7qjx9G/mP
         MxXg==
X-Gm-Message-State: AOJu0YxEbzUfCpkd8rmklB9Mt5zoUxYJVBXhDsNUnIJIoRz0i7T/slMO
	n/p91XqCwtBLahzfJwDsXwjjmGSuBDvWZcO23AWl0qFZWfdFNrxfijRpjhjd/g==
X-Gm-Gg: ASbGncvGiRWLCqPDcwxnStjj1Fm6TVIkcwkP3Sr6u424e9TwAWA2UTSJvclKZv2TbdB
	nbgmZ+FHpiXFNNiEC6B5hMFFPRZrQgU+VoiLk5ztw9C3/wisBAsCu93vLGGi29+SBCs39iXDSE1
	PSZRR8tJlRax/4eYO3Sw+cMeGkfwa9Uihuvykx2xqfh3AaZb7rUnoaBWkDKR0qjJykwJhC9xdhl
	2W2XREq8hhvtTdXOnxx8fxSWaTNz7kfKT78M7uSeF4ZMhlZ0U+B0LqkdxJM6MOytYoaehAptRpP
	LdKbOrXOjrCIP2PdH4oqkJzfjY4VV0i3NQ/F/p2w24a2sFbbw2dqJrVEYmBenD191gWbZ7Yy9ma
	OCwxoWBjoaoHPpj+Y5KLqJy03T7T1gcM=
X-Google-Smtp-Source: AGHT+IGfidDQ2lS9dVajxDwVKGClLItT446VrgEYCpQuDrgvqSEAzy4GQUg7Cf1ivPaDTTaVb/+JvQ==
X-Received: by 2002:a05:6a21:3a94:b0:231:242:2596 with SMTP id adf61e73a8af0-2403163540fmr1088725637.5.1754456019415;
        Tue, 05 Aug 2025 21:53:39 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:7ec2:c6ff:fe46:ef9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-320f77d81bfsm13278093a91.12.2025.08.05.21.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 21:53:38 -0700 (PDT)
Date: Tue, 5 Aug 2025 21:53:36 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/2] remote.c: remove erroneous BUG case
Message-ID: <cover.1754455931.git.liu.denton@gmail.com>
References: <cover.1754375026.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754375026.git.liu.denton@gmail.com>

In the case where one pushes a non-existent oid to an unqualified
destination, we encounter the following BUG

	error: The destination you provided is not a full refname (i.e.,
	starting with "refs/"). We tried to guess what you meant by:

	- Looking for a ref that matches 'branch' on the remote side.
	- Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
	  is a ref in "refs/{heads,tags}/". If so we add a corresponding
	  refs/{heads,tags}/ prefix on the remote side.

	Neither worked, so we gave up. You must fully qualify the ref.
	BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
	fatal: the remote end hung up unexpectedly
	Aborted (core dumped)

However, this isn't actually a bug so replace it with an advise()
message.

Changes since v2:

* Add t5516 cleanup patch
* Squash test creation patch into the patch that fixes it
* Include the erroneous object ID in the advise message

Denton Liu (2):
  t5516: remove surrounding empty lines in test bodies
  remote.c: remove BUG in show_push_unqualified_ref_name_error()

 remote.c              |  4 ++--
 t/t5516-fetch-push.sh | 54 ++++---------------------------------------
 2 files changed, 6 insertions(+), 52 deletions(-)

Range-diff against v2:
1:  d26f355c19 ! 1:  82b09af4ca t5516: introduce 'push ref expression with non-existent oid src'
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t5516: introduce 'push ref expression with non-existent oid src'
    +    t5516: remove surrounding empty lines in test bodies
     
    -    It is possible to trigger a Git bug by pushing a refspec where the
    -    source is an oid that's non-existent. An example of the error message
    -    produced is as follows:
    -
    -            error: The destination you provided is not a full refname (i.e.,
    -            starting with "refs/"). We tried to guess what you meant by:
    -
    -            - Looking for a ref that matches 'branch' on the remote side.
    -            - Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
    -              is a ref in "refs/{heads,tags}/". If so we add a corresponding
    -              refs/{heads,tags}/ prefix on the remote side.
    -
    -            Neither worked, so we gave up. You must fully qualify the ref.
    -            BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
    -            fatal: the remote end hung up unexpectedly
    -            Aborted (core dumped)
    -
    -    Document this failure in a test case so that it can be confirmed fixed
    -    later.
    +    This style with the empty lines in test bodies was from when the test
    +    suite was being developed. Remove the empty lines to match the modern
    +    test style.
     
      ## t/t5516-fetch-push.sh ##
    -@@ t/t5516-fetch-push.sh: test_expect_success 'push ref expression with non-existent, incomplete dest' '
    +@@ t/t5516-fetch-push.sh: check_push_result () {
    + }
      
    + test_expect_success setup '
    +-
    + 	>path1 &&
    + 	git add path1 &&
    + 	test_tick &&
    +@@ t/t5516-fetch-push.sh: test_expect_success setup '
    + 	test_tick &&
    + 	git commit -a -m second &&
    + 	the_commit=$(git show-ref -s --verify refs/heads/main)
    +-
      '
      
    -+test_expect_failure 'push ref expression with non-existent oid src' '
    -+
    -+	mk_test testrepo &&
    -+	test_must_fail git push testrepo $(test_oid 001):branch
    -+
    -+'
    -+
    - for head in HEAD @
    - do
    + for cmd in push fetch
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
    + '
      
    + test_expect_success 'push with matching heads' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	git push testrepo : &&
    + 	check_push_result testrepo $the_commit heads/main
    +-
    + '
    + 
    + test_expect_success 'push with matching heads on the command line' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	git push testrepo : &&
    + 	check_push_result testrepo $the_commit heads/main
    +-
    + '
    + 
    + test_expect_success 'failed (non-fast-forward) push with matching heads' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	git push testrepo : &&
    + 	git commit --amend -massaged &&
    + 	test_must_fail git push testrepo &&
    + 	check_push_result testrepo $the_commit heads/main &&
    + 	git reset --hard $the_commit
    +-
    + '
    + 
    + test_expect_success 'push --force with matching heads' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	git push testrepo : &&
    + 	git commit --amend -massaged &&
    + 	git push --force testrepo : &&
    + 	! check_push_result testrepo $the_commit heads/main &&
    + 	git reset --hard $the_commit
    +-
    + '
    + 
    + test_expect_success 'push with matching heads and forced update' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	git push testrepo : &&
    + 	git commit --amend -massaged &&
    + 	git push testrepo +: &&
    + 	! check_push_result testrepo $the_commit heads/main &&
    + 	git reset --hard $the_commit
    +-
    + '
    + 
    + test_expect_success 'push with no ambiguity (1)' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	git push testrepo main:main &&
    + 	check_push_result testrepo $the_commit heads/main
    +-
    + '
    + 
    + test_expect_success 'push with no ambiguity (2)' '
    +-
    + 	mk_test testrepo remotes/origin/main &&
    + 	git push testrepo main:origin/main &&
    + 	check_push_result testrepo $the_commit remotes/origin/main
    +-
    + '
    + 
    + test_expect_success 'push with colon-less refspec, no ambiguity' '
    +-
    + 	mk_test testrepo heads/main heads/t/main &&
    + 	git branch -f t/main main &&
    + 	git push testrepo main &&
    + 	check_push_result testrepo $the_commit heads/main &&
    + 	check_push_result testrepo $the_first_commit heads/t/main
    +-
    + '
    + 
    + test_expect_success 'push with weak ambiguity (1)' '
    +-
    + 	mk_test testrepo heads/main remotes/origin/main &&
    + 	git push testrepo main:main &&
    + 	check_push_result testrepo $the_commit heads/main &&
    + 	check_push_result testrepo $the_first_commit remotes/origin/main
    +-
    + '
    + 
    + test_expect_success 'push with weak ambiguity (2)' '
    +-
    + 	mk_test testrepo heads/main remotes/origin/main remotes/another/main &&
    + 	git push testrepo main:main &&
    + 	check_push_result testrepo $the_commit heads/main &&
    + 	check_push_result testrepo $the_first_commit remotes/origin/main remotes/another/main
    +-
    + '
    + 
    + test_expect_success 'push with ambiguity' '
    +-
    + 	mk_test testrepo heads/frotz tags/frotz &&
    + 	test_must_fail git push testrepo main:frotz &&
    + 	check_push_result testrepo $the_first_commit heads/frotz tags/frotz
    +-
    + '
    + 
    + test_expect_success 'push with onelevel ref' '
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push with onelevel ref' '
    + '
    + 
    + test_expect_success 'push with colon-less refspec (1)' '
    +-
    + 	mk_test testrepo heads/frotz tags/frotz &&
    + 	git branch -f frotz main &&
    + 	git push testrepo frotz &&
    + 	check_push_result testrepo $the_commit heads/frotz &&
    + 	check_push_result testrepo $the_first_commit tags/frotz
    +-
    + '
    + 
    + test_expect_success 'push with colon-less refspec (2)' '
    +-
    + 	mk_test testrepo heads/frotz tags/frotz &&
    + 	if git show-ref --verify -q refs/heads/frotz
    + 	then
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push with colon-less refspec (2)' '
    + 	git push -f testrepo frotz &&
    + 	check_push_result testrepo $the_commit tags/frotz &&
    + 	check_push_result testrepo $the_first_commit heads/frotz
    +-
    + '
    + 
    + test_expect_success 'push with colon-less refspec (3)' '
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push with colon-less refspec (3)' '
    + '
    + 
    + test_expect_success 'push with colon-less refspec (4)' '
    +-
    + 	mk_test testrepo &&
    + 	if git show-ref --verify -q refs/heads/frotz
    + 	then
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push with colon-less refspec (4)' '
    + 	git push testrepo frotz &&
    + 	check_push_result testrepo $the_commit tags/frotz &&
    + 	test 1 = $( cd testrepo && git show-ref | wc -l )
    +-
    + '
    + 
    + test_expect_success 'push head with non-existent, incomplete dest' '
    +-
    + 	mk_test testrepo &&
    + 	git push testrepo main:branch &&
    + 	check_push_result testrepo $the_commit heads/branch
    +-
    + '
    + 
    + test_expect_success 'push tag with non-existent, incomplete dest' '
    +-
    + 	mk_test testrepo &&
    + 	git tag -f v1.0 &&
    + 	git push testrepo v1.0:tag &&
    + 	check_push_result testrepo $the_commit tags/tag
    +-
    + '
    + 
    + test_expect_success 'push oid with non-existent, incomplete dest' '
    +-
    + 	mk_test testrepo &&
    + 	test_must_fail git push testrepo $(git rev-parse main):foo
    +-
    + '
    + 
    + test_expect_success 'push ref expression with non-existent, incomplete dest' '
    +-
    + 	mk_test testrepo &&
    + 	test_must_fail git push testrepo main^:branch
    +-
    + '
    + 
    + for head in HEAD @
    +@@ t/t5516-fetch-push.sh: do
    + 		git checkout main &&
    + 		git push testrepo $head:branch &&
    + 		check_push_result testrepo $the_commit heads/branch
    +-
    + 	'
    + 
    + 	test_expect_success "push with config remote.*.push = $head" '
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push with remote.pushdefault' '
    + '
    + 
    + test_expect_success 'push with config remote.*.pushurl' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	git checkout main &&
    + 	test_config remote.there.url test2repo &&
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push ignores "branch." config without subsection' '
    + '
    + 
    + test_expect_success 'push with dry-run' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	old_commit=$(git -C testrepo show-ref -s --verify refs/heads/main) &&
    + 	git push --dry-run testrepo : &&
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push with dry-run' '
    + '
    + 
    + test_expect_success 'push updates local refs' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	mk_child testrepo child &&
    + 	(
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push updates local refs' '
    + 		test $(git rev-parse main) = \
    + 			$(git rev-parse remotes/origin/main)
    + 	)
    +-
    + '
    + 
    + test_expect_success 'push updates up-to-date local refs' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	mk_child testrepo child1 &&
    + 	mk_child testrepo child2 &&
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push updates up-to-date local refs' '
    + 		test $(git rev-parse main) = \
    + 			$(git rev-parse remotes/origin/main)
    + 	)
    +-
    + '
    + 
    + test_expect_success 'push preserves up-to-date packed refs' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	mk_child testrepo child &&
    + 	(
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push preserves up-to-date packed refs' '
    + 		git push &&
    + 		! test -f .git/refs/remotes/origin/main
    + 	)
    +-
    + '
    + 
    + test_expect_success 'push does not update local refs on failure' '
    +-
    + 	mk_test testrepo heads/main &&
    + 	mk_child testrepo child &&
    + 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push does not update local refs on failure' '
    + 		test $(git rev-parse main) != \
    + 			$(git rev-parse remotes/origin/main)
    + 	)
    +-
    + '
    + 
    + test_expect_success 'allow deleting an invalid remote ref' '
    +-
    + 	mk_test testrepo heads/branch &&
    + 	rm -f testrepo/.git/objects/??/* &&
    + 	git push testrepo :refs/heads/branch &&
    + 	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/branch)
    +-
    + '
    + 
    + test_expect_success 'pushing valid refs triggers post-receive and post-update hooks' '
2:  2bd892b26c ! 2:  938dfb8d4e remote.c: remove BUG in show_push_unqualified_ref_name_error()
    @@ Commit message
         is wrong.  It is an ordinary end-user mistake to give an object
         name that does not exist and treated as such.
     
    +    An example of the error message produced is as follows:
    +
    +            error: The destination you provided is not a full refname (i.e.,
    +            starting with "refs/"). We tried to guess what you meant by:
    +
    +            - Looking for a ref that matches 'branch' on the remote side.
    +            - Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
    +              is a ref in "refs/{heads,tags}/". If so we add a corresponding
    +              refs/{heads,tags}/ prefix on the remote side.
    +
    +            Neither worked, so we gave up. You must fully qualify the ref.
    +            BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
    +            fatal: the remote end hung up unexpectedly
    +            Aborted (core dumped)
    +
         Helped-by: Junio C Hamano <gitster@pobox.com>
     
      ## remote.c ##
    @@ remote.c: static void show_push_unqualified_ref_name_error(const char *dst_value
      	} else {
     -		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
     -		    matched_src_name, type);
    -+		advise(_("The <src> part of the refspec is an oid that doesn't exist.\n"));
    ++		advise(_("The <src> part of the refspec ('%s') is an object ID that doesn't exist.\n"),
    ++		       matched_src_name);
      	}
      }
      
     
      ## t/t5516-fetch-push.sh ##
     @@ t/t5516-fetch-push.sh: test_expect_success 'push ref expression with non-existent, incomplete dest' '
    - 
    + 	test_must_fail git push testrepo main^:branch
      '
      
    --test_expect_failure 'push ref expression with non-existent oid src' '
     +test_expect_success 'push ref expression with non-existent oid src' '
    ++	mk_test testrepo &&
    ++	test_must_fail git push testrepo $(test_oid 001):branch
    ++'
    ++
    + for head in HEAD @
    + do
      
    - 	mk_test testrepo &&
    - 	test_must_fail git push testrepo $(test_oid 001):branch
-- 
2.50.1

