Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E8372059
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474288; cv=none; b=i6GqEWRjMssjhIEc2v3fgxtDdEZE700YDUotTCe7sMdUzh1Kr9bufuwfkyRYngUDc1Tp++q4pOioefF2zqzDy7EDDcaKr3r0Quo84dmwb1uEYS/rXYfD+292gEUFzTQCZ9pM5/mtNZAy29NerlPJ2zNlGvv2qKJqFq0bLee99ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474288; c=relaxed/simple;
	bh=5l9fni4eWntDwBQQKos+7yGh1XzNJDUg6XYjUJDAVaE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sPvGUR1ZLxpa57xZadf8qQPj8zUj8BjUZYTR0gT0OHlVPj/F09SvqEbcQkEUNdluTMLwC+awRC43eKlvMdMGV66+ZrgYdlpTuffzSVFB4N/A7cGr44T6/2E9maqUnZE78fvcbKEba83CN2W+feZ+5GC9UNdHj7rARJFpGjLIbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC7rKc5j; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC7rKc5j"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90b2fcf90a0so1051173085a.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474285; x=1780079085; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHlbXSV5guyXqb3DlkoRBp7CU9x3abawZ5QTJ9dGiWI=;
        b=iC7rKc5j+/yu5J4YrEABhqQZ61gNXcmVcy4lN2UjSc/K/s+qliVF0tVER5QSGcUKIq
         J91flEMrs9pchW2MbppNfItOxYwfqQRVd8NWIG+Pzn8J6qxu3rufAMk9Q6OOEnkoysL+
         Q3N+n7GH6vh6xjbF2wbHRAxPe6fCWfm+y+IySK+CVH11MmqrAfVrTD41PhWDTDD1yrWI
         13LWdRMpKX+RlSqdv6pVIu00naBhbtiGBAuoYQZUl3y8+dvVyK3BTba7ijUrzj1KZY7H
         mZ6wNXuxKCjqMQ+3s9j3bKegSt569paWQIH97/tbldOth5qClSNACPO7H689KGUBp0Cg
         1f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474285; x=1780079085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHlbXSV5guyXqb3DlkoRBp7CU9x3abawZ5QTJ9dGiWI=;
        b=RcBQzTKnQJSE6ypBUwAFCh7/8pYAvLn9lGTlHGAQEamWJ9QYvljRJX4JxL3pb/xZwa
         fNI21vhCGK8QD8eZjjq43OKhF8kow9HsCIKGg3WnkLKCSfYPttiZ8SlhJtCctuqqdOLq
         YBkj8WH11ak4hVcow4HyiNKK2K4uB7v6ZNXajyQ3YR02ljMV5SE9xm7kfxj6fcEoqcAU
         PxlFs6FSTz7NuarAMlE6+t7l+NtDJA72eCOJB9hOEWGGF598JikoM1X3OWZnBVgWShwS
         dg0eEUsSDVt2DC5FKQHoOTbIb5kEyrEZ6QpKPxpcLWghvJDjobkj7dFNzdejTluVBICX
         huRA==
X-Gm-Message-State: AOJu0YykjMVhIjgR5SrebhMoIKBAx0aUmUf/I0sfwnwTeWawka1xJssd
	9yM4ji7NeKgkMTeWwk74hup1g6w51wo3ShRnjogIsZT2n8ua/2J17IOBK0QD9J0+
X-Gm-Gg: Acq92OHWYodms8HrFM85j53DbPC60hK5DyuAYIe85fEqS0/quRiHYQ0IvfVoiG5SxgM
	6wArFRs0btzIHViZpWEGV/WOKT4dSG8b7BBBH52F5kJC5hcdLplwa6Gf+anhaLClf1qPO3miQvG
	Vzog84k9povj1rRVvvSh0t4+vxWyw6XWUle6S3VuQujOtKKNqWt5TFqWg9GUnc91F4+UVcAZ35k
	j+RqSesSOAozpBS0C5Lj+T8Gu1mv/kBRMIaB/5uKz6UOAEtwHr2QiQt8nM2mgw+xZK/pzUG+rSd
	7RJyzkocdOe+A1pf9X9U6ylHASNLVOV8ZZyIBDlLxBwFYINaQfHotHrDGpdGKrGbBtgKYxGl2/6
	MgOco9vbwoNe68CSya8ge4lByb5lRrth/AQRDdh11vN+S8ioV73TsKXw+h/t1khTmXBhnaUPJq/
	933/ydYur18FL8adfQLbtJbSAWgeQ7ZWpp/a6iWxoFAbAJbqoU
X-Received: by 2002:a05:620a:318b:b0:911:c5c0:d5f2 with SMTP id af79cd13be357-914a22d3d9dmr1077964385a.1.1779474285571;
        Fri, 22 May 2026 11:24:45 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb905677sm205816585a.18.2026.05.22.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:45 -0700 (PDT)
Message-Id: <89726faf7ec457d6f709ac435e9b4bb73d6c6fda.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:30 +0000
Subject: [PATCH v5 06/13] backfill: die on incompatible filter options
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'git backfill' command uses the path-walk API in a critical way: it
uses the objects output from the command to find the batches of missing
objects that should be requested from the server. Unlike 'git
pack-objects', we cannot fall back to another mechanism.

The previous change added the path_walk_filter_compatible() method that
we can reuse here. Use it during argument validation in cmd_backfill().

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/backfill.c  | 5 ++---
 t/t5620-backfill.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 7ffab2ea74..b80f9ebe69 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -96,9 +96,8 @@ static void reject_unsupported_rev_list_options(struct rev_info *revs)
 	if (revs->explicit_diff_merges)
 		die(_("'%s' cannot be used with 'git backfill'"),
 		    "--diff-merges");
-	if (revs->filter.choice)
-		die(_("'%s' cannot be used with 'git backfill'"),
-		    "--filter");
+	if (!path_walk_filter_compatible(&revs->filter))
+		die(_("cannot backfill with these filter options"));
 }
 
 static int do_backfill(struct backfill_context *ctx)
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 94f35ce190..ede89f8c33 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -15,6 +15,14 @@ test_expect_success 'backfill rejects unexpected arguments' '
 	test_grep "unrecognized argument: --unexpected-arg" err
 '
 
+test_expect_success 'backfill rejects incompatible filter options' '
+	test_must_fail git backfill --objects --filter=tree:1 2>err &&
+	test_grep "cannot backfill with these filter options" err &&
+
+	test_must_fail git backfill --objects --filter=blob:limit=10m 2>err &&
+	test_grep "cannot backfill with these filter options" err
+'
+
 # We create objects in the 'src' repo.
 test_expect_success 'setup repo for object creation' '
 	echo "{print \$1}" >print_1.awk &&
-- 
gitgitgadget

