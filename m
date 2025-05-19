Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BF2AEE9
	for <git@vger.kernel.org>; Mon, 19 May 2025 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747680487; cv=none; b=MNJAo8ny5rdcyD6mm9fKNxyZK/gcgYJoVXxMZsn7Zlkl8HVewlCf9jutynkoyi1a+XKKnVih5HDaOyhdhknxnBRE8NQKC+BmBXg7DkzXv/52vyjxt9oqq0lFmnV5A9E/ukSeh0c8BkEb3HMAIIEpgqMMUKw8jb3A5ZzbloDNXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747680487; c=relaxed/simple;
	bh=KRbbxFfdQ0jSFTzHok6qUoGClkJiLRAQiKUR47xoomw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jZa5U0v5KfVPJf5N4tF+2OvUfbCTr9ms7+/ycA6VBZuRhw/by6IyP0YIB2BvaiHOrzGn5D5H+gMWFxatsY2w8Ny6EkAGjfWEtbAR9uk7VKGFsKu1vH6dC7U0fm/tI4UvAL3beifzbEWuRLnnuGBYPsKl1NmzqtZou8BQNdLsJBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JejiNIaj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=deP30k0t; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JejiNIaj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="deP30k0t"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6996E11400D9;
	Mon, 19 May 2025 14:48:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 19 May 2025 14:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747680483; x=1747766883; bh=2E+lmiWxe/
	LUo6s474oNq3bK202ga/FsTo2gPxFQHkQ=; b=JejiNIaj/xKy7Cyyc5OQjxXn6h
	TrJxGOeqak67ODyVoAs12AhzvY5TiowfWomcl7d87gL2DuDvd1QDnmN7nl97LZh4
	FiAX2wVbfv+0czjQ8RaItXxfZPC0l2Td0xP+2ksh6Sldpo4U5X/265duqE0s7wQL
	TBRnInyxATsmYxXznpahO0sK5o3143mb5sDjKYqR1ZygkcUE++Iw8/OEDi8t7Jkk
	gwGzxXcHOytJPSWX1Vzw9DHvCr2CDSMput/BeZJa4x8qMlstRZZqhONyvxnlR0I+
	nUZaWg7dBqU8IZAhmSZ0EhmeepKP/QEZ5zqt6Da9hojIa/ASh2+OA4JDzmsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747680483; x=1747766883; bh=2E+lmiWxe/LUo6s474oNq3bK202ga/FsTo2
	gPxFQHkQ=; b=deP30k0t237Dz52xdcArRGhwI2TdUIAVTjhkhTaFFPJQjC8zDCi
	zTZKI6pgNOu0l19a1/m1os6HsV6Q1nTNV1+wEqVH9ICG0ByWV/KzKS3BhpHhwD3r
	jiMPIk0qD1S8DafJ89EbwW65KqrzD7MoBgfPrQy2/azpJRrOuQ5vOQeRc4ZIlh+0
	zpGlHEs2QYET5UeI0/NsdnxUnWyYA4vP6k85JtkZxZmapDHBAij7mnOT21fQDdPF
	3+EhNiQNZRwDa4MdZX71oG3lYYlNTy2yun0dxC6RWudSM6ojav/uhZKvg9PHjs3S
	8D7AWFTgACzZ8kubL1Ua5xHAYqia52w9HVw==
X-ME-Sender: <xms:4nwraHdrPXwAfZxtS_dTh92Ndy1X6IYOt-8B_D4KTTVS_ksUheQKCw>
    <xme:4nwraNPHXaB-Wgn2hbT2kabMzr_vdAYElb1vbG8JIZzR-ZvFUr4kWNDlSAvTNSRrB
    AAwetffkh3_VSi0lg>
