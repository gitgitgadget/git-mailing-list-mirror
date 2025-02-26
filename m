Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7B258CC1
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557324; cv=none; b=b5VeqXGPubI0en2xUeYfsPTfuEyydOfwFHtQXwGlNc40V+Gk3Mf6XPkEvmoSO39Bh8Pd/RVhLTqO1h80sEsV/yOBIL9me2kP3P4kfmrGzoMWLVN65BkVr0peFoIy1+bUWJ5EZeQgr2jq1GLtfY27+hw+3+Aqu3EZMrdBK28Sfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557324; c=relaxed/simple;
	bh=xwQTGjGyKqUhKt31GtRSw2xdK9a0htEIzeyRyx5aR24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvYM9fz7HCGAuzqR07M87/o9+b+n7d0Cnv50IuyqCRh4Naq6An+bSgMLiAnrCp7+JAsasqqhMyvL4GPlQdLiTQflOGz5RVZNvbo6u+qPmA0GwQdb3LRta1WF4b2MEYthwiqzgVfIL6Yu170vcrwo+w7LO/339ZHjoc0ODtbGJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MI+xC7YU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSU25O4D; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MI+xC7YU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSU25O4D"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 318FE1380EC0;
	Wed, 26 Feb 2025 03:08:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 26 Feb 2025 03:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740557320; x=1740643720; bh=QdEQKCb1P/
	XnkshoqhDqh/DMl/2tLhd+hWuBso0AVig=; b=MI+xC7YUGcQPk7XQNHH4LN8ykH
	rlZepWpQfyKW447ncEwGVBFJ1UaTEW+/8KSK4eGUBF13Wm80y8pHLj4b7eO4y1XZ
	wTBrzHGIElyIw/+yCRFOJSRDLsFnk+C/lpi3hCWDSSpR1fh+3xc50QDT0ThNOPGe
	geFsW4KWXTPiGVOPYewOufr8K2FqXBy3pjS9d9k+/3fPxd8aU18kcjjovHiX8aib
	f8FiuZjYAc1r+cq+gdSri2+Y5ZenznyK50x5zVW15XkZU9iFs7Sob+jcahuAp3bO
	T3wh7Mjm3OQOSL0FJgQuLdmDsjLLDEXC9Ri+A2N5XfjEd7qNnp/7X2KxZsng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740557320; x=1740643720; bh=QdEQKCb1P/XnkshoqhDqh/DMl/2tLhd+hWu
	Bso0AVig=; b=SSU25O4D48PggoE5ykfsRW8iXN9cwKeFIPGLkhyffp5ZCcskVRA
	B548/ZkEbJmhZ++tfBdUBf5jIDs1oYGDn625MRgjJaQNHDKiM8+ZNxgZm/sFJjyL
	ouq47KyIYwTfPl1T2gdlTwWMuaMoT12elZIv0BCAWKH1H3aFuuwcvYKKX0l2hlEX
	NOxIAGf/QQcGRxrRr1HiWtrqd0ejaBVYFFAfyfu49pQax85llzPbA+2UsAYxilAM
	AbWu5gfZx2qX8GJq4tGSWC3GgO2+f5lEkm2bKGJ3WTytzvtYLZVcorBtbwaw6rLI
	mByalopp+GICHxkMEAhYUOCiAaGNB3zGhQw==
X-ME-Sender: <xms:CMy-Z7fr2nvhgdYyFZ8XdBRwy3c8pzLQI3kGIQgfA3EVvWEQ__YxNw>
    <xme:CMy-ZxPjprIV_eFYO2mO_F0oAm14Xq9rBe-R-rvHZB4BQyNlZFk3eVqN2D54aTUKG
    GnZUh1dn5iTtW8pHw>
X-ME-Received: <xmr:CMy-Z0gZ9seiFVDjr-kzCIkfRMiuV0FG3dPBZMPCPQgNq1ijRh9mCGzVDVSH9I36Fi3gVDEzT9QUMumRVJGfZ4iqcnuxbld_HV6_AcCmOClKdO6e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuh
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:CMy-Z8_fwkH8ZkIeIm7hSN4S9mLoH0naCWjuoc6SvSlKufOflKDrJg>
    <xmx:CMy-Z3sJJSY6_aGi4HMlsoNW43_ydtdlVrjEgx5oTGFaTdM9ZA0Vww>
    <xmx:CMy-Z7EnlGziuPCIEvpsQ3htpIPwR8oJK1iRC9deAepioiJs9VCdZA>
    <xmx:CMy-Z-N9h94ouFw72DcK0-NAF7q6pNa9jOdykTocJLoeQOnWWD3MVg>
    <xmx:CMy-Z9V3BCMCPe442uGQLtB9YG70iUz_vVYzJHmZETvihnHm4k3S1lq->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:08:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6cd3fc17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:08:36 +0000 (UTC)
Date: Wed, 26 Feb 2025 09:08:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 4/9] packed-backend: check if header starts with "#
 pack-refs with: "
Message-ID: <Z77MAMqVGrT2jgcf@pks.im>
References: <Z73DTwr9RicKMINe@ArchLinux>
 <Z73D5XLzzg-OPmdT@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73D5XLzzg-OPmdT@ArchLinux>

On Tue, Feb 25, 2025 at 09:21:41PM +0800, shejialuo wrote:
> We always write a space after "# pack-refs with:". However, when
> creating the packed-ref snapshot, we only check whether the header
> starts with "# pack-refs with:". However, we need to make sure that we
> would not break compatibility by tightening the rule. The following is
> how some third-party libraries handle the header of "packed-ref" file.
> 
> 1. libgit2 is fine and always writes the space. It also expects the
>    whitespace to exist.
> 2. JGit does not expect th header to have a trailing space, but expects
>    the "peeled" capability to have a leading space, which is mostly
>    equivalent because that capability is typically the first one we
>    write. It always writes the space.
> 3. gitoxide expects the space t exist and writes it.
> 4. go-git doesn't create the header by default.
> 
> So, we are safe to tighten the rule by checking whether the header
> starts with "# pack-refs with: ".

The commit message nicely describes why it's safe to do the change, but
it doesn't describe why it's something we _want_ to do.

Ideally, we'd be able to argue with a technical spec of the format, but
unless I'm mistaken such a document does not exist. The next-best thing
is to do what everyone can agree on, and that seems to be to both write
and expect a space after the colon. By not following consensus that
exists in other libraries we're being more loose.

So if we for example started to stop writing the space due to a bug,
we'd still continue to parse the header alright and thus not notice the
problem, but now we have broken other implementations. That may be a
good enough justification for the change itself.

Patrick
