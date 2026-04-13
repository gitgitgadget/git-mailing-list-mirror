Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE03B47F0
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073795; cv=none; b=WZvLlekFMrPMsHLm4ZSNjKsFVCv4M326EM1416RPRt/9FZdqNtARYAczKD4ac496SzI8Hc8b2gHyqesKHOwbxzKH+SRSZz+7K93lhwDe7reUaloHCzPGwzTVdoTu59npIGRM0LJilx4jYBQUDi/PNrGrhKqpslxnO6SeswgprXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073795; c=relaxed/simple;
	bh=QLCduKr/SqppvYlL/3QB3tqtEDyGYhqYgGOP7O79sFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YGjlN0bptnTZN2Drh6EZczZiGLucYclRWzsLtIhgV3MM/UL3iV6H7VQEWvLYxZpvF/fQA11IDkzKvKYNLhoETmEAotkAUgaWuWONsN2uymMrSLelLFeLDLIDuys3TeKs57YK+CiYTkhOXdgpnNM12kCQM6bqy7mSa2kRCRdVjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C4hmgfbj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lzC4I08X; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C4hmgfbj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lzC4I08X"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87D87140011B;
	Mon, 13 Apr 2026 05:49:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 05:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073793;
	 x=1776160193; bh=3l03fjw+O39aDKXsXSvJXvNiBbVuHyfddABy1E+QRtE=; b=
	C4hmgfbjZK6Ip9DVmrMEVgoElHrOVF2yxKdmvAtEBMAZWGsqmhBQ+0Zy8kh/sT6/
	e3I4WuFA8YQKIKIW9s1dmJriEfw0VUl8n7/PZuyFWkLlcD3WN4Kiq6zAPqviw7/J
	P46WV/YXcPIYuW3FHB+2EUgkksv1bwQqZ57yzDEBP18D7DrXqsqSHZoWkJmFjT9+
	VBvxBXEtvSdmaDJFheV1jZDAY8tRq0wCBtrmtCmybndg973WlRtgapT3m1rF2FDf
	u085pr2A+38fIwbQ1q+RA16dwOaMKiz3aTF+VCRm54BDvtGDlt7Q9QWKaDLhhpP+
	Ws9KyUdPtkN92sv0MJapRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073793; x=
	1776160193; bh=3l03fjw+O39aDKXsXSvJXvNiBbVuHyfddABy1E+QRtE=; b=l
	zC4I08X8hF+8TF4SE4mlK4VuIsqqMRrNqkNobY5U2jLKZYYXpqYn5Rpq0nfFEizk
	pq/p91ts3jWNa4ITbemk7LiMxx97uAmLZKk6thS6AJisdn9FkDocE9/EwbOM03dh
	iXDvYqNMu7bfWBp8ylP7EU6Kyt/5/uLe/K8bjKw1DXjLOerx+rqDTFUHJDYjIrmU
	clvsqKcjo00ZIYGVz5KogDGhNphYjq2YYas3ImcXEmJRvBRQJEieZJX0tsVZYrpn
	B9cyPgamaigIoZdrBlTrYbaBWgO70aWdOzazBko7WDvQJf65/pOg6T8O7sgAGRP1
	abCOGPFmLO8cglZ8lhU8A==
X-ME-Sender: <xms:QbzcaYQgesfpplAWQyGz255qfFuMfOxR1rh5d0I4EOGaKv8Ce6j2Nw>
    <xme:QbzcabwPevJCZ1jwYkiVUmh3UpKjaWSX66ktTxKwsYI3VehE_wrIWK1k-b_mXqP8I
    JRaTDk0tiBRVlUWiohAeQcsZ2J8-POW70K5zZcAHNjPdhNeAfPiGA>
X-ME-Received: <xmr:QbzcaTeRtKU6w0sJBbgajYLgkVsTaFMfyjvMc73RVt8rp8ayxbOdEFNl006C__91DAOIlolHVhXJ7zxxPcM7FA3dBYFVOL2m3tgorgF7UN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QbzcaXKH54Cs66ntKlX4qiWPjxh3qH78Kriz3mOFzuCLWjyDINwYXw>
    <xmx:QbzcaUGVI4mAGpsJDRmMHZAAz_HVt0ylTXwDrTp3mbKqLcKPvXz8JQ>
    <xmx:QbzcaRrewu8OIzeSmYE5XVFR_W3ffQLB4hy6xFVDItT9PHq0_ztChw>
    <xmx:QbzcadSfEFGfe7MlCF8V5A9TPOINGVTpZvem8uOdOvWp-AAK4aqbSQ>
    <xmx:QbzcabrAnfcNWXxScNTKa2kJ8XGa1Z3QCjcg7uceNeYO_ayJeu9luVwa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d442877 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:31 +0200
Subject: [PATCH 10/12] t6002: fix use of `expr` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-10-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

In `test_bisection_diff ()` we use `expr` to perform some math. This
command has some gotchas though in that it will only return success when
the result is neither null nor zero. In some of our cases though it
actually _is_ zero, and that will cause the expressions to fail once we
enable `set -e`.

Prepare for this change by instead using `$(( ))`, which doesn't have
the same issue. While at it, modernize the function a tiny bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t6002-rev-list-bisect.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index daa009c9a1..f2de40b5ed 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -27,13 +27,16 @@ test_bisection_diff()
 	# Test if bisection size is close to half of list size within
 	# tolerance.
 	#
-	_bisect_err=$(expr $_list_size - $_bisection_size \* 2)
-	test "$_bisect_err" -lt 0 && _bisect_err=$(expr 0 - $_bisect_err)
-	_bisect_err=$(expr $_bisect_err / 2) ; # floor
-
-	test_expect_success \
-	"bisection diff $_bisect_option $_head $* <= $_max_diff" \
-	'test $_bisect_err -le $_max_diff'
+	_bisect_err=$(($_list_size - $_bisection_size * 2))
+	if test "$_bisect_err" -lt 0
+	then
+		_bisect_err=$((0 - $_bisect_err))
+	fi
+	_bisect_err=$(($_bisect_err / 2)) ; # floor
+
+	test_expect_success "bisection diff $_bisect_option $_head $* <= $_max_diff" '
+		test $_bisect_err -le $_max_diff
+	'
 }
 
 date >path0

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

