Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56834188580
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 05:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067530; cv=none; b=aNamf1dt9eoFuBWUxFK3puzxchpTSjnFnV4JDFfbyEnDAxUTr061Q6yAttsDxBZajkvd6uH/3Sf5i067jepe8L0jM8VcHtVbYFR7jakYZ3zAxpA8NZwQMm4kx5Dex8UFDNbexZFPo/TX+L66ewcgBHlLdt1h6HDVRKxbcNpD+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067530; c=relaxed/simple;
	bh=QOBSUhFeGsNeKfzDziXB791SQsBbs52jZlqXYxcNcwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+cDflrwPWpWL4spvuLjc9AnRoxHNZhqp247AwBPZKPLSrjGluyxQsL1tK5sQTPGG0gw13AX4i+MYMnm54qjlRT7NQitRZ2P1JFSsZldTspqnxJOsel0R7R9mOuI5dcXYrpOHGMTGKVvsPAEOC4bk/OEJMjAdt2g9hi7OmOvSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fuYoysBW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J8kCriEJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fuYoysBW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J8kCriEJ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FB8D114015D;
	Fri, 13 Dec 2024 00:25:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 13 Dec 2024 00:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734067526; x=1734153926; bh=n9Rh/Vd2Q6
	zQE32/oVXSXWKKIQ7c3q/nBmPTyKcBlr4=; b=fuYoysBWCSo/0bgwUOlUEvGVw1
	ytBT35UHR+TmQlwxZgvErT4ocl98xkD05+m+7MMpiF3sd0nQJe4TfUqMoOlOLY5O
	leBZo/bBQfr4uN28bgbxDr+t1YKa4N3Yt9wPmNmF/uOmE9QwGsSqFpBZ2mhiJi89
	Hmof+1voGhNeeIzEkCwwG9V0dLl1OTJUYcMtRXNJwLP9kFAY9JEod6IA+oYCjidJ
	uNdELb6/9t5MsuOdGgA2gsXVfd+q8UFqcitHbVpM/FmY9pfEHodzj2MkrMjCXFaV
	gxPaQrsD1deBOjUSxeCz7bLZOwcci96xi590Xa8eiqeYHMIEbDO1sqFeM/6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734067526; x=1734153926; bh=n9Rh/Vd2Q6zQE32/oVXSXWKKIQ7c3q/nBmP
	TyKcBlr4=; b=J8kCriEJblCyY8dBRJwIx/LMnOUJTWEy7EER4k7UhZMeGgtxRyk
	IRmR+p8nJPS/A9UvEOxpbRLHFKBMmik8RTRWW5FN9qOk/sYp/6qX9QgEdxKdMbsn
	Mu7vf9sGef3HBGgUm4qsez4ZJmucqcQzy4X21uAgRZRnZYDMcPcPd12btDUQK7e8
	37Fpst6HGDs4qTVw38yHYydDS+QUT05PAIFdgVwI6OycvSgw32vrMTxXEpXrznSI
	mdBpodz9GU09weBqnn4eCeLhtVSgT1SUuoU14Ll+aQhdfN5Ew2RdnhKRPU7jac1c
	VNnwZquANlkAOo8aONMqsthfk8KiBGDJLOQ==
X-ME-Sender: <xms:RsVbZ2jUheXUWrxy7RYAy-qMIjux0p3QsxQSOS2Zd8VysZUrtyxFuw>
    <xme:RsVbZ3D8pj5f1vXqTvqYM9KyoZUIltzk9GIRpBNSnSGFKkcP8Bi_oxitqFGX-EdLT
    6stcVUi2oDgcUumwg>
X-ME-Received: <xmr:RsVbZ-FzhoKyKMEKHnzCeOuJF2wAbdmb0bwhR1nYRvYH2W6y4hoXcyzk84m0NAjnRy9EVsu_oFOcJb2f4iypPZl688ldd5UOvhEpTuhBXlrQbu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RsVbZ_ToqpVpO40-RvtxMWFylep9_UVIBbCmmBmhV6HTLcwNjnqmQA>
    <xmx:RsVbZzwsRNwC6C8e0RTIZTaPUBQsWivyrFoktTnx9Zq-Wrg6ohBtTA>
    <xmx:RsVbZ95Z-1hJt4Xdimnxg25d08K0tyW4JUrqYP7mn_6wMOjBq-QSfQ>
    <xmx:RsVbZwxJCIXjlBg_-_0hLZfTs05I_A7OAq7pZdyoU8P2ftdmYg4MBw>
    <xmx:RsVbZ-8EuiHVZsA3UpQvx3PlKYOIwBeHg4DKv9pEADhExcbWg3fe-w4x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 00:25:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a44755f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 05:23:47 +0000 (UTC)
Date: Fri, 13 Dec 2024 06:25:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] t: fix out-of-tree tests for some git-p4 tests
Message-ID: <Z1vFNpcaRIFBODZk@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241211-pks-meson-ci-v1-6-28d18b494374@pks.im>
 <CAOLa=ZTgQLgWWsgOCufvkaUDD1RwP+cs8eSAK0XuLXXHiZa_4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTgQLgWWsgOCufvkaUDD1RwP+cs8eSAK0XuLXXHiZa_4Q@mail.gmail.com>

On Thu, Dec 12, 2024 at 02:53:47AM -0800, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
> > index 036bf79c6674f6f1f0d667c7270674168428ffee..02f9ec09053890a4d41b7dc95644066d6481bbb6 100755
> > --- a/t/t9835-git-p4-metadata-encoding-python2.sh
> > +++ b/t/t9835-git-p4-metadata-encoding-python2.sh
> > @@ -14,23 +14,25 @@ python_target_version='2'
> >  ## SECTION REPEATED IN t9836 ##
> >  ###############################
> >
> > -# Please note: this test calls "git-p4.py" rather than "git-p4", because the
> > -# latter references a specific path so we can't easily force it to run under
> > -# the python version we need to.
> > -
> > -python_major_version=$(python -V 2>&1 | cut -c  8)
> > -python_target_binary=$(which python$python_target_version)
> > -if ! test "$python_major_version" = "$python_target_version" && test "$python_target_binary"
> > +# These tests are specific to Python 2. Write a custom script that executes
> > +# git-p4 directly with the Python 2 interpreter to ensure that we use that
> > +# version even if Git was compiled with Python 3.
> > +python_target_binary=$(which python2)
> > +if test -n "$python_target_binary"
> >  then
> >  	mkdir temp_python
> > -	PATH="$(pwd)/temp_python:$PATH" && export PATH
> > -	ln -s $python_target_binary temp_python/python
> > +	PATH="$(pwd)/temp_python:$PATH"
> > +	export PATH
> > +
> > +	write_script temp_python/git-p4-python2 <<-EOF
> > +	exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
> > +	EOF
> >  fi
> >
> 
> So if the python version (2 here), is available, we create a temp script
> which will use that version. That script is then used in all the
> commands below. Makes sense.
> 
> This is similarly replicated in `t9836` but with Python 3.

Yeah. This whole setup is just plain awkward from my point of view.
Another option would be to accept reality and stop supporting Python 2
altogether. But doing that as part of this patch series did not feel
like a good idea to me.

Thanks for your review!

Patrick
