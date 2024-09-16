Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072ED157469
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487163; cv=none; b=broYpvY+vaR7c9AgVn6qg2UuOd/8PFfEPaGeJuLctpQgGwfNNt0v5nnjmpCxPTazVwmmu96YnppnlPsQV4OGWCH+0noxs4H9q/cCN+D0RL590Y46xmJrdSYAD6uZDT0GhJbbJF+4o+dG0IAU99Bu47YhCAWiS4lD3EUEmnu+atU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487163; c=relaxed/simple;
	bh=nfgtXQhLoByL0Kya3WgGCHW1r8a3zL8Ja8SZ+nXoLN0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEZEDrEbnYdJqkfkUurCA6l3U0PFt07twcRGGZ0gk0Wqs0Fi5QLlQ6FR+0mOuk0t1Sdn1EcYi2oLpvec0rWdGyikNRH1LJ4Zo/AlH8bqKLnWpfFe5RJyTmUGES89AAMMYDGnblWtkBU1JsGYA9Gs0kA8PNFEUrhMAb2TmUS7U8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BgiTqZSj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ai2INHjI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BgiTqZSj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ai2INHjI"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12ADE114023E
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 07:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487161; x=1726573561; bh=zp2kMQQ97T
	frUpfJ5oYHVkDFmvwcTdJD/YWn185ZEpg=; b=BgiTqZSjQ4//wD+gXZNgaYrXXQ
	F218eVtIzvSYX7GVL+RLCMStHl/Sut6SaZwStQSQiiKbyf2xF4ko+kwvpq+mNj25
	NIdgjZfIRLECDLk4ulTHU2AbVjxBYh+nMYhw9bRmSgV5WLHF3l4xi4N8lx6LLv/0
	cxm/XSdc5KRLrRTKi5xqnC55fHk0VY2yA/NxcysR8AufEidMqhBNSDtSfUZZBrR2
	5OBPbhBIp/mqTxbNw3Yu3uKdKyCd3ANA4fJp747hIlQX1iBcPfEl97jxtAtHZl83
	w/RJ9dvdOBLCJMPcXBWbw0UgGlzl9VvBlU/miARSu70zQ6Xnp+D42tjGEZZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487161; x=1726573561; bh=zp2kMQQ97TfrUpfJ5oYHVkDFmvwc
	TdJD/YWn185ZEpg=; b=Ai2INHjIl7We6N9w0j5V92euGl6tixwtR5xrswWoLRpc
	vwyAUiQnvZ2TeB9MWP16sVASjoCZLpeP1AtZtEw8rwflffrVTfUnYZc2eIN+bOFH
	cb2DEH74wOXcaJPXxNkeBrNisUKHbLVbNYa5VHHIM1yrfsqGzo5SYcTyEBl05r40
	2PElT5qgznBxAemOnp5PN3OfDd7+WZBbhOs75Edx/swpZCskuoFa4ZJfuXXc8WMK
	noHfhZuPmpn8sa8AF08WoQIXn8vK/RcCWqFl5By3aFRqf2SgTo2XuJxiYPC81Wcv
	2DcrFaqiQOMs/73xFweBemy8F7pxB6H7SJ3c3vI8YA==
X-ME-Sender: <xms:eBroZog9M5bEryUSY-ZboTHHcpmeVuKE8zacHPTgklfZLw9T0kmxFA>
    <xme:eBroZhB_b-5yZhk506M6xUHXJSYbQ4DTXc1msZnxEEvZwe97JymoxLGYDrd-P5JjB
    s53gBS073dwhddrPw>
X-ME-Received: <xmr:eBroZgHSwatb0YheVf0COFlctIZlzhY_eBSFFXGjmDRK9YebZFPireKdzjEJV-jIV53_nDX9_x78mHsC6AXIAC2AW1TR9zI1S__NZUJ_I2UmUvxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eBroZpS8AgAPPdAvusMr2uCmM_lvC6XYy99r8Tp2NlS3wQ8e8qW6XQ>
    <xmx:eBroZlwHS-NJhhX4oYXNJpwCMT_RW-UXpcixkWaqh2els2yYwi7Efg>
    <xmx:eBroZn5mRUG5rWH0r61q70JqvTJqvfyasrkQFsmDC0sFnubh7N3Zdg>
    <xmx:eBroZixpZ1eIvCwTe8sz4LlX6t_VateQjlw0wYKJxX11ChutZMFwRg>
    <xmx:eRroZmpGNfzeXNQX4pcfR7q96LZJcl044tybQCrOrEnUrt6xOS49crgY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8b3dee57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:43 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/23] parse-options: free previous value of `OPTION_FILENAME`
Message-ID: <330b6c52a0a99ba8fa18378310250e5b617d40c2.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

The `OPTION_FILENAME` option always assigns either an allocated string
or `NULL` to the value. In case it is passed multiple times it does not
know to free the previous value though, which causes a memory leak.

Refactor the function to always free the previous value. None of the
sites where this option is used pass a string constant, so this change
is safe.

While at it, fix the argument of `fix_filename()` to be a string
constant. The only reason why it's not is because we use it as an
in-out-parameter, where the input is a constant and the output is not.
This is weird and unnecessary, as we can just return the result instead
of using the parameter for this.

This leak is being hit in t7621, but plugging it alone does not make the
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 30b9e68f8ac..33bfba0ed4a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -60,12 +60,12 @@ static enum parse_opt_result get_arg(struct parse_opt_ctx_t *p,
 	return 0;
 }
 
-static void fix_filename(const char *prefix, char **file)
+static char *fix_filename(const char *prefix, const char *file)
 {
 	if (!file || !*file)
-		; /* leave as NULL */
+		return NULL;
 	else
-		*file = prefix_filename_except_for_dash(prefix, *file);
+		return prefix_filename_except_for_dash(prefix, file);
 }
 
 static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
@@ -129,18 +129,24 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		return 0;
 
 	case OPTION_FILENAME:
+	{
+		const char *value;
+
+		FREE_AND_NULL(*(char **)opt->value);
+
 		err = 0;
+
 		if (unset)
-			*(const char **)opt->value = NULL;
+			value = NULL;
 		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
-			*(const char **)opt->value = (const char *)opt->defval;
+			value = (const char *) opt->defval;
 		else
-			err = get_arg(p, opt, flags, (const char **)opt->value);
+			err = get_arg(p, opt, flags, &value);
 
 		if (!err)
-			fix_filename(p->prefix, (char **)opt->value);
+			*(char **)opt->value = fix_filename(p->prefix, value);
 		return err;
-
+	}
 	case OPTION_CALLBACK:
 	{
 		const char *p_arg = NULL;
-- 
2.46.0.551.gc5ee8f2d1c.dirty

