Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1724C6D
	for <git@vger.kernel.org>; Fri,  3 May 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747535; cv=none; b=s5ihitjgdJjm7MYR+5CNON7dkEr3vsPjckmBjfMAyvdgvm1lBXWnRGp4jc9vDXEX8QOyd7eu2NppduJBLnYzZazi23hp89clxFnfte2DZTgAL7fQgTMbz4BFGqKrQLIWeDN5XcydBXeeg9eaemwgEgI6vauOtH0HLLUDWcpejuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747535; c=relaxed/simple;
	bh=KkI/cMCm1iZ+Bq30XZHZf/TZa++Y06qL6vpmVTQbyTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZKDRg4Jrg+Yw2rjzLVMHL3S4+0FBQoo9yRykUGMYQ3clHikpgkT7PXYPNigHTf1S/wDB2S7KAOkYONhpm8BQ/7j8pXsVIPQgae4iFPIum8zysMdbLG3p7teYR3WpQnhWgOmALejF2TZjfRPvmZ5x7gGcy0a8QrR/h9kjYDhje+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fahn8iTC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fahn8iTC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2664A257E5;
	Fri,  3 May 2024 10:45:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KkI/cMCm1iZ+Bq30XZHZf/TZa++Y06qL6vpmVT
	QbyTE=; b=Fahn8iTCdHC1sbRIaDyDIm2JE4q0GW89emNvljlC960aWncC3FnNRf
	Vmssn763NGyIwZdvDu2HS9Enma8nzSML3AahlMWa+zx31RtKH7hTifoh2mAA4hkq
	0XExLSAcLkbqphqElvvDNnanQ9H9V1hUK+Tx2u4P2YKNea3VMmA1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DD32257E4;
	Fri,  3 May 2024 10:45:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D033257E3;
	Fri,  3 May 2024 10:45:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: steadmon@google.com,  avarab@gmail.com,  christian.couder@gmail.com,
  me@ttaylorr.com, Enrico Mrass <emrass@google.com>, Emily Shaffer
 <nasamuffin@google.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
In-Reply-To: <xmqqr0f47wp9.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	17 Apr 2024 09:58:26 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<20240417163244.651791-1-emrass@google.com>
	<xmqqr0f47wp9.fsf@gitster.g>
Date: Fri, 03 May 2024 07:45:25 -0700
Message-ID: <xmqqseyzar96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C77D77D4-095B-11EF-91B2-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Enrico Mrass <emrass@google.com> writes:
>
>> I'd be curious to learn about norms or practices applied when no consensus
>> could be reached. It seems worth elaborating on that as part of documenting the
>> decision-making process.
>
> I may be forgetting things, but I do not know if there is a concrete
> "here is a norm that we have been using to reach a consensus, not
> just written down but it has been there" in the first place, let
> alone "here is what we do to resolve an irreconcilable differences".
>
> "We discuss and try to reach a consensus in an amicable way,
> sticking to CoC, etc." has mostly been good enough for our happy
> family, perhaps?
>
>> ... However, nothing
>> in the current description strikes me as specific to these larger-scale
>> decisions.
>
> I agree with that.

We didn't hear any more comments on this topic, but writing down how
the world works around here, with the goal to eventually have a set
of project governance rules, is valuable. Otherwise loud people may
act according to their own (unwritten) rules that annoy others and
harm the community.

Thanks.
