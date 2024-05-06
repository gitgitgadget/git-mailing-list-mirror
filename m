Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EAD156C73
	for <git@vger.kernel.org>; Mon,  6 May 2024 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013679; cv=none; b=UmuJIah/BKetVHGkxCFyMJwv0DSMCUu93HXtfmOn2K75dzihyB5Bv/0J/NoCZb+LxRd0uCTYSl/yMTF+OLL4O3DLcwoob6WUc5Q1JQtiDPpqk3gVruMKphtVTkql50IHMCCFqigQXYZfQdYALCWx34RKtBpo+Sg9yKdtrkI+GzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013679; c=relaxed/simple;
	bh=YuBqMXARxwVtmMQKur1dq9T+w5vUkON/UQlfxdbJOEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQApZmY9dXuccysxf4oC76e7nsvKFHNYO1bDRrejsMvc2o5+RDy7+5cpG8zRpV1BCCo0pBhAnNvSvMo3cN8+34gCfCeC+UbN0I7XvbPuAgaz1gB32JsRw1NZDRwiAxvjMVLYqYDihZi1uuRBVWcfhplTvF1d5RkdwYjy7GnYv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kd7y0VEf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kd7y0VEf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 500A32CFAB;
	Mon,  6 May 2024 12:41:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YuBqMXARxwVtmMQKur1dq9T+w5vUkON/UQlfxd
	bJOEU=; b=kd7y0VEfd4KTsytv14N5VDtX8SWwJCotK//gajwuZHvCLHM54cyPq2
	tkwgC5vhI/ar42aowdLA0p073QNdYGjetzfpJReKIoDXkRDIKex4kItiHvCh+reB
	OBEXcFtIQSuy1CCtNYgmIscFFOIahiKwWLVQV0sRu3Hw6UEUfULtU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 495AF2CFAA;
	Mon,  6 May 2024 12:41:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC7E42CFA9;
	Mon,  6 May 2024 12:41:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "James Liu" <james@jamesliu.io>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
In-Reply-To: <D123HB68ZKO0.3C5RSYGQNO9L3@jamesliu.io> (James Liu's message of
	"Mon, 06 May 2024 09:20:48 +1000")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
	<xmqqedai959z.fsf@gitster.g> <D123HB68ZKO0.3C5RSYGQNO9L3@jamesliu.io>
Date: Mon, 06 May 2024 09:41:12 -0700
Message-ID: <xmqq7cg63nbr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 739D58AA-0BC7-11EF-A11B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"James Liu" <james@jamesliu.io> writes:

> On Sat May 4, 2024 at 3:25 AM AEST, Junio C Hamano wrote:
>> > Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
>>
>> Huh?  Do we have "all" option that disable everything?
>
> Oops, I think I mistakenly copied the subject from the original cover
> letter. I don't suppose this warrants a v5, does it?

No, I was just teasing you ;-).

