Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2655250
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IwBUGHqv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A0DE1D73A8;
	Tue, 26 Dec 2023 15:12:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=L6FW+nTAP6RNi7F2UJuteQIvfurgMQTtL/V5Li
	HYG/c=; b=IwBUGHqv38uLdB61qWSphZbhKditTRcbT+covtjNjWKu7nhdC8c+N8
	rri/sUTqT57Ctk4xZ9DmGjuUIcugoJk6Cxwa5dCG/Z0sbq/8VkEVUsZLuXNWUOtD
	irsOrNsb5GkfMVxILHuTQEd/z5f68ESsPKzxNH5zgtML4BumWp7b4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 115391D73A7;
	Tue, 26 Dec 2023 15:12:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB0B01D73A6;
	Tue, 26 Dec 2023 15:12:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>,
  Jeff King <peff@peff.net>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] sparse-checkout: be consistent with end of options
 markers
In-Reply-To: <pull.1625.v2.git.git.1703619562639.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Tue, 26 Dec 2023
	19:39:22 +0000")
References: <pull.1625.git.git.1703379611749.gitgitgadget@gmail.com>
	<pull.1625.v2.git.git.1703619562639.gitgitgadget@gmail.com>
Date: Tue, 26 Dec 2023 12:12:56 -0800
Message-ID: <xmqqil4khgdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 294CC12C-A42B-11EE-AFC8-25B3960A682E-77302942!pb-smtp2.pobox.com

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Remove the erroneous PARSE_OPT_KEEP_UNKNOWN_OPT flag now to fix this
> bug.  Note that this does mean that anyone who might have been using
>
>   git sparse-checkout [add|set] [--[no-]cone] --foo --bar
>
> to request paths or patterns '--foo' and '--bar' will now have to use
>
>   git sparse-checkout [add|set] [--[no-]cone] -- --foo --bar
>
> That makes sparse-checkout more consistent with other git commands,
> provides users much friendlier error messages and behavior, and is
> consistent with the all-caps warning in git-sparse-checkout.txt that
> this command "is experimental...its behavior...will likely change".  :-)
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Let me drop jc/sparse-checkout-eoo topic and queue this instead, and
then resurrect the "use default for 'set' only when !stdin" as a
separate topic.

Thanks.
