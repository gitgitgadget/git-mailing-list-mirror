Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44036682C
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732758; cv=none; b=FXKbQgF8AUS+PrGvQDcvPEubrvAkGYW4XXuXgT63gDN5uInSz+5FWIkGYeBPGWQvV+uz3/uaWLqgiBL+jjGIzb7ehJZfSNq97feoM7DKLVPT51yQPgSi2Zh72MpV4+RttSz99uTCc2OZPeuDerCfRppda88Vh0UFUzSRLoNZl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732758; c=relaxed/simple;
	bh=67qsQdr2ng0wcuiaDgyI8YH2rf8DagG9WQkzJLXshS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUPh08kUxUyDCp8yFODmZQwS4Frv1IgzhpDLd4QQ5zZR/65qU/IGIqpCVOW/IrW17kXIzzE+ETuE7+h5wlILtoGYxfoa+2sk9y5fK+03vg0xAHs7/OtgaCpn8S+Bw/+wNZ4N/GiRQYmn/SBpuuvBapPnV8gkhDB7Qw3iNAHGsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xv1EbBJD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArpdCofy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xv1EbBJD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArpdCofy"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AA0E3EC0321;
	Tue, 10 Feb 2026 09:12:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Feb 2026 09:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770732755;
	 x=1770819155; bh=O/7VNK4BIyEHKedgPU4tNAT6xPtmLxp4xnzOsT1X5eM=; b=
	Xv1EbBJD3acmn90d0SgnfYWnsXf8k/IHBg3A9P1XtaGjlYO78be/auRsGB2VDzMd
	D6PQZp9Hhm1PANSZ1qWuBE8xpRZixgs1m6dvtYUCIeff/CO6inkdNZY/2bTLW5NR
	NtjO7IMtqofReQI3FeLwKv4XC1iBu1x+opuufmRdg+mXDDQ9bCHw+nj3OZ5Bem3/
	M5N6TWHQAzYCfmhNwsdnfpY3g94hPkC2MiKJnqXyNTThaXjCnserTVjOSNyjGUZy
	kgNr8vMszuk+w+qzLLBe2t6di5nh58nyrCIxWFqhWe1ugIzrL7WAu1ra4ZcwZtgs
	pgu1ZQ2Byf0UyWRNzl0xwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770732755; x=
	1770819155; bh=O/7VNK4BIyEHKedgPU4tNAT6xPtmLxp4xnzOsT1X5eM=; b=A
	rpdCofyNdKVIwfp90zl6ISGwEfVgUhYBfpCmR1flkdCS9Rxohg/SXYFhXqM4wL4N
	5lIdB7xf0qjRU/lAFs82CHlwwVR/nM0io3HGfDeZCpKRcONkOKiCM5resSrNXBH6
	I1d8bOYyonBvEIRRMI4RTWFy4hf2LmI1LQMK+lQgm0e8C6Dgy++VECK6TpfCs0As
	vGZ9pSHtRsZAYjdwz22CNCGG7pqxKgRqlLUhnBQWZ+gfzzPzswIO/e/YHMxKBLDw
	hght9QxujWMudlKwdvlVrKnfzETi2KQp10n3MSGx+wvmujlIeQQkTV0WVNijDMp7
	8q9PtIgrBh90rtPHU59FQ==
X-ME-Sender: <xms:0zyLaXxHK-Gquxp6zvZxDxf8LnhxG4erq9eWywk_TY8W7k8oB1Npqw>
    <xme:0zyLaWSYJZPyj-ryAopgK09WoqSyUhGFmCyJfvl9K5c_D6CWrKkgiwaru89Ja4v6R
    8TGXN1VnxMJGm2DZaul0to2riwd7WX3GdMnvE-EHPCRwJEpRSEhrt0>
X-ME-Received: <xmr:0zyLaWXIBRCILJ_amCloC9xdPMFSyUnV8zEiV_P8oQt6eBkEh_DRdBiio6caVXE6RvMoPproklfgJsEALjyHVxDH8QslwBYGBWAoZgPSC1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfeehffegfeelgfeiudelheeuuefgieefve
    ejjeevleehtedvgeejgfekgeeugfdtnecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtsghovghgihesfigv
    sgdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0zyLaQYfvTCppk1vWWpx4CStAh3gwoDiiDe2bcbp3OwOH8-6iBpMNQ>
    <xmx:0zyLaU3PLiU0U9U2Oe8BejQbacwJghbMezouKppLdKgzfd7pdUGo4g>
    <xmx:0zyLaai_vxK6ETPAtUZHEuc6nJ_qzy-Iv2zLHYXNhbDbdxwD7M_gmw>
    <xmx:0zyLaQaeoCgPAzqvpREgfe_2icIVYTewnH9z7OnZ8rHT4OTfXLNAEg>
    <xmx:0zyLaWhvDtIp-3uw43YhpBndgqJtG4yIQMGuOefj3bU2PQLINCZhCy_t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 09:12:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7f73a0d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Feb 2026 14:12:32 +0000 (UTC)
