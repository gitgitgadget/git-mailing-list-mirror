Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567E3ACF1C
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103723; cv=none; b=ARvuIhOVUYfoHfRQ5IeYF67ujAe3feARES+x4VU5H3Wg9xD34P/5ftvj9P7hxWgg1w7XKDEJ1ynmYLU/wv7sWXBOCPE7n2oXL0WkmSOFhDsErbaqlkMbfrkE3ahb83JsyWGXfRRmcaCWxHKJlgW/DhJ3rpoDR0J6Ak2V4TfA9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103723; c=relaxed/simple;
	bh=/uZj00DtlIhS0blBEw/CYIaVwCSKZt6yCuXi1nIpxB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIl2QtJjSKV4oMuJG1UQGwxx5hoePToMJISBOhkQRpi+BPXcr3FQlg9bgRM4Eg/g+n18dKP1jIy0r0vAOPIA2U84S+j3VSH1gXbCekKRfP+LIPOBgilILl2zVK5spT+mBpHJ48Lj2XDV9mgEkaP/XFnLeHwpz0IcfG3EJfE3bZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KgUHP7Xu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k0g4dlkf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KgUHP7Xu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0g4dlkf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 03A2BEC06C2;
	Fri, 11 Sep 2026 01:15:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 01:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789103721; x=1789190121; bh=cOoysKpkRR
	7UBBL1KsreU/tmh/S3JjVrdDgk47UkE90=; b=KgUHP7XuilAz57frYjVHD1QD3/
	FYbXEcc8wTjI9dQ1slE9KIETs38iGbtGUWw6ZdfhPMH0mNMiVlMVIrfNC7VXn3gI
	hPxQ0krap/OMAy8toORYjayOdojvAHlRhaOFS3eEyMHU5MMNiECTJzZWnRa2CtjD
	rYymPdsJt+2l5iqZpu+QhUZzxCnVb9EntluHpicTsFibQluW6WsG/swkpVyjhtad
	qHrgv8rj/aLMvaQBMTNydPbE5ayfgKuNC9cjbHm/8Jh0v75gRh7yaBtWrPmWCD2o
	2hlsnV5Jju+oQVJkIT3FVkn3GsVE859Y6a3yoEbHxQljl1vAgFTyKbbjsCGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789103721; x=1789190121; bh=cOoysKpkRR7UBBL1KsreU/tmh/S3JjVrdDg
	k47UkE90=; b=k0g4dlkfFKd4ipMVwJrKgCvuUcdH87b285BdJHQ8qrRK02W8q/S
	aYxef7Y/bsL6vuEX7H1ZtklfgmMK0oJTK+PfitwDhCeKPDUR/XmDFSteGomb4jYa
	48YGCIXoLsj7ogiwO0E26tY++hllzwLjH+p3N99dXsdoclkXUVIECvDkQZLhaa9j
	h/9Y2OKFOJymWK3wRwHDN1z2yhKZQlnOARkSytt0OHXOjb9zm+rTDPWMtLRPstra
	WhtkYVvNZKrMTYKndbYQ6l/o/9VuGDhxJVeRwbVly5VLvoeWHJnT68Q2UUS7CbHc
	MFNh6NZohx7lu2rXqx+AzPHm6FBfLKdr58g==
X-ME-Sender: <xms:aI6jajEONadp3SrQ-mh1v-E9hyvopkQHbNrJGYwpv1MjS1pAD4ddXQ>
    <xme:aI6janP3r4qbgCNbrxJMIZcRj6_oL63lQqg2NAhJAQ7TRuBvlGv6LzpF7xjyHTmZ1
    _bDD4xlSEtWCre0CAnzq-K77rQ9guuGqANByNsT1FFwiZyr7zw0ea0>
