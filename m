Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36149B461
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390947; cv=none; b=eOYodpYI0fEAxeHG9KrS0s792JF4P6/6SLPlgxLi7bs+CDMfrjrhpA7olf6ilI92/1SLeqYPcfUY9gO4FHR/2QwwpD3CpkoOdfIBQg9zAi1tKjbC9t16ZCZSpLesrmBCZJm6mglm6b2W+a4WAq0c9IHVYxNF9UX7C3yfXP+hU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390947; c=relaxed/simple;
	bh=gS255VSchS1W1ZxiVtwlod8DizWz2V7VbjN4GSzUgMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbkhJJ/fzOW7M5R4FPmxYa7VZlpKkR9atpUXngBU1WhyPU9B0Y3KF0KaK5Z9sm9CgztfE/aNaabwlL56CGHP7FaWHNfwWFU3JfHOUWZaibXolttahAjDqtsKVlvv2KtbVNupi1TZXxMEyEMrBb/ERadCtu6+KQv7ImplfG8k1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtXsfQOs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtXsfQOs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e623eda81cso3240915ad.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791390946; x=1791995746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/sMoQX/1/L5YfoHH7Cysdn9Tlht6cEySLZp9lC30rx0=;
        b=UtXsfQOs+dm+CWR2X+mryvJ+t8d3wdz2h0TSqaSVWAAUbyzaS0ykuuAdtqr2LPcB4G
         J00WPHaQtP5DD2+k3P8ZqHQRcFrbPAwDdDO35nU6buMqdHSNutJ/rxFT81bEFLKEdmOE
         pSQqyPoP8dGpG/BY3KnN5eRXN4pCRvXwNHQVWcBNjdThVE/Ju4dR7s+p6AYJsPNQsMR1
         i2jy2e37Qz0Qh704+xQO1xctIO6m3rb8GghKgWQ3L4dSaa+VuZfQiYIiRif1HtD2qhlK
         0QYlv71p6zz/8eanT7QnYOx3lkAtbEqzshjB3TZViBbZrbCw5zpgJDGhe8SipueR04RN
         nhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791390946; x=1791995746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sMoQX/1/L5YfoHH7Cysdn9Tlht6cEySLZp9lC30rx0=;
        b=JqZ8qXjonzBIEVDxKbIW6PwIO9g9fQFU6Xc0/FpUgU/IkwQ6lOLmmmbzATO55atTMX
         eeWcj3KJV8s8my6unvW7A7fe+i43Pjh3fDgapwmCyATfSHtIVPgatc0Pl1h8r/csv6LP
         Xeb1M3+eydFFGVtooqoME2YUWitwd/sE1yMtHTCqK97IfFS2JfMW40/30D7HEai/qhyg
         nwj6gYbWPLfpWJvjRHA8Vj6ro3T0hPOg5doJAxiBjG7zIuZvR8mVyuLwgk31G0EJvdQt
         S5VbAu0kUt+7eVbu9vob2/aNr48XudRHWrWtFR0bHko+SJ09TJ0coh4uuxhEDALIDy/I
         O7BQ==
X-Gm-Message-State: AFq9FYKk7XmdKkue0foUGV4+x+necJbeR0GYi7aje9FothOUL036TajX
	0gnM/BUSW0rdQJ+VSx4G9QA47LD3vErSY/dYQ0HN8ZXQmbVDhq1U8ojWfXAwhTI2tbE=
