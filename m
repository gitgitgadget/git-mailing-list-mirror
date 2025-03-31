Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B912940F
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743404729; cv=none; b=ouPybcyO4ao8KqJO9/Jmr9J60twORXRcETuYhQ1j/pS45Fc6VNl5kgPm/O0wH8zgk99yf383/DXYwnbC6KMBx2KZvvMk3Zqll07QoeKKAxk61YFDNXhmpuT4YDCvtj7tUkiJ6xyVKcfZZzdVlHenJDjr1lCpdp520wdoAAuBDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743404729; c=relaxed/simple;
	bh=N8imtwWDQ3qgXWly+joynXx4WdB/0pOmxwgxI7HUPzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua0VNYsHMQ+pmXvKYB11ob3BCW9kmxwZG4UWKgAwByzn+F8/Lc6lRDTaqAPVWK6NfwWQLOZJWOmiD/sBWFFNrTaR+ISVwSBahroT2hs3wSmElA2anHoM6Kj6q4QNLXwxsAatdi5XGen/94NH7ZjR5uErfu0B8KOO1NzBsD7Iw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rDxmG8mO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8eH4e+q; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rDxmG8mO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8eH4e+q"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 589C811401BA;
	Mon, 31 Mar 2025 03:05:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 31 Mar 2025 03:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743404727; x=1743491127; bh=FCepcTwYE4
	0y0iNvZP6F1o329i9/jY111Y+r6vbFRXE=; b=rDxmG8mOKn/tW23zPn20oRMeq3
	dG89m3/Y9c+DzKYQp4BPqOPFceY/rbkWWtnuSmEu1raCpzugZtXaglOfwN7IfVvr
	UdRI6/hVh8g+ZOKt+lKrL7/vim/7QnPKrnyEzeeFi6dST2E4AYTgPZ2rn+kp5xvj
	agwXWou8o5MP1G6NKxej0fgjECDjaNZ1okTiSUGFiZge8k7uHrlllwu1YSDOnNX9
	31mhtmxokhhuWdbg2SQ9C4FcTnuDUp7clKd3Frj3QA1B8SA3Y2UvCQ4WW+viIQ2n
	f/pKKAn/Rd5vbIrYu6bbnJYxJSz65CRlB9w1uzBAH4dN+MCFp0k4WaiF/sTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743404727; x=1743491127; bh=FCepcTwYE40y0iNvZP6F1o329i9/jY111Y+
	r6vbFRXE=; b=P8eH4e+q3mha3LmEvSp7j/9Fp7SvO8nBFw9v/z4FlziHS1kz1JP
	dz+nzg3/T4wBlvbCXZRjS/kesyGrInvw86ffMbmmh/eHqEXaNFPLhrDWu7V2t1Xm
	aWH3alOt+E6mB7J/BF8xdAhZ09LoDxUalfsyapLlWzEHTd0VgPTB+l8/VESbRiKu
	o4cDwrvgW93BqgqpRgv4+rDcyJBC4K/AHKo1XrY/9/8IWCb9D4c+cszacg7FmgxO
	IypM9h4CExU71W85STuQCfRxJR1NvW+HY0y+Uu0zBC8MXeBI8HLHszq6V9d81HEX
	SCOtVMduknAk8EBvH3cI1OMs8NY9F24KLMw==
X-ME-Sender: <xms:tj7qZ-Km1xt3FiTKXWAr59Yalt5R3QhN2CbCKBp5qTB-oUcep7Mt1Q>
    <xme:tj7qZ2I2D7ftTkwZ3bauLU6IZdVGphbvCLzutMUKLqOvmWqqM9lHJ_xJjJuH9qI5v
    NUq4RVpaXpxJ9jmBg>
X-ME-Received: <xmr:tj7qZ-uLDrJQiQi_dXLEPhhnUXFbUKyqOndNRPp4pL1zLTHgvIG-fVQEPxjeAirOkvPt35JF1J4JiYbhBLj96TIzC1MwNoxroKlZNnsCihEyrPOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tj7qZzYhbu1B8sbM-1kgQ544f4aOytUsPQd_cKtqFQeZrwwKclnDsw>
    <xmx:tj7qZ1Zsxrfz33zL9PEUPlM_0DJgmnonj9Fbw7pyF_ipnaGB59Q0Nw>
    <xmx:tj7qZ_AAAHmUNjHr8pAp6buuQMCiOigFkNDyLiZneihm6NMMjiR8PA>
    <xmx:tj7qZ7aXtfUjU_fXX7C_gO5OAOoCfW94EJGZ0h_CUtW-SdRX7bGNJw>
    <xmx:tz7qZzNF9BCwTxjESY_W4TAlfT7MQzW_gVx0xUSTnUfB9WT77PvM9BJa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 03:05:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95368dad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 07:05:23 +0000 (UTC)
Date: Mon, 31 Mar 2025 09:05:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com,
	gitster@pobox.com, phillip.wood123@gmail.com,
	sunshine@sunshineco.com, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4] blame: print unblamable and ignored commits in
 porcelain mode
Message-ID: <Z-o-suJAfu5yc2AW@pks.im>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250330204339.191382-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330204339.191382-1-karthik.188@gmail.com>

On Sun, Mar 30, 2025 at 10:43:39PM +0200, Karthik Nayak wrote:
> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
> index 370b768149..50a0a7ca4a 100755
> --- a/t/t8013-blame-ignore-revs.sh
> +++ b/t/t8013-blame-ignore-revs.sh
> @@ -158,6 +158,21 @@ test_expect_success mark_unblamable_lines '
>  	test_cmp expect actual
>  '
>  
> +for opt in --porcelain --line-porcelain
> +do
> +	test_expect_success "mark_unblamable_lines with $opt" '
> +		sha=$(git rev-parse Y) &&
> +
> +		git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
> +		sed -e "s/^\ty3/unblamable\n&/" raw >expect &&
> +		cp expect raw &&
> +		sed -e "s/^\ty4/unblamable\n&/" raw >expect &&

The intent here is to do two replacements in "raw", right? You can do
this with a single call to sed(1) by chaining "-e":

	git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
	sed -e "s/^\ty3/unblamable\n&/" \
        -e "s/^\ty4/unblamable\n&/" raw >expect &&

Patrick
