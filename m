Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29383BB21
	for <git@vger.kernel.org>; Tue, 21 May 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331254; cv=none; b=A9WD3uAtJWI2f4pkAjhVLJ98isgo/0N9lwa5dGjLWK1c8ltMEHD8VfVyN08sM/3F1+SKZyP1iUGv2DR1hfR3sqNrU55W6dXEY9VC94es8uZ3fLCSyBU3+jzvmDTZqdxPO3NGQ0o/aYoFKqF1knlTsG3DPzQ8J217my4XFVoEvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331254; c=relaxed/simple;
	bh=k9mYxOvuYWJic+0d0T7+daq9a+L/Iu5FKEpT2SIaz50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rimL7b1aXnl8vOM4hG6ARIoTTHK44G9eJw8iKN9AubsDzGbyQlmygkXOwKttYX/QdD59qiLMltjJA2x8goeMM1FYdkGF3ZayaTbpVMQXl1sZGepLMcbghqhjh4POd/4cAS/gfe8GlU4xvpYDY7O1j2pD2W+lrON/TuTncHTP42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NByuBYY3; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NByuBYY3"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 734D32344C;
	Tue, 21 May 2024 18:40:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=k9mYxOvuYWJic+0d0T7+daq9a+L/Iu5FKEpT2S
	Iaz50=; b=NByuBYY3EtgfcnoGEmizsKDbmdhk7/GNPdt1QC0odBE+2ajydGbBF9
	/uvg4REsNlNs8Mo2HeVTCkEsvlNSz15DOVPi8gUtQ233dYI1tP/CqllZMajEMNKg
	bDoKcQMas8LpGFDrmD2qOEKP3xdv32RULCRH/FhaeSnwylMeegZQg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A61A2344B;
	Tue, 21 May 2024 18:40:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D19022344A;
	Tue, 21 May 2024 18:40:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] Various fixes for v2.45.1 and friends
In-Reply-To: <Zk0hKCsbjFGkguFQ@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 21 May 2024 22:33:12 +0000")
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
	<Zk0hKCsbjFGkguFQ@tapette.crustytoothpaste.net>
Date: Tue, 21 May 2024 15:40:50 -0700
Message-ID: <xmqq4jaqkcul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2D5A875C-17C3-11EF-ADAE-25B3960A682E-77302942!pb-smtp2.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> (My apologies for not getting back to this sooner.  I took a long
> weekend for the Victoria Day holiday and was busy riding rollercoasters
> instead of reading the list.)

That's fine.  We all must have fun sometimes ;-)
