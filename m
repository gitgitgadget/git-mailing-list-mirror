Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4F1EEFC
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708377894; cv=none; b=K9lQBsNzsmM/FbgnizBWAT2oqHWFMzum3F11JHMmObrGI2fNa40Ms6KGBVCZYtqImYeaGYzCE5KGs6tjE6NPBqgYMidTF+oY8miia4vf8bqMJ/6EkwVeK4rdkoNA9YO0vgQIO1CsFy0RBCs/4T32ocYU6IyJOHyi3buJyu1Qjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708377894; c=relaxed/simple;
	bh=NBO6NjmNQc8itQtuVZ/dZRiljTRRnUG9P1me2P1PYgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UTRVYS8hSN7bB24s1YfKlv9d+d+R+vm4kCoNX+XriRThewgpO3WRg2mOJJ/avJ0zAVpojCYR1amjJJ1kP1tP1FVg6BJCaq+Lbkaf/I+owaSftIQ3b3tjA/hRWVIFgPV93EADTu2CEbifECxCIJMAzD584WpAADlvCKu3Pp4LFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h4As0pWG; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h4As0pWG"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3620425931;
	Mon, 19 Feb 2024 16:24:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NBO6NjmNQc8itQtuVZ/dZRiljTRRnUG9P1me2P
	1PYgM=; b=h4As0pWGnglPFjfHbfxs1VH0egAihg1lc3XSrRsr6GuVTtgUiiDc0h
	3COvnX1ZXmant8HHtFHQWGJMqt93APhvdch5Jnaf9Rj4aw7FrNexzvBKlUhdKCFn
	FAXsVayqXl+ncQEkkCc/AdRBm6Bt7TZDPZUtYghBiF7AmWKa52aSY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F14A25930;
	Mon, 19 Feb 2024 16:24:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D18262592F;
	Mon, 19 Feb 2024 16:24:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] apply with core.filemode=false
In-Reply-To: <fd8264c0-3080-c9d9-cac5-51115b9909a5@gmx.de> (Johannes
	Schindelin's message of "Sun, 18 Feb 2024 23:38:04 +0100 (CET)")
References: <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
	<20231226233218.472054-1-gitster@pobox.com>
	<xmqqzfwb53a9.fsf@gitster.g>
	<fd8264c0-3080-c9d9-cac5-51115b9909a5@gmx.de>
Date: Mon, 19 Feb 2024 13:24:47 -0800
Message-ID: <xmqq4je46tb4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4F96DCB0-CF6D-11EE-97D7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Chandra Pratap (1):
>> >   apply: ignore working tree filemode when !core.filemode
>> >
>> > Junio C Hamano (2):
>> >   apply: correctly reverse patch's pre- and post-image mode bits
>> >   apply: code simplification
>> >
>> >  apply.c                   | 16 +++++++++++++---
>> >  t/t4129-apply-samemode.sh | 27 +++++++++++++++++++++++++++
>> >  2 files changed, 40 insertions(+), 3 deletions(-)
>>
>> Anybody wants to offer a review on this?  I actually am fairly
>> confortable with these without any additional review, but since I am
>> sweeping the "Needs review" topics in the What's cooking report, I
>> thought I would ask for this one, too.
>
> I just had a look over all three of the patches, and to me, they look good
> to go.

Thanks.
