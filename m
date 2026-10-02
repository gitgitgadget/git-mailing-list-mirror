Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79E443319
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926469; cv=none; b=PTt4d6Lj1VjizwP33LTbQCIerS+HGspOHuOqXbjIkiJDHYHRn8bSSzwtBdDhrze8R/rY33KibXM+AoGXeqJ3RmTmtHjeq8PUCiStuXFXqkK7UWnePexW0AFPMelRDKz3bgPCB4Mp83+fGWbg1PJXfcl10eUT6hQsMJnOPADj2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926469; c=relaxed/simple;
	bh=/Rx/4EjI3E6oXHvxvvT+eJ97KbJCCV4yyw2knOx1vnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCPyJ49cJbP9zmN+rNva1lsAya9ONgvI8U8Yrcocx4PJcQkzZ6ZqyrPPhiTPT3jKB/5iZAf2RSM66jfXy4/aTGoVZ770lv7KRg0XgsYixc1qEGvuHIaKQ7vOTrDKmgjn1WMoIaPCXr7yBihUc7TNTbo/PO5nMaYiUiyNGPf4ygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YIYf0OZ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=en6XPCXT; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YIYf0OZ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="en6XPCXT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4524D1400168
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 03:34:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 03:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790926467;
	 x=1791012867; bh=ilNi2TZ/cPJBcDc7MDF198UQ6BLOrUOWXuJRxupOp1I=; b=
	YIYf0OZ+HjGI2L+MOY7hT4og9+iVr3Dxfct+QmTsAaHmlCy/Fjk36wlqd1wzkzRM
	syLC1JRjHlOZXjhXaDT4Gdfh0oLfoYldxj4cSrKj1beq9e/PDXlzopD9Av53wABF
	rXo+uLhZrsUGrEEAjsQ1E3Ra/MHmUhWdXohPxf4lalxcAE8qFMZLtHaTmWTfbSAL
	Vf3UtQGQKxF+j1lUylJrcUn0a+0ZqR79p8LffGc0qWPe/+acT+VNkyrtf0gBwL3i
	ffgzNbiwN9DqBg+n+hIAAVxkO1HZAApfWF6G1Add251/4XeoGEaT4I8LEuq9vKBW
	ZsPPyj3eAbKcbr3kHhe3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790926467; x=
	1791012867; bh=ilNi2TZ/cPJBcDc7MDF198UQ6BLOrUOWXuJRxupOp1I=; b=e
	n6XPCXTdh2H5Oe4kJiFTtgaBHHmzpVB+eux+yrSL64WMrqM8BEfnov1o53QW/jWV
	YaiFgjueVItB6wHSy1nmqx+dyApf7L+7+w+8+h8auu7+hjtd9wa4n91kFW3ah6As
	sgOs6g6l2rQGx9WGBwMx8EoF58IIp28cbHQ5w9Kfpqu6xa7OOQB/C4BNuIFXZjx6
	peZi/u8U9VfaQq1PuQ5Ex5uBh9a3Pw1L6I6/8V2t1kYdff/GtLgLKBqENivMwzBi
	e2MnRBHzqw5IKQJoqQO5ykm1yLBnsCHtIwFMTzx4RWZ5Qp9fM5wtmHhnHqtuV85j
	5wzjHRzx3zscMVDUAEn0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790926467; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ULnpYePrnK+6PfsXeOYIh/H+9AwmanwYApzfYJpe5E1LwcA
	5bakRIbJ36euLvq6y+uFLH0pp1s7Md9teuvYOys8AMaswCxwDZGx5Z9qmWHHjXWr
	qLjGzssD6HMjhmKo/NVPHI5UXBN82p72SXfH+yYXLPj5yUVOCzjABEg3S8iSo5Hz
	jD5hEI0quva+DKiFn2ODgIAPUi/mXiJJlF3TPrMlQksqMJLSKk1PnRYPdXUaoRrw
	QTgFUM4DhvGuraYLKbMeQCzTyQzsEoY5LyI45TqNIFwHcmzRxab3OCoAI8v8y7d/
	xsF+P6ur7OVDZlkafknMOGWBaTy4yN7w5awWWSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WkZXp7WlMwNuPQx3FAnx73ZcYWlSsi5qbOtkJatLmsE=:/Rx/4EjI3E6oXHvxvvT+eJ97KbJCCV4yyw2knOx1vnY=;
