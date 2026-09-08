Received: from mail-qv2-f6.google.com (mail-qv2-f6.google.com [74.125.230.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3F304BB3
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906811; cv=none; b=Q94olzAsXlqTdF4aTM16weqDJfSscpZuoOc7q3qGb2RuB3oE/Rx7yP13v0igCp2Ekcfe78iTgkovL/5Bg9JdvTs7wg4mEp0qKxa3nTWz4JKKN7U5+Oz2ew8Q0LnO8w0CXHV3RxF2pcS4lzhCVuU0I/v+z5ggfFrd/fn6zra70SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906811; c=relaxed/simple;
	bh=8DeCc0J72xZ6C+01bKDBvnOoSHtyUkdxD11HYVkwJD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COtw92mEs8L/J3irnDEXDP1s06kHBZJD4ZJPnWqYrj2R9YkgA+gumNXhnnrScF1bkhmHKoi0K2cqNMPyNxeij7LKQcu9OXB7Tv/MfFx4HwmkRGepqoNMVceElcHnWQ/ymBIMYK3oZonpe7VNH+vuVXmYugcuQP72a3AC6vwlvXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=dr/rY+GE; arc=none smtp.client-ip=74.125.230.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="dr/rY+GE"
Received: by mail-qv2-f6.google.com with SMTP id 6a1803df08f44-90cd0a3019eso20733456d6.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1788906804; x=1789511604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8le5IMaWegP6FuszqEBu/X4SX8CmNtFHFzoDE8EpMN0=;
        b=dr/rY+GEh1Ujb3dm/KPvqov5LGDqhWUGVH2JWAzZPUywKEmEqYoYYByjaZm1Fhs7hA
         p+Zg6dLTuPKPwRsC9a+dbywlu4RG/u9VdSQ2XIx2Dd/6lCn98RfgYjgCwDEcWDvkuXRT
         vuJT6cdNacsKfIzg/AWRx9n/3KOqE9ijmZApM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788906804; x=1789511604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8le5IMaWegP6FuszqEBu/X4SX8CmNtFHFzoDE8EpMN0=;
        b=jn4yqCgog7ITmSv3C8/v9VqEhXpptQtfu3O2BpoAx+vyJaOz1NWG2om614dIREN4PT
         jlVKBoBzRNwwANDlwkXW/eIsXhGe4kuPzIc72L4EMqaQaAygnpNW3udHONRNTae7lOQQ
         rOROElZEQHxciu9dMnXXR5DehKZTHe1IvFCZk2sX2dZSe5sWds89aWOHaGmfnXa9r7cg
         O4iPxbCrofp3sYGVgnmKhQoD0Gk0mvwgTXWBi1yPN8Jy9vCIuobZh1195/8qOlSe8KxV
         7HLoz07QIvZ7VHL3UNcocjuZLMUaR+PiwyObG+Botb0J3oq/PicJAjg6mloo/Ap9f1A2
         /4hA==
X-Gm-Message-State: AFuF++m4mLq4eaB0WI6zpSc8jebjtUcg4f9D8Prr4+912gw0m4rEDEDj
	BIvsbBEU1uWETUbaFM8YwVLElOOzgYy/G4KHIKnv7SbThiYnIQMcJeSo+SgmUSx+mc8zyG/n6mF
	Utv2UfTrv6NAU
X-Gm-Gg: AYBFou1UzozeMqBX7U8MFfO/MCtn1MeF1V+qNsM3S9JKmmIXmRgZwMp0vQe3JoacCKZ
	FLp065KnV+MKgBP0YmVePKpgXERAYOGuBQOBJ34xJvV+wLH7bxi8SMgnxKWLt1gIHC1tNBlabkV
	LEggpg4NVMDq3f1MIVM9rlQShb69KfZCiF4k3FID4mjp9d4uKKAS2rJEbZASClDos6LVddlfNKv
	k5M30sRuvGearElIS2HVwtY3eQoC8mUNhuav8xYOFZ3Ptr9ER0UVRDY/aTrMOc4vCAJwYPbpcET
	kP725ahlKctegxRgG+9hFNxfYTuL7bkAmJLsbqdUqUDjNkSUOqzbWd7EOSnCaZIXaqc5r20u3m0
	3b9LBJKq0Ie1m/DS2veD71epgR+89G53F0YvB8N0euhTD0qrByVQwvGEjMX6gaKAQnlF0zGt5A1
	gWKXo5bqcibgYwFuqywcwAFg9PYsJermzr2LL6uAWGB0/XCbOGYI1aGerttwq4nouR7KEVf3Jz3
	940g83tRgQwTLMRwHkoMEFGFJjrFD5LH0FNgKZvJBSXHQ==
X-Received: by 2002:a05:6214:4e06:b0:90e:9d41:d44e with SMTP id 6a1803df08f44-9103ef6f60fmr373165656d6.21.1788906804415;
        Tue, 08 Sep 2026 15:33:24 -0700 (PDT)
Received: from com-79390 ([40.76.104.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91053b4992csm70634696d6.22.2026.09.08.15.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:33:24 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:33:19 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Peter Elmers <peter.elmers@databricks.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [BUG] git bundle create with bitmaps omits tree required by
 advertised ref
Message-ID: <aqCNL8y9wLLP4ovm@com-79390>
References: <CALY5j-0K-LfowAavH8X3UfZ24eAsoX=xew=KTt=4uCfZrdwXQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALY5j-0K-LfowAavH8X3UfZ24eAsoX=xew=KTt=4uCfZrdwXQw@mail.gmail.com>

On Tue, Sep 08, 2026 at 10:23:37AM +0200, Peter Elmers wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> I created two sibling commits with the same root tree, stored one at a local
> branch and the other at a remote-tracking ref, wrote a pack bitmap, and created
> a bundle that included the local branch while excluding the remote-tracking
> ref.
>
> Adding `-c pack.useBitmaps=false` appears to fix the issue.
>
> The following script reproduces the issue:

Interesting. I reproduced what you wrote here using your script. I
highly suspect what's going on here is that the non-bitmap case
overcounts some objects beyond the boundary whereas the bitmap case
builds an exact answer.

The non-bitmap traversal only marked boundary trees UNINTERESTING in
this case, so it happened to keep the shared tree.

We can fix this with something like the following (only lightly tested)
patch, but it has some test fallout for cases where we generate bundles
with only tags (+CC Peff who may have some opinions).

--- 8< ---

Subject: [PATCH] bundle: restrict pack haves to recorded prerequisites

`write_pack_data()` uses every UNINTERESTING tip as a pack have, but the
bundle header records only boundary commits. If an included commit
shares a tree with an excluded sibling, a bitmap walk can omit that tree
while the header requires only their parent. A recipient with the parent
  can verify and unbundle the result while lacking the advertised
  commit's tree.

Restrict pack haves to UNINTERESTING commits marked BOUNDARY, which
are recorded as prerequisites. Other excluded tips must not suppress
objects that the advertised refs need.

As a consequence, there is a bit of test fallout in t6020.13. That test
includes the tags while excluding all branch tips. Its header records
no prerequisites, but its pack previously contained only the three
tag objects: the excluded tips caused their target histories to be
omitted.

But that bundle was already incomplete! With no prerequisites, it must
provide the history reachable from its advertised tags. Restricting
pack haves to recorded prerequisites includes that history, increasing
the expected object count as below.

Reported-by: Peter Elmers <peter.elmers@databricks.com>
Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 bundle.c               |  7 +++++--
 t/t6020-bundle-misc.sh | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/bundle.c b/bundle.c
index f55a521b2a1..06a52b8e705 100644
--- a/bundle.c
+++ b/bundle.c
@@ -359,10 +359,13 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, int progress)

 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *object = revs->pending.objects[i].item;
-		if (object->flags & UNINTERESTING)
+		if (object->flags & UNINTERESTING) {
+			if (!(object->flags & BOUNDARY))
+				continue; /* Not a bundle prerequisite. */
 			oid_array_append(&opts.haves, &object->oid);
-		else
+		} else {
 			oid_array_append(&opts.wants, &object->oid);
+		}
 	}

 	if (odb_generate_pack(revs->repo->objects, &generator, &opts)) {
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 939d4214f4d..6fce6252a11 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -446,8 +446,9 @@ test_expect_success 'create bundle 4 - with tags' '
 		make_user_friendly_and_stable_output >actual &&
 	test_cmp expect actual &&

-	test_bundle_object_count       4.bdl 3 &&
-	test_bundle_object_count stdin-4.bdl 3
+	# With no prerequisites, include the tag targets and their history.
+	test_bundle_object_count       4.bdl 40 &&
+	test_bundle_object_count stdin-4.bdl 40
 '

 test_expect_success 'clone from bundle' '
@@ -784,4 +785,13 @@ do
 	'
 done

+test_expect_success 'bundle with bitmaps includes trees shared with an excluded sibling' '
+	commit=$(git commit-tree main^{tree} -p main^ -m rewritten) &&
+	git branch rewritten "$commit" &&
+	test_when_finished "git branch -D rewritten" &&
+	git repack -adb &&
+	git -c pack.useBitmaps=true bundle create bitmap.bdl main..rewritten &&
+	test_bundle_object_count bitmap.bdl 3
+'
+
 test_done

base-commit: b8242b093d9e941a34460d715e3ce616a34ac3fe
--
2.55.0.openai.744.g47c847ce2641

