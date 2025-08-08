Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7231D7999
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754628074; cv=none; b=srQMCmqpUzhir356kBbgT3IRG5UYhQL8BuA1bGtAzsv3myNS7YPYOEkgnEvIY4GlHo8nvmJoi1/+xgZedBhrNCp6EdFCGWM0wvIK7xhDNR6LB265ZL1pl5KpRdRjRj/YktmGf8P2nWLr2pC/MB1mgHz2vG1j0jrCKIEJ20A1eE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754628074; c=relaxed/simple;
	bh=eCa8OR7jJHTX6m9+TMgAMiSnzxnq9NQfgxn99PMYlF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXHYDis3YJhZO4E6BwvHgt/gdblGrtDPK/E5XhPDJy4Esqws0+EYQTlOdLd0jjtMbUMMUJyeuybJWF+uQHU9h2n+sUIEcSXMckdcgvogX1GpPXCX9xtynNSV2xKC30JpdEDKORjthkB8yYH+kr2myD09T5RT7p3RowQ3S0vaIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn7y/RN4; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn7y/RN4"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b34dde96cbfso298029a12.2
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 21:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754628071; x=1755232871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3csa9H+Ah/LSr0jg/EGL014a8zJtNCHtcGbuJg0U5E=;
        b=Nn7y/RN4X/NPF7axbOJP/GiYdfJ/pkW6e6X+UALrYe8aHni9X+mf6uJF/KrccNm8fV
         lnvB7FjAb3spixjiIBnmNKnoau9TrbF1bLhMKYOyiqikRc+WDliRzuYG0cELxGaDiQ7K
         lrYMEuXxw8Y3yOZQ+msesCU1RV7+w65JbJGekHrec1UBmyoQ/dQTPEtNaXmZXnCGOqwT
         JXHY95U5WnXmuXIU2hZUogSH7Qcy105TmjVqsT/JQJWl/GtZxHab/6GvnUwuC+UtSWIv
         1ZMAL17x7QBhOPWcWmSl28OorNLy+XMuffx7TwzF/3iyPjX2a9pxp/qf+mFbCF5T8kJ4
         i5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754628071; x=1755232871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3csa9H+Ah/LSr0jg/EGL014a8zJtNCHtcGbuJg0U5E=;
        b=GNsmnPuuIMx0PUfj6BUTqBgz/16QArmeHRVwJwe8/6LpQNJQ7l0f+F3ieS4Q4pA7+M
         pDWR7dTiWYrlQs3CtndgtJ95cpLy600oyX0OWtf5+enJ8/Vjfb0VCzbvTebCTEd48d8g
         bmrFKUSNHaIyG26MzSZHRXGEUF21LjZNcmOvepNbSAs6L4G6lTUAQlngPVDqPBjPzEwl
         3dlhQ0GFQEbRpsHEBm6Y1KvtYHTR5B09IePdEAZC2ELX111xFELt8HzM9OdmuNkgiu9E
         S2qu7jiMFVOK/+1KWgnM9QMRV1TFZuW3YcTVheXOuv+/TEff7lhKDppb5Y2C9aOhgLGZ
         iSaA==
X-Gm-Message-State: AOJu0YwUvdG1Fvg2Nchs2JmKJV54OlbFWFc1I8Rpews3Er4jXaDSS/q2
	1gjwTnW9rWeQBZyFJ+RuEv7kyu4Mqaxe0sw964GaVDQFq6fh2BIbYNCNx4KY8Q==
X-Gm-Gg: ASbGncu4OttkBicBLLMy5Yp3WRN+t7cpXTQDDLjpeds6CtL0EKUAICElFZYISDZ2J+p
	0eJi4BRis/bf0/GZDJmOoz+pQc/jmvKXpPsdG4/tDlgwk+ODIoA90RCilauZApWaQQIdViYxjZ1
	2BcP0W4NvvbIOiz1mZvCyYQmjOikTs1gJWhTXvSSkTPGQmrG1hpIpBBB/W/zp5fKsInVEWfTS5l
	aAiZ4g0gAtVQWCyQOySDb5EmdQenJkV8HvymgJTd3+va5bf1qTjKeXveUI+0n9wkOQCPiL0+/un
	P8kWEiClhWEykhd1Sd/e+Rqy0aXJqxPhuVPdL8AAhHp+ADs0anIlM7gi0EFeaA3HF30kgfvQEGp
	2omDrQAq2mRnlM6Njp1KfImqJMypT9g==
