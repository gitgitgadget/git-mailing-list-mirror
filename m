Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D1181AC8
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718062056; cv=none; b=eDDwqpnkqOAPPu5NZHg0uZ6MFUDCgR87KA+Wj9k46UUwsnbhuDPW8Wcu8EdZ+REcKhZfiUcOXK89kDNNaFuRgOYxCfIcUePEKzJAvttt1LHiQgP5llJAgExb8Sacq5vDbk0HcA3cacM1SllbxPic0kAjM/B3a7DW1Y0Wy1Dluis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718062056; c=relaxed/simple;
	bh=qWFM/aEWByZgBMpVByuUfdhMj1FgoTO4/f5i+0xA0vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GInwk7h9O+zSISUsL0cBkRUgfwfdnumA+Ykg30Lz6WNql2y+xwrwkXjIcDTrutqKvIa/SJn5MUaDzEU2IjsSzOUxhl/exhWuuCIodg05Pb1RqgZkgbcKFhBMcKZcNSePxusYmkgdo3sQQJi4GBXeso9eNBGb7I6YpdB2SQcY1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Received: from [192.168.5.3] (c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 45ANRX0q017332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Mon, 10 Jun 2024 16:27:33 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116] claimed to be [192.168.5.3]
Message-ID: <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
Date: Mon, 10 Jun 2024 16:27:32 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
 <xmqqwmmw1sev.fsf@gitster.g> <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
 <xmqqikygzdgk.fsf@gitster.g>
Content-Language: en-US
From: Yuri <yuri@rawbw.com>
In-Reply-To: <xmqqikygzdgk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 14:37, Junio C Hamano wrote:
> But .nfs* files are not something you as an application are not 
> supposed to touch, so a directory that still contains one cannot be 
> removed, either. It's a limitation (I wouldn't call it a "bug") of 
> NFS. You can kill the process (or wait until they exit) holding the 
> file open and then run "clean -df" again, perhaps.


With the '-f' the user tells git to remove all, and if this doesn't work 
git should tell the user that this didn't work for the .nfsNNNNNNN file 
and for the directory as well.


Why is git quiet about leaving the files. It should complain.

Or maybe there should be a verbosity option, like -v 10, that would make 
git complain about such things.







Thanks,

Yuri

