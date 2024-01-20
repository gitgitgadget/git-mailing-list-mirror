Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293E7ED
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712169; cv=none; b=KMkJm58hLkypwDZvJIJSG0YLJ84w4CLDcqPrCHCZku4IqePoUUdIyBICnUzqNbRGhTMXzU+xz6YBD/FfaGll6jKCFhFS8fUZuy+Qja+4wMJHE2plxN2SMDKh4b6ygTMe/F7wPI6ld+1muFuWP1KqOzth9yslNzV6Pm4EmPjDhhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712169; c=relaxed/simple;
	bh=5OrrJ9LphyOuAd18hzGPYgHDywM/xd86Hj44lD7Rx/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gKbIsZkeNB82s0U0OpGGHQRDenvk+lyNO+LU1+4pQjPSuDy9F+dpRAmRa+nvqp2J1bZCBcgxDyyxb3j7d2lgjDDNu7qGzMNh2Za6mDMfnR+ZlCo9sZuCXKuAFkURYgSvQwKQMhAHdh7SxLGSVsZdRNZrzyMGJuJ6BUAl6qE02OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FiCAiROM; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FiCAiROM"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 48EFC3470C;
	Fri, 19 Jan 2024 19:56:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5OrrJ9LphyOuAd18hzGPYgHDywM/xd86Hj44lD
	7Rx/A=; b=FiCAiROMVCPJc5R3UsigdE+rM+tKYC62dGSMd6IBzLFmpk4XFQuMKQ
	oe36WfVTJz0WRgFkxNst5elWy9ZHvGH3yqRJB/GLCGKxmJ4qt1YQF84FU8J0IKmc
	/HorKSfqaZ7tT8DksKQTRMHxss1spYruGzCgp3HbMQAprPC1cn00U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 418743470B;
	Fri, 19 Jan 2024 19:56:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BED5634708;
	Fri, 19 Jan 2024 19:55:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Frank Schwidom
 <schwidom@gmx.net>,  git@vger.kernel.org
Subject: Re: partial commit of file-to-directory change, was Re: Bugreport
In-Reply-To: <20240120004628.GA117170@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 19 Jan 2024 19:46:28 -0500")
References: <20240119132551.GA31532@debian64>
	<ZasCZ0YetzmlBFvw@tapette.crustytoothpaste.net>
	<20240120004628.GA117170@coredump.intra.peff.net>
Date: Fri, 19 Jan 2024 16:55:55 -0800
Message-ID: <xmqq4jf8j010.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AB7448DA-B72E-11EE-AD31-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> I dunno. I probably won't dig much further on this myself, but it's
> possible Junio (cc'd) might have an idea right away.

Sorry, but I do not have any idea "right away".  I even needed to
see the tree of 2888605c64 and check if we had submodules back then
(it turns out that we did).
