Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776F2EBDD0
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090190; cv=none; b=O2tZn2kT5AINt0odzzT6qgKDM4XkrggP++bQcLoHoYPzba0eeg4yhAyvZlHeCsVjqz7kHD6ypPYcl8IBkHkxZY3uSoFULXUR25f9OwWMmqf4Lp2PhP7wYANT/jimWK4OTEuclAbF7s5E/cZlCeuc4Tgw9S12dvP0K0bEzGwYgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090190; c=relaxed/simple;
	bh=BEQebn6+i1nUKJ1v3+Nptq3pz5CNWWkwIpLt6ns2g68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LNuHWQZleuafm4pMgRt3+aI8+f3pv9JJKMZ8V4hfx+Gv1t8fqxztYstXEOekFUpYyTEwXR8kHqTy+QwFnj3fkn1B1SHPqhtgZe8rnQMWErxMWhQJEPF0JwxtwztwK7j/5ZWWEEZ9CtAA5NcFEsDUn79mE2tJ8VbBG1Il4iqHob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IIwDMhNN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nbk6GZ23; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IIwDMhNN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nbk6GZ23"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3B50FEC030E;
	Mon,  9 Mar 2026 17:03:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 17:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773090188; x=1773176588; bh=AmW6S/x6Sp
	guaJXptVeOUgGH6scVTuiCiFvV8KpqQDY=; b=IIwDMhNNePsqrkltQrt+1Jtlbq
	neihPrDhUWtOsJy1RvqtJJDClj24l9IhNLaoOgtjgUjUslnjDiswMv4AxX8ffhQY
	FHCTqF7UMD1y/vrYi9AZQ1guX9aYN7zTIq9P9Rg5hFb4Ej8/Ubew1IQmEMpj8st+
	ukjLpDkAcRO5FYLtT8kOtAkl0d3hCbF1FId1r3pPR2oqyTdcgrUhNasBs3AOHuqi
	nFeWrifqULDW0/DEawVDn1Z5nKW6kny+a6HiUE5KFBn/8uki9RqWhBkr0/PNIeBB
	88VOuAVXnWEkj2/jDP1tpMoPYPsMOhpRWj/TAQRFcRkRC97ojFLKHW3simNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773090188; x=1773176588; bh=AmW6S/x6SpguaJXptVeOUgGH6scVTuiCiFv
	V8KpqQDY=; b=Nbk6GZ23yo6udvZx06z3S1rK8PPuxD5cz8VldcnuuHyNv/XzFk+
	17BM5wejSleVgoKIHeN98kNQUrvzDbRAxi2XCEadcxnMVFeIV/EtuIXjLH3dxBYm
	3H8+9Ipo6sCPu+q0+D4hG9BAxXUPKI/vY34/TzycVDUyfSPjSGM+lLJzJ4V2Jvrb
	JnW8RviWEors6FlPlP3lzFQavTxf3iTIVKwew/HBXSlBAxYXviHcSpW9vbznWeze
	1/+UDUqllAx9BghC/2Feh+HNoP7WY5BsCT6un0/G2GJ+EvcLoVasae0C+RkpWodk
	vowiw06v8dzxM7eV7y5+85wmj/igb8CzzKg==
X-ME-Sender: <xms:jDWvaY5lxMuLd7WU2n3QWP_LtwRZevfLRxF8QqexaOdgX4BWmqt1MQ>
    <xme:jDWvaRXJlqr1BLtqlQ9GrBtnKARJW5p0lzAQMyyVU8AlSAIedO3P11mIH_47D-WK-
    aA1krGlB4Fa0hgQ-CplmGKlov4KLvgnbzk4WX1VoTBbPt3M94ia>
X-ME-Received: <xmr:jDWvaU2EtuQlgY76i7NO5yD23zBlDjXte0_smzTJvOYgsA-d-xcUTJs-SMeJ1ALuTqQR-QwGutyygsDxq4NKdIbxOEEBuiZOcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggslhho
    ohhsrggsrghtvghrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:jDWvaW0GWgL00YEiTAMiYzcPHp5nf-XAhdJvSSt41vAy57OWX3F9jA>
    <xmx:jDWvaf8l-L5Wnw6NfBKnbqnlVdf_f1RXVuQiMrZWZPlq4uFdU7r9Ug>
    <xmx:jDWvab3IcHX1KcQrDcZpEa7wYRyuzNIRv7hE5iPMDECmsadyfqKFUA>
    <xmx:jDWvaU9Qbrf7A_CsEvnis-FyqmgZaogwRt6IKdxNciv4V3ZE01PeVg>
    <xmx:jDWvaZW_fZGqi8bX4EIvBl2iNS-LD3ns1o1SsHar8dVQfuS4M_phnBMT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 17:03:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v2] t9200: replace test -f/-d with modern path helpers
In-Reply-To: <20260309162832.605969-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Mon, 9 Mar 2026 17:28:32 +0100")
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
	<20260309162832.605969-1-pabloosabaterr@gmail.com>
Date: Mon, 09 Mar 2026 14:03:06 -0700
Message-ID: <xmqq8qc04sxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Replace old style 'test -f' and 'test -d' with modern helpers
> 'test_path_is_file' and 'test_path_is_dir' respectively.

OK.  Being "modern" does not automatically mean "better", and it
would be helpful to say why we do this change for those relatively
unexperienced who will read "git log" later and find this commit.
Perhaps

    Replace ... with ..., because it makes debugging a failing test
    easier by loudly reporting what expectation was not met.

or something.  The patch text looks good.

Thanks.

> The instances were found with:
>
> 	git grep "test -[efd]" t/
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  t/t9200-git-cvsexportcommit.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

OK.  

> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> index a44eabf0d8..4507e8e6db 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -31,7 +31,7 @@ export CVSROOT CVSWORK GIT_DIR
>  rm -rf "$CVSROOT" "$CVSWORK"
>  
>  cvs init &&
> -test -d "$CVSROOT" &&
> +test_path_is_dir "$CVSROOT" &&
>  cvs -Q co -d "$CVSWORK" . &&
>  echo >empty &&
>  git add empty &&
> @@ -303,7 +303,7 @@ test_expect_success 're-commit a removed filename which remains in CVS attic' '
>  	git commit -m "Added attic_gremlin" &&
>  	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
>  	(cd "$CVSWORK" && cvs -Q update -d) &&
> -	test -f "$CVSWORK/attic_gremlin"
> +	test_path_is_file "$CVSWORK/attic_gremlin"
>  '
>  
>  # the state of the CVS sandbox may be indeterminate for ' space'
