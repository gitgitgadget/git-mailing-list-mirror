Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5694D28689
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550211; cv=none; b=rApZbrOZJdW8EJQ/8ISN2e9mBPzJSlvhO9nFCRePxjWmOZS2s8QKwAhlkQN+i6rEMNHsezWQuzOJKIXHKpu3/bF7k0rRzbGiAtHR0BqxuACI7PCFq9SaWQga4+qp5PZpcK5eN3gF5ZDdkExKfkV06/KV/xn+YTrOwQ3ggwSDhuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550211; c=relaxed/simple;
	bh=N3WDuqBFPtvrX3cNb4UmdBkc8+dkHpUMrsf84bZkQdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jC3uoB2axY0B789RRN5pwIIpubaeN5btPxeiM7lnI+fCXJt+FCPWQz6cgbiOXJwlFIrKiuX4zIHdrgQfaKf5NlG5SLZ0WJPX6rOHEEWBe0p9H1WKsmas2taHcjgeMLrmLyUZc9+q/Ktsssyx00ADx5uKgFQ1t5BwK+oJpaetaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fcyHtamZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dt/IecCR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fcyHtamZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dt/IecCR"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 270C913806E4;
	Mon, 25 Nov 2024 10:56:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 25 Nov 2024 10:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1732550206; x=1732636606; bh=YkMZjzEdm9
	2LzBMs484WH6GUz3hbSA2BLA8CZCveDAI=; b=fcyHtamZ+wiiWDGLnbys0opP0D
	C+MFG9YVlMicDUyQlwa4tiMLKuElMtOlXrFgGlAuyQmJrmQATnA1q0QIWYh7ApA7
	XS2mTMHpiW5mRw7Xcov4X5GkeUPNE3WNQbXr0T33rpCeVwoRBXctAopqrB8v9Xq/
	fQf57S2Oc7gbRBsG04Qga05JSa3oZ3fD188ELhOjp9NL6OF1v++aDOiEGWtnDF09
	Udc4ntdTqcP6UIuVfcZOF01lseznzjrVwFAispLWt04kM2yzYR/53SXk13wphhkb
	ec71gkG3OCmQHrBpW9yejhK2e3b+/ToVzImaUdPxH5zSIxzPjCWgZdvBUbYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1732550206; x=1732636606; bh=YkMZjzEdm92LzBMs484WH6GUz3hb
	SA2BLA8CZCveDAI=; b=dt/IecCRGSL+oFmehEaEHu3NghLt9uANgO5imi9ZRBl+
	CVXkrzGV35g68C5HocMErohQs3G122Dvg/OZh4gRALzWT7ZlO6Frs1XN9H9OQQNy
	FMuhU6u9CppsnzVHCpFSj87TSUwMcP8wL0Rqcr64a5eDpPFBr6YYJr1zb49QVX8B
	ZGGNHgCfwlMdVg6ssxThD9ZK2Ey5sw6ZXJcTia3ns8+tYrY+4vt3fbzJbRAK/2GD
	kgUlw/TV4PMI5smDyFb0sXRTH4UqE3TUwpeZnDd4xJn+X8tZPPmDUd2eoQkR1XQ3
	mCkpdpuAJBJ/C0hkDSIIHdmEajYWeGGwmbLzgAcVxw==
X-ME-Sender: <xms:PZ5EZ_8dx_eT2y9jbBptLyunrT1MQRqgU5Re0_IHm5VtHP5i5uSNmQ>
    <xme:PZ5EZ7v7xHU3KLF734i1FPVYMI4yVaDycN8DPAzkKtSFzwl9Jav34GLeOvfddfnG2
    ieDQcHRGLDUwLxMiA>
