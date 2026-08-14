Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAF77081E
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669282; cv=none; b=n5hc0Ln9VAdOqdXNUOhvrcl6vj3kJekkFdzxu5wT3qimugxURAPVXFeTSapvRmeWYyvQKa9cmokkn7zyCLQImsenKA/eoZsPrg5nqFjbUefbSZdjfSLljXtTlEoQVmqeFVejVlJQqAnRpGtf1AYEXu8Mau7OP8gn1/kZbpePhMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669282; c=relaxed/simple;
	bh=McliH/nVAGytw9tKNM+VEf3pY/KFlU2Q7HRR1pwm+Vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l/BmEa/kU+mBGPh6zE6HEBzSE8KAAlNnBtYcmxpgi19u6Dbmhpsr2WZjFGg3RBfJViwHEZFzQg6hWFZdV5+x7fNRGtR8YbawRls4uWeo6GfYgKnSC4XBb3zutNiTPWnOIkkH0ejaAixPFiFklsE9eTafALCI+94IfdAL0cml2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iLZLbZ2o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YP4lgPQE; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iLZLbZ2o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YP4lgPQE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D7FE7A03F7;
	Thu, 13 Aug 2026 21:01:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 13 Aug 2026 21:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786669280;
	 x=1786755680; bh=ilN16FxdpHUGx2U+sOeGXIgReymjXK194oEZCb4OB3k=; b=
	iLZLbZ2oXp1jUFzmlpw6g0cX5XWXPARsqsIcGt9cfye5WzmKrdXbUmgb2UaU5iff
	6tyNv6mrhEzvGAvs9EojUS3X0cA9KhcI/rr4pgOeUBUhV70PsBRA2zspjDciWaML
	upK6yUXQ12TsUhH4dZWwX9JHHXSe4Fj8wfIenQFKuKRSvh0B0L17BDUPaZ3HNEdk
	PHljzwKRHKqjXF0wfMFeC52BQBNCHORCeghj67QMTrngBGrDgMbG/+XCD3FQlSTa
	m4/Olv/62l0O8G/Xb5rMVUAbTF00Gx73u8XfxatL1oR+obEdXugbDNF982WuemGh
	cHjVQJqeJ5+9Wpyzv60M3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786669280; x=
	1786755680; bh=ilN16FxdpHUGx2U+sOeGXIgReymjXK194oEZCb4OB3k=; b=Y
	P4lgPQEB6eNuc5cZZjrJvU6zHT3+OxMitguawiOSImTg9flkjAmlq50xPUIpj9j4
	bs35k79up8CE0z5OdzaV7wY5UNwgBfO18+BdMx4R/wAMRcEtOncU6T9Juq7BukJU
	HLd0f2uHHKSCzA5mJ6txzJqf/In/Bm82Ic4VAzbe4GscirzQ3+UujsEPpR72v9uu
	uTOeRE290JYrbC/3359YWbiXs9aHV5ClbqyLsOHXkELXTmi6gA5zHVEGQIe/Lw/O
	AouA475BqEtdTiWRBXfGs1McoA5nID8xtIWDbxs5ikkGnmzNNADFka7DeWKT6Dqq
	lQH5u7Z02gWfiN6Lyze7Q==
X-ME-Sender: <xms:32h-ahESLvusiOrUpoyZ7C6uoGSZNrpwgXkv446ikZ-B-z5fsTJx7Q>
    <xme:32h-aqA49rOm0cObVGDr6aVb3DzKqjKJJMNUFhSQTReZabPoiZXRcLdCdRXBR0cK-
    RtPbCv8JHGXvUfYnDA4Mehif8gRl6lraaRKzYGEjCxwZwP3dNlqtw>
