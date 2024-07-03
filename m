Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD5717DA39
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720036485; cv=none; b=JtuYRmWqEzh4Ivm+iRKmWW2l9fWu3TyhHXBY9ib3P/VTF410HPaIrYaWaaudX4vk4Hl5Cv+XYDThYoL4aPi5EjISkZ+BqETA+TXSwIwcTHMxTTwMik08aB9AQ/l4iUHZiWhN4B46350Rb387Pnsi3DuiBAHAxHbl49rYqBYNp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720036485; c=relaxed/simple;
	bh=9RHIJe7N18V7lOV8twYaS8aJLZ1AmHtWyZx88GJ+vLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QM4Y+XiRhOe7d0ohCKkxjVmOpz6kOgqmIECDlRgelcDsBW1FAf1bEnzhQcdDAlEumdgWF6w2b3D9tF1KzyV+jmt0bSr0qY3r+1K6B3VQZimr3/LP7HlBEx+wFwqIGzdz/tpsguvUIky4uUja7qoTluu7Jl2evLm3pNCGo0xyzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=prG5L4bn; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="prG5L4bn"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CF3321BF14;
	Wed,  3 Jul 2024 15:54:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9RHIJe7N18V7lOV8twYaS8aJLZ1AmHtWyZx88G
	J+vLc=; b=prG5L4bn/90W3EFbDGzjbYXtDXSglWbHy13Wq84DL/KvGLOtRGIQjp
	SO5ZfAabTbfhj/qQchR2Wp6a5gBKDb9FEqoZztnBXPuik0XvQaQ06Z4KYLlVOmSn
	rF9D3CxiG4+2kkRkqQXFgJ0szRwJ3trruDyCVO1hCiD7Fa4qULPmA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C65DF1BF13;
	Wed,  3 Jul 2024 15:54:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 327FF1BF12;
	Wed,  3 Jul 2024 15:54:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  newren@gmail.com,  vdye@github.com
Subject: Re: [PATCH] advice: warn when sparse index expands
In-Reply-To: <068752a3-4140-4b30-803a-1c409afb01e1@gmail.com> (Derrick
	Stolee's message of "Wed, 3 Jul 2024 15:18:06 -0400")
References: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
	<xmqq8qyicpdd.fsf@gitster.g>
	<068752a3-4140-4b30-803a-1c409afb01e1@gmail.com>
Date: Wed, 03 Jul 2024 12:54:40 -0700
Message-ID: <xmqqr0cab69r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 16BE4644-3976-11EF-B92A-965B910A682E-77302942!pb-smtp2.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> I can send a v2 without the config option present. (I'll wait a
> day or two to see if others have strong opinions.)

FWIW, that wasn't the direction I meant to lead the topic into.  It
is perfectly acceptable if some are much more often used than others
among various advice.* configuration variables for squelching these
messages.

I was merely making an observation that this is likely to be a less
used ones.

Thanks.
