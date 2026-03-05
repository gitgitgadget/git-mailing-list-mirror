Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5C9460
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716998; cv=none; b=nbUMao3ApcOVLzLAAZlSFBXyY0JDvOhlbMvtssPCkbU8HbfBajQVvd+GthR7fNgU2jVwETji+KlJeBdZIEmhk44wbcFFFRGbT+WAqUQHZHuknQzfZ08voETc061JoT1G6ksWHzYh4XVF6H/NZZhBnvlh9LtBN3I6HbWoj+1RLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716998; c=relaxed/simple;
	bh=DcDnNQtZgw3thy9B9DH3BnjSwp8aKd2lWd0wLOIuCaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti2OBYFTTloL6Xh8wB1CCIwEjSGvBhJdCakD1UFjaZt3c0hVlA96uJiCE8eaFRtV7vu9tPtT0TBciZtI21xkwGYGKZ9kWEgtyXhceRwulmcBYRNX3QoZp859+eTKMB8gYevc9sWLEh4BWcE+h93v5Luglqd9Xkr58N9efsNfvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ioFD4UEX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v8dRLtI4; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ioFD4UEX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v8dRLtI4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DAEAD7A01D9;
	Thu,  5 Mar 2026 08:23:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 08:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772716996; x=1772803396; bh=q0JJ5ykpcf
	wSZg/TjZo9zRPic9qt0MBCfcruo9J3eFA=; b=ioFD4UEXvG1482i7ZtsNz64g7T
	hHbkJlih3l8o8BFKoj655O46e7QcRVIqP/x21tgeXzTkKh0nTeIgJaiG0V5eoaNt
	KPKj4u9t3qdlpvKD44Dx57yslkWP6dpEoVfWIDOM6+xQyMQyIjvPTfcF3FLyuOhd
	DuKT21sfOcKSAdIorICLzG10KrZyjBVlcmP3RdmhkUYJP+kBZbym9I9o9wD0PPZa
	rrwCeFaCANiAZEw1bFraD8QD/pDjsyXeHZKdSoSPhMUJ79Q3h5dx3M75SnI/3gJB
	Ihg2t76H6LIDQYp8Q3HD2W7NC6K3ui4atj3TYiHVvJXDq0/7yHftg7qnsKsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772716996; x=1772803396; bh=q0JJ5ykpcfwSZg/TjZo9zRPic9qt0MBCfcr
	uo9J3eFA=; b=v8dRLtI4qn2Hev4+FYZUhFN6Bl8cv01LJuw98icx15RMGGTJBgJ
	5hpilo2nYlpPa1USTUf3VJLyEdvhT/VJfKn7fgCthpVy1AmVAUKkQm5erouKTLKh
	idpk9YTDqQqfGbtekmBV8/ZU8bgY8Wn8OUyFxmGTRJ9sEa5voRWXzBJj4p2JZZC8
	15NXWqL/CmwmO+mEK27MsSiKQtrxACrU59iu1ZPW++ohHkDv98sdbhXO/TDqglWp
	5xP6Bk0vnt7+ZmgeCrscx3M20Yb7VsmM8Hf4CQlCJ8rpzi++I23LVzwhi1F1ITpX
	hUJj3D/v0OitQ1MGilymaBvlKzOBc170alQ==
X-ME-Sender: <xms:xIOpaZKXym7qMn8vzRuOS12rLK7ygpKiPwvKMS2t-CBL46TEK_Ydtg>
    <xme:xIOpabJUm1-hDoeVTkM6f54n3WyVCYwrTtGXgIVCbCgtrsVB_xI4KKuGXOuri3s06
    qGerVGVTEs6sfMfVCKk3rjtDXs4ag_dw1WHY2erIW_yRIUTKICQ>
X-ME-Received: <xmr:xIOpafXxm-ebnT1uVJEo_-xGC-0vrXpVdimX3CE3sBDCZCg6R9L7WQOtUHU36jVT0uHepYnS2ImZH4Ik2f25qirRNlPyrjiJhzAKCEbn37pY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xIOpaVhsfmSRZFjO8uV0DNjXosZChHLWyqSYwGtVKx0wTBzxIfM2Ew>
    <xmx:xIOpaS-vEXo3qeXQo47l0YYtOgbB9iUKaBTXnOpea3zVcwGIjLtJPA>
    <xmx:xIOpaXC817vua-505j1kcyjpUuMHnmahDwm4DReR-dyP4bd63qUuQg>
    <xmx:xIOpaXKO_IAlBQdjJmpi7zXu-IM5wy4V2dqJLwvbfvJ5Qw3NZdDnqw>
    <xmx:xIOpaa47NRCvd9tZMlFM5MoZ_hVMGTvFhQJoKtF2keGfFL4JGUQIvkOY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:23:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aa6fe55b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:23:14 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:23:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/17] odb: split `struct odb_source` into separate header
Message-ID: <aamDv3M02MKthCPF@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-1-253bac1db598@pks.im>
 <aahToju3J2qj6lR3@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahToju3J2qj6lR3@denethor>

On Wed, Mar 04, 2026 at 09:55:11AM -0600, Justin Tobler wrote:
> > diff --git a/odb.h b/odb.h
> > index 68b8ec2289..e13b5b7c44 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -3,6 +3,7 @@
> >  
> >  #include "hashmap.h"
> >  #include "object.h"
> > +#include "odb/source.h"
> 
> Out of curiousity, since we include the header here, it is transitively
> included wherever we are using `struct odb_source`. Ideally should we be
> explicit or would it be best to just rely on this transitively?

Hum, dunno. I think it's fine to just be pragmatic here and only include
"odb.h"?

Patrick
