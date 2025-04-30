Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A5B3B2A0
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040630; cv=none; b=puONomdfSInueElKLiff6LMeM0kNMaMAeoZ7OE7ZGQS2Kq7o7txH/9wpfqaBz1uszbYUOZNvN7Nt2Prf/uFQDqTj43pFKI3yFXs2fzSiL9abSqPni0oD3dgMoXzoJEMflECuahXhcQJi5HlWPk3Q8VHq24rXTLxwc3f94WkWg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040630; c=relaxed/simple;
	bh=rcOdQSvzwydQKDHJKhLKjcXw1j0yb5GFZTscMTWsZfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u+JxsfX7O7MwZv/ExiWMhjomBf3NkkTCxc1HDAJ6uSNr88Z9Hg8PITtOhS159UIuiX6SuFlVi3pWRt2K1wwIPbAqomBK2OBJzKczkIgY0LIFnpg3GiN/C8FiMf0jpc3+kS5niMezbH1abeMSVrcbK+8Z6eVzlDHCRLxIXH7mxvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TPz5i8Rv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w2p8ScwN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TPz5i8Rv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w2p8ScwN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8977025401FF;
	Wed, 30 Apr 2025 15:17:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 30 Apr 2025 15:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746040627;
	 x=1746127027; bh=NEOCs0iZHqpfuIe6mDLdtzI3xHbDFNF05pyOENf+qos=; b=
	TPz5i8RvIJyYCpVzFP78khUYfcVHijoI9BAJiZIJhucnj++Jgs3Ha/LEGtBmyAMw
	lAcrCfwEswXHtTqb1/SrUJB52rsCjyDErJ7v+Bux1GnbFb2D37sJlh2Qt2tARhsS
	NIXHwrKhFPxC3f7QOdD3t7cWVrXo8UFy2d0FAvjXT9WV5OVWUr+yIpq7gSim/Y7u
	GSbI7L0FABIlelBflmck2Sa1z04Ph0ThhaVuI0upPQZfmdaY5C9PwkwXpOSRNSzA
	VHVsjJpF+p4QQj10hYDoF2SgWOjb41LK2IXDtLccFqFzTQ5/ZENJeXsNef+6dXhE
	5e8+T9gxWCG/TipEtbH7fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746040627; x=
	1746127027; bh=NEOCs0iZHqpfuIe6mDLdtzI3xHbDFNF05pyOENf+qos=; b=w
	2p8ScwNvkCpfMHnzO5ktpaXTnu8FICaeKt8QIBJrMsyj1lJ32g2h6H6Ve4LSjkzQ
	iRrKEt6ZZ6dVvtiDLczYcmOZFqdf8Nm4tp8SQvR7R2L6ciLNWU1gh+joIMCb7lI+
	UVWAYRkgc33/dMTyl1UzcTzLy98mOy0WH1S86tA1zTT0BafYVS1MK/WUFfYIpYsc
	2i3Yo12PmzSZP2iAlmVYfL+rKlLqsi66y2rMPR5K+htNU7xJUgzVKSz+owLmP0Bk
	hzd3N/kO4qmP1Zzx8FzQfEAg8bzy/HxVUbxN9c6FQMw5nu6xMVoD8QB2tXiqGDIg
	aPKg1LjH8rLWnUtqCaaBA==
X-ME-Sender: <xms:MncSaF2qCxUlQf8jSORe-0W2hc7X9FnuvocMpP7p35U0BwNOBU5DnQ>
    <xme:MncSaMEzuWztBPfEtxKPCG7iKf3xMjvpBZwhOeB-dn6kSUMPWgWSnIPayGnslVM9i
    t94UKYibdkrgVbomg>
X-ME-Received: <xmr:MncSaF7HprrrTWZ4kDgTfDeLxsYN3IOxFPg3f3Z_izIOkriddJ4legVxz5ZSC6qYRCIF82kV2E8nXOFuNMoD_k47Ha1XlDN9xwP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehl
    ihhnohhjohhsshhfihguvghlrdhhrghuphhtsehunhhiqdhjvghnrgdruggvpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:M3cSaC3DrOO05Pw_Y-qumx2XAmCDVr3SAniqsnRMQSri54Mu0yQnlg>
    <xmx:M3cSaIFMqVfIuAd6PAvP9QhWN4HcWw9xal73sgsnOxadpcHnAEbeKg>
    <xmx:M3cSaD8VpFN0aN_pvnAf91o2N6H9V8jv6_WQoenpUT23b37wQE2vLw>
    <xmx:M3cSaFk3pbLmKMdpWPJFx9l_MYobuEzPZ6EO1j-4Ue1uAOOdnj1pbw>
    <xmx:M3cSaDklFMN1i9CwpZa84nsEo96qeHF-yiTnuEky5FIRzNVU9m7aYeOR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 15:17:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Lino Haupt" <linojossfidel.haupt@uni-jena.de>,  git@vger.kernel.org
Subject: Re: doc: git-clone: Improve discoverability of --no-single-branch flag
In-Reply-To: <057e8f72-ea67-432b-a687-2b5af08fba05@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 30 Apr 2025 18:49:46 +0200")
References: <fb842b0e-3666-4b78-bf00-c7d11a42dd25@uni-jena.de>
	<057e8f72-ea67-432b-a687-2b5af08fba05@app.fastmail.com>
Date: Wed, 30 Apr 2025 12:17:05 -0700
Message-ID: <xmqqcyct1mtq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Many options are documented as `--[no-]`.
>
>     git grep --fixed-string -- '--[no-]' Documentation/ ':(exclude)Documentation/RelNotes/'
>
> This is explained in gitcli(7), “Enhanced Option Parser” (for some
> commands), “Negating options”:
>
>        Options with long option names can be negated by prefixing
>        --no-. For example, git branch has the option --track which is on
>        by default. You can use --no-track to override that
>        behaviour. The same goes for --color and --no-color.
>
> A concern might be that changing `--single-branch` in this way would be
> inconsistent with the overall style.

A pair of quick counts:

    $ git grep -E -e '^`?--no-' Documentation/ | wc -l
    189
    $ git grep -E -e '^`?--\[no-\]' Documentation/ | wc -l
    80

I think we should try to unify to the following style:

    `--frotz=<string>`::
    `--no-frotz`::
	When `--frotz` is given, the command does THIS using the
        given argument <string> IN THIS WAY.  The default is not to
        to THIS, unless SUCH AND SUCH CONDITION, in which case THAT
        is used implicitly as <string>.  To disable THIS even when
        SUCH AND SUCH CONDITION is met, use `--no-frotz`.

That is:

 * Both positive and negative form are given separately as a
   headline item, so that "grep" would work well;

 * The description should be unified, so that it is clear to readers
   what happens when the positive form is given, when the negative
   form is given, and when neither is given.

 * Mark-up the text that the users MUST input literally inside a
   pair of backquotes.

Which means that existing "--[no-]opt::" heading should become two
lines, "`--opt`::" and "`--no-opt`::".

Thanks.
