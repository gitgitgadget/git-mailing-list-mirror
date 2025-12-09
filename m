Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C77224B0D
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765267468; cv=none; b=DIzu9VDfupLDWD0J3K3/HoG8SPQ87jjf5RGG0YGJp4LztMktCZnTMD23CBQLTYIWIzR5fw3R5CPQKyFaaU/pi26hGv2q02F4n3VYPzyr/ag64GJVkZLzo1doELpqJBH+5XuI5ry/sUJjJI81SAUbqe0EzJG4w5KXgBK/9MgKkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765267468; c=relaxed/simple;
	bh=jugPg1J45HANFoZBrcH2nTcsrPFycDYBUQ2Y5VZqmeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enjc8ZTB7Sf/xN5gRFiV+7VuibvMJizI9ZCDoUOiJeD1tTHRUYgCt6O91xF+dcKFmIQ67W5wS3L8sDDuCyMewqNQlV4CmoBzxZMa38N+yTLTdulT4tKKsod6ubDt18PFdrgSmNWhOs4EoXbAIKGI/rgHIFVlPTgPdm9sRZXYSTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jU5/8uEs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xz8bbgo5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jU5/8uEs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xz8bbgo5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 43436EC0556;
	Tue,  9 Dec 2025 03:04:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 09 Dec 2025 03:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765267465; x=1765353865; bh=SC8zqYspIM
	tcBIjLSk0HffVkfD0+1J+aRERDpk7Q7ZM=; b=jU5/8uEs1up/TYJoKcaOcFFjNa
	blN8Wq9S9k04v5csM0Gha5mEM6HG9I9SaC+Exni9wt7G7V/X+a8RJLjUJ/OyLhv9
	Y4mZUfkvjzJtm/JmU4VfR+ViYqdnCl255EYgpFjwQUWhipuzYHS56pDlpjv6qv5J
	pTekeWg9VyYUwHf9Oo5kF1Wr4TZmSqO6RXlymsUl79XuAAMOLaaiFZw1RgMUiXbU
	w1Jd4X24U8TzluzBii1Ue0h1uhe6x3BKv0Tw7elOOCrKkKm874rBVXxngal3EfNC
	LJ1KTVhJMzrxw2PnkoIeAkCdfwhTCdeu4qslkyaPmTeZRazZXK/hK5KODl0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765267465; x=1765353865; bh=SC8zqYspIMtcBIjLSk0HffVkfD0+1J+aRER
	Dpk7Q7ZM=; b=Xz8bbgo5/3zQt/1bLzETw+oh9243Qcc/SttiauoniOfdbid3nFN
	TAo7lpbcKNiAKeTaUcA9ris6ImS4ST6zDrPz+eiWV1351+5z5OnVnKNiXR1gkrBP
	KBmxJyxzYFdK+913ewV7027va4iV7p3FgvoF4nwLFZKYqvxgp769jx5gtzf3yBUU
	G7YqKES6gnwZLKXARFm4bjrtE8yzCGQ2fKsBtQMdZj/YCoIGqB5+tP0jvKIRRLId
	fHMd4wMBZnXZePHO9rGnsYW71MgZnpZPJrYgdc2xUoglx4WUIQx+l+RF6SCsZaIJ
	cVMq+PcW4oVd+2bPAvVB/xkaLRz/lD7+Xmg==
X-ME-Sender: <xms:Cdg3aSbeeOERMuuqHEpsKYrQUJw5xokjWdh3mApqH6yBzsiGfEw2Pw>
    <xme:Cdg3abZZqC9TmWhOxJzD8p8D9-grNyqUACEqan9tyyXY5d6RJVyQ_emHjtkEkwNd2
    S_w1TV6QquWqiYhSXvD6GOz-pd9T2Fil8JP2Alo84eGl8O5h30foA>
X-ME-Received: <xmr:Cdg3aamsWEemCmfSu9BeDfPnUv_Y7akMfYAp_RefOly-s_AVSL4olDU3I_JA373d1-ITun_LEh1Q9e4PB-GAwzrEBjKujurhCrvE9-VnoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Cdg3afyih-09fXRZ5BIbOPQvbEWlwR67FnUhlGbEiRzXu-Gq7zZNpQ>
    <xmx:Cdg3aQNLRbHM65Gv99SoglVeo4vTfJlEUHNRjC6ES5ctiXPGCR-kVg>
    <xmx:Cdg3abSNQRoIniV-e-LrMp_cA8Oe5e3B1460U8YZP_GZiLxXnxtWSg>
    <xmx:Cdg3aWbAvah6xvQ0E_epPLmnNl67MKxY-2sQXuOJj-sl-fIopbzqyQ>
    <xmx:Cdg3aYLLqhRPVkBtY0hwWnOYEr63HcE-swNSEq1whyIsNfVridaYDpTq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 03:04:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e517ca61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Dec 2025 08:04:23 +0000 (UTC)
Date: Tue, 9 Dec 2025 09:04:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] odb: resolve relative alternative paths when parsing
Message-ID: <aTfYBGr-0SIDinYF@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251208-b4-pks-odb-alternates-via-source-v1-2-e7ebb8b18c03@pks.im>
 <kz2eftlrmaxpxjybhjwqlewy3dx44sdznimzs6reoqtev4qtox@hl3s2gxz3sk2>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kz2eftlrmaxpxjybhjwqlewy3dx44sdznimzs6reoqtev4qtox@hl3s2gxz3sk2>

On Mon, Dec 08, 2025 at 08:09:30PM -0600, Justin Tobler wrote:
> On 25/12/08 09:04AM, Patrick Steinhardt wrote:
> > Parsing alternates and resolving potential relative paths is currently
> > handled in two separate steps. This has the effect that the logic to
> > retrieve alternates is not entirely self-contained. We want it to be
> > just that though so that we can eventually move the logic to list
> > alternates into the `struct odb_source`.
> 
> Naive question: is the intent here to eventually move alternate ODB
> sources under the primary ODB source? Or just to record the alternate
> dir info in the ODB source?

Not only the primary ODB source, but into ODB sources in general as
alternates are recursive by nature.

The problem I am trying to solve is that ODB sources may not even have a
filesystem-local directory, but the way we use alternates recursively
very much assumes they do. I don't want to treat "files" sources
specially though and only recursively add their alternates. Instead, I
want to move the logic of enumerating alternates into the source so that
every source can have a different way of enumerating them that may or
may not use the filesystem.

> > Move the logic to resolve relative alternative paths into
> > `parse_alternates()`. Besides bringing us a step closer towards the
> > above goal, it also neatly separates concerns of generating the list of
> > alternatives and linking them into the object database.
> > 
> > Note that we ignore any errors when the relative path cannot be
> > resolved. This isn't really a change in behaviour though: if the path
> > cannot be resolved to a directory then `alt_odb_usable()` still knows to
> > bail out.
> > 
> > While at it, rename the function to `odb_add_source()` to more clearly
> > indicate what its intent is and to align it with modern terminology.
> 
> Alternates are indeed just additional ODB sources appended to the
> sources list. IIUC though, doesn't this function only add alternate
> sources? If so, maybe it would be better to use
> `odb_add_alternate_source()`?

Hm, yeah, I think you're right. We still have the recursive nature at
the end of this series, so let's call it accordingly.

Patrick
