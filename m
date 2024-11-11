Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F219AA72
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321547; cv=none; b=ArK+pgzZudKn6tCWxvlrxS8WrXBSEtnYa3dk+IW+DIr3FXF9PNks30WQZBc+JHyn7A6Db3NzUOPc9nRrkNl1JUT5PhFNi7TlcEGsQwUdcU+ksDAim3nszATWUNDZyv7iKH+unftSSEeUHbDcAYvEEN+wqrPM2fu+oLWCg4zYdCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321547; c=relaxed/simple;
	bh=s5YEsYWfpPuYkkvo+T+8fo1iQsjcVu+3CVbuV6M47sY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcazm7R3MHS2mz/MbffXJ9loVCP8FzoCtmHHduOGBXa8+O48gYBAlrQbzwbixkCx32M7a/pc13eydtjNazvQLF26F/wrwx+8dzu+7ViJEbhUuxDSw2+EbZy0zw+hLzBVtJepaZG0V1oKWPZ5/zGmzAt2vCQTHlpDAT3BKGjvSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FeHg/X8T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fX9M3j4y; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FeHg/X8T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fX9M3j4y"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4B50114010D;
	Mon, 11 Nov 2024 05:39:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 11 Nov 2024 05:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321544;
	 x=1731407944; bh=/FmVEdYB5ZIf1GcyF0jOssmnXr/vC+AyI297O2/WUlA=; b=
	FeHg/X8TySeKPJBJ5sSwqmpDA82h3cub5c0PO5LH4JPhtASkbYUpH/4MPHP1h7nx
	bQwrLURzvr1PA/UmA5/m4Xnan7z2vY8bjXNGgKc8MPF78LGiDhUvxJmDmO331qHy
	MkFRTOxZ6xkIvgnebnsWXPCu4aqBVaOgAeQPbPsS4V9pIbnwIB1sUUtBXLu3qdoU
	805Js4HaUMglzug5opFfite698ctfGLW3ihduqtbs/a65Xnc7Y2BXiOKAug1RfRv
	Ev+uMq15eu4gabJD1cDt2B+B/b8hMNZErcAqPHIA4G6LodfqDUseo0LfCGB2QK1z
	aOFKX62PaAvBEU9c+fNEyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321544; x=
	1731407944; bh=/FmVEdYB5ZIf1GcyF0jOssmnXr/vC+AyI297O2/WUlA=; b=f
	X9M3j4yRGGKjtR3TDSiLz+z6CJwRtqgauA5f1lrqTtWgP7se7bvIYBJec1EDo7Nj
	c8iOv+oEFUmpcshr07hJg2K5RjpX/nxq9t66Mz5tojUQK+tMpGiVKufM7KAJ+HNm
	JvWRLnyI4uXEox4K+dMQ1SV6qN0chy9bCWQMwEq9ep8BUsvAx05UMbCFfn4uYtRp
	DYHY1G3w88P+JSqrl43Frq0XFKYaB0/N/2/4AuAr0oNFlUm72f2CHHoQdD93ID+8
	FyWm1nSQRpf/0gGY1CP8wmklizd2OnoVkkgDX0IaYyEj6srIrlTT9r/5tqyg+/bg
	s4/jW2x+uKitKSRc6aNuw==
X-ME-Sender: <xms:yN4xZ67Cbab8L1LSfrd6ffkylUfMC8-uVIGwHVE-qyHLaMHrfSHDIA>
    <xme:yN4xZz5UAh4IHcH8bZja8W8AmnMGClGR5qrT184x8V3uPcR6SVo3s9zUZ3e_Xvpiq
    uT1ZSSu3eVENtZrJw>
X-ME-Received: <xmr:yN4xZ5fqNUO0VVsDLYzQucaDodCtnVphjn94l0tEYznpWVBdaXGCBBbKjvtz_sxB9vkigSVDIptiTtandcMh393rYn9iVY1pqFmWoFD3OkM0Juef>
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
X-ME-Proxy: <xmx:yN4xZ3L4z4jMOLgvi86PXoUrCoy9xR0TkOU1wfqrgggQKrOJX_TVeQ>
    <xmx:yN4xZ-L4Hjta-cwXQ0DsNZzccg5GyBdm3MsM1VQb5M_9GcRqzTVhkw>
    <xmx:yN4xZ4ygCe11YtHsqPkRxtsdknUeeB1-v_yuBUQjuExYbI74W4mPzA>
    <xmx:yN4xZyK1BG9TsXRX9uTwKSwfFh3GHfFM26ZNhAzjWrtQmk8z2o-q2g>
    <xmx:yN4xZ1WAB-_l0wZ1U6SIivDd0wo6KAfCpJ5zdhMGNW-0LZmyM38ZQaWf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 91c7b0d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:49 +0100
Subject: [PATCH v2 20/27] t/helper: fix leaking commit graph in
 "read-graph" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-20-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

We're leaking the commit-graph in the "test-helper read-graph"
subcommand, but as the leak is annotated with `UNLEAK()` the leak
sanitizer doesn't complain.

Fix the leak by calling `free_commit_graph()`. Besides getting rid of
the `UNLEAK()` annotation, it also increases code coverage because we
properly release resources as Git would do it, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-read-graph.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 9018c9f54122833eaf9dde52ced06e354e1919ef..811dde1cb3c8809352f79428a589c2158fc62545 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -97,7 +97,6 @@ int cmd__read_graph(int argc, const char **argv)
 	}
 
 done:
-	UNLEAK(graph);
-
+	free_commit_graph(graph);
 	return ret;
 }

-- 
2.47.0.229.g8f8d6eee53.dirty

