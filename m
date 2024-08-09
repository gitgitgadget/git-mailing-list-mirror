Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43441224EA
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723237956; cv=none; b=ohd+P0ihS1rC0RjDiQIkqB9kovlJK9NwpF58CDmqbrYOSvdpe5h1nnNbNQVItCNrMEWxwMdAhhjDF3zshLKpKxTU/zMJeHa9WMu+W7BXeQQF/0e6GcNvTbaTROQVUnSTzCNROdX3eb33DtvO1/ReL+By5JPkNiVgaAOV+7HMa6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723237956; c=relaxed/simple;
	bh=sT+LYJJwEwcxtE6rgmPSLtWvVjYykXfIyieptljd4tY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLcCJKTDZRBZasVZANsUUTR5xrg83NmY7k4WDiGM/16FiyxSTFv8oCl3l+OGDUSXotJmnl94PfHCKLPqA1142aiW/4woP8CEHJM36fuBk/xIPSwTPt8odOdyl9zf75CbFbWzSUBV99Q1RWd8/CkaHr/nMf0Urc3upnewa/AYHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fzMA72Gp; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fzMA72Gp"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C85C12FDD5;
	Fri,  9 Aug 2024 17:12:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sT+LYJJwEwcx
	tE6rgmPSLtWvVjYykXfIyieptljd4tY=; b=fzMA72GpU/c+AiDxr4iFqoWK7j3n
	a7x28y8P+xtGlt+Rl/X82/mhLavbcQV+XH/rtGgFXntGjVng44H3hvHIyfZJjYfv
	u4uMCjuqJmPrj6JLTf+KyWCeVzKk3zo0hczpA87kFgxqqR56f0U3W+nWhlnozoTu
	j9IPMQvaFvmZNm8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C0FBB2FDD4;
	Fri,  9 Aug 2024 17:12:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EDCF52FDD3;
	Fri,  9 Aug 2024 17:12:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: What's cooking in git.git (Aug 2024, #03; Thu, 8)
In-Reply-To: <CAJoAoZk15_O=qasf1RspWfECFX1gQLTXZVMCeP3=RMC14K=2sg@mail.gmail.com>
	(Emily Shaffer's message of "Fri, 9 Aug 2024 12:49:47 -0700")
References: <xmqqo762frkz.fsf@gitster.g>
	<CAJoAoZk15_O=qasf1RspWfECFX1gQLTXZVMCeP3=RMC14K=2sg@mail.gmail.com>
Date: Fri, 09 Aug 2024 14:12:29 -0700
Message-ID: <xmqqle15bdtu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 16D36D7C-5694-11EF-BB63-BF444491E1BC-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Emily Shaffer <nasamuffin@google.com> writes:

> On Thu, Aug 8, 2024 at 5:49=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>> [Cooking]
>> [...]
>> * es/doc-platform-support-policy (2024-08-02) 1 commit
>>  - Documentation: add platform support policy
>>
>>  A policy document that describes platform support levels and
>>  expectation on platform stakeholders has been introduced.
>>
>>  Will merge to 'next'?
>>  source: <20240802221948.2367124-1-emilyshaffer@google.com>
>
> I haven't heard back much on v5, just a few "I will review this soon"
> and no update since then. Does that mean it's ready? Maybe other
> what's cooking readers missed this series and want to take a look? :)

FWIW, in my draft integration for the day (not yet pushed out) the
topic is already merged to 'next', so if somebody has spotted a
glaring error in it that cannot be fixed by additional patches on
top, they have only a few hours left to stop it.

Thanks.


