Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C52E3393
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 00:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555523; cv=none; b=WqP5shTOGuEmGL6TFuDQM9Ixg+DL+Cv+GF7VWkl4o9r6uDaG27LoZ/XcC+kmlLyx6W04DbdUNI9EMe/k1IfVwIc1StoeXo2/fJvWfCrgwrq4F2uEwJ8e4La7IyKdCKpVnQKkOsteOJUHFqTwkctGrACkkGsTBNDVK2/60xf9dPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555523; c=relaxed/simple;
	bh=l8wHJui7iKhGZjK+YAz3mD+bBd/4L1zY1ImbVHV0FjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI476lqcHxEM7wHJ0K5HdlL5f/cGUxJMGKiqHJDR1aJ2bWxFeJgwx5/LUdKHlN/tocEI0hmZSChj38ZV5t4X78YkFw3azdCd5IgaXKQfD2O+Be8stQwmybaW5FgMMR5zJjba8JPXLa0DQVhZEROblKtH3TReY1BuyPwfyOQFOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ayVk7+kE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W6gNO7A4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ayVk7+kE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6gNO7A4"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A4781140127;
	Tue,  1 Apr 2025 20:58:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Tue, 01 Apr 2025 20:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743555520; x=1743641920; bh=dHyFXRPx6E
	XbP7K0CjTxfVh4Y8s/jQEf0erQP2K6rrA=; b=ayVk7+kEvpdByVJCeGxH6edvGx
	lPhdPAGGpkZqDVA8zMX94cMZnPO39/T1dZ4jghg1NcrQ9V+sowQjknuDASaehMSh
	qmr4QV6FON4dsIuMR1Lm37tYnFXjXfaCIsvwyrZbercmAOcHubuni9oD0XbbKSRG
	xRnOGDuCvXhzQDgoscGVrS1a6dS7JEYgj8NNhJ/RhkMgMx5hSOTyxr0XisxGZyXG
	aPmfL4YLxCZA25GSXN0qODBzUcCxwZToBWJnKcUbLRHdYORKaTQgS9+rW7FrN7iJ
	IID5RNYw+CH/xSoYJ1CPbaxlCGutRPiTFgvWpINm4BkjAcEcAa1B+2yORFTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743555520; x=1743641920; bh=dHyFXRPx6EXbP7K0CjTxfVh4Y8s/jQEf0er
	QP2K6rrA=; b=W6gNO7A4/Oa3RFm6e1Ct1Rl3xeCyl2y3weEt7IaozUCdN5IncfL
	DUQsOWuAFNQ6TLvhK3TqJNTRXT0c5h5BBLmEXUmj7Y6JbU5oXXM7SskThRqnvg1b
	w0vcxWFgDQ+ymjxs0J/EXjrUcpIWEAa8Gp1MToz1Jdx+n9p4VqdWv8AfRGjLAWgo
	5qmNv25qS3benFwe4ixpMDA3rl/M2IMxdRKX0UY486eaT4vBnbMB4U91O/uLDgz0
	X11lPHVYjmn7pa0CiyddlxFV8nrZUztkTqWRk0EFZByjq6TO2f5wzAfNrAaNNrSL
	puyZg9fbbxMtqa/HH3Gchohip1JECDybckQ==
X-ME-Sender: <xms:wIvsZ-bNNumA6pvWXwb28SqbU-0Zjx2lUV99ccRZyp6DMJFyQp9fzQ>
    <xme:wIvsZxZrUBXSqEFWkruA0OJFPXQ5B0VJHGr-Y9D1QvZzlGDIgK0ORxuSaQO4CTi7W
    fCB0LGRjTlUlLibwQ>
X-ME-Received: <xmr:wIvsZ4-0GxdwR-2zYgWsnNyIjmax0x52iqI6XOfh2YXjvjS7nq5JzvT_cQT7lx3ROMgkStq5Fbgy_CWLdQ692OEieNl6lqxmTZFYOH2xuPkK7TP3a87n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeegvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepgfevfeeviefhheehhfegtefhvdffheefheeuleeh
    ieffuedvvdeuhfevffeigfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhishhtshdoghhithesrghkshhhrg
    ihrdhishdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:wIvsZwrHu3U6U46XgpY5xexq-GFCPzJSjiRg67zFuA9UomEW6kr5MQ>
    <xmx:wIvsZ5p_Qjug474dJJIDEuO54ufUPLYPTEkwes3BIZEcvpfUmCS0Ww>
    <xmx:wIvsZ-RM06g8xnO49rPjzwC_5qBqq6yzCBw9fxKPzDRqW-lykB8gDg>
    <xmx:wIvsZ5om2sV9ljz7BllxMbV7kV7No5OwTnENj4hIvXcndsTQVSg3XQ>
    <xmx:wIvsZ7vfYjIHvbHJ2v6cCM1vkLvdBybZ45AKIbedC0EtARsbJSwx5QDH>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 20:58:39 -0400 (EDT)
Date: Tue, 1 Apr 2025 20:58:38 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Akshay Hegde <lists+git@akshay.is>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: meson: Installing completions
Message-ID: <Z-yLvgkJnGm0CkG3@teonanacatl.net>
References: <Z-uLqQd7QHZq-tB7@akshay.is>
 <Z-u42Sm613hMj1Ft@pks.im>
 <Z-wltqWraESmb-Lm@akshay.is>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-wltqWraESmb-Lm@akshay.is>

Akshay Hegde wrote:
> On 2025-04-01 11:58 +0200, Patrick Steinhardt wrote:
>>The biggest question though is whether distros are aligned enough for us
>>to provide standard installation paths. That is, do all distros end up
>>installing bash completion into "/usr/share/bash-completion"? What are
>>the desired directories for tcsh and zsh completion?
>>
>>If there is enough standardization then yes, I totally think we should
>>start installing completion scripts automatically.
> 
> Well I can't speak from any sort of authoritativeness here, but for zsh,
> they are usually installed underneath the datadir (usually /usr/share),
> then under zsh/site-functions. Of course, I don't know if that's true
> for all distros.
> 
> Could we extend meson_options to allow specification of bash/tcsh/zsh
> completion directories? If they are not empty, I think it would be
> reasonable to have meson install it automatically.

Having the ability to specify the install path seems like
the way to go, even if the default is used by most systems.
For Fedora, only the bash and tcsh completions are
installed.  The latter is simply placed in:

    /usr/share/git-core/contrib/completion/git-completion.tcsh

and users need to make some adjustments to their startup
scripts to use it, as documented in the file.  This was
added to the Fedora packages in:

    commit dae8588
    Author: Todd Zullinger <tmz@pobox.com>
    Date:   Thu Jan 3 14:59:27 2013 -0500

        For now, this just gets the file from contrib installed.  If there are
        enough tcsh users that want it to be more automated, that can come
        later.  For now, the directions in the file must be followed to enable
        tcsh completion.

In the years I maintained git in Fedora, no one asked for
any changes for tcsh.  Apparently, either no one uses that
or they don't mind the manual work to configure it. :)

IIRC, there are git completions installed by upstream zsh
and installing git-completion.zsh site-wide is not generally
agreed that everyone wants?  I'm not a zsh user, but I think
that's why I never installed it in the Fedora git packaging.
(It does seem like an oversight that they aren't at least
installed similarly to the tcsh completion.)

For reference, here are the locations for bash, fish, and
zsh which Fedora uses.  This might be helpful in determining
reasonable defaults (after comparing to other distributions,
of course):

    bash /usr/share/bash-completion/completions
    fish /usr/share/fish/vendor_completions.d
    zsh  /usr/share/zsh/site-functions

-- 
Todd
