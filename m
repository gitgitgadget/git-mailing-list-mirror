Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ADA193075
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520506; cv=none; b=B/KqDMaQKBY/eLQKmyieWbqphXjzBjqqgR2hZ8L34U23YI2p4qqfIZI8la3a31ODLV65mLwjU0Ocgt0WziOAGg0rguAmLCyn973du8V/n2guQDkYZNZpop6ER/1o7xuj6muXWBK1iVKLEc9qrJnT15DxZXNTlkIVESWXe3bBZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520506; c=relaxed/simple;
	bh=AexZDlm+O1JVJcAyTlLZcdZui/deEDfMD7yORNSiD8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kde5MjRdDrqeG3mQr0XX+KEk1vOFfTFXjJ3yCxfvwBfHDpGLEv1MGJhwdqdcoeKx0uQqgEEYPbjpFraneUg3ZrIUr67H/Xcv3Vr8KuGQdiC1pn7U+GnVzRQ82PCA4il8ogpuUNEBB7C/VT6/Z4JzG2xyohD6gG5kUM9f3RKbsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rEweAqqT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TPleeZGp; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rEweAqqT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TPleeZGp"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D078913801C4;
	Thu,  5 Sep 2024 03:15:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 03:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725520502; x=1725606902; bh=PRzMHsKzEJ
	Q5WnuZqV1K3D2u8KEMJs3L+WCi63RY9II=; b=rEweAqqTVxDcnX7iRxHo6uuH1m
	NZsXbg/9qVk3/tnHTQQRPIYYVvgr6AZ6upXSLKszG15AROyB6ZFHYuqHwe2zsHnu
	zjFEEhvvbOuT4wIELRoO5rZLkFoBqsCasZ9+trXjeOV3vchKeQsNucwrf1lsDJZx
	F7RXJ1zU1c7V6+oobKNgySpccVcJQyYeQ96Lg+giLfPjBMnlzqSFCpYaCztBh9xb
	prgl1lwGgh8hL5dELTLXOy+ETE+fNRWwUBv3iViqeoIi9uHKrxcdNUIisCCOzjeB
	dFjJJbiIC2ZQICGqg7OfU4irqF7Ne1XVyjKe0uKnFUBJP9aXQvKAkkHDVQbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725520502; x=1725606902; bh=PRzMHsKzEJQ5WnuZqV1K3D2u8KEM
	Js3L+WCi63RY9II=; b=TPleeZGpuBZmhzejYW+Rmg86MxUq2mHVtKmLsbdx//qN
	UIbkGEYdrHCoZih1SMS0JuJ7jqfIZ33oCB61qUb3m+NcFpKvLm8UI8SlMa40By3P
	6jAkzzmztahnyIN6S16QcarRdBiBmQ31nIhP81y3vIzTEeHCcfv3QvFXxKzGjX9P
	Z1GzWt58Bz3/dr9mkjFzDF6LjcCwHeqGez7AkmecOkMX9+Q81SYBpL/xN/MSGSes
	D+g8ZKm0taqgZ38lcAiZbCLa+hGnaKcdiKWHY6OCQ6yCCEeFwXSqvQKkx107Qb9f
	U5G3E0W2wuQjCJVocVzKxZSiJiUWp6giX6PGIZP6oQ==
X-ME-Sender: <xms:dlrZZmxE4EXdsnzRdnPtkrlgJFSlS3UYTkm129kSptjFMvBeeYLyVA>
    <xme:dlrZZiRGfEFbh8qER4kpX1LtrhkP2K6xXxQiZUu_QJDDcHpov1pfx-jVm6_B7CCoO
    IdD0wIXmQ0sLThq_w>
X-ME-Received: <xmr:dlrZZoWNfmGuE126BfZHP_qcKOnA5GQ_geeCLNLhxw5o4jJ_b77e8GHu0uQhe6f1Q_G9a7LTRs7SbmO4lj0r5IUNFGUwobkWuE7k0cJAr89JfLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehkedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtieduleeu
    lefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:dlrZZsgrh0fJneEsqs9a079NBazRfhPS-QKw86ziGLG_vWQxb88aAQ>
    <xmx:dlrZZoAYh-7nT7sGm29M6Mo9pvzPRA8EXWoftwz7FJimVZPJIK-yZQ>
    <xmx:dlrZZtIKbwZAQkBODZzl4JlOYc3ApYy3mVJnoT-SLk2Pnv6A47EUFQ>
    <xmx:dlrZZvDYNQnOxWhkR_eQRfMG-rs9wCXrjPJC4Wd9HkwXPTQW8wEZ9w>
    <xmx:dlrZZrM4C7DUr3EWb1GCEKqCnTCJ_HVk2m9m1mohSS7OPt5wL8mXiU8m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 03:15:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 169c7be2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 07:14:48 +0000 (UTC)
Date: Thu, 5 Sep 2024 09:14:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 3/6] t-reftable-stack: use Git's tempfile API instead
 of mkstemp()
Message-ID: <ZtlacTtiEgPCRzTi@pks.im>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-4-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904150132.11567-4-chandrapratap3519@gmail.com>

On Wed, Sep 04, 2024 at 08:08:03PM +0530, Chandra Pratap wrote:
> Git's tempfile API defined by $GIT_DIR/tempfile.{c,h} provides
> a unified interface for tempfile operations. Since reftable/stack.c
> uses this API for all its tempfile needs instead of raw functions
> like mkstemp(), make the ported stack test strictly use Git's
> tempfile API as well.

I don't quite think that this is sufficient motivation. The real benefit
is that we know to clean up the tempfile in case the test fails because
it gets registered and pruned via a signal handler.

Patrick

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-stack.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> index c74660a1e2..8047e25c48 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -76,7 +76,8 @@ static char *get_tmp_dir(int linenumber)
>  static void t_read_file(void)
>  {
>  	char *fn = get_tmp_template(__LINE__);
> -	int fd = mkstemp(fn);
> +	struct tempfile *tmp = mks_tempfile(fn);
> +	int fd = get_tempfile_fd(tmp);
>  	char out[1024] = "line1\n\nline2\nline3";
>  	int n, err;
>  	char **names = NULL;
> @@ -95,6 +96,7 @@ static void t_read_file(void)
>  		check_str(want[i], names[i]);
>  	free_names(names);
>  	(void) remove(fn);
> +	delete_tempfile(&tmp);
>  }
>  
>  static int write_test_ref(struct reftable_writer *wr, void *arg)
> -- 
> 2.45.GIT
> 
