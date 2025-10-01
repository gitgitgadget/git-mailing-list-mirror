Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3061BDCF
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321056; cv=none; b=MuBqiDeinJzCue45yJL5TTW6GykCYhoCbwUKSJks/hNV+Nbph9ZBgy6C+XfSGM4Iwwu2WQ9qbtY8E+ICzjA9tP2kthxEp+tqRujHvFGMKOXKSD8N3LFPBBwFDFhxG90KdahDERcEwl95AQh75NwG4OrXuOJvpiXGaU+pXsk0X58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321056; c=relaxed/simple;
	bh=NuUaHSjGpcjTUgd2AvqnVXZSAwjr51IddnQcJ/EthkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=Lqo0wbcjTmQB2f1tLFaZ98oBL6ZncdegyyhEGDdZ+ABqyueyCPn8lyYbrkLSautVM1VDcnGZyVrFw+6Rvdj2QwKSgHxNxDiOa8TIjijw2XOvbusF2ZUoIYhVc5DllbEwxoPQhqDkpcCGmno8yQwkkrMRSnVlv/uEnhBT4CoCvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYTlmMCf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYTlmMCf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e5980471eso14510845e9.2
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759321053; x=1759925853; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRRF6P0HlxXRYAHwGirXPAUwUgM8kKQzQz4ZqFkxzeA=;
        b=eYTlmMCfXcpEP8nYLOCufP+m/M15HcpvyBxXlU+jggppR273fo1LibH+AnTTEJjqjd
         rMHkP0iLVTkH+mkcbSI+cgpMYWxkWIQXLVssunyFZEG0ZbVSttq/DNsUxfLXXj32+7Uq
         YDLYaID8NSnaWA8SWjefvgpIBP5x2EleVaCEUe/KNO8Y65mCFZ5UYwFjuEpwgiMKEx11
         qh5PQly13W949T9V3YZ+Yop04kwEzoIB0gRDpUZ5Z5sA3QmIHFSdnkNow73PmmWAd9wg
         3f/N/Xz7hSi94E1Ck5dan/ibYTzcvTLxRAT3aXw+ofLKJEfK21anf3VmNn07BPIFDPYK
         onBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759321053; x=1759925853;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRRF6P0HlxXRYAHwGirXPAUwUgM8kKQzQz4ZqFkxzeA=;
        b=rTCzfKaQSImFhVsWyHbh/B6VGgGxPaOi7WYvxFR3o7AMUN0YeC91IrILTESrmP32aw
         JX7hTkSm6ETispStBx0m0x+bEiGo9l4rwuPzXc0vhhypMoFBt2TWEfRN38DJWd061pg4
         9oM7yyqMKR6QTyLUiyjasbYCjQMGzh+3/Pxb338lU8QtZJYI/lYMF58iPeW85UNZD96C
         0DVvbPGW1MHc71IM+G8+fhylOOYlPdZ+kyyQ+qOJNRYAzJABS0VyVBS5d/vm/K+9LLqs
         jf+lYGynjNqlURQR4f7SsrgX8oZiT4ox1lVL3OjQ/ZLzUaPYh5OgLmlecID1OkGMoTGI
         RRmA==
X-Gm-Message-State: AOJu0Yw5F6TnEyN6+2Wv3VRKhoJ1+C5QN1+/X0zbegK/UdRqb04vIPdT
	/9bC5poZUpNsyT4F5bvK7DuRoR5UxLv9bSapZ354ria+FY2UV/omecK4
X-Gm-Gg: ASbGnctUP+MuDhG4eD+seEc59Bb22LYM8c9OvhSh1pwCyYGoX517ejdxly8myw/ZBOv
	iU/YiSlInAvR2DvC+zXIIDJi1+Ymz+dg/DKNMyweH6GpvSbG75aJO048lw/Gdr3D6C9H5h2Y1a3
	h+GlCyWZmtoeFbcIEgEIcQE25lJPhJMVsNd5xsnbECBQ6WbZasiMOEiS3nJLWhaImrZ+Vm2ayHm
	/H76woY8eKkyDL104TMu0WliDutWjkBAq7RnO/WRqN9txE4jfzmhJXDMTg8IPgIHmGwN6tzG0m/
	Iqs9VtOpvRYDPy6GDTCDw04C79PtUdAJOW1hbjjR3N7mHLApOv77sLR4upflNXZ1sod3cDGVEBN
	Ah1czhAlqjINnlKWb2NrO/40wEv84qxHmodEXF0KeAgDVzlIF
X-Google-Smtp-Source: AGHT+IFBVn1cLJYMfkgkpl1hC67/+EuthjfvR51511JYr1rKpC2nE9VwN6FLDuy0W2Yz0WiIWF7UuQ==
X-Received: by 2002:a05:6000:1a8e:b0:402:a740:1edd with SMTP id ffacd0b85a97d-42557816de4mr2870115f8f.39.1759321053142;
        Wed, 01 Oct 2025 05:17:33 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.216.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc6de90f9sm27138533f8f.48.2025.10.01.05.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:17:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 01 Oct 2025 14:17:29 +0200
Subject: [PATCH v3] refs/ref-cache: fix SEGFAULT when seeking in empty
 directories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-583-git-for-each-ref-start-after-v3-1-000f03837a92@gmail.com>
