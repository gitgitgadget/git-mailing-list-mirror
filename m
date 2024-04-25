Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAE12CD8B
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061902; cv=none; b=TjX5gB0rM3/tFYYz8rf+xd3sHwEG7E2VLK6r6LE5nEwU1/hpRTa9wUSOI60IAxs6yKJggys6KMPDGecA4zHLgxc3pr97fhNHjII08PE85GZJ+2Nh0uGOt729JE/yZDCvlfnUudCPmyPKVF28BJB8oArSkTHSB/uPFLIwBpifK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061902; c=relaxed/simple;
	bh=//8upq1KXhZDfeO6cA6xSjM/TGfTsPZuPq2N9SiNN6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K0BvZ+62CAI5k1I5np7VUaDhNfTKg2TaDSPnVj5N4tqNw1soOueACFGALTz49/0nz0vcnBRL2h3nIfjv3YdiOyys/WojnbRGZkGdyiottJlWMZCR9V9U8qQyVSt8RjJQiy9rL7BhCkmBUCzPIH3IqXSqoGh9t2vsNrNcyQBAdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=le+bOYG2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="le+bOYG2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C67B923659;
	Thu, 25 Apr 2024 12:18:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=//8upq1KXhZDfeO6cA6xSjM/TGfTsPZuPq2N9S
	iNN6o=; b=le+bOYG2Xa9TrEKIZLH7mPvkC9YbdH6BISshTmQxZzdjPBJY05uym4
	CHlACA1ajpybVeyb2QW7pi9NzVCc0gzWwsy2XJVogDwYxLjmHN24QXgEmXu9JoAa
	A01/MGf1qJLIsF1LBG89jc/Aah++TaCUoza/yTfCPsjEXDAywOgio=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BEAFA23658;
	Thu, 25 Apr 2024 12:18:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 847EF23656;
	Thu, 25 Apr 2024 12:18:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk,  James Liu <james@jamesliu.io>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
In-Reply-To: <Zin8R_iS8_hiy2JE@tanuki> (Patrick Steinhardt's message of "Thu,
	25 Apr 2024 08:46:31 +0200")
References: <20240424035857.84583-1-james@jamesliu.io>
	<xmqqo79z2s24.fsf@gitster.g> <ZiirKgXQPLmtrwLT@tanuki>
	<7d1d2892-d486-4e91-b100-e44c1d76893c@gmail.com>
	<ZikSNSszRzBz715c@ncase> <xmqq34ra3iyj.fsf@gitster.g>
	<Zin8R_iS8_hiy2JE@tanuki>
Date: Thu, 25 Apr 2024 09:18:09 -0700
Message-ID: <xmqqmsphh0vy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 69328B20-031F-11EF-8C95-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> > Filtering out advices would be doable. But we probably wouldn't want to
>> > do so unconditionally whenever we execute Git commands.
>> ...
> The reason here is mostly that I do not know whether this can be rigged.
> I cannot state without a doubt that no command may output "hint:" at the
> start of a line that may _not_ actually be an advice.

Ah, I mistook what you said to be "we may want to keep the advice
messages in certain situations while filtering out others".  

Surely, we may send stuff to the standard error stream that happens
to begin with "hint:" that is not created via advice.c:vadvise().

I do not however offhand know why anybody would want to filter such
lines out when they are filtering out all advice messages.  When we
emit a line that begins with "hint:", I do not think of a case when
we do not mean as a "hint", i.e., in the same spirit as real advice
messages.
