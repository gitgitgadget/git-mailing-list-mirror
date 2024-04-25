Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE82E636
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063328; cv=none; b=PVFoYdCSbAtLZ7k80ivf2uEPfqrvvVcyZWY/DegtZuwwmBY0P6rYJ7AdtvRmWoAPN6tXqZsv+JxYTzLfMUXgGfuHcRfBb0mRhZzEPX5Qq/GBMVcEIgI/retKf/QxApfTm/+w7xUnLoxcA3qHf6hWIpd6wXVE9/SDCLKdvwTyqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063328; c=relaxed/simple;
	bh=l/0kqvREPSjni3xp/q/ztIjtQGDPIc+YcTJ9uYuVUWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d4pR837U8IvdcdSWFstf2MNLEXrdauXomIoYJTJBar0suj72jShsXxcDEah5FJl+XXPCIMJbziPfpaUsXvcDpo5RHFPOUeNIwQn2VQ0FPrkvddxK+YPftG9eeNE8v6Mo959kc1bKEeYGgOXiIGKPJQLEERvqjB4jtwRS+TIEWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RD5lR6dA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RD5lR6dA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E08DF23CBE;
	Thu, 25 Apr 2024 12:42:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=l/0kqvREPSjn
	i3xp/q/ztIjtQGDPIc+YcTJ9uYuVUWI=; b=RD5lR6dAoFJ0RorBVU0bnmmGJFAq
	6jvgz1u05HS4Oix6PUSI59ocrEKaeNPx7EWtu5uuMPqOd1YGl7+PDAEcCJI9beXA
	rRocntFF2dExepz+74poKaI5amFP1jlhghYHEep8jNlSYrJYHtq9y/i+lkADAgoP
	4N6MFkFRtRpVR5w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D66B923CBD;
	Thu, 25 Apr 2024 12:42:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECA7A23CBC;
	Thu, 25 Apr 2024 12:42:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Roland Hieber
 <rhi@pengutronix.de>,  Denton Liu <liu.denton@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] completion: add 'symbolic-ref'
In-Reply-To: <mg33zswrxwxrlbzcvxyssxpqty5qxbezw43rwwnkepskne6fmh@3fypf2gskbyh>
	(Justin Tobler's message of "Thu, 25 Apr 2024 09:36:34 -0500")
References: <20240425101845.708554-1-rhi@pengutronix.de>
	<4ea09a34-bd62-434e-b893-8e3780aa915f@app.fastmail.com>
	<mg33zswrxwxrlbzcvxyssxpqty5qxbezw43rwwnkepskne6fmh@3fypf2gskbyh>
Date: Thu, 25 Apr 2024 09:42:01 -0700
Message-ID: <xmqqh6fpgzs6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BE651AD8-0322-11EF-838C-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Justin Tobler <jltobler@gmail.com> writes:

>> (I was going to link to SubmittingPatches here but I didn=E2=80=99t fi=
nd a
>> mention of it there. Apparently I misremembered.)
>
> There is a section in the MyFirstContribution docs that mentions it
> briefly:
>
> https://git-scm.com/docs/MyFirstContribution#v2-git-send-email

Thanks for noticing. =20

We should improve the situation by probably moving[*] more from the
latter to SubmittingPatches so that people do not need to refer to
both just to find out the essentials.


[*] If it is small, just copy; if it is large, move and then replace
    the original with a reference into SubmittingPatches.