Date: Tue, 10 Feb 2026 15:12:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] t4xxx: don't use iconv(1) without ICONV prereq
Message-ID: <aYs8zajWSixG8i3c@pks.im>
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
 <20260209-b4-pks-ci-msvc-iconv-fixes-v1-1-1e3167cd8828@pks.im>
 <xmqq4inp6bup.fsf@gitster.g>
 <20260210111401.GA27953@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210111401.GA27953@tb-raspi4>

On Tue, Feb 10, 2026 at 12:14:01PM +0100, Torsten Bögershausen wrote:
> On Mon, Feb 09, 2026 at 09:55:10AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > We've got a couple of tests that all use the iconv(1) executable to
> > > convert the encoding of a commit message. All of these tests are
> > > prepared to handle a missing ICONV prereq, in which case they will
> > > simply use UTF-8 encoding.
> > >
> > > But even if the ICONV prerequisite has failed we try to use the iconv(1)
> > > executable. But it's not a safe to assume that the executable exists in
> > > that case. And besides that, it's also unnecessary to use iconv(1) in
> > > the first place, as we would only use it to convert from UTF-8 to UTF-8,
> > > which should be equivalent to a no-op.
> > >
> > > Fix the issue and skip the call to iconv(1) in case the prerequisite is
> > > not set. This makes tests work on systems that don't have iconv at all.
> > >
> > > Note that arguably, it's even unsafe to assume that the iconv(1)
> > > executable exists only because Git has been built with support for it.
> > > A more wholistic approach would thus be to split up the ICONV prereq
> > > into two prereqs: one that tells us whether Git has been built with
> > > ICONV support, and one that tells us whether the iconv(1) executable
> > > exists. But that would lead to a bunch of changes throughout our tests,
> > > and for arguably negligible benefit.
> > >
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > >  t/t4041-diff-submodule-option.sh             | 8 ++++++--
> > >  t/t4059-diff-submodule-not-initialized.sh    | 8 ++++++--
> > >  t/t4060-diff-submodule-option-diff-format.sh | 8 ++++++--
> > >  3 files changed, 18 insertions(+), 6 deletions(-)
> > 
> > The repetition across three files look a bit disturbing X-<.

Yeah, agreed. I was wondering whether I should have another preparatory
commit that deduplicates the logic, but ultimately I cared more about
fixing the CI failures that we currrently face.

> > > diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> > > index 4d4aa1650f..4dd4954260 100755
> > > --- a/t/t4041-diff-submodule-option.sh
> > > +++ b/t/t4041-diff-submodule-option.sh
> > > @@ -37,8 +37,12 @@ add_file () {
> > >  			test_tick &&
> > >  			# "git commit -m" would break MinGW, as Windows refuse to pass
> > >  			# $test_encoding encoded parameter to git.
> > > -			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
> > > -			git -c "i18n.commitEncoding=$test_encoding" commit -F -
> > > +			message="Add $name ($added $name)" &&
> > > +			if test_have_prereq ICONV
> > > +			then
> > > +				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
> > > +			fi &&
> > > +			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -
> > 
> > This was a bit unexpected.  Do we give any guarantee to builds that
> > lack iconv support that "git -c i18n.commitEncoding=... commit" will
> > pass the payload verbatim?  

In case the ICONV prereq is false we set up "UTF-8" as test encoding.
And UTF-8 is also the default encoding that we also specify in case the
above configuration hasn't been set, see `get_commit_output_encoding()`.
So this would essentially be a no-op and is expected to behave the exact
same as if the configuration wasn't set.

> > I would have expected ICONV prerequisite is used on the whole
> > test_expect_success to exclude the tests that are affected, not at
> > such a low level.

The thing is that many of the tests are actually things that we really
want to test regardless of whether or not we have the ICONV prereq. They
aren't inherently specific to any specific encoding, even though we
_also_ verify that the encoding works as expected.

I didn't want to decrease test coverage, so I tried to only add ICONV
prerequisites where tests couldn't be trivially made to pass without the
binary.

> To my understanding there are 2 different things:
> - Does the platform have libiconv (which is linked into Git,
>    and handles the commit encoding)
> - Does the platform ship the iconv binary ?
>   It seems as if mingw has stopped to ship the iconv binary.
>   And as a result, Git for Windows is missing it, too.
> 
> (And if someone asks me: it probably makes sense to bring it back)
> 
> https://github.com/git-for-windows/git/issues/6083

Yeah, this change in GfW is indeed the root cause of the CI failures.
But even if the iconv binary were to come back I think it's somewhat
sensible to assume that the iconv(1) binary may not exist when built
with NO_ICONV. There might for example be platforms out there that have
no iconv support at all, and the patches in this series would help
those.

Thanks!

Patrick
