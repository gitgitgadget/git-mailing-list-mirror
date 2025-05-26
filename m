Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335E1863E
	for <git@vger.kernel.org>; Mon, 26 May 2025 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748238336; cv=none; b=qLYnz8cf5B+njYa5Yp3t0sv0xF8jQEJXBcd5fO/IQ5swVk6XsoHlwRDWCJcug0pYYMNhqkRuWNmw+F4obQadOHbjE86Bb/P/azGtLETfMW2WE/1uCu//EgiIQ/9MaFErK5s3YvvPmMf43qbwAPJ2KUAsVKIToaPb1jY+9nLThIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748238336; c=relaxed/simple;
	bh=Uf6xowtWVWzZU8hGDpCSGC9s24VKiJNxU95+xtkPaFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFOuo34V1fNNxjh+mrXPfDOQWWbInXr+rs+Ku3mHThTASvRV4af/xacCNn/3I47hbrM8nu5tNKHmZKf53BSq+6B5JFaFZUhbcV+qT+6nhNkX/l0FVmZSas3FfSVIn+klzUxyohj+PFv4WZQgyxRjpZu8McrGPwLOyNAsmIS+Wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZYAiFko9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJGCvgjB; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZYAiFko9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJGCvgjB"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB2CB2540103;
	Mon, 26 May 2025 01:45:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 26 May 2025 01:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748238332; x=1748324732; bh=V4t6gOVudM
	ZqCDOPUIprqEe61oY9O5394olaHI3mJC8=; b=ZYAiFko9Q5I6Vm6EsvnxSO9Cei
	cyo6HA79o+vu5rgn/Ji5GiLHgIM+kDK8UsmyRERU2pdR1tGIy18wsoKsjj8LooKN
	OtHLMMVH4MqSDhXGfmFRU4cUMXLu9HxMn6AJT5iv7IhYSCwBCMjrLuAhLcIoBL/w
	2zOsfIP+DRxG049XT0r7DKuKGTqWFRugkF7bZQ9OTooUOBJEGmXTyQoOjD4w1lYt
	VeN8m434SZSEP4QGft+T3W7dgdTGk3rQsflDfqrJYToAcgxCxctjn5i1DDFRcj6q
	X0O3qMb9C+rNQCqMts+a4J31qHDSa81g7Q52qreWO5vzqlgOQcKm5/Z/o1Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748238332; x=1748324732; bh=V4t6gOVudMZqCDOPUIprqEe61oY9O5394ol
	aHI3mJC8=; b=nJGCvgjB2zdywpYuGgPhPv24ek4ZxbTSt+QoAzXn3oCXF84CYQ1
	bit8OTv2tfCr4Y5Le3p72vib5kTg48qCbTSumCdcCOkHFJDFJmhXLP9SRftWZHX/
	uCwhIhz3Spw1M5ebCJsF0LR9Au+ORwN9u3fJQxoJQdEbJ7Xcf0SG8ORwx2rdfPv3
	s9kaHqWpKdtWX5684dYhYyMyoZfT51o1TSsfLpHppAvQDQV01IjvzOJ0Zn0Ce5yc
	9QzQ3UszFTmAb72rUXGmph3Pj3ntsgz56Oz0mTux/FozP0h8yck9PdLCc61Pettp
	KLR3wmqHdVrmq9n9G3a54WFfKzitbatF+4w==
X-ME-Sender: <xms:_P8zaMkNFtyKF72NDzD7AQOjXH56kb3VABuogRl0ixoezoINxise4A>
    <xme:_P8zaL2QCNH5EfIFQtT75nigCxrHcYEsNzcSownxZpC-vcg_8aQhNMSvKj9WYh0Dr
    0qPVyka3DbhJfX_cQ>
X-ME-Received: <xmr:_P8zaKrGS_5t-snJlhFcJ07CL6qvOyxOxxjNQNgBPHc383mro9gFiQdMr1bwret7dg2vDdDd533vqagOHsscbIaLc48QKpBzhVred9xFJif58w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduieejvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdr
    tghomh
