Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451171B960
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751044; cv=none; b=ZI+8Ofbcwp2HmTThW2VZQKhJOJA10b4ulLClgmAzjefYsJKpdQ9hP8oCby9X+e9H2a1Buyb0Sc3IZ8WO0CBPfmZJYhys4gbNlQbwtlDdhmdXSpL/jHaCfKwqeEJnoPCf0G0KwVqodIzEgiO7rjvPozcpOrkswg5HhoBJPiTWj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751044; c=relaxed/simple;
	bh=Tpv90zRGB1jqwQaOCPway4d+VcUw4WK+MQhuICxq6hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyFpyhfI/rRkKnKpGD74uTPdHoMdUGlUtX6jtrbUv8Pc3X07T7o1n7kITG9l4vyC55Pko9wKvrt6yeXRQ73yWO4GyvXCMn0aQCXtlA2MuEXtVFHW8nNV1yOtISMH68venf3yMOOWau+v6mepKtqgaY+KBm8nBl5gStmUbF27rQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a4PfCkZx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rGGPS0qi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a4PfCkZx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rGGPS0qi"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5781111400EE;
	Fri, 28 Feb 2025 08:57:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 28 Feb 2025 08:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740751041; x=1740837441; bh=DeEFwDdFfv
	hBRG86/tdkxKtbblrxEceqwNWQW8ltjdU=; b=a4PfCkZxW5KqlXNtXkx8A4/E/e
	wBA52G14Mgkf787JcaS0W9PFuGvBIvhoFIQ/6e1Yb9EM3+GkSIWjLXd5z+HAzs7T
	k1g8d3F9gVX0AnJynPlr7H+aQZbfvD4GBdaBHi/3m/R8Y4J3NnzE+Ne8DfU4tRaj
	RW58595ekUEWjOijFluAvWGX8a80oifS9jbpP7BdOpEp1VJBjjLQNX87F43PAld9
	+ztiE52Yxw9rIcyBaC9ZVMNkBWZmUaWgbL9dX2eEMnJMtwx+5KN3MnBtINd1hu3t
	CdQLFb/CBP6Qts/sMqgiQg0aMFPQf1wD61smxWSLsVH5C1dvEpOMovjPVlBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740751041; x=1740837441; bh=DeEFwDdFfvhBRG86/tdkxKtbblrxEceqwNW
	QW8ltjdU=; b=rGGPS0qieJiFIRigpGSfPz52anKTDMqHrejdwXXFNmPq3OcRo+1
	JnWPT7/AZsil8+ClF/ljHG1tZZDLuhb3ybOccwI5lUVGOV6tGajVcEy4PST1yOPV
	oSeiBKFGomalY0sgMBANbnIlKxGstIulkhMMEco8GHndZ2KNT7u+papuI3xdgJhD
	JGBQpGWLnA79fSV2KPZOj+YHfxuFfGpWIwikG5m/YhZmnVpXDVdCFvz5Lyy1cpdL
	NsG00qLsWtU9cIrmaDYl8Oig0eV8nuTgu1tMA9hAjyv2g44rKM7IU6eDY8Dtq5Yy
	QCnrh9InJOc+v3VuOq7In2dw0EHYXIwGgAA==
X-ME-Sender: <xms:wMDBZyXoyv0Wiqu6UCDGwd49BFu1ECUKQQTby9feIwhPwZWFN-rY6g>
    <xme:wMDBZ-kxCLzA4XIMQDzJWYJtzbK4hFdjlQnV9o-aegz9mi6jSWoxspAptO6gZJyIf
    A2ijFrbhgsjWlMAHQ>
X-ME-Received: <xmr:wMDBZ2bugHSfnvxOl0QuQeNCr_BbAnxGz1f36Ru5GgP9p1bte_v2wxzxY4t0RjoUnJ6HM2Ke3CHipzRt004WUCawJqUYTYoEk5arCWFnu2cltppUV_Nz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgveefveeihfehhefhgeethfdvffehfeehueelheei
    ffeuvddvuefhveffiefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wMDBZ5WRAPB2qk6gX7XofN0eQHdRNchw5Kd-4R4o5EkJL9wC7FYy6g>
    <xmx:wMDBZ8meqVoOD8_3wJd06cBX1H4AdvCrFkAqmozzt30ja6gYjED2_A>
    <xmx:wMDBZ-fNEy-vvbAZzxkbmstu7TFQ1eVuGrnnQFQvFyjJ0UD-ygv7QQ>
    <xmx:wMDBZ-HG_WuTrWrg8tHb_Mqnt5VMN5TVwUh7nCnTli0-PG8YFaXKog>
    <xmx:wcDBZ9DwslyGynVPMFVDcJYSxerSmMhagG7kpoaV98TK8qX5_L6E75wF>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 08:57:20 -0500 (EST)
Date: Fri, 28 Feb 2025 08:57:19 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] contrib/contacts: rename .txt to .adoc
Message-ID: <Z8HAv5I1hoNiQYoa@teonanacatl.net>
References: <20250228034713.203461-1-tmz@pobox.com>
 <20250228034713.203461-3-tmz@pobox.com>
 <Z8FwIqnYYPk5bV7O@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8FwIqnYYPk5bV7O@pks.im>

Patrick Steinhardt wrote:
> On Thu, Feb 27, 2025 at 10:47:05PM -0500, Todd Zullinger wrote:
>> The .txt extensions were changed to .adoc in 1f010d6bdf (doc: use .adoc
>> extension for AsciiDoc files, 2025-01-20).
>> 
>> Do the same for contrib/contacts.
> 
> ef18273a2d9 (Merge branch 'ps/meson-contrib-bits' into next, 2025-02-27)
> wires up this thingy via Meson, so we'd also need the following change
> on top:
> 
> diff --git a/contrib/contacts/meson.build b/contrib/contacts/meson.build
> index 6ec92f47c43..73d82dfe52b 100644
> --- a/contrib/contacts/meson.build
> +++ b/contrib/contacts/meson.build
> @@ -16,7 +16,7 @@ if get_option('docs').contains('man')
>        '@INPUT@',
>      ],
>      depends: documentation_deps,
> -    input: 'git-contacts.txt',
> +    input: 'git-contacts.adoc',
>      output: 'git-contacts.xml',
>    )
>  
> @@ -47,7 +47,7 @@ if get_option('docs').contains('html')
>        '@INPUT@',
>      ],
>      depends: documentation_deps,
> -    input: 'git-contacts.txt',
> +    input: 'git-contacts.adoc',
>      output: 'git-contacts.html',
>      install: true,
>      install_dir: get_option('datadir') / 'doc/git-doc',

Since this is only in next and the first patch of the series
targets a "breakage" in 2.49.0-rc0, should I split the
latter commits into a separate series based on next or is
ef18273a2d9 likely to be merged into master before 2.49.0?

Whatever makes things easier for Junio is the goal. :)

Thanks,

-- 
Todd
