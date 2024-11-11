Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8B16C6A1
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316181; cv=none; b=CICvvxwqP9ocChPfm12+hz5k4Np4/nedOSBJY3vSc2SH6zQijjMRs77FtNI553vS0wMCZEtlZFpqLlPNB2ZgQ6ltRNnpcbfIo+W+Zjvux/DGSD2k4skTfwQYEVRhjBT2/ND6m9IaP/rgMYEQNiPBVjhzbnykoz0wmwcf5h0zfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316181; c=relaxed/simple;
	bh=TNPc4VYMQzyZ/NuWSjyRnhKk2DpSVC0LX+wKxbbk8TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH64PjYZ23Me6bTnqynbu01kQdu/DlL7UdllAqpsw7patmDK+xnq4kCybdXGXEumQXPJv6f1xtprCgnI6il4UBDzC4XU78PviHHW6V79hOv79twzP4n+bbDflgBs7etyRrdlTtZs0WUpROhTWdcTt6KFAArHIVUMzTSkBt+u30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F7AmyNQH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gsc1Ewl0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F7AmyNQH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gsc1Ewl0"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB6E01140141;
	Mon, 11 Nov 2024 04:09:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 11 Nov 2024 04:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731316177;
	 x=1731402577; bh=H8p4FT4VOsaHPKP+H1Gn6oq+drPwjXtIH8CdfashUNM=; b=
	F7AmyNQHxJ2Mt0cLDdEVHZ16E5pk3GCvU91+xUICy6Zwi4zWaXx8oSxFuyzixLJK
	RbSrhYBRSA2owTYfdRq1c1fG9v9xm5usn0ifs1XaetO4Ihc+QmOcoxFX+PG/eXJb
	rYL1IFBf/ahM7a+LYZ4NDFjMvR917ZH19uzv+oZ7wJJkyf4uJNxdvOuiMf72OHE3
	VmLZzO/Q2xCJLoA4j8QLOg0r2O0SosgDWNCv5ze6a3t61NIB7I5F0G2LcuDA9pvG
	wchiz2Mi17otk9GKojskd3lYTE0yLDgjaYOjuQPwWLb601MhnGsAxoTGk/9+CDJ5
	ugfh+l26VvWWlmhCFCJabw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731316177; x=
	1731402577; bh=H8p4FT4VOsaHPKP+H1Gn6oq+drPwjXtIH8CdfashUNM=; b=G
	sc1Ewl0MWtuNje3dKFi+fqzqMA7Bx4KD34CEgpXN7hmvNAg0O6b7v5Vla1adu0Qb
	7UPujFafiQ/VQeFXhxwH0Sqm+Pyty+bhIPsnrkKhYhDFURaBerRMaDivRMpjWRz2
	Pdksyses3bISePKxs+P/5kh8NAnVJumwT5GO3quxmr/0n1xony7mBt9t7ZOvgGkL
	RoSDNsfnISbGDj4K0XGxV6GXHkl+bUE2jWObnFUALdEPlkJ/5FW1UNAbyXJNNUjo
	KZuJt8VlwRltOrYqPQvkR6+eOjYrnGQMEuk/UEgt9szqeLfXASZfsOwtn6vMbd0V
	rtTcpcD3tBUDRkOsqpmkw==
X-ME-Sender: <xms:0ckxZ4HmZF7TTRHt_U38h8x5myfyBZnQoOm_h8w-sRGcOF81CToMuA>
    <xme:0ckxZxUn8HzDNbvEm82Jh29IWOB9N3K4fRtqMNhA6ETdouQU5pw63PgrmMJ_GdC_3
    0hHZV3BMQat_skDZA>
X-ME-Received: <xmr:0ckxZyLaGSreG6gJDtkXOk8MGj_DsfV6RGqSu3xQ6jHJwP9xkk1-N0za-Poug1UO-4BxzlxDWZ2MdLkFuYHKfb3BZYIt33oXtZfkz_8XvP7BVbF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveev
    jeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprhhjuhhsthhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0ckxZ6HYN__OKr8vw-3aybcBXyEG-vIv0C4W8O4AweJcs1ofF5gT6g>
    <xmx:0ckxZ-WmF2b1g3rcPc4c8_v0kYmBPA3oWLdtUIGWVsbrQ8RZSmlBhg>
    <xmx:0ckxZ9NpBqpdYj2doA-z9sKGZ9jBvkh85xw-7yza2ZTYI4KUO2JTTA>
    <xmx:0ckxZ10y8CJK-yZw1d50mvfeKQAEvZ9_PWjP92_ohGZJz9cJNWK3FA>
    <xmx:0ckxZ7jLmPC07qtgpTuWFSWOZoR_4VWbeWmKRikGgUIUVfKqsu_feCio>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 04:09:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb20d452 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 09:09:01 +0000 (UTC)
Date: Mon, 11 Nov 2024 10:09:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/26] strvec: introduce new `strvec_splice()` function
Message-ID: <ZzHJx34wavjbGeqr@pks.im>
References: <cover.1730901926.git.ps@pks.im>
 <c23e1a08854530f5c2474725ddde1da1068c2c12.1730901926.git.ps@pks.im>
 <41165e8c-eb5d-4fda-8f6b-67b7ec74bcbe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41165e8c-eb5d-4fda-8f6b-67b7ec74bcbe@gmail.com>

On Sun, Nov 10, 2024 at 10:39:08PM +0100, Rubén Justo wrote:
> On Wed, Nov 06, 2024 at 04:10:44PM +0100, Patrick Steinhardt wrote:
> > Introduce a new `strvec_splice()` function that can replace a range of
> > strings in the vector with another array of strings. This function will
> > be used in subsequent commits.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  strvec.c              | 19 +++++++++++++
> >  strvec.h              |  9 ++++++
> >  t/unit-tests/strvec.c | 65 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 93 insertions(+)
> > 
> > diff --git a/strvec.c b/strvec.c
> > index f712070f574..81075c50cca 100644
> > --- a/strvec.c
> > +++ b/strvec.c
> > @@ -56,6 +56,25 @@ void strvec_pushv(struct strvec *array, const char **items)
> >  		strvec_push(array, *items);
> >  }
> >  
> > +void strvec_splice(struct strvec *array, size_t pos, size_t len,
> > +		   const char **replacement, size_t replacement_len)
> 
> There's nothing wrong with `replacement_len`, but it has caught my
> attention because in other strvec APIs we use null-terminated arrays.

Fair enough, but we do end up using this in a subsequent patch, as you
discovered in the next patch. So I'll leave this as-is.

Patrick