X-ME-Proxy: <xmx:_P8zaIm-WzDSOL1Wt_DPJomfFdlZnn1vnNnN6MoYgiODtKngbAxY-g>
    <xmx:_P8zaK36zrTe1NFa5AgqAPR9_hjNSq4_JTqliGwm8jSA1AF0bwIDEA>
    <xmx:_P8zaPvFuo8uuW6221rC4WZ3Sce-NtGQjuD5peOBN-BUaUgYkut6Qg>
    <xmx:_P8zaGVfZ6Ad1Ynqd4JlYhdkyIZY46CYCONJshh-2Cw_86uN49432g>
    <xmx:_P8zaANquwWui55BvoFXGc3MfqbwIJ98RpQlCx0qwB0FLH6wxDbNvovx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 01:45:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62bc5fc3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 05:45:30 +0000 (UTC)
Date: Mon, 26 May 2025 07:45:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 02/17] object-store: rename `object_directory` to
 `odb_alternate`
Message-ID: <aDP_-VX_Rz-MqiAS@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
 <20250514-pks-object-store-wo-the-repository-v3-2-47df1d4ead22@pks.im>
 <tjsbotrnrffykmi3letktpb3bly4nqw4wxzyrszgbln7pznem4@3kwiq4zvaebw>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tjsbotrnrffykmi3letktpb3bly4nqw4wxzyrszgbln7pznem4@3kwiq4zvaebw>

On Thu, May 22, 2025 at 05:13:55PM -0500, Justin Tobler wrote:
> On 25/05/14 07:12AM, Patrick Steinhardt wrote:
> > The `object_directory` structure is used as an access point for a single
> > object directory like ".git/objects". While the structure isn't yet
> > fully self-contained, the intent is for it to eventually contain all
> > information required to access objects in one specific location.
> > 
> > While the name "object directory" is a good fit for now, this will
> > change over time as we continue with the agenda to make pluggable object
> > databases a thing. Eventually, objects may not be accessed via any kind
> > of directory at all anymore, but they could instead be backed by any
> > kind of durable storage mechanism. While it seems quite far-fetched for
> > now, it is thinkable that eventually this might even be some form of a
> > database, for example.
> > 
> > As such, the current name of this structure will become worse over time
> > as we evolve into the direction of pluggable ODBs. Immediate next steps
> > will start to carve out proper self-contained object directories, which
> > requires us to pass in these object directories as parameters. Based on
> > our modern naming schema this means that those functions should then be
> > named after their subsystem, which means that we would start to bake the
> > current name into the codebase more and more.
> > 
> > Let's preempt this by renaming the structure to `odb_alternate` now
> > already. This name is agnostic of how exactly objects are stored while
> > still specifically pinpointing that this is about an alternate object
> > database. Furthermore, it is already used in Git to represent this
> > context -- the only stretch is that the primary object directory is now
> > the primary alternate.
> 
> I know the naming here has been discussed in other threads, but
> `odb_alternate` doesn't feel quite right to me. When I think of an
> object database alternate, I think of the additional object sources that
> may be configured for a repository.
> 
> From my understanding, the `odb_alternate` here applies to any object
> source, even the main one. Using "alternate" makes me think there is
> another object database somewhere which may be confusing in scenarios
> where there would only be one.

Yeah, I do get that. On the other hand I don't think it's too much of a
stretch: the local object directory of one repository is another repo's
alternate. Furthermore, we already do have the distinction between
"local" and "non-local" objects, which translates quite well into this
new naming schema.

> Ultimately I don't want to bikeshed too much on names, but wanted to
> voice my thoughts. As an alternative to "alternate", maybe we could do
> `object_source`? :)

If we were picking something more "generic" I'd favor `odb_backend` over
`object_source`, to be honest. But we have agreed in the previous
version of this patch series that this isn't the way to go.

So I'm not quite convinced that `object_source` is better, and if we
were to go this way I'd also rather call it `odb_source`. If others
agree that `odb_source` is better than `odb_alternate` I'm happy to
adapt. But until then I'd rather leave things as-is.

Thanks!

Patrick
