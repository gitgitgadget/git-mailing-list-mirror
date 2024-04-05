Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4F171672
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337239; cv=none; b=L+qx0nKr/zdESgNsGTGNc1STLiXth1vZblh1S1ZVYx1WUP7pM+c8hr7PUmjMdow0TGvoc1ywHAGM8FckD3darK+QPCgxBzF5ieLToWok+jm/CypkYfE0VEiTa6D/hnuimXtih6mn4X1+f+lVPuetgdj6UpwJ+jFUf28w8Gprk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337239; c=relaxed/simple;
	bh=+SZKRsgrGD7h2CQZk749dHHGsgtD+ZijZfWzt4aduck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPzo0rKspqbkwmQEeOziQ2Xf/4qEmsmVcVnR2kGZWarEAhhQGRs7PiIt/fYtBXSj07FkJ6Xfrwsia1lXylKQyOM17K5xcNNDNYZXMQZGuQ1ePeCxuxQoW017SuHcQOPV1Kb9xcUpvMqIS2Mv5lGnYqzYvZsys1o2ImVWPa+wk4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FIyolGjp; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FIyolGjp"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FC1B1D8044;
	Fri,  5 Apr 2024 13:13:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+SZKRsgrGD7h2CQZk749dHHGsgtD+ZijZfWzt4
	aduck=; b=FIyolGjpVYolzAwCSP1YNFB/Tj3yVeZs0rN+dDcSNSlff5NSSM8cDS
	RZxrcralLWaHxXQpiMJFOwQSYCWmEDjXP4yJNWnNmV02ZFCCL2mZrnNR9IRVsXIB
	Wawfp8Gpk6f42/YU3baq8e3ogihp5KaUouB5p298MbXVcXcPBn1KM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 671451D8043;
	Fri,  5 Apr 2024 13:13:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5FC01D8040;
	Fri,  5 Apr 2024 13:13:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <fa91b134e6cb18578d9c499f584ae3c5@manjaro.org> (Dragan Simic's
	message of "Fri, 05 Apr 2024 18:51:55 +0200")
References: <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
	<xmqqzfu8yc40.fsf@gitster.g>
	<8d47bd687f2ad80bbc1e1c86ae337327@manjaro.org>
	<xmqqjzlbwyhr.fsf@gitster.g>
	<fa91b134e6cb18578d9c499f584ae3c5@manjaro.org>
Date: Fri, 05 Apr 2024 10:13:54 -0700
Message-ID: <xmqqplv3vijx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E24700B4-F36F-11EE-9855-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> However, making the vertical whitespace a separator also follows
> the Git's general approach of not wasting the vertical screen
> space whenever possible, so taking the separator route is actually
> better, if you agree.

Of course.

If the topic came from a contributor with a longer track record and
used terminator semantics, I would have insisted to consider
separator semantics a lot more strongly.  With only two commits in
this history of any tagged releases, you are getting a bit more
lenient treatment ;-)

