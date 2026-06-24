Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283E91DE4FB
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297147; cv=none; b=pddL8Wf48NZh4lhjQm6vyE5ORNN55BC6PgoeKLUH1RuRO4QiHUP1IQVX+TGC5szyv1Ix0uwST86UIVzM5UD7UUuURB1mR+YD5NknwgVU+jQpWQj8GUKg3XWJubypxoTZkPfVfAFKxrH2Ub0CneyvK6RfZQKsaKToUZvwYxMy7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297147; c=relaxed/simple;
	bh=UxNbM4WCOISAEH87ISoiAGsqsXOfXlPpF7D7b0eO114=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sknb0xzCFezdpO5jKwJgmZxQ370wrQ1M9/lx95ytwGxyY0NvVHlvvAp3YHhmr6IN0kUhN+3mS7k2yNaNawe0XE+ALv3eU6CfamNaTshdf6UXeJ1r3MTagQdm0+kwxEAr8MQGWT53aRcE643JnNOz+FbDHOn/1P8DYeJrPjT/cRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dmo6F4Y6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFY+eJVq; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dmo6F4Y6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFY+eJVq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 68F041D000E1;
	Wed, 24 Jun 2026 06:32:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 06:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782297145; x=1782383545; bh=nUdJQPoGK4
	62sZ2Z+DFIYlG1hGH85yHJIuDE2Zljp1Q=; b=dmo6F4Y6+dqavQKJr3RwqD7Zdl
	/ZXxMQCeFH0caYqLbYUGXWtx+3Yi1CdhXRVIyiHuhyBgdEcEgLJwNlFIP0z+c1U+
	tP71qv4vZaOuM9G1Sf0GO5Ib+0Q9igmrdi3sAT9AJrPSMxpcuDuX4+z1daN6gX/W
	/C0dGs9WORFIJmg2rfArb9Umd6euMAuBhsl5GNX5kLUO1Thc9DqDDzOm3wo21nTD
	38trnMG+pHN9rRLTyPQQ/EcFZJRm3X+SMObw/BxZJ8022HcClyrv9gc5MRfWBR2g
	lHi6GT+6Lo6H5o0l4pgmr2XT7NzBvn1DcS8IjLOaFi6AGOlRiKwYaQX+E7iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782297145; x=1782383545; bh=nUdJQPoGK462sZ2Z+DFIYlG1hGH85yHJIuD
	E2Zljp1Q=; b=IFY+eJVqzJpjjayxPLRsBhWIXhhgpTGKp1VBkGKdfW+HUmxulH7
	zU6W3f4yjcwygh83w6frowByoCktgvRpn/UlAyGBnYxhrcpAVleEp6aE7FdpdjHT
	l/6YY6QlnBt9Z4VOduTJayncqWIAa/FSZE8CRTuypYQSVGxI20C+dNsZDXx1Gct2
	YoP7LABKw/8lFG/g56aOA5Y7qvLPfoYILjmbKoUF4qQ1B5JasRSLqahmqzF7G8jF
	3PtOIIUn4x7InaPy16we8BeJ/K4v/sm7QS2TUFd+ZaDxXpbr3AFuPL62hPXFokGr
	FxF6MaWQvrmUZpDsS+fx3QMdQg7xAaBoVBQ==
X-ME-Sender: <xms:OLI7agkUtUR_9Tpi1UXZbOzMZxXh7U6lvEfX7kGLMUkbi0t4DrJVqw>
    <xme:OLI7apINUxsB34IJMfOwTjzYPkP6qJW49FCB5qUpNVC7KAEu0u_-fS__XfUHMGxah
    P90AS8WmtdWsk9NaysdsksiIexIGfupl2yRyymdbQW2uKYzIlSu>
