Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041F19DF99
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143143; cv=none; b=PSCbFrArOMh91H1Glc/tHO7l7k/d/S0DRgebguGBTU/CgnjDNEndDsT3qalscUMijDxAfK993UCJyrrf0Iv5sLafDueNK49hNGuEdPKPSckTT6oC1traxSqSfdq/GrPUIBRfU6sN1GobeZtbcyT8pRJ9A1lpw9fpw8G8zdF1x7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143143; c=relaxed/simple;
	bh=7D8tMKtnkX9XEvKhEYPZZ3a+uhLbUYkbyH0UaobjxwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZpiuzXt4jPU8BDk5d6iAgUAm06fx7eXm4AxELgSve5eMc1Yy39GqMCvj6E1N1yhmjwEZcYOdkx6iG4ArED/Uh6tnwso8XrYPKJtjQJBMXVp5k5+n3qRdz/ChiNpw5XbgbCx3sTF7ddkU9SLz5yyAY8oV2jBJAk3gytCax7vOnkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IvbAdgUH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IvbAdgUH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC6743D144;
	Tue, 16 Jul 2024 11:19:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7D8tMKtnkX9XEvKhEYPZZ3a+uhLbUYkbyH0Uao
	bjxwY=; b=IvbAdgUHAhwz0SEEVs3jbqXyHBtLP/fKTLMyQSgxxWqIMW50X9m+fD
	/cSulUzY/fCyvXw50P8mMDO5uNMjENtlERxrz2HmuMsWZMWz/ap/2EJt2J1cZbGL
	pMj3V3HmUBOZYc4W4yvaSL6gBRRdJTOl88UN+Sf6CyHZN/ns0+irU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 95A443D142;
	Tue, 16 Jul 2024 11:19:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D54493D141;
	Tue, 16 Jul 2024 11:18:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2024, #04; Fri, 12)
In-Reply-To: <047b889e-fa6d-4c4a-b486-0bc80922c4ca@github.com> (Victoria Dye's
	message of "Tue, 16 Jul 2024 08:16:09 -0700")
References: <xmqqbk31b6le.fsf@gitster.g>
	<047b889e-fa6d-4c4a-b486-0bc80922c4ca@github.com>
Date: Tue, 16 Jul 2024 08:18:58 -0700
Message-ID: <xmqq8qy1cql9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA1CD692-4386-11EF-A6AD-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Victoria Dye <vdye@github.com> writes:

> Junio C Hamano wrote:
>> * vd/mktree (2024-06-20) 17 commits
>>  ...
>> 
>>  "git mktree" has been rewritten, taking advantage of the cache-tree
>>  API.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
>
> Please drop this series; I haven't had any time to work on it since your
> latest comments, and likely won't for the foreseeable future. If I do find
> some time to address those comments, I'll resubmit the series.

Thanks.  Will drop for now.
