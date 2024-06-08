Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8711B978
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717877788; cv=none; b=qZVGQgsLiWuv7R1m/QUefht2f8KQioWgaDYvw59bxZWivm6EC2LFanHSltqr+awlf7e9QMeXsT60sfwsIIc4EeMGnmub2q3sLhOmDRVHwedsjn9l6I7wZ8o+RGGjaSUnf2MeeTPTjvB7670he/GbXIg05Q1uRnZy6ZYpc7t8Uno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717877788; c=relaxed/simple;
	bh=chbjvl04JAHPLYUmSW5Fv+3xohsCPCCYzLUa9pTJX+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApJ//U01Yvpc1YjDYuYBhNQJfzAtdE2oZwdnMpUn8AL2SCVzV0orTaqx9qmu7q5aGPGQ5c2tU06QvJZTJGm5HK8yTKugcsyL/Wz2xsxuofsrpNjxX2GB6altmx1hNwLt5OYhi6J2Fea8onfgLeO0ltw2XPqiFzNgJX3D32lCswg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=horse64.org; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horse64.org
Received: from [10.42.0.97] (dynamic-176-007-194-255.176.7.pool.telefonica.de [176.7.194.255])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 3013518574E;
	Sat,  8 Jun 2024 20:15:20 +0000 (UTC)
Message-ID: <15611436-01a4-4df5-a8a6-240e502128e4@horse64.org>
Date: Sat, 8 Jun 2024 22:16:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
 <xmqq8qzfcl98.fsf@gitster.g>
Content-Language: en-US
From: ellie <el@horse64.org>
In-Reply-To: <xmqq8qzfcl98.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(I'm probably not the person to answer fully. But I can say HTTPS Git 
clones from GitHub don't ever resume for me, if that's informative.)

On 6/8/24 9:00 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> One strategy people have worked on is for servers to point clients at
>> static packfiles (which _do_ remain byte-for-byte identical, and can be
>> resumed) to get some of the objects. But it requires some scheme on the
>> server side to decide when and how to create those packfiles. So while
>> there is support inside Git itself for this idea (both on the server and
>> client side), I don't know of any servers where it is in active use.
> 
> Didn't the bundle URL work originate at GitHub?  I thought this use
> case was a reasonable match to the mechanism.
> 
