Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C368191F8A
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162713; cv=none; b=biViN4TwL2ByNAgBcVAzDhnLJ40YYUprE0qWFWO1aDgnQJmvgl1o4etUOVzUdzqfM0Hj8rJhjljcRKuLnupJFFZfXUMYDUMJrPqaoRc2ge6P30NaXBCZqn0rgkaDAn5g25OKfinEO3jiXQCRw5fGYLBkkg5Imc0/s0QLJMP0+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162713; c=relaxed/simple;
	bh=u6BC6mmj5NKTyFYQsNNGowPPEXLi/85qwssdjA4Gcj4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPBBi6ixVD1oTzgVdqp+eTmIEe4zr6AI3gQ0UIzaunsPBcCWSuiLYyWNATkbsa4hiZum91llagavDNAQftmTOSdVY5K9LT8jMonNKRjDdfcAVjTBZblSXHY2z+AQHnLcw3KVTqLNZIHHzibATEgD2w/KDXg9IWUvrkIQAJlCrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rW78t6rb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BoXltB7q; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rW78t6rb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BoXltB7q"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7AFFD1151A89
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 20 Aug 2024 10:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162710; x=1724249110; bh=Snw0jvtwxT
	o/7W6+4Fw+sDMpgouwrcVw5ViBFUmoZI4=; b=rW78t6rbj5oREXxMnFMCyaMawE
	alQqwvzfF5yhxv50q4/eIpgL45DapEN6FKNHTXISiQ/xmTs646e15DIHeHEIUSky
	+H/k6NNStN6tGimZubxLFn1dE3O/jqUmwb7183Qm0IlS8e5NwppsgvJS+W38Gnxe
	ayUQa6mT53SN1tkTjJI+Q7uzkPzhmH56ynRd9D0y2F5XBjKyb6h4V2BT02WFpBpV
	ReA3ROFikg3bjHsJ1TROT1NYARIJlp9HRJIRV0aVEMaYkpf/2YtryHVG0F2ODTaF
	2ncCxw/LZgqbXJnEEX2PUuGd7dzpfpM6skcrQaz+3mnOiPF5V9x2PV1Oy7xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162710; x=1724249110; bh=Snw0jvtwxTo/7W6+4Fw+sDMpgouw
	rcVw5ViBFUmoZI4=; b=BoXltB7qzOCaVYArM+BmI9Ti2rvog0rSbWylZvGcbGyO
	Ln+Cy0xnfF/fJ0SC8lX88ji/O9ZASlmc868WzSLC5KcOnn1L+/Jgdrr8Knr8ootO
	Me4DExNgKnsBj2pktXi/+OkrjdoodNQH3mDNXhbfWuEzoaLnVYYmoiNFYfr4vyMX
	XiR1+hKAA7BWZnyGI57oAZUV8vzeSFpjWWxQSrK3zaFDa+k0sSr8kKLj864OAY+D
	LscyQBAw63BZChQniuj4sTY+fs8KvKiBUe8kZkTf5FvJ8w8L5iLAre751204flnO
	82wHr7QR0ET7Wc/i2BQmz1A7txmsUCO01KHXU7tFnw==
X-ME-Sender: <xms:lqLEZi2Rx0MWASh3kGl-gvT2rdKJUnFkch_ms9SoOx831k4tk95EPg>
    <xme:lqLEZlFa2UuFotkbWeCG85zKpGGA7-JsWYWXHaO-UlTHYvs2gKCseoatayvdGpGVd
    e_LJDhA8_o3PC8tRw>
X-ME-Received: <xmr:lqLEZq6SvAqxW7zX0Qg7ZwnLK3TBo-7u69BS-TU2_w3e70fwIgeIiyEY9NdODHDlKlcCOZa9mDMTNQl19P2eeXpv7bKdEVXninkDI7mrs4_QTOSUGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lqLEZj00Xl9R1HfpU-8neEmos7EmJlEuE777RKdUKns6bu83sMv4JA>
    <xmx:lqLEZlHQioiNtxbKevttQxLeTG2XpLbRWwQijND0VPEiKLL4HpXJdw>
    <xmx:lqLEZs8U1qMejJxsHUQ-LM13ZC7aHC7GMTAr4eX_UcpEwHsYrZMtTQ>
    <xmx:lqLEZqlnSjyU1sF0F8VHvcY2QvleWl07UZJiQ-GX24NvSNVV3fEEiA>
    <xmx:lqLEZjOqvlij2gseoPNPczDJ5cab3G_26FxsuVLVq1MoMUlqKVO1SH4C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 532195f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:38 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/20] pretty: fix memory leaks when parsing pretty formats
Message-ID: <82f3908f9620cee29e36a51f6d18ddcc8392b966.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

When parsing pretty formats from the config we leak the name and user
format whenever these are set multiple times. This is because we do not
free any already-set value in case there is one.

Plugging this leak for the name is trivial. For the user format we need
to be a bit more careful, because we may end up assigning a pointer into
the allocated region when the string is prefixed with either "format" or
"tformat:". In order to make it safe to unconditionally free the user
format we thus strdup the stripped string into the field instead of a
pointer into the string.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index 44222fb83c6..af8f433cdcb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -63,7 +63,7 @@ static int git_pretty_formats_config(const char *var, const char *value,
 				     void *cb UNUSED)
 {
 	struct cmt_fmt_map *commit_format = NULL;
-	const char *name;
+	const char *name, *stripped;
 	char *fmt;
 	int i;
 
@@ -90,15 +90,21 @@ static int git_pretty_formats_config(const char *var, const char *value,
 		commit_formats_len++;
 	}
 
+	free((char *) commit_format->name);
 	commit_format->name = xstrdup(name);
 	commit_format->format = CMIT_FMT_USERFORMAT;
 	if (git_config_string(&fmt, var, value))
 		return -1;
 
-	if (skip_prefix(fmt, "format:", &commit_format->user_format)) {
+	free((char *) commit_format->user_format);
+	if (skip_prefix(fmt, "format:", &stripped)) {
 		commit_format->is_tformat = 0;
-	} else if (skip_prefix(fmt, "tformat:", &commit_format->user_format)) {
+		commit_format->user_format = xstrdup(stripped);
+		free(fmt);
+	} else if (skip_prefix(fmt, "tformat:", &stripped)) {
 		commit_format->is_tformat = 1;
+		commit_format->user_format = xstrdup(stripped);
+		free(fmt);
 	} else if (strchr(fmt, '%')) {
 		commit_format->is_tformat = 1;
 		commit_format->user_format = fmt;
-- 
2.46.0.164.g477ce5ccd6.dirty

