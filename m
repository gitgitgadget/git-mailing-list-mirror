Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18198139584
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271394; cv=none; b=WPfOpZ813lbt9/x6rRpUd5vEv5smMqQzTjo1nQXHn3YoriG2U1TbOwxgD1Xni90Gy/QLVYhU6rjK+pVFGyi1uZMMb5tBcZc09LoD0jM4dsuE9WE6yGqowcRBhVVCR82BBabABhif1UJVsUH1FYFNFg0AtXmMCC0ooVwbv2DaBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271394; c=relaxed/simple;
	bh=1oOCAWZCiRGEasOkTwXVlEPGZjHNVAJMbKwlKlNo4BY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LPO5RdTRINvdaJ9Om0FkRD6pJ+5017vKaMSB0H4ZRV1yzatP54sGkJzzdLbPTcvk/Ua0Xsu6TwlvSuGUzNlA9oae3/eTOUUo7e9B9/Z3pu3v2z0yPE2OFcHnHLASq98XUSFk2S1qe4oiCDZuZBxcTs23BpTtczF+eVla6BFvdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NgoQOsyE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NgoQOsyE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 763A730409;
	Tue, 12 Mar 2024 15:23:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1oOCAWZCiRGEasOkTwXVlEPGZjHNVAJMbKwlKl
	No4BY=; b=NgoQOsyENXLkdddJw5M4T/+t7WFACnwZ6dWibffcqpXbtRVyJmjVJP
	3yh6hRQe9Codi0hi4CafaqIy3rrKVRnJZeE7dqFow3FFa/vjbKebCNZXIOj1urcK
	ErLsEc2S6Pt17zy3ENGmlNyQoLoIFSusjsFTaWPsOHdIF5/iQ9BHM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6143930408;
	Tue, 12 Mar 2024 15:23:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0244930407;
	Tue, 12 Mar 2024 15:23:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: git@vger.kernel.org,  David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v2] diff: add diff.srcprefix and diff.dstprefix
 configuration variables
In-Reply-To: <20240312005756.GA3029606@quokka> (Peter Hutterer's message of
	"Tue, 12 Mar 2024 10:57:56 +1000")
References: <20240312005756.GA3029606@quokka>
Date: Tue, 12 Mar 2024 12:23:06 -0700
Message-ID: <xmqq5xxrl0f9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F5A0EEEA-E0A5-11EE-A085-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Peter Hutterer <peter.hutterer@who-t.net> writes:

> Allow the default prefixes "a/" and "b/" to be tweaked by the
> diff.srcprefix and diff.dstprefix configuration variables.
>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
> Changes to v1:
> - note default in documentation
> - drop the custom prefix function, change the defaults instead
> - commit message: options -> configuration variables

Looking good.  Will queue.  Thanks.
