Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187E190679
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737359899; cv=none; b=uuabfIzVX9iBRXh64MSxk02xyHt0k8lnHjxWkBlwu2ErjWWVVhrCtdCcR6UtgHoseESfEVrloCisEfZnv6/98bqKciCzTorT6/YZXAQhHPe0afkyr950rhjL7iY5wLWUo31sWSPbYli2vzEjD852ypnN9wSl8CXJ6Qk4CtmgemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737359899; c=relaxed/simple;
	bh=YK+BcmrhwTbRjMZSRT//IA8HL7L6FacYZ/tjaZvp3v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ6WQ+Sa+WbN4XqBSJXf4QaXPp/b2iklbGxLWmP4rOeO4J3H+tPg9HSU4ueZunaIyrdT3BbjPeoaCnjLdQjuEvRvkiHpiP1siNtWHBIpa4PZgsYvVN9SoMuV8jzaVCzFSUQfCnItvGAe56TzdYQbHCO5ZrtanZmjIfBaK3z9rhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WtcU67ko; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SmMZgV9O; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WtcU67ko";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SmMZgV9O"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC930254008B;
	Mon, 20 Jan 2025 02:58:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jan 2025 02:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737359896; x=1737446296; bh=2L85jjnrPL
	rMFIPnIOJSdG6mWdPKNow8cppbrmtDdE8=; b=WtcU67ko3KJxSYkdU+3pVIypvA
	M2oDyx5vb08maDcXWXgsCmuICV1S6S6Ukedo04BstyXIYGLYPi/zAZiv6T5WkYys
	mXxlJGGrE2r8WcUJypQ6Q22Yw5MhtXhfkUctERqWo9kXgUNABcqik9Y1cVPq2PP4
	cFAnVGo+0XjS5d4+82OZJnLvSa64yl5D4TPLRhmtktKXohjapWQPzamwW91mcpSh
	YqBd1JpKHnA6c9TBOx3HKnkjRAVjvr+TAUMiAq3GwnclVKQyfwYDIvh3kxRHZDK7
	0qcixb578QG8jj6geRJVXrJY8EXP2jmlk8DYBQD+xcameYSbm8rXDTnuRlmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737359896; x=1737446296; bh=2L85jjnrPLrMFIPnIOJSdG6mWdPKNow8cpp
	brmtDdE8=; b=SmMZgV9OPKmH6ToLlliOWEVwcvz19HAClFNkwugg8HFmOb46JLQ
	TFqeIyawFPJuJKsmQdZvmedAwNxLWMp6qAaDR1Sw2kAHMVAyf6KY6kp4aSZP982J
	vs6iTWJV07QJcPDidX0t83+HhLUzdPzxKapBaqtHzSwySLOXBe4Mr7RsK0afaitj
	/n1VaygKlBul8YABW5Kvv39AT16DDjn9uzChOQuqgOQq3mKTbPsjs2nsFpzaA77B
	nk3r4GPnS/f9PL0QVrl9BSLSwK/3c5eworINd4BhUTLH89Rhl7kw+lvsoH7XIw/o
	6m2gMkpPitKb2+dv4qFxD2oWJ1HlH+YM2TA==
X-ME-Sender: <xms:GAKOZ98XrdAQRUi-qQq7n2Op7NIRNsD91hLXyX5pwuQVNR3XvbaGEw>
    <xme:GAKOZxugrwjBMavU7Mw6CDt74MaxSp9OacCMG8YAxmtqrY3BYq-37kPz2sSIqJxYW
    gsynBXGxi1zMDKq-w>
X-ME-Received: <xmr:GAKOZ7DF43ZgG76hn4Oon5BO-VHeOSdjwKe29AYQGB7-TNcA4OOvAs4EVK-q5oz7R56UcMKyFMwLyf1a7Np-WtnoYWxyzXsQxYyfSn6-TN2aSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeikedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GAKOZxe4umVByZoTjWLihQGjzDHGebJdUy-kVM0U6IPkLNb1qvTzXQ>
    <xmx:GAKOZyPQXPVJCPLjMx6aOaSNVi0WVo8IQIGvTG7LOH2gJ9w-CtDgdA>
    <xmx:GAKOZzmtrpY1wRb7rKo0uE7NMCofi4VgCvstOx8Yvzh37Nj5MEb33A>
    <xmx:GAKOZ8uIKqkhorj_U5itZoeSnEkyouZigjsHyDqv45bclR3C8lunuw>
    <xmx:GAKOZ_ogAEC5cef6TuX7XPyuSLwFdGVzZ0yFuFf1mpzqjnH74yP_BIQu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 02:58:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 905d67f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 07:58:13 +0000 (UTC)
Date: Mon, 20 Jan 2025 08:58:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mike Hommey <mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] connect: address -Wsign-compare warnings
Message-ID: <Z44CDZJblkvQ_6po@pks.im>
References: <20250117074909.1430067-1-mh@glandium.org>
 <xmqqo705mjw7.fsf@gitster.g>
 <20250117211830.75prk6e2u3qlatwt@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117211830.75prk6e2u3qlatwt@glandium.org>

On Sat, Jan 18, 2025 at 06:18:30AM +0900, Mike Hommey wrote:
> On Fri, Jan 17, 2025 at 09:26:32AM -0800, Junio C Hamano wrote:
> > Mike Hommey <mh@glandium.org> writes:
> > 
> > > Most of the warnings were about loop variables being declared as ints
> > > with a condition using a size_t, whereby switching the variable to
> > > size_t fixes the warning.
> > >
> > > One other case was comparing the result of strlen to an int passed
> > > as an argument, which turns out could just as well be passed as a
> > > size_t, albeit trickling to other functions.
> > 
> > As long as the blast radius is limited (like this one, which most of
> > the cascades were within the callchain of file-scope statics), and
> > the changes of type is going in the right direction (in this case, I
> > see all are using size_t for length that may come from or compared
> > with the result of strlen(), which falls into that category), such a
> > change is very much welcomed.
> > 
> > Even if the primary objective is to squelch the -Wsign-compare and
> > even if we are talking about a line in packet_reader object, which
> > would not exceed 64k bytes and using size_t is way overkill, that
> > is.  I personally do not think -Wsign-compare cleanliness is buying
> > us all that much, compared to the amount of code churn.  But this
> > one is well within the level that I can tolerate ;-).

It does generate quite a bit of churn indeed. But it also made us look a
lot closer in many places where such warnings are generated, and we
found multiple sites already where unexpected values can cause us to do
weird stuff, including going out of bounds. So if this allows us to
detect (or even better avoid introducing) even a single out-of-bounds
read/write that can be exploited I'm happy.

I think overall it's going to be a net win in the long term as it forces
us to think more carefullly about types, which we haven't really been
doing until now. And this is a frequent observation during code reviews,
so it also gets a tiny fraction of reviewer's time back.

> Do you want me to address Patrick's comments?

I don't mind it too much, the end result would be the same anyway. Just
keep it in mind for future patch series.

Patrick
