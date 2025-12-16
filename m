Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE5330DECE
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874179; cv=none; b=i/FdlMhup0STzlyeOw1HKd8//HnBbQLh61r3QMbQchLsaYOcuKPRcij/MT62Uc7Z4eHgiqY7E/8NC3TOmPCKVWG6eb7RNtrgrJH7tHg4fEEhxhBDk6s3Vi6LjyAoxnMMdWnA5ZCQFU//gt73XIDvbmrP+FHYiwcv0WcFzT1hBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874179; c=relaxed/simple;
	bh=elin9z1Le7wamLpCh1x+0dOeroJdWj1kb4Kdhxlytqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmaR3ryPynKRsx7nBAuUFfTvQVuzBGF1scuoQk8UiBr84ZAuxcNI6BMUHR7YOfECqkciFXIiNC9lAUCpV60i8AXYwO9ADoZdtDVJs8iSaxXMw7zIbOds6K1GgS9Tb5hV38j8sFJL4fNEO3VUl2BlVftIC0giAh8z0LlphwX+XBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f1uBogvU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=on8dr56U; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f1uBogvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="on8dr56U"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D3DD17A0079;
	Tue, 16 Dec 2025 03:36:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 16 Dec 2025 03:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765874170; x=1765960570; bh=Rl9udPostt
	0isEL/mTMGbC0AnDx3rkO7B3dwnAiM+k8=; b=f1uBogvUlVZfnqRh5YiFM+6XDi
	3+2WOpDXqvdkH0gpO/j0R7YzccwKqT32gBwTM6vWa6pr9V/bsoYjTQVrIkKY5PUR
	esadMQG563Shxv+XZtOSO22QyPKkuA+l1eDX77thEnUE/v5IEWFaG6JZ4bHOsUcm
	Uj1gg5ZyoretRUpbFlb9P73HsJMBPbi40jEzZdx1yt/nLZgcUUtl/m8q5zUr7yYZ
	P5MLCh2mvRw9/Kp1OUS70ehDyeIn5DlQOqjZ+WzqEysfF3tOAfc+R2WxgzjlXCK8
	bt7pL9aG3736PFjuQH7IezIsk/Vr1YdO3HKmU4lhbVKxBw0Z5Yw5uVn1SYug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765874170; x=1765960570; bh=Rl9udPostt0isEL/mTMGbC0AnDx3rkO7B3d
	wnAiM+k8=; b=on8dr56UoAO/iVz4rqwAnI/5/k6x6Jj7P44RjybZpRjV+gxl+2b
	PHGKf6ANkc+jLtIscGxhPaU91d34IQJKUKYZdMYdkLwxo3WCOngwywCnwfwYU4UR
	T8yXRUk3AY6+Ci7t/HLT7F3PwVMi8O9/aEANT1TlsW0r/PC05RzMwMZE4viXMAMX
	PY53d7OpS0lX7iJ+p6N1PVaqSXUh5Lj/0TSU+3jnTmOwZeO8R1VkxtC1l0sQkJwm
	XfvOpiVoe1xx6DFF//T1mVo0yX0l7E7NybKFVwuEv3dZlvR2hNZOa6qvgxDuDSca
	JsM/d0SEVWMQv0UAEXWC6Ad3NQwa28ONlQw==
X-ME-Sender: <xms:-hlBabZpO5hP_tjQAO21IzTH9815MoxXYu57NI_tGbX_B50HTNAUQg>
    <xme:-hlBaQYmoVI24H1x4n6_BpP06XJS41AVn2aUYLayq3LBPj_cyAifsfO6dWVa60hTY
    QiKll28r77aEDeps6xiiLyAypwr3enxB5z7e2xdzmDlvJ0jFSz7>
X-ME-Received: <xmr:-hlBabmKl2xp7QF4gKCPgmuS-W5q0zTLwQXBkdBW2SczdrJhPES3ilLIOcmdJQh3hl40yEZiwfG9R-ARwcvjHmyc7yWQbZaXg-_j3QsEIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:-hlBacyPjtut0HDOTV6CZF9YRuG3pqZQMz1E1_RzwwhoZC6FZuiPQg>
    <xmx:-hlBaZP_uvIaAISdK1VJbn6ThUewiAoJpnhyP740wRNnsaJS2gI0Tg>
    <xmx:-hlBaQTPWA5LUvc2LAw7n1ipPtoCTutl254Sics13BGYdtrH0Tq2tw>
    <xmx:-hlBaXZvEhEFQDQdGcImO5Yrdw1oVPs_VYHP-sOO_eRn12kFie4y9w>
    <xmx:-hlBaRKQDzwE8K-8FI8-wBIodA7N78qbbBFyw7DvEBY376V--8JqeJ4V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 03:36:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06142c6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 08:36:08 +0000 (UTC)
Date: Tue, 16 Dec 2025 09:36:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] packfile: create store via its owning source
Message-ID: <aUEZ9RvivPRCjIQ_@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20251215-b4-pks-pack-store-via-source-v1-1-433aac465295@pks.im>
 <7rbnw67kn3xe3mpkpssiy22ewvjihzteole3sjhosocqo4sr7a@cig7o2dauljd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7rbnw67kn3xe3mpkpssiy22ewvjihzteole3sjhosocqo4sr7a@cig7o2dauljd>

On Mon, Dec 15, 2025 at 03:30:44PM -0600, Justin Tobler wrote:
> On 25/12/15 08:36AM, Patrick Steinhardt wrote:
> > diff --git a/packfile.c b/packfile.c
> > index c88bd92619..0a05a10daa 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -876,7 +876,7 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
> >  
> >  	p = strmap_get(&store->packs_by_path, key.buf);
> >  	if (!p) {
> > -		p = add_packed_git(store->odb->repo, idx_path,
> > +		p = add_packed_git(store->source->odb->repo, idx_path,
> >  				   strlen(idx_path), local);
> >  		if (p)
> >  			packfile_store_add_pack(store, p);
> > @@ -1068,8 +1068,8 @@ void packfile_store_prepare(struct packfile_store *store)
> >  	if (store->initialized)
> >  		return;
> >  
> > -	odb_prepare_alternates(store->odb);
> > -	for (source = store->odb->sources; source; source = source->next) {
> > +	odb_prepare_alternates(store->source->odb);
> > +	for (source = store->source->odb->sources; source; source = source->next) {
> 
> huh so IIUC, even though there is a packfile store per ODB source, we
> will add the alternate sources to the same packfile store? 

Not quite -- what we're doing here is that whenever we prepare a
packfile source, we'll implicitly also prepare all the other packfile
sources part of the same ODB. They will still be separate packfile
sources, but regardless of that this logic is of course still quite
flawed.

> This is feels very awkward, but is maybe part of the "weird in-between
> state" you mentioned in the commit message.

It very much is, yes. It gets cleaned up at a later point in this patch
series, but I'm not a huge fan of this intermediate step where we are in
this in-between state. I have been pondering over it for quite a while
though and wasn't able to figure out a better way to structure the
series to avoid this :/

Patrick
