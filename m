Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FFE63B9
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726856146; cv=none; b=dukF/YNK3kJqHbwcpKcqWIxUlTinpFOX34CM2QNaaV4QF0rp/dUensHjx5DB/0M3fi1Zs1Vid9K4rj/yTITmO1YGPQL8x0BS9f2wfIwE0C3zOD1LeX1d0WNgE+PvmTtd0ru+pz4q+sWeN4Y7cX61DAghydd0l5h8XSv1rT2n0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726856146; c=relaxed/simple;
	bh=963NM71Q23CX2/dCMN/xizihY5ampUUEX2CGg2C1Ma0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BtDejgBZPBZddie+fMy5m7rZY1Ifg2ewQZ730msSssXoEA6S9sYQRuovgSNQ0uhXSJUwqQ4m/2yAz9F/UTEj8qjP+1PkmRVelfqBVWIUZ2xFQNxABIa5TaT4ESUlCwC/Biman6dkyzwOAAixxBor6ojh9PWbi5lAkWPbVqp2xDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=STPnb/Ve; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="STPnb/Ve"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16D7E36FA4;
	Fri, 20 Sep 2024 14:15:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=963NM71Q23CX2/dCMN/xizihY5ampUUEX2CGg2
	C1Ma0=; b=STPnb/Ve7B4RSv2jlXvbq5b4gDbnfwWMf2JDD0/Q3e7WGJCX1YVkC9
	74G3G+1KEbfkB6NvPHY4f9g77ZT0An+zyhzAQ3qEdgpNMkjG4yrGocfuN6ETKhmo
	we+ESPFvprQCZJOOuImfAF96iTpDVeiDxhLNcEaI/+GK9htbZGtjA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DF4336FA3;
	Fri, 20 Sep 2024 14:15:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7196A36FA2;
	Fri, 20 Sep 2024 14:15:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Marcos Del Sol Vives <marcos@orca.pet>,  git <git@vger.kernel.org>
Subject: Re: Permission issue in Git in DrvFs-mounted network drives
In-Reply-To: <Zu2aHdaw_oDv_dp7@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 20 Sep 2024 15:51:57 +0000")
References: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet>
	<Zu2aHdaw_oDv_dp7@tapette.crustytoothpaste.net>
Date: Fri, 20 Sep 2024 11:15:42 -0700
Message-ID: <xmqqsetugpip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 599BFE72-777C-11EF-A396-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Other folks may feel differently about fixing this, but I would suggest
> against it.
>
>> The WSL team at Microsoft has been already informed as well:
>> https://github.com/microsoft/WSL/issues/12051
>
> I've provided some comments in the issue there.
>
> [0] https://pubs.opengroup.org/onlinepubs/9799919799/functions/open.html

It depends on how hard it would be for filesystem providers to fix
their ware, but (1) leaving our code to require open semantics of
POSIX may serve as an incentive to encourage them to do so, and (2)
I am not fundamentally opposed to have an option to help users of
such flawed filesystem, provided if such a change is done cleanly.

Thanks.
