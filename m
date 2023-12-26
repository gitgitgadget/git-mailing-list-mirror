Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4F4E639
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KVjJUnCB"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 925F83174B;
	Tue, 26 Dec 2023 11:33:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lNVBl3f8Bfg2bLcivwepPYnzg5ayceV3/lCBml
	b3Sq8=; b=KVjJUnCBiS1+udzH1cxrVLliggVDTqqPe7WflXGxxoueSjMOwStnoe
	bCILe44MX/vPZKVKHOzjxo8l3PcrIiC7BEuBiGWf2Luv2d2JjQ4FA7P9g2THZMWI
	3t3oGC1fECXq4FXR9NujknrEDPsykfhbS1Vui6MRNHbLv2fbozaiE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E57A3174A;
	Tue, 26 Dec 2023 11:33:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 169DF31749;
	Tue, 26 Dec 2023 11:33:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Sean Allred <allred.sean@gmail.com>,  Git List <git@vger.kernel.org>
Subject: Re: rebase invoking pre-commit
In-Reply-To: <bf1ce173-50d7-405f-88c1-7edb7ec5a55a@gmail.com> (Phillip Wood's
	message of "Fri, 22 Dec 2023 10:05:56 +0000")
References: <m0sf3vi86g.fsf@epic96565.epic.com>
	<bf1ce173-50d7-405f-88c1-7edb7ec5a55a@gmail.com>
Date: Tue, 26 Dec 2023 08:33:12 -0800
Message-ID: <xmqqa5pwkjp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 772D49D0-A40C-11EE-BCB3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 21/12/2023 20:58, Sean Allred wrote:
>> Is there a current reason why pre-commit shouldn't be invoked during
>> rebase, or is this just waiting for a reviewable patch?
>
> The reason that we don't run the pre-commit hook is that the commit
> being rebased may have been created with "git commit --no-verify" and
> so running the pre-commit hook would stop it from being rebased - see
> e637122ef2 (rebase -m: do not trigger pre-commit verification,
> 2008-03-16).

Very true.  And back then we didn't have "rebase -x" mechanism but
these days, anybody who is interested in running a command between
each step can use it to run any validation script, not the one with
fixed name called "hooks", so I'd place this to fairly low priority.

Thanks.
