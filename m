Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D32C0285
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731302; cv=none; b=RJvf/BGVt0jEpT3tj+zm1ELe2/IbnW6vl3sS9hzW0L1/eAapI9irbV+qHDLGbRdOj0MtllL0E4x18uS6MK5rbA4VpLw8WJhmDKcvIoQTWz8Ng3Ivx8UKCJgsfEZVzYj+U88ufBql/HLsfq9J978PdeItMfIzZaHV59RaTqO+7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731302; c=relaxed/simple;
	bh=lIGeP3s2eEpzxnmUZeZJMlKVvts3hC6eZYBPd/e08ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brCz83ubxy79xesEnY3vI0lIu1cCy52soChg+QeZo7yWC0/rtlSlVz0nkguZ4aPL3uWz+PEwh9fF4aidyOr8y4FHWiAR2W/VxWiHFpNcHQVr/pxqOEnIOPFrhqtqlqpWpG32MLUFsCXkcwpo1xTU/JTX+pf/NP9PZvND03Do+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DLG/IS7l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oPQiDM8Q; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DLG/IS7l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oPQiDM8Q"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6CD981400303;
	Thu,  9 Apr 2026 06:41:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 06:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775731299; x=1775817699; bh=M4V6NNQhh7
	oaAIgLRfJW1Ka+X+XpCTfXGNrbqC8lNII=; b=DLG/IS7l/NS5/UZv3RwO5U/fLm
	N0ndxxlFO0gvqMmTOOMHmdXj+VPNrJxek/pRrM+ZqBXcArQGe5Y0RxmJIro8ivZp
	Dq6PqtbgaL1crhuSZQ8RjZLiGFBmYiC9TRmFCzfq1mUEaehigoBCKcwffuQ5Qn+O
	XQpB29ST5GHh19Z/zlS2qaYYPF3Y1dabbbNh9Ook/7j6qAR6ZxuvqGYuFJ61wN9P
	ICrSsY68IFJEvWuA8Alus7mGXR7aGeciHw1RkJSk0UiejKTEuPP/8LyecMuLbNs+
	7niKFE4+vPmJaj9OXEUjVM4SxQdg2P/jCRYzDp0l8zybkQ0I3zPk4Sgdu1fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775731299; x=1775817699; bh=M4V6NNQhh7oaAIgLRfJW1Ka+X+XpCTfXGNr
	bqC8lNII=; b=oPQiDM8QSjiDFD8NmnYifuz+ZT8ZiFAyW64XMNbpKAIyFcTb0zC
	FrUxEmGJlwCfKb2bqPSTnSt4FfVAlPaBtoMuLo4V7Ldo+rkW2vqpDjXHhIPlX7IR
	Y0xE7CZGXv9Vim2Wsnc5acNWtMj3NNS/Dspd8fRsv4TvhNIu0fNMxHWTI0qPpqfA
	BLz2zl9CDLxWKH72grFTBUKY9irEy8URp+4HGqCyYbeRtiF0fE8+ndNHzGZBCfcz
	/HbkvOCzpjJ3Ak9ilmouy3MDuuy9xYRxue0oVRxd5eRKfEpHT89Yi2VC10rIHlCh
	3JoAKWLSSOocFSXSQNBfZHDnKX4RTO2zRdg==
X-ME-Sender: <xms:Y4LXaVhIWepVFF6WS5ZTgRxwcK92BGXDeooa0SsKKpyl9rOSLpxnGQ>
    <xme:Y4LXaRCeUWPq-FkxpoVYZ71XdHJyucTcUMHQc_4ljwtpFTiBVVU3eVKbjrWvizUK2
    t62svSgDTKPYUppuuXl7EkWtxYK3Ee1osbDP4rOVwQ-Cj-kxMjHMQ>
X-ME-Received: <xmr:Y4LXaaG6bKJv54i0rvZVVbnd4VwPzEq4nVSzgUVswvo7RfOmp6i4m_fz0BduZK0e4syIj7fZ50hH4cGXLEa50T4OV6ziBVfJO7YR3Gxn958>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddviedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Y4LXaZIqhFtYyJk_YZ07JyxFjgO_yGkSHNVTYk-xmlwgrO5y_cIW5g>
    <xmx:Y4LXaemBXj1SzC0lCrKXU4dI7L05jEIifQJmvndBeNF0r-HNpueEGA>
    <xmx:Y4LXaRT0VikSQZvQMEIO8P6VXw04xOrUQz0mPUUOXPgWnfCWMU-Htg>
    <xmx:Y4LXaQL4qpv2Es5Q4V8hZBLzWJa50k0qM0Tlxj04C-gHzdn97FfQoQ>
    <xmx:Y4LXaRkUBn3e65dJCHh6YjNNv-qsKKVlId-vDC0AdIp3kNgzxXTu2s5L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 06:41:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b3d533a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 10:41:36 +0000 (UTC)
Date: Thu, 9 Apr 2026 12:41:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 01/17] odb: introduce "in-memory" source
Message-ID: <adeCXRAWvho7Qqaz@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
 <20260409-b4-pks-odb-source-inmemory-v2-1-f02b4f1c0f13@pks.im>
 <CAOLa=ZRkctXNkpTqiTSTkvskajPZTid9WTG3fKr0YV641_5qrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRkctXNkpTqiTSTkvskajPZTid9WTG3fKr0YV641_5qrw@mail.gmail.com>

On Thu, Apr 09, 2026 at 05:26:50AM -0400, Karthik Nayak wrote:
> > diff --git a/odb/source-inmemory.h b/odb/source-inmemory.h
> > new file mode 100644
> > index 0000000000..95477bf36d
> > --- /dev/null
> > +++ b/odb/source-inmemory.h
> > @@ -0,0 +1,35 @@
> > +#ifndef ODB_SOURCE_INMEMORY_H
> > +#define ODB_SOURCE_INMEMORY_H
> > +
> > +#include "odb/source.h"
> > +
> > +struct cached_object_entry;
> > +
> > +/*
> > + * An inmemory source that you can write objects to that shall be made
> > + * available for reading, but that shouldn't ever be persisted to disk. Note
> > + * that any objects written to this source will be stored in memory, so the
> > + * number of objects you can store is limited by available system memory.
> > + */
> > +struct odb_source_inmemory {
> > +	struct odb_source base;
> > +
> > +	struct cached_object_entry *objects;
> > +	size_t objects_nr, objects_alloc;
> > +};
> > +
> > +/* Create a new in-memory object database source. */
> > +struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb);
> > +
> > +/*
> > + * Cast the given object database source to the inmemory backend. This will
> > + * cause a BUG in case the source doesn't use this backend.
> > + */
> > +static inline struct odb_source_inmemory *odb_source_inmemory_downcast(struct odb_source *source)
> > +{
> > +	if (source->type != ODB_SOURCE_INMEMORY)
> > +		BUG("trying to downcast source of type '%d' to inmemory", source->type);
> > +	return container_of(source, struct odb_source_inmemory, base);
> > +}
> > +
> 
> Interesting, in the refs namespace the downcast functions are added to
> the source file (.c). This works too, is there any reason though?

By having it static inline over here we can basically ensure that the
compiler can inline this call everywhere. I doubt that it really matters
in the end, but I guess it doesn't hurt, either.

Patrick