X-ME-Received: <xmr:32h-as82-RI97e7JYQOBLZanotQ7nYqIh3hlGdNkO6Jevi4mdNYtSZZnmSwHpryeMzF4fkG6trNTQptRZQPIvZcqVaDYbI5ZPw>
X-ME-Proxy-Cause: dmFkZTEFByJTkIBTifrczh8nN0pzdn93Rs3D1V2CzI63YjS3ymjRYhLO/EPR1NjSy+MiDG
    LZyyCxXsoAMX2qIQelk1J/FqPHevct5h9r+6+3fs3ISKaC692dXsZ2JzIjjYLTTzSq9z8E
    chO1o6aNb0Votk3RQ6W9JkAcMlS8oliDkj8otbIjzOrVMDMi5b8PqXKfZ7uyC7LTYQFpaU
    sJRS0VFhNvN/0f4RJ8cCcQpohr64qgjfKaVtl9CGjQ/X9Orpe7RYuydouAl/LSxpo9V6Pd
    s7NZp0e+4KSxC0UWIc9GsKf1R5EPgWCRS3zb9AL7t4fIHoPbrl8FS6gxMyTSRzB0NK+RLu
    elRroajtjX9eGfm/HA6uA3nAMWgqsA03tpD7rWgrLX7jYVzmSvicH0v5UB2/PK5Ho3Rf7H
    jlQZM3FxHVklY9BVwOZtplVdRfDWQeJSlzhXOhFc0OmJqY+4KC0lo2c21cJJSs9/ZtR37p
    Puz1YDT9QRxEpoGm7mjipLCbw5otaKZKppoZEvmn+WJ+awM2Tv/fyJ3CbdhMD1qIWVUzYe
    +2VDk774WH8MnJmVQglYCpRSxGepXaVTzdPnuWn9GldgTSmrDS9mlROj8YHZnoF6iMu6TR
    oti+V7kzQ5c84yiB8MN9+lZ4Kajiokd7lfHRv/DqTeVNr4vkhquP1qKK68Sw
X-ME-Proxy: <xmx:32h-auC_G-hkXcV8afQ1KDGP3dICyMI0usqrAlrcY_WJpvtcogRfrA>
    <xmx:32h-apTBKUtmHQ4DNbwaXl0o7zxKYA3i3LL8hEKX1rreC3z0dgw7BQ>
    <xmx:32h-atuCUuDV2OnccHxkruvyR1OakwKkQNh3IfECMMYL6-mpSFss6Q>
    <xmx:32h-at3vnj4KcnN66p_aJWKk5MfPvul2x7FBoLmrAgiozrAndmazLw>
    <xmx:4Gh-asACWnnB5tANuHSHQBGf2yv46m4UGqSN434BGlGWN7vTyAYiOG4b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 21:01:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v3 2/2] doc: format-rev: use [synopsis] on code block
In-Reply-To: <V3_synopsis_block.b66@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 13 Aug 2026
	16:23:46 +0200")
References: <synopsis_block.af9@msgid.xyz>
	<V3_CV_synopsis_block.b64@msgid.xyz> <V3_synopsis_block.b66@msgid.xyz>
Date: Thu, 13 Aug 2026 18:01:18 -0700
Message-ID: <xmqqfr0hqzvl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> This code block uses the placeholder `<subject>`. Let’s highlight this
> placeholder properly by using the `synopsis` block definition which was
> introduced in a34d1d53 (doc: convert git-show to synopsis style,
> 2026-02-06).
>
> Yes, note that code blocks since commit a34d1d53 can, on synopsis-style
> docs like this one, be immediately preceded by `[synopsis]`, just like
> the command synopsis is:
>
>     [synopsis]
>     (EXPERIMENTAL!) git format-rev - [...]
>
> Cf. verse-style:
>
>     [verse]
>     'git name-rev' [...]
>
> Acked-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

Has this been tested with both AsciiDoc and AsciiDoctor?

  https://github.com/git/git/actions/runs/31751206776/job/94617158587#step:4:4886

Curiously, it does not fail for me locally (by default my builds use
AsciiDoctor).
