Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0C36E460
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277882; cv=none; b=aqSDGcdrHAynb+ViFvbZTG2cTGuQ3Uv0N+BGZvGSmEA5RqbGaGSMuo8Gx9M7+m6TpFZISQFoNZOkFYgUlKwP5VptvGWPCHHhxZbh+phDhK0rCfxMtTTr3Mw3JEvwyrWMU+YpRs7pboVd9C2HUJ3KPz04iKgv/ymTTfa3J1z9YpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277882; c=relaxed/simple;
	bh=1kMhzYhrOlrAe4kN0agkNKFmLNg2pgX1YUOb6ysCoNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=czLdcwZfvk23Lbt3ppQE5S1zCsUQjoFSW5Y5OF7m2d+tNFg+x/P2uS+NzB32MAcAy+zxDnYCfTuw7+7U3D6L6Td0/QbJ+mCuph8EHqDPNy27wNyKJAonf0DAy0kIsAxKZxC49ehJS9lXj44XWRHPdMccfRAddCMIm+r0VVxSpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L7yC+Ohk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gdR96yp7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L7yC+Ohk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gdR96yp7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E19A514000E9;
	Thu, 24 Sep 2026 15:24:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 24 Sep 2026 15:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790277879; x=1790364279; bh=CdBjp1uD1A
	CDfEqi2UlgM8YBnx4zJreSPZ4Dof7BgZU=; b=L7yC+Ohk6P7NwlzSPrFQciENVj
	YowsnKwieepBLiBFWC1h4/topP6REoE2mGQxF8BW3hcRz4XG+U7Pjan5VxJAASrd
	LeZh5g398cum/8+gLJaLYNUCWjLraP4joFJ4DS+x+JrOB4sS8T59z7V+Cii1E9ct
	V6w8ZNTIkYhiqO7VSyTOnNtLh6XAfVpZHv5SNZ/lPJBYTlAgbQ9ulo26vEmeo3oi
	EZgazrP1ZHk2ZfYnZHpwE1J7542Rf20hrURcFC2vOq5ntgZGP/kwvDNbekZkWIk6
	6PR8nBfCK65ozaqPqUQa6TpQ5e6sEGCpmOoDxumzIB9azsnPqZBQd/6MQqZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790277879; x=1790364279; bh=CdBjp1uD1ACDfEqi2UlgM8YBnx4zJreSPZ4
	Dof7BgZU=; b=gdR96yp7QbTF1WO6obKF5MOKK+1sp/jz6EHhqS6flaQIlONv6dI
	oNNIKjmiLb2hGMTudGWXp82oLFfrkLy6U+mR9WnfPWyEWyiBBt8XKKG1TIAvdGFC
	Hh7QVnXFQEsQJQ7mSL6XVP1OfMDi/sWOM8sEYoHs8PDZRnz7SKAOOcxnJU7mXRGi
	2LL4bKYJy+feTx8N5Kd8ht07KQ9XHjo305IV1pRgFf+Lbl6Y6kTcG7ct2dGAbFcr
	LzRvc8YwHnOWqgDq2IWuftOqdTmHaRknGMr50YKaFceoBGsA32CWNW+ce64Axv3G
	ODkLlSO/EJipdiqE6BHZYQ3MGl7UElmI9WA==
X-ME-Sender: <xms:93i1apqjz0liJurqec5JoENjQNwTCVLkAMl3qfLiS_EIzXsnZ7QWEw>
    <xme:93i1aijriXOdHTspLcdwFvAdoYMMySsi983bWvKH8mW0nI1dzZ0YrlcxGzel8KGuo
    1IO77jHE3cneMM3q7l_QLD7QolGttBaM-6Zc6szjKBj4590Xbw7LDM>
