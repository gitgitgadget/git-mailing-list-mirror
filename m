Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE220DD4B
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526868; cv=none; b=p7rAIXzv0AMd95L0vjRJ5PlMnP9y9AQ0T9IInZVSA4YC6DCUXCh+NNhKOetj1brc/rGxKRGn9diDynFNEYZgi29x+3PscJN/iIcrX+qBVuhHfHFWRQ4AP69rWssLnreRw3LVnDB4nAGZ5cXmj/QDuYiZxAxQz1jV8TudpOyaEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526868; c=relaxed/simple;
	bh=luKAgjPY1D9UCJAjiEQ7IQOM4N/O7PpZsdrd7JyrVrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fkceMzTBRiGTzEnbiY5OD2ahJ3qdpQbUl9bldu3DUOV3k98iIrujMaJHnripZR0FP6sMZ+bp3TjGfB/hnOiLCOYPp9XYv7BG5b/l+5e5ElHh1a1zdPpuL8vPJdCH+ruBATEN0HJSi6A1IcLLqYw8hiEX0Fdwk+abTpREQh4Dcy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO3Sdf2e; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO3Sdf2e"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so804956666b.3
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743526865; x=1744131665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZamY49KYIIQpna0pFjo1j5XN2zgcNiRu6ZUU8y1AfB8=;
        b=EO3Sdf2embxXz5GOTpEACYGnTxigq3xQ2fxEd4Fni8T9v6kEiH7aghUGwMgBxNF/xq
         3UuYq1v6kDpASrGJQOPHLPkjwMIaacBG6eZc8Zb7k0/mulyYxYT9U54DxRUiqYZJa52V
         wU9RbyEJ+pg8ZSTarcq9P6AZXnc69x30+P2guQKu6lij2SRwp8Qcs7y3RU0FcKOIUfgd
         UUQxa3rZlD/qw0uJDnskbWWjx6qu0DKnuZ3wZsJ3F39tQR3tnbw6MImPaJUmVkfHA/Xq
         n3gz5wLIUlJcVrsnSw5dXzaY6qyKSmsLdGzr0qkhdpfu4a1rm/d7Jc/dEisvzGTcsPkr
         ASnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526865; x=1744131665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZamY49KYIIQpna0pFjo1j5XN2zgcNiRu6ZUU8y1AfB8=;
        b=jWNhGhgyMMfdUXfbHLcBfS1JXqAmwj6T2fFC+WIGiNzlZBRTGOkzSbbBisFKKcrdDK
         KnhzIq1c8COsZzupG3RE7FlpWRem/jlW2BcGs3rZHNWbBbB/xoxmnCmlgvQYvwKVEia9
         obAv/0ZgBa476P4BgxA0b883Rr1i23GM9ANhfu4Bei0duyjQw7K2e35waw/ySDWx472H
         o/2x4/YCIvIJZtH/n5wCpOhTQ8F+/ZqIbC+N/eKNRp/TfRtV5Qk11cxqAHyJSC1wyXPI
         honep4gGuSlQg+D+WwL1OybeFbhALp/3u3wGe4i4kMHKEemoLgVFazm0JxdFlv1aF37K
         z+bQ==
X-Gm-Message-State: AOJu0YxefxGDFfYUACeIkMdEWZ9e642KSKWG4MdmOnWefcjyRv+Qa7It
	lIEQ2SpbgX6I1jVYN9sVEziJbhzZVtglIxjklYtmc2RRod4CfBPGOZ0tBTHY
X-Gm-Gg: ASbGncuMBnbvSZqD3ydimvTNuWoSwDgqTkuzYZXP4zNylzJOAcoPGtqWPyuJOZtWKze
	HkCrRncQ2hNrcAqoV6H7i0vWM9a1WpAUMdNScpKzmzflkW8Ej2kE5qaiTH1EEx54I1gBWIOy7X1
	mlDG24pj4wLa6Vn0S8tjUGYbMBYI1CGuGVrUVAPlLpBg0ZtcLY6k1oUO1cRkV3UQ1IjajM9ymGX
	lDiGF86U28syZnd/v+4QR0lXTqqpI4gCYGGMTJI9aFe1cxnnVycnlgLsnD2Zcq9RnzgU9ku6Dbl
	q23hunZ+RX4cgik2P/VXWMa/IQj+eIgXs3ZjURIBWnoa9qEb
