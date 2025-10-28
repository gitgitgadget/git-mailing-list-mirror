Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DA2BE024
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633554; cv=none; b=Cr8d49rS5PqjVaYz0Mdn7Di+Z3Nf8kXKkCBD+kpfLHteVKzKY+mLfv8e356PsNKONNMiKS3FBsms3VU2icxk4tKLGeChiuwdK72iAwiERpQ3ZP/e2SgT7xfgJmeOP61eDOdLJTKPHVw6UOv4mlahUq/uv2UOJmseJVxB3MByfVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633554; c=relaxed/simple;
	bh=UITO7Y9EECWFNOIWTry4lJUIUVXG33JOvdMpHInHtT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYRKf5mnJY6qurFK+zVk36yVR/lrJOZXSglrD/pUcOzHl5jdXaeeG3C7874Hvdng9JFgFFZdA2I0gs+ZZuJbulzHvKG9/oMbsJmSIy/2Ial+jpenlRk7g7ExdasCIxVP5gpeMCXpPBkUGYXdrkZ+WugoItr4kjl1kqfUskWD/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hJVxQYV/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x3SybxIb; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hJVxQYV/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x3SybxIb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B1621400286;
	Tue, 28 Oct 2025 02:39:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 02:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761633550; x=1761719950; bh=5wIsnPIWLY
	A8oCtuBwnZdYhbpbZRrCkHxDRIRVQJjcE=; b=hJVxQYV/yJ+Fkcb61K0j3g1U7L
	p2eVTjrfFh8ao24I0t3mflYk5VQaRiqgxjlXFRQdaip5JwYnEFumWaojVTWK9LQv
	LKHkd/gdKwctmj35epm61L7UTeDrTIJq9Io6sEYAoHjZKYeyDga+p5PLRBkMZTjq
	P3uHexvxdijpT9gILQkCYjDJwBVBTJ0bL2SEe8S++MToQkg+dOZv5NiDkSswbeO9
	OOIjQgXSZB9zUY0iKLBQzcLGopmCC36LO8OVhPDxKJWKnppYO+d4nK/qrGmsp7pq
	JaqekUH6ZHOHJ+ilX7CvvEZTPG5IJ7qFcFy/xp/F+V3cPMDCMIpmXMicZwHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761633550; x=1761719950; bh=5wIsnPIWLYA8oCtuBwnZdYhbpbZRrCkHxDR
	IRVQJjcE=; b=x3SybxIbS9OFIMrN1KyoeSfy4NVjwrObV3hrvj++L6TZxm0G++4
	n1KenWnvUMRw8DFa9kIPqBZar7XJbQfD1IeTcHr9MY5knQCteSaCI1bwwOAH7HdW
	3j5z2x+/hMyd98Tei3gfGbBvluGlDkZGyBc85lJG7mMUiWUOLAYkvQWySkjOa0zj
	OmIPC1xWE1x945ij0I+bu0bEu2AaRUspP5ISLI1471UE3CG9TDi2xF60dpAMhaBc
	KM9Fe3QJlTF/C1QUeq5T/k5QgSlFjts+P6nTh8FHzTKNCqSpHpSTevWUWYC2KWUa
	/RrqiStQHRjrZd2qYEHFLoC/9pOkE4YKZxw==
X-ME-Sender: <xms:DmUAaQ1EAVmmPE3IQJYo8QE5sBtGYTRs8yE2VhrXPuAGfJLyBcaN_g>
    <xme:DmUAaRFHPeM71ewDjl6elU4shmEwbsv8ImzzKjBtlox2_ur2EFSZBMwJ2CZSuj8Ao
    ezGae662XqZPmpAr1AW23dOZP_vWR123uI2lZWHNQaoFeQnwz9JEA>
