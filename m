Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60D349B1F
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448738; cv=none; b=pAgXCr2cz40TXJ08uM5TbsZSkmnff/DM56DbS/0OP3iasddhmQu2HLgk5K80+rFSQOfxMllWUfwsonD74cSHxTJYrUxQWWNUtUGH8bVBWRz97yAimbaY6DiETR45MEG7CiP4OHObbWpYLl32bmyTOIO0ls6fE5+J2c3w5M0AzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448738; c=relaxed/simple;
	bh=KEHUr+tMCyAfZL0TH2cVvr+qTjGFu8r30qijS76k5BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DNlAGNpOXyOvbxt+ZSC51paKWU+m9Xo6pBsdvpKzqieNrScRh/PebFfYNsKdkWziBCg3jDbTp6GCKwnTejwEccogCItN1k6puRYI7KHmCviGWtB8ukh0LEIpUX5ZFAGj8dCAH0Suvj233VZaGshk5zpOkBx1YqFD7/4JQGfbfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EGxjxbNN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bqvLO94d; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EGxjxbNN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bqvLO94d"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 06F337A00EB;
	Mon, 26 Jan 2026 12:32:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 26 Jan 2026 12:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769448735; x=1769535135; bh=quDr5E/iYv
	N5sSrBzeuKoLW1S47bZsozj338ltsVks0=; b=EGxjxbNNTos7zR1Uad/M4JGeS+
	+3phnK3cUNLlMKVGrh+7Yg6cG1/utkRRRNoKHQV3G/lVHF+arFdCa714u6eg6GQg
	rIMrWYNTg9M9o7JPU3VjqjUx17cOE0RlZO3X5VrDULkcXkfJZUPDOsqLV0DA0E6V
	7vpGwkvVUvjl4qUqPdU+BfHUw2KjJc+qtUE9A9P7IxADUmltmzhojMUHfQV0dPM4
	hvgaxu6ZNYkLNlWR8HexwJPG4XQOTxadYyqMqoe1FANoQ2Xaa6tNlOyxA8vqp9kd
	S261TubXBuBxWARER7lgVxl+5hko80rW8rl7Tz12qoSgTUYqyHUPidI6Q3Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769448735; x=1769535135; bh=quDr5E/iYvN5sSrBzeuKoLW1S47bZsozj33
	8ltsVks0=; b=bqvLO94dFP5ZeNpBzEGD9FGBVbqR/C823Qg6s68f5RPLyJykSQN
	Z7tdZaqADkSJstg13pumRzVeFF2zsfKsDiafX7F+B0TzqMsFrFzLwHpzqmXI+lhY
	o1tK7zR5Hg06BJp2LCJafJCmf9a+i6+pl3FZSxF6P27COKpcNH9r80erd/lYyv+X
	Rei/CyzxKvD0IKQU2SRHMYbKSxcwqUQtQleSSp4ceBPNJek22UvPXqsz0uVwWvwX
	kJcfTgvY//y3YyhSMuXTKo2ed8eyekt/goFa/waErr2DqwEn4artWljCJtLYnZzs
	Bxirnr6sHbkAP5Y8loQRmuaJJF/ojcKQVoA==
X-ME-Sender: <xms:H6V3aYHafbNqIVsALcg6VhDIPQHZxi_C6OZzFWlGZ0E_UHwUW_gXjQ>
    <xme:H6V3aYPV_uaYAsfTCUbEkE4sbg5IDOIKkSzJ0As0j8phSmVnnwoR1thdK_FVcujnd
    D5flUUyIFSPzlUjgQzHXr0gznTO-b5TGfWPle87cNIGxgmZguFdwQ>
X-ME-Received: <xmr:H6V3aactK2AwNxt6_jpX9875D2iDIqA0YDj3iRCfCmvmn8gdC3NCEoDoUJyQko57oqgkMZV7FsG9Baf0QE5JwE2-31YfMA7pkATjKuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephi
    gthhhinhdrghhithesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:H6V3aVuk-yoWGRH07Q7P4EzTgm5dkoyJ-B63Grsic27DE_rVrwsIcg>
    <xmx:H6V3abl5yAWbeUPT7P-_p6WuD1xB8jh-rXLCC7F8cQCrjWmHtkqggw>
    <xmx:H6V3aXxjQDyxNDR5C3gA652EhFPRna3h7xnfcwnHi5MxJDiWndIVjA>
    <xmx:H6V3adMLVRXJZ4zCa-wGNkLDwkRfJhPVDEXw3srqD9kEfRWdFnRO2w>
    <xmx:H6V3aU_mNeRxyZnVkqDF9cMS2ayn5A47T1jq5RJpF9Fi_gb2yeu1rcRA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 12:32:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using
 histogram algorithm
In-Reply-To: <3aeb49dd-8618-42e0-b9f9-6a4fb8065793@gmail.com> (Phillip Wood's
	message of "Mon, 26 Jan 2026 09:37:03 +0000")
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
	<xmqqikcusn8p.fsf@gitster.g>
	<4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
	<xmqqy0llk33y.fsf@gitster.g>
	<3aeb49dd-8618-42e0-b9f9-6a4fb8065793@gmail.com>
Date: Mon, 26 Jan 2026 09:32:14 -0800
Message-ID: <xmqq343sjn4x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 25/01/2026 17:34, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> On 21/01/2026 20:51, Junio C Hamano wrote:
>>>> "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>
>>>>> @@ -915,6 +919,45 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>>>>    			}
>>>>>    		}
>>>>>    
>>>>> +		/*
>>>>> +		 * If this has a matching group from the other file, it could
>>>>> +		 * either be the original match from the diff algorithm, or
>>>>> +		 * arrived at by shifting and joining groups. When it's the
>>>>> +		 * latter, it's possible for the two newly joined sides to have
>>>>> +		 * matching lines. Re-diff the group to mark these matching
>>>>> +		 * lines as unchanged and remove from the diff output.
>> 
>> Also, after reading the first paragraph of the big comment again, it
>> makes me wonder if it is saying the same thing as "When histogram is
>> being used, we shouldn't bother shifting up and down to join groups,
>> as the result will always worse than the fallback", but is it that
>> bad?
>
> Looking at the example in the commit message the result of shifting up 
> and down and then calling the fallback is better than either the 
> unshifted diff or shifting without the fallback, so I don't think just 
> disabling shifting improves things. It would also stop us coalescing 
> changed lines, for example
>
> -A             A
>   A     ->     -A
> -B            -B
>
> The indent heuristic seems to assume that we've shifted down as far as 
> possible before trying it so that would probably get messed up as well. 

I see.  Thanks for a good explanation.

> To me the problem is that the histogram diff does not always generate 
> particularly good diffs (maybe I'm biased - whenever I've tried 
> switching the default to "histogram" I've always switched back 
> "patience" fairly quickly after being presented with a diff that I found 
> hard to comprehend)
>
> Thanks
>
> Phillip

Thanks.
