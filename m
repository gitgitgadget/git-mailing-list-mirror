Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8A26ACA
	for <git@vger.kernel.org>; Thu, 16 May 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871560; cv=none; b=Gxl47HRxMpwCDyEgkDTOxvyU8HmuaOU8hncslktlPKF//1EoFHJQXYpodSMVhfcBzitZ442cP8he/pNy6bB8lTlqgN6EPC0ByycZDQGxeJ7FIADdK3ng7fNXHS6YeWX+YYEIXHxUX/VF7zHNmaU/15Cw+y3IBZFdn7g4A4OpJ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871560; c=relaxed/simple;
	bh=iUYDVq8rqBewJKpFtcdf8Nu9IxF4AkrQALCFt/BIxpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HVkLDEw4Wxuj/VA+JuGL6NmijlShI78CeJggwxXky/cNA/kjYnsjdjTD4qVP4k1Q0bufuXm1vKYCgk5oMc2MuXvPjMYEl0Mt4kzJO9z5fM7noNHAqhiDPLIgyL+PbtqF44UmaaPngEkNrdVCqzLT7ucpJ0+CS0JFrPNX37pFbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n9ZzyFHZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n9ZzyFHZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6D6E25D7F;
	Thu, 16 May 2024 10:59:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iUYDVq8rqBewJKpFtcdf8Nu9IxF4AkrQALCFt/
	BIxpI=; b=n9ZzyFHZMyHjVNTqTP4L6i78UBWpyuZmft1i87khJ8hW0xqYn49zCu
	afjKzvaWnZdKbTe9UgKG2VXq6RKjfDRt4rya39/bFnyOS51c1ocpFQAk97EKnkXz
	ElxUDOE/8a+KzWrp7lvHXv8Ko8Wp/bkP9A93Ay50RwCf1ePYjqk3M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE84D25D7E;
	Thu, 16 May 2024 10:59:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B10925D7D;
	Thu, 16 May 2024 10:59:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Brooke Kuhlmann <brooke@alchemists.io>,  git@vger.kernel.org
Subject: Re: Git 2.45.1 - What is the right way to clone with global hooks
 disabled?
In-Reply-To: <ZkU2Vao8yBHYdUmJ@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 15 May 2024 22:25:25 +0000")
References: <FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io>
	<ZkU2Vao8yBHYdUmJ@tapette.crustytoothpaste.net>
Date: Thu, 16 May 2024 07:59:16 -0700
Message-ID: <xmqqy189u7jv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DDEF03C8-1394-11EF-A34A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I didn't see my patches in seen earlier, but it's possible that Junio
> has just been busy with other things and may pick them up (or not) in
> the future.

I knew about this message, and addressed your half of the "hooks"
topic in my response to Dscho's proposed patch to the other half of
the "hooks" topic, but I didn't realize Dscho's message did not Cc
you.  It should appear at

  https://lore.kernel.org/git/xmqq4jaxvm8z.fsf@gitster.g/

by the time I send this message.

Thanks.
