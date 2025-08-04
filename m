Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7CB241114
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295448; cv=none; b=d+1JIPrz9hbUZFxRx4IV9EDHbSEf67GkFaPXV+5NAo/s//VrAtV77A0wANpPcl0++ZwOUVRWjjM0Hycc1rapwatXC2lLCQQEOZgSLD5Z54aUVkuVx6fH63oKYo/AVEtLfGRjxOpoTY3srbvJUgf4Oe6iNjqLgiUcygqeP2kV5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295448; c=relaxed/simple;
	bh=lsIsYuU15SrQjohIR9+CN37d+WKM6tvvuqdIDZcWVNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+HEdG9nj1dR58ArAJ36258oq55tISs+rCbSFgYJyOg5f2wIt70cJmc+GMYpLpVapElqkZhuC7MaedptcReDB4ELhyfY9tRf38Rc2LlnZgZH4ocrNHvuqfIE1GKS81Cio7rPlWjeAw7dAF1Hboeq/KV4/BhxhqciDq+7bZ0Q/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qluu6rbd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AXfVbPqJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qluu6rbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AXfVbPqJ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id AC74A1D00134
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:17:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 04 Aug 2025 04:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754295445;
	 x=1754381845; bh=vfAqAd3p/mq82EjTFViN8wCrh2YGSLNGRFjnBz7l4vU=; b=
	Qluu6rbdfgwlUMK3wjTThRjySn57211aKy8h/mfEkW6a11KRf6w8WfUnTzgBRlFi
	W5b7M2mVJWA2tXzCs+rSDzh1AV8wzNVLTPODiAyI6BFlj7gg/K1cU60Ary1Qg1S+
	t8ObdJy15Ztg2mxUZUsBTguBpxtU4RzZGwPkQWbRWaBlSAtDlcMZVHHQmognBgcw
	YDA8KR1sNGFcbuuh6sxgxvPQkxoTHlO+GePCQ5FEm78VfphWmQGmamPbVs/FiMiq
	zOjm54O6FaJG+RY8Obp+Us/JkXU92ICeQGAtNUA6YjQDrAqWHbk8y6soUc/XcX6J
	byc4XvR73sTPdOh3vBsD6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754295445; x=
	1754381845; bh=vfAqAd3p/mq82EjTFViN8wCrh2YGSLNGRFjnBz7l4vU=; b=A
	XfVbPqJg8mdwOF06JT8F2U0AZmeGfZbf/KjH8u8UEFw4JPtOxSZQgAVEeqjlkxl7
	fIudleaPySnQriTnG/OiiQVZOeRD/ZYkPfkFUpsN9QWXz7VNwFp0wtOrMV12DpiE
	XLPWmvOxp6XAR+Ce5f5eHRcih72AWz9wrHlcBirYuCXxegj2QehELg8FLuBNkFal
	4ui72JG9G3iKGPQobudBRwqwgDOMEXbR9FGzfJVeZDxcy3qxscWmVRbnlsx9014l
	4SQfjEHIXZoJts8CT1W7BrqrpQqTylFrSayjvVXtNNePn5/hATWv9LK1+AvzfWNG
	z6D/ZtFgKvBW0nz8fILRw==
X-ME-Sender: <xms:lWyQaDANN_YEG0xbhsz7UkwU5uPVToCur2p6T7JahQsh4kIBzyxIjw>
    <xme:lWyQaLgorI9m2SbVo89MTmpRG1gXIv1rqS77ey9SjU-U_K-RxLV_WXPuYCUH_GwOH
    cY-TIiKcN7Hghpgzw>
X-ME-Received: <xmr:lWyQaH8n-FqwGc43jBLV8fYcqdElt8m0wuhAxxL6yROQzZbi69zIaS95DllOlLaXePNWRpLVeEyqGqdaVJAWnYD7aJ2thLUUxdV3rYVui6M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:lWyQaH_gXdvv89m7PPIpzYi7zvThqzJYnHvMwgIHF3ajsTRxtAVhJw>
    <xmx:lWyQaACdaZdv0AgEIFeVkxc1Jj6e4Oqt5dhaML-7LwtuVQDmqUNXnw>
    <xmx:lWyQaHziBCY2TAU45CmzzLQu2ImzozzOZ34TiL2Xy2_WU5ZYJS1cqA>
    <xmx:lWyQaFR2c77FXlY3WKpopYofIa6Z9hvovC_9fbl-8mUEVDlB9NsOwQ>
    <xmx:lWyQaC4jTpr3cqxlMNYErQGSrLMSeTt0nLI5J6c2v5iUbB_DDe3UH9Sb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Aug 2025 04:17:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f712a5c6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Aug 2025 08:17:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 10:17:17 +0200
Subject: [PATCH 1/9] trace2: introduce function to trace unsigned integers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-b4-pks-commit-graph-wo-the-repository-v1-1-850d626eb2e8@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

While we have `trace2_data_intmax()`, there is no equivalent function
that takes an unsigned integer. Introduce `trace2_data_uintmax()` to
plug this gap.

This function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 trace2.c | 14 ++++++++++++++
 trace2.h |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/trace2.c b/trace2.c
index c23c0a227b..a687944f7b 100644
--- a/trace2.c
+++ b/trace2.c
@@ -948,6 +948,20 @@ void trace2_data_intmax_fl(const char *file, int line, const char *category,
 	strbuf_release(&buf_string);
 }
 
+void trace2_data_uintmax_fl(const char *file, int line, const char *category,
+			    const struct repository *repo, const char *key,
+			    uintmax_t value)
+{
+	struct strbuf buf_string = STRBUF_INIT;
+
+	if (!trace2_enabled)
+		return;
+
+	strbuf_addf(&buf_string, "%" PRIuMAX, value);
+	trace2_data_string_fl(file, line, category, repo, key, buf_string.buf);
+	strbuf_release(&buf_string);
+}
+
 void trace2_data_json_fl(const char *file, int line, const char *category,
 			 const struct repository *repo, const char *key,
 			 const struct json_writer *value)
diff --git a/trace2.h b/trace2.h
index e4f23784e4..115c45a1eb 100644
--- a/trace2.h
+++ b/trace2.h
@@ -463,6 +463,15 @@ void trace2_data_intmax_fl(const char *file, int line, const char *category,
 	trace2_data_intmax_fl(__FILE__, __LINE__, (category), (repo), (key), \
 			      (value))
 
+void trace2_data_uintmax_fl(const char *file, int line, const char *category,
+			    const struct repository *repo, const char *key,
+			    uintmax_t value);
+
+#define trace2_data_uintmax(category, repo, key, value)                       \
+	trace2_data_uintmax_fl(__FILE__, __LINE__, (category), (repo), (key), \
+			      (value))
+
+
 void trace2_data_json_fl(const char *file, int line, const char *category,
 			 const struct repository *repo, const char *key,
 			 const struct json_writer *jw);

-- 
2.50.1.723.g3e08bea96f.dirty

