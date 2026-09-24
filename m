Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96447CC6C
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251522; cv=none; b=cTf8EDoO3DpZr8zIiqpHP4q3kKeRlGLHowZGimPLE1Zn2wWBL9ZfEE+fyQ1NoOY4pgSOJl07UBuZeicFofNv6olAt1LEA9/qnZZIf36ynlCj41IR8Nfvm1GspTI4r2iRubfIMjZNnSwMsThaU0Lh9fB7KegO/Hx4bxp44aHleXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251522; c=relaxed/simple;
	bh=vROTewiVgQprQAdnwWhQhDD4lzWs5mDKIHU4a7vJOis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X69wnqcyQdo3jFNUhN1TIcrzNsPZs7VApqkDGPpKcf8INO6zQZ0kMhWkt0r8IWWuMkK4ZLbbJBK417ukWLyATkSKlSuV8Adnfbku2APWX3P3yDr12naA0fl+DiIChy70KeR5QyauADwB/fvGUz6caTbnQKvLbkXzTFzGzmKRQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGJKF5cW; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGJKF5cW"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso1678110eec.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790251520; x=1790856320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhc0y1IK2UAZkl2BqoEwK5QklLKJSgoNV99rgINuhQo=;
        b=eGJKF5cWfmBtwh86RigSMQYI8xdMO0Gn4bTwAQ1VCmePSg8ku4NCFB/I5w35GNZt2o
         0cdR4oLoIjuB4owfuMNaxbnbMuoZh4C8Xq7DnMbyqWtNG3YQRP4GK7MRqKBv46S/lCdK
         RMk4qnJ8h6qqkD3KIzBERsNZX2IZ1g2WccU9Uo0YyCEItZYtM+9enLFOuNIX1sM2C9Wx
         PO4SJQkuVbqMyr9dhLp40VZW65gPCfXatqjW8fx8jmG5+pB/+AprHZA+NKakH0xqpTDr
         DeANFyJ6oOPkBG1rNF/gJCC3Is3ybHT4LBrblXlxLB1cEC1I4bXMhjHod25W1yyl0puR
         BKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790251520; x=1790856320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hhc0y1IK2UAZkl2BqoEwK5QklLKJSgoNV99rgINuhQo=;
        b=ipYpuLbGJqEbloXncKvHdaWfdeIR6g/XwiLZb9NINtlPlVTXaq4S+09hjCbqnA9NNX
         k5Bo7YuzOAySJjNz8godvR8XH+rnYAWBxJfES80enx2ZSKktHCY/btYh4Yc2EpmSkPvH
         E511x4/NJv2VR5A40cucrbKkkoUwrEVR9at91yp7mT+VCBAPX+fyD96bXrWQehYmKCG6
         KAIRa8/2DXD7RP+3DPgPK/IO0X5CcTbJzrGmrVPEtyRrxwHMPNQGsTAqO6NDOFEnrG0D
         QnlpapoLCOHanBqFsBFMc+vqgQTkYHbiEHHEf98s8G1XAgtvaQ/2wNpp7QyuFBQkG52q
         cx+w==
X-Gm-Message-State: AFuF++m5+mtUM0m7rFVvbe28SpnKV8eXTuifWhkp4Yv2JP9AcU126PqJ
	fZMUctl8h6up9nejv4hFoe0Ji82F+ySWZ2CnU3m2azDlyhNuMggrSiUza/6kJHw1/qk=
X-Gm-Gg: AYBFou28+ppvQB+6hbBYsrPwzKhtRMAbeId7tIVw+94Iimfecp1CXbusVRFyq9QmJ0g
	ZpbkaxxnI5NucdSSuBunALchQe3w3RxEo1qfG8cr/VhAOcuHQP1pwVc8R54qPKNPd2OsSMsS1ZL
	i6pf38/W/d5iBBK6lxfVM6CPbv2777DkIcXjXFjlvasbvTzyh2s+N7X9X2wyBpKVJsal7zEZAc6
	qq5YZQcYpdotCJBjvU5zE9CKYDkQLRElqIf1Tf81Vh9Gh+LNrsNtVYQvzquZ0CO8m9Amel3Q9h7
	5k24RnGv0mUfXCIfp87ZeVMZhfEJcOcMEYopeOmBjitIo4fh/A559AsOv8lGWqnAShCRrEr8My4
	8PyVBvfxuUitkijp7oCNd8KAStlIr+c2+BVx6eGpxCeahpAZXpZ7XXYeyedDXJ3n/sqnxPOHgyA
	P/xtF7CbJXRUvOX0hm3tAQYJHtEuk7vJkWwzMZR0FGSPBVuzIw925zqDxkZD2EytpdfBRmUcD3U
	MIxUQhOcXNbZs1m8TCMHi2GLwt6ZR/94MWf
