Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09421E3DFA
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502918; cv=none; b=r83AcQKl5nYrz2jt0c6/PDsNX5NodRh492KfNcT+NypJdyOsLhiqRVYlDY+tb6YGxl43DBraBSHQVYFBT3JC6/R16vt2/+zoP0DerOAr/3FEwRAVivEXpsQ7i/QmN5tuHSRH/rvsPvVrvKVyutTx4H2E50Faqa0SFwleGET7b9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502918; c=relaxed/simple;
	bh=FQsIlr8FYl8hS+XdjGw0Z0vo0mh3JmW8vkG5jW+rjPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef0ll/FE46wmrbUTZs3hFL40Uh8UgoqjddCuK/a9Qmtv5EY+xpj4xTjVQMBlKh2KM2IfrFk/htxwGkJVVCheCSjSLQULggvekNrQzgMcXjqBpnVktcVVPuipIRT+x6NOX7RvMC83GdnZ2b8PykYlQNc9hUvVvC+8coVtFN8QfcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PUAFXonV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQ+5B3lr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PUAFXonV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQ+5B3lr"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C58D41380267;
	Mon, 21 Oct 2024 05:28:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 21 Oct 2024 05:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502915; x=1729589315; bh=Lp8F+yjwHt
	d41DHePMtsWb0cKfrAyOG0fG3YpB+rrc8=; b=PUAFXonVUge1d2w+ilE0IUJpmp
	VXjpmJ4kXPrU3N/9H9/h7YGUYWkYUT/CnFgszVv3tBSEb72vtJNNQzwursc+arYh
	58UZd8bJhGh6iXL+ATEvykMWIku4HN18qVdmcwr+Wmazt41d2xJK1aJ5pRlzNm9J
	IHWzw1Mx+SR78sl87S+R972tETkLUqy130oygQJDF1xt95wL0BZFIGwXfW71m1Fa
	PsPYHXgat7x9RmbQWwKImhlX7WqXPLli/RsFdEmJBty9VoKyxhklDeylKd3Ms3Fl
	URQVv6mctIG1QfD06aJW9HmhWci41fVJvwMH1luHn8/5PTVWoTpy6esx7xGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502915; x=1729589315; bh=Lp8F+yjwHtd41DHePMtsWb0cKfrA
	yOG0fG3YpB+rrc8=; b=hQ+5B3lrfQlAEPSfanfWb5Y7EKO+EyEXPj4sCIiiwLJ8
	BnwKI7dA2y6balIJZwJTTiC8+BK6ivyG7/fQFyp6UUQHVOZomQDMg4BfFbRY6YK9
	ZiBPSPTjPepd/abETgb4RjpZ7on4x5f3PwrUs6srmbvba729xIBglKyYnmwef5fJ
	A1jDwl5TBkIVWOfvRgNpJNrtvoAlJFswBtAUo+A1tMhr9givgElf8c/VSBNuqzLa
	KMDjZZv8KNeX6Zu8JwBw4AWJtiULNqkQe3QNHgHw26FUiI7XR/szLU3ngELuivAq
	XSfayMO5otrqvj/ur8+vm/tSOB7LkIitNpD45o9zsg==
X-ME-Sender: <xms:wx4WZyw8r9oQQSul4-lsW_4apc74Z8qXebzttQgTRH-gkuwwgBdatw>
    <xme:wx4WZ-RCMnXs4fkf6c01LoTqjQs5B6WAIwzSBKiVRWBvLJhQauNMZeg20EXIwklVr
    2zt6Ddlr-HBGTnutQ>
X-ME-Received: <xmr:wx4WZ0WrD2jLE5SApnPBaucO21rOgdEsJo1WrZWHq0SWuJzg41RLgN_wjtVnz0i6NfKw5hMX9diMCnN0fO60vGJMkJYImAQE4_NaDuxmx8Ga>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wx4WZ4hWC2EJxJixSw41hn_lTs-5eFK7R7YUm5O9U7QbHxncMRZJ7Q>
    <xmx:wx4WZ0DMNXMzmRIBgJyY4hy1SCHIEOzjFXwIn3vhMYyaPISFW-G1uQ>
    <xmx:wx4WZ5ITUK-ncWl5cRHUGrBWSewWnLqhXXs2Qe1WMs4IrGmTPOgTyg>
    <xmx:wx4WZ7AS46-gMoDZ8ORl0kJOvDCSKr7siSkFDLwX8EB4RE0jXWaG8w>
    <xmx:wx4WZ3OZPL3o9YH9tWr7HZ_Q-bNm7gRibOdEIUWvKe75URNRvxuhOIxI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4434f8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:07 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 10/22] trailer: fix leaking trailer values
Message-ID: <e3ffd59123f23f53c0bee930ef7602acf2d800c2.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

Fix leaking trailer values when replacing the value with a command or
when the token value is empty.

This leak is exposed by t7513, but plugging it does not make the whole
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 trailer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/trailer.c b/trailer.c
index 682d74505bf..f1eca6d5d15 100644
--- a/trailer.c
+++ b/trailer.c
@@ -249,17 +249,23 @@ static char *apply_command(struct conf_info *conf, const char *arg)
 static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
 {
 	if (arg_tok->conf.command || arg_tok->conf.cmd) {
-		const char *arg;
+		char *value_to_free = NULL;
+		char *arg;
+
 		if (arg_tok->value && arg_tok->value[0]) {
-			arg = arg_tok->value;
+			arg = (char *)arg_tok->value;
 		} else {
 			if (in_tok && in_tok->value)
 				arg = xstrdup(in_tok->value);
 			else
 				arg = xstrdup("");
+			value_to_free = arg_tok->value;
 		}
+
 		arg_tok->value = apply_command(&arg_tok->conf, arg);
-		free((char *)arg);
+
+		free(value_to_free);
+		free(arg);
 	}
 }
 
-- 
2.47.0.72.gef8ce8f3d4.dirty

