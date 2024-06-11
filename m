Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370A6FB9
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718068956; cv=none; b=qckG4EDop/h/3ab43pJCS7IE4+6xOsQagelsYUbYAFOvvOdNovCXaxuq744VOQDNrC5QsxMSl+a2kTszDInB04MVGQUl3kfrdfndIuBiIeAWevvJDFkKUj5rrcHYCn5uPEpKvEynYNpL036Qk9wWZmQr8KsgeFpK4UOXz7Io8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718068956; c=relaxed/simple;
	bh=og1f8BBRQv8QkVea9S2MfBH3Crl8WXumcipdIHkR2OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCe6gP+Htc3w67E41yEyF/k0uhUGfgFhGT3qFwZr37tnUiui6mrkM2BzbemUJMfyTG0a79666qcQDIh/4SzMk+mkKW6+VIoB2+hsRMCbuAtFDFRkKjG65VN1Au7o1vW+iHgI55bDgoYQeN8czExPZZrGq8UOuZ6zeBOAedCelII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Received: from [192.168.5.3] (c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 45B1MV1J041317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Mon, 10 Jun 2024 18:22:31 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116] claimed to be [192.168.5.3]
Message-ID: <b8f8fa08-e4a0-4755-99f0-9311b05945dd@rawbw.com>
Date: Mon, 10 Jun 2024 18:22:29 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
To: rsbecker@nexbridge.com, "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Git Mailing List'" <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
 <xmqqwmmw1sev.fsf@gitster.g> <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
 <xmqqikygzdgk.fsf@gitster.g> <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
 <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
 <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>
 <0eef01dabb9d$70c99690$525cc3b0$@nexbridge.com>
Content-Language: en-US
From: "'Yuri'" <yuri@rawbw.com>
In-Reply-To: <0eef01dabb9d$70c99690$525cc3b0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 18:19, rsbecker@nexbridge.com wrote:
> That is what I suspected. I am suspecting that git does not see the 
> .nfsNNNN file when it is performing the clean. I think NFS creates the 
> file after git does the scan, so as far as git is concerned, there is 
> no .nfsNNNN file until after the operation completes. NFS puts the 
> file there independent of git, so git does not even know about it. 
> Does a second git clean -df . remove the .nfsNNNN file and put a new 
> one, with a different name, in place?


No, *only* the .nfsXXXX file exists in the xx directory when git runs.




Yuri


