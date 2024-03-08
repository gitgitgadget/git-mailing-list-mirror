Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D75D478
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.34.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929684; cv=none; b=d3wLODmAkI58vRiBTfjRWz6mlzsfxPrEdcw4vlw09BSGmg6/96cwnxbbOhFG9KS5m6DUxUmgsAi/OleRW1IoKsNbZGWRfcDugtQRrDPwtjyVB1u3x1xWaWSOHE1b9gR9pQ2shZsi1DBTAUPLfiU3c1t0INwuJbjxY4j77GAdOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929684; c=relaxed/simple;
	bh=O9oQa1tpzy9GOyho+kLawTnZw3LDFDYfrnfSywy1DXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E19yUWZdYMwXPseysxpnrb+EY9LEG/jrRkA3cwJT5dDK33n257yp9GfKpyRTO2ne831cj8VfTeaj/ghaVen1IsNzQmRY7Sl1E9bREKn4zhpewHZfG2O6glB7BfVOwExMHAwoXm+0FKQcxp8TQVFv5Dn/zZFlu5X0BAXNBfkgsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=HNgJ0Yl2; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=D1tG0NH1; arc=none smtp.client-ip=195.201.34.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="HNgJ0Yl2";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="D1tG0NH1"
Received: from kernel-space.org (localhost [127.0.0.1])
	by kernel-space.org (OpenSMTPD) with ESMTP id 72285bbc;
	Fri, 8 Mar 2024 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=s1; bh=4N
	huhZkd9zd+u3/vs5KmcV7lp8s=; b=HNgJ0Yl2vqxVB9Qax2D/FSkn7sHjfsPhgK
	9NYs0pduDNJJluKdpHbohiXK3lX4s+PELpaZSf1XpzP3Gd1JcLdRmZRD5SjrUJ6D
	XLbiaEZQ0PnW6DFdBcdRCE5V6dSxN+QNuzf6SCmEqoWXCAs5vCURkyEFakCoJnrQ
	Y9O2/iY5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
	BepPo9o9jkwOjn/8nALueYEYQPicJvPx3OspkousHUlOUlTjOQN2m/tn/i7rmgFZ
	cGiGl02akXNy5iXPshH+XpEwrQHyOgl6c/GxZNRobxtEdcMN6haZ8929EagS3//Z
	DL2nkwNqMQXbDVop4Jqt7wjUJ1oklfvWGrFCKGBi8xw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1709929527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6mSsyId8SZckwBsBrWoQsMUeLa2hRdBbWt1KVw+LDw=;
	b=D1tG0NH1VRBdIZphzAbZSxWe05+zwBsxb8fdgif09Nq848X6Wn9jgz2YPgs/ICcd2H76jf
	WWQJt4KOXLnZEhuCgTMOvJJ29aZ0D87U9Ps6QuVaU1WAOwmgvcydIP7kyeESpYhXSOG5wL
	glbXWjuXcS3srkv2U1T4pNauaFNZY1E=
Received: from [192.168.0.2] (host-79-51-238-97.retail.telecomitalia.it [79.51.238.97])
	by kernel-space.org (OpenSMTPD) with ESMTPSA id 28c1ce56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Mar 2024 20:25:27 +0000 (UTC)
Message-ID: <d5f9235a-aa27-dc82-8191-c3e4b73ebce9@kernel-space.org>
Date: Fri, 8 Mar 2024 21:27:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [BUG] cannot git clone with includeif onbranch
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
References: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>
 <Zetw0I0NHgABR_PX@tapette.crustytoothpaste.net>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <Zetw0I0NHgABR_PX@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian,

On 08/03/24 9:10 PM, brian m. carlson wrote:
> On 2024-03-08 at 19:25:52, Angelo Dureghello wrote:
>> Hi,
>>
>> below the bug report, not totally sure this is a bug btw.
>>
>> ---
>>
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> Perform a git clone https with includeif onbranch in the .gitconfig
>>
>> Create a .gitconfig
>> with
>> [includeIf "onbranch:wip/pippo/**"]
>>          path = ~/.gitconfig.pippo.inc
>>
>> git clone https://github.com/analogdevicesinc/no-OS.git
>>
>> Cloning into 'no-OS'...
>> BUG: refs.c:2083: reference backend is unknown
>> error: git-remote-https died of signal 6
> 
> Thanks for the report.
> 
> I can definitely confirm this with a local Git 2.44.0 built out of my
> working tree.  It seems to trigger as long as there's a `path` entry
> whether the path exists or not.  It _doesn't_ seem to trigger with a
> `gitdir` check, but does trigger for `onbranch`.  v2.43.0 is not
> affected.
> 
> I do definitely think this is a bug.  First of all, we should not
> trigger BUG conditions, even if the user has done something naughty, so
> we should fix it for that reason.  Second of all, this seems like a
> completely reasonable thing to want to do, and considering it triggers
> for existing files, and that it worked just fine in v2.43.0, I don't see
> a reason we shouldn't have this work.
> 
> A bisection[0] leads us to 0fcc285c5e ("refs: refactor logic to look up
> storage backends", 2023-12-29).  I've CCed the author of that commit,
> who hopefully can provide some more helpful context.
> 
> I have some guesses about what's going on here, but I haven't poked
> further into the situation, so I'll refrain from speculating for now.
> 
> [0] git bisect run sh -c 'make -j12 && cd $TMPDIR && rm -fr no-OS && PATH="$HOME/checkouts/git/bin-wrappers:$PATH" git clone https://github.com/analogdevicesinc/no-OS.git; RET=$?; [ "$RET" -eq 128 ] && RET=1; exit $RET'

Thanks a lot.

Actually i can work with  git clone git@github.com:..   that works,
issue is only on http.

Regards, and if i can help, welcome.
angelo



