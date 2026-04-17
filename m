Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F9C344023
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423080; cv=none; b=AkEJcEO0tIlot/AEkvYziPmXB6bpmYje4CxLp5Zsr71liVPMLpDKmnoRsu3PlXMHOJywGtoq8/bpi9Ik02pMwj8HjobT7SPEgNJ3vU+Ku0WdrE55PFyRgLhtUoaOrBIN+QbwAK48tRpE4omQkX6Z+Or091wNOwT2//PXmK6+n/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423080; c=relaxed/simple;
	bh=Sqxral/SVat7YZbY/zlwJPMjwZaC+tbEEgeKF5W+yDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQX0WH19Q4J7gIvkDoa0UlqPPZoFMd5BU86SdccltdGhekLDlDooGvX6TIy6drKwYmKEyMX09JJd+6I4wr32uIUBBwidip7VJyMKmsTJ9UEYc0K8rMk6BCOWYyGE65+Btmcepnz1kRCppjEPsHp9Pu+t/iC8aIh/18VJVKZPx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v4qqpbhM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kHPcQRCg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v4qqpbhM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kHPcQRCg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A7047EC0103;
	Fri, 17 Apr 2026 06:51:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 17 Apr 2026 06:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423078;
	 x=1776509478; bh=XEya7yAAAKPO3UWdxUc352JTS9XG89Av+Nmdra2x60M=; b=
	v4qqpbhMClWwB6LI4DwhcXYiTo+wzrilb3p5JmyYYC4U6GhR2Jivm9ZwCMDFr8ua
	IMHMJ5AliLtkIqTXI6OFdsqCY9JJj0En+6I1yyrRVkNrglQ1+ixnRTLTm/91Mg4o
	7R5VLtbQfW4eVtO92WKB7OO6qSFJUSfWwTVE6M8362HOjFl/FUQECxYTNYBQhpVS
	5hvoC0Hd69W3UkveKmcix556qX5yzLgzuzzik67oOd6rPziJ9or2s6JJu4//IuCm
	vzUIQ0vW7phBxlsWn1shvc+bvmIQRXUXHNELmlP2zPTMjYXx3tg5skKjmxkL/DL9
	FOjDEWPYi3WS2GueuDwMrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423078; x=
	1776509478; bh=XEya7yAAAKPO3UWdxUc352JTS9XG89Av+Nmdra2x60M=; b=k
	HPcQRCg5E6AVuppmZOWQAa//xJ+eizIjRLF0NdQF6790eCynVkkBQ3190Frqo5WK
	JmAmkklB5mjNa3bTwDNqLsanladhnqNJ1JEh/XsVEWty7c9vLX4eJWBVAG7Bpoat
	pEbp8GGoWEJQUgMjjxjiWHvxFwMMOqQDGMNgUp+Qj7f1liqZQVN2myV0PEEpwuUH
	6b69ot6ph1H3neioev6wppnvgCx3LZfkcvVepRa9WQrTs3ZRV1b1JGrDfCYJf8mm
	aVvlw1hJMZP7cPwdFUhNtnhT1syCppHnUA0mhy1bR0LgiieQYqbv0z8QFqW844dy
	kKEaUWdH4drtc/cWanU8w==
X-ME-Sender: <xms:phDiaS9qb_5NqShxEGeBi_GTT54OfP8E6N2K0hmuNEAS0QHpkWa37g>
    <xme:phDiaZswWXfLPOShAETUquPqik65CpMrTSdc8iWk-Py6QKbldY4wk0betEEpMuv4f
    raxeiMdFDSJHVsKmP6O58CO-XqityOyf5BFRjOPa5fisnBWkCHu>
X-ME-Received: <xmr:phDiadABc5n1ZA7YkEkbLEiAKL9xIjZRVdzHvwn9jnP61b_P3Y0zwdBcafe6OeN_JpVCwSU_ST6lORtqReNvshobw6MM24b-rcWDDyx8DNku>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:phDiaZWzeI7b3YAvcV4iXxAsrCf040F-0y49vbAQhC9Pl8S4w0PddA>
    <xmx:phDiaTCKWYsTQhC-wvIhMLIr58IywlywPbGArB4BbvAuCFZE8z9lcQ>
    <xmx:phDiaU9EHRrXyvuhzoA578eUsGg_N58L8K3fJrAu4zNOCWwWNddiQg>
    <xmx:phDiaSEjlGxnQP86RQN_GJjEHL86EXg17VpJGLYr9nRf2ZGiQvG1Sw>
    <xmx:phDiaQ93fXBALMSHQ-MaqG05MfODJkggKgrr7U1uKlvv5uyVobkTh8T8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23824319 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:54 +0200
Subject: [PATCH v4 08/12] t0008: silence error in subshell when using `grep
 -v`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-8-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

In t0008 we use `grep -v` in a subshell, but expect that this command
will sometimes not match anything. This would cause grep(1) to return an
error code, but given that we don't run with `set -e` we swallow this
error.

We're about to enable `set -e`. Prepare for this by ignoring any errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0008-ignores.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index e716b5cdfa..d77a179bdd 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -122,8 +122,8 @@ test_expect_success_multiple () {
 	fi
 	testname="$1" expect_all="$2" code="$3"
 
-	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
-	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
+	expect_verbose=$(echo "$expect_all" | grep -v '^::	' || :)
+	expect=$(echo "$expect_verbose" | sed -e 's/.*	//')
 
 	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
 		expect "$expect" &&

-- 
2.54.0.rc2.529.gd9106f7525.dirty

