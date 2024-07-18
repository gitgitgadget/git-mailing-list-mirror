Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9724C62E
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286478; cv=none; b=AJqQ87VKPgYGl6qDbMa4NKbARdJ3KxDfA2uH6cHyUngOvHB7AKTeuRFFL8DfjUvxwPdlf25g+wx8DNwD9k4vGiYj3zECtloy+yvv+bGVEVLsi8iOhKs10Bz9dna6UKFX8P/TbyMAeV2oxmY26lUwVMLIaSGXnBzd0A72LfV/L+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286478; c=relaxed/simple;
	bh=OttUanscOmOyzDiHxSSUQXzMIUOYYzoiPst/HBQSnTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iMcOkNkvcObdxjLMEiJZMwY3603nYeZRPNDSRpZxAlqHxdZDqGLvvhfNEJdpeqVBwnhn1AMNXfgRIyjcgLJjaocqlXrw5ldDdOPKSXHcIypkW6fhNiliTONsJo8LF1oYLr0mukKEwT94ZFXdmJ+xHSpO+V9Fstmmo7f9bDKn4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ExLoSzDj; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ExLoSzDj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A6BB2781F;
	Thu, 18 Jul 2024 03:07:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OttUanscOmOy
	zDiHxSSUQXzMIUOYYzoiPst/HBQSnTU=; b=ExLoSzDjteqsG68o7Hq1URzdjHSH
	fLc9hRDajD5aLeF+kf7bfgROCyNqNdATQJNeYa3WlFJfkWgrnkyiNwDPFXboAU4e
	gXU9Bf0ooWFCBiJvl9wgPT1RamOaOKendM3aU/lFTGWnE6T+A73PVdYdAYTn9sul
	jvpGp1TAuuIE/VU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91BE82781E;
	Thu, 18 Jul 2024 03:07:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3F882781D;
	Thu, 18 Jul 2024 03:07:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  git@vger.kernel.org
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
In-Reply-To: <ZpiAcJuAH50UlHIX@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
	"Thu, 18 Jul 2024 09:39:44 +0700")
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
	<xmqqikx42c42.fsf@gitster.g>
	<9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
	<xmqqr0br26ok.fsf@gitster.g>
	<8dd1a2c7-5b9f-4e2f-9c5a-d5d5758714e2@ramsayjones.plus.com>
	<0e2c66ce-d870-4a03-a26e-a928183b9b2b@ramsayjones.plus.com>
	<xmqq5xt33a10.fsf@gitster.g>
	<a1a771b5-f8fb-40e3-bae0-6307abbce58a@ramsayjones.plus.com>
	<ZpiAcJuAH50UlHIX@danh.dev>
Date: Thu, 18 Jul 2024 00:07:53 -0700
Message-ID: <xmqqzfqfyy7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7481F258-44D4-11EF-A43C-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> writes:

>> BTW, I didn't expect it to take this long for this issue to come
>> back to the list! I expected it to almost immediately cause
>> problems with the sparse ci job, when the version of Ubuntu was
>> updated to the LTS (now previous LTS!). So, I just found a simple
>> solution for now (which turned into 2 years).
>
> Well, yeah, -Wno-vla would work, I used that macro __STDC_NO_VLA__
> because I'm not sure Git want to use vla or not, so I only tried to
> disable it for system headers.

Defining __STDC_NO_VLA__ would rid use of variable length arrays in
the regex.h header, so "-Wno-vla" would not be necessary.  It's just
that it makes me feel a bit dirty to define the macro that only
compiler implementations are expected to define in order to cause
header files behave the way they would with a compiler without VLA.

If we apply Luc's patch [*1*] to sparse, the header would use vla in
parameter in the prototype, sparse would grok it, *and* then
complain that we are using vla, so we still need "-Wno-vla" on top
(but "-Wno-vla" alone would not make (unpatched) sparse grok the
construct, of course).

> And yes, the vla declarationw as added into glibc 2.35.

Thanks.


[Reference]

*1* https://lore.kernel.org/all/uug4xslokvlxr6z24q52z4pt7nrtiimbzunz2gz3k=
pilk4kxts@7jljsksi6baq/