X-Google-Smtp-Source: AGHT+IE0S5yTGSWUObIEhNuUdDaJR7j8e8WZ45jNeIDhUC2gl4h8gq9Gc41WxCk9oxA1F3l2nER68Q==
X-Received: by 2002:a17:90b:3b8d:b0:31e:fac5:5d3c with SMTP id 98e67ed59e1d1-32183c46730mr946144a91.4.1754628071474;
        Thu, 07 Aug 2025 21:41:11 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm17062141a12.56.2025.08.07.21.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 21:41:10 -0700 (PDT)
Date: Thu, 7 Aug 2025 21:41:09 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 1/3] t5516: remove surrounding empty lines in test bodies
Message-ID: <d31f320fdbb375cda9365df501e9b684ee84360c.1754627874.git.liu.denton@gmail.com>
References: <cover.1754455931.git.liu.denton@gmail.com>
 <cover.1754627874.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754627874.git.liu.denton@gmail.com>

This style with the empty lines in test bodies was from when the test
suite was being developed. Remove the empty lines to match the modern
test style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5516-fetch-push.sh | 51 -------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4e9c27b0f2..8eddf3e40d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -105,7 +105,6 @@ check_push_result () {
 }
 
 test_expect_success setup '
-
 	>path1 &&
 	git add path1 &&
 	test_tick &&
@@ -117,7 +116,6 @@ test_expect_success setup '
 	test_tick &&
 	git commit -a -m second &&
 	the_commit=$(git show-ref -s --verify refs/heads/main)
-
 '
 
 for cmd in push fetch
@@ -322,104 +320,82 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 '
 
 test_expect_success 'push with matching heads' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	check_push_result testrepo $the_commit heads/main
-
 '
 
 test_expect_success 'push with matching heads on the command line' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	check_push_result testrepo $the_commit heads/main
-
 '
 
 test_expect_success 'failed (non-fast-forward) push with matching heads' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	test_must_fail git push testrepo &&
 	check_push_result testrepo $the_commit heads/main &&
 	git reset --hard $the_commit
-
 '
 
 test_expect_success 'push --force with matching heads' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	git push --force testrepo : &&
 	! check_push_result testrepo $the_commit heads/main &&
 	git reset --hard $the_commit
-
 '
 
 test_expect_success 'push with matching heads and forced update' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	git push testrepo +: &&
 	! check_push_result testrepo $the_commit heads/main &&
 	git reset --hard $the_commit
-
 '
 
 test_expect_success 'push with no ambiguity (1)' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo main:main &&
 	check_push_result testrepo $the_commit heads/main
-
 '
 
 test_expect_success 'push with no ambiguity (2)' '
-
 	mk_test testrepo remotes/origin/main &&
 	git push testrepo main:origin/main &&
 	check_push_result testrepo $the_commit remotes/origin/main
-
 '
 
 test_expect_success 'push with colon-less refspec, no ambiguity' '
-
 	mk_test testrepo heads/main heads/t/main &&
 	git branch -f t/main main &&
 	git push testrepo main &&
 	check_push_result testrepo $the_commit heads/main &&
 	check_push_result testrepo $the_first_commit heads/t/main
-
 '
 
 test_expect_success 'push with weak ambiguity (1)' '
-
 	mk_test testrepo heads/main remotes/origin/main &&
 	git push testrepo main:main &&
 	check_push_result testrepo $the_commit heads/main &&
 	check_push_result testrepo $the_first_commit remotes/origin/main
-
 '
 
 test_expect_success 'push with weak ambiguity (2)' '
-
 	mk_test testrepo heads/main remotes/origin/main remotes/another/main &&
 	git push testrepo main:main &&
 	check_push_result testrepo $the_commit heads/main &&
 	check_push_result testrepo $the_first_commit remotes/origin/main remotes/another/main
-
 '
 
 test_expect_success 'push with ambiguity' '
-
 	mk_test testrepo heads/frotz tags/frotz &&
 	test_must_fail git push testrepo main:frotz &&
 	check_push_result testrepo $the_first_commit heads/frotz tags/frotz
-
 '
 
 test_expect_success 'push with onelevel ref' '
@@ -428,17 +404,14 @@ test_expect_success 'push with onelevel ref' '
 '
 
 test_expect_success 'push with colon-less refspec (1)' '
-
 	mk_test testrepo heads/frotz tags/frotz &&
 	git branch -f frotz main &&
 	git push testrepo frotz &&
 	check_push_result testrepo $the_commit heads/frotz &&
 	check_push_result testrepo $the_first_commit tags/frotz
