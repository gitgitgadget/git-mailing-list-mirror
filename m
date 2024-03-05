Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018565A796
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677578; cv=none; b=STf6oAsVmq8cK2SW9cItL5YdZn2gk06PeeuCq+fdiyUO7MV9wBfWLGJME6i7L5jbWn7KvJXJqcCkAUxiVTRVuKSL2cQEIElX0KysaPjAgLkbiBY8kipkdVcwSwzWehTIOiXuspNs91zc831pJoaAqmBQObFWKJN5dIJSxYdE0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677578; c=relaxed/simple;
	bh=fnp3n56u+fsIqjWqPCasQAgGPSC94YMY8RHCYVcqric=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fHGxpQaWbhiLJO7Njh8FehQHqGd2ITvJ66fQZMkwzM0ZMEQltCFvz//1WQrRTfw4NONpZ7bxVXZKOihANX7w74Yz2T8IpCChkOeCmYwqP+AbnMY9DNTBHT6VgJWvh5xWUes94IQWbzQBZzTVxJFu0fmT/1A2/o8zn6btkAdIAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JCN3vVDE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JCN3vVDE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 34FD81821B;
	Tue,  5 Mar 2024 17:26:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fnp3n56u+fsIqjWqPCasQAgGPSC94YMY8RHCYV
	cqric=; b=JCN3vVDElZO1atrsROsya7+PZA93dx0rWrtZNVnjD6bQf25eaNLMk6
	/+h+43CcNWmcFAKfWk6RA8R5DErX0Go/JZlzR4WmJjaqwFtF4rxKRiPVCK7IGrPp
	8TkVoo6iz5OZqXwnOHvb5OiQ2UvNQztie2s+VriUuhEVvlLxaT508=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D4331821A;
	Tue,  5 Mar 2024 17:26:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A728E18219;
	Tue,  5 Mar 2024 17:26:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 03/22] t/lib-cvs.sh: avoid redundant use of cat
In-Reply-To: <20240305212533.12947-4-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:25:02 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-4-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 14:26:10 -0800
Message-ID: <xmqqttlkxqm5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5EEC0BB2-DB3F-11EE-BC92-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  t/lib-cvs.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
> index 32b347337908..57b9b2db9b3f 100644
> --- a/t/lib-cvs.sh
> +++ b/t/lib-cvs.sh
> @@ -71,8 +71,8 @@ test_cmp_branch_tree () {
>  		find . -type d -name .git -prune -o -type f -print
>  	) | sort >module-git-"$1".list &&
>  	test_cmp module-cvs-"$1".list module-git-"$1".list &&
> -	cat module-cvs-"$1".list | while read f
> +	while read f
>  	do
>  		test_cmp_branch_file "$1" "$f" || return 1
> -	done
> +	done <module-cvs-"$1".list
>  }

Again, trivially correct.
