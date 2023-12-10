Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D+JuopUa"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4646F106
	for <git@vger.kernel.org>; Sat,  9 Dec 2023 19:16:36 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFD631D4484;
	Sat,  9 Dec 2023 22:16:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eE+xIJ31E9X7LigwC8fIy7VJwOmlmTtMn8H18M
	6ty7M=; b=D+JuopUa56m2a/2lD40KvpM0qmHykh4qu6p8K9OLQ8VYgQMvtcAw00
	casA7Wuvouc/M4fR2su95fV7ApOanhFYRI1ZjYTosT+F2Af6PlZSot3wwibIDsqG
	K4h6Mt7MTsOm3CIQJWCcGx0hDnBer0VPJuFuGBTQfLId6KaAcRsGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C81101D4482;
	Sat,  9 Dec 2023 22:16:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28B1B1D4481;
	Sat,  9 Dec 2023 22:16:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] clone: fix init of refdb with wrong object format
In-Reply-To: <cover.1701863960.git.ps@pks.im> (Patrick Steinhardt's message of
	"Wed, 6 Dec 2023 13:39:44 +0100")
References: <cover.1701863960.git.ps@pks.im>
Date: Sat, 09 Dec 2023 19:16:30 -0800
Message-ID: <xmqq7clmn3w1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 846612EE-970A-11EE-9123-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> While at it I noticed that this actually fixes a bug with bundle URIs
> when the object formats diverge in this way.
> ...
> This patch series is actually the last incompatibility for the reftable
> backend that I have found. All tests except for the files-backend
> specific ones pass now with the current state I have at [1], which is
> currently at e6f2f592b7 (t: skip tests which are incompatible with
> reftable, 2023-11-24)

An existing test

    $ make && cd t && GIT_TEST_DEFAULT_HASH=sha256 sh t5550-http-fetch-dumb.sh

passes with vanilla Git 2.43, but with these patches applied, it
fails the "7 - empty dumb HTTP" step.

Thanks.

