Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA312107
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296793; cv=none; b=t3c3QKAIYyuZoLQjjAZLZtpVvrLIKFVt7iS5wCeolD8b1HMYFGFy1FXkGtLAY/r4xcSbbfgUfcSYRNI1G9dr0irIt+j/OhKhkyonJB9PpJDEd/thwPxm390KS6RHvjg+s52vmiSw9L4EH+HMvMF4Y3ZK33KGzuk9hftaPrSZPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296793; c=relaxed/simple;
	bh=Krccb2t/ACZkTdUNSh6D8cV6Xr4aXnV+ZjdONSTFiX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oa70ku0YLQVt5MssFtQejVNtf1gvo+PkcNS5KVyMfR1i7Cr1ggZ/xAxhxQQoRQLK08Fh3djPdQGUaobgKHN1pT61dteFafiPTyefnJ1ObOQPSdyFusKDRewo0d8RPs1yImnyDahRNNBcXaeq+bzs5J6zk+f1WwRVlE/fHse/Am0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PDWOr1tq; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PDWOr1tq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DDCC328CDF;
	Sun, 24 Mar 2024 12:13:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Krccb2t/ACZkTdUNSh6D8cV6Xr4aXnV+ZjdONS
	TFiX0=; b=PDWOr1tqH52Ka+BNLSnC+mHl7qdbASsTLgY3gozRzjbKTzAhN13wkM
	FK2SewaVMam1zKSmMbrYX1gq/DYkJGwxD6d77v75O7HHtoy+cMYiQ7zefXYIClpC
	57CY+AE5k+jyaTNeV0HymnuvMuNpjX9JISaf2fsRnLb8rLQo0IauM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D624628CDE;
	Sun, 24 Mar 2024 12:13:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6FD8928CDD;
	Sun, 24 Mar 2024 12:13:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Matthew John Cheetham <mjcheetham@outlook.com>,  M
 Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
In-Reply-To: <ZgBE37Xs3TQEF2c-@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 24 Mar 2024 15:21:03 +0000")
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
	<xmqqedc0v029.fsf@gitster.g>
	<ZgBE37Xs3TQEF2c-@tapette.crustytoothpaste.net>
Date: Sun, 24 Mar 2024 09:13:06 -0700
Message-ID: <xmqqzfunsj59.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 66BB3AC0-E9F9-11EE-B701-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> be, as that is better for the world".  But I am OK to add less secure
>> thing as long as it is an opt-in "easy way out".
> 
> ... Thus, my goal is to make it _possible_
> for people to implement this, but it to make it their responsibility (or
> that of a suitable open source project) to do so instead of asking me to
> maintain it.  That, I think, is a fair and equitable tradeoff for this
> situation.

Yup, I think we are in agreement.  I have no problem with giving
them a long rope ;-)
