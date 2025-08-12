Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603027FD5A
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003167; cv=none; b=d1SH6wdY3v2WEG7tzTsDoOmTph3OxgR5KSESJcMH97z7OhcSEoi8nNH7QdQVpiSi4Z+UcV8RLa94BMTF63RIriHAmNC89OmGGjWmOWaS78A54d0iZZPnKFUIlIvgtDDjlTYnQiHUoCJgT+BeOHS28lg9Ll/QC4GWWyM3Gr/m1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003167; c=relaxed/simple;
	bh=Ms5MsByZ8mTodfd+CJYCh53zydZVcB9FtUvc9G1QcQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZgndT0FsNDDJkvVxNYw6Ufzycu18hN07rWSnGniFWfdpP4r2YWwew9ZDiHZ3Y9Lks7moEdxf0CiGR9y9DANv57Yafsk9gWFw7We4YqHsqDrve/2YcDC2dM9il51q0TwvS9sFrmZLuAzQisBq/fExUjbIjIKK7Afu7xLpAEuLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dWrRA7uB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IEb/gcEP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dWrRA7uB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEb/gcEP"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D59CEC0184;
	Tue, 12 Aug 2025 08:52:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 12 Aug 2025 08:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755003162; x=1755089562; bh=CsUvVWLce5
	4/zV614GlKxDbWGlIp4i6nbih//lRFXu0=; b=dWrRA7uB09t7CqpIMBbX1R0fNX
	45vMrUSME+AsyImYw7Q6ViK6E9IAQs5ZIpcEXBJLtDUNg3UrirB6MDg50rhUBKgR
	uvJ3hF/JYMSdVLcbcwKlSa/fyE2nlNSklYLU/XLqKuK9BCBNim5qsen6ohX9r985
	gel03f4cCNY3g746VPsrJIDAGhVsiCDufLdGeZ74zidBMRYGScorEDYM3+mId4H9
	tTR7+jIGcvDs2eWgG3HWSUJhQNIbdE975LjyxTzf1Nbla5Fh+NqLSQg5wYgqspVG
	vjFc9fFnFkcDlQqOJlFGqHWjdph1jzlIFlnPLM9G98YHvSIhpRu75KANeczQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755003162; x=1755089562; bh=CsUvVWLce54/zV614GlKxDbWGlIp4i6nbih
	//lRFXu0=; b=IEb/gcEP8RiIVSg3Rwtf07nXlwO/JzJsHnq4XvRc5iBT+ixNdDA
	ej6Pqcc/Nk4sBuulUrHfUTtWKa9hjYHqH8e1J73vYuk0aZJyvSFhU7iEkQqkm5QZ
	QS0oT4DM/O+DDuXDmcgPFRrz/DRdbkaSAVrlmJ4YWJtAf29gNXY9NBupOzA5yI1d
	pxisDuq/D+26XpOE+wKgizPz0TLFmMSB30KQWM9GsWMmzu3QXcvLrfUGxxC1fJDY
	Bdg68/D3W67ipuc6weRMEU++3B3h+4+dNfWc5kVUZ+umW3aIRZEK9oRK7xh6yd1+
	88gzSqMhQyiFSvfceGA0nZf2VlW/xODXCmw==
X-ME-Sender: <xms:GTmbaHE44OIZ7DEOS6V8k8GTGCET7JxmrxlBfspn86UNG-d8eyfxOg>
    <xme:GTmbaHmW10bUN1fVOOVtRdelEHW4DS8pIdsR6clR3-hVOn3iz1NUxxVU6jnYj6AFl
    RRPaea2wyWUQ1psyg>
X-ME-Received: <xmr:GTmbaClLUmlsW_aEvXVpA16MqBOmXsu0TqrvaSJE7G74re48bOELwWY_xZmhFb55G168MJj2Le1xpVuLNJDh9S_ozorUJmNthyCvdFtn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:GTmbaAtSvgn6UR7VFQ-I_bvtLYQwy58cXiyatpgoG8z_n836a2Kw7g>
    <xmx:GTmbaNlRdFowq2AEzff1tYVJj6mZpjbSthZnLHzOC9EmdrCvPU3BQA>
    <xmx:GTmbaDvZ7hQ-_IiERLv0eswHR-2X2CcZV4lCffPQ3hsXNbgvG-jN7w>
    <xmx:GTmbaLdAcFBv1nG9hXGNDRxcq0_8ycPpMSrrUiClQ2vLV3FXDUX6mA>
    <xmx:GjmbaN2f8fqDrU8thdKyrKrpzpHl6th_qLF1MEEBJBUClEcBaTeEz47t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 08:52:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d5f6611 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 12:52:39 +0000 (UTC)
Date: Tue, 12 Aug 2025 14:52:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t0450: add allowlist for builtins with missing
 .adoc
Message-ID: <aJs5D2jPh8Uom96p@pks.im>
References: <20250804073002.1586332-1-toon@iotcl.com>
 <20250808095943.3312265-3-toon@iotcl.com>
 <xmqq7bzdfoxe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bzdfoxe.fsf@gitster.g>

On Fri, Aug 08, 2025 at 03:07:09PM -0700, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
> 
> > Before we were silently skipping all builtins that don't have a matching
> > .adoc file. This is overly loose and might skip documentation files
> > when it shouldn't, for example when there was a typo in the filename.
> >
> > To ensure no new builtins are added without documentation, add an
> > allowlist: t0450/adoc-missing. In this file only builtin commands that
> > do *not* have a corresponding .adoc file shall be listed. If there is a
> > mismatch, fail the test. This should force future contributions to
> > either add an .adoc, or add the builtin name to the allowlist file.
> >
> > Signed-off-by: Toon Claes <toon@iotcl.com>
> > ---
> >  t/t0450-txt-doc-vs-help.sh | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Forgot to add something?

Indeed. Toon is currently out of office, so I had a look at what it
takes. The below patch is what I ended up with -- note that I also had
to reverse the `grep` condition to set the prereq in the else branch.

Let me know whether you're fine with just squashing these changes in or
whether I shall send another version.

Thanks!

Patrick

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index da2d0af5b0..e12e18f97f 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -112,10 +112,19 @@ do
 	adoc="$(builtin_to_adoc "$builtin")" &&
 	preq="$(echo BUILTIN_ADOC_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
 
-	if test -f "$adoc"
+	# If and only if *.adoc is missing, builtin shall be listed in t0450/adoc-missing.
+	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-missing
 	then
+		test_expect_success "$builtin appropriately marked as not having .adoc" '
+			! test -f "$adoc"
+		'
+	else
 		test_set_prereq "$preq"
-	fi &&
+
+		test_expect_success "$builtin appropriately marked as having .adoc" '
+			test -f "$adoc"
+		'
+	fi
 
 	# *.adoc output assertions
 	test_expect_success "$preq" "$builtin *.adoc SYNOPSIS has dashed labels" '
diff --git a/t/t0450/adoc-missing b/t/t0450/adoc-missing
new file mode 100644
index 0000000000..1ec9f8dcf3
--- /dev/null
+++ b/t/t0450/adoc-missing
@@ -0,0 +1,9 @@
+checkout--worker
+merge-ours
+merge-recursive
+merge-recursive-ours
+merge-recursive-theirs
+merge-subtree
+pickaxe
+submodule--helper
+upload-archive--writer
