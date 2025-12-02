Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB5221FD0
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663525; cv=none; b=F6PKqvD7nC5Bi3BpY0hefpxKyForQNmdIDOfeN24Tu4Ax/jz/Q/+c0i4aNg8nknpkxxm09pi+1ZLEecEFLjcvkP1unnCwk+33yd71G5sETh2O7MrsLH/W69YwX4e6+bpyLkAT1QRzyNAN+nYGJtZhqEYlbBy3AlNjehCZk/XBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663525; c=relaxed/simple;
	bh=KV4IUIB7hUsXyyF7y+yLXuHJP5Keg6YI2fRCi3bpq10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgiUTPKXoDfDkc74ffD41SQ3V6c3gqYONqbihyhf3L5dpATJJLewiYBaTOnjl4BoAn7W4xsrYBtf0rSJ568ne/kZcgGYiSEqmwoGgfFCAvtKY0VFLYXaPjvgumJUHj9A13Oj+uya0j9GtMmz30CsHqu6hte6cqp2NnVBBq6udrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VGB3NDyI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=twS7CMzE; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VGB3NDyI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="twS7CMzE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A00D87A0199;
	Tue,  2 Dec 2025 03:18:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 02 Dec 2025 03:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764663522; x=1764749922; bh=nsr0qfn3LB
	wmYbuVyglatgNTfJAK3WTy3VLwY9WQ+jM=; b=VGB3NDyIfupy+PIzH4eXk3SJkb
	1OjHsprvUmqsE9aXTGjJQ3mfePtbIlDis51GQ8D+360YHXiZZCS4JoNF6kVJfH3W
	mOoIkyQ2G26v1mFfF7/0jVFxgRC2JSjyrywAlCe2W5gIZvJdduy43DMUzJBN+NL1
	QwlACHFS6FbJFyt6pyTNfcuoAzMszVVBfdZjab4GtK6xds7zwM+tB3AEqrGFvsgZ
	Nq4nDPCh1c8N2HYQXnbiMrK+pMp8FUCBQ2jSD+XQX0AOZiklKfB1mcy9DvpuKlc5
	fLdbVAnWKZuIBjaALFBCTzYXqyVRASKokrvPwBkw09Sslk3Ez/Z3wOwtIVow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764663522; x=1764749922; bh=nsr0qfn3LBwmYbuVyglatgNTfJAK3WTy3VL
	wY9WQ+jM=; b=twS7CMzEDRn6nhh1TVATRj9JLQ/0kaKnTeXzvUqXUPEGek4cAQ6
	s0XE6rD5lis5su9Mo5eiWHe2TX9c458B7DODNLVjuXnRlvyi/w14/aNX2BKlzhpl
	bVSF84t2nvSH9+ukwD/ll9rupdlBehR7B/8hwh8UkK3RMjq/eYaTHmIv5VFs7Wui
	pcaiqUR4Cg6yT8oWyAZ15/MgVyM2ZykvOT3y6d5ome8BhKrPRwnoiGIuMNDhiEzN
	yHlArUpG7sa2sfupDQqa9naoMRLqvrtpkZr054FwlsPks4cm0+6hNSJ2EPnMDOhZ
	dHnqu4DJLNyCumr+yQdt0PkKa4jQD2WfpsQ==
X-ME-Sender: <xms:4qAuaeIQ9Z4haCccvCwpAO_oI4fmCaIv9dtMEILoStKkjCZERrb3eA>
    <xme:4qAuadkzrRmuGvzda33ELZF9yAlpJcMsb_VwesTnsnfRdOFnr4r7ilC8PMlEmhQN_
    uAb5dgPVz-VfB9f5tNvtlmdYfuOWxzx0WBVl3kKM-tmkvlTDCk>
X-ME-Received: <xmr:4qAuacER3rnIuCokE-GK3OD-cI5eyQ-BRthtE0lpk0HbwHT_m2nLHsHphmoUONcqUqnQpflbAisCgn_NjKVvkYe36fDzLqP1yTCnrBP3_Nc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedttdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeugedtgefhiefhkeeludekgefgveehjeehge
    fhlefhveeivdduveeludekueelgfenucffohhmrghinheptghonhhfrdhinhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehs
    rghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:4qAuadF4N0wsNoq3CcZ7W7XRoPkXIFuS-lm1J6KKq0tGXqRbPyZ2Hw>
    <xmx:4qAuaZOyN1NGLf1VDm_d8aZIhvAcQmM690zo53DP61eRirbX6zi4LQ>
    <xmx:4qAuacGbPJ0BUj7sZZKQs8tg5R6a8XatX8Vcs9sAlfqMwZve4iqUqw>
    <xmx:4qAuaQPBfMgFdXu3xNw9MRCmg0nNQPwrLJSuc5szNqmpooxMGrPrBA>
    <xmx:4qAuaUwp4AHoKrJPQTTtZ2WCOuID8lxDdxVLTfBIArelEUNKEF0HJeld>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 03:18:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24afd300 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 08:18:39 +0000 (UTC)
Date: Tue, 2 Dec 2025 09:18:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix doc default hash algorithm in
 WITH_BREAKING_CHANGES mode
Message-ID: <aS6g0Zjzd5OEd-mb@pks.im>
References: <20251202014605.52110-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202014605.52110-1-sandals@crustytoothpaste.net>

On Tue, Dec 02, 2025 at 01:46:01AM +0000, brian m. carlson wrote:
> When WITH_BREAKING_CHANGES is defined, the default hash algorithm is not
> SHA-1, but SHA-256.  However, our documentation was never updated to
> reflect this, and as a result, we end up misinforming users.
> 
> This series fixes four places where we indicate a default hash algorithm
> in our documentation such that they conditionally say that either SHA-1
> or SHA-256 is the default, based on the the with-breaking-changes
> attribute.  This both improves accuracy now and also makes it less
> likely that we'll forget to update these places when we hit Git 3.0.

All of these look good to me. One alternative would be to introduce an
attribute that we can then reference in the docs. The below patch shows
how to do this with Asciidoc, but of course we'd also have to do this
for Asciidoctor.

I don't mind much which approach we use, but wanted to suggest this as
an alternative.

Thanks!

Patrick

diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index ff9ea0a294..fe1c150ec6 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -24,6 +24,12 @@ litdd=&#45;&#45;
 manmanual=Git Manual
 mansource=Git @GIT_VERSION@
 revdate=@GIT_DATE@
+ifndef::with-breaking-changes[]
+default-hash-algo=sha1
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+default-hash-algo=sha256
+endif::with-breaking-changes[]
 
 ifdef::doctype-book[]
 [titles]
diff --git a/Documentation/git-index-pack.adoc b/Documentation/git-index-pack.adoc
index 18036953c0..730c3835e6 100644
--- a/Documentation/git-index-pack.adoc
+++ b/Documentation/git-index-pack.adoc
@@ -126,7 +126,7 @@ information on the possible values of `<msg-id>` and `<severity>`.
 --object-format=<hash-algorithm>::
 	Specify the given object format (hash algorithm) for the pack.  The valid
 	values are 'sha1' and (if enabled) 'sha256'.  The default is the algorithm for
-	the current repository (set by `extensions.objectFormat`), or 'sha1' if no
+	the current repository (set by `extensions.objectFormat`), or '{default-hash-algo}' if no
 	value is set or outside a repository.
 +
 This option cannot be used with --stdin.
