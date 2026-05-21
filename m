Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F28368D4D
	for <git@vger.kernel.org>; Thu, 21 May 2026 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382169; cv=none; b=FmgDzt63rSvATZ9vGF2laGFHNEDGrCtqG/BvYo1HhOhGEzWaO1ArFWIV+C9/TI1XE+3Ky2E7uIJ+qaMOB8vKeQ0oFYu4aE93BMKdx4/JPRb8rM4Wv497fzjR+cCXQB6wHQlpHTGh6fIX8Wu54hLM34tLCI20FH53aicm6oUBQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382169; c=relaxed/simple;
	bh=rmEM9vc1ULilZ7TieA+WpiqPjJ1o7NMRqluqjHN/xcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=njAnwVcDNvImOGS0FhmlfyoLl3PFU6WxkbelM4BfdNUxkh1JDPEZZJNX2pg88jIniaESkB29PB2Gpx9Z1lrsvDEyHPiy7kF99wYJgmopiHaexta/6PO2mKbuOXRtZrwqRb5zFsMWyvf/Wyw6uqVxfmtMgtkS3R6kGyZZ+10jjHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wNyd3E8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5gEOCEW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wNyd3E8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5gEOCEW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CF20D1D0008F;
	Thu, 21 May 2026 12:49:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 12:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779382166; x=1779468566; bh=lDFAi5XhQR
	R+iLio90EKfPdyvqumuN3/1WBjSQoc6O8=; b=wNyd3E8mFFneztwjH+wfqAE10z
	kCIqnZh3aBHzAdQuQkN7de86I8bz7/h9h94TNQZSltsSuWprMIYQ1ETL9n1JX9cS
	SblnNSiQ6GfU+9MUxNYLEF5UefhTCEjTwsCKhuDYzW0R50mxR+xyFTVxp1Sml6OT
	EFwchQjGh3ImHzhx3id480WF/7V+zgk/ldZtxZ+cuMK8qWN6h8CJ1srVNWKDDy2O
	24M7cjEMo/gbYAPKGU4CcJ1AUlyDtAPFW6o7cO5R0FZK0UeWgqz7+aXreV+eENXk
	fXASKGMQIutj1Cwou7eS2vqmvzr1+Gfd2fgcs/VY0Z/wdFNWoK1/gEVde1Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779382166; x=1779468566; bh=lDFAi5XhQRR+iLio90EKfPdyvqumuN3/1WB
	jSQoc6O8=; b=e5gEOCEW95EmsvOXWza0O8X5IHdXIgfuV8TJ6+IiBWjNicpBaon
	QrOm6OLUGt4mQk0eo6z/oi5weVygjIWOdYfiP4ivjc5bm6be51NeAYfte+UD8C1j
	r59X3gPqyUo1z0brn95BRbcJJlLmi48UGUsDYVVurCoK1Oi7axxVnKliA3Mr7bgi
	O59A1se9hQQE07hC6+Nj4aE7rk58GTScbNKgfai2tfz6kPnlMaK73w2jCcnmIKzW
	+9bny9nzo68H8oaTRz8BUzXvHin604lfX6Rv0jFEfyntphZ04gWOzvb2P1qcRqSQ
	XC4gofXOIezgSfGQyfQV2IjOkRtjywCf+qg==
X-ME-Sender: <xms:ljcParobxZ2Um7j9ptEzHifxnb2xFPPv5YmQEgqt6m9EDoTxaDutdQ>
    <xme:ljcPatHhH9HJVXVyXT4qmGm-L9YAoLg4CMiEJLTAEk1lWCWN24Cwvmntwyp2xWQr5
    eKVGPejINCHTRdiCHehZBITkR2fKcbkHxa-bZIqMrWTsGGaS_j8XE8>
X-ME-Received: <xmr:ljcPaln0nk7h24oBnwSi9e-KvBkWDTkmNthnCpih7lrwFMyTWmLKLrjH08_9O5yx-37i9sr-RyGC2q3JPTUoQgaW5WDF31lU7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:ljcPaomDDKIm1umxsjEO7aCTsS8OycMhDzYxel-kJmSsygB3RWrnsA>
    <xmx:ljcPauuSLrjpYtmFCLFCCe2Cqrdsc1gn0xUQDrHRXuXBxmUSFb3wAw>
    <xmx:ljcPajkxCYkdm0K4MT39u2Z4cBatk_ounB6Vcs6b9U-AMRLB4R-Gug>
    <xmx:ljcPahs1gteojvW0ldk5m3SgVsLSFMyIZ8gJrDa7LrNalqTKG5JK3g>
    <xmx:ljcPalOMbXsVcZxpN79lAeMxkGYXlxVK2aQrE1KwfeMyVC1uR6NaQH8V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 12:49:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] t0001: plug test gaps for git-init(1) with
 GIT_OBJECT_DIRECTORY
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-1-f130d2a7e8ae@pks.im>
	(Patrick Steinhardt's message of "Thu, 21 May 2026 09:42:28 +0200")
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
	<20260521-b4-pks-setup-centralize-odb-creation-v1-1-f130d2a7e8ae@pks.im>
Date: Fri, 22 May 2026 01:49:24 +0900
Message-ID: <xmqqcxyozp0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In subsequent commits we'll rework how we set up the repository. This is
> a somewhat intricate and thus fragile sequence, there's many things that
> can go subtly wrong, and there are lots of interesting interactions that
> one can discover.
>
> One such discovered edge case was the interaction between git-init(1)
> and the "GIT_OBJECT_DIRECTORY" enviroment variable. When set, the

"environment"???

> behaviour is that the object directory should be created at the path
> that the variable points to. This behaviour is documented as such in
> its man page:
>
>   If the object storage directory is specified via the
>   GIT_OBJECT_DIRECTORY environment variable then the sha1 directories
>   are created underneath; otherwise, the default $GIT_DIR/objects
>   directory is used.
>
> Curiously enough though we don't seem to have any tests that exercise
> this directly, and thus a subsequent commit inadvertently broke this
> expectation.
>
> Plug this test gap.

Nice.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0001-init.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index e4d32bb4d2..e89feca544 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -980,4 +980,14 @@ test_expect_success 're-init reads matching includeIf.onbranch' '
>  	test_cmp expect err
>  '
>  
> +test_expect_success 'init honors GIT_OBJECT_DIRECTORY' '
> +	test_when_finished "rm -rf init-objdir custom-odb" &&
> +	mkdir custom-odb &&
> +	env GIT_OBJECT_DIRECTORY="$(pwd)/custom-odb" \
> +		git init init-objdir &&
> +	test_path_is_missing init-objdir/.git/objects/pack &&
> +	test_path_is_dir custom-odb/pack &&
> +	test_path_is_dir custom-odb/info
> +'
> +
>  test_done