X-Received: by 2002:a05:693c:41db:10b0:33b:dd20:f79c with SMTP id 5a478bee46e88-33ffeb46c67mr1900714eec.12.1790251519849;
        Thu, 24 Sep 2026 05:05:19 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm14302671eec.5.2026.09.24.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:05:19 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC PATCH 3/3] setup: communicate why a directory is not a valid git directory
Date: Thu, 24 Sep 2026 17:32:21 +0530
Message-ID: <20260924120502.2642141-4-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.12.g2c9c8d64bb
In-Reply-To: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment, there are a few scenarios in which the error message
surrounding an invalid Git repository is a bit blunt:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
  fatal: not a git repository: 'repo.git'

In this case, even though repo.git is a valid Git repository,
we get an output saying it is not since the GIT_OBJECT_DIRECTORY
does not point to a valid object directory. At the moment, the
user is on their own in figuring this out.

Instead, make it more easy for users to figure such issues
particularly in cases where they have explicitly specified
a Git directory. This intends to improve the error reporting UX
by clarifying why the specified repository is not considered valid.

We achieve this by means of using the new helper
is_git_directory_verbose() that has been introduced. With the
same, we get a more helpful error message as follows:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
  fatal: not a git repository: 'repo.git'
  reason: cannot access object directory '/does/not/exist' set via $GIT_OBJECT_DIRECTORY

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 setup.c                       | 13 +++++++++++--
 t/t0009-git-dir-validation.sh | 10 ++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/setup.c b/setup.c
index b3b53a1cfc..3e99141474 100644
--- a/setup.c
+++ b/setup.c
@@ -1225,6 +1225,7 @@ static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
 					  int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
+	struct strbuf invalid_gitdir_reason = STRBUF_INIT;
 	char *gitfile;
 	int offset;
 
@@ -1237,12 +1238,19 @@ static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
 		gitdirenv = gitfile;
 	}
 
-	if (!is_git_directory(gitdirenv)) {
+	if (!is_git_directory_verbose(gitdirenv, &invalid_gitdir_reason)) {
+		struct strbuf die_msg = STRBUF_INIT;
 		if (nongit_ok) {
 			*nongit_ok = 1;
 			goto out;
 		}
-		die(_("not a git repository: '%s'"), gitdirenv);
+
+		strbuf_addf(&die_msg, _("not a git repository: '%s'"), gitdirenv);
+		strbuf_addch(&die_msg, '\n');
+		strbuf_addf(&die_msg, _("reason: %s"), invalid_gitdir_reason.buf);
+		die("%s", die_msg.buf);
+
+		strbuf_release(&die_msg);
 	}
 
 	if (read_and_verify_repository_format(&discovery->format, gitdirenv, nongit_ok))
@@ -1304,6 +1312,7 @@ static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
 	repo_discovery_set_gitdir(discovery, gitdirenv, 0);
 
 out:
+	strbuf_release(&invalid_gitdir_reason);
 	free(gitfile);
 }
 
diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
index 244dc07c0e..411aac1d9e 100755
--- a/t/t0009-git-dir-validation.sh
+++ b/t/t0009-git-dir-validation.sh
@@ -79,7 +79,8 @@ test_expect_success 'setup: custom git directory with missing HEAD is rejected'
 	mkdir -p parent/empty-dir &&
 	(
 		test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
-		test_grep "not a git repository" stderr
+		test_grep "not a git repository" stderr &&
+		test_grep "reason: could not stat HEAD at" stderr
 	)
 '
 
@@ -93,7 +94,8 @@ test_expect_success 'setup: custom git directory with HEAD as a symlink outside
 		rm real-repo/HEAD &&
 		ln -s ../garbage real-repo/HEAD &&
 		test_must_fail git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
-		test_grep "not a git repository" stderr
+		test_grep "not a git repository" stderr &&
+		test_grep "reason: HEAD is a symlink .* but target lives outside refs" stderr
 	)
 '
 
@@ -105,9 +107,9 @@ test_expect_success 'setup: custom git directory with invalid GIT_OBJECT_DIRECTO
 		git init --bare real-repo &&
 		test_must_fail env GIT_OBJECT_DIRECTORY="$(pwd)/does-not-exist" \
 			git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
-		test_grep "not a git repository" stderr
+		test_grep "not a git repository" stderr &&
+		test_grep "reason: cannot access object directory .* set via \$GIT_OBJECT_DIRECTORY"   stderr
 	)
 '
 
-
 test_done
-- 
2.56.0.rc1.12.g2c9c8d64bb

