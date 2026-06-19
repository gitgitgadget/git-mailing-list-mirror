Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F31494A8
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853634; cv=none; b=BG2hzbeS5cIytUzpE7XKkBa+03HddqgCmSjBvjToVDAw1ezqk5qF2BwBhCDDLJllvi98/IRKzwTCX4xmzka54rpV5majtLQ13fgHVTU62J9HMpqe5r/NTxgfeXSxfHyWWAkU1usyY4rcHG1+MxDHA7BEhC68uSmJFTCmSvnoz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853634; c=relaxed/simple;
	bh=1PaBr5bZNuU3nqKQYqbIQk+1XTI4yQOjK1IVDPQGisA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dU/pX4b3EuccqxDN1OkhY4kYQ00zA86pUnW7zOkdwvB3RsFtAegvVbf8XmX+cX6c3rePgUXC3SZW1g+VNIEK5fd8nXeUPVMNf0U+7hPYrYz4RFGjWe0X5DjxTGv7Je0wzIesI3zCK71JsNd5eK2WyW4w4bZm90i7SPGBY0IoC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lXj1psdU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bH2eGgR0; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lXj1psdU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bH2eGgR0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1669F1D0015F;
	Fri, 19 Jun 2026 03:20:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 19 Jun 2026 03:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1781853630; x=1781940030; bh=JLQQefj2mj
	YxoVNB4NUHFZmOw2Z0ydsH7Taud3eKX0M=; b=lXj1psdU9yJS1RL/kj3PiBSpe+
	aEBsWzL3mtlEqVc14+9+TwrvQt8xjO/FuUt2Jg9jiEcUS92HK16QLXOeWWwFYHa+
	TAFa3LneZLIkXneSCMw8z+BsXk2UtCXLUmTZV5Lr/HZSM4papXm+aK113axf9RBn
	pDD13kj6uwr4ZWHZPHHt6msSIReFqh1017ZLdc84vvDbE1CWmp7XTrmi9+u8Ng5N
	SqyqS9VD5BBrHG88DpvEdXsakmwn9odCNa0ZdknnAg8H6iLXPPrVGam90YKtzq6h
	uMdc/CpmvJfvx0JouZOqH1H5QPvYKbOy69ho/xwkm5yj2MbR4+2Bwj+WmyBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781853630; x=1781940030; bh=JLQQefj2mjYxoVNB4NUHFZmOw2Z0
	ydsH7Taud3eKX0M=; b=bH2eGgR0qKaY3FQsmJhIhOKaEVko3tqfaiJGI9Yvks8O
	puHjiVQvH//Q8fix1JIaXQh3QaIcZDYF+huClJHLmWcmN+o/8ScfrpIRi0YVLPk+
	Z7aN2nME5WreKtXrjBMVd5aQ5K2nhuG1p47JJyKVM5G6QfkjU+DuDkvEXgfiNiai
	OWkHvnod/IWfSo6MlOWODM5VCKozaGb/TmmjGHkBw9Cf73wPvm5itsJ+E296JEj3
	rJ/Bw7Uf8tVPaDFrU1DkAQhaZWQZh4Z9g67Echzym3ple3PC2prjIO/u3tlUrTBY
	eWzRb2/UaE2uH2fdIKPYv5XS3R/Wu/LKbxRr+73qdw==
X-ME-Sender: <xms:vu00atxY54CezOLhlHnGIY1Da3gXRU5FZ_JsR4SXQv7KuExL0ddusg>
    <xme:vu00akJkU4p6AcCIH4j7NKtAJOAqucD27quaOuYhQLMiDl5axtqGVoGLR-CpUfbG4
    aTumv2Nm_y18P6jZUgE2WLBhQYxtnGujaAePkkz7vIJbADSYv_uvg>
X-ME-Received: <xmr:vu00avqOfx2xvVgLmj_VQupuzJrwKxihKQHDZM8Qm3gqsvI2JtaPNcUd9-r-oAvtWzH9orduIU6osfeleLhHzCTukPo1D8p6ZyoLV3YgssI>
X-ME-Proxy-Cause: dmFkZTGP8v+TjtD4DB7OUTMWofWIxPqpJsUr+kGVgodSQzl5C+ekG1qc6HQykNjx+0Engb
    i7PI37SM/1vdIjmNxN2rMh1+aY9KIk6zX8ClPqi+Xqp8LyeAwc06SD1Sj4LVN/ssDDnHbC
    JEAbGfJr3T0hwpU98mIJTr0kLcvryeoS8JgXqHhjYiOTrX+q09MVf/NMb6qMBhzPGlwnrN
    uA+ZTaWjnMX4dyu9PsHfsMt/qbWXrpzzWWGdld6XJLuG726fZE8rjPv97ajCy6tBnoDi/+
    KLllTjJu/oaLN7jC9jcoKy4mt9ftllgxpqnb75EMDchH0L9KBPGwoWQ8tmuqSrHAw/ufGp
    MpuMc9MssF7nygs9cy+knTYEKbq2NC/xVN9GxqXeHNZYjHhtQI1yNLZcLufkmo/LTiT9pe
    JszV+1kqjNMI/Tq2siGMV9eqsGChbOYDrLMi6O5OjTpI0RbYTsRliweQ7cZ9ImmVZFR+ro
    5jUYKTl8ooXJLZKcQglkDHma503vuI0aboNWBEzFwJUsXXwVHQPpdtEfVI1nntNyLft3Jf
    K8J4Un2AjPf3Gp7L9klR6OsdQr6ltB2IRAhUHdDIdPvGZKE87KlFo2vOM9Ayn0ZQl0h30f
    mRpGrCaLGQJ3AmeHJlEFBR0HwXj9XugKhNHMxvApvie6KDOtYB1z+22gj4ZQ
