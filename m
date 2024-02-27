Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925EF36C
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993213; cv=none; b=So2xBrcNdhpTUD73oH13b4I0ylYhyEr+hnvs24a5H5GbH3prlgCiFP4u2nvMqAK+8PR5tjKLko0c1QG9NQYoROr0nDCskQUpYislUZasH2M8VICZZNDYm5ZAZaF6XdWbHejrA+oEEb8EShEvT0Rohhl2PZeIRC9xAmHmztrcHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993213; c=relaxed/simple;
	bh=fkNIwroLIYRoi5FbOvI22eSeOpWE+66Utq0LJ+b1ffo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HX/nSWiA4pywnY0hudAo6soTfZHF77ATyK2o27Qd5FTmjriDKGmFbSBlvZNcY5eNGsy+4i8FZyuV1Mcdvi1BkhMTFOGsyAic39keMbOmZJa4eLRMpPRcIyQU4vMcQ1Y0GORHQd2K5nqvagM/E6C7TJ7G3VnjtZXqkaKGtR2Amqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=r18+XeZe; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r18+XeZe"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DE131CA1A0;
	Mon, 26 Feb 2024 19:20:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fkNIwroLIYRoi5FbOvI22eSeOpWE+66Utq0LJ+
	b1ffo=; b=r18+XeZeD2vDloVF6J2ulqrIq8I3QSJUBdn1nvqSLFq4K0aAJEMIKE
	PVw2KB0fX+3quAuCrmBJQIg7onSGZx2a+bfcyVIoH4RDY0guhNkjOwmMMZm2ISla
	+1Q9PIpltZZAtUrCr1sGnqzkqBaLSM59eli31Wwa5BIenaqeIy/uc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 71D541CA19F;
	Mon, 26 Feb 2024 19:20:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67D691CA19E;
	Mon, 26 Feb 2024 19:20:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Calvin Wan <calvinwan@google.com>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@google.com>,  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
In-Reply-To: <CAO_smVi76TbmHd5w2rpBEEYbaw46SNTrekFHE-ohDC6-=dk6DA@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 26 Feb 2024 10:59:38 -0800")
References: <cover.1696021277.git.jonathantanmy@google.com>
	<20240222175033.1489723-2-calvinwan@google.com>
	<xmqqh6i0cgyo.fsf@gitster.g>
	<CAO_smVi76TbmHd5w2rpBEEYbaw46SNTrekFHE-ohDC6-=dk6DA@mail.gmail.com>
Date: Mon, 26 Feb 2024 16:20:07 -0800
Message-ID: <xmqqle76iwqw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F73C9AE8-D505-11EE-AC3C-25B3960A682E-77302942!pb-smtp2.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> The condition added 13 years ago was, IMHO, backwards from what it
> should have been. The intent is to have stdint.h included. We should
> include stdint.h. I suspect that 17 years is enough time for that
> platform to start conforming to what is now a 25 year old standard,
> and I don't know how we can verify that and have this stop being a
> haunted graveyard without just trying it and seeing if the build bots
> or maintainers identify it as a continuing issue.

The nightmare of Solaris might be luckily behind us, but the world
does not only run Linux and GNU libc, and it is not just <stdint.h>
vs <inttypes.h>.  This is about general code hygiene.

> If it's still an
> issue (and only if), we should reintroduce a conditional, but invert
> it: if there's no stdint.h, THEN include inttypes.h.

But it would give the wrong order in general in the modern world,
where <inttypes.h> is supposed to include <stdint.h> and extends it.

We use inttypes.h by default because the C standard already talks
about it, and fall back to stdint.h when the platform lacks it.  But
what I suspect is that nobody compiles with NO_INTTYPES_H and we
would unknowingly (but not "unintentionally") start using the
extended types that are only available in <inttypes.h> but not in
<stdint.h> sometime in the future.  It might already have happened,
but I do not know.  I haven't compiled with NO_INTTYPES_H for some
time (to experiment), and I haven't met a platform that actually
requires NO_INTTYPES_H defined to build.  Once after such a change
is made without anybody being knowingly breaking some rare platform,
if nobody complains, we can just drop the support to allow us to
limit ourselves to <stdint.h>, but since we hear nobody complaining,
we should be OK with the current rule of including system header
files that is embodied in <git-compat-util.h> header file.

In any case, your sources should not include a standard library
header directly yourself, period.  Instead let <git-compat-util.h>
take care of the details of how we need to obtain what we need out
of the system on various platforms.

Thanks.
