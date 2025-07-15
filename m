Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D323A275103
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568021; cv=none; b=LvsihfR6szGjV4le6QzK51VhRzWhY3XSdizklRzxcfWZxpX1ji1opzuA0UEtYtW3zqbW1GzXukH2pDrOE8vqJZab7A7tUJWHp40yR3YYt3GlLlCS3ALSrhRmYYSJm/pao55pt4xEFJCwXL3hGF4hkcWcmnxnAvosqjQriU9Vgwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568021; c=relaxed/simple;
	bh=LyIISgghvCvkBWz+jfS+cCizi6Zfs4ndjU2i46qDoLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcIGs81DGWktLopuaWFj+rbqr4XSTVZiwzeCm/yZM49jazUOSIv/xMMoMFGcjJfhv3ynj9js/bhtXqAH1kmBnHX+kxxOUz4tdjV6QYUPQ0rhHz5tDR8A+au/XgsZ5sOaji44F+K9okX8iFlCglvV02wMNBL/4c3I+sHNUheV4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=StyWnkXh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jdOM8mYG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="StyWnkXh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jdOM8mYG"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC3D814002D9;
	Tue, 15 Jul 2025 04:26:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Jul 2025 04:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752568018; x=1752654418; bh=lQDwFmlAVh
	enpb7I27mEejTRyrItwS7ccY3DnZAyw2s=; b=StyWnkXhfhc1o2TRZg9D3DoE08
	/MvKNbWqqTpodhlSVbd9oIC8fh0FgwYEUMWYnF+K+rHmLxzLtqXvQTxGkcd9XeIP
	QBXXgm9RMlGKeG3RvKaY86gh9A4kk5q+0jUStSCxFPyhv5iaUjNoMbk2LzW9Ov2C
	Y6VcoqBkbaJRbOjdDSp8tI/4EbFKkuS6rCWAVQBAXk6NmGMMxlEynsQvft3Q8AyJ
	1DdI5mDwdXwNYwubPtTVSdfqMP509R6GrFiKMEqbGpnF1aybUNcFK8qcuTSHj5UP
	HtvpXEVs8KIsejL/DZn/w3F4kz5VFF9xk/gNwRXP8I0vDJxFYciyNpewjhFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752568018; x=1752654418; bh=lQDwFmlAVhenpb7I27mEejTRyrItwS7ccY3
	DnZAyw2s=; b=jdOM8mYG0AKqwUHpi/d2wpGyV2sJhew9k0PnzkBsu30Qi9gNkO5
	9HVya3nW1kvk5PwLX/tszBUIbBdpoQHip1CcbURfvpLQF7e5ZuK/fFWbuBEl1190
	+svt+LWf1wPU8d7c3fop0pBKcQREMwWnpabnxXgzHn93eZci0X6Wfm5KuBCNE3BH
	PSAnJvCdRYcIouX8DJogHb7hmKAp7mC5LGTOn/zbGjsCSftb3trKVJiYVNrlDZyE
	BTWEi6ppzGKumTaLYWE5loJQFP3g1O60kMG0i3k7FIaKShnXkAraIsOZVMdbVHfw
	+NQzOsUxLhp9YtCPbphBwyK8TQlj0Mw1KDw==
X-ME-Sender: <xms:0hB2aGnAMpjXNWR1NDX-6DsSHme96GPSgKZsSU_n7XzDIthxwMatIw>
    <xme:0hB2aOA4jwnqm33973WWTHT68ntUJ-NdDqudwyfyWCRGl3hV8BCAxHhe6_lug_t1t
    NnkYTlcK12lXdmnxw>
X-ME-Received: <xmr:0hB2aGfAbpVDS152BlMFnLx3u4npSdliZBAL4RDU5OreEIAJzrMe5ZWkhG1Fj9kwNzFkxNPmqa_GtEVKpBw5IURUr8DYt_PB_IcaP-52tBS45g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0hB2aJLzvrvtrnQj-6FEX6DlxFFUcYjGpiAAy3TdBIjtbGTtCcdMsA>
    <xmx:0hB2aJfMUkOZYIUs6yL3dLRrCCoyFcBO1lM5X1v_T1zIn9PWkxI9Ew>
    <xmx:0hB2aA152XYo2WXTwHmVjk5LxhRhs0Ar0Kaa0uSHGljMh_9mpidvDA>
    <xmx:0hB2aCgwKI0eAfvB0OKXjMAcjan7pWEjdYBnvCpsY1vhHzeDvdWHmQ>
    <xmx:0hB2aM1ra1BkQaoS1GvIUvP0v8tqeB2keFqN04VOLobKkmwXhimQMTwb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 04:26:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b50cf04 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 08:26:57 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:26:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] midx: stop using linked list when closing MIDX
Message-ID: <aHYQzmJfSe4XZX_e@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-3-f31150d21331@pks.im>
 <lb7rv7wkpdbekciz4astmtay3u2t7os56jvxpfa5x5vx6ao4vc@jvvnav6ybqzl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lb7rv7wkpdbekciz4astmtay3u2t7os56jvxpfa5x5vx6ao4vc@jvvnav6ybqzl>

On Thu, Jul 10, 2025 at 04:31:24PM -0500, Justin Tobler wrote:
> On 25/07/09 09:54AM, Patrick Steinhardt wrote:
> > When calling `close_midx()` we not only close the multi-pack index for
> > one object source, but instead we iterate through the whole linked list
> > of MIDXs to close all of them. This linked list is about to go away in
> > favor of using the new per-source pointer to its respective MIDX.
> > 
> > Refactor the function to iterate through sources instead.
> 
> The `close_midx()` function itself is not iterating though the sources.
> Rather each of the callsites are now resposible to ensure `close_midx()`
> is called separately for each source. It might be nice to clarify this a
> bit in the message.
> 
> I also noticed that there are several other existing `close_midx()`
> callsites that we leave as-is. Each of these sites though looks like
> they don't care about globally closing all MIDXs so they should be fine.
> This might also we worth mentioning.

Indeed. I'll add a note.

Patrick
