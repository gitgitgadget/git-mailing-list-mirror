Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC917B51A
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321534; cv=none; b=t8vKj5mwHoChE1ia7vnWWFfokv8itVe6DVsLaVdcsPy1wpiRCpmPt2J4nLU2maerGBjWSpMBnWR1vwPXfItslDsA51g37mB+2Lz0KbPi+TtD2GcQEYa52MUppsPgJNgirfi1SvBav85LsQRl9NLYTULnNZQlciQsMtqtWwU3US0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321534; c=relaxed/simple;
	bh=FUITSsWuKf+6OoHBFvKAvt4z1atjfdf0/OsGcqzvQaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUZ+LMTP4cWBTskM9bZRok59YKE2cxdtXAmDDrGB6hXA6DC56HDmccLnnLJMU5g3aoS39DmkpSqCZeKUFBZQPgnLGQiyEd7iAQ8c27wLIPyPg4B7QHCQfXZ55AgZVCHSv9At6ImeK07Cgrw0SPeJpfUOxICDI76vIadrWA7Dtvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J+gZ6ipK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tsc9p1a1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J+gZ6ipK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tsc9p1a1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id F0B7D13802D7;
	Mon, 11 Nov 2024 05:38:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 05:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321531;
	 x=1731407931; bh=oOtBi9rj+Bdmq5qxV9FHytYFcwhoLUjxCrJ+lwgL5yc=; b=
	J+gZ6ipKB7wsgZxzM3YR4X+iL2+xIlQqh1WxKEq8pmT+zDulN88OikilahnCvOAv
	BsSYb6VLHSIDj7wQny/ED6QOxnOveKmfku9Cu63M6d+NK+Yb/3k+u46xO9yiqAZY
	T+iCqMITr9V4qZovjRDbAkAC50CBFBWX3VzqCh22Zdyo7W84wuWVOAJ44lLrMkVh
	miFJ2ig/H8sOUhoEcmi6p+h0ACRiE4FKxFkQXTWAw5beiEh7DsM4ZXd8YkRGD3SA
	yqttaiAk3V7Kljhd2dzbFARgOtuuNoTdNH2NNVdPiSv0lLhPNK0DYusgdH610DRR
	APpjqhCqb1oizgRZfRBXlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321531; x=
	1731407931; bh=oOtBi9rj+Bdmq5qxV9FHytYFcwhoLUjxCrJ+lwgL5yc=; b=T
	sc9p1a1z46aRK1VX43u3dHB+F5+oKhaXxaNT+brjFWHEc/voO6Q23/bjpxTKGYZt
	Wy5ygey3Z9Y0AXp+GSyiqGSg+HIbdBm9SlGWWf76rwhtT4x/1kcu3mM0Y6HvCUcb
	g3H0kxhwc7Doq+1Jo0arlyO/svISfz0edxfXciTPfLZCpK/s0BTY1OuHzRwAflP1
	0udoTHlkbt3uBhwtRLcB8EE0FxZnf8PGNKr3/xi8Gp7+4aPLRmC5BGcNu9/ZlIdG
	bLBj9DUoepfBCM8qw22BSU/b5q3ryva1jqYOPn9GU6b/yY7vwpveOYhLTw9X1O+x
	lAaxqREXzREm69ZMgCl+A==
X-ME-Sender: <xms:u94xZ-CvZiC7vxd_Z7F7i5iLp74nRloORHW9EnMnRWOyzONuLlHX5A>
    <xme:u94xZ4g-Mrjvgmj9Yl5iivBefxlwgcJMVYHAcEWUeaqfHQwzxk_qmSXHEhi4hsPH-
    MugwjxEgAQ5JSlDFA>
X-ME-Received: <xmr:u94xZxkoUx6cTOmoThhycUH9gaKPII-7u3-FAndNAKMPFDs9cvrgtLZ5ghivZiKyhiz4WpXpoMQHC044a7JzcdB7LGGTRahhwuOzqgcGx0l1bS3P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:u94xZ8z0XYl2tioBjvHNLNbLrm34x1S9N5JILOfolmakxhVBIb4-Yg>
    <xmx:u94xZzRHRLekmbfQ9Qk0VNeATlhMNCW1aEhtuuSH5cpcr6Ocd9OBXA>
    <xmx:u94xZ3al4Zxm16NRngv5IdIwUDfx_IOAkaLhILTVeECmZ2Vo_nOtew>
    <xmx:u94xZ8QIIdaX2FCyjevELseUJcymqjUSrDFPx0arKqDZeT6dTDujXA>
    <xmx:u94xZ-eGVVsSYMru9b5C3-oxODb6lf_w2pmA4OT7d-swxryV2yXkpwe9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ecfa0da6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:35 +0100
Subject: [PATCH v2 06/27] bisect: fix leaking commit list items in
 `check_merge_base()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-6-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

While we free the result commit list at the end of `check_merge_base()`,
we forget to free any items that we have already iterated over. Fix this
by using a separate variable to iterate through them.

This leak is exposed by t6030, but plugging it does not make the whole
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 04e9a63f11c7fa1a9dd11d3f193c500a4cb937c6..12efcff2e3c1836ab6e63d36e4d42269fbcaeaab 100644
--- a/bisect.c
+++ b/bisect.c
@@ -851,8 +851,8 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 				      rev + 1, &result) < 0)
 		exit(128);
 
-	for (; result; result = result->next) {
-		const struct object_id *mb = &result->item->object.oid;
+	for (struct commit_list *l = result; l; l = l->next) {
+		const struct object_id *mb = &l->item->object.oid;
 		if (oideq(mb, current_bad_oid)) {
 			res = handle_bad_merge_base();
 			break;

-- 
2.47.0.229.g8f8d6eee53.dirty

