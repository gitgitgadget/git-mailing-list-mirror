Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB284D11
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410131; cv=none; b=OcqASQTga84+Ubzbowe4bTifKe24OzGMZQeYeqVgP3hSnwOC+CgYOzafarrQDsIuwP1/8dmEAkRhgxuuKM6ewzVEaF3Yy7nNCFVD91X3PCrimQoBoGZfgrnhTzTPvFQBUZFx9zz8t/wXmJPernfuFuOWmmT/O7TZSvvea6WWS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410131; c=relaxed/simple;
	bh=twuZB12K7kLiQk1IFwhG1Qy9yJsVA1sOPs0/GJVJpbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GYjF8+3ef6h4kvh+daV6KIio569cuED62BZ+hFifQqN7gRkhOt4AYtnpNocn/2oqcdo0e+NRp0zBfJsSqB3kVvTjdjl0soelsoBVC9vj12gJ8Qk5twBDazh77nTPwcfR2YaOyaF0UAUoq0L8uwVuh2Wffx3k5cB5Jf9OK3OrcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PrvuSGPz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PrvuSGPz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0676F31E43;
	Mon, 25 Mar 2024 19:42:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=twuZB12K7kLi
	Qk1IFwhG1Qy9yJsVA1sOPs0/GJVJpbA=; b=PrvuSGPz8SaHe8zS473j7wrRstCQ
	CRPcXf7d+TMRyTpinGgGxLCeq4KhnezvwkcJFg8klbj+swzMZy/HqCdCfjzzx0Cf
	fy9e4pnBkdA0K5Mc/V7nlH3YAGkAalE5IkqwklmvaP7Y6C9q9gCIxG/ecL8SdIdG
	JZ3BcyWEOJtJsHQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F2D5331E42;
	Mon, 25 Mar 2024 19:42:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 464CE31E41;
	Mon, 25 Mar 2024 19:42:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] add-patch: introduce 'p' in interactive-patch
In-Reply-To: <8dc0218b-914d-4a12-8136-45c6d62162a6@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 26 Mar 2024 00:15:51 +0100")
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
	<fa64a975-40e4-40f2-bdcf-fd2da4fc506e@gmail.com>
	<xmqqcyrigfft.fsf@gitster.g>
	<8dc0218b-914d-4a12-8136-45c6d62162a6@gmail.com>
Date: Mon, 25 Mar 2024 16:42:04 -0700
Message-ID: <xmqq1q7xg9pv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 49EFDC26-EB01-11EE-A78F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Doing nothing here produces, in the current implementation, the intende=
d
> printing.  Maybe the message needs to state so?

Yeah, "/* Nothing special is needed */", or something.

Thanks for a quick response.