X-ME-Received: <xmr:93i1auii8Tae6vY3xSiUvQLFMo0TE6XDOZYmHzHyj566oQnBgF1Krw48S8Ikh65RaAQZcxwCNXdr_ugGug9fFXFTwb-FbOo0ltox>
X-ME-Proxy-Cause: dmFkZTE/U2JrNsyCjyX9qhfTp0KXQjhjGE6/yZAXBDVNFbxUuOWdVKNPoLXJAvKCxrkAcC
    PVZM5/32Sn03rWC5fsfo78TDRMsTyh3lGd18jybPThlazU/QOf0dqr04ZgMjhA2EOLlDHI
    93dDIW5qO0gdCo3GvCpc/TomRPDIa7CvY7kCiKqlPq3BmFhI/k18hHriD6r3NrwEg2a/bd
    djXUNZyhbssARcpbOyFGRV7IjOXnwScUxPAzuHmQZ5x3u5snK6IfSBJyM6o2lsoLk2NtZO
    zZrnMVHdYgDO2zDcJ0T8Yn3c8QQC0MmKy8OZq0HTw3XVwsXL2P7Td9Y8N34i5Pepqy+ZiL
    SM6RAhUZ9p5eo5F2oSLHpAPW3VfmYa+k7y2ynDmeeyuNdSz/dyd3X4eDyLqnbSX0MT1zTo
    mHDyEKpWs/WZEPJBOPmGEbZ9oHHTVXD4YZbSUaw0G7o8BmeEqG32TZUFrjJC/LCcoPtH8M
    yDBhSN0aiB8VURs9AwV0sDtepiX9Fh5OgSLM1qYArUKTbeISiHwWiEQdUjUkx3lMTyxaBS
    FG01y4w4uHm98PXVZVfs3l7XRL+hGdKS+MWzDjbBQLazuiSRYKq7EAx+1WsvhiX4d3fRTo
    9m6DtUkdwV+DPf80PfnJM/C4vBDDEnG4NXciMPhZqhrIXXqCpvfsJIzzHzww
X-ME-Proxy: <xmx:93i1agj3v2A1SPB_O7eSKeu60zfvSsb8wJMnQTZJ8JaQ5MaV6MH-3A>
    <xmx:93i1amIbI4okUKXk0jFqXh9o316pVJZoYbBllVMwCfRTM6k5Y8a5hw>
    <xmx:93i1anEO4ZlULnUSn97dvTWVxgLZf55y4NBjJ3MOTDSufLsiNejS0A>
    <xmx:93i1aiT0MVzw9ooCOvcgotB-SXFG5GhI0Cftw1P-bqlkqvEH9HGJMw>
    <xmx:93i1alxwE-564C0E2pjziaHyZ9K18Mf2Qf05WkO7ftMKbQv1SUgH5PAq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 15:24:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: ps@pks.im,  git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: What will come after Git 2.56?
In-Reply-To: <20260924183523.53201-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 24 Sep 2026 20:35:23 +0200")
References: <ap50kgyenpRrsqln@pks.im>
	<20260924183523.53201-1-haraldnordgren@gmail.com>
Date: Thu, 24 Sep 2026 12:24:37 -0700
Message-ID: <xmqqpky21mh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Well, same as there's room after Git 2.9 we also still have room after
>> Git 2.99. No reason we cannot have Git 2.100. :)
>
> I agree completely, no need signal that 3.0 is coming until it comes. Once it's
> out, not a soul will question what number the release just before had.

I am afraid you totally misunderstand what we are doing.  Once it is
out nobody would care, but that completely misses the point.

By giving "Something big is coming" beforehand, we are warning
downstream projects and distributions an advance warning and that
begins with the jump from 2.5X to 2.98.

> I have a list of breaking changes that I would like to introduce, I was hoping
> they could be considered before 3.0 is out -- otherwise I fear I have to wait
> another 10 years for 4.0, I would like to change the default values of these
> config values:

I do not know how long it will be before 4.0, but if you do not have
any draft code on the list or even design presented before this
message, it is way too late for 3.0.  No, these won't be part of it.

But some may not even qualify as "breaking changes", so after 3.0,
some of them may not have to wait until 4.0 happens.
