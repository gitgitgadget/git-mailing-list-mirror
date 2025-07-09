Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C12E973D
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076691; cv=none; b=PCM7OnBK7k9Fl16/dUeCTt10xqUNwLNgIROE7J4HvVj6T+Kf/n8DW9EgsnSIRCN47W34blm5bL86TnpTnRPtTxj7PyNQKNNOrJasKtF98SARG51sXH4g7LaqzJyzZIGqWTejOT7EyR1U2IWrVR9Ki4Gu15jzo7AqW16Ydi9ybWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076691; c=relaxed/simple;
	bh=u1MANrlss2BHkZvGfGq7bCYt48Rji5n5I3B+XlR3rxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8b644mEDNLxtz6LkE79+Vjg+LO/sNWm3hKm8oWR0kwUNCKBgWLwvuA/GTYlp8dgAKFzIkcO5We6fUAQe4ccjdz5zLyLGISZ3NC3PDK3vHFxyCkJw/IkpANpqWSyvG+ckqArlypTEbPuFYP+AiekhR7smLtyjL4kNQqq55ASQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M0XN4gCt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYI4SJ4C; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M0XN4gCt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYI4SJ4C"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B58FB1400353;
	Wed,  9 Jul 2025 11:58:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 11:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752076687;
	 x=1752163087; bh=J/jJAOJZTzy5KR1HptaiGgIJbh6CNU4lQokv6c4JZg8=; b=
	M0XN4gCtLzNeiB8Rxh+CWuqHS2Lrs8Jo0ivKOC7mFHuP0K0Xc93FbuWfjhgfco5Z
	AFxbEsD0/fCVOP5unPwWxHPaTg9CYVRvcyMnuhsyoZ5W9xaH4Aqt1ExHhu2pnHHL
	qM6pLXgxv6qtUJ3i+eSXO666Ml0ck3VJ3tGAoLZ2cM3G9phdyxDpDbzhh39v1K8g
	/A6TzTiBcRepkWye/EvAddD7CIMHvRsDKt1T+PwzRhDEF3ZC/FbgY19dgcCoYJ9X
	jfvji+IV7yvETEFzLEOBi8v9Lu/SboDel8Z0s2JCuaAN9muprUGObg32hulfi6Fn
	8+cuNtlffn9IdbKWvyxDaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752076687; x=
	1752163087; bh=J/jJAOJZTzy5KR1HptaiGgIJbh6CNU4lQokv6c4JZg8=; b=Q
	YI4SJ4C+1XyOkPg6QL4E83CZzPuaEMASM+Fp5vAe6yv7q0MFA7bWSMwy7b/RI5kI
	OT8xKXxJIn4y8a+Gmtk5HJJDNIoAeeapQ9gLU5BHsU/WtVtpQCtU/LzBorSmeOC2
	sQbw+veiS9hJHmyWdVfsuxaQBPsOlwfVwvgGSi9viCfz3TUprXbUDW0nrrpvJ29N
	LlIL4/ZpPfCVE9TlSDXPlgY6RY0ymq131q2y2v43QQgpz3t+OSS2SSFkTz/2/+Kx
	DfqRGcMV0w7pUfEHRMv+SO1BPKOmUVKZqo7LnYJBJpHCtvytFsv8xI6zsC4ZEmoF
	kgOsFmuCsQs3CedRWSY2w==
X-ME-Sender: <xms:j5FuaMKi6-KdOLRSd1mB0DwRi_wTKuCPJSoyBBUcNK9geFih85bIRA>
    <xme:j5FuaMWOr81jds7CZXpK_UWUUOkxRrf01t9k2DbSawSDmSFDYTVBJEVTqqKwmilsV
    sUCeJn0qI1apQvhfQ>
X-ME-Received: <xmr:j5FuaOgQe-nltYpSxZWyGipJ8vQn8-FbmwGv1GOphMLm7jnXgfsOlgQESihyYErQ0dib8oYbcvbjU5sdI8sPsW0lAWB8Sa6B5zX1WyRPmFHcnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:j5FuaH8gPapH1WhYk-F_OBFhGwjctSF-JjeCYVZU7anfZmxlCEb-mg>
    <xmx:j5FuaIDb5BvB1kCRLdazQK64XAForzLH_DORvMVtRw2Ct-kDp0WR7Q>
    <xmx:j5FuaEIoO7OmF3semqD4E7bZAVXjEuGYbfSdUdIicTSQpe04EK9GUg>
    <xmx:j5FuaLlnBYGcUTJMRd38AnZ0u50-r6DdNhu5STaOwd8IyaGkFvdWRQ>
    <xmx:j5FuaGsnv5C8M9yyPzNUiH9O7zOo7a9uCMi11KM-b00BgbXbbXxTwy8U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 11:58:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c2aa277 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 15:58:04 +0000 (UTC)
Date: Wed, 9 Jul 2025 17:58:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] parse-options: add precision handling for
 PARSE_OPT_CMDMODE
Message-ID: <aG6RidvxUqV25Fli@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
 <77b841ea-eab1-4e76-98ff-f7a16653fcb8@web.de>
 <aG51nFpH6kMT95uf@pks.im>
 <144ecb24-4da2-4311-bf26-3101788f4b12@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <144ecb24-4da2-4311-bf26-3101788f4b12@web.de>

On Wed, Jul 09, 2025 at 05:05:35PM +0200, René Scharfe wrote:
> On 7/9/25 3:58 PM, Patrick Steinhardt wrote:
> > On Wed, Jul 09, 2025 at 11:45:14AM +0200, René Scharfe wrote:
> >>
> >> Call the function that does the raw casting do_get_int_value() to
> >> reserve the name get_int_value() for a more friendly wrapper we're
> >> going to introduce in one of the next patches.
> 
> >> diff --git a/parse-options.c b/parse-options.c
> >> index 68ff494492..ddac008a5e 100644
> >> --- a/parse-options.c
> >> +++ b/parse-options.c
> >> @@ -68,6 +68,26 @@ static char *fix_filename(const char *prefix, const char *file)
> >>  		return prefix_filename_except_for_dash(prefix, file);
> >>  }
> >>  
> >> +static int do_get_int_value(const void *value, size_t precision, intmax_t *ret)
> > 
> > Nit: after the fourth patch we have `do_get_int_value()` and
> > `get_int_value()`, where the major difference is that the latter dies if
> > we failed to parse the value. It might be easier to discern which is
> > which if we called them `get_int_value()` and `get_int_value_or_die()`.
> 
> That would be misleading because get_int_value() doesn't die() like a
> function from write-or-die.c, it BUGs instead.  I don't think it makes
> sense to advertise the presence of assertions in a function's name.
> But we do have a tradition of using a prefix of "do_" with wrapped
> functions that have a more raw interface and do the actual work.
> 
> Nit: They don't parse, but cast a void pointer to the appropriate type
> and dereference it.

Fair enough. I don't mind it much either way, thanks!

Patrick
