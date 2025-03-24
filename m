Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18915273FD
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 03:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742787567; cv=none; b=LL6/oUDLyd1FxfDnBCnV3cI9/+fGJwgDif8ptXoirCcO3U3r2bTQo2vjTosN2RzbZfCo1o6JS4lyM6hcrIQtANGD91r9wdXeR3+CglfiDLqnrFmJ7VLnHUJvpBYMK8p02ynQsashkKXSrnidxkfPdL1td0F7ef115pjG9tUjYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742787567; c=relaxed/simple;
	bh=KYHyWZpWpeIrg+ByLZkIauFs7I02d41ib3ZbfgZa3Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKU0ZxT6R9ukUTPo8r06/GJQUP887uYIq8zepK4NE4F59CuAn8pGKpEk5l7ejbM0lBF/SyYm1WI0WEpmGOzuBZyU6jHzf+F/opOWxuWLC301oAzjmcYW11SulunTvHqmFefKjICmjFmRlsnne5iDXBOjfXeBO6i+4k7G7mqBnB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=b8fR60bJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="b8fR60bJ"
Received: (qmail 15482 invoked by uid 109); 24 Mar 2025 03:39:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KYHyWZpWpeIrg+ByLZkIauFs7I02d41ib3ZbfgZa3Rc=; b=b8fR60bJFz3SJ9U//gX5FJv/AgKgSaxTHY6qNde4Or7n4jyHt32z2S/ff4E7RrISlEigUJnq/EFw0AT9MWEbKd+7dQg2zQgzkuh0qMKdqTXUkUaqA4fyNqdIvJ5JUHtj5iBVBXKjvLwNE5Ycs2ADK+4pCoA48Y6ob1SSiftmasrq+YVxqGzvhvg6IBqGF1rprT6aO8xZeehZP3J99/ug+Db0R+CvrbBA5jEZPvVNzNZdatHhw6Xho9d+aoR88yjrfJAfKMmTVxh4oo2vguwZ2CgLOHxoMCXJ2XJl3NkK5nPBow3GENEzD+F7Kk0zbXnt/JxmQCyXusKJHHsH23dOBg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Mar 2025 03:39:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17253 invoked by uid 111); 24 Mar 2025 03:39:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Mar 2025 23:39:23 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 23 Mar 2025 23:39:22 -0400
From: Jeff King <peff@peff.net>
To: Peijian Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-command
Message-ID: <20250324033922.GB690093@coredump.intra.peff.net>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com>
 <20250221190451.12536-9-eric.peijian@gmail.com>
 <20250224234720.GC729825@coredump.intra.peff.net>
 <CAN2LT1CsjA7V_y-OqDNREkpERHEBcx627JhCrzg9GHfWS=b0NA@mail.gmail.com>
 <20250313060250.GH94015@coredump.intra.peff.net>
 <CAN2LT1D3d=yMYVhBjpj5PvyjfTVjwqcFPNViuCJ=f49YbCZuJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN2LT1D3d=yMYVhBjpj5PvyjfTVjwqcFPNViuCJ=f49YbCZuJg@mail.gmail.com>

On Fri, Mar 21, 2025 at 02:24:05PM -0400, Peijian Ju wrote:

> 
> Thank you Peff. I like the idea "... it is not an error to ask for
> %(objecttype), but you will just not get useful data for those
> entries."
> 
> So if we do remote-object-info with format "%(objectname)
> %(objectsize) %(objecttype) %(objectsize:disk)", the response can be:
> 
> 4346b22767c07e31d0f9b524fcb377972d957313 199 ??? ???
> 
> 
> Where ??? means the placeholder is not yet supported. In this way we
> don't have to change the default format, and as new support for the
> placeholders is added, ??? will be replaced by meaningful data.

Yes, something like that. I don't know what the placeholder should be.
In similar situations for the ref-filter printer, I think we use the
empty string for unsupported cases. E.g.:

  git for-each-ref --format='%(refname) %(tagger)'

will show the empty string for %(tagger) of non-tags. That lets you use
conditionals like %(if) to switch behavior. The cat-file formatter
doesn't use ref-filter now, but I think in the long run we'd want to
unify them. So it probably makes sense to match its behavior.

> About intermixing remote and local object requests, do you mean what
> happens when remote-object-info is passed oids of objects that are
> available locally instead of on a remote? If so, I have these
> scenarios:

No, I meant that --batch-command takes a single format string, but you
can issue both local and remote requests to it. So for example:

  git cat-file --batch-command='%(objectname) %(objecttype) %(objectsize)' <<\EOF
  info 683c54c999c301c2cd6f715c411407c413b1d84e
  remote-object-info c9d3534de317f31915f37e9d9c0d52d4cf901482
  EOF

would show the local info for the first object, and remote info for the
other. If you're only issuing remote-object-info commands, obviously
it's dumb to include %(objecttype) which cannot be filled. But in the
example above, it is possibly useful to get more data on the local
objects, and a reduced set of data for the remote ones.

> 1. An object is on remote but not on local. This is what
> `remote-object-info` primarily focuses on: we retrieve info from
> remote without downloading the object.
> 2. An object is on remote as well as on local. I think
> `remote-object-info` should still retrieve info from remote instead of
> checking local data. After all, if the user knows the object is on
> local, they can use the `info` command. If remote-object-info is used,
> it means we are interested in the information stored on the remote.
> 3. An object is not on remote, but only on local. I think
> remote-object-info should fail in this case, since the remote doesn't
> have the object. The info command should be used in this case.

Yeah, agreed. remote-object-info should always predictably ask the
remote.

-Peff