X-B4-Tracking: v=1; b=H4sIANgb3WgC/43QwW7DIAwG4FepOM9TgJKQnvYeUw/gmASthQkYa
 lXl3UeqHaJdtuNvWd8v+8EyJU+ZnQ4Plqj67GNoQb4cGC4mzAR+apmJTqhu5BqUljD7Ai4mIIM
 LJHKQi0kFjCuUwFkz2NGpUWvBGvPZFvztWfF+bnnxucR0fzZWvk1/cHH8G68cOOAgLQmrJqvM2
 3w1/vKK8co2vIo9qP4BigbKnstmicE5/huUe7AHIfRmFGMv7TWhpDh9IQHGkNtdFPAOuBB+ZKh
 H6ADH3k1aKY7dtJfXdf0G83sW+HsBAAA=
X-Change-ID: 20250918-583-git-for-each-ref-start-after-fba7b9f59882
In-Reply-To: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
References: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3873; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NuUaHSjGpcjTUgd2AvqnVXZSAwjr51IddnQcJ/EthkM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjdG9w/SxHW0eoMHZysy32eudYjqRi3em8b8
 uyAY/r5ujEtEIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo3RvcAAoJED7VnySO
 Rox/jaMMAJIqkZxzAvBDMYcFV1M/1wA/dU+yYIN9GZGAM6RQrP2TdaxYXZo0yhYCQqAniTaVk8e
 5xpu1Ei/LJxctSjiJ26cawlrTI7WYumewoNo8usgY0tfNadqZsvkPcJhDW9qiXqMjaS8bygri0/
 auIbYjsT1u1uXP5wxg+fXQXU/Qu/Wx9Joh6lHqrh9h+0kEI70e+AZvRuPfEit2nBsYimuCU1Kit
 PCTiI0Ltdn0OSDtfiT/fn0dg4ciIf0GcWrTVl4xKwlewim8+TwhQ2jNIBg9NBxvCz6seL4ZXOlR
 Xmwu0CwS54iaV3BgKq1jpedfH2AVC394VbwluteiwxSIFGV2uL4A/KTcmt6coC13v4JvjPbyYXv
 hjr9EVXjxJf6AUeyRj77F4nXm7Wz1aB45J8PET2Mb/aKxGDmQafrBkOnY/wUol1scmTS/75R1NQ
 O0S1MU2VAvKG+1VzfpzkKfhsnlWpS6LUIDfT2/TcV9lGEE6w0P0VprNLgpsmbaIHLzegx2IhiO5
 WU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'cache_ref_iterator_seek()' function is used to seek the
`ref_iterator` to the desired reference in the ref-cache mechanism. We
use the seeking functionality to implement the '--start-after' flag in
'git-for-each-ref(1)'.

When using the files-backend with packed-refs, it is possible that some
of the refs directories are empty. For e.g. just after repacking, the
'refs/heads' directory would be empty. The ref-cache seek mechanism,
doesn't take this into consideration when descending into a
subdirectory, and makes an out of bounds access, causing SEGFAULT as we
try to access entries within the directory. Fix this by breaking out of
the loop when we enter an empty directory.

Since we start with the base directory of 'refs/' which is never empty,
it is okay to perform this check after the first iteration in the
`do..while` clause.

Add tests which simulate this behavior and also provide coverage over
using the feature over packed-refs.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v3:
- Modify the commit message to also explain why it is safe to add the
  check for empty directories in a `do..while` clause.
- Link to v2: https://lore.kernel.org/r/20250925-583-git-for-each-ref-start-after-v2-1-3613b5a27ff1@gmail.com

Changes in v2:
- Moved the `dir-nr` check to the loop to provide better bound checks.
- Modified the commit subject to talk about the issue at hand.
- Substituted EOF with \EOF since we don't do any variable parsing.
- Link to v1: https://lore.kernel.org/r/20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com
---
 refs/ref-cache.c               |  2 +-
 t/t6302-for-each-ref-filter.sh | 65 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index c180e0aad7..e5e5df16d8 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -539,7 +539,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 				 */
 				break;
 			}
-		} while (slash);
+		} while (slash && dir->nr);
 	}
 
 	return 0;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 9b80ea1e3b..7f060d97bf 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -754,4 +754,69 @@ test_expect_success 'start after used with custom sort order' '
 	test_cmp expect actual
 '
 
+test_expect_success 'start after with packed refs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		git update-ref --stdin <<-\EOF &&
+		create refs/heads/branch @
+		create refs/heads/side @
+		create refs/odd/spot @
+		create refs/tags/one @
+		create refs/tags/two @
+		commit
+		EOF
+
+		cat >expect <<-\EOF &&
+		refs/tags/default
+		refs/tags/one
+		refs/tags/two
+		EOF
+
+		git pack-refs --all &&
+		git for-each-ref --format="%(refname)" --start-after=refs/odd/spot >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'start after with packed refs and some loose refs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		git update-ref --stdin <<-\EOF &&
+		create refs/heads/branch @
+		create refs/heads/side @
+		create refs/odd/spot @
+		create refs/tags/one @
+		create refs/tags/two @
+		commit
+		EOF
+
+		git pack-refs --all &&
+
+		git update-ref --stdin <<-\EOF &&
+		create refs/heads/foo @
+		create refs/odd/tee @
+		commit
+		EOF
+
+		cat >expect <<-\EOF &&
+		refs/odd/tee
+		refs/tags/default
+		refs/tags/one
+		refs/tags/two
+		EOF
+
+
+		git for-each-ref --format="%(refname)" --start-after=refs/odd/spot >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done