X-ME-Received: <xmr:DmUAaWh-5US6gOORUcdy3zfSKIL0dfb5x1MaYFNYcAvQ0GpfF_Tg01TpkFNilQCkVmQP-zgxAtRFvnNnwEUkVViIaHl9eAjEdJQ6NrtBew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DmUAaU-LAmUEbGIaoMCYrSwWs9KgNmdB6LfsQ3_VgnkoajPbxXuHnA>
    <xmx:DmUAaVrI2CMNzCTsu2lWZEfMTdXiygwgbR5P5ioErXXpxhx4f2BEzQ>
    <xmx:DmUAab8V3mNiZ1DHBGr92Ss05tcr3AkY71tFNgVe1ijkcdPXSXS5Ww>
    <xmx:DmUAaRWPwZa6TBd4fYgBk2MXj6jsPpVDjWchN5xi9iHAzk5dx2gLhg>
    <xmx:DmUAaZ7FQSaTVQhA9418sYidlvwo33u-MOtSGPn1RqD0ikTsevilfq-m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 02:39:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44f615b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 06:39:07 +0000 (UTC)
Date: Tue, 28 Oct 2025 07:39:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] whitespace: correct bit assignment comments
Message-ID: <aQBlCCDWMhLX_aBa@pks.im>
References: <xmqqfrb4hyjl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrb4hyjl.fsf@gitster.g>

On Mon, Oct 27, 2025 at 01:36:46PM -0700, Junio C Hamano wrote:
> diff --git a/diff.h b/diff.h
> index 2fa256c3ef..60749154e7 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -331,9 +331,9 @@ struct diff_options {
>  
>  	int ita_invisible_in_index;
>  /* white-space error highlighting */
> -#define WSEH_NEW (1<<12)
> -#define WSEH_CONTEXT (1<<13)
> -#define WSEH_OLD (1<<14)
> +#define WSEH_NEW	(1<<12)
> +#define WSEH_CONTEXT	(1<<13)
> +#define WSEH_OLD	(1<<14)
>  	unsigned ws_error_highlight;
>  	const char *prefix;
>  	int prefix_length;

Here you're using tabs for indentation, whereas below you use spaces. We
should probably be consistent.

> diff --git a/ws.h b/ws.h
> index 5ba676c559..611c6b6d50 100644
> --- a/ws.h
> +++ b/ws.h
> @@ -7,19 +7,19 @@ struct strbuf;
>  /*
>   * whitespace rules.
>   * used by both diff and apply
> - * last two digits are tab width
> + * last two octal-digits are tab width (we support only up to 63).
>   */
> -#define WS_BLANK_AT_EOL         0100
> -#define WS_SPACE_BEFORE_TAB     0200
> -#define WS_INDENT_WITH_NON_TAB  0400
> -#define WS_CR_AT_EOL           01000
> -#define WS_BLANK_AT_EOF        02000
> -#define WS_TAB_IN_INDENT       04000
> -#define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
> +#define WS_BLANK_AT_EOL         (1<<6)
> +#define WS_SPACE_BEFORE_TAB     (1<<7)
> +#define WS_INDENT_WITH_NON_TAB  (1<<8)
> +#define WS_CR_AT_EOL            (1<<9)
> +#define WS_BLANK_AT_EOF         (1<<10)
> +#define WS_TAB_IN_INDENT        (1<<11)
> +#define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
>  #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)

The "8" here is a bit curious, but this matches what the comment says:
the last two digits are the tab width, and there of course is no macro
for that.

> -#define WS_TAB_WIDTH_MASK        077
> +#define WS_TAB_WIDTH_MASK       ((1<<6)-1)
>  /* All WS_* -- when extended, adapt diff.c emit_symbol */
> -#define WS_RULE_MASK           07777
> +#define WS_RULE_MASK            ((1<<12)-1)
>  extern unsigned whitespace_rule_cfg;
>  unsigned whitespace_rule(struct index_state *, const char *);
>  unsigned parse_whitespace_rule(const char *);

All of these conversion look correct to me, and I agree that this is
easier to read.

Thanks!

Patrick
