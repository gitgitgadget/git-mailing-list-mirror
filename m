Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A271420D8
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798219; cv=none; b=OojXkb6cJx4eRZ34lLdM0+eCbnkkcXP6lN3vOgj6bralvMc9j3MXmYVuonXO4jEjtTEqG4q9RCmjL2MaLsf5cgjBnkMrm3jxO4gf/zwZrXnfGxe9SR8EIekfcf18OlOG1RNhHU6Nc5Qq8B3WPSHhbKXp8bhdZ4LPX+ejR4mAoK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798219; c=relaxed/simple;
	bh=+iq9Gp1DQMo4OII2vt7SFOgIrbMqVT63ml2/GucNGbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPp3LQmPgcPhOXew+zCCDoavbg2JRCyusVyg1k7J/ydkdEVJ6BBri5ZHRFnUf7EFQxzzP036bGMk0yuT3iyEHSZsVUNlavo5/6cuYoVJyIoMr+GyZu1GKSRNXcsThBrgXL+aQRkMXd9odl9VvFGFhRudAuBSTM7ybpVXNOtqCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U30POHve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NV7zrmo2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U30POHve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NV7zrmo2"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2431E11449FF;
	Fri, 16 Aug 2024 04:50:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Aug 2024 04:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723798217; x=1723884617; bh=48AQgDYR4e
	zqeAFsIEiF1hyotuKYg1H2rvUQxElMfio=; b=U30POHveGSYeohPYYCJTYdXJUp
	vDOEUJJ0KaBWl/zAV+Hb+5vDWZKws9AnDzMtLxPnZ6MZkSI5KpKnS2uzCQVD6MoM
	WOUoC1jQGvw8+K5kzZbHGbv/OmgJ2IAyF2wxjkwu9f5lVWnh7+adHVUiTvb2fpPx
	QHgtkkL09EPOegIEbB+79Utmt6LZ7jXBGVNMGvhWNSBiQiYBDm8w0ckTVwHBC0H2
	uT7z8uTMRXgAMCwarEDH63wS2Ws99ZMXjAWZIAY1QbqEql8pcXk5nxOHHZuVaX5q
	fxm6OJD33yc9o2xGovdRkV0eczuUyhlDqZPx9SDPHazKAKB8R9WtrXrzCLtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723798217; x=1723884617; bh=48AQgDYR4ezqeAFsIEiF1hyotuKY
	g1H2rvUQxElMfio=; b=NV7zrmo2QTwtCAb0rNNSyHjOTtD+NJbm++hlwslaGREp
	NC1wsWAqX39qeM8PwHC2eiuUVVHaAqxLO7FMCa/YtYys19xlJP5patLxLVCa9Z9u
	30edWS8LnjmpvDckXzqv+BGUzHwmBSizU4vA+3ApXzq796va1EMZuRhIAFAtirZQ
	EOlr8IV33NG250OoJsNUHEIaSrKJXQJG3wREnOU81gVhEWpXI9mN1rvXH1vg0Nuk
	3vO1abLrVhFq6dwuEPUofCdMUbWAUPc9t1bBCoKPVLqhPADmSrz8T3arE7b0bb+K
	F/MiiX8id4BomMf87ztI/eJBZrHBU+mj3h2IFoDfZQ==
X-ME-Sender: <xms:yRK_Zo-3d9gj783w1BuBDcPdH098aK_x4gJ4gJaEDs3jhBTQ7rDSNA>
    <xme:yRK_Zgu-rTusfSdcf5GPgBrHXgYRWRM3URFo6_YrVlm8TmkglK82PGcKeVLitDSJV
    fnd2wUvoPFvtKBbbQ>
X-ME-Received: <xmr:yRK_ZuAkPDWTiqDFLsCoptRt3uLWIxF0F5fbYi53eqnrOjj0WA8VOb1S417WQb4X4vOiXvpn-egAO6e0F-KWQMBseBtPZp7wad9q4D0omRjto6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghvihhhphhitheshigrhhhoohdrtghomhdprhgtphhtthhopehs
    rghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yRK_ZodfIDdhWIQp0pyHGdcxzHBFdm1KENyhD23UHbbq5wDXVamsMw>
    <xmx:yRK_ZtO6U-2is3FVPv7sLLkJ569TmjlFTrOmu3io3-7XRgNFoCwPQA>
    <xmx:yRK_Zim66vuJ7ULznYIPWRjhGg22r4fpDqRuAwQ-JqOdjJ8wBzdrig>
    <xmx:yRK_Zvuqm8SJu1u3uWG7VfxsNBwUjeQd6UA65vNhJP1uJJ8rY_oj5w>
    <xmx:yRK_Zip-e_dmvI7mUOxUcOd8xtrF5eDlnDJ1gkG_ikeRtAG4O00NyDqD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:50:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62351fa5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:49:53 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:50:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH v2 7/8] git-prompt: ta-da! document usage in other shells
Message-ID: <Zr8SxmujUZ7Run60@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
 <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
 <4aa75cdb5dddca0fa2a4817e856d26f724cb43eb.1723727653.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa75cdb5dddca0fa2a4817e856d26f724cb43eb.1723727653.git.gitgitgadget@gmail.com>

On Thu, Aug 15, 2024 at 01:14:12PM +0000, Avi Halachmi (:avih) via GitGitGadget wrote:
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index c3dd38f847c..75f272daa21 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -8,8 +8,8 @@
>  # To enable:
>  #
>  #    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
> -#    2) Add the following line to your .bashrc/.zshrc:
> -#        source ~/.git-prompt.sh
> +#    2) Add the following line to your .bashrc/.zshrc/.profile:
> +#        . ~/.git-prompt.sh   # dot path/to/this-file
>  #    3a) Change your PS1 to call __git_ps1 as
>  #        command-substitution:
>  #        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
> @@ -30,6 +30,8 @@
>  #        Optionally, you can supply a third argument with a printf
>  #        format string to finetune the output of the branch status
>  #
> +#    See notes below about compatibility with other shells.
> +#
>  # The repository status will be displayed only if you are currently in a
>  # git repository. The %s token is the placeholder for the shown status.
>  #
> @@ -106,6 +108,33 @@
>  # directory is set up to be ignored by git, then set
>  # GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
>  # repository level by setting bash.hideIfPwdIgnored to "false".
> +#
> +# Conpatibility with other shells (beyond bash/zsh):

s/Conpatibility/Compatibility/

Patrick
