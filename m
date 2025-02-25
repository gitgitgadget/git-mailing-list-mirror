Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF58825A34D
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469197; cv=none; b=aS6OJG4D4LGP/CFoZzHltHxy8ZihObgNRA4fiO0z1SuXFbwg0l3fco2wFimxkBfo0bfJg3NpFaIwGXCtrv+WaaBPhsS/+Ghv3fZqGwbGEAe5yMNElEPOj94MBImQvndK6HfsRrBZCrPK3eHAQm+LiQK2gpB0Sln7aBHR/OkQqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469197; c=relaxed/simple;
	bh=y6Q8IlsokhCjvIvr2NRUpi2M2RwB7+EB9xcCx0hgm1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZLKAqqsWunFpb8rbAiLadeUlQjgjZciCx3S7CKhYI7TMaavkbzFdBnKQoHR9YhZnHgGXNNw1Id3cvs06a/GMXHQwEeJdnM7+dz11/tdMP8Mtjw1v6fmPLQWwWzdLbITH6BjsRPZkpqwjOc7RRmt9Af4Be2ntFlIn+L1u/brqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JLxLlbii; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FzmGNTNh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JLxLlbii";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FzmGNTNh"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BBDC225400B8;
	Tue, 25 Feb 2025 02:39:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 25 Feb 2025 02:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740469194; x=1740555594; bh=R52VnMyIuN
	w14dOS9I26g4WtDI+xoxWLn4LNtpvZ4PY=; b=JLxLlbiiE4o3Qnhg3L36EF8Oei
	Fnct0GlAUUgNnQJS2xK4ajzC2ytCkUFtzQ3fUHXAG2d2eTPxgbJ5gF7xYimmEHSj
	18lp+eQRT4T9ahLRF5RYcMLckTrkaR0iCwW2I8qlXzIVcvr7u7v8Vyt9VZ2SkB/Y
	TNOF2txqGXhU8le0tyzV4PcZELGa/YfbJmNHb/KcWQ2KBoIzxmS27o8O5z5gxFb6
	SQ9m8hSTOtxbsrNYYpv8xcUf26rZp0yPj7ZUzuz+roKRXykcvb9UQqEocxD+GwSC
	BaA7AKsMyxmWyRXoOO3WaDMmdZs9IpF9YQZ1YDqFSvh+hQQyLoBTTRDKGQVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740469194; x=1740555594; bh=R52VnMyIuNw14dOS9I26g4WtDI+xoxWLn4L
	NtpvZ4PY=; b=FzmGNTNh6qolMmshuQ4TdAAX50FEQUCCwtznClNiEHL9WF9OYbN
	pe8/KgahbDtKDfCcudYPC48x+HPA42IrVPfsH2ro0RPGer9EZCWq0uNercVwhQYP
	gE01pia0q7y2w55WmtSTce8ZFQ/++UaqbvpsCHODkMvJgnZ7ay8KWBIQxbuGHwQs
	8IDwK9ldgVGeBFQf2vAKbtJjPqtllVv9B5hNW1Fmi1NEFQ3S4QMOC4R7Zx/0HwwZ
	pcIdxElJDXmJlhwTJSMahh+GPSmWcmMIWAwx2fmwsIGsDEscQ9tSNm6vj5ocTrBv
	fjSP3V5j4KW+ZD0snL+397p5SwJQUeLorDQ==
X-ME-Sender: <xms:ynO9ZxbKKdT3ZDEaht3JEARkTtoEs5Z3Szmc9VRSnEgtQdXpy8Y00g>
    <xme:ynO9Z4brmIk-rN9Vf61l-J3amA-EpLkU9CEG-rxp5nCDw9hbaPneGhqHq66PnT1KE
    jzNFkV5Fs1jqTnuRg>
