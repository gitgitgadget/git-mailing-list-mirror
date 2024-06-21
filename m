Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD615FCED
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986719; cv=none; b=abzIz+FIPw4JezSkQauT1rlwjMNapVbyNHvQibQrAIWbpZ8h31wnWsRqxu+y6sVQ0iB8vcyWYFPcMo9ZHSFzh8AEANMW3CQsTWb5wg9k2Z9VL0FZT4nQ7HfH9hHU8pg6kIF9ayWVrXdf8oddB0BobhhA4mvS/xV62nyNZEHSfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986719; c=relaxed/simple;
	bh=OAUS52nexlrdbU5qnremVyTYS/C7TIR3AFC/zEHQDvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gE7RlS0pv0XBCLnQbwiYbs/n+T+ejNfTWOyCPqXlkvNUB7jgXLsGrNdPDmwwdH+Q6ncs6NYJ+UU6BsFMMxuFec/gw513kVDiztqek50c2/bOwDhKOa4P4DZIu3WzWjHYc3kKnGINpMn9PNSQcWOgry2KJp7zG1VACC3bHqXwA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VlpClngO; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VlpClngO"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C54F254D7;
	Fri, 21 Jun 2024 12:18:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OAUS52nexlrdbU5qnremVyTYS/C7TIR3AFC/zE
	HQDvM=; b=VlpClngOW1BMw8nrXSjVh91manVtIkrFtPPkTqd9Nq5fBGGYCfFvD7
	FFKsunOoeHMiRWprqeuBggw3Pw7W79CjxKoTbN7K816KMFgyx/UQmtAhAWAyS5UX
	X+drod2JmTmC/po4aj7g+LlfyyEO1t0eFqxTeqJacYjun4oMz2ETU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C4E4254D6;
	Fri, 21 Jun 2024 12:18:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8DA6254D5;
	Fri, 21 Jun 2024 12:18:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
In-Reply-To: <010201dac37d$68a96070$39fc2150$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Thu, 20 Jun 2024 21:50:29
	-0400")
References: <20240619172421.33548-1-randall.becker@nexbridge.ca>
	<20240619172421.33548-2-randall.becker@nexbridge.ca>
	<xmqq8qyzv5a3.fsf@gitster.g> <xmqq34p7v4x1.fsf@gitster.g>
	<DS0PR17MB60311D246BF2E89FAEB3C64DF4C82@DS0PR17MB6031.namprd17.prod.outlook.com>
	<00ea01dac362$73935e20$5aba1a60$@nexbridge.com>
	<xmqqv823p3tz.fsf@gitster.g>
	<010201dac37d$68a96070$39fc2150$@nexbridge.com>
Date: Fri, 21 Jun 2024 09:18:34 -0700
Message-ID: <xmqq5xu2p8v9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E9241DE8-2FE9-11EF-B749-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

<rsbecker@nexbridge.com> writes:

> I think I would rather let each one stand.

Yup.  Two patches (one for zlib, another for libcURL) next to the
one already done for OpenSSL, would be good.
