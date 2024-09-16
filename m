Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42A3FE4A
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473056; cv=none; b=kawvExCpved/v2gLsLAAKDqcYwGSN5thrTUrtj2N7x9JC9/1cfPkDKpCiW/lQEojYcx9867I6WXmYptDjWhS9CW+5ROXFsh0wcGEneLi7Ag2V+fW85g/4DODkT7ce1wgFjqPBTZ+aOAeTauI/bCGarJhr80CNMQiC6JODiE07+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473056; c=relaxed/simple;
	bh=Q6f+XpD0tu0FE+wvZVhodvcjAU2fKqa8ZvMIU9ln/sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loQbJJoaE0rwKGUfAQR8+D7BlxrhI1Kn1PhGzlSmrVKvUDKV1n38U6hqRPC3du346Vylf0fm5jidghTmNoL1yJOqCFvs+B1v7JXuowKP1g42GbzQRshkyMs5Y5+IinYlIz7ea+LeK5ukz8ZWXDzYAVEfl7qgCvRVr19Q9qzNq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=avF/1KgA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dsDw1n3I; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="avF/1KgA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dsDw1n3I"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 512421380259;
	Mon, 16 Sep 2024 03:50:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 16 Sep 2024 03:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726473054; x=1726559454; bh=zDHl0OONPs
	LfZ0OcxW97IOfZPPzSDVBui2d6cHtgfDI=; b=avF/1KgAc4qijF9ZHWKyzPUGDu
	bf+3aQu98TshOOVNiWP8f+DPGlqMqt5dEwCPL22yAUq87v6U9PSiR6nw/Jq1SZ72
	27qIXr5mMyxOvxiL+V7ZvHt2C0xgTDMWyZE8nnO8ntA+tsuxhM2uBIGbbAkapzP3
	jlirRoV/kRMb6Maa22H3w1ZUzZwtn/UFF+lxp34yTUJ8W/+xGgXgCzPSVviIKdOD
	Op5V7r+aG7kFuDq36HSi/JcfnHnwie0osyL5Z2ycFvdQIpYDGaf6m+VagZ7oYJPd
	cyEniIWU9VsK3574It6VQdkxc5lvvf3LHXxjp9pwodCOgfh6HL6LxqZg40xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726473054; x=1726559454; bh=zDHl0OONPsLfZ0OcxW97IOfZPPzS
	DVBui2d6cHtgfDI=; b=dsDw1n3IQkE3N9YqfUv4o5897eyIRb+FVbO0M+r+WnDv
	jdF4DV5I8KBb4bdJQQTInJot4KLYW+QUPfz3HdhWee5xkiqu1/gOr4/RlOrwNLw8
	z3KB/T3mN/G/bPcU9CI89MEnS9dpF05cljuesHBlezsEekPP0JaLeKveMMRDdqn+
	aEFI9quyZ6TX/DVqzQN2VNcNfcyjibwz1kiN5Ny6w45aJhrtA+ByO4rNxWHZw7gZ
	2Eo3bugyn3ii5FQ/QeKdv2/4glPRFFCuDi1xHvxlnFOCpt7ViRWu+llH/g9iVLh/
	OKx8PqhDyoN0pJrJvjm2MvfNKq42s3OAUqDD3IkN2w==
X-ME-Sender: <xms:XuPnZoB4aCT7ubtl-cWWAXlkLYxxSQPVp_elX-0G5oVkG8vJKasy3g>
    <xme:XuPnZqhqtLqIjNHygg7rzd7s972Yw1d-_MS_-0uKDwmwAgwJl87QmEi2Vh8q8rgh3
    neon-RCutalE4zCQQ>
X-ME-Received: <xmr:XuPnZrmx5JBuSAz56ZM2f_CC_DPJzYwaj1CzkyNsR1UW-Gpa3hhPBzcIJger-SBod-EyfthCV5sPNZ-tTuNotb4qQFyRCjWiQKD4QievsJRL6QeK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehhvghnrh
    hikhdrhhholhhsthesohhuthhlohhokhdrtghomh
X-ME-Proxy: <xmx:XuPnZuxNe7KoWpShuLlWpoyM9PNvIrWejLZrmiKoPnXGhdcabUTbwg>
    <xmx:XuPnZtT5VYDxThMamZx6Ul4a4Znt44qEZO6l_DwKmC7BV_boFxuyeQ>
    <xmx:XuPnZpZzZost1Sn3zIwrFyUuDPdhPz4ZQLRV-lhI7FM8zGAjSQKdkg>
    <xmx:XuPnZmSMXXsanGerfOaiTwvMaIvrE2DwOn5ySs7nW3T_BZfYvh8h4g>
    <xmx:XuPnZrPDprxt3N6WMaUmcNc4evRAh60LmooRIEYgD7_RplnoLIl_ru2O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 03:50:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07a1f177 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 07:50:34 +0000 (UTC)
Date: Mon, 16 Sep 2024 09:50:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Henrik Holst <henrik.holst@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
Message-ID: <ZufjWR6AJM-DIWPR@pks.im>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldzsrhyp.fsf@gitster.g>

On Sun, Sep 15, 2024 at 09:37:34AM -0700, Junio C Hamano wrote:
> Henrik Holst <henrik.holst@outlook.com> writes:
> 
> > If I set LDFLAGS to whatever pkg-config --libs libcurl says on my system (actually: -lcurl -lssl -lcrypto -lzstd -lbrotlidec -lz) then it compiles just fine. If I add LDFLAGS to the configure environment it will accept that test, and then detect, as expected, the pkg-config settings for libcurl.
> >
> > Should not ./configure FIRST check for a pkg-config environment without assuming that even the most trivial curl programs should compile without any additional dependencies like zstd etc?
> 
> Looking at configure.ac, pkg-config is not used for any package.
> Specifically for curl, it seems that "curl-config --libs" is used.
> 
> Presumably the reason behind the current behaviour is combination of
> (1) ./configure is an after-thought in the build infrastructure for
> this project, (2) pkg-config was not ubiquitous back when autoconf
> support was written for this project, and (3) nobody considered
> "upgrading" our use of "curl-config" and our manual detection of
> dependency detection for other libraries to just use "pkg-config".

I sometimes wonder whether we should move on and discard one of the
three build systems we have: plain GNU Make, autoconf and CMake. And
from these three I'd rather want to throw the autoconf-based thing away:

  - The Makefile is probably what most people use, so throwing it out is
    a no-go right now.

  - CMake is really useful because it has support for IDEs and
    alternatives to GNU Make like Ninja, which builds Git way faster
    than Makefiles. It also has support for out-of-tree builds, which I
    find rather useful.

So is there a path forward to move CMake support out of contrib/, make
it an officially supported way to build Git and then throw away the
autoconf-based infra? I'm not the biggest fan of CMake myself and very
much prefer Meson, but we already have it wired up and thus I'm trying
to be at least a bit pragmatic.

(I'd honestly prefer to end up with a single build system, but also
throwing our Makefiles out would be a step too far at this point in
time.)

Patrick
