Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3DE3D092A
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658017; cv=none; b=KVzdp8PG+/qbOUGNT+GJT1W6AbPl3+nGkBnxq59w9UQ5Y/ieVp+43S2CLVh/qbLHJsT9ZygQtDfZjnLccLtHK1RUWxJ7DOvSQ9B+qzIfXbk/2fOKS/xryMIjArq45h4/vOyMUTQijcsM8yMXWUQoxyY6wOFWzt8JTj1IVP/SVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658017; c=relaxed/simple;
	bh=Ew4I2EWUQCwmMCrmFfZSudJf/fsnq9B5esAEv3ocsyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AtemNcMoQhvtehmoTVhCf1cHFi+2gsZfHbtl+YvqknGhRSiWxD3FPCwojy59KptzIx6o8jBl7HWeJS8ebXnOax+HIHh4uwdjHlxwxpNso2MvFMshwg7s5zBsO0B6Q07DA/XM1fikxzDiGF5ibWE+YaVyf6cOCkchgLt+kdYyBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ybIeVexu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QGm33ZQE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ybIeVexu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QGm33ZQE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79A9814001A3;
	Wed,  8 Apr 2026 10:20:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 08 Apr 2026 10:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775658014; x=1775744414; bh=UsHoPvYqIa
	e6vGGZGCn4rR7s3SaiytsQuvV013wv4l0=; b=ybIeVexu/7J5P7G4qlWytuvdO+
	KDj8LtqC67J/9SxcAGCvol63F8GWePFWgw1FPFI4YndeFgRizK/GwOXXuLRkI1QJ
	bOL0ZSpFlZFGPumJvuXkyZRCKIt2A2y/NgVyQU4cd8c9pSjEhOioXpPSy3x6+/IJ
	YWCSAQ7UeFPRRNeAJvjAqHT8k20jzSZwVXksNULrlUiHF+uw4cWLWSCfnfTSyd8T
	UrFJ2RoifmI98u2nJdXML63T5OdxG2ccuqkP4PKqLwZet4iqfwdi4ruVYoflKYWS
	Y10CQTRS511dwiXGawESDVpJa+jhSlEwmDP3zkZklPXdsZfb3jWtJIVZVESA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775658014; x=1775744414; bh=UsHoPvYqIae6vGGZGCn4rR7s3SaiytsQuvV
	013wv4l0=; b=QGm33ZQEnUvYfhk3vyD2xpXegk2V9uurDWxNPfWlpK3cBiieGK3
	2l9fE8amgSLvLa0v5DdgYgJtVGUfFQtdm1NwDDra7U1OtO5ifDmRbWJ02nqVokLt
	ce1qNuolsjr0VReR2pXYVwXo1q1TEF4762OkUZFo0P7G0d5hoVqh8X41ayNL9MCN
	uTTteZwOyffgq8NhM1J+vvkNBJi8VoFYaWQYvYz1p29f68Gn5O/pL7ynelGy0tnC
	gd5P+zuqMkEHJKefGt6SyY+h6f/SScUIdHtuPzGnL5jYYhjLopbl++sRYbObmDJT
	KcRynUb0kiv2/fXrRWloKYD06z3ETC8yAEg==
X-ME-Sender: <xms:HmTWaePigvErwo-cPVuZvpIWMojuwaxHjrdbOEf0QghPdg3cpi1KhA>
    <xme:HmTWaT9NBdNxKcxozapdsULQojEoZnkMp8Sa8m5Eo79_ywg7f8phpC8CkXgRQgDUO
    KaSJlmrVwt1rhuZ6leDzKt-ZokhucRE6usrJ6AIUI8pJkyMCh8Jqg>
X-ME-Received: <xmr:HmTWaaSLpuKTfAda3whueU5aP6568rW9fOKYAz5B9qgMfOGoAoNWt5lqXgAwHCotZXrvIfTlOQ9hzcT5m6bR0HVaprGyjujKfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:HmTWadnaru7T7ojxrPoGE86A_EWu4swRsnR0cJw_EvzdIgXr4qqfCw>
    <xmx:HmTWaSRaX1S83o5OxpW38eLqP4UAsacRSmESi9zneHtTO5SgjemP4Q>
    <xmx:HmTWaTMHXDfZJJbYQm_OY4rBEVxoEZ0VQil0WCeuD5_Yefv7FOwj4g>
    <xmx:HmTWaTX2laV955vfCq-Dx45XfphQnHKIfdKqwSnBwyEjLAI2rUtKSg>
    <xmx:HmTWaYWq5oxVZErc7gGWn2mVOCpIqpVnQtGLGKvsupCuwqIxySSCGb5L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 10:20:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH] docs: correct information about reftable
In-Reply-To: <adX65j-4Vb24GpF8@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Apr 2026 08:51:18 +0200")
References: <20260402224241.4104726-1-sandals@crustytoothpaste.net>
	<adX65j-4Vb24GpF8@pks.im>
Date: Wed, 08 Apr 2026 07:20:12 -0700
Message-ID: <xmqqy0ix1qlf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Apr 02, 2026 at 10:42:41PM +0000, brian m. carlson wrote:
>> Our description of the reftable format is that it is experimental and
>> subject to change, but that is no longer true.  Remove this statement so
>> as not to mislead users.
>> 
>> In addition, the documentation says that the files format is the
>> default, but that is not true if breaking changes mode is on.  Correct
>> this information with a conditional.
>
> Makes sense to me, thanks!
>
> Patrick

Thanks for this ack---the patch message somehow escaped from my
radar.  Will apply.



