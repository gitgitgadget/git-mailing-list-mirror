Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C527B32B
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791715; cv=none; b=WBUU3Ky8qMiXns8BMpjDVpjghOtaDbvCsxw5XBUH6NHomiPOT0dL1ps65fBhFMmpD6iQ15LhPg4RyatS8XwKLBLpB/BN9To2Ms3YWlDAOh0lRysHD8uRToqGB6CZaWESZCXkX8xWnvmecStgh81QZ0Q3cWBwdjDDvS6py78OamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791715; c=relaxed/simple;
	bh=HdfexyK8ZS6gCWsX9ZH3Gl+z8EwVDTKmBWGjsfp2rug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=Hq+jRP2URLMDFJxesCEH2uR8l1QVZx5LNNogANBSVzP+0TLhP2XOt5x3bM7Aq9VbpA9CY5TeLuZpqp41SEOAKEbuhglHKvuUEsmJBLyb3LbK5pzmHYzn8KN3MO7iZCucQZp4KykjpuSGGjN8rpgRLC+vRpgWeR9ebIQAggxy8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5iG0Mzt; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5iG0Mzt"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3164978f11so132394366b.3
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758791712; x=1759396512; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJs4zjK1mcEGSVsCuQn2JOsaEpDC7SGpQl1Pion9fco=;
        b=B5iG0MztRBxDBTcUb5Q97kMqW3727p8OXgmaMAXEQvnHfKGrOTrMydVabkIZT1nj95
         bPN/izsp4c1mB4Dd/gzFIrkKpnLMVNXxJo/muUdK6DN3vxMQbC5r9XpFHzWynumSg2uf
         i0eHWKEFRlVSyd8Et5B3xdgEqByD1WegiChDq4/LUFtVKizoBn3szeiEf82RkbWalHzs
         J7J6JXeGabSFsnN/x8ExfqjwfRnco+YYgaco08Qe8rV47dSOATz2RoovDdnmnBhxNY0q
         3VgL78W4v/xzXDnKuXvduOXlMAdvmWzJdkdWmR1m9s68KtupwA4pKsHueReFaBmERTUA
         iwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758791712; x=1759396512;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJs4zjK1mcEGSVsCuQn2JOsaEpDC7SGpQl1Pion9fco=;
        b=EfMAuOmRblVDQVqa4nt5b0OYoJnGzfCWJf6w6bbrOLCg97kqSHFKFvC+40LpKtMElg
         GW2BmBa/pZFQarDs0S8t2INlEwGPgCAHjkzJicytNZKr0ufe1baqd6WuWWtMkJsvhSLC
         gXHcNzBf6bj6d/jn+90AOSwTwWsxBCVN7y2Bqa5+9AFMMzUDl9R+5Atd2PF5OCB8Ubwe
         JgfXQoxH+iaOdGvYNguJXdNkDZkHKjKZwFeE1X9a9BAG3qjsG/L4mJ1yoGu0olOJaEIQ
         wSj/Yfb4+rbBSbsJzi3carIDYciaWJLLcqTUjpra487HS1MIaD7Yv7Jcn4Tv5TK95xoD
         YxgQ==
X-Gm-Message-State: AOJu0Yx68gb3ZI8QEJjH9t7rbX9URc03M1HZOfqaYf6A20j3wEyt6b3y
	jmcjxpgboebzSk/tDOrePP6SYR7RTiXZrYdZMQdm88jZ9d4sTcW0V61E
X-Gm-Gg: ASbGncspoEndjTu4ufVIUJrmT6kbdxASh5ZUrdiRnEF6wyVaZEPuAevzGFrJtBsYLRQ
	egMDfmOzkhZolgVt7HqUwMHoDwH46EItqltnir6r8y2qPkafZxEWGAxUynJLOpirHuxhMlzVnHm
	HMEvCNi6o0TN51luZ1f3TUWhE7Srq/PqNKjRJ/g7RXxz2Ss3A+bbJ4BSng6N81kklOtf+qNS6gl
	HDl35g0e6drTCFTIU1vSOrTCrftwNoeN1i8lnLL8DhvP0McDwJEsfGlziFevkoUiJzu6oMV//3v
	mGjOFVFJopjJof28MIXCQzWDP6ORkbiSb5GhfZL20kZEcdgPUgCP/swrkJj0eVFltf2Kg3B6cbs
	NP8jTCvuFYNGOwq0V8pJPYAU+XUE=