X-Google-Smtp-Source: AGHT+IHGaxId/Rnmgv338VIK4QquQcgBViPaJErw0hK6Ilkc5l5KGSaR0FEVeZ6wh5QqzG+M4uujZw==
X-Received: by 2002:a17:907:9491:b0:ac6:b639:5a1c with SMTP id a640c23a62f3a-ac738a4bcedmr1247849666b.22.1743526864478;
        Tue, 01 Apr 2025 10:01:04 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:90eb:ce:1988:2fde])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196dd46asm780219666b.160.2025.04.01.10.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 10:01:04 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 01 Apr 2025 19:00:56 +0200
Subject: [PATCH 1/2] t6020: test for duplicate refnames in bundle creation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-1-6d23b2d96557@gmail.com>
References: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-0-6d23b2d96557@gmail.com>
In-Reply-To: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-0-6d23b2d96557@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3284; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=luKAgjPY1D9UCJAjiEQ7IQOM4N/O7PpZsdrd7JyrVrg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfsG83rwfbT33sm44CythHFiCK9MSuG5sC/E
 xGoM6ydn8o4eYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn7BvNAAoJED7VnySO
 Rox/zs4L/35FbBCkdrdZ5VyW2sxwuZLpW4DChGaBTUTFelxhOE+RtsN7hmZJXWL+xKPWUKJErIv
 vwzgc85Kd6aUrSaNEAuRTcunwcW0PJ4HZt+J+Xm0KHNDgA3tgAqjcJbjMdD7IR9aJ4+0LOFkF6s
 N5A8K3iLDL0ScrVBCo345gZUV6dVYU8cTaw/O0+YS+f0xQ2Nk18DOp3GGquiYRqyLcwhuRJXuOa
 DugLNryJJfCvtuAYbkCpQF4jeGoh7rwRH/kh990KrYwi7yXQsiZrbqEMNnh7IE3MvAFShWpEeIx
 lTKtoKwABRwJCYa8i+7fGIlght7jOgSfZPaDWwTuF2ImJ7piQkO/4BYMgWLFt6quT7e/oi9U2PA
 NP83CVQGT/t4ecomoE35toSi1IrRg41D+laUslAa4N5aywQ7Ub9DVeDgmLMeaevXBsQshOyckz6
 wJAJxUJuX3PUrCWlQuRwzfT88OlJMjEWI3sM0fMDeS0tgBePgY//IONQv1EA0GZ7epHNYcuh/L6
 zU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit b2a6d1c686 (bundle: allow the same ref to be given more than
once, 2009-01-17) added functionality to detect and remove duplicate
refnames from being added during bundle creation. This ensured that
clones created from such bundles wouldn't barf about duplicate refnames.

The following commit will add some optimizations to make this check
faster, but before doing that, it would be optimal to add tests to
capture the current behavior.

Add tests to capture duplicate refnames provided by the user during
bundle creation. This can be a combination of:

  - refnames directly provided by the user.
  - refname duplicate by using the '--all' flag alongside manual
    references being provided.
  - exclusion criteria provided via a refname "main^!".
  - short forms of refnames provided, "main" vs "refs/heads/main".

Note that currently duplicates due to usage of short and long forms goes
undetected. This should be fixed with the optimizations made in the next
commit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t6020-bundle-misc.sh | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index b3807e8f35..dd09df1287 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -673,6 +673,63 @@ test_expect_success 'bundle progress with --no-quiet' '
 	grep "%" err
 '
 
+test_expect_success 'create bundle with duplicate refnames' '
+	git bundle create out.bdl "main" "main" &&
+
+	git bundle list-heads out.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+# This exhibits a bug, since the same refname is now added to the bundle twice.
+test_expect_success 'create bundle with duplicate refnames and --all' '
+	git bundle create out.bdl --all "main" "main" &&
+
+	git bundle list-heads out.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	<COMMIT-N> refs/heads/release
+	<COMMIT-D> refs/heads/topic/1
+	<COMMIT-H> refs/heads/topic/2
+	<COMMIT-D> refs/pull/1/head
+	<COMMIT-G> refs/pull/2/head
+	<TAG-1> refs/tags/v1
+	<TAG-2> refs/tags/v2
+	<TAG-3> refs/tags/v3
+	<COMMIT-P> HEAD
+	<COMMIT-P> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'create bundle with duplicate exlusion refnames' '
+	git bundle create out.bdl "main" "main^!" &&
+
+	git bundle list-heads out.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+# This exhibits a bug, since the same refname is now added to the bundle twice.
+test_expect_success 'create bundle with duplicate refname short-form' '
+	git bundle create out.bdl "main" "main" "refs/heads/main" "refs/heads/main" &&
+
+	git bundle list-heads out.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	<COMMIT-P> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'read bundle over stdin' '
 	git bundle create some.bundle HEAD &&
 

-- 
2.48.1