X-ME-Received: <xmr:PZ5EZ9CIzVCv1Q5yduU-u1UOGcoEUHg_kM4xS-jcsGzM8-ApQr4HKrfNKxIWWtgyNFas6ZeK89efueGQvcCCSETv49gDOffJVOXcka4az_W6bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeigfeitdffffdvvd
    euheehjeehheeludduhfehkeekgeeggfeuffehveegteejfeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PZ5EZ7eMEdX8_Jhu2Lth6-zMfG_iuvDOYI0KV2ZeBb_djLtzEulrsg>
    <xmx:PZ5EZ0MY3SO8uq-ZKOe8zgcnPBinrPXpfVy4FMkCZNpQZXkRV3DDPA>
    <xmx:PZ5EZ9kimuHYFcZ41w4O48TSWbfA-b9vrPZwz1YcDDx_qQPVRpx1kQ>
    <xmx:PZ5EZ-tdmUoEQ5wSafgRoLPZ9VoVl52I0QDuGw9-63XBFNm_vI0rww>
    <xmx:Pp5EZ9bKC834cL1a_ia3abbCHZ9StdaF-o7ueWzHVebujqyxxKlrKW6Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 10:56:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aedadd3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 15:55:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 16:56:25 +0100
Subject: [PATCH] bisect: address Coverity warning about potential double
 free
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-leak-fixes-address-double-free-v1-1-d33fd8ebf55b@pks.im>
X-B4-Tracking: v=1; b=H4sIACieRGcC/x3MQQqDQAxG4atI1gZmpkqhVyldxM4/bVBUEhRBv
 HuHLj94vJMcpnB6NCcZdnVd5orYNvT+yvwBa66mFFIXY+p5HZ0nyMhFDzhLzgZ3zss2TOBiAON
 egF46uYVAdbQa/nH9PF/X9QNI7yOpdAAAAA==
X-Change-ID: 20241125-pks-leak-fixes-address-double-free-e7fee5a4a300
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Coverity has started to warn about a potential double-free in
`find_bisection()`. This warning is triggered because we may modify the
list head of the passed-in `commit_list` in case it is an UNINTERESTING
commit, but still call `free_commit_list()` on the original variable
that points to the now-freed head in case where `do_find_bisection()`
returns a `NULL` pointer.

As far as I can see, this double free cannot happen in practice, as
`do_find_bisection()` only returns a `NULL` pointer when it was passed a
`NULL` input. So in order to trigger the double free we would have to
call `find_bisection()` with a commit list that only consists of
UNINTERESTING commits, but I have not been able to construct a case
where that happens.

Drop the `else` branch entirely as it seems to be a no-op anyway.
Another option might be to instead call `free_commit_list()` on `list`,
which is the modified version of `commit_list` and thus wouldn't cause a
double free. But as mentioned, I couldn't come up with any case where a
passed-in non-NULL list becomes empty, so this shouldn't be necessary.
And if it ever does become necessary we'd notice anyway via the leak
sanitizer.

Interestingly enough we did not have a single test exercising this
branch: all tests pass just fine even when replacing it with a call to
`BUG()`. Add a test that exercises it.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this addresses the issue reported by Peff in [1]. The patch is based on
top of 6ea2d9d271 (Sync with Git 2.47.1, 2024-11-25) with
ps/leakfixes-part-10 at fc1ddf42af (t: remove TEST_PASSES_SANITIZE_LEAK
annotations, 2024-11-20) merged into it.

Thanks!

Patrick

[1]: <20241125131722.GA1613472@coredump.intra.peff.net>
---
 bisect.c                   | 2 --
 t/t6002-rev-list-bisect.sh | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index f6fa5c235ffb351011ed5e81771fbcdad9ca0917..d71c4e4b44b40706b8182bc8821bf711b5794376 100644
--- a/bisect.c
+++ b/bisect.c
@@ -442,8 +442,6 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 			best->next = NULL;
 		}
 		*reaches = weight(best);
-	} else {
-		free_commit_list(*commit_list);
 	}
 	*commit_list = best;
 
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index b95a0212adff71632d0b91cf96432b276c86a44c..daa009c9a1b4b67d510df74f1d5d5cc2b1a904cd 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -308,4 +308,9 @@ test_expect_success '--bisect-all --first-parent' '
 	test_cmp expect actual
 '
 
+test_expect_success '--bisect without any revisions' '
+	git rev-list --bisect HEAD..HEAD >out &&
+	test_must_be_empty out
+'
+
 test_done

---
base-commit: c5c2f8884377a610fe2752658af3b06f790502b5
change-id: 20241125-pks-leak-fixes-address-double-free-e7fee5a4a300

