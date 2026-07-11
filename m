Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AF3C5836
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776481; cv=none; b=LI6SjEURCbq8T5Cm8DetKIRu3BD4CCQ1ERy2OLIeZEeD2jqdUqlqAn7vv+mObliRBihILw2mn5aFJJH9QqUVe083fdBQzdto6jjFOY7CDAHJ13e7O/InLrj9OQXmqREEsTx895Ehofx+sn239m06xSPgK27wZhxnY9xpdwcOBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776481; c=relaxed/simple;
	bh=DSho0eZDymbgbgTau2vrqaXmIE8WHvceCVsKEf7gFyw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RCLvgjlu6GQguClJ3lBFlMkcQgiy1T/K7WPdw1wBNz6+6JHLu5JQfcUo97lPlrSakUCay7AZQqgInzgIB0w5RgwPF1ai5/O9djHVYcFyJqW+J/Dsu+sRM/P04qDp4CbnA1hIJYAArz0mrSSzWEC0F/O3DAlJwsYP1ZrJF32W1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9b+XENX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9b+XENX"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso2441232a91.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776480; x=1784381280; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CVenBqXm686IFtz47gDc7myd2vA2Cfx7WnCIPhcwAn0=;
        b=U9b+XENXPAwbWY5u+D7PNcKkTmyRvFzxKYG3aWeIbTmfEZfZCTsQZEhmvmebiVmOcP
         9/jL2XWOTOJ6kZhDIw4p1EHB+OWvVJ6gmVj+XefGLMNWvZwQjWntaHxFSOnmC8nqJqDB
         n6dpiT0rX2HjOCUSWRjHFKv1PwJkaF8Kk7NVA0f1Z2sy6vIwvc5M85pJv6uhpwY9DMjO
         GKYwSu0a7ViMebwqNz72ElDJRNBOUBn0k0+esY5p4T4oHo8VoMwQk0uz1U/KwJdvIf+j
         HIZuDUSg7kmLumY417mbfNNPM4c6ptkzKNxmm2sumJbbJVBH1cSPDByMKZTHZwlsFC9v
         mmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776480; x=1784381280;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CVenBqXm686IFtz47gDc7myd2vA2Cfx7WnCIPhcwAn0=;
        b=NyYlckXCtEYHAmToF36u3qcNg/AHe2WPey/mU+qx6Uweq5LbX1xHLj5+uXpAiDnPxB
         p7wYRHjpbjUPRfSnqJ9ueYJ4Q66ADV6//dF+Nr1lgWgTqY03pSu25yOtvJqQtEH+uciZ
         iV+yReHGsUlW8ijjMBeiCsH+sEIMaNzBzHai5YAlhSe0jRycY7ViIC/qBbhhw2qynbs5
         Ee7V2Tx27rnY4LTkfzSQr7GsVVyirYB2dyCnjSqgwBY9wjyS72agxKXumNS6b9f6XHrE
         O9Kbas29aO5IcKcltAR85JK810rNrsX3p/Hcw8hctw59DAAVAVzRUB9XmX/5diViVb+s
         ZSUA==
X-Gm-Message-State: AOJu0YxHNNr9fZNw4TZDa68VwfcGnRX1SUcOY4+fEv1vA/BTBkNdNoLu
	jFA0t9hYgSYZA9CA1TCU7dC7vXEl9zgC5/i6AH6NtkrZMWy4ZA7UjSZtL//Uyg==
X-Gm-Gg: AfdE7clU681XLbpyhnVj8F0HX+QLliy+TijNEkJlg2l4ZpX/r9NHptWD198kMqlv0qi
	oYhqxcZphuU3Uf6pO+jN24cj/6QdXemybBqlmeKvUZP9sTITO7mn9SX0Bt/BjMiW2solxAsZDc2
	sgnk5k85FAD1iI87amSuMT/ufsCcUXycaSQRUPichpWJRcCLXznBM2XuBzaoQCSa1/H3cMh62rQ
	A6ANFPfvdPKhmiPOpLxH3/kn09nJjCn8yqYHkJDKZF+jXU8IVxRXwSv6YQvOtFZY57IhIyTUEgD
	qUnzbvY/+UnN04N/vaLjJW+8ucrvomyBQ2ubQE+zGoferGb2s+XskIkWIHfKKYoH9UHosOwFTtx
	gkfY5Gp9ZvFakCZjSwvBSkZ349bfvkjUGgvDHXxIUpdrohqOiObOPRCa9DCdDrHjAY3SaGwqcbZ
	zEel6X9VpO/gLrmG32cwe0ExZlPg==
X-Received: by 2002:a17:90b:540d:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-38dc7752969mr2917010a91.30.1783776479762;
        Sat, 11 Jul 2026 06:27:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm55814223eec.31.2026.07.11.06.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:27:58 -0700 (PDT)
Message-Id: <9e76f5fb62ebcac1eec1318044af4b11ad517831.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:40 +0000
Subject: [PATCH v6 05/10] commit-reach: add trace2 instrumentation to
 paint_down_to_common()
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add a step counter and trace2_data_intmax() call so that the number
of commits visited during the paint walk is observable via
GIT_TRACE2_EVENT. This provides a way to measure the impact of
future optimizations without relying on wall-clock benchmarks alone.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c        |  5 +++++
 t/t6600-test-reach.sh | 44 ++++++++++++++++++++++++++++++-------------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 778e11f5d3..ee1632d724 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 #include "commit-reach.h"
 #include "ewah/ewok.h"
+#include "trace2.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -113,6 +114,7 @@ static int paint_down_to_common(struct repository *r,
 	};
 	int i;
 	int gen_ordered = 1;
+	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
@@ -138,6 +140,7 @@ static int paint_down_to_common(struct repository *r,
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
+		steps++;
 
 		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
@@ -194,6 +197,8 @@ static int paint_down_to_common(struct repository *r,
 	}
 
 	clear_nonstale_queue(&queue);
+	trace2_data_intmax("paint_down_to_common", r,
+			   "steps", steps);
 	commit_list_sort_by_date(result);
 	return 0;
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 698b831a6e..45aa26cd44 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -153,24 +153,34 @@ test_expect_success 'setup' '
 '
 
 run_all_modes () {
-	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-full .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-half .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual
+	graph=.git/objects/info/commit-graph &&
+	test_when_finished rm -rf "$graph" "${graph}s" &&
+	rm -f trace-mode-*.txt &&
+
+	for mode in none full half no-gdat
+	do
+		rm -rf "$graph" "${graph}s" &&
+		cp "commit-graph-${mode}" "$graph" 2>/dev/null ||
+		true &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-mode-${mode}.txt" \
+			"$@" <input >actual &&
+		test_cmp expect actual || return 1
+	done
 }
 
 test_all_modes () {
 	run_all_modes test-tool reach "$@"
 }
 
+test_paint_down_steps () {
+	for mode in none full half no-gdat
+	do
+		test_trace2_data_singular paint_down_to_common steps "$1" \
+			"mode=$mode" <"trace-mode-${mode}.txt" || return 1
+		shift
+	done
+}
+
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
@@ -244,7 +254,8 @@ test_expect_success 'in_merge_bases_many:self' '
 	X:commit-6-8
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
-	test_all_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many &&
+	test_paint_down_steps 45 2 25 3
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -329,6 +340,13 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'merge-base --all commit-walk steps' '
+	>input &&
+	git rev-parse commit-9-1 >expect &&
+	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
+	test_paint_down_steps 81 80 81 81
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

