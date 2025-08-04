Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421E23504D
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294737; cv=none; b=aYbbRBKk9Rsnml+e+ZVCzBbtjyw9PPTfPwD+Korv4EamWTPMbqfptKEGvxOUYD2vZxTHLpZPr3z20IVI6R0jvp3kIpPWAPhkvxHmBIjvs/X8v3UIpDFltaJfDdHf/d01OFRJrvDxjUT1hB4w6LBFSDbT+1zPqKxwhAIiJMAZ5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294737; c=relaxed/simple;
	bh=LpXD4DxPbU6Ztksnt0fsguHTd4IAOqiuWJj6bZeY8Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To8QEjDpidVcsOCn3/p4IzNVsPt1PotjA2qFQN+tApCOwkzaWE11gC8ZUBY0GkljuddGKIXU4smuuhTjNoIEbfURbokO7WD/OoR9LvfgHuVb4pWPggvKQz5vZbfGia5Uez9LuEBbqN8kvX2nXUW61oWTpX1JHz3ASw9IXZlBjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XMLqs65J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMphxyip; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XMLqs65J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMphxyip"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70B2D7A00D4;
	Mon,  4 Aug 2025 04:05:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 04 Aug 2025 04:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754294734;
	 x=1754381134; bh=P0xheP6t3gkazGoBWXlxPVvPBvUvhPeiq1qRfcFp1hE=; b=
	XMLqs65JEnXveV/CESKhwYwGD7Pqxn1iGt2YMTC/FLsKHznRwG4nW/dfGZtrYEAa
	zKBq92TKg/4XSfprwh08w8M7zLpAyuIB0qGg6vOmycDvrqfO9vfd0YMrVz5+gOVP
	dsz30vJXXWVQwgKE6A1JTG+up39ZPkzMAOtPAY48trk2yFkgPdBgET3U9JwK3gyG
	WYD5sUv30mEHf431ziA4NVlnBnxymPnMToNCf8c+HHOoBfVC8bcvOJIBCAljxJkw
	XjdWMGYR46d0d0hE2jnkCbG9/+IOISecO1rkIAaw3IHRATtCekGpqQmt3AuGHpp9
	wNw8qPiF05xJ50JeUYgaLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754294734; x=
	1754381134; bh=P0xheP6t3gkazGoBWXlxPVvPBvUvhPeiq1qRfcFp1hE=; b=H
	MphxyipMkyr1iSJ45kQYArjNXmRCnD6we0Ewa0g7B7zDqQ2B8e2e+MB1Lmf7lRe3
	eTAi/u+mngbDrsE0TWDgLuVZ8iKC8XUmQCP50DXoNEOVxic5rw6sUX8UrF9MxA1K
	TPs53Tl56dzUqauQGszbalog5IQZY+Gtk/cNT2DByhtfjBu6SGaFxQ7Al+hHoFh5
	0h9d/TyN3TwxVHs5IIHrfHFyAagXmqpNLYUbQu8iqnSBWAvK9qJpuS9v0rJyvPvP
	X6fksCp8H7ZQikuvN6lq/DG843UbLzg9FXpHeLxRh7uS13rDMJPbq+hRxLyjh21+
	eZhvLlqrrVRgSU9BoYV1A==
X-ME-Sender: <xms:zmmQaKMrWK1KJSUzL382h_UMWnf564JuLJAt4inBa72qK39O5MJaQQ>
    <xme:zmmQaMMOgc5e3rcTscrnxvtah62vXveUtjrBO7pPS0xzfqRquCMOsDa2b8v0hFtlD
    XndiiIuK7wrL6HmXQ>
X-ME-Received: <xmr:zmmQaKv-xH4WgnBldINfhXUxV9wgk0dnOVHaLsZSh1hR0oAjY29ZdwftOoJxVX8Ia3a_Pgt4sLFDVaUutER22axOAFA4h-PB8Be-Q_xa0z0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefheffgeeflefgieduleehueeugfeifeevjeejveelheetvdegjefgkeeguefgtden
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhdrlhdrmhgrlhhinhhouhhskh
    hisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zmmQaGWMs3A69UDf7qFhqFzgFO9XBppPd0tpZNMaTrbOukI_zbs4lQ>
    <xmx:zmmQaCsGQ1oJN7lCfrudITwfKF2YPCk0-D4pw-3PpOfg6nrl4CtpTg>
    <xmx:zmmQaCVMiw2NfgGLqo3KeAjEF0aYBjgxoF-TqNyD4k86bdzRXasdVA>
    <xmx:zmmQaFlqA5ZbBnfttOh2aUVW7g8a6gZ1DEwLGFP3T9vk2VeqUCYLrA>
    <xmx:zmmQaCI9DBwv_kIsrqn6Smcw0T96ErY3RXMmMXLt4PsxiBCHD3MfUboG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 04:05:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f49fdc68 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 08:05:32 +0000 (UTC)
Date: Mon, 4 Aug 2025 10:05:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Mihail Malinouski via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Mihail Malinouski <m.l.malinouski@gmail.com>
Subject: Re: [PATCH] docs: fix typo in worktree.adoc 'extension'
Message-ID: <aJBpyYIFR-JLzu8e@pks.im>
References: <pull.1936.git.1754291811503.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1936.git.1754291811503.gitgitgadget@gmail.com>

On Mon, Aug 04, 2025 at 07:16:51AM +0000, Mihail Malinouski via GitGitGadget wrote:
> From: M-L-Ml <m.l.malinouski@gmail.com>

The "From" header and the Signed-off-by line need to match.

> The documentation incorrectly referred to the extension without an 's'.
> This fixes the typo for clarity.
> 
> CC: m.l.malinouski@gmail.com

This trailer is nothing we typically want to commit into our history.

> Signed-off-by: Mikhail Malinouski <m.l.malinouski@gmail.com>
> ---
>     should be 's' on the end of the "extension" in the docs Update work…
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1936%2FM-L-Ml%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1936/M-L-Ml/patch-1-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1936
> 
>  Documentation/config/worktree.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/worktree.adoc b/Documentation/config/worktree.adoc
> index 5e35c7d018a..9e3f84f748c 100644
> --- a/Documentation/config/worktree.adoc
> +++ b/Documentation/config/worktree.adoc
> @@ -15,5 +15,5 @@ worktree.useRelativePaths::
>  	different locations or environments. Defaults to "false".
>  +
>  Note that setting `worktree.useRelativePaths` to "true" implies enabling the
> -`extension.relativeWorktrees` config (see linkgit:git-config[1]),
> +`extensions.relativeWorktrees` config (see linkgit:git-config[1]),
>  thus making it incompatible with older versions of Git.

The fix itself looks obviously correct to me.

Thanks!

Patrick
