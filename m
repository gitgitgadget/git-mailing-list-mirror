Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA28235C01
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564947; cv=none; b=YoHme0+yS+8RJKj3VAbUKYlFFPNYS+TB+ovb+Hd38gsVRVA89a8Zqm4EhDvoxvOtJdDyO3jjLY/xIGTdmQutsKd4FDBhbzI4i3nudnPcIuKOArghpVnv1FyTRrWKWqE1/5klDK2XPK8+CaQlusrbUHGw6TeVYB/vtfn9llv4Pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564947; c=relaxed/simple;
	bh=V5qaw86Pz3RWHWfb12KrEHhUBud1kPcTfksO9E+juM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=japeCgxjEvs3F0lIzPsse76J+RAHvg9KIMBEW8W1bXDk0aqKlF1HBJVEoCOhAb3f8K0WSQy3WbmwW4ZIOjy8AwyGIQikVfBER026gTbzay/33ZFvSMdShAxPhZ3EvUIbcCEE26qVAFCiPL4TkkHjfzgCHymVBoY+OhgVkj+PFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pdj6pgUS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjbsI40n; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pdj6pgUS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjbsI40n"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C179B11401ED;
	Fri, 25 Apr 2025 03:09:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 25 Apr 2025 03:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564944;
	 x=1745651344; bh=cS8dzkd7YjRmhY1Dj1/9RQ8ZwZl4Goe3+SKWRaDJnB0=; b=
	Pdj6pgUSW8M9po/9HrOEIUN7FnZkF9jW3ySA+6ZIYLWb9BIOO8D27swsaJHpo9DZ
	iX8ldfIADaeYA457ccf9PqOFjPhTcfA8oy1znUiMuc4ArvjZEFV+gJi2620Vggsd
	l2B/J3MsfYXHOXdg+P0zwiN+e+vRgw3AHzweEdkLclr9O56If5rjqiHTfFEq4Qre
	JcAYYs1vOmTjT2U2QQEi9iu8T47L7W0TwDwg7C079wXIppB6a1Yeonv4pAsTN01N
	QMnpluhzKgDfSVcombciA1PBVYfRAyy53j0Eicx9iqSeC29cY97NDZ7e6YFgsCKh
	NebovzfV5wyRF8BoplCbpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564944; x=
	1745651344; bh=cS8dzkd7YjRmhY1Dj1/9RQ8ZwZl4Goe3+SKWRaDJnB0=; b=P
	jbsI40nQkQKd7rjRE8pCOQVpdPm7ITmRQ7PpCJKiuArU47oow5YecvjSx2f3uZ/k
	YqHeyI9zzzCN/yMi6Im+XJffhYqU6wqspxss5xDz4OvJ8R7wbNdfOJ4+8RgNBFfR
	yrE83dyS0qt/irrkGH7YDgW34girrr4GQMpbhQmhnoompgZ+VshLuRVn0wNLQ12d
	Xx65SBrHP96yyXExJqG7y9V0jVsW0SVlhl5uuXpvxjTlDLUI765E8Xrv52An2rTp
	bcIrFCoiyiK9IrjmXWMWbJAHURySKYRbMuAqv+egl6Y0pZV1y6mPlCGHEgjjkRNd
	Kafl09WlS3O9AghOT3tJg==
X-ME-Sender: <xms:EDULaEJgFdynxKy519Jws_r7SQWjLG8Zv0OBJYlkJPzEGvLtsDvtfg>
    <xme:EDULaEJkYypk3qXiRm0uWDcp-sYUGw4cw5lkGzjfP5ZYsW1FW4e8IJyMhR_FD9yt2
    hUaqHLxGZNhCT3s7A>
X-ME-Received: <xmr:EDULaEtUnfi3TBaY-lWrAGVg01rMKeSqyZBfFQ9qU7gKTXb7aqu3ENAeR-Oha8UrnIpMwy4AdOYFoZPXeLIGTzmeQuslODOQNjoGQhk3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:EDULaBayvzgIdr_2HMLseGcTlcIgHIACOLI8y3Kh0sVoOb_TsgFEzQ>
    <xmx:EDULaLZbKuBMlKgupZFhDg3DxjOV-t1MLwp_7loahv8o6M2GRG0C-g>
    <xmx:EDULaNAsHWHRk0hKZxtYPl1S-ULmoQtECvQx9SlrayPCPY-4wJXZ_A>
    <xmx:EDULaBaGDLIZaT_wKddiqodV3h6IijjadUbjWs1ajbGhtsB0cgjobw>
    <xmx:EDULaC3qs1iQjsQ28O7OVibZMwvy2wjumllz7cNze2DccM_VOvOWvSdZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:09:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1f5cff7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:09:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:08:58 +0200
Subject: [PATCH v2 07/13] builtin/index-pack: don't fetch promised objects
 for collision check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-7-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Any packed objects indexed via git-index-pack(1) are subject to a
collision check. This collision check has the intent to determine
whether we already have an object with the same object ID, but different
contents in the repository.

The check whether the collision check is really needed is only performed
in case `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)` tells
us that the object exists. But unless explicitly told otherwise by
passing `OBJECT_INFO_SKIP_FETCH_OBJECT`, this function will also cause
us to fetch the object in case it is part of a promisor pack. As such,
we may end up fetching the object only to check whether the fetched
object and the object that we're indexing have the same content.

This behaviour is highly dubious and more likely than not unintended.
Fix it by converting to `has_object()`, which knows to neither reload
packfiles nor to fetch promisor objects by default.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/index-pack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f49431d626b..805b7aa1e28 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -892,9 +892,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 
 	if (startup_info->have_repository) {
 		read_lock();
-		collision_test_needed =
-			repo_has_object_file_with_flags(the_repository, oid,
-							OBJECT_INFO_QUICK);
+		collision_test_needed = has_object(the_repository, oid, 0);
 		read_unlock();
 	}
 

-- 
2.49.0.901.g37484f566f.dirty

