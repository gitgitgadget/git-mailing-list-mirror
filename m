Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED654774
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773379929; cv=none; b=X8qiPRVqdOIhrPhobxzQdC5Zzap22JIi/ZnvZ0AA2NthBW5qib9WKjziqrsugIdh7ZTQoVx4rJ/8v3A6olvYFgCZRIMLjqiJcjQnx8cBO4YH7e7zlX5LmrCE/rAXps0UJc0+uoIaQPVoj2reOqZzfUWG4NdgyUsCrfSphYSWL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773379929; c=relaxed/simple;
	bh=+RhQ1w3fiIy4Km3hxdI/GL5VmVUE6qmFf0J9QVIoYPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pcc1R8yV9Gcv0JC4ors9kCExBKRL6tKNFIinaHFn9r5BSVJLs7ilyj6X/8tR/PSHOUfJV3dIVJp7VQTENR23gdTDN5Or+kSOJwilF9vIFne0cyZlX5oE0tNpY0BO7TDym8G+54bJNpGDvFoudjg3Q2B00NurrMvk21ffA+E7DRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8mcIZki; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8mcIZki"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so1125418a91.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773379927; x=1773984727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aty3W4gNoSB4wyDuoILbWhxjDXgcMcruDDiUsBSA7o=;
        b=b8mcIZkiWxYLrseuKXmKfXl9kj8dr65oi+VzD/55lA0LtFaRbceF9vrb8HDAkVuO4C
         r/EYKPFkN9p4bHJkMb3Uago2WlSIK0hyyhVBZ01ZoJ6bkfev1ZJ47jn3PwIRHB5dS1NJ
         Auz7zSyRydrisp2gvU0HqF4UZTVaKvmuUZS+cQ/s3g8mP4yvFqGje15YIPiSXhZH81K2
         s2fCdA5Ii0G6rsp1C5r9rYEK15rrWQp3Q8lLTapAO2DSWqoIx62pubH5GjtP+fRrNQ19
         Izh94Np1n0E8lNVxLfGSe8qSui5klq7qBX9MGoytT6Dp5QlgAPGiDcmY8qOmf7u5L/Ue
         3pgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773379927; x=1773984727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3aty3W4gNoSB4wyDuoILbWhxjDXgcMcruDDiUsBSA7o=;
        b=Y9sVMEdh0nVOWSgchAh6IbC92J2xeg5MEC0+vQyYQ3N1/yz3GAYk/lWWvq4pFec0Eh
         HBe1ICzLZoVA/iJFHLLnGlLl4VZFGtsP8LTusGtL3USAizcpiIcWJmGnvmj+CYqbSjhM
         NOlLptuS9CDLg+FuT71QUexX8S+Y6Bym3hOLQ7QjeSzgfd90zLMO4thE7iXu+g1EbbvM
         0KQ4/fy3bAPBcNHO2s6tXXVcaNGk/8CJNUrj3Hb1+TECriWo+5OpiubuUHZgvxVJC8Q+
         AZT0BN7Rx/89hw5JHXuWYF8VSLcT+mzo51GU9C9HUvp/Fs0bCQ8CHO7v5LQMdJd0ZrS2
         MpOA==
X-Gm-Message-State: AOJu0YzIm57B3K93gWMOrighADSUuIYpG7crIXo5WJY43PAJbZAvOfte
	fPyvw9oDw7ZLEpdwmIaV52OLWH+tbp441BCx26D7OIyjk7QzE9NmNMoIL7Hymz7sKCU=
X-Gm-Gg: ATEYQzwYYV6xO7zuweSySX2GeEzi/FjIDLv0nTqJZkX0i5ui680Pn6GBJbjNOSs4pu1
	Jt3rzB5eFzYlQfbuVGAmX4CduLBzyA9ZYzHR+KcW85mGWiaCASx1gMLp7Gu6+dk1Jrv467aj3qM
	EpNq4AZcBEDWS0jgw9c4S8zElXX6TlC8Dxrj3CI3uqQndp2Sct4HKX/AYqjAdsYnVPdU9kJdQrq
	Iib/04LEO5GOov+DKPB8fyRwsJ1F1DWY3oF16wW602IZxb62SMWPc/u1CbEWFYq+oDlkNtpmwpB
	jnfC2l2/qS0E9pr8omyXwPzjXpUJSSswL3dwxf77wregN0PG9ZT7Y0hu2hzuuXAfk/f+ntFT6Rq
	Cf+RBbBSXUxLaKWVwAJKeuCE+J5I/rNNJhsbMLvBTpvYJFwxyAVJgYf3A9B2TxBUFu3yibJV6PI
	64rGiqc07NqxNo2PH/DEK3TGeE1ozYrvne0MpVNLxGpem6m6Ij4Yz7OgX0J6r851FY46o7muA=
X-Received: by 2002:a17:90b:4a47:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-35a21ec604bmr1597676a91.8.1773379927364;
        Thu, 12 Mar 2026 22:32:07 -0700 (PDT)
Received: from localhost.localdomain ([14.139.107.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a22d00518sm577013a91.2.2026.03.12.22.32.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Mar 2026 22:32:07 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	peff@peff.net,
	pushkarkumarsingh1970@gmail.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v3] t0410: modernize delete_object helper
Date: Fri, 13 Mar 2026 11:01:59 +0530
Message-ID: <20260313053159.36492-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260313025852.30010-1-r.siddharth.shrimali@gmail.com>
References: <20260313025852.30010-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The delete_object helper currently relies on a manual sed command to
calculate object paths. This works, but it's a bit brittle and forces
us to maintain shell logic that Git's own test suite can already
handle more elegantly.

Switch to 'test_oid_to_path' to let Git handle the path logic. This
makes the helper hash independent, which is much cleaner than manual
string manipulation. While at it, use 'local' to declare helper-specific
variables and quote them to follow Git's coding style. This prevents
them from leaking into global shell scope and avoids potential naming
conflicts with other parts of the test suite.

Helped-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Thanks to Pushkar for the initial review and testing. Thanks to Jeff
for the catch regarding 'local' assignment portability. Paths with 
spaces could cause issues on some shells without the extra quotes. 
Thanks also to Eric and Junio for the feedback on 'test_path_is_file'.

Changes in v3:
- Added quotes to 'local' variable assignments to improve shell 
  portability.

Changes in v2:
- Added 'local' to variables and ensured they are properly quoted.
- Removed 'test_path_is_file' as 'rm' provides sufficient 
  error reporting.

 t/t0410-partial-clone.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 2a5bdbeeb8..52e19728a3 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -11,7 +11,10 @@ test_description='partial clone'
 GIT_TEST_COMMIT_GRAPH=0
 
 delete_object () {
-	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
+	local repo="$1"
+	local obj="$2"
+	local path="$repo/.git/objects/$(test_oid_to_path "$obj")" &&
+	rm "$path"
 }
 
 pack_as_from_promisor () {
-- 
2.51.2

