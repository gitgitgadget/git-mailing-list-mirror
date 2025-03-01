Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677651519BE
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740853232; cv=none; b=WHyxlg+NN0AyTlVxh8xmmjyp2K24Dwy3WcIyrOPRYwQYShfhRMNDbpi2olp9BcpNosr/jUudMrDRrQDvWmCjiTWqGC5vgq+gWp/k/OTGzakMDOZOqhLtU4lZi67/39b1c1e2Y6krloBFd4EveUqzWEJ11AY7rgblZnAfG1QKx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740853232; c=relaxed/simple;
	bh=IC/rW+7C9Q9b5P5gucDd8JW/pvYSrZP8LiXQOzdx/k8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nenxsv+J65fDJLjQNE5jUh7yIpD2GLbpiTcac5B+vJKH9CdI2T/GgHnGHKX75xwRy3G2Ka8vf3uZoKtJCWM0tQLiEPcJDGozQfl2g6WD/hpuHxzHOB2DksqD+ztfLAf+CSirD6E5VbOd/rPHjRPGMqMwI1RE8U+Ca6gvOB+tbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XKwFCA5p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jGYEXk6J; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XKwFCA5p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jGYEXk6J"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 70F17138113F;
	Sat,  1 Mar 2025 13:20:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 01 Mar 2025 13:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740853229; x=1740939629; bh=FYNQmFelxJ
	j6NEamYT3WxNc75mcT6pcIQ0qKwgNh1/Y=; b=XKwFCA5pgOky3rETBrFUrxl/I5
	DbVrlIczC6Ocl4xqRZfgF43lciyT5KAKjt6YW+x4cHOuhglKcB1Hs3WNNnEVqO+G
	NN2e0XU5lqSXYGFlgQNvWABJUxUEMr+0ZIJw0jvzV/N3vn2Jc02XpUoAvhiVtgkR
	mpQK0TAe3fA0h2wvuqP4BnXxVVElsRnzeWwoop5z4B8prPa1teYF9Jjp+okDHvvx
	UfCu02KTbQ2eLsESGXOm7xoreoMnUX80Do+Bg82r0q6wUVJbyVpCJEblJBfefIi/
	ZMp6DWm8qoy+JW0sFU1u6OE0lni6cO4989mYyFMvIfiEoaN9UFK0EjOrPDhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740853229; x=1740939629; bh=FYNQmFelxJj6NEamYT3WxNc75mcT6pcIQ0q
	KwgNh1/Y=; b=jGYEXk6Jgo7lCRpl5UZ66YwiWMQhfagQhriv/u+9SpnrxiC/9ZO
	dewgUGbO3WUcKCTgCs1Pq3xjvaQ7whsOBs56/GhViCTZkEQUhfYjMLZCao+gy7dR
	k528rq4IUNUQG/DMXRWDVuKWFOj5EtwAbOhROU9NFnafi8OSlIwIC6qQ/dAv7BXR
	GaxKsQZGqKk56pDOtvlm6h7QN/y7abiOIsbfuqoRjdcn84pdeGW6BH2YgRvq+e2V
	XqxzVxy9ayiloc4Qs8m4DEwoGnEalWGfj5U9A3FFhCYbIvr8rToXIIfi1suP7A7S
	D4wHvCTm199Ap0XK/FKwk6q6grX2UI7TAOg==
X-ME-Sender: <xms:7U_DZ8nrObSKE3ODi2K6o-eIz6YgWDI72CDADy5w5Bf0jtRCjXvlww>
    <xme:7U_DZ70WwrmIOQqI5U9mlWnNs0vZeflOIZ3FtR5BO-jngYxMBNYLcEK6iRKaV7cmp
    -naWLBFwhHNiTCAIQ>
X-ME-Received: <xmr:7U_DZ6rUrUtFSdrlzCRcNZAW7oDIrRHjiri8KB-6vPbW3z1jtwLTW6nBe7GiId-r0RkoXJJ3aPLSxC8NTb_-mEU9ImNk2D9rFjz7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelgedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeevleelhffgudfgtefgueetgedvffevgfev
    tefgteehgeekhfefueeviefghfegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    ehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7U_DZ4m0ryPVm0bMst2zhK9dcwjLakVXdfZpR29drSgOMFOF0iPQiw>
    <xmx:7U_DZ624kobYDn_YGxQVDNtoa97MCBbREBv2hcwv-MbKxE2gI9W-WA>
    <xmx:7U_DZ_urxuRH7gbUJedK-eUprq1Q2njDAVSyYqR0yLpsqb7bhntrqg>
    <xmx:7U_DZ2VNHI-dB2xudqkUsQlQa8Mos69EWHRvX0WmnJBF2bpFdM0iag>
    <xmx:7U_DZ29P4AYNgIZ0wcLhri1a7aLRDDwBRylF6EmF5zl6oT_NulxVHFLe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Mar 2025 13:20:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/3] doc: txt -> adoc fixes
In-Reply-To: <20250301153607.95746-1-tmz@pobox.com> (Todd Zullinger's message
	of "Sat, 1 Mar 2025 10:36:01 -0500")
References: <20250301153607.95746-1-tmz@pobox.com>
Date: Sat, 01 Mar 2025 10:20:27 -0800
Message-ID: <xmqqh64czk7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> This series is now based on ps/meson-contrib-bits.
>
> Changes in v2:
>   - build on ps/meson-contrib-bits
>   - include changes to contrib/contacts/meson.build
>
> v1: https://lore.kernel.org/git/20250228034713.203461-1-tmz@pobox.com/
> CI: https://github.com/tmzullinger/git/actions/runs/13605720163
>
> Todd Zullinger (3):
>   doc: update howto-index.sh for .adoc extensions
>   contrib/contacts: rename .txt to .adoc
>   contrib/subtree: rename .txt to .adoc
>
>  Documentation/howto/howto-index.sh                 | 14 +++++++-------
>  contrib/contacts/Makefile                          |  2 +-
>  .../{git-contacts.txt => git-contacts.adoc}        |  0
>  contrib/contacts/meson.build                       |  4 ++--
>  contrib/subtree/Makefile                           |  2 +-
>  .../subtree/{git-subtree.txt => git-subtree.adoc}  |  0
>  contrib/subtree/meson.build                        |  4 ++--
>  7 files changed, 13 insertions(+), 13 deletions(-)
>  rename contrib/contacts/{git-contacts.txt => git-contacts.adoc} (100%)
>  rename contrib/subtree/{git-subtree.txt => git-subtree.adoc} (100%)

There still are references to .txt in Documentation/build-docdep.perl
and I wonder if we should also address it?

I know for recent builds Documentation/doc.dep seems to be empty
after a build, while the file is full of lines after building older
releases like Git 2.48.1.