X-ME-Received: <xmr:ynO9Zz8En0QAJvCfPzl7YyvpDDd11CTCy0xDYyr7Cp24Qm3PhH11SvbssFucBNaQ23Z501Dwpf-sQwrtTvobRA3zoaNu2GAvnqqyadwPC2UUNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ynO9Z_rUfOaZ96pz0hganzXDbnOpktVepgNS-qkVNm94z2ryEh5YEA>
    <xmx:ynO9Z8oOO6kJmPExK05CDLEBFH-q0oomMHy_01vYygPTJFr6k05Zpg>
    <xmx:ynO9Z1RkjWzN7N4M_RDQF0Ex-vrMNYCHfo5WQmh6-T8-8kZUv3MbqQ>
    <xmx:ynO9Z0rBZAjNTBnqlWUCqAxzYQGFHYamCD5XmL7arEVRfBU7-yr-dQ>
    <xmx:ynO9Z0JjzAyCZjMHTTqK9men3XHmimdGHZtr3QoU-8Ai-SmTGNPUrEtv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 02:39:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9c745eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 07:39:52 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:39:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 13/16] refs/iterator: implement seeking for ref-cache
 iterators
Message-ID: <Z71zxwWA3VzM82Gr@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-13-e696e7220b22@pks.im>
 <Z7yG6q44rBccInPt@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yG6q44rBccInPt@ArchLinux>

On Mon, Feb 24, 2025 at 10:49:14PM +0800, shejialuo wrote:
> On Wed, Feb 19, 2025 at 02:23:40PM +0100, Patrick Steinhardt wrote:
> > diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> > index 6457e02c1ea..b54547d71ee 100644
> > --- a/refs/ref-cache.c
> > +++ b/refs/ref-cache.c
> > @@ -362,9 +362,7 @@ struct cache_ref_iterator {
> >  	struct ref_iterator base;
> >  
> >  	/*
> > -	 * The number of levels currently on the stack. This is always
> > -	 * at least 1, because when it becomes zero the iteration is
> > -	 * ended and this struct is freed.
> > +	 * The number of levels currently on the stack.
> >  	 */
> 
> So, this value could be zero? We want to use this to optimize because
> that we don't return the empty ref iterator any more.

Now it can, yes. Before it couldn't as we returned an empty iterator in
that case, but we cannot do anymore because you cannot re-seek an empty
iterator.

> > @@ -444,6 +448,40 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >  	}
> >  }
> >  
> > +static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
> > +				   const char *prefix)
> > +{
> > +	struct cache_ref_iterator *iter =
> > +		(struct cache_ref_iterator *)ref_iterator;
> > +	struct ref_dir *dir;
> > +
> > +	dir = get_ref_dir(iter->cache->root);
> > +	if (prefix && *prefix)
> > +		dir = find_containing_dir(dir, prefix);
> > +
> > +	if (dir) {
> > +		struct cache_ref_iterator_level *level;
> > +
> > +		if (iter->prime_dir)
> > +			prime_ref_dir(dir, prefix);
> > +		iter->levels_nr = 1;
> > +		level = &iter->levels[0];
> > +		level->index = -1;
> > +		level->dir = dir;
> > +
> > +		if (prefix && *prefix) {
> > +			iter->prefix = xstrdup(prefix);
> 
> Should we free the original `iter->prefix` before we assign the new
> `prefix`? I have seen this pattern in previous patch. If the caller
> calls this function multiple times, there would be memory leak.

Oh, good catch, yes.

> > +			level->prefix_state = PREFIX_WITHIN_DIR;
> > +		} else {
> > +			level->prefix_state = PREFIX_CONTAINS_DIR;
> > +		}
> > +	} else {
> > +		iter->levels_nr = 0;
> > +	}
> 
> When we cannot find the dir, we set the `iter->levels_nr = 0`. Could we
> first check
> 
>     if (!dir) {
> 	iter->levels_nr = 0;
> 	return 0;
>     }
> 
> And thus we could avoid indentation. However, it seems that we always
> return 0. So, maybe we should not change.

Good idea.

Patrick
