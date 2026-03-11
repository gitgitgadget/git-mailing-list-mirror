Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B62C11CA
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257448; cv=none; b=RXDC9gXz7UIXubzizFvLfj7yXL89YEB0ia5zLoilVrBmmkKRZKNfcDHF8gKUNdVsgMBpX5Y9+Cfz/WHhnnWtTgerz2vTHjawJL91/66+BTkOjJFYaikyklRejeAjBqy7V58EG6lKisqIlfjFqddbaBHC5ebw++pZFg6QkewWXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257448; c=relaxed/simple;
	bh=IHjeiHSKZiu+13SuTwdSEFXJVukJaX6w8jMYinvToKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s0daPDjOZa25n9TaWORC+PpD+zzQBC2DXe/HLRINdDS7o2Sq3UDouy4O2mMh/Y8ChHqCeMtaR1+D0WASlRbHyBAOiR0g7S7gaNa0KEYq4Uf9sT3oR0/jyqiV0ZwW9FcU/O8c3L+q31V/6ZcFrbvz3LqAlSBGFYsTj8X3XGtjeU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lJxTxqZv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ua/7qqxP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lJxTxqZv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ua/7qqxP"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A8A047A01CA;
	Wed, 11 Mar 2026 15:30:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 11 Mar 2026 15:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773257446;
	 x=1773343846; bh=meyWUbju+jKRlGuu8X6rEt5dO4V4DkDOVSTfYpYuF7M=; b=
	lJxTxqZvweGOkyv3gpqv1ZcF70ghoe/R7SqxIZNvcf9XraKTZnODKT8ulvPTkxVy
	UBoCoHl/QVxjkXN+5LPLQgBXHJNvXexOwiVsBtysT99EXHevu1KbXgKCPy55ONDJ
	WqWdNHcASzjIPDxbTGBuaHW7BR9FeqCzQy97SI+6UgquagqTlZepCUfMimJHNFka
	kf3tHSwoW65/4kEhfdRMAAqFVTO2RwEGVhTEexv7brCFabeTR8DkdJCV+ufJgazF
	UW399og6zhyVC5Kclqx8X6BnUF5n+OB2xgBRTWj6DYiEeS2eylSmuIgXT6SC6DMc
	4MEAARswd+AY6FBtHZRG1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773257446; x=
	1773343846; bh=meyWUbju+jKRlGuu8X6rEt5dO4V4DkDOVSTfYpYuF7M=; b=U
	a/7qqxP0ZDzmk3f0Op68wOjpbXoDp5hlmSDlEtJTljs9vcbYwRJm/2asmEnee7oF
	jVYo4RyFDjqR2bB+OzLY41bkwUK6TrwfCiml6kd7CawsirMjTH8ogWTZsCmivWRV
	qywHR0cMOMW8HHBdEpKaOHL1X0I2J1MiYih6qOWcsnHE/kIAxNCnWto2e8QyAJHa
	MMTwb2dLJLO23hhmwePzcOoOldmqW0nekKihbhJ6pSrLhkeD2skOHfUrsUgmrDc7
	pYogLfLBNqZlIZ/BofjcVDtoLkcDyuakFCSrqfxx0u4ouoINh0wlWz81Y7KXuiwC
	ctPk46XjncRcvlSuIb4UQ==
X-ME-Sender: <xms:5sKxaWe5OUJdRaHZfhPF_Kxofq-aKhyGbXb0wQSFWOR9kk04vQeO-Q>
    <xme:5sKxacxh5sO9WCQPxN_IRZn4mReGShGm43JcMU1wS4Y8SM0nivj131zJZBXe13dZl
    cPFCfUk1dXtQ0F2HCN1GzOqaT5xw_NB9Xm1z9LsMiYnKf_szTt5Dfo>
X-ME-Received: <xmr:5sKxab8kq-iRfz5zQPAnn3ZriLcWbfr3-5cG_TeUd5mQrXtQk7_0GW88oFR2q8b_mhbFVxqSxl3UhrZOS03eALm1G820v6q1RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsghkkhgrrhgrtggrhiesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:5sKxaaxAa4aho8efgfCNJaYD6B6uZ3UH44faJoSlNFKpGuz_EMpriw>
    <xmx:5sKxaTrpcrrSv3n1VDxX6-Cg1qOywsNeNdmwa1D3v6oZthbPhP5WAw>
    <xmx:5sKxaTrh8cb-mg9BWkAkO75dAD3i4vcn6x8Uhnk8vHxza0ebafOHLg>
    <xmx:5sKxabBqj4ay_bW27VGpE91Emmo5cka9F6ZXyp7tnPioXcSJNCLSHw>
    <xmx:5sKxadvgat7ONzlPu-LYLGTFaOW8xIQ3nVoVMfEygN1Tjjmdduxyfp4w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 15:30:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  l.s.r@web.de,  ps@pks.im
Subject: Re: [PATCH 0/4] wean start_command() off the_repository
In-Reply-To: <20260311151923.4178655-1-bkkaracay@gmail.com> ("Burak Kaan
	=?utf-8?Q?Kara=C3=A7ay=22's?= message of "Wed, 11 Mar 2026 18:19:19 +0300")
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
Date: Wed, 11 Mar 2026 12:30:42 -0700
Message-ID: <xmqqo6kunoyl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Burak Kaan Karaçay <bkkaracay@gmail.com> writes:

> start_command() relies on the_repository due to the 'close_object_store'
> flag in 'struct child_process'. Introduce repo_start_command() to allow
> working with arbitrary repositories. Turn start_command() into a macro
> that wraps repo_start_command() and migrate the existing callers with a
> cocci script.
>
> For callers that cannot access 'the_repository' due to the lack of
> USE_THE_REPOSITORY_VARIABLE, define the macro. If the caller already has
> a local repository context, pass it explicitly instead of defining the
> macro.
>
> Thanks,
> Burak Kaan Karaçay
>
> Burak Kaan Karaçay (4):
>   run-command: add repo_start_command()
>   run-command: use repo_start_command() in strict callers
>   run-command: redefine start_command() as a wrapper macro
>   cocci: convert start_command() to repo_start_command()

The organization to start with a wrapper, and then moving to a macro
that is protected behind USE_THE_REPOSITORY_VARIABLE, makes quite a
lot of sense.  I do not know the answer to the question I asked on
"don't we need to know from which repository we are closing the
object store while switching to this new repository?", and without
knowing the answer, we cannot quite decide what the function
signature of repo_start_command() should look like, so the last step
might be a bit premature.

Other than that, a well reasoned series.

Thanks.
