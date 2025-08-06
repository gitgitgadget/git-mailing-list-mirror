Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF422367DA
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522131; cv=none; b=LZRp+SjMx+9C+ZPu0G0ypcjM+2yyGxF/EX2/sXaHT2OCNCap4KUpO3KNOdEisirp9JfnkIMLaPFiGRflSGs0VXfyQSlxfofK+I2AHtdTYioXuq1v5HNfMmR0XRkSKjNdSDZA+ALu6ogON5zRf4EbxW99GAeKqiFm2aiWHTTMiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522131; c=relaxed/simple;
	bh=Tf32sVaxIDzVdZUY7mPXcJQzgd6hYTeC2kNs2UMktCM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u9bUt77HT025CtqjVNaVEwqLFtBehAClkmKpnx7SJSenZ3JcZMkcE8ieiEYH05GsrbfIZSHa07zdNMX7KI/lsrVkeypN6lhBzkEFspYj2fNks1gAVXRb75Pl4mQKPh9xX/c4WVuC6GvSnrRnNtCfhwfqEKAantqK2frpPxbdWLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxb2Hxm+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxb2Hxm+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so342238f8f.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754522128; x=1755126928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/e7m55WfemLgvnNLENovLKwJMzjaSgkaTMwaJoQ/zk=;
        b=Rxb2Hxm+pnmZVwHgZLSxbSzukCdLC3UtyH3EoqUaFZPZTG8oYQKSCTq4xpm2I5+PU+
         KNGsPl5OF2cYDf3lBbDc/p/nFzrOHWqutRSjF+UauFZUb3EmOPU3gWpLA+sLwb4wdZPD
         mzsCsIRXIBchpXmryz2bPg2xVP5B81+90yJz5STexsdFaTsyv3MCoFe84548rxSfyTZd
         ZTWY6bZ5TpAZyTJzCjvHUJ5FexbLXE0rFqXIcV0D7asD+gkbSK/sH2MKZ548uY3yL8oT
         HjoxsoFLQwcVkQVWr8ayUDVImvNmDOpaAnOVYMuLPEf8hIviI3Dy/TLwMuqIemspeboE
         svvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754522128; x=1755126928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/e7m55WfemLgvnNLENovLKwJMzjaSgkaTMwaJoQ/zk=;
        b=Js3sMikgMVqPiadadgVU8kkRN0T6dV2kDsFdCSYbG7zcA6i8cUNcz8F9EFET6lvVA3
         4HHJepPYltyzdOFNXt14oRrwq9I1SDTB1mOZSreDsXmmX+vwgqfOjvtecZnS01U7kP62
         7EXpRE6qsa4i2+FGTudI96R+N7yB6E9cfdSHs3o/eY0XV9mDSHj/KjBudIzQsYUQIeSr
         BpziDhSuED69m4olZkfAONsfiSBKGAYuI6P2S0TY7YkdF6a2CehuDoMxBkZwSBmmz4nH
         rsHcWbSCmOX17GE6bWHp3QjQTfpvo+on+RQgcoYEN28z3VItoyhIEEOQNBQdDWb/lBpR
         rCbQ==
X-Gm-Message-State: AOJu0Yy5DvywP6sGTkBux4ZsjL997J79sAMRQfQlB5Is0wQAIIAdRegn
	EzHNRTaTNBscwKP+2ldle/kw9DraCB2YKHCJaASUaYxi4DXPg8D4ZEo31pIFuA==
X-Gm-Gg: ASbGncvCPQx+5Fu0YvEryUUwTBEm+wmo5abNERH7UIye+3M8GWD3AeYGgKXuoJZzfhq
	KZUX5D96XlF1TQU5KPjeprj+HULABhAKqekcPTgo+4g9/8umeQD7OMLx9nWP9suE+mgyZ5zxEzA
	g6Y+vrw6kV0j4l20jiHdj+l+5hWsPNw6uQd4TMSFT1FvJ2BQmbcIlsuxSliB4oHdroz891YvhSf
	f4K8kkdpQMYOrXB+avt5VdxhQ3L/iMySmxP9pIKfq8/E7Z9HT+t+rA1Wlr8iLjodGP0k4AdcDsc
	8Ddizw0kJGg2PWBx134sNBdjCMOO56L92TXaHPDjeYbKmuor/nnrUTPzzWbpjCfZ+ihDbwDBCg6
	Se7KPU8BuDbyhFqmZ2tZTwlw=
X-Google-Smtp-Source: AGHT+IF4WJcQEITJuIg0ACzwZI62Zg2UwAnBZ/sLVKzAfsFaBvFKobMB4xLMEwkFjZzmATV/kgF+KQ==
X-Received: by 2002:a05:6000:2308:b0:3b7:6828:5f71 with SMTP id ffacd0b85a97d-3b8f415995emr3538925f8f.9.1754522127644;
        Wed, 06 Aug 2025 16:15:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9160sm24655682f8f.21.2025.08.06.16.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:15:27 -0700 (PDT)
Message-Id: <29b5e00c556a3d39fb9ca57bf3903f43280def5d.1754522123.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
References: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
	<pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Aug 2025 23:15:19 +0000
Subject: [PATCH v3 4/7] t6423: fix missed staging of file in testcases
 12i,12j,12k
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Commit 806f83287f8d (t6423: test directory renames causing
rename-to-self, 2021-06-30) introduced testcase 12i-12k but omitted
staging one of the files and copy-pasted that mistake to the other
tests.  This means the merge runs with an unstaged change, even though
that isn't related to what is being tested and makes the test look more
complicated than it is.

The cover letter for the series associated with the above commit (see
Message-ID: pull.1039.git.git.1624727121.gitgitgadget@gmail.com) noted
that these testcases triggered two bugs in merge-recursive but only one
in merge-ort; in merge-recursive these testcases also triggered a
silent deletion of the file in question when it shouldn't be deleted.
What I didn't realize at the time was that the deletion bug in merge-ort
was merely being sidestepped by the "relevant renames" optimization but
can actually be triggered.  A subsequent commit will deal with that
additional bug, but it was complicated by the mistaken forgotten
staging, so this commit first fixes that issue.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 2def1522bd59..e1251b4e12ce 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4747,6 +4747,7 @@ test_setup_12i () {
 		git switch B &&
 		git mv source/bar source/subdir/bar &&
 		echo more baz >>source/baz &&
+		git add source/baz &&
 		git commit -m B
 	)
 }
@@ -4771,7 +4772,7 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
 		UU source/bar
-		 M source/baz
+		M  source/baz
 		EOF
 		test_cmp expect actual
 	)
@@ -4806,6 +4807,7 @@ test_setup_12j () {
 		git switch B &&
 		git mv bar subdir/bar &&
 		echo more baz >>baz &&
+		git add baz &&
 		git commit -m B
 	)
 }
@@ -4830,7 +4832,7 @@ test_expect_success '12j: Directory rename to root causes rename-to-self' '
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
 		UU bar
-		 M baz
+		M  baz
 		EOF
 		test_cmp expect actual
 	)
@@ -4865,6 +4867,7 @@ test_setup_12k () {
 		git switch B &&
 		git mv dirA/bar dirB/bar &&
 		echo more baz >>dirA/baz &&
+		git add dirA/baz &&
 		git commit -m B
 	)
 }
@@ -4889,7 +4892,7 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
 		UU dirA/bar
-		 M dirA/baz
+		M  dirA/baz
 		EOF
 		test_cmp expect actual
 	)
-- 
gitgitgadget