X-ME-Received: <xmr:aI6jatdAVKCC6hJ6QInvXRdTAzqY5ABxwqgS-cN-2q5mD-dICroNrfpxmpsFWixq4YkhAA>
X-ME-Proxy-Cause: dmFkZTGEo/DGXRr6WsB3M20CDFOnECDASavAz7btXzSUbvfiCEAl72FpbFfpXyEmsBPFu/
    RHjSwIo4aL7UCYlsk4L+wFcxGVqldYgpWooyNt30YzDaJixGZRHgmsxpWqQszHXKI7S+oa
    4fecYUl8fy/O1ULWFgrQjwoC6NelUt5o9bkTuF5TfexlZcV8NMyb368K4G396W35aUkqwR
    f+MhuufswUOpzLYJ8GNpu9EP7l/DRTqxQp39aNxWGIovn99vC7LvLGK8rJEJ121prFyyK9
    xjgyQ9HEiaRsYdZIOlLIIA6K8VRwY4vV4HidbhcS3fSfDLQK+HL9d7TMF5bRRhpktdPUFd
    mOmQZKajVXzuRYOWqvEsJ5gop867iuZxtfLtFPPn+PutZUF0e1qYU45P/j1MV7CYkqoD8z
    JnVUbDbAUZ32YmiaaSsadr6ndLczlRHrJc+hAZUD5nlGaRz93ZXcMoTxqjXyU7n6yZz2gV
    +cuQMrpfaqTtyBzC5OIIxlG2k3flCE/bOC9uLrhKgTNFQe0TG0rhvYonjLeTcJKKCFOgW/
    yzrYlbnNESCAZLIyAShpN+WklG4fP+TdKb62kR+L7gArgWEJwE2rG6lIigYIC02tXUvn4V
    vljOIGNPCRaHZIeJ1OrhgJvQECpDpKUpDei1jtfprq1UqZuwCb8tUPLdJErw
X-ME-Proxy: <xmx:aI6jasvv9bNSNMZ7mc5zYRvmdo2YWMODojMLVGodLOt_1dfDXezQEQ>
    <xmx:aI6jamk4YePjDkbDZUghyllsqbEgK5DJ6EZIME_8JSX32W3vy_I8pA>
    <xmx:aI6jamy02zuA7EXHCUlzvgK0jvrayruKgm3-1FZOKgMRwcKuBonmMw>
    <xmx:aI6jagMibjKutwPMPlzniq5VwuoU__0fsvKKlEjAlM-kL0KFMygcJw>
    <xmx:aY6japJxrOwtklKnOpJDlSZ_U0kRBf-ELIQ64eqWQlBBjX7MVjYAh7hz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:15:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b52f4cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:15:18 +0000 (UTC)
Date: Fri, 11 Sep 2026 07:15:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v5 0/9] odb: write alternates at creation time
Message-ID: <aqOOZB0wQ8FNGVE6@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
 <CAOLa=ZRYsJL_0sKnfHD0PJO+5c+BKSMiuN20PeQHKJin82TJDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRYsJL_0sKnfHD0PJO+5c+BKSMiuN20PeQHKJin82TJDw@mail.gmail.com>

On Thu, Sep 10, 2026 at 12:53:21PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > writing alternates into the object database currently happens via
> > `odb_source_write_alternate()`. But while that creates the ability to
> > create alternates at arbitrary points of a source's lifetime, we don't
> > use that functionality in the first place. Instead, we only ever write
> > alternates when creating a new repository.
> >
> > This design is suboptimal due to a couple of reasons:
> >
> >   - It requires us to have a `write_alternates()` callback, which is
> >     overblown as we never even write alternates to an object database
> >     after it has been created.
> >
> >   - We're about to make alternates an implementation detail of the
> >     object database's backend in a future patch series, so alternate
> >     implementations may not even support them.
> >
> >   - The backend has more flexibility with how exactly alternates are
> >     configured when it itself is in full control over their setup at the
> >     time where it creates the object database itself.
> >
> > This patch series thus refactors how we handle alternates so that we
> > don't write them ad-hoc anymore. Instead, the series introduces a new
> > option for `odb_source_create_on_disk()` that makes it handle those
> > alternates at creation time.
> >
> > This is part of the bigger goal of moving handling of alternates into
> > the "files" backend.
> >
> > This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
> > with ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
> > `alternates_db` field, 2026-08-17) merged into it.
> >
> > Changes in v5:
> >   - Rename `add_one_alternate` and `add_one_alternate_data` to
> >     `collect_one_alternate` and `collect_alternates_data` to clarify
> >     their intent a bit.
> >   - Drop extra parameter in `collect_alternates()`.
> >   - Clarify why we compute `commondir` even though it's unused.
> >   - Link to v4: https://patch.msgid.link/20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im
> >
> 
> Looks like you missed my comment/question in
> CAOLa=ZQaPstiQmXm9=TyWPUxL6X2=Lcqeg6y2XeXzSJDpq-GBA@mail.gmail.com, but
> otherwise looks good :)

Oh, indeed, I somehow overlooked that mail. Replied to it now, but I
don't think it requires further changes. Thanks!

Patrick
