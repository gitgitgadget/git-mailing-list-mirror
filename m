Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DFC143
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T/zKFXRq"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8D711C
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 05:03:47 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 443DE28D5C;
	Wed, 15 Nov 2023 08:03:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=drxBub1sPnN+N3ZLDvPuqRZoCDjwIFEJdvpNK5
	3SWgw=; b=T/zKFXRqDZyeMPlK/6v8tQ8s7vBq20zZ4tOwP/NLAbeVmlIdDLzWtB
	SmZI6zsegzzcJARp8PQyYM2FXNXmi8+PR83Dp16g9vHfJYyvdxWPVWXtmBEqktx1
	AoQp6XAhYiWaVvZPFkgH0xY1MlVwUxMQd7xGJ3ucqxuCHvgOTqqIQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DFD728D5B;
	Wed, 15 Nov 2023 08:03:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D0B228D51;
	Wed, 15 Nov 2023 08:03:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] rev-list: add --ours/--theirs options
In-Reply-To: <20231115120417.1327259-2-vegard.nossum@oracle.com> (Vegard
	Nossum's message of "Wed, 15 Nov 2023 13:04:17 +0100")
References: <20231115120417.1327259-1-vegard.nossum@oracle.com>
	<20231115120417.1327259-2-vegard.nossum@oracle.com>
Date: Wed, 15 Nov 2023 22:03:38 +0900
Message-ID: <xmqqo7fvw4lx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 66660E54-83B7-11EE-B2BE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Vegard Nossum <vegard.nossum@oracle.com> writes:

> Add --ours and --theirs to view the commits from
>
>   $(git merge-base HEAD MERGE_HEAD)..HEAD and
>   $(git merge-base HEAD MERGE_HEAD)..MERGE_HEAD

The range you wrote with "merge-base" would not work well, when
there are multiple merge bases between HEAD and MERGE_HEAD.  

Just saying

	MERGE_HEAD..HEAD and
	HEAD..MERGE_HEAD

or even simpler, saying

	MERGE_HEAD.. and
	..MERGE_HEAD

would be sufficient, simpler, and more importantly, more correct.

