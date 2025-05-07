Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8BD20FA86
	for <git@vger.kernel.org>; Wed,  7 May 2025 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600756; cv=none; b=RRYFy40h0Z7YHo/nsWLr9C7YYGusQ+PIIX0LKQlXD+aL/pLBTG+lzDUgTgj4ybICnVJ924sJeBNPDKT7fKtWbfb3lugllzaa9vvwfsaUWPlGLbby/j1ggRSNLCRuwLWEpLYebY+Xt04YNKOYv+5g/PtLkUzqamZg4xra/8CQE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600756; c=relaxed/simple;
	bh=D0H0rrGhOuGL3TqEJF6V0gebk1tLBIWYmCN6MN/AV+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUNEM1lmnp+C+QaUvImhi6WmiS+2/drhU5VA3sLfC62s/g3sN2tXGub48HdsUn2sMCmU2yxQ2s2NQ7vTD3LUTRgNkrjTN7DlN5uyfR5rxI/wjrBLLE//NLPyLL/gizNh5h5K+A60Gk9zYsXwCAr9Tjepmv/sqLjHlWdSR73v4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BKES1O+y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZV4vxU+2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BKES1O+y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZV4vxU+2"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 667FE11400FA;
	Wed,  7 May 2025 02:52:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 02:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746600753; x=1746687153; bh=mPJAD2VY7I
	J4P4woyqR1bdb8u/cyKjB36PLf4Xv7sDk=; b=BKES1O+yhH0PIFG9Beui+YwHmV
	m/sH5L0FaHM5GmaL26giTwsrImGiEvyIdmnXJROjzF9ZDvholORybfiS/yJn8iK6
	WKCYYnyrw1TMPOHaHP4TvRW3pGB5vjsmqXtGesZFC0ntc6rNkxPI++/owsGVZ7nU
	y7rLZuAG8AouzNbi0L52OSpgSe4N6WnPo6CRqfp53VgENVUCYw97bo8crcH28w8V
	a/ITnpNdx2dJjGGtEPvahvY5dHaXV1c3Byu8qkpemRzXfryxc0ZlNgDkQqdrs0f5
	64T3RmbKV/sKie+jlXncqw1qztlg/RknRV1VPzwh+4fz7lvN63YXjcG8gxCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746600753; x=1746687153; bh=mPJAD2VY7IJ4P4woyqR1bdb8u/cyKjB36PL
	f4Xv7sDk=; b=ZV4vxU+2AP233mSxUprldUWrj6zM0Q3cy8jwcEJdq+N9bSosYYW
	FPGej3l8Np9iIDJlQcR3RG0Kf0NKuTaKEWvXYb1/0+sEIpvNQYEiD2vEJ3CudfeR
	sF6sGsKtmdPKccZ7h2SiLNdljWg7IpXc/g6dRMZUwDUnZxmNkC5c2EopGOLf2x15
	MmNv5yhbkb9Pj0d65upup65VDHD7jpkt8daF3sHdy4sJ6TwkpDG+3sHIaBAwO4A4
	8CCzx7sSN+ly1HSCJXEjVTZqY70cQFYl+d/s5nhu7rcO8SqN478F/icAT+Ahl3yq
	HZzwKcRBRKQPcXhvG2EgkzzXHFlIUcyrd8Q==
X-ME-Sender: <xms:MQMbaNvURaBEknMwkid-i4aUf6sp0QH-9OKgjbGuxPfiBNwOcdpQXQ>
    <xme:MQMbaGd_0ma1DV3ANpygW0q61eP_SCmQNVizgEslCzmJ0K7vZiP_kIan4MhMudJv0
    fLA8i0KZ1gPXEj_Yw>
X-ME-Received: <xmr:MQMbaAwha6JKbdIvIgS7SjSnY3hIO3opgCcKcp2Fh3A21mJF9SSa6Fe4YxNmrD5hejGN9TaBegzkwJl3SPN9CfTd-DtRmHiD7nxrUF_K3WOUTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MQMbaENGQYtbHHLuOTW4_50e4pYjfgHVj04jGj32vLEuk8SAKQQicw>
    <xmx:MQMbaN_g8gsSIVXUzvPptNBGtgMx0SG8Y08rZQx7Br3zDIwFeYmaBg>
    <xmx:MQMbaEW17Hwh6Rk9pARwqXkfrzZKK_b4DYVw-Gq-M4nL74FjxqLsQA>
    <xmx:MQMbaOe93j9_Ejwd8aFjqDZ2oAVCGZFlz2jWioZtUu65R36fkJwsIA>
    <xmx:MQMbaFZASLmzufgKtTwG0ee9eSC-KI8qGji3ubhw1Qeoa6D_g3B65-Az>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 02:52:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebcf4e61 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 06:52:28 +0000 (UTC)
Date: Wed, 7 May 2025 08:52:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] t: fix cases where output breaks TAP format
Message-ID: <aBsDKayGKszubn5i@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
 <20250506-pks-meson-tap-v1-1-5aaab2942a4c@pks.im>
 <49ef0fc1-39f1-4771-88e4-440e0924478f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49ef0fc1-39f1-4771-88e4-440e0924478f@gmail.com>

On Tue, May 06, 2025 at 02:17:09PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 06/05/2025 11:59, Patrick Steinhardt wrote:
> > The TAP format does not allow arbitrary output outside of a specific
> > test case. If a test suite wants to print any such diagnostic output,
> > then this output has to be prefixed with "#" to mark it accordingly.
> > A bunch of our tests generate output outside of `test_expect_*`
> > testcases anyway without such a mark, which breaks strict TAP parsers.
> > 
> > Upon further inspection, all of the output generated by such tests is
> > rather uninteresting. Refactor them so that we don't break the TAP
> > format.
> 
> I think there is an argument that these tests are broken and we should be
> running these commands inside test_expect_success(). However this patch
> doesn't make things substantially worse because although we lose the output
> from test_create_repo that probably isn't going to matter. The changes to
> the highlighting prereq look fine too.

Yeah, agreed, our modern style when writing tests should always use
`test_expect_success()` indeed. So an alternative to this commit would
thus be to use `test_expect_success()` as you propose. Let me know your
preference, I'm happy to adapt if you think this is preferable.

Patrick