X-ME-Received: <xmr:OLI7al7Cm8VdL9iWmsucGEB69ip1nhpDWbNnZnrfMfID1LJDu-C0K4h4E-Gj2Nm0pV8SVq6DstzlivrIf_NXGt6oV15I_MwCCMsvYEh->
X-ME-Proxy-Cause: dmFkZTEa1Xp74Nr189XXV8wBo4JS3k4Lhyt49sU9IvXfjHK1xt0kk2TYYm+ZBTgPL7CyVZ
    TvJcvszzdad/JMZSyqxd993rp7v5QGH3ezIxv7G7tHYt87OuBRv38XnURWFNzJdkGRTzbU
    UKcfd8ibeCjKejLRE9h9zv0dfNTUrPChief/78p9HVOId6Gyxg1cI3wf5pNY9acF+8OOdd
    u5LZ/3o301/eG1RRBj8SkFy1ZcbY6xp3rUKwqG9Lu4VFMsNOL9xTJDoGd6oemVkTavqCPy
    Qkmhb0V5pUiWhT6nNbP0Wm8YJp5ts3mqUJVUmWCu2xplihG0HSMesXrk1jqfkWPIlaI7Pp
    frI4dDrzCrr8dfgxN9Kg8qjsovXx2E+CiatDs+yWhsOM5mi+woApfcwFSSH4TgD+Zimwdu
    RYAvhA7omwfriLkQptUvibj9qWMo8zjqqMfdEP6z/2l45gvi/I6YlMs/OE1UJ+PbBVtTmC
    lY25yJcbqdme9w+IiJDY54oK0GDoovdOxMEJv9e0R9RfSG/jVtfNDIM9W0XGdRESlNHmqv
    HBFX8yNbwPc6tIiySCIAQJ4+jIYGJ5W27PTudMEzs2CnADgDSCw5fqa3bjsPQR3HWtO/aG
    9fItbLhu0HG0NSzbpK/qTWNcBOEkcdhWSYBdY6AqGhinQkQ86L9obkJVF/DQ
X-ME-Proxy: <xmx:OLI7at1UylXOuAQnUgAPCm3Nb6l3rjYD69jueWJAYvrVBQ3nxzxlyA>
    <xmx:OLI7arcmKT_pCsU3qkD1FB49PTQ3uhQZdB_X_XfqrZCjZ_hf0kxAjQ>
    <xmx:OLI7ajfqzz75nuAmyg0HqR91lAP3nSZ_Zh6Dke-VDksGdgXcbvKpPg>
    <xmx:OLI7amz_6xIV4WTwr1at5RYQF4Gi82oxb-l-YzqRLp9pwtM_kgYNOA>
    <xmx:ObI7apA6FUx1LRkz9__nYlaIBinsYWQcHMjeBYd_iFzNayqYuYScV82D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 06:32:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82b68c92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 10:32:21 +0000 (UTC)
Date: Wed, 24 Jun 2026 12:32:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <ajuyMrQ3Eg4pB-Iz@pks.im>
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
 <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
 <xmqqcxxi3eov.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxxi3eov.fsf@gitster.g>

On Mon, Jun 22, 2026 at 06:08:48AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The Git project is not exactly the easiest project to get started in:
> > it's written in C and POSIX shell, with bits of Perl, Rust and other
> > languages sprinkled into it. On top of that, the project has grown
> > somewhat organically over time, making the codebase hard to navigate.
> >
> > But there is a rather practical problem: finding your way around in our
> > project's tree is not easy. Doing a directory listing in the top-level
> > directory will present you with more than 550 files, which makes it
> > extremely hard for a newcomer to figure out what files they are even
> > supposed to look at.
> 
> Well, many things already live in the dedicated corner of their own
> universe, like tests in t/, builtins in builtins/, and documentation
> in Documentation/.  This is pretty much moving everything else in a
> single directory lib/.  Surely there are things like top-level
> Makefile and other build- and ci-related things that do not move to
> lib/ for obvious reasons, but I view this move essentially to change
> "for core-ish and library-ish things, look at the top level
> directory" to "for core-ish and library-ish things look at lib/
> directory".

Right. It does drown out the things that have to live in the root
directory though, for example files like README.md or SECURITY.md.

> Would that make it easier to navigate?  I am not sure.  What I am
> sure is that this will force many in-flight topic (and soon to be
> in-flight because people are holding them back during the prerelease
> freeze period) to be updated, and it will make it harder to make
> fixes that can apply both to 2.55 and before and newer codebase.

That's definitely a downside, I agree.

I have a bit of a different angle on the second part: it's not uncommon
that projects move stuff around, and if Git cannot handle those
scenarios well that's a usability issue that we'd ideally fix. And by
doing such a rename we basically subject ourselves to the same pain that
other projects are seeing, which might give us more incentive to
actually fix those pain points.

This might be a bit of a weird take and might raise some eyebrows. But
it's basically a tooling issue, and we are the ones who provide the
tooling. So we're in the best position to fix it, and by doing so make
everyone elses lives easier, as well.

Who knows how good submodules would have been nowadays if we had used
them ourselves? :P

> So, my initial reaction is somewhat negative, but I am known to
> accept changes that I myself do not necessarily agree with, so...

That's fair, and just to state the obvious: I'm still happy if the
community decides that this is not worth doing. But from what I've seen
until now it seems like most feedback I got was rather positive. Which
honestly surprised me, I was expecting more pushback.

Thanks!

Patrick
