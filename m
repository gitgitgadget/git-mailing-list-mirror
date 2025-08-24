Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F352CCC0
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051380; cv=none; b=b4Ymjyoc/Gmrt54lHdJb4HH07OPvMnMCS+xdlD1hWRDbqua0IRo5aJGGvVL1DVkYhtmNLhxzq9B3ULBKmIEZ1aG1tMTmIfU5I6BsNrS5RIs5QJkLt5ReHps6eoR7ZJTQ7lUT/DDq1O/S8lk1YQ+DZ3FvLTE2c814IEoAarS0g8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051380; c=relaxed/simple;
	bh=2hWDsMK8pzkxbm2UeXUy294fUYURawPWXK08ap2ERe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Van/UVwHS6hGI2YFJCJSQQfbWqw13wq6gEMAbTKZY+MXbJ/xwBbotB3HSGtjseA6Q84AOvkbXniEAHeDc/sN7NVSBHo9aSUTixzsJdT7PuCOVH7lBrhseD22pMWGIE2PArecAo9jcSqn7BvhPaVGN5QhHxuw/kM/3qsh8s+xZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kW50lJ53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRrUuaUQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kW50lJ53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRrUuaUQ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5ACA17A00B6;
	Sun, 24 Aug 2025 12:02:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 24 Aug 2025 12:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756051377;
	 x=1756137777; bh=oezRUq4985JHBKFTqO17S0Kgo/wGvhkFsoTxpeFpc7Y=; b=
	kW50lJ53Q/1+RSiX7XGGOKp9EGAIUj/7vk5+xMy1TIX2OGihuUoaIHiSC0/Qce4j
	0S997qbvfy8bLZeYNYo//zcW9lFBI835DsMrd5GYqI3BunWmwlMNHAXp8CmOc90K
	aVquqo16CDyGeQVCTu4DyfmmkxWHb123J0bHPnroxS9h+eTH/9wvP8BngEB2uZ91
	6OqyvqzKATtnv7CjFjuSCGXjhi6tIHrrUIq8Ckkz9eZpOo9Pnm3OrJQt2OYvP0/Z
	5vTtnQXJ8TeQ0ne8ayXq+ARcAk1GUdT5R2rcP7mx3XwE/rxkwqOzgFaPQuCUxsJ/
	Ffai0sJX9hGORs2Jb0t+zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756051377; x=
	1756137777; bh=oezRUq4985JHBKFTqO17S0Kgo/wGvhkFsoTxpeFpc7Y=; b=B
	RrUuaUQP3zo+EfEniGbIEQNjUVwjkmM8UgTt0Sr5L0PhoNWNiofgfB5V/Un1O5Uv
	By9oRQpDyttTXiXKx9r9zCBUtD0fPoxaZVNjKlbfso4WU7aaLbcAP6MrwM257mCu
	Ai0AYYmzangh6UpHAC4FYPPYSTwT8HCiF1zsEf/ieQlslIBDtuMUKlBzVVrMK4hN
	FNS6mIsE58/XeotvtKyNkiZd0wnUKEonYJ9Gz1PkWzCv20uq69yU2ufv78wzK+rz
	15AoH+kL7UPI/WBN7YABML/B5rWKqNrqv2y1dRd+frnyNhUoGwwayRwTk6MKqD7Y
	JynQwXg78vsZoG/1CzRdA==
X-ME-Sender: <xms:sTeraPmQWjjt55Lu5t-pshCH9A_XPPusrJGh1PD501jChwLpu7g4RA>
    <xme:sTeraDBmpCSSkPrDkm6Jasiesjj4vAyCNj-Clqt2PLhRADMK-5CcE-6BJYa4D40KC
    fLG1oTLSP54taQ2Pw>
X-ME-Received: <xmr:sTeraHfr6EkspsY5ZxyIW3CL-nsmU1YPtsnmpRzdhj_zi29Gpx3RaVfvm8ilf6i67xnWV5fwbbEYoPYWLmlt3dolGBn0FXj3BTTRkW05>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvh
    hilhgrsehfrhgvvgdrfhhr
X-ME-Proxy: <xmx:sTeraGKpM-k46PAutUJGpTb_nUcOHyv7xAgYMQQPeDNMqzPE5ji90w>
    <xmx:sTeraCcWHXU7O0ibpLWJGnhjY_XfhSg74PGiRs5J0FyuO_Wn0gETqQ>
    <xmx:sTeraF0r0hhVju9mQ7wuVBeGMiMwZLQ3yWJGHxnC2NBqGqp2D_zGQQ>
    <xmx:sTeraDj8_7VT-iJRn_UHhlnLTU5z2ux5V4w2-XnzdM5XfCezMwnmpg>
    <xmx:sTeraCJ9LDcr-xXZ7Ppk9jU4j-TUKMn6A19-sqFeEyQ7aHyoWEcNrOA2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 12:02:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9905b3d4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 16:02:55 +0000 (UTC)
Date: Sun, 24 Aug 2025 18:02:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 11/11] builtin/history: implement "split" subcommand
Message-ID: <aKs3qu5W2eqnF1kM@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250819-b4-pks-history-builtin-v1-11-9b77c32688fe@pks.im>
 <3298210.5fSG56mABF@cayenne>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3298210.5fSG56mABF@cayenne>

On Sat, Aug 23, 2025 at 06:37:23PM +0200, Jean-Noël AVILA wrote:
> On Tuesday, 19 August 2025 12:56:07 CEST Patrick Steinhardt wrote:
> > @@ -47,6 +48,26 @@ reorder <revision> (--before=<revision>|--
> after=<revision>)::
> >  	commit. The commits must be related to one another and must be
> >  	reachable from the current `HEAD` commit.
> > 
> > +split <revision> [--message=<message>] [--] [<pathspec>...]::
> 
> missing backticks. Also the order of options and <commit> are different from 
> the general synopsis. Is this order allowed?

It is, but this usage definitely wasn't intended. Will fix.

Patrick
