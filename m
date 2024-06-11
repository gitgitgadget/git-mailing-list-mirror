Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C3172BCC
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091848; cv=none; b=fTMju6XZhHixK6jtdt+oa1ljAju6mAXrBYmC1jdmISQbPvuxB7ZCAqG7WyYSUfRoh9V10ZDttx4y5YXeue9MdmA33YN/OkfuXI45oi4tseztLjxvxF6dVeRIS1vbJYrR5hRL0cNAhwogGZclVw9dhLL8Ux7uJKKK5CLPsqLClfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091848; c=relaxed/simple;
	bh=3oYjfTOGyrExicaPMFUS+mSIeW5UU+kROiyT6aTqRS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVPNvSmPbhaNRQWuYU5GgWoweQ3on0G9EvofSo4JPm3hGmc6CJpQ7xqHyFwpbL8GkWMka9h3Jag75hgBehwW8zepLGhLtWmjty8X1zhnm5dtO/wYIfehPQwb1dW83A4PqQBsbEzTmUJ5A55l2pqmW3PWSyj0T4AjbRsdrBAmKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Received: from [192.168.5.3] (c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 45B7htYd085980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 00:43:56 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116] claimed to be [192.168.5.3]
Message-ID: <ed33cfa9-d0e2-4e98-95e9-e210b24ac337@rawbw.com>
Date: Tue, 11 Jun 2024 00:43:51 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com, "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
 <xmqqwmmw1sev.fsf@gitster.g> <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
 <xmqqikygzdgk.fsf@gitster.g> <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
 <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
 <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>
 <20240611064847.GC3248245@coredump.intra.peff.net>
Content-Language: en-US
From: "'Yuri'" <yuri@rawbw.com>
In-Reply-To: <20240611064847.GC3248245@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 23:48, Jeff King wrote:
> $ git clean -df . warning: failed to remove 
> xx/.nfs0000000002c8197f00000002: Device or resource busy Which makes 
> sense, since the kernel fails our unlink() call. Maybe your system 
> behaves differently at the syscall level?


The system I observed the problem is Centos with the kernel 
3.10.0-1160.76.1.el7.x86_64 (10 years old).


"rm -rf xx" command also says Device or resource busy
But git-2.43.0 doesn't say anything.




Yuri


