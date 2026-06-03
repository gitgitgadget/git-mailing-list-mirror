Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490423EA66
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455597; cv=none; b=ksWA4jwu4QWU+FWVBBDySOcMr3PpIdhrhlwaEGljbOqNpKdAUcoWt7uWogG174MeccPeCNJXFCLsn8nCw0qYPnesPipvfCK4hdCrwlU92JZENemu6jGgGuznVgFaEa2PQLWaCuSezPL+0pwQ5yVM340iwuzZejSrfB5CqaVB8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455597; c=relaxed/simple;
	bh=w9nUi59WmVmWwvgXs7GZqIp4eaI0X2QxIrtbaNlqVLk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fr5lZ2wtuCeeurYoVFBiHBNnYQrD+y2zwUJB+1aJ2X2aSDxSWJbZv0w9h5QNOGkRXu3TB9R/K3txsjSqPN4ZZpb+GBwKYptpWajCLMsxU9G442xycOcWILDMHY6bJV+Rkx27MdqFoN6QUW+oG34v/jGQbOkGgBJsTf48FU/D9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S6m47bc0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SPc4vtNN; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S6m47bc0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SPc4vtNN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3900FEC0219;
	Tue,  2 Jun 2026 22:59:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 22:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780455594; x=1780541994; bh=0XBAgr3F8X
	EV6IzMxhe3JPTpIhHNMGnLi+r0OO6i48k=; b=S6m47bc0aJnI5jjl+m1CD0dVXi
	6n5wVZ9pupGnNXkPMfvbAst8SPG7fRiPXuUK0Vb4ErUJjyc7NnLWitaqOORApzJ0
	iyY/OtqmMAJx4q+JgeittCo9Wi/07i4kz5lom/RNT6GZMXTe4rIIXZoiNBH1uOhw
	7RCyUIjnSrRv9t2FVJxixT4STf8O9ltimhXQcMpoVbLYHxIDJhajx6Q9Ohmkb1sm
	s0fde6E8IpVK8pDkVYtT8sYs3GnArwrGcxQ692uAQPumKydxPn2JAepZRGPMF59M
	tzPKiGvJnqE1UeYlOG5K4L1Et3MeEVwUKvyoOHBTg/F6MPVXRZeUYyDwXLIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780455594; x=1780541994; bh=0XBAgr3F8XEV6IzMxhe3JPTpIhHNMGnLi+r
	0OO6i48k=; b=SPc4vtNN2qD3DVedeSzB6oTUPxba57J+DMyd9KOdpa9PE6dlapo
	lv3PobgAKOMx2k/Q4sMqBMODIWGWZXHxZ/HA5y/Wq7ug6PLyGZJNzb4j4HbZwt8Z
	gHl9OCzy5Qn0mJafJCDFakw1yXOF7eun1tuBsiSeqi1TSk3g1y5zKUwf0Z7RxhnD
	LroGTv78LQPQW6cGKtAbiVTSqAmVZfy5/gGdPw2S3OsD4doAPSzSuNqUF6914/eQ
	nyYllIEu1DTESNJLONl9JMMqp4VwvARjOE7uhM/kI75/HPAfD5+FC+IX2expxVhB
	PRM1QqM9vKzlDLoyM5DMNIE+ci2RmJiZK1Q==
X-ME-Sender: <xms:qZgfaplzfybOx8-nZm2LilOn6Z5P6fVKfYOHgTuaf4DNUZSEH75Wkw>
    <xme:qZgfaiq8S_77vb4pEy-ycdFpcYRMOcq0wW9QZMVDw-W9pDo1TeqmC6_AkCqTqu7W9
    EuuhNkpFDv70IHWOWSb1PAlq3Ab-VWkRtyza5OhZsqEMVU3I2nNJQ>
X-ME-Received: <xmr:qZgfaqEPRuGQGhfgUebKt9XkSAOGoVV1mxPk4AzzYXuPDckcRE_b1AAvEZi1djnc0tA9D5_1Pmq5S3O0Acqlpeaj61PVG8LeTfzzKyccf55k>
X-ME-Proxy-Cause: dmFkZTFsvTQNr6OMCwbvEvu5Hc8VOGSB0iivWgl7q8kfTqUuAZvuTmlmJJRKYZUthV+Ndz
    1J65jrUK8Mngp/38LgnRbkgXZ6RO6SJL5s/88eE4V4Jf8TVzg+x2fPX7DIC1J6B66x5Uim
    tdFoV888KWSk5V4VJCwHl6ubtNLeTqOWjNk9AhfATM4GCfI3cDBTDLLpjz81qlLFJaDHxu
    481anCJXkvGZe96JZ0Pfx+BX1ihB7MBKG4qfTftra+VBQxDSzDQROMCQoZEV2/KC0QIFPe
    kYIDJFt38Hc53kwZPrWvXhZcUrhFDdzpqluMMhFh05d96mNKyb9W4Q+XfAzIYAe7qnI2iR
    4qwQDTePqzyQw9CWCq5ISKN8lWbgsqL15dWnway8zJurowL+PKny1gaf67ljqeg5ysfMp/
    ruIMSTTuwc5pOAK12BfooebP1kWBTT7Eo9UDkzmkiQDuli5wGv2TZstwUdXTj+KWQY6BCd
    OiCO0p6+CQLRdOvtCyzLzN/nqeQX4+vTWiMMhylhgOb4plQrWBDkT8Hq24MGLuJJ+MVfTr
    G9HvjGnxiZ8HjXlxy2LXIryeXLkS1ybHoqexzwI53Orlxxql4xAi+80THH2FJbqGJICnja
    3TRihPLaQlw43KMeADnqtv+6+zEaldaigVrgULnPwRoPIZ9XJHzjrM75Nm6A
X-ME-Proxy: <xmx:qZgfamyb4TH3t_xmaQ9S-Nm3L0q6_1hbpXuTMeu6e6WNYOYIL3Qguw>
    <xmx:qZgfanpILWZKCcQCTMRFm6nGvpDFKoZFXAHF1XxwVEQXvSYNRTLMkg>
    <xmx:qZgfaoheCugmyNCs1Rl5vFP8kCBO7bL6IS3VDW5fZWd7oPrPCPVQaQ>
    <xmx:qZgfasgCy9Utm6LNLfnvA15F9p6B8JU08UHqwAN5l1bXC6IprF822Q>
    <xmx:qpgfapMamlOxY2PQLOB3C_WIzXCCywEyBl28M4uWAZXwg4mdgbwIzCJW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 22:59:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
	<20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
	<xmqqldcxvziw.fsf@gitster.g>
	<8dbdb553-9633-46bb-8a51-040d06d0d10e@ramsayjones.plus.com>
Date: Wed, 03 Jun 2026 11:59:48 +0900
In-Reply-To: <8dbdb553-9633-46bb-8a51-040d06d0d10e@ramsayjones.plus.com>
	(Ramsay Jones's message of "Tue, 2 Jun 2026 17:23:16 +0100")
Message-ID: <871peopbvf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 02/06/2026 2:32 pm, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>>> We're about to extend our documentation to recommend b4 for sending
>>> patch series ot the mailing list. Prepare for this by introducing a b4
>>> configuration so that the tool knows to honor our preferences. For now,
>>> this configuration does two things:
>>> ...
>> (hence making the tree dirty).
>
> Hmm, for those of us not in the know, perhaps mention the b4 documentation
> at 'b4.docs.kernel.org' (which includes how to install b4 ... ;) ).

Thanks for raising an excellent point.