X-ME-Received: <xmr:4nwraAj_WbHZjHU-GqZ8Bvt_V7Qcd7j4FjFMPwfseZRWhYuouHGW8GOOR1-01iL6h4HRTMjwiWGwSAWgswTAmbpchbu-QjTCJMW-3jE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhs
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhht
    ohhordhorhhgpdhrtghpthhtoheptghonhhguggrnhhhqhigsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:43wraI8ytq51U0QvUpGF6sQVfC-S1wF0__ye-Yv4EAJh3OLuuKphyg>
    <xmx:43wraDvFF-_notBCP55X6F6ABC4Nhb3do1s5wReqrv1zdnnYQvqB1g>
    <xmx:43wraHGYnKUj8pM3IhAqxHCSQlOlUcBH_JAOZ_CVF8cCeJziM60R6Q>
    <xmx:43wraKP_ay0uU7iURGEivmq9BHLAd3kEzG5eIECEPsgDc0APGiW5Bw>
    <xmx:43wraC7cPJ0sOxnAYY-P-nCtbkU0Yovo9XUGImY-eh4337UOi52pd_0X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 14:48:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Eli Schwartz <eschwartz@gentoo.org>,  =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?=
 =?utf-8?B?Zw==?= Danh
 <congdanhqx@gmail.com>
Subject: Re: [PATCH v4 0/5] miscellaneous build mods (part 2)
In-Reply-To: <20250519162523.1001478-1-ramsay@ramsayjones.plus.com> (Ramsay
	Jones's message of "Mon, 19 May 2025 17:25:18 +0100")
References: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
	<20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
Date: Mon, 19 May 2025 11:48:01 -0700
Message-ID: <xmqqo6vomo7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Again, I did a test merge to master@cb96e1697a, next@a128411c76
> and seen@df1b4f9cf9. The conflict which showed up in v1 against
> the 'seen' branch now appears in the 'master' branch and has the
> same resolution as v1.

Thanks.

> A range-diff against v3 is given below.
>
> [+] https://lore.kernel.org/git/aCrekcz6onTFgEWw@pks.im/
>
> Changes in v3:
>
> Patch #3 changed as a result of Patrick's review [*]:
>
>  - use the '/' magic string operator when setting the
>    ETC_GIT{CONFIG,ATTRIBUTES} build options.
>  - add the default values to the 'description' fields
>    for the 'gitconfig' and 'gitattributes' option
>    definitions
>
> Also, Junio, the range-diff below shows the typo fixup, but
> you should find that it doesn't show for you this time. ;)

OK.  And changes in v4 are just that two redundant comments in the
option definitions are removed, which makes sense looking at the
discussion from the sidelines.

Will queue.  Are we done with this series by now?

> range-diff against v3:
>
> 1:  ac97fdc76e = 1:  247bc82c01 meson.build: quote the GITWEBDIR build configuration
> 2:  181738d371 = 2:  a87f683a95 meson: correct install location of YAML.pm
> 3:  1f4c74973c ! 3:  40ea59efca meson: correct path to system config/attribute files
>     @@ meson_options.txt: option('default_pager', type: 'string', value: 'less',
>      -  description: 'Path to the global git configuration file.')
>      -option('gitattributes', type: 'string', value: '/etc/gitattributes',
>      -  description: 'Path to the global git attributes file.')
>     -+option('gitconfig', type: 'string', # default 'etc/gitconfig'
>     ++option('gitconfig', type: 'string',
>      +  description: 'Path to the global git configuration file. (default: etc/gitconfig)')
>     -+option('gitattributes', type: 'string', # default 'etc/gitattributes'
>     ++option('gitattributes', type: 'string',
>      +  description: 'Path to the global git attributes file. (default: etc/gitattributes)')
>       option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
>         description: 'Environment used when spawning the pager')
> 4:  97ff1613f5 = 4:  a7d2f1e132 meson.build: correct setting of GIT_EXEC_PATH
> 5:  983488fe4e = 5:  a45b9dc650 configure.ac: upgrade to a compilation check for sysinfo
