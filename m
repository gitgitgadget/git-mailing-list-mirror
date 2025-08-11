Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72C1E2834
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901974; cv=none; b=QC3OIS5E64cGI4XzGJ67ywi5RaydhrL2VGZxTJitCTfBU7mEK9oke/aMG3oUtk83TYUKMzHveb3tJkkQohJP6MdHDIvdWLvV/4C/4XHv0bSlHoS2w5Wpq4M4boFwz9nlszvVlayVxeRF4X3oJ1U3QSDQlw7qJInqvp8tQxAXfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901974; c=relaxed/simple;
	bh=BogDQVj5aSEppnrLS4+3fx9GhA5SC83vrrDATKGnUJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvZgd0jrcwEdYnPRZ8CJX8pLzeevWwU3A/kPsAwPTLupU6BXGpaPKPxoUIgK9Mf2ZrBs2bCy1440v9UtLzgjQfy12zmDGlRRa3/GU11HrHCpVpjf95HNe8hYTak975Oxn4aDIJ/of99ZjY+SO/t1UWbGVKigBIIUVAb7K7e2zOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C2odB/8i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xf20I13c; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C2odB/8i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xf20I13c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 59A45EC0067;
	Mon, 11 Aug 2025 04:46:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 11 Aug 2025 04:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754901970; x=1754988370; bh=SvkBxu0Ki5
	l1r/2uF5iKSZpDThtvSuFa5ueSrNAExnc=; b=C2odB/8iGgdHHp38bN7G0bKsJc
	xWapPyQKD5rckxzC7FqAGGtYluMJeW6h15M9cGZ1KuoT468YvSCVfJbaGSRNOKqs
	0LUp/Dc+UswyR5YjUu/8P0azPmek2PUeskyWL7Go/EN0ewrFIflHinQaUmta4DpR
	vUjlobnE8ykecOlwqe+0bosbWcv9BeCfno5Y74LQ2C3G0Ty2/q013yrNdET4sXqc
	SZXWqwulflKI6nEepPKNgow7O6NBMxGY99lQGt6r/WNenAmKKZBaNRMvOKUgXtH8
	8cHjU7uSO8ld/fwGYgYzHuum0bNxpeIz3pr6a95gz8J5t6h3JS3rVNamjfNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754901970; x=1754988370; bh=SvkBxu0Ki5l1r/2uF5iKSZpDThtvSuFa5ue
	SrNAExnc=; b=Xf20I13c6XvtJYLDOb6XqOUcIFFcmFSvUVbKPeSvI75Vbwm3YwZ
	jKaPl6ZQbLXMQXNuhvwMeUOwb/bwPEJ8Xehq2yoJ+5yCv2h6+Q917aTlbBI0TYb9
	yEsWuOGWFZDv41ZMYCJ8aQjg69gLdR9JEHf6Qn2t7UkEbMp8GxClPxR0iqMdnjbN
	xvY8C1dP5gT3Emn1IxMyXCxsCXzEM/N49dGSi2AxFUY8B8CMihhIIzbWY+63AwGg
	c6LyX8UkMda2YXPjFpGcIGYEnbt0WdyLTJ6+AY1SKH2kfXZWAROJrTGbtzE2CErx
	U9x3aTXep4lY1Buz9axxMOQ4vYjOAUO2xbQ==
X-ME-Sender: <xms:0q2ZaOuBwkfEVYOUQaN9YVKbwVW4pxG1bzC8JXXLN3c2_f3IMmuaoQ>
    <xme:0q2ZaGt7rBHU4WH8XYpMXy1TSrGWdCV_k8ERje3_Wk_1x2o4JSdFUov5zHvUdnf09
    WYrYrKRzpGUs3xR_g>
X-ME-Received: <xmr:0q2ZaDMywfawK11O5Z-Lt-iCVYIsmdgpC-j6Nn_U0tnAoNG3yzttdv0Ji4cA7tw1lwvFPGG968uBGrVJdvZ1DjA0aeb_g9DVIchaYpPqiCs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdr
    tggr
X-ME-Proxy: <xmx:0q2ZaE2twY4w_VbEjIiuBZ6TFwbrs5QHME3Wg4gD56VUuJKae_KBQw>
    <xmx:0q2ZaPN4t108t3cZufYPGbd-wM87D4PTAf8ShU1awczwoNzBZV-YIg>
    <xmx:0q2ZaE3bn2U1U1eEfyta_j9uoYn2itPa0Wf_fDKzywY9mJaJooTXjA>
    <xmx:0q2ZaGFOQjg6cYzYTcCWMyviuzn475viMdLZfLq6BYgjX-ud-qp3fg>
    <xmx:0q2ZaLVDOrRYBOxxEcLhrt3gEfJr54yke6z2omspeGVJW1ppIRyU_PzI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 04:46:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cdc9a3e7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 08:46:09 +0000 (UTC)
Date: Mon, 11 Aug 2025 10:46:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 2/5] doc: git rebase: dedup merge conflict discussion
Message-ID: <aJmtzfuibPwS1WVl@pks.im>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
 <061790686b9036cf862c5b918126eac1ca02a79b.1754702057.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061790686b9036cf862c5b918126eac1ca02a79b.1754702057.git.gitgitgadget@gmail.com>

On Sat, Aug 09, 2025 at 01:14:14AM +0000, Julia Evans via GitGitGadget wrote:
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 449f01fba560..e30b9535fff1 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -39,6 +39,27 @@ shortcut for `git checkout topic && git rebase master`.
>      D---E---F---G master
>  ------------
>  
> +If there is a merge conflict during this process, `git rebase` will stop at the
> +first problematic commit and leave conflict markers. If this happens, you can do
> +one of these things:
> +
> +1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
> +   and make edits to resolve the conflict. For each file you edit, you need to
> +   tell Git that the conflict has been resolved. You can mark the conflict as
> +   resolved with  `git add <filename>`. After resolving all of the conflicts,
> +   you can continue the rebasing process with
> +
> +   git rebase --continue
> +
> +2. Stop the `git rebase` and return your branch to its original state with
> +
> +   git rebase --abort
> +
> +3. Skip the commit that caused the merge conflict with
> +
> +   git rebase --skip
> +
> +
>  If `<branch>` is specified, `git rebase` will perform an automatic
>  `git switch <branch>` before doing anything else.  Otherwise
>  it remains on the current branch.

Yup, this reads a lot nicer.

> @@ -74,13 +95,6 @@ any commits in `HEAD` which introduce the same textual changes as a commit
>  in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
>  with a different commit message or timestamp will be skipped).
>  
> -It is possible that a merge failure will prevent this process from being
> -completely automatic.  You will have to resolve any such merge failure
> -and run `git rebase --continue`.  Another option is to bypass the commit
> -that caused the merge failure with `git rebase --skip`.  To check out the
> -original `<branch>` and remove the `.git/rebase-apply` working files, use
> -the command `git rebase --abort` instead.
> -
>  If the upstream branch already contains a change you have made (e.g.,
>  because you mailed a patch which was applied upstream), then that commit
>  will be skipped and warnings will be issued (if the 'merge' backend is

We lose the bit about `.git/rebase-apply`, but I don't think that's a
bad thing. The user shouldn't have to care how exactly a rebase looks on
disk. All they should need to know is that `git rebase --abort` gets
them out of the state.

Patrick
