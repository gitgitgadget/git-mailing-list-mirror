Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9ED25570
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714255363; cv=none; b=Ty2Z1ROGbyTdkWXqXY4LdQS4wReT0H8msmCV+hUWH6cCvgt6mwv9Gyv/RD2UMY7VktdCAY8U02Wp/y4D8nxyUgqeGwOCJWzcpqgOLf/1q6uImh33RUeWqd2rdwHRWHwC+51hs7xqFKfoYP0TDI8oHWQcOIOLNCIsRl0r2oDi8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714255363; c=relaxed/simple;
	bh=DvH1/PiL3n13/PINa9QwoK9Ozqun45a2d15S7CmGtkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDm5DB5DXEE+vt8VGRNS8gzTSOuYgeUDb+S7p2CiQw1c9K+kfFreIcgnrXDJiHAgHD5SqAI+IyHLUDoPWYuF7SiBypCNtE0+6TXnMyl1OqbCUXkpm33ELtBQtVyj0KtyCl0g2EWNfMcR3zV0NrgUR5b5wEg/LujxqHsA4BooJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1s0q7x-000000001EE-13HX
	for git@vger.kernel.org;
	Sun, 28 Apr 2024 00:02:38 +0200
Received: from [10.20.10.230] (port=59976 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1s0q7w-00D1HJ-0Q;
	Sun, 28 Apr 2024 00:02:36 +0200
Message-ID: <c40c7a11-6d5c-4d93-8675-93b505a38e64@drbeat.li>
Date: Sun, 28 Apr 2024 00:02:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use of Git with local folders
To: Junio C Hamano <gitster@pobox.com>
Cc: Felipe Bustamante <fisadmaster@gmail.com>, git@vger.kernel.org,
 'Karthik Nayak' <karthik.188@gmail.com>
References: <000901da972c$61efc670$25cf5350$@gmail.com>
 <CAOLa=ZQyCwJO3QhLF+_ZkFWWoQ77o+0Mdrvz8hL0j-x3fdt-5A@mail.gmail.com>
 <000201da97f2$579fa110$06dee330$@gmail.com>
 <30c5852e-c8db-433c-871b-1ae5c87034dc@drbeat.li> <xmqqv842683i.fsf@gitster.g>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <xmqqv842683i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 27.04.2024 19:14, Junio C Hamano wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> What would work in my opinion is this, if I understand you correctly:
>>
>> 1. In the Git repo of day 1, remove all files except for the .git
>> folder. This is to make sure ...
>> 4. Continue from step 1 for each remaining day.
>>
>> This will result in one repository that has one commit per day. Going
>> forward, you'd probably want to commit more often so that your commits
>> comprise a meaningful unit of work instead of arbitrary day
>> boundaries.
> 
> Hmph, perhaps I am misunderstanding things, but I didn't read in the
> original or the follow-up from the OP any wish to "squash" a day's
> worth of activities into a single commit each.
> 

I guess my brain just implied from those daily copies that there was 
just one commit at the end of the day.

Your explanation below makes more sense.

> Let me make sure what I understood from the follow-up from the OP is
> not too far away from the reality.  I thought the day's activity is
> 
>   * The whole "repository + working tree" from day (N-1) is copied
>     into a new "repository + working tree" for day N, to let the user
>     to play in. Then the user hacks away, creating commits on top of
>     the HEAD.
> 
> So there may be a directory structure
> 
>   - FBustamante/
>     - Day-01/
>       - .git/
>       - COPYING
>       - ...
>     - Day-02/
>       - .git/
>       - COPYING
>     ...
>     - Day-10/
>       - .git/
>       - COPYING
>       - ...
> 
> but Day-10/.git has ALL the history for everything.  Day-10/.git
> is a superset of Day-09/.git, which in turn is a superset of
> Day-08/.git, etc. all the way down to Day-01/.git/.
> 
> If that is the case, and if the end state of each day needs to be
> given a "label" so that it is easily discoverable, then what I would
> do would be something like:
> 
>      $ cd FBustamante
>      $ cp -a Day-10 ALL
> 
> to first prepare an exact copy of Day-10 in ALL, and then
> 
>      $ for d in Day-??
>        do
> 	rev=$(git -C "$d" rev-parse HEAD)
> 	git -C ALL tag "$d" "$rev"
>        done
> 
> to go in to each day's repository to grab its HEAD, and make a tag
> for that commit in the ALL repository.
> 
> Then doing the usual things like
> 
>      $ cd ALL
>      $ git log Day-01
>      $ git log Day-02..Day-04
> 
> should give us what happend on the first day, what happened on the
> third and fourth day, etc., as expected.
> 
> 

