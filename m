Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61951A3168
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542941; cv=none; b=eQ1XgrYor8sL/4EcezjoMNv9x5sxTSGSbK4+i/4l5/a2Q4aSgQ/WkcHQT0x+YrjAC7XP/ZYUwXz5S8GYXQt5oCNBIlDpgGeJRw1yVr4f9iPiRxqJyc9muUSso6qzupW4hwBMeb45LNpuTqgJPWGOrTKDycYtDSc8ud2CbpPg5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542941; c=relaxed/simple;
	bh=Tudvfx+kNDRsu/WyH/tk3Tppup7fL/QYiBUnqcwvrQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVbZxJRNXPWCkuB2ohd2smp40zTOChEBvSBvyCKPzshP/BUDsgnqiCJxNf8Ky5epqckQ7VqsUNPGPrUh+6LGGNqDnNoXXzf0BSlRc+fhfwbxaxJ1pEFw9l4qLfq43IW6h2+plrXbLWa/4olhA07rkgs3l1btofX3wiQyqK7RxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mjwWMUAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwxDvWnS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mjwWMUAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwxDvWnS"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C57E67A0178;
	Thu,  3 Jul 2025 07:42:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 03 Jul 2025 07:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751542938; x=1751629338; bh=vZXpMtf+vH
	VuqYUwE8xP/oEXT3O2s96TUJ2Euqg3A78=; b=mjwWMUAHCgrD8KRRHDusJM4S1i
	lWGj5q50vGjvR22FYyjsda19dJOVdXA8kYPCX7XgbDkspZ4e3+ItHeD/rgjRyaPz
	TNw5YZy3WxMly7YP2SgX+XxbgqN3962RAv9vRo4PvbnmuSEPRrmN2TJBArQwZMQ8
	0BiaYkeIA8QOcicKBzQ1tJKBSOnYsiAv3FTbXNFGWOi8ClCo3kJ/4gtn05HTfHdR
	kXjsyO3uetxSs4IsEriuwujYwdpXAndrOQsBnglyKMWmotWDMLXbpa5Z1YFiCDzY
	D3dokqgssrs0IDFCzY/vmHSrGqn0I0YU+7XXI6nvFWsFwX3VdHjNIYvX9qIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751542938; x=1751629338; bh=vZXpMtf+vHVuqYUwE8xP/oEXT3O2s96TUJ2
	Euqg3A78=; b=gwxDvWnS3VT1smWUcUZJ+Z6MkKp+eddr/+t8PlYkiX/VweF+p9+
	1f7lBAqmQ6skDGa368o2TE/k7egbN1AHh/HE19BIBHgJB5H3PanD8/NRbfX5pGhP
	W6eg0UYGuajcXUq99VCAS7mhiJBA4vxmBwd22eOPcqWJ9vLy6jsU6WVja7RBF/Hu
	7wXlUl1YLmill5nA7s/rNc8bdoYcjJgWhxCgdxUVlLaIODwlW+wInXUUBp84AU8h
	JFPXcGHW0EioOYoA/8O55bHE0AjEbL/nPTdOIUI1Vur+UqO2yapCQTG/zBfCE2jr
	vF8Os1kDucOdwQuz2cJy4Ly0uQdh8opGxng==
X-ME-Sender: <xms:mmxmaBR9dJYitfo57Yz1DAiUgriYDYBmuNNMfVitSesJaTKKTM8y1Q>
    <xme:mmxmaKxVX6YWHTcTd6yF9zXljg0JqCORCVonK-8uWJAB_OxCQXPTCC7nKJySygZIu
    mFoEn5_R6xNDZnjnA>
X-ME-Received: <xmr:mmxmaG1agJea_-RES4RNB2LUAQIo_ob8UQ0AKDpdXHJDaf0x9AmLfQ-UPEyg5iEvi7SjyFpq7lQ3lONrWs-lGoPnah_mSpwewvAhYJvdUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehrhigvnhhushesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mmxmaJDaQ_pJFhzj5uoqwvLUSqdaWTtywPwBOqnVDWJh6wYujRyPnw>
    <xmx:mmxmaKgzRR6yUK46mKWkqSd1u2Ic2kjAt3y5wt3EPiscRKHejQY8xQ>
    <xmx:mmxmaNqKpt-PdXPsIGUjNfQi-5uzK94fY37VQPfTprTKdWWOk74FZg>
    <xmx:mmxmaFiMPlrejvzENn21vYOyOwoKGGWzSXV0z9Py6Q-Y6z-1wLc3DA>
    <xmx:mmxmaA__rU952xt_aUMAxLyfmrYqpvMOwRKrwWvBmBhm_DSBg2J-lB35>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 07:42:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 729da958 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 11:42:15 +0000 (UTC)
Date: Thu, 3 Jul 2025 13:42:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/2] BreakingChanges: announce switch to "reftable"
 format
Message-ID: <aGZslJSks2GF3uB7@pks.im>
References: <20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im>
 <20250703-pks-reftable-default-backend-v2-1-5a27e72a8c5e@pks.im>
 <CAOLa=ZTJOqqr25Sj0YSAc9rDmar2qZiVD3H+K6qhdN3qKdqbGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTJOqqr25Sj0YSAc9rDmar2qZiVD3H+K6qhdN3qKdqbGw@mail.gmail.com>

On Thu, Jul 03, 2025 at 12:54:24PM +0200, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/setup.c b/setup.c
> > index f93bd6a24a5..f0c06c655a9 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -2541,6 +2541,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
> >  			repo_fmt->ref_storage_format = ref_format;
> >  	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
> >  		repo_fmt->ref_storage_format = cfg.ref_format;
> > +	} else {
> > +		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
> >  	}
> >  	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
> >  }
> 
> Shouldn't this change be instead made to REPOSITORY_FORMAT_INIT?

It made me a bit uneasy to change `REPOSITORY_FORMAT_INIT` as it is used
in several places. So I opted for the more contained change.

In any case, I found the logic to be hard to follow anyway as it is not
immediately clear where the default value actually comes from without
the `else` branch. So I consider it a good change regardless. In fact, I
would argue we could go even further and change `REPOSITORY_FORMAT_INIT`
to be set to `_UNKNOWN`. Same for the hash.

Patrick
