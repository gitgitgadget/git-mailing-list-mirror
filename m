Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261123B8D76
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423085; cv=none; b=m/hLcCAgZAiVboqYH/ZtH0JPIVv5jFyXO8Dfgg6iG+l2XQCepQuQO0CVAXeMirvdNlKhwrmMcdv9GOaAhcSG/tCstaVRUodLjhHBgCtZWgfK9Vav6yP6emsmCZOZ513ldttd/iXSEP+00WsASjiQ5nJfgjHjB4Q5/3SUX+l+U+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423085; c=relaxed/simple;
	bh=btpJKUiFNlUXA1LKD9q90pol3SWi1ccsm86g6cgPVbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbUv05r+QCrIEmFVT6DP7gBjFHuWjQpWm2Qy4ltZwnWl9OtN5t7UYyM3FPdA8YVrSpsYqjdlNdt2FSHMoRGjmolOpg3GrnSgEiI27+zo2pVTQdkmR+vTBVhDW/TMJvPbp6i/ZWUJrHnp2NuGcRmRWFrnZUKE7EwWVmZyHSIb9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QabB/1vq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v7dvbNXN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QabB/1vq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v7dvbNXN"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C5628EC0017;
	Fri, 17 Apr 2026 06:51:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 17 Apr 2026 06:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423081;
	 x=1776509481; bh=Qec/Dl8HiNegnp6O5X03Pa/AAEyuglTunFMmWaoK2V4=; b=
	QabB/1vqr7+vm4w1ohMqbhNuEGqaDPZX9roX3mX8y7kkQWS3ZB0k9MMAonTpqBNZ
	DI9MblNU/UwiWYDxSm96EVHzKQF8YThSOET9fxPwa8iFcoF7OPE/rylm/o0OqQtP
	UHQOGKCvAx64XS51oquUUAFXiKSlTAnQJzujyvy2tEV1aKDI655zOLidfAju1jxK
	ceQ38oL3VBYhgMp5V8PRB9/K6CwDmYVkC0+ClNk6lsDjPLHuJfRs+jvlztBarotZ
	+UxHKeMQLU9Eh9fqD11eZxG4JaOtaBIkPMo0f0JnKqexih7YPCxZTZ2lwcfXluJs
	1KEnFr/FDvloBepbeVuEAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423081; x=
	1776509481; bh=Qec/Dl8HiNegnp6O5X03Pa/AAEyuglTunFMmWaoK2V4=; b=v
	7dvbNXNuejofaHUC+/7gNK1mXVqJfwOc94EbE8MbQB5CLDYBA78Mv3hmtlj4sjs5
	ZqhiRlIoJrLQdzoD2T9Fr2gZWRMMZ5U56ztmyZ1Sy5LTyMxSQTCv6InhcpawBZif
	2R5TUC1RfnvGi0ynbOSH838ZQ2lzNqAA4ztAhUYTzZh+BLEAgLim2XvpcbwY3+Ay
	9TdwJpRsLcYjFGji4MHW9/2oPQGWkqqb08CMG9JFAzDsq4jRSnCyIW3XatuTIX/W
	e+++sjT1qcWiaJ1yB7GmL5DK+KMbEuodLmgr8yGm9vuZDVmUumGiLETpYUyn1ljt
	5RRrFPFwrXZoWO8U65KWQ==
X-ME-Sender: <xms:qRDiaRLoPIJ8PpYYb9Og6M9NIeOTohTvV5-NfaNcvZ_-TIt8a8yfnQ>
    <xme:qRDiaUK8NRy3pAtNqLoN3qv57kaJU4V0bc1359wgLHxq4OdqLj0wzoNaJKwnQhH9g
    -UJv_q2GZMdlwMB-g1iQJorHOKzzVGMddgHNgMWRXI9Snvb9VwkYg>
X-ME-Received: <xmr:qRDiaeuBxoA-lZtPpd3cDEfvEWHN_CZhXMyUBxNrN4LiRx4AXExHu69ARLBAftdKUF582Veuw1CwJkBq9v6rZLjGJwXmlaVgYheZOSzmhD7V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:qRDiaRSBApX4mnAAPCG75HNTz2LSNp7N5-YHS1vJTJdRVXirDiX4DQ>
    <xmx:qRDiaUMjurXXW2usnItHdgGpevR8y_BTdS8bwXZFxuTIUs1N4GF8qw>
    <xmx:qRDiaWaDSYZTYmDHSuEd3eFc-IsV50v-CAwEGpQ6qtz0SW5iUHrX_w>
    <xmx:qRDiaeypTVdzo_BqTbAPcZ62IUnoHEKoqtgm0mJn92uCZ7sQazivQQ>
    <xmx:qRDiaUoHH9xzq7LwXNkhtgxBG5SJFPBXfxnLO6qYK9tBbtmhUvLZbM5G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fcdc2a56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:55 +0200
Subject: [PATCH v4 09/12] t1301: don't fail in case setfacl(1) doesn't
 exist or fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-9-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

In t1301 we're trying to remove any potentially-existing default ACLs
that might exist on the transh directory by executing setfacl(1).
According to 8ed0a740dd (t1301-shared-repo.sh: don't let a default ACL
interfere with the test, 2008-10-16), this is done because we play
around with permissions and umasks in this test suite.

The setfacl(1) binary may not exist on some systems though, even though
tests ultimately still pass. This doesn't matter currently, but will
cause the test to fail once we start running with `set -e`. Silence such
failures by ignoring failures here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 630a47af21..0e0d07a1a1 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -12,7 +12,7 @@ TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
-setfacl -k . 2>/dev/null
+setfacl -k . 2>/dev/null || :
 
 # User must have read permissions to the repo -> failure on --shared=0400
 test_expect_success 'shared = 0400 (faulty permission u-w)' '

-- 
2.54.0.rc2.529.gd9106f7525.dirty

