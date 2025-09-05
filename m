Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044920DD42
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053117; cv=none; b=KEuhXhDU2XVwxXLnwc/1jtUKCnYOADqPsZzDWQsnpo7PGZiM/QsIGLU8qE7WXx7FZclUa2jwdaiA6/msS5qgV61VWQjxqsvoOZVJYY2p3TYOvRESAP5kLq/m+4lTwh3HHt0USszkG8Ff6lmogCLPqvLTe6rsb+Fb2kl6Zpt6Lm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053117; c=relaxed/simple;
	bh=J9OSCVoR44yWEUZnB/xmdwuG/gmdWwK+1LwfaOVH0mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIl2voBuIfytPQxmflxjcctBbt3o5HXJs1Lmqpvq/nDpTT0v6WZGaVEderMZ3vUnTB6VvJ3SLpKB5fL92uDS6c6dJVvLEwMjG8RGdJDFxXjunXcDUPgd4w0e1Ozc+uEHg65P/O2F0CSQ2VZ3C4YteEEK12dnXYDRCvAiieR5Ev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XBkPivOm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GvbM8QmK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XBkPivOm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GvbM8QmK"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 364977A045D;
	Fri,  5 Sep 2025 02:18:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 05 Sep 2025 02:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757053115; x=1757139515; bh=Fq36AOlipd
	ZhCcegINbz6CPlobzjSr4DVg0riUDZVos=; b=XBkPivOmnvjdIqi/fsJjiboO4O
	S1YJsvy0/oYkHqcK/OofN08css+jLj4xuWATCXLLgcTtxxdOqZlCB3shkHbTn4Kw
	RSiAHB/yKaM8vMfWbTRoIKLsz/5Z+WP4QvqQfJzMmWqS/1V8ALjsSA0cC3/0khvy
	XHZWI7pwqre5gUP2a01MeSxNonXDZqzcY8qFVNnMgTm8uaMsJHL6c6Y4yqKI9QH0
	aHka2Vs2f2FqJcVOVhK2Bi70pyr+Yy5J6YYYmn+iS37iKI4dRIpzylhoUxadlcVW
	q1Zi11FjmQGfEe3WK+bTDEhQL5S/P/n+h4HL4FT19T9pR8DXQTNBjlq2Dctw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757053115; x=1757139515; bh=Fq36AOlipdZhCcegINbz6CPlobzjSr4DVg0
	riUDZVos=; b=GvbM8QmKoPzov0Bxpy6BtygfTstkhZ3Q7NFRKhuKffb57MoHgga
	NxH69uWemaGoFu7IGOxXpIUeHVO7RyLokBEwdJtN73z7T+JfQXrxDG1eKMfxa9mN
	ZOvZWPLgFjUp6qQ6MO2szJ3vmPO4Dq72200vJU9KXYUCERHSUYR9tWBl6lcXPllA
	FuE7ib7CuvHRmKubk7r5KhZx+/O1eCWymhfjJJIaUru8tUrdQCUnmgP9+BepyNW7
	CvlNaUDe33JLt0o/pskTWIlssF8envTlLcXwQcyk9lHz7sosBK/ZNcGPK4OZhzZc
	MKvtXyXKZTA/alecAPKDcTYCG+6zUHJqZvA==
X-ME-Sender: <xms:uoC6aFmsSBzTpttQ3CZHcS7kf0R7d0O8pBS5u5ihKb5MDbFGExGWvw>
    <xme:uoC6aBBOHprXxHNiBrtCjz16CdehyaaRrTKZ9Vqmru9lqCiQd3eJxqYZ6zGwBqiCC
    9JC2queEVW7PCE4bw>
X-ME-Received: <xmr:uoC6aNflo9eor1eR_gHkl9spRs53242WWUg5Y4aahyjzn_QS5KRrwVW10yj1wstRGPYcCV32aaDeU8irSdEzfsnCXkUYYe4cStDMsAxBcvvR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgf
    eugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uoC6aEKEQk_ZDMCJALqPQafn2FIjJ6oKiWFoaDyo72_HJ0fZsUk1Eg>
    <xmx:uoC6aIeHlUgmeBOi9vyGz-z4Ovvlznw5OkiS4HwADEacqlHDVMF62A>
    <xmx:uoC6aD2xdh2mWapeT9CuFbSHAlmPU1_h7-tgVkqPDbOtsNmPOW4xSA>
    <xmx:uoC6aJg81CqQVJxm2jqPhlatBJISF1944KhQ7WU1aQnBOia8bor12g>
    <xmx:u4C6aILIK8TW5i9K0dypqmGv5cbertt1CWVNgnqE6wKGzTWwcOMVKEpi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 02:18:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fbceb49b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 06:18:33 +0000 (UTC)
Date: Fri, 5 Sep 2025 08:18:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
Message-ID: <aLqAtVW667nZI5JG@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <xmqq1pol7q8i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pol7q8i.fsf@gitster.g>

On Thu, Sep 04, 2025 at 04:27:41PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --cc commit-graph.c
> > index 9929c1ed87,2f20f66cfd..0000000000
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@@ -823,7 -812,12 +823,11 @@@ int corrected_commit_dates_enabled(stru
> >   
> >   struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
> >   {
> >  -	struct commit_graph *g;
> >  +	struct commit_graph *g = prepare_commit_graph(r);
> > + 
> >  -	if (!prepare_commit_graph(r))
> > ++	if (!g)
> > + 	       return NULL;
> > + 
> 
> The while (g) loop will be entirely skipped when g==NULL, and then
> the function returns NULL after iterating the loop, so there is not
> much reason to have these three lines for early-return, no?

Ah, true. That's even better.

Patrick
