Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E163FE7
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921690; cv=none; b=BDE+Hja8fOfyYEarlZPPCHlG3FIstrubNU1THwdsmNf2MhsbTJiZ02fZvxLue5kzLIgpEoiLUFf63T7ZDGv1J3LxyEPVe8CVki9FnUX2SWD+63P+k0ZaRFc+yLEDRQBqMZTIU9MimMSVgShMasmg0ECrbCt7lEMffYgA9PNsIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921690; c=relaxed/simple;
	bh=+Sv0xFcsJ2LdijijlVV+kHRSPYZYcgDanCrPhmYblQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwjZnxuE2b6NjwGromx3gbglb4jNdjCXQ//cXFB5KhLrYddBct/sphHpPiiyMphC/DC6ntokimKSZ/1UUagVZi9VoCcGme/glNRnWuOwWMIPkgAYxU+QXTE69q1VdcvOn0jr/iAbn92D4C3fzvz+JuQMGuId3ZtRLgCRqrVcXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WWQLhmaI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jYCngWGr; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WWQLhmaI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jYCngWGr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 57EC01D000DC;
	Fri, 26 Sep 2025 17:21:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 26 Sep 2025 17:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758921687; x=1759008087; bh=Q0WJbIwuK3
	UFQxjazEvlhp0xKX6AQewaLMaqIihRY90=; b=WWQLhmaISEtnyGI98aTD6yuy4Y
	S/o5rcX+6183C4B8yw3D2D4H7gkUOWrOBUzLP0Ag/1qT2MKKrh6aicvLJiB+3gtS
	Qs1ffUz5q5eSlLd9hkqMSnP5RuZEXhk1z3LUJWocicvWHdsN+ijqtqYcrDhXeZa5
	ntrWGNUUJg/OBRZG4a1shsUv5jxKF8ghFHH2A41BZ0EcDTUAqTfL04XRt4meK9m+
	805d4k9eiKANXmSt59gZVouOqfb3zsawTf5Oaui9w+OYBaCaZFFofuzwoJj4CwY7
	XjxgPAiuzqIeScNiH/ENrV2e2M6WMj0z+4lIJFMPZcS64lDr92AH95Fi5OlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758921687; x=1759008087; bh=Q0WJbIwuK3UFQxjazEvlhp0xKX6AQewaLMa
	qIihRY90=; b=jYCngWGrj1HB6Kc7WhBvoYRcNd9PJXl323EljFVMUBG+50sx6tq
	XmMbqwNSdCW2fxt+1u+ofGPxXtJAPfdJp720fkcAZ1RU3O7maXNP7/U8R/rhlYMT
	Efi+Y9gaEgRoyB5nkhARwx3c8tDkSptSFgHMOaeaOU4+BdS58s4LU1MWtw8jVfl3
	bgILicxHZDeIe+TYrsvQblES7lJyRoJSRXAzlso/qiKhDnVEhROGVFD9MUs3OcQY
	6JcpVR5FfqUBfW9MyEBxEaI+UX5jl1vKcRyfTI+3/n5ZSkrIx2sWbosbM4LlSb2L
	XrrHw8pOGXxGZH2/Efd/jonZF/q7T53t7iw==
X-ME-Sender: <xms:1gPXaN4XXZqZiOun46R-PfaNbPf6QPz8Oo2x8APmM9H1e15XRwIuyg>
    <xme:1gPXaMbHXWd_vYqB45jdDGnn3BlKJwE-ezcUDnFXe5dBO5VGwEoonDeaZJXyXaPlg
    yLRgAnXHEisPlsaupwLGT5CE6f0I8rmUDc6ba0t01xRxNI14_3T>
X-ME-Received: <xmr:1gPXaEiwB1hm3OHYhlDuirhSet82inOlJ-0ypJN5ihojuqhw52aOOaryjrCSIA1-_UcfSEuUyCCL4ldMTwVcIIIOnj-T4lznAszO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtdeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1gPXaF8YA1rIHKCv3u42B7c3nlAZtM_5jITQx12GoempteBpfxHuvw>
    <xmx:1gPXaHoCBEvRHvzchmFjj0ElHbTfMYVpZxWiB6NWNsLqBQHonjR0dg>
    <xmx:1gPXaFXr15ZTKJrQE5kkJGSQaUSj9EufpfxWw0LAyS9OHA0UjEZUQA>
    <xmx:1gPXaODrfCgN5ju2Ao3gJ6G8eLOs-F4-qhNGDEEzWkbR1TYcEfvhew>
    <xmx:1wPXaCPs-29mUn-YuxFd77dPkzH4QAVe_BXbaa0WGKQPWdfxMPC-zOd0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 17:21:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 4/4] doc: commit-graph.adoc: fix up some formatting
In-Reply-To: <c8e40336-0a16-4da9-b251-d166f80ffeb3@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 26 Sep 2025 19:11:57 +0100")
References: <875fb7a0-6dd9-412b-a34a-21758c339871@ramsayjones.plus.com>
	<xmqqfrc9citl.fsf@gitster.g>
	<c8e40336-0a16-4da9-b251-d166f80ffeb3@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 14:21:24 -0700
Message-ID: <xmqqwm5kap0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I tried searching the web for the answer, without success, so went with
> the 'prefix' style used here. However, when I read the above, it made me
> look at out current docs and gitworkflows.adoc showed me I should have
> used an '~' character instead.
>
> I just tried this and it works great (apart from having to \-quote the
> '{' and '}' characters in one title), so a revised 'diff' is given below.

Oy.  It is one of the special things I am unsure about---would a
character used for such quoting (e.g., backslash in this case) count
as one display space to count the number of underlying characters?

That is, which one of these do AsciiDoc and Asciidoctor want?

    Deleting graph-\{hash\} files
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Deleting graph-\{hash\} files
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~--

There is

    OPTIONS[[OPTIONS]]
    ------------------

that appears in MyFirstContribution.adoc (even though that is an
illustration of what you would write in the source and never used),
and

    `builtin_objectmode`
    ~~~~~~~~~~~~~~~~~~~~

that appears in gitattributes.adoc (this one is rendered), so I've
been assuming that these characters necessary for mark-up do count.

I guess this is the same "prefix is easier to write, underling is
harder to write correctly" theme?  If we know which one is correct
and can use the correct version, then I do prefer the underlined
form.

Thanks.

