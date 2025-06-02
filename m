Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7301514E4
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892825; cv=none; b=BFZ43GSVNUlpBkl1VvJDpmxoFLgXQpHLp8hK9KFhxP0Ovlz2CkpycUPkvsRmk7b7OoAQEUDWt+/l/626xtyoon2prueFe0gGR/5nBBX1BuiAKosktir3uBUUIBg9dWKLuir2ZdIiT63rvMUNDMQLbQldEHI8vvq0YGnXojpbbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892825; c=relaxed/simple;
	bh=Ers0io6haJ/DS1zCjDDysA+oe16KHq6WP1ZXTp4KzKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DuIEepBYWD03nIIunw5oVdZ5DSIg51vrXtjnIFIwAEmgv+wyNRDnDTD0IsDLoDBL9Vg77bavTrFoRe45OLv95lxmAGnMLF4pQMY398rhggETI+dEDnnexknGkj7z1+YGPfgn9vrq8f7Ha2Qi1LSG0JK056+mZDjCJL5t8XkQCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aLNNnL7o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kv92aU5T; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aLNNnL7o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kv92aU5T"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C47D254019B;
	Mon,  2 Jun 2025 15:33:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 02 Jun 2025 15:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748892820; x=1748979220; bh=1rf2DzN4wS
	LaK/WyN7tek9T0FSCowDwNhIEQqGS9F60=; b=aLNNnL7oX9uv3KLsR9ZHPpBw/D
	LJgACIFYAKMdcM7Bz0xl2OcMGMPREGt/E942JFjMXEphOfnpNO0eJILX30ZXXqSI
	Q1XJyW0QzlqLX9tWVmQq1Umm3BH6pRa8wzaGNX9wkbCol6iGrwiVraPzOTH/oeYK
	jCODq4H/RmAFDaRsMn9722rr3qJSf+LH2JQ5lj/qKO83umcZ2wThJWURmZA32fTy
	EUozr1rZWeGxaqjTT6855DrPs5TS36iyCobRyfp/C/cVgw3/jmGbHQfJhBIjvp/D
	sM6HgaU282tN2sU/FwwYYX91RiUDFRSXoOGVLaehwN1jsNyUKaeLgv/0Ygxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748892820; x=1748979220; bh=1rf2DzN4wSLaK/WyN7tek9T0FSCowDwNhIE
	QqGS9F60=; b=Kv92aU5TZy0PwTpvZQVzVZr9tVWeRBPRTgAuQEqqhKPKTQSUNq1
	/Inr2haG8Bt/5DxAHhWHuBes6a45TtBuVrilV6dqYxj1XMjXMgljNplF52vgTPTF
	5CCh6gcwePhDW0rvn56Wd+NHNRfzCRQ1jWgIKh8J6hQQZf3ilsBG9x4gjmi6EJkF
	Tz14McnU1naYJkYG8WzL5Vc+X+bhCQzpfehbW6Z7rfc4kJVr/wCFW6jYGq1PP2j/
	mPNQt9qfe/oNFo9BQFOJDoKbEP1wGDQY2H88cBPtGSIxHafH86SYp2vMB1Yj0oNT
	Uu2dU7TiDIDNc9lPJxJ66sp3y6GgdojSgDg==
X-ME-Sender: <xms:k_w9aEnf7nN5F5zcmX6TBhqFXa0-9v1WqtTVfNcrjhMd9zfi0uc0_Q>
    <xme:k_w9aD3EkmZs5JjShDWhJEi5jF250qe9tCLxN0IuT6I9OoRJ0DRSOdRaB_W1_C6h8
    jVG-aZNs4HqQzmURQ>
X-ME-Received: <xmr:k_w9aCq0aE6BMamTz0GDNrpgYavcOI4Imws9K8pWy_7xX_Ykt_P3HX_gCbYeIlyyPFBEJLNye-4LyeX-AJ5Ri0hRPtdw9S72gR6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkeehvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:k_w9aAneDTwatO3aPB-9NG-qkwXO08cTWRnh_okSt_QSWiAjuG3ITQ>
    <xmx:k_w9aC1k88GiVFLWsHuAZ4doML60oenNzY0FZbanuzfH9zsxyxVQeA>
    <xmx:k_w9aHuxBCH0AKGTq1ynK5rkMF2lc0ICqjfg_Y8I3YHxpBP_k8qeLw>
    <xmx:k_w9aOWkdQC11SSBXkBE-ZD-RqARGgtK3reIOl-70eVzPrNwMhZbVw>
    <xmx:lPw9aB_jmSr81EDYzubJMbVzhcoFsvocg2WlEc4uZDcTTZqWY7iMKk6v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 15:33:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 06/10] t/unit-tests: convert reftable table test to
 use clar
In-Reply-To: <20250602122559.208780-7-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Mon, 2 Jun 2025 13:25:54 +0100")
References: <20250602122559.208780-1-kuforiji98@gmail.com>
	<20250602122559.208780-7-kuforiji98@gmail.com>
Date: Mon, 02 Jun 2025 12:33:37 -0700
Message-ID: <xmqq7c1uszu6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 3cccc73073..0227fdb3e1 100644
> --- a/Makefile
> +++ b/Makefile
> ...
> @@ -3972,4 +3972,4 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
>  	$(OBJCOPY) --localize-hidden $^ $@
>  
>  contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
> -	$(AR) $(ARFLAGS) $@ $^
> +	$(AR) $(ARFLAGS) $@ $^
> \ No newline at end of file

I'll fix this up before pushing this morning's integration result
out, but here is an occasion for a quick quiz.

Can anybody tell, without running "make <something>", what this
accidental and unintended change breaks?  It may be rather
surprising ;-)



