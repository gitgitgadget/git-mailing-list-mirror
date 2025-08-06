Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE91E7C03
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754456024; cv=none; b=A3UyZL29RW8JHzhy/+V1IXc6q7fpuyVdOkG7vNqRjqftRkPXoiGNbWfIkk6KReyPsh2VDI83IWNFBn72wDrDh/Cxkd9spqzZcYKiRVf9JfSP3oNdQZ/8Rv/3+pRLaUrfVCm9RwJ13RTOQ14MZMPwAH7kXIC7onZtkuu/0EnAME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754456024; c=relaxed/simple;
	bh=eCa8OR7jJHTX6m9+TMgAMiSnzxnq9NQfgxn99PMYlF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnCw4hdChWZiyJPMpAv7qqicj+7PfpOi2WxTxmG1nnvD0Z3INsEt57eEtxMXXpln6ALqz9KIovJZD5w2u0ez4X7Yev9w8NNiUiIv0ZHhCPD7rxYwVjRA+pFtzzHLUz5ZKYDlciqGMme9DpeOzvr41l7/NPOpUb1ypcHBOs1dhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoDkTseJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoDkTseJ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76624ecc7efso629840b3a.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 21:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754456022; x=1755060822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3csa9H+Ah/LSr0jg/EGL014a8zJtNCHtcGbuJg0U5E=;
        b=OoDkTseJi+p6TPgOhnM/FaoNPCAqS9Xyhb6rGfPIfmBI/t0I09wSY3DiMqXePpOWEZ
         i+taoLU8JqWtH8dd9wQ8AZPftIGgQ521KpRbxvNxnUQVWZfL1fuo/glSgEVo8d63cRqD
         iuSMDcnRxUfPDbqDMys9bmPPeOfHK1hgIGdRttD48REHP+wPC1A6Vl+eksqs5aLuV5U2
         LMZS5NnJWlwXHosgOWthIhaYuugoxwhfpmW681ziRjHn9AYJh7tUdUJlYw3msAcaWpTU
         1aFMFn42pWce5PgwuB4qC9bsfp1ibtAc5S3YbuGWV3DSjoXUra/GNLl8Y5OCLkLFAdmd
         cnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754456022; x=1755060822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3csa9H+Ah/LSr0jg/EGL014a8zJtNCHtcGbuJg0U5E=;
        b=j741MODB0IGjh3ceuIK1pjh7SxPyKe3LHxtJbdSSm0Hd2WIDpNDTLerrc5yRbwjYC+
         vzm4kx5KoCcpobeWpFtgijgxGqNUDpwXU5rGW7cRouus7tZDTtgTo/uVeNswysuaTUv0
         cIC5IAf1blkMi7RgC9JDOPcMNqIWmWsEi4Ru+1HggP6FyhajJLpWc4dC6gGGYXM2ufrP
         crzh1rZlLprP0/EDrVs1JEVbAdIJFDK32NIP56tsN3bRVaTsYqRPsstIvYNJf3IWIvDV
         UJKtb2boBU7A7tRlHRicKnCPrjSGpwXyCoDjtjBLXMyk6z1KiU2oqPyACD5dAaNPRR5z
         AJMw==
X-Gm-Message-State: AOJu0YwJ/xhxLoeGMZy9/0tjTm1OXPNkKx2cmJpeqky442U6BFuIklOa
	RAwOgfZKlZHVgcaYmE0oF7kAzQZ1EepxeXSwig5xZe3divv4cXljXb1uGHG29Q==
X-Gm-Gg: ASbGnctnvjovIc8zuO4BULOTsS0v3An2Z32IdGRr49BhlqUnWJaHONeDK+D9/euRE5y
	CvSzJ9KvZpO7RquO6tyJ29snZ9RZHNVauNInuhhE+oBflqIPNVbI+/xMyAUd5AGAsUfuKZ5RPYC
	dbY6MjwDTJ3tZ5mexGdycRFiBodKQJGYBp5F+papo9kK02YnYRg5fIZUbqEWqoPIWTBmklgOmH3
	n8gy6iBinRdJRPjXE3dSS+ggzkT6WHBiXWI8q6M6708d0m6UZ2/rElp9UNzMJenmrXJAitdYcTf
	5rPB82cPwDZyZl/kEpWAT2g2n4tD4StnC+zpexrazW6Ty6vg3ezQip1AHGluFFRoH8Bd9yMRXaH
	Xrk747FwSDticz34VchmC1DNftlKd7fhKELGvWAWWWg==
X-Google-Smtp-Source: AGHT+IH+RtPVU+8YqwJtlDjuIbW/ajRXIRz4CfbvuM6+i/vEYeyhzts9roQLvbgVkg6RVdgJ5eeEWw==
X-Received: by 2002:a05:6a00:1a92:b0:76b:cb1e:ac3f with SMTP id d2e1a72fcca58-76c2a61328dmr758167b3a.7.1754456021841;
        Tue, 05 Aug 2025 21:53:41 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:7ec2:c6ff:fe46:ef9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdf61d182sm11495145b3a.119.2025.08.05.21.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 21:53:41 -0700 (PDT)
Date: Tue, 5 Aug 2025 21:53:39 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/2] t5516: remove surrounding empty lines in test bodies
Message-ID: <82b09af4ca8e610dd06b94be560622837a35d3ff.1754455931.git.liu.denton@gmail.com>
References: <cover.1754375026.git.liu.denton@gmail.com>
 <cover.1754455931.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754455931.git.liu.denton@gmail.com>

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