X-Gm-Gg: AYBFou1hatyp1O3BzftPyz71GTznQTJJOKG+fnG1Nm7YBvjMf5uz3fFaoINtNLUSjTU
	oOhchxWv2Z0UC97j2FEyVYMeOay62aRvLYk30LJSXvL6McAlD3xvTcliOoQwyxafRgnrqq8CLt7
	uyf1eEYUxoANWkGFHuHaKXmS/hpJHrr9mmxPDZnO5kXPv11BAzP8j0JDLmEAXFppBcrK+1Yo6Go
	qV/zwk1clLru/l7U7hmrLVD9zYISfstM9nCu/q0uu2yx/J7gOXqnQwKi46Mp7NOFYYWUBpSduIW
	pvGwIobFlVnc6IV9I4PqhvbMUu+h2wSNgv7MuBI8ivPFkjwhZ69nai6rYHaLVoh4E+XZANsBCtr
	oKjCpKw7qU0p1Em0hd7aLeLPVyf2Tl9a0ttYUBUSseJsMYLF+emg70JaiDQj0x38mnwZqzqE9Gl
	CuCKrK6tqx4y5rMo2tepnNfh0JegvS9J9sgawaR6dyLfG52AE4UYPf9ox5vGVYWteQDlCDasx8Z
	7ib2Rc=
X-Received: by 2002:a17:902:e5c2:b0:2dd:c0ff:e726 with SMTP id d9443c01a7336-2e600542f85mr22739435ad.56.1791390945730;
        Wed, 07 Oct 2026 09:35:45 -0700 (PDT)
Received: from archlinux ([2409:40f4:314a:a1e2:9855:ada9:1db7:a1fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604948613sm14826555ad.63.2026.10.07.09.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:35:45 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v2 2/2] combine-diff: filter the fast scan by the relative prefix
Date: Wed,  7 Oct 2026 22:05:14 +0530
Message-ID: <dbc32586d8ee3b41bb28cd9f6e838658b2206880.1791390459.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791390459.git.dilsheddilu123@gmail.com>
References: <xmqqld89bmd1.fsf@gitster.g> <cover.1791390459.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pairwise scan filters paths by --relative before looking for renames.
The fast scan bypasses those callbacks, so it can show changes outside
the requested prefix.

Filter the fast scan's paths by the same literal prefix and release the
discarded records. Add tests for excluding outside paths and for keeping
explicit prefixes with repeated separators literal, as ordinary diff
does.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 combine-diff.c           | 18 ++++++++++++++++++
 t/t4038-diff-combined.sh | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/combine-diff.c b/combine-diff.c
index d615471717..e8a3bd1ee9 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1474,6 +1474,24 @@ static struct combine_diff_path *find_paths_multitree(
 
 	strbuf_release(&base);
 	free(parents_oid);
+
+	/* Match the prefix filtering used by the pairwise scan. */
+	if (opt->prefix) {
+		struct combine_diff_path **tail = &paths;
+
+		while (*tail) {
+			struct combine_diff_path *p = *tail;
+
+			if (starts_with(p->path, opt->prefix)) {
+				tail = &p->next;
+				continue;
+			}
+			*tail = p->next;
+			for (i = 0; i < nparent; i++)
+				free(p->parent[i].path);
+			free(p);
+		}
+	}
 	return paths;
 }
 
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 21eeb4fbcb..50df3dfb46 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -652,4 +652,25 @@ test_expect_success 'combined raw relative diff follows an outside rename source
 	test_cmp expect actual
 '
 
+test_expect_success 'fast combined relative diff excludes outside paths' '
+	ours_oid=$(git -C cross-prefix rev-parse HEAD^:here/file) &&
+	merged_oid=$(git -C cross-prefix rev-parse HEAD:here/file) &&
+	printf "::100644 000000 100644 %s %s %s MA\tfile\tfile\tfile\n" \
+		"$ours_oid" "$ZERO_OID" "$merged_oid" >expect &&
+	git -C cross-prefix diff-tree --no-commit-id -c --raw --no-renames \
+		--combined-all-paths --relative=here/ HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'combined diff keeps explicit relative prefixes literal' '
+	git -C cross-prefix diff HEAD^ HEAD --relative=here// >actual &&
+	test_must_be_empty actual &&
+	git -C cross-prefix diff-tree --no-commit-id --cc -M \
+		--combined-all-paths --relative=here// HEAD >actual &&
+	test_must_be_empty actual &&
+	git -C cross-prefix diff-tree --no-commit-id --cc --no-renames \
+		--combined-all-paths --relative=here// HEAD >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
2.55.0

