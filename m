Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CEC48CC0
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O8qzjght"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B543F2F438;
	Wed, 20 Dec 2023 14:34:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5KiVJ4xWVc1P4WMfA1oLR0MIGqg8NW968140wq
	AJNj8=; b=O8qzjghtsc2R56MKPUZWl2SSLtRPPssRtaocdUqXaF5VKsnLe7s2Ny
	usjJf0ygvYuboDdLwKpHzFFZrUE4Jmdb923hqjNV2YhCHtoja8llGCJC4a9vjFLH
	RwLMNk0Yn2zPxkBXeSGr937xydhZUAOOMiOvtX8Uw4LOIDmDBOil8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AE6FE2F437;
	Wed, 20 Dec 2023 14:34:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 551FB2F436;
	Wed, 20 Dec 2023 14:34:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 02/12] treewide: remove unnecessary includes in source
 files
In-Reply-To: <xmqq1qc35sx2.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	03 Dec 2023 22:15:05 +0900")
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<dbfb108214d71ab29c29230eed3c4d40fe4b42b7.1701585682.git.gitgitgadget@gmail.com>
	<xmqq1qc35sx2.fsf@gitster.g>
Date: Wed, 20 Dec 2023 11:34:01 -0800
Message-ID: <xmqqedfgsm6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB5BE23A-9F6E-11EE-B8AC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/trace2.c b/trace2.c
>> index 6dc74dff4c7..d4220af9ae1 100644
>> --- a/trace2.c
>> ...
> An in-flight topic seem to want to see git_env_bool() that is
> declared in parse.h that is pulled in via inclusion of config.h
> hence this hunk breaks 'seen'.
>
>> diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
>> index d5ca0046c89..a0032ee3964 100644
>> --- a/t/helper/test-trace2.c
>> ...
> An in-flight topic starts using "struct key_value_info" that is
> available via the inclusion of "config.h", hence this hunk breaks
> the build of 'seen'.

It seems that we have gained another topic in flight that gets
broken by this change.  I can keep piling merge-fixes on top, but it
does not look like a strategy that would scale well.

Can we get this series thoroughly reviewed quickly to merge it down
via 'next' to 'master' soonish, so that other topics can be rebased
on the result, or is that too much to ask during the Winter lull?

Thanks.
