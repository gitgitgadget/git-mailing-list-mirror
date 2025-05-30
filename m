Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90522F386
	for <git@vger.kernel.org>; Fri, 30 May 2025 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613934; cv=none; b=YDcansPHeGtBShpzv92lUQvlZLcsMXfVldqZUJNIji9WblPizMl+q2Dh/I+N57DHVeHZd0THBd0tBqQtgZ7kO5mVYj6FsnDKyqGqjiMfreTVpt0vLw1977TPz3saJIFTpDi57mvCSXM2ws4/GKnO3ghhvovTkBGaysjcJXHOQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613934; c=relaxed/simple;
	bh=EVy9B8em9ROTeMAQ53Lwqxg0nMDZO0JORIDhVbGMpJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8noFHie4b0Vg2QSu/fSdZQxOvEoqFFPqNcd/Z2cy1NYZOiomhiCUF3/IuSatDgRoouMqjywvuxaKP4In1hM2P42zn4RVBHVnlu0KjSjeoGvT0kLiLQHGQ4OblIKPPREgw+jlOK9fk33kpF1exLKzfWKyjTu3VdMKpEvEUVKraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JXVnDy6q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oXZj9Btg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JXVnDy6q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oXZj9Btg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBDD611401AE;
	Fri, 30 May 2025 10:05:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 30 May 2025 10:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748613931;
	 x=1748700331; bh=Tabq9TB4F2wRa9Qa6YDAo+ep80a7j7qUGqyxYsKYDkk=; b=
	JXVnDy6qfLgwhugbeXzSqD51Th/hMkiuVvmzm8QrsK7NPPS5WLVPG11i8DV2r7Vn
	oJtXlQAvKw/ux3l1pqjtH9Cf+0CPz25KOA2JsqjXjg1PFA6bBsOoam5CW+RYwuqD
	TB1CXGJTUG2Fwfsq2qHT0i5HsBtd6kbaDWUsV3ZhTdqBjwbsAjaYPhXvETYQH6B1
	WoLDDyfX0nDsXCyEeNqCWY/GsRo9hhDOKFkiX18xfFVtjowXpHkPyhupR1/aFzh1
	bY3DOsuW0zx8FLb437SBvOrDAsPdhn7Wk1KWnoAlGY3tzmiEhod+2OFp7DtYyGye
	nmITf5RyFfaehs500lYHNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748613931; x=
	1748700331; bh=Tabq9TB4F2wRa9Qa6YDAo+ep80a7j7qUGqyxYsKYDkk=; b=o
	XZj9BtglAMdI/ME+5kZNkbfe3IfUL1OLl3LytlgE7WlThGfsSm/eBoNo3C6Law/a
	w3CQlxSiJn1pyyQbeZs4vmXaMnYWjhMI27QLX/zNFQ03Ctj+3vm60hf2TUesyljI
	BZLPw+2LOD8ASpGxMHEt1aL6btIHIGTcp5oGN46zHKXWTjj0t8ECZJ1ein1ZW5t9
	12K+TJX6XCKJVdjUaolLfXqAxmUDzQasvoSJebFjcuSLKaXXDm80W0RxmfiqkQoT
	DvIfuZa1tOqAsgSPH4J0lJOGGkg99swAVowmCIWZghUY9eyMTWZuqZ9YCRBSX52a
	AVuVctscgEeRKgiq5n2qg==
X-ME-Sender: <xms:K7s5aOGNu84uX9R6Y9nzftRNwVdI5XOc0kT7YYa_F0Vo2D80fmbg2Q>
    <xme:K7s5aPWqtbiUCmkua7okEKflR2Gm6PyCZvAmKWU_zNL70dKgc-51dnaI-u_idFLSL
    PqKGTv44y3v-sovVw>
X-ME-Received: <xmr:K7s5aIJALuQ9LQi-fCBptnBhGCqgTy2JGlTJpUvJYvV67oLBW9WeTfBbpYLKAOJThAm-2EXq_rXBmDXbQv8kNwRVsvUznriPseOfzBfscw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledvudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleeh
    ieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtoh
    hmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:K7s5aIGvYS4QBiOUjIpCD4sTUUUhZ1S2AGkEUF_cJVgjthNolJ_vJw>
    <xmx:K7s5aEVkdWj6E0XAEb8yV-h9xPM71bKxf0zyTbGwDvlxCIXj7NA9Cg>
    <xmx:K7s5aLNLlLhND9wcNXbnEzww5lt9cJEjIOvUZJA9hw5fLL0QO8Ue6w>
    <xmx:K7s5aL2eyEggnakZoeig9rHJx5I60gueWQsoIVx1wKgdbqn57Ty2UQ>
    <xmx:K7s5aOsWDi2UAvma8t6ikjSiGudzNCPr6G-Z0leQw0yk7EInxVyN0QzV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 10:05:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0870dd6e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 14:05:30 +0000 (UTC)
Date: Fri, 30 May 2025 16:05:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
	david asraf <dasraf9@gmail.com>
Subject: Re: [PATCH 10/11] builtin/gc: avoid global state in
 `gc_before_repack()`
Message-ID: <aDm7KdKrjhjDToqH@pks.im>
References: <6EE3E4F8-16DB-45AB-AD67-FADE12FBFBBD@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6EE3E4F8-16DB-45AB-AD67-FADE12FBFBBD@gmail.com>

On Fri, May 30, 2025 at 08:56:36AM -0400, Ben Knoble wrote:
> > @@ -965,7 +957,8 @@ int cmd_gc(int argc,
> >          goto out;
> >      }
> > 
> > -        gc_before_repack(&opts, &cfg); /* dies on failure */
> > +        if (gc_before_repack(&opts, &cfg) < 0)
> > +            exit(127);
> 
> If I (a relative novice to this part of the code) am reading
> correctly, we trade an implicit die in a private helper for explicit
> exit in a « main » function, which I find much easier to reason about.
> Nice!
> 
> What I don’t see (being away from the rest of the source at the
> moment) is where 127 comes from. I don’t intend a crusade against
> magic numbers :) and I’ve certainly seen enough exit-codes of 127 to
> guess what this means, but reading only the patch the number does
> appear out of thin air.

The funny thing is that 127 isn't even correct -- it should be 128.
Maybe we can adapt `die_builtin()` so that it knows to not write
anything when the first argument is a NULL pointer?

Patrick
