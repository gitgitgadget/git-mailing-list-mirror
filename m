Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D08150981
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996800; cv=none; b=tYQegVx1/oOPnOVK47wwediVUrWIsUEaImzcnUiw4zoZawkYxAmaFvFLkYTfhukTqDSwophenVdwlC+y6KCs7FMrK0uEJnzCx6UgI/ggGtVG49HwDil0FI+TiK4O0Gp1LDNs3mVvQhF5Sv66uKphNacl1vmTWdR323ngMxfhs40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996800; c=relaxed/simple;
	bh=pi0MwVeE7NaGr+raRzzDg1FVVNlp+ABbipFeZlVLUvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db7lN838bmrrCTEP/nwj+ZawG6VzENdinTlxeaBe7U1xqIFbahxVwoxsmcp+hGY1shwBLcaHP0cXbtKPJrED+qO6zoQUqQIXjH6ITPlyi9axjNhZiz4l0rD+vlbEyrAwp5ugwkZoDotRVOBkrT7yXnUm5Y3dNtVcec7suom62+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E+vwiDGr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cEcXwhvO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E+vwiDGr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cEcXwhvO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 91E2B13804D9;
	Tue, 19 Nov 2024 01:13:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 19 Nov 2024 01:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731996795; x=1732083195; bh=uAb0Ru0PpG
	/gAWBvV0J+KBtvLDupBHfKRks0TddcfM0=; b=E+vwiDGrDsmsmS9F8TxxNQY+02
	UNlRG1qU+zvlSsbCXLe+k8khqH+hCAGFXFuJvw4e6apsKRfF7hCQuZ8HgvrmGxi4
	BzlA9kBswW8T3RKQo4Hzxf7YBpmxCS6a/aOL5LevM4n9zIf3Z0mNOIOM56nXfBK0
	wiO3pfObBpY6Odr9bpHe6TWHWjiv85L1jpqNRBGlTU/Pldf/AJyGvydLh4BwZWVI
	Q/PnQJ+GcYHVxky0ipGtTq6Q2r2R1rhA0A3rIeMTLz5naWQVqiIG1z8bgUsuCP18
	ulxkbxw3drlgT6XYyL0SdV0Dw2q8X8ihUJSsZP5gpZmcUmAsCOh/YA7AzL4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731996795; x=1732083195; bh=uAb0Ru0PpG/gAWBvV0J+KBtvLDupBHfKRks
	0TddcfM0=; b=cEcXwhvOXNMFc4WOo4kVSiNZXbO7R8484tuoX9mKatGTtoo21DC
	Ac3Lz/cIy4nwE3LqhD3jaUJ6F9XOv8wcK0EiJngL9F3sDBW/W2G1QN+mbJYAQKXD
	gwao6o4OG/tuQXbQNvq7RFwe/p8Odbc63nwdbsltVh18U7lcMHL8lxlcQ3OQSOAm
	Zzz5r1TYwvVIyEnbyyTHgYecZRcCxQVaiSnrjM4g6BJ52yoe1agMNHlRSGotgus1
	AB6khF2OOuqX5Qk6Qv0FG3IZ+ABckk3z0rQLn6u1vqz1PiBi0F11JwZc5c7ep+LF
	6qbmfcNlMDOlrpPFi4jphn3cHv3Trh64mmA==
X-ME-Sender: <xms:eyw8Z-cxrI4QyHeLxgNMf6kv5S7CyvtrQonnqJF6roZ7GJP_dpULzw>
    <xme:eyw8Z4PlEA-cklx5K5Kkm8e56WNl9C1uomfQ2t5R-z9p6bQDgi-QgC1nYY6u4sG79
    AmSEU4F9ZK2ohMFvQ>
X-ME-Received: <xmr:eyw8Z_jCib54Agr8aSHxo5msN7wSTBI-km3awj9N4VGCYCHpWHhVN5SwjXDn2xwsuMAiBgbQKZvkkKra4ro-7cb_XZZ_BYSyUSE8g0tp59OBAxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:eyw8Z78_VveGVfhWC4eLFT93bCs7FdskDF2x6TPRMATK_DHyz2xlYg>
    <xmx:eyw8Z6uCVm9XAKPpxcbMLokd_PhZ6N2_ouNdkrkjJnxS8NrlH2XyEw>
    <xmx:eyw8ZyHhxWEx33U0A0V8AtbhuosFN4dQfNPi_17WEPCcxsvJBgbadg>
    <xmx:eyw8Z5MSjgRTPdaafuJ9L7wFuaCLpn7KuQGOSYSfHxKpW9YUmDKXCg>
    <xmx:eyw8Z8XUrB48n41XBT8-UfGFuGGS3iY_X1Ca2qhY721Ual7ZntM5tKY3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 01:13:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5305bc92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 06:12:21 +0000 (UTC)
Date: Tue, 19 Nov 2024 07:13:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] cmake: use SH_EXE to execute clar scripts
Message-ID: <ZzwsZfNgJck3V45F@pks.im>
References: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
 <20241115-pks-clar-build-improvements-v3-2-29672bf65ec6@pks.im>
 <j5dohg2u5vguiffj3dkqimach725ca2yhyzu4cookd6gvjoav2@qizyg7mazhyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j5dohg2u5vguiffj3dkqimach725ca2yhyzu4cookd6gvjoav2@qizyg7mazhyz>

On Mon, Nov 18, 2024 at 12:47:32PM -0600, Justin Tobler wrote:
> On 24/11/15 08:32AM, Patrick Steinhardt wrote:
> > In 30bf9f0aaa (cmake: set up proper dependencies for generated clar
> > headers, 2024-10-21), we have deduplicated the logic to generate our
> > clar headers by reusing the same scripts that our Makefile does. Despite
> > the deduplication, this refactoring also made us rebuild the headers in
> > case the source files change, which didn't happen previously.
> > 
> > The commit also introduced an issue though: we execute the scripts
> > directly, so when the host does not have "/bin/sh" available they will
> > fail. This is for example the case on Windows when importing the CMake
> > project into Microsoft Visual Studio.
> > 
> > Address the issue by invoking the scripts with `SH_EXE`, which contains
> > the discovered path of the shell interpreter.
> > 
> > While at it, wrap the overly long lines in the CMake build instructions.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  contrib/buildsystems/CMakeLists.txt | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> > index da99dc3087a218d30e0fd1044567d7148d0d80a9..2db80b7cc3c6aba840f18ffdc78d2cda1877d8cd 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -1005,10 +1005,13 @@ parse_makefile_for_scripts(clar_test_SUITES "CLAR_TEST_SUITES" "")
> >  list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
> >  list(TRANSFORM clar_test_SUITES APPEND ".c")
> >  add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> > -	COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
> > -	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
> > +	COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh
> 
> In the previous patch we used `${SHELL_PATH}` to execute the
> "generate-clar-suites.sh". Here we use `${SH_EXE}` to execute
> "generate-clar-decls.sh". From my understanding this is done to help
> discover the shell on different platforms. Naive question, would this
> also be useful in the former patch?

Yes, it would. I decided to bundle the use of SH_EXE in our CMake build
instructions into a single patch though, which is the third patch, so
that I don't have to explain the change twice.

Patrick