X-ME-Sender: <xms:g16_at-EV8j_sTzldyFrFxj8baEp7su1ugYX04NlIWyWFuNuR4nwbg>
    <xme:g16_apLkCYD7oVDUQllJDt9RFthvYyrFJMeEn-_zttwMEYa8p4-T9K7ca-YmmqcGk
    hwMeNeyaqUGBrd91ELrmoLnEuBZWiRCqec0Onos93GPmuPSan0UZhNR>
X-ME-Received: <xmr:g16_aoaGp-4dxfUIzWMA7XUaeqihVQ3fc7qbm8qeqtSZbSaUA4-gKw>
X-ME-Proxy-Cause: dmFkZTEP3KwCkB75OTcWIBCH0pP2HWg7IV8j4L/feKxyHCflRWjjUONKg5GANVXbd+6KEw
    cfHynXX7LNmxY228ewmjje5LjD6dh/fR4cg4Ds+FB+K1w8g5pGIHkzr5255AATqTZGMhPL
    RDGH+lEP4yKFRyhPmIyX0ISWFdOJjSVaVRgsruWX8DgET8M8BDp76hB5AJvDQbprcQkWui
    W70Yhj4RFRYD4w9002sNY94TA7BtZebQ6N5Y3TJplM38pNVszWS1mfEvFsXVJrRJ4eBcbo
    E/jtqwMNQaXjZvS4FqJfyENB+Vud9IMpWpB/FHWM1FKYyW92YnybG4ozKiv2U+sAJdlnZ2
    sjwpzQd6rx4L5yGxu+ylCOx4W4ltVUoQulx3Curz9653NZ89ae92lEIcknLd6RHKyDUXn7
    kyrF7gR1UTufDgTgsLRVk35rlUFl7fEFCpvNXRbg1Ht08MnvzAh/EfskJAK0utdQbHN0FS
    utNVdtIHo8G5ovcRcpx/ni+d9PBn6EKP7H6c7ae0lNNrR1gaaLhCmP9kJhbIYNXhpPd274
    WfYOn2XP5AQ8c/hCtXIX3YEhTe7kG3culikxd3zcmIyDcOxpKynFHNDRIAnmi7Q+PQ5yYH
    r7FOfM3ZaiO2SrTd8fFXIaWI2ypyibCk+E9DTf6gELBvwwunwUHkWyzEN23A
X-ME-Proxy: <xmx:g16_arIug0DI4wB3SGxfQ-GgHq5FJzwlum9jHsm1eW7wQWE5SQLXbQ>
    <xmx:g16_amBJSCbgdKzQ22peae4hN6wbHpID61kw7sf3qyxKm_3VfFhouQ>
    <xmx:g16_agr_xC0JpoMlDmJGTmeZ8-cwpfBuNidg8-1A46zsOKcjFLVO2g>
    <xmx:g16_ahidDrFaRssheVxmTDfrspSg_MTP37lR9_QVxD0GxbRUtmlQMA>
    <xmx:g16_ahU5XVcDjka2vziZTiwbu9ASq48OeLUJa7SJf0iiZmDXhPkoSk10>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 03:34:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc67b5f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 07:34:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 09:34:06 +0200
Subject: [PATCH 1/2] packfile: move around `close_pack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-packfile-stale-delta-base-cache-v1-1-7592a3e31ae0@pks.im>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
In-Reply-To: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
To: git@vger.kernel.org
Cc: Guillaume Chauvel <guillaume.chauvel@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.15.2

In the next commit we'll want to access the delta base cache in
`close_pack()`. Move the function after the declaration of the cache to
prepare for this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/packfile.c b/packfile.c
index 4fa5fd67c8..af1b837974 100644
--- a/packfile.c
+++ b/packfile.c
@@ -355,16 +355,6 @@ static void close_pack_mtimes(struct packed_git *p)
 	p->mtimes_map = NULL;
 }
 
-void close_pack(struct packed_git *p)
-{
-	close_pack_windows(p);
-	close_pack_fd(p);
-	close_pack_index(p);
-	close_pack_revindex(p);
-	close_pack_mtimes(p);
-	oidset_clear(&p->bad_objects);
-}
-
 void unlink_pack_path(const char *pack_name, int force_delete)
 {
 	static const char *exts[] = {".idx", ".pack", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
@@ -1263,6 +1253,16 @@ void clear_delta_base_cache(void)
 	}
 }
 
+void close_pack(struct packed_git *p)
+{
+	close_pack_windows(p);
+	close_pack_fd(p);
+	close_pack_index(p);
+	close_pack_revindex(p);
+	close_pack_mtimes(p);
+	oidset_clear(&p->bad_objects);
+}
+
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 				 void *base, size_t base_size,
 				 size_t delta_base_cache_limit,

-- 
2.56.0.353.g0856645cf6.dirty

