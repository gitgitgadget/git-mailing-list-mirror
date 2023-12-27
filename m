Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1949888
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kPfrCQ5f"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 67A1618017;
	Wed, 27 Dec 2023 17:22:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3xs/t0I4FGGFNNJUorEzdwQBiPRQHB7XsZcuWc
	ZA0TM=; b=kPfrCQ5f2XLtzB6NrIr8QoNrffpiwZh/b7wmYSmMhbG5dd9sjGxIvw
	7sjHN6Q8lmieTeK2t9Uz7kHQYY97nLa/V2tB3VKHRIAo1fwzQSxqLc1TrG6teuVz
	zA/3AIA1iqhUkExcgXy8hrpnu5/C7+7ZxKd+tcXjwVLMf92qKra/c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FF8A18016;
	Wed, 27 Dec 2023 17:22:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06EAC18015;
	Wed, 27 Dec 2023 17:22:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Chandra
 Pratap <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v3] sideband.c: remove redundant 'NEEDSWORK' tag
In-Reply-To: <pull.1625.v3.git.1703672407895.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Wed, 27 Dec 2023 10:20:07
	+0000")
References: <pull.1625.v2.git.1703351016486.gitgitgadget@gmail.com>
	<pull.1625.v3.git.1703672407895.gitgitgadget@gmail.com>
Date: Wed, 27 Dec 2023 14:22:51 -0800
Message-ID: <xmqqmstvl1z8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7A02E0CA-A506-11EE-A156-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

>       - * NEEDSWORK: use "size_t n" instead for clarity.
>      ++ * It is fine to use "int n" here instead of "size_t n" as all calls to this
>      ++ * function pass an 'int' parameter.

This does not sound like a sufficient justification, though.

We should also explain why "int" is good enough for these callers.
Otherwise, using size_t throughout the callchain would become
another viable solution.
