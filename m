Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8F610D
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757204518; cv=none; b=S6G7k2dSpXfUdoFX1rXWwDG0Ej6h3IGjHN92RaYYFiY2IGlrTKpCXm3WT6xp0wum1xmkawJ1GMuuwL02c0YJoN6OujRisBwgr/2EEIZLyO7UxxKp2v1A4r2YKQFGZJ8gQY9CWKK4ewiPNh0QcTvxJMxgqiP32sjQBGQIGEi7dAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757204518; c=relaxed/simple;
	bh=AWbdTwdwL0BPxCtvLdDFhWzr4bh2rU0b03E+aY5mZRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dZjKjyYclVnIkZuSEuF9Mcn/Srg2oX5ProZjM5RfwGQwuh1D8nBSQ4A8PiZIUpj+1v+5ywi4bZR7cmBdvqvVsO8K95RIvd7o7CjiJLVZ/YCc/T8WSS/4DiZ9mvmeykSv1DoqO94T2Xvm3EF7LXQvP5d3ziH9FLrm29MhL7DSlXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FbYcPUFu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CC9DhJL5; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FbYcPUFu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CC9DhJL5"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 96DBA1D0005F;
	Sat,  6 Sep 2025 20:21:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 06 Sep 2025 20:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757204513; x=1757290913; bh=RUHil8cFjg
	xSIZbQ5tXAn9UpxLRVSAs2lqB2HpqW/ws=; b=FbYcPUFui3mWzQ+BnAw8n7Qhen
	yanxhdYPZE9CsWv1G30lvkMsB2rLxXxYsxbdbZyAmzRupnawWalIXWe8zjXBlVax
	f7O+NMrwK0nR5m9ebyS2XOlKobrDN6BK/vXD3ONPjlpgsboYAt6ZJdiTc+t+bp5C
	EeybqCsVXolytmBtUSQs9wyXcRpcobX/FQEQpcXgVWHXnA7DviCFSe6oZL1AcQTy
	Bjeg1ZYIz6Sf9tPyRtyBiESpXW/iPKE4nHyfb7d79kf8/URlPA/41UzaLLTnEktb
	nbO34y8WpHgiKx4qYTrlAaP23ocQXasmwDWOpgidFbKDuwHsioCW03SyT6Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757204513; x=1757290913; bh=RUHil8cFjgxSIZbQ5tXAn9UpxLRVSAs2lqB
	2HpqW/ws=; b=CC9DhJL5vdYOMChRXmfrDVzpjR2B/aLZmwnDwSG9CGLOxq0nXPg
	yVfsc6pfWGEQUACQiSB2hCXb7YLzkAGxH9F3pcTM9IchCpAxQx3sdiK9p7RUhIW3
	JBaDeQAw6Vt1tcTZA1nsoD6YhzdpkDhw6HFbrHiBHmvlaytiftZXVHcCt1JkdGAQ
	z891mOQ42MhwdvtjmhbueDmRy3LjaRsklWlENjkH+FSzlsaORILvMw4pJhcNozXG
	eCwg2FPcqWG4II3gscccTEoty1IKsTNl53T4BvvzC/IzFuTWjN472z6bjpNJy26+
	Acj6jwOUUQb/V7GSWQZin1ErX1UMrQ1fuHQ==
X-ME-Sender: <xms:INC8aLYiKZHYOmXhDtJPEMSp4-P4OmaCuKuGSCZt8Gh5hd-ZjU2lFg>
    <xme:INC8aLC7XvjJBUvqZv_o1yiMeC9UD8_XsJbDRlLWe8BRUgzsGKwSOp5yRYfRfsMzK
    jgr05KB4uNPweRoQQ>
X-ME-Received: <xmr:INC8aJHZx9kU0gJEo9YZ9n-6cLrVrNLOYt7qduvLzz4Wo4obe4S1elo_pCKQ1UBInJl7dPGkCH_sozvTVwMQoxgCmM4aGqW9M521_z0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvdehie
    gsihhtrdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:INC8aGPz5rGuPeTS4ao-iiv_dZwR_i172mPe-okOWJa3ZvMafq4E7A>
    <xmx:INC8aKjy9yoJ_uU_ARRQFq2_sN6LgxXj4I-KiSF2k_QPaBSNcRx6pA>
    <xmx:INC8aG3JxoYWvAwmc_lGnhS8CMo1sguCCLZhDfQlSYS-v47YXfxDTQ>
    <xmx:INC8aHnvnREPDbbmiAv4NqJY2oJ857Qlmw8l0dbZe63mQXhdV60umA>
    <xmx:IdC8aPKDxMhqUYhnR5recuIMSWpa8cejBBDaag_3NaPh3rPsmZCecPVO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 20:21:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 6/7] ci: convert "pedantic" job into full build
 with breaking changes
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-6-6939cbf4a0b8@pks.im>
	(Patrick Steinhardt's message of "Fri, 05 Sep 2025 13:51:02 +0200")
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
	<20250905-b4-pks-rust-breaking-change-v2-6-6939cbf4a0b8@pks.im>
Date: Sat, 06 Sep 2025 17:21:50 -0700
Message-ID: <xmqqzfb7yuw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>  fedora-*|almalinux-*)
>  	dnf -yq update >/dev/null &&
> -	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> +	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null

This drops "make" and adds "meson ninja pkg-config".

https://github.com/git/git/actions/runs/17506343802/job/49765327830

seems to indicate that AlmaLinux is unable to find meson and ninja.

