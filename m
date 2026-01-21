Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E691645BD68
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979975; cv=none; b=uWbSMZXe+oB5Q9vLMqpiJW4+YPV7Rpho9+ImN70SzEPPUwaGUzYzmYD5dlgspEnivv1ObPSWdzzIIrIluyADqoT5oZIKPWM4f/Sz1kAOBDCiF7Xv0nUwxt4E37nJPHcC555FzNcFdDJRmeqhmo8gilmjfAMDYR5bDyOAgChXWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979975; c=relaxed/simple;
	bh=sQYlkaYlvXjzr1OSJoKDpL+PiuUQZFN+Q+7HtiVwBaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf4gK+dLvCwZ2wrWcYDNdsbeU9RT/28QUXX0pi/1Ec+F+Gs/fYKeeCFm0snXsIrQmrCKBcXOlUkcSqgP0EYktfmjcizAAqkQDFglrLSFnxjAPqEZlAfS6w0wT5DKwhyzWj8Key3UJ3tCpfokaCeVxBpidxVwaTUsb/Vj7biTD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZMz8bpfy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wBdbpYsX; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZMz8bpfy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wBdbpYsX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BAD0F7A0137;
	Wed, 21 Jan 2026 02:19:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 02:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768979966; x=1769066366; bh=5TsbqmKzX1
	+IwWeX1pr1KgbzFqqMKnKm4LNTpo3RY4c=; b=ZMz8bpfyeQlWTtgEdA+0WCYsPJ
	wMdZBHbi9D92HCA0tJPz7qoBy2tg1xYu3SdQU5uU8pqpKUqPdCohBMjI3Vi0AyTf
	2atliih03zmUl9D7lf7MMlUSKgQG4OfhsL0e29B3sYSF7p8uT8UcmuzI67V/Gc2J
	sYfQGg8WPLu48phz+U7MBjXKlk6M3jhXPak+TQmuTUUoWUzW0WZ8JVMdyMjL08c2
	ZqwWVwLpEFbShemFX7asc6Po/zYi8VqsFf7RupUD85Pm0x06j8uMGRsb680o67Qy
	PQ64A1GvOEZALXY09HfS5uNAZ8H0wVEUywg3AZjbSICPi45G+BhNz9bpFMAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768979966; x=1769066366; bh=5TsbqmKzX1+IwWeX1pr1KgbzFqqMKnKm4LN
	Tpo3RY4c=; b=wBdbpYsXtuW5IAO2dHmWeyKUWfz90y+xOPw3TdKRLSCAzKTJQKy
	Yq4bhSN31Cs1xL9nE9GsPL+Itk1i5YZI7B112Z7dQowKeZYRvYcrzkiXoSi+74Ey
	IbTzsty8iTZzvZWgWSAAEUmYiQYw0V19s4ib7HIdax72wC6xP1eS66SOJ9sliUa0
	L4WCMTznqpkmWgIz58M8m7irmvtV02p51iSWy0lnzeReRptXUI0SU69EX7cTqYPD
	j7/Qwj/bBm5FP2kk/cJ6yNgiQimjIJhA9s2/cY7/FOzVz/Ch61PEfVSrahvujVrq
	MtvMOpSfD7Ne4PqFEbsH0iIPL0bP4dyKqLg==
X-ME-Sender: <xms:_n1waQIvXDYDWuYA6ZXN4_8ZcItZ9DrJBSX_bfpRKOnlKyxaKEuoHA>
    <xme:_n1waXC2gCTV13ZvwSkJ4W9XQuIfWfJSYLIzBhiJVIh7EEFThCSfge7zzfEss96-P
    3N6WnuZy2YbIVRsxEGx7r1HMvufIEoucCbxzBisCRXoUKKuxeLO>
X-ME-Received: <xmr:_n1waZDgCCFkO3XnFs8FabCbSQmvZj9MQlnFsCCw6p_9_x5Jo9KoAH8PCgwXqfa7Bgf6_r0hm3zFsWoPMDDwfU9h5lc8vuYktw8Q7jdm1iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghvihhlrgdrjhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    eplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_n1waZAn6nTKmq6ke2RritCdph2PCqz5Df3Yf5ru5wqG34nIVvFzUA>
    <xmx:_n1waUr1E7WKM0cov7TdRJyq3LtLkgsYdNehTzSlEvEnxHB3W1QwEg>
    <xmx:_n1waTlGFFgNq9R_R8vHEdBOAumL5p4Mp3bJYwf-Sd_K-8URlUhVHQ>
    <xmx:_n1waUxkfjiVO1gjmUd1qfW_9HZqA7O22TsmIez5oab-tDfnvfnSZg>
    <xmx:_n1wacSd36nMa2YrwTYsASgbmsOTksYlNgMwT09flkJ5PTj-YK_Uxwcr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 02:19:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb536215 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 07:19:23 +0000 (UTC)
Date: Wed, 21 Jan 2026 08:19:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	avila.jn@gmail.com
Subject: Re: [PATCH v4 2/2] repo: add new flag --keys to git-repo-info
Message-ID: <aXB9976b3Oqf-_Tp@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260119210932.68893-1-lucasseikioshiro@gmail.com>
 <20260119210932.68893-3-lucasseikioshiro@gmail.com>
 <aW8bOfVLcG58t-Uk@pks.im>
 <2B17A803-F1E0-4A9D-B0B7-2C62DA3939A2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2B17A803-F1E0-4A9D-B0B7-2C62DA3939A2@gmail.com>

On Tue, Jan 20, 2026 at 08:11:35PM -0300, Lucas Seiki Oshiro wrote:
> 
> > Tiny nit: we also tend to terminate the last enum value with a comma.
> > The reason here is that it makes it easier to add new values going
> > forward while only having to change one line.
> 
> Sure, I forgot to add it. 
> 
> > You also have to adapt `cmd_repo_structure()` to handle this new vaule.
> > Otherwise it would `BUG()`. I guess the most reasonable change here
> > would be to treat "lines" and "keyvalue" as equivalent?
> 
> Nice catch! I don't know if it makes sense. If we change that in
> structure, we'll also need to also change in info, making the name
> "keyvalue" useless. Another solution: change the current "keyvalues" by
> "lines" in those three cases. Maybe it makes more sense than the name
> "keyvalue".

I also thought about it, but didn't want to propose it myself. But I
agree that this would be a reasonable change. After all, git-repo(1) is
still young and it's marked as experimental, so from my perspective it
is fair to do adjustments like this once we notice that we've been a bit
too narrow-minded.

So I'm all for it.

Thanks!

Patrick
