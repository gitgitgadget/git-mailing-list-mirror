Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC678274
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144664; cv=none; b=Tw0bXyQaPm09xfvq6Kv5pMeZDH8uv0xuhLZPKYAuDg1INSfp/1M5K7v6/P6RfbJ3sQDwRyglvT4gI9rryLv9xzRNfrUJFI4hWonj6ZOTgHHSAjKkTDf0hrp9eyQTISbBaphK4MqrAQx9ZM79oQ7n60v80SeUlWnlzAWyHZgt/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144664; c=relaxed/simple;
	bh=KLQMiqyv1jocpElodC1ecd7weo0HzQCiYYZ6rEjC5nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTxT60+GnrRZq6Y53HLxdf/ea+nfe5jDxpnt2k7XNsNEBvAKfFzbFGQxC3DqBfhePrXuzvmE1CAJSc5KMTY1uyWMmpCn0YMJZjR9cO68KfMw0UitjhpodRTuLbq9659XaV6QJ6tM/3hhLch7QdnoWH4Rz/60tcbX3JmGXUMq19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=rPPPOyQJ; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="rPPPOyQJ"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id CB3BD19FD3FE;
	Fri, 22 Mar 2024 22:57:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711144656; bh=KLQMiqyv1jocpElodC1ecd7weo0HzQCiYYZ6rEjC5nc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=rPPPOyQJZz7mj+HTq8zbkToOiewESTikajjfV4Fhnz+XTHnXsOVGpCeGd5zenVxVd
	 8F6ApcUtQl4QIzEWu5laokc6JzmQQewv0MuCieZF17l9oG9FVbSWpf2+k+T+0sIdfw
	 U4YU++ncQ9sq2PZ4Wpd9S3Ma6Dy8q2m8e9VTGnR0=
Message-ID: <3925ac99-bc05-4f8e-9a52-c22c13f6a4b5@schinagl.nl>
Date: Fri, 22 Mar 2024 22:57:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Support diff.wordDiff config
Content-Language: en-US, nl
To: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com> <xmqqedcszhty.fsf@gitster.g>
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqqedcszhty.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey list,

On 02-03-2024 18:03, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
>> This patch series adds the diff.wordDiff config option. This mimics the
>> '--word-diff' option of `git-diff(1)`.
> 
> Is it even be sensible to introduce this configuration variable in
> the first place?

Of course it is :p as a human, I crave it :p

On a slightly more serious note though, I always have to use an alias, 
or the command line option I cannot use `git diff` with this as default. 
 From a human UX point of view, this is odd, and we have tons of 
configuration options to do exactly what is desired, without aliases.

I suppose the deeper discussion would be, do we distinct between user 
(human) facing options and arguments, and machine facing options and 
argument (in theory, yes we do; in practice things get abused).

Git is often blamed due to its horrible UX. I think the problem comes 
from the deeper issue mentioned above. Because things get abused, they 
can no longer be touched, not even to improve UX for the human.

> What would this do to users who set this variable
> and use third-party or their own scripts that run "git diff" under
> the hood?
> 
> The usual answer is "these tools should be using the low-level
> plumbing commands like diff-files, diff-index, and diff-tree", so I
> am not worried about it too much myself, and the above is purely the
> devil's advocate comment.
> 
> Having said that, running
> 
> 	$ git grep -e 'git diff '
> 
> in the collection of scripts I use [*] to work on this project, I am
> reminded that I may have to be a bit more conservative than I
> currently am about the risk of breaking scripts with the changes
> like the one being proposed.
> 
> The proposed feature also may break those who use the git-prompt and
> diff-highlight available in conrib/, even though I am not sure how
> badly they would break, because I only looked at the lines given by
> this command:
> 
> 	$ git grep -e 'git diff ' -- \*.sh ':!t/'
> 
> and didn't check how the output from 'git diff' is used.
> 
> 
> [Footnote]
> 
>   * They can be seen in the 'todo' branch, if anybody is interested.
