Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A364216E1B
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840885; cv=none; b=nLpeuekaYstIfIYT0tIYeXHZGbGZgKIYgDbjxEtgtMwe0rJtU1EtgI61Rjl7VHgcSpyrWNRPwyQxh8RQGmo7G5aJVTSnmfSR8/PlRqROXujkYja7X+cx/lyz4+aVljnC5rieFLGSWq1S6TOjxwtAt+XAdTLDqJanquzoSOqdicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840885; c=relaxed/simple;
	bh=xgjSs+C+JaR39nbXbqRWPlpoRMWlTUkaUxzVfbZIkRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OlbZEq8jCmHE3DiK8s/KB5gRmKyy33lXEjAMqV5zBJaqMhuKMc+jFPPlealvCy5LHroB1lU2PMGWToJy7Ad79TnShJYnUouYWrVxhqh27Pm1NejkLR3pJYNmCKsp2LA6/0K20glatdhHC6wxi7DnSaGlnZhau8G21StACtn9V70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rFZ4qPOo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZqa04vs; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rFZ4qPOo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZqa04vs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B114EC02AE;
	Tue,  7 Oct 2025 08:41:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Oct 2025 08:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840881;
	 x=1759927281; bh=Mq0tPSCs4e5gIOTsC3Gmo4cncnRjlL1zbKielvJzQTU=; b=
	rFZ4qPOo2o7vVLN4mNhg7fJcoNP4RuWXxdydP7rOl3InbAssv6tOQD8ZiBnqa+Yr
	rCSFvpkVqJsCkbNzxdgcQoRCtr2jpEvIdOmoA6Gr5caAEgf8MV9MOPd6Guom3xKJ
	aW0YZ2Mfm1UI8nY+4NUbaqWCQNGTf7iu35MdUxyFOqEwC3urLAIm50vPK7Gd4fPl
	bE91vWKLOI1uUjZjCI97TTBKTSoR0LCkkCgdK9x9TR4zgpmqK0XVNTUq5AOKjBp0
	TVkBgQGS7eCYey9sThUB6rXxlAeIxP7jn/xTTlfKbJlb6lFdb294Y8+JdgmBJLaY
	EtlgyXU30LKi2lgTwcuBVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840881; x=
	1759927281; bh=Mq0tPSCs4e5gIOTsC3Gmo4cncnRjlL1zbKielvJzQTU=; b=E
	Zqa04vs5vAF37pvRtpnYHFZCCmfJqg9wtuptmzeEdyHjQJCEdG76I7+ZZ9E7c7Aw
	ss/vf+nqRdIhautbPgIyrIelBtSVRRpeZNeqINYE6q5p0BpEd+D68uEkQ6MbCNyB
	mNHvG3f3hDpDuo6iuaaLrzdp7pdI+7itYofnZc4wYfnXlw5EXJ2ck78JzfvtVu9F
	GPRqXGnWdh2BoHGXrJTdYSWbCtV0T31Qo4WGPspz4l9NnROlvvNkOx/de4wMEHYP
	f3tAfVAXxjcpb89LsEq7tuuAtZFl/t362pZ1UvsjlhWTrVqq6fOIDb3Tbu7phljn
	XlBCzAc8lpF5JPRo6oABg==
X-ME-Sender: <xms:cQrlaG8bAyFhWpNpcKufAv8MRqeYUO0vuYGi3h2zZruG7nBK3Xn6Vg>
    <xme:cQrlaMsH4D2ATR4BDKte6IXscTiXIfEaOtE2-d4mlg6HmXlzW5B9Ej_6fD0DTCqsz
    RBGrlLjo-RclG9UwVCtQr5uFgYZ_x8sg-NQLdy8RJDevb0YTT_A>
X-ME-Received: <xmr:cQrlaJqp0Azn4rOxSYZh0YqYgrtwF_DEurKIYeVB_7ZiXQgHVrBfcN_UP4_EOiBHPWNQHwHZHDNoZX6Cipnsg6A34iQKTqMQ6xzCaxcj2L0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:cQrlaJnbCvvOoN1K2IhZpi-HGcJ9EmTGsDla8L_fTLdARmOI7L7Spg>
    <xmx:cQrlaNxzva25wpIonoLNTuWAGanEi3F0Oh95hZkI7zqyZL_a-PN9jA>
    <xmx:cQrlaBnoKWTGCk36xIkaMktCPgMTIhk1y0ZfnDq3sdYxIuCtMFcCcg>
    <xmx:cQrlaGf7_swJMQzC-RSbPDUboDHqnlUg--E-1PH4xEgamVf7yN92-A>
    <xmx:cQrlaLHgxDO32UAIi1tHJDkGGMPdhQDgXYcE3FZGBoJoCi7WOnYQiAuH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:41:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6e3eac1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:41:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:41:09 +0200
Subject: [PATCH 3/6] builtin/grep: simplify how we preload packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-pks-packfiles-convert-get-all-v1-3-428227657a89@pks.im>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

When using multiple threads in git-grep(1) we eagerly preload both the
gitmodules file as well as the packfiles so that the threads won't race
with one another to initialize these data structures.

For packfiles, this is done by calling `packfile_store_get_packs()`,
which first loads our packfiles and then returns a pointer to the first
such packfile. This pointer is ignored though, as all we really care
about is that `packfile_store_prepare()` was called.

Historyically, that function was file-local to "packfile.c", but that
changed with 4188332569 (packfile: move `get_multi_pack_index()` into
"midx.c", 2025-09-02). We can thus simplify the code by calling that
function directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 13841fbf00..53cccf2d25 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1214,7 +1214,7 @@ int cmd_grep(int argc,
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
 		if (startup_info->have_repository)
-			(void)packfile_store_get_packs(the_repository->objects->packfiles);
+			packfile_store_prepare(the_repository->objects->packfiles);
 
 		start_threads(&opt);
 	} else {

-- 
2.51.0.764.g787ff6f08a.dirty

