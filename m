Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A1ED9
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467109; cv=none; b=oSjRIrBY8AM4vCdRvrstGeVA8E1mDXpuTo8GJ6Nd5OSVHAP9AZ4IuWkePmBi4T3A162iMiy8KRRHVxpoCCQt40o0RRd+kSU60PJMlvueVBn9fBFoDavUNH5q964veevQZcsjOuSQ/PmYCJYhZ+LGW8iQelUQfWVgwioewUsXJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467109; c=relaxed/simple;
	bh=OHfj0dbxBES1nh1XLuU0kbbPyhZd4ZuKkSRfar8bgUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L7gASgqcUls5r1cjztBZ3mhM77hOW7cYfepuHyBmz/xUpU7j7/TeCG3wgSmx2iwIj5hn2IgbfXSfuLx4hnqa4oLeq1Fs9B0tKkXVxXzl6/K6Ph44FY1QuCPF22iO961KhjrOda0XXwbOEj+RSw650B51k+RTpOigjif/ubrpTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I1jwplq/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I1jwplq/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 300342DC49;
	Tue, 26 Mar 2024 11:31:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OHfj0dbxBES1
	nh1XLuU0kbbPyhZd4ZuKkSRfar8bgUQ=; b=I1jwplq/5z/esmMZdp9UokfXCUYO
	Kw2/l4EK3/DqhrWk9vMnLkHWMuZHjhZxJGxaSLxot2GOrRDTn3/OzljDh6OLFeib
	R0zCx8Dyea2WiRzu9kjtYmTomDW3U5eBaq/pRs9nUQfejqDy3eSWIS783aWqGTFC
	v1XzxisGgfqMKfc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 286172DC48;
	Tue, 26 Mar 2024 11:31:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BAC582DC45;
	Tue, 26 Mar 2024 11:31:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] improve interactive-patch
In-Reply-To: <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com> (Phillip Wood's
	message of "Tue, 26 Mar 2024 14:37:50 +0000")
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
	<6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
	<59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com>
Date: Tue, 26 Mar 2024 08:31:41 -0700
Message-ID: <xmqq5xx9dn6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F2909260-EB85-11EE-A081-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Rub=C3=A9n
>
> On 26/03/2024 00:15, Rub=C3=A9n Justo wrote:
>> Let's reduce the verbosity in the interactive-patch process, in order =
to
>> make it less confusing.
>
> I think this is a good idea, I've left a few comments on the patches.

Thanks for your reviews.  You raised very good points, all of which
I agree with.  'r'edisplay may work well (and I wonder "r | less" or
piping the hunk display to anything in general would be a useful
future enhancement).  Response to an unrecognised command should
probably be a two-step process (a short "'h' is not understood. type
? for help" with list of commands upon request).

I however am unsure about omitting 'p' from the list when we did not
skip.  We do omit 'k' when we have NO previous hunk to go back to,
but that is because we cannot do it even if we were asked to and the
only possible outcome is an error message.  That is quite different
from 'p' where we can always show the current hunk when asked, even
if it is just after we have shown it already.