X-ME-Proxy: <xmx:vu00arKm3UmrojRxVb4uJ52WFyr-0ljeScdn4s48XSB8y8XITYLatg>
    <xmx:vu00asSiUdQftVh_TnimFBuFeSjyCsiXqcdcVmYMaOTPcnYCNCSVMw>
    <xmx:vu00aiu_qsdD2A5jtV823OLzn_0laWIvLjzDTiubXGRqxd-w5XyB4Q>
    <xmx:vu00alZPUUcepSpDK3Q0GX5pkWayZ760aq5DqFMpADVOQriA0LaZAw>
    <xmx:vu00amabGurMfRLK5j4T_LnzB5vdnioIRv33gx77K_AY7NW8sYWeau75>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 03:20:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a38ed4db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 07:20:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 09:20:20 +0200
Subject: [PATCH] t4216: fix no-op test that breaks TAP output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-pks-t4216-drop-unused-prereq-v1-1-2ce0d7bea088@pks.im>
X-B4-Tracking: v=1; b=H4sIALPtNGoC/yXMQQ6CMBBA0auQWTtJW7GkXsWwQDrqaFLqDDUmh
 LtTcfn+4i+gJEwK52YBoQ8rT6nCHhoYH0O6E3KsBmecN94GzC/FuXXWY5QpY0lFKWIWEnrjqQt
 Ha7rBuDZAXdR84+++v/R/a7k+aZx/T1jXDYFYvKOAAAAA
X-Change-ID: 20260619-pks-t4216-drop-unused-prereq-5793107a0249
To: git@vger.kernel.org
Cc: Todd Zullinger <tmz@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

In t4216 we have have a prerequisite that is active in case the system's
`char` type is signed by default. This prerequisite isn't really used by
anything though: while it is used to guard one of our tests, that
specific test is essentially a no-op. So all this infrastructure does is
to provide some debugging hint to a reader that pays a lot of attention.

Besides that, the way we set up the prerequisite also results in broken
TAP output on systems where `char` is unsigned by default: we use
`test_cmp()` to diff two files outside of of any test body, and if the
files differ we enable the prerequisite. If so, the call to `test_cmp()`
would also print output, and that output is of course not valid TAP
output.

That wasn't a problem before 389c83025d (t: let prove fail when parsing
invalid TAP output, 2026-06-04), because our TAP parser was configured
to be lenient. But starting with that commit, t4216 is now failing on
systems with unsigned chars.

Drop the whole infrastructure. The prerequisite is not used anywhere
else, and the only location where it's used doesn't really provide much
value.

Reported-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

as reported in [1]. Thanks!

Patrick

<20260617220330.n6byiFQr@teonanacatl.net>
---
 t/t4216-log-bloom.sh | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 1064990de3..16bc39c359 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -569,27 +569,6 @@ test_expect_success 'set up repo with high bit path, version 1 changed-path' '
 	git -C highbit1 commit-graph write --reachable --changed-paths
 '
 
-test_expect_success 'setup check value of version 1 changed-path' '
-	(
-		cd highbit1 &&
-		echo "52a9" >expect &&
-		get_first_changed_path_filter >actual
-	)
-'
-
-# expect will not match actual if char is unsigned by default. Write the test
-# in this way, so that a user running this test script can still see if the two
-# files match. (It will appear as an ordinary success if they match, and a skip
-# if not.)
-if test_cmp highbit1/expect highbit1/actual
-then
-	test_set_prereq SIGNED_CHAR_BY_DEFAULT
-fi
-test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
-	# Only the prereq matters for this test.
-	true
-'
-
 test_expect_success 'setup make another commit' '
 	# "git log" does not use Bloom filters for root commits - see how, in
 	# revision.c, rev_compare_tree() (the only code path that eventually calls

---
base-commit: 95e20213faefeb95df29277c58ac1980ab68f701
change-id: 20260619-pks-t4216-drop-unused-prereq-5793107a0249