-
 '
 
 test_expect_success 'push with colon-less refspec (2)' '
-
 	mk_test testrepo heads/frotz tags/frotz &&
 	if git show-ref --verify -q refs/heads/frotz
 	then
@@ -448,7 +421,6 @@ test_expect_success 'push with colon-less refspec (2)' '
 	git push -f testrepo frotz &&
 	check_push_result testrepo $the_commit tags/frotz &&
 	check_push_result testrepo $the_first_commit heads/frotz
-
 '
 
 test_expect_success 'push with colon-less refspec (3)' '
@@ -465,7 +437,6 @@ test_expect_success 'push with colon-less refspec (3)' '
 '
 
 test_expect_success 'push with colon-less refspec (4)' '
-
 	mk_test testrepo &&
 	if git show-ref --verify -q refs/heads/frotz
 	then
@@ -475,38 +446,29 @@ test_expect_success 'push with colon-less refspec (4)' '
 	git push testrepo frotz &&
 	check_push_result testrepo $the_commit tags/frotz &&
 	test 1 = $( cd testrepo && git show-ref | wc -l )
-
 '
 
 test_expect_success 'push head with non-existent, incomplete dest' '
-
 	mk_test testrepo &&
 	git push testrepo main:branch &&
 	check_push_result testrepo $the_commit heads/branch
-
 '
 
 test_expect_success 'push tag with non-existent, incomplete dest' '
-
 	mk_test testrepo &&
 	git tag -f v1.0 &&
 	git push testrepo v1.0:tag &&
 	check_push_result testrepo $the_commit tags/tag
-
 '
 
 test_expect_success 'push oid with non-existent, incomplete dest' '
-
 	mk_test testrepo &&
 	test_must_fail git push testrepo $(git rev-parse main):foo
-
 '
 
 test_expect_success 'push ref expression with non-existent, incomplete dest' '
-
 	mk_test testrepo &&
 	test_must_fail git push testrepo main^:branch
-
 '
 
 for head in HEAD @
@@ -550,7 +512,6 @@ do
 		git checkout main &&
 		git push testrepo $head:branch &&
 		check_push_result testrepo $the_commit heads/branch
-
 	'
 
 	test_expect_success "push with config remote.*.push = $head" '
@@ -596,7 +557,6 @@ test_expect_success 'push with remote.pushdefault' '
 '
 
 test_expect_success 'push with config remote.*.pushurl' '
-
 	mk_test testrepo heads/main &&
 	git checkout main &&
 	test_config remote.there.url test2repo &&
@@ -655,7 +615,6 @@ test_expect_success 'push ignores "branch." config without subsection' '
 '
 
 test_expect_success 'push with dry-run' '
-
 	mk_test testrepo heads/main &&
 	old_commit=$(git -C testrepo show-ref -s --verify refs/heads/main) &&
 	git push --dry-run testrepo : &&
@@ -663,7 +622,6 @@ test_expect_success 'push with dry-run' '
 '
 
 test_expect_success 'push updates local refs' '
-
 	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
 	(
@@ -673,11 +631,9 @@ test_expect_success 'push updates local refs' '
 		test $(git rev-parse main) = \
 			$(git rev-parse remotes/origin/main)
 	)
-
 '
 
 test_expect_success 'push updates up-to-date local refs' '
-
 	mk_test testrepo heads/main &&
 	mk_child testrepo child1 &&
 	mk_child testrepo child2 &&
@@ -689,11 +645,9 @@ test_expect_success 'push updates up-to-date local refs' '
 		test $(git rev-parse main) = \
 			$(git rev-parse remotes/origin/main)
 	)
-
 '
 
 test_expect_success 'push preserves up-to-date packed refs' '
-
 	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
 	(
@@ -701,11 +655,9 @@ test_expect_success 'push preserves up-to-date packed refs' '
 		git push &&
 		! test -f .git/refs/remotes/origin/main
 	)
-
 '
 
 test_expect_success 'push does not update local refs on failure' '
-
 	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
@@ -717,16 +669,13 @@ test_expect_success 'push does not update local refs on failure' '
 		test $(git rev-parse main) != \
 			$(git rev-parse remotes/origin/main)
 	)
-
 '
 
 test_expect_success 'allow deleting an invalid remote ref' '
-
 	mk_test testrepo heads/branch &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/branch &&
 	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/branch)
-
 '
 
 test_expect_success 'pushing valid refs triggers post-receive and post-update hooks' '
-- 
2.50.1

