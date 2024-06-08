Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE98BEF
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807603; cv=none; b=mUp5Jya5ayVS4D8fpjowad+yKerT5sU2LUt2tP6fg/1gsiZTGtnNhKgNg6QocKEt1nuR8sEUrhB8WO0Jv3DjqLhjo44661zJoGbh80fDxibeNRnvsGQ+iIf9L0yzuz8gcOgxDA6eiIOBKSffh1UTDhZuBHcxIf3Jl1q48e7OeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807603; c=relaxed/simple;
	bh=W5rT/Ny+x8UGuCbOaGTYknloOy0Q/NRPF6TnIyfDQbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PaVL2eGyH7TwiO2jAR8EAJuUss4EEpY3fy1Czfg1o6NJb1am2x5yNyBHy/Qh3KUVsDfc5aq+cywT1Zo8U8mqK+13hrOerGJt9pG9GCySO2kLWLWPku354t5dxSIKFD7zCaueKWb499nM1+h6l2wxH1AXJTdh2OzI9pN5zO7vhG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=horse64.org; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horse64.org
Received: from [10.42.0.97] (dynamic-176-007-192-159.176.7.pool.telefonica.de [176.7.192.159])
	by mail.ekdawn.com (Postfix) with ESMTPSA id BB919185CBA;
	Sat,  8 Jun 2024 00:45:34 +0000 (UTC)
Message-ID: <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
Date: Sat, 8 Jun 2024 02:46:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: rsbecker@nexbridge.com, git@vger.kernel.org
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
Content-Language: en-US
From: ellie <el@horse64.org>
In-Reply-To: <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The deepening worked perfectly, thank you so much! I hope a resume will 
still be considered however, if even just to help out newcomers.

Regards,

Ellie

On 6/8/24 2:35 AM, rsbecker@nexbridge.com wrote:
> On Friday, June 7, 2024 8:03 PM, ellie wrote:
>> Subject: Re: With big repos and slower connections, git clone can be hard to work
>> with
>>
>> Thanks, this is very helpful as an emergency workaround!
>>
>> Nevertheless, I usually want the entire history, especially since I wouldn't mind
>> waiting half an hour. But without resume, I've encountered it regularly that it just
>> won't complete even if I give it the time, while way longer downloads in the
>> browser would. The key problem here seems to be the lack of any resume.
>>
>> I hope this helps to understand why I made the suggestion.
>>
>> Regards,
>>
>> Ellie
>>
>> On 6/8/24 1:33 AM, rsbecker@nexbridge.com wrote:
>>> On Friday, June 7, 2024 7:28 PM, ellie wrote:
>>>> I'm terribly sorry if this is the wrong place, but I'd like to
>>>> suggest a potential issue with "git clone".
>>>>
>>>> The problem is that any sort of interruption or connection issue, no
>>>> matter how brief, causes the clone to stop and leave nothing behind:
>>>>
>>>> $ git clone https://github.com/Nheko-Reborn/nheko
>>>> Cloning into 'nheko'...
>>>> remote: Enumerating objects: 43991, done.
>>>> remote: Counting objects: 100% (6535/6535), done.
>>>> remote: Compressing objects: 100% (1449/1449), done.
>>>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>>>> CANCEL (err 8)
>>>> error: 2771 bytes of body are still expected
>>>> fetch-pack: unexpected disconnect while reading sideband packet
>>>> fatal: early EOF
>>>> fatal: fetch-pack: invalid index-pack output $ cd nheko
>>>> bash: cd: nheko: No such file or director
>>>>
>>>> In my experience, this can be really impactful with 1. big repositories and 2.
>>>> unreliable internet - which I would argue isn't unheard of! E.g.
>>>> a developer may work via mobile connection on a business trip. The
>>>> result can even be that a repository is uncloneable for some users!
>>>>
>>>> This has left me in the absurd situation where I was able to download
>>>> a tarball via HTTPS from the git hoster just fine, even way larger
>>>> binary release items, thanks to the browser's HTTPS resume. And yet a
>>>> simple git clone of the same project failed repeatedly.
>>>>
>>>> My deepest apologies if I missed an option to fix or address this.
>>>> But summed up, please consider making git clone recover from hiccups.
>>>>
>>>> Regards,
>>>>
>>>> Ellie
>>>>
>>>> PS: I've seen git hosters have apparent proxy bugs, like timing out
>>>> slower git clone connections from the server side even if the
>>>> transfer is ongoing. A git auto-resume would reduce the impact of that, too.
>>>
>>> I suggest that you look into two git topics: --depth, which controls how much
>> history is obtained in a clone, and sparse-checkout, which describes the part of the
>> repository you will retrieve. You can prune the contents of the repository so that
>> clone is faster, if you do not need all of the history, or all of the files. This is typically
>> done in complex large repositories, particularly those used for production support
>> as release repositories.
> 
> Consider doing the clone with --depth=1 then using git fetch --depth=n as the resume. There are other options that effectively give you a resume, including --deepen=n.
> 
> Build automation, like Jenkins, uses this to speed up the clone/checkout.
> 