X-Google-Smtp-Source: AGHT+IExMziBroHBf5Xx14kROfXw5a9PN73riPttgKtva2c6Tbn3DObVNAxuwdAnIOJmPGIxKSr4Zw==
X-Received: by 2002:a17:906:c143:b0:b23:32d9:d025 with SMTP id a640c23a62f3a-b34ba450e42mr289673966b.30.1758791711315;
        Thu, 25 Sep 2025 02:15:11 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:cc13:30ef:64a:ce69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7806sm129013666b.70.2025.09.25.02.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:15:10 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 25 Sep 2025 11:15:07 +0200
Subject: [PATCH v2] refs/ref-cache: fix SEGFAULT when seeking in empty
 directories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-583-git-for-each-ref-start-after-v2-1-3613b5a27ff1@gmail.com>
X-B4-Tracking: v=1; b=H4sIABoI1WgC/4WNQQ6CMBBFr0K6dgwtNhRX3sOwaMsUJhFqpg3RE
 O5uJe5dvp+f9zaRkAmTuFabYFwpUVwKqFMl/GSXEYGGwkLVStedNKBNAyNlCJEBrZ+AMUDKljP
 YkJEhONu6LujOGCWK5lkO9DoS977wRClHfh/FVX7Xn1xd/stXCRJ82zhUTg9O29s4W3qcfZxFv
 +/7B+Ws7OzQAAAA
X-Change-ID: 20250918-583-git-for-each-ref-start-after-fba7b9f59882
In-Reply-To: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
References: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3334; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=HdfexyK8ZS6gCWsX9ZH3Gl+z8EwVDTKmBWGjsfp2rug=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjVCB4zuilVjp/rGJD66Li5zSSUsN57PP0v7
 WexoTClXPCsLIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo1QgeAAoJED7VnySO
 Rox/V9UMAIvvBctqrjE9FwH1voeP+2i2Qs/gq3fLlOhJMaFGwt4wnVOyBS1K5UpzWMyEcGKrxwl
 aW8Omp2a8TfrarmvfU9OPWULX2c2jIiU8bN9B1MirhD9MAnzsZbJmGd+T366FU6wSw2WevneyV2
 1KUiKhJiaLvcXI/+JjE5eq9jEbtvDJ1KNvutoC8ZU8WyowNOveB4IOGXEjt41KpK4uliVRFKpyh
 qpU/WNckiN8iVoiYYw8m9Z5R5+fBRoZELg3jkKWE/LYk1LuQgCZ07ScyyQ7ZupDstlqHUlSTTAk
 dLxrROiInsWsqlYly9QlM0v+XqgMpCWmpkIx5XyFMYndvCHVPp7h0aJSu7uu1Bl87Zi1GR3Ekqd
 RIs1tccgsLV1Pu2jOA/QM5UU798EQXPbLYUJni/pliqSrT1sO+3xERffKzidEgWSebjAsAGY9+Q
 LKn4ouPaC+OKCa4TwlUxMFp7+Xwh/TZZ/Wbkg/sE0P17Ii+MkqaKNpPpRrvYzfKxtHL9uXJ/mA5
 5g=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'cache_ref_iterator_seek()' function is used to seek the
`ref_iterator` to the desired reference in the ref-cache mechanism. We
use the seeking functionality to implement the '--start-after' flag in
'git-for-each-ref(1)'.

When using the files-backend with packed-refs, it is possible that some
of the refs directories are empty. For e.g. just after repacking, the
'refs/heads' directory would be empty. The ref-cache seek mechanism
doesn't take this into consideration, causing SEGFAULT as we try to
access entries within the directory. Fix this by breaking out of the
loop when we enter an empty directory.

Add tests which simulate this behavior and also provide coverage over
using the feature over packed-refs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
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



