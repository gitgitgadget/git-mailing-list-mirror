Received: from seshat.vectro.org (seshat.vectro.org [212.24.108.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECFB19CC20
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.24.108.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109296; cv=none; b=CXR1tpS3ONskIjTUY+9x3c5+NoDaVgJ6/QWoDh4UhB0hdNxyMiD3JrS7OUjHFsS0GCfqVdytHZ5s493Ewl1/IZ34ByJFcYxZFwhO/YBZ47bSrMmE5PDaXo5/pHEyD1SWYXf2OWfqdu73AZYW3PyifsJACHNgE6wOOQI9qarel3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109296; c=relaxed/simple;
	bh=N67WL/rG5rZ8WwZ3cIUn9vpK4pFPg00vrtipCbd+1Ak=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Twf2hWJ5erZZYjbYgmMT3h0zbSSBBXetSMtYIu28Bqnt8L1KABZhFfSihKL+pW9easKQhsE2S1fXyS2hYT2jaiDx7i+Ui0tgx6WlG+k7/zbXf9gQtDXxzDfvKJw9q/jx+/x66CUGG0HdzFfo6fLAPciUvK/icbD5pzYtU/lFGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vectro.org; spf=pass smtp.mailfrom=vectro.org; arc=none smtp.client-ip=212.24.108.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vectro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vectro.org
Received: from [IPV6:2600:8802:3810:ca00::1975] (unknown [IPv6:2600:8802:3810:ca00::1975])
	by seshat.vectro.org (Postfix) with ESMTPSA id 15156100847
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 19:29:10 +0300 (EEST)
Message-ID: <d8512f2b-400f-4daa-a59f-5d10d4fc3840@vectro.org>
Date: Mon, 23 Sep 2024 09:29:06 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Ian Turner <vectro@vectro.org>
Subject: Bug report: Undocumented interaction of --exit-code and
 --ignore-space-change for file move
Autocrypt: addr=vectro@vectro.org; keydata=
 xsDiBDfkgYERBAC7vHU9ULWvDjKn/RzM7vdPwo1grC+rVzbKQ+TEX9kZL2KK7+oQ0dufGbmC
 ZBaja2Uqn65Qp/e8ZFwtgR3UJ/8aae1iGpi6svvYqJukHEEcoe3Ja3F9cmya1WoefSP1w+KT
 AsSvVM51SfBHSANum1sjY/cICFI9YoCdcRKYCk5XVwCg5w9GWjRELr/0pfL56sXmXG3KxnEE
 AIOkn189rToLi/VAq+ndPcPxI+iPz+bKO/CtHSkuQB/nGeZl1SEzpaWI/vwLChrdtEKabkpQ
 kfge6AHxeizhsxvfSee2EHjS5ZafEy/uTlSupQhbP4sCca8WwXnuCpObDu8wJYhtrukjtr1e
 9Y05FrAvpOBITpqGdhpdcWMybTWrA/43MM1fjekgPol5Ket76Zzwv0E64BL/h2wAahPU5bl2
 yJ/7Os2S9hqAYPQzyEnvGS8mHTgZPEelyeBrpfwDvr3mxzI16eebLCVaJF8il/16vpqwuFf6
 Ybo3VRvc5lzjIqf8pqEBlDVl8wv4vKtNZshSLlT3A0VWpJ34K23C5GadhM0eSWFuIFR1cm5l
 ciA8dmVjdHJvQHZlY3Ryby5vcmc+wl4EExECAB4FAkGIebkCGwMGCwkIBwMCAxUCAwMWAgEC
 HgECF4AACgkQfn9ub9ZE1xrtVgCfbhjp9jueTt06DX37oGAaIvadpTIAoNw+dxuv9kc9jfdG
 /Sm4Gx4zOmByzsDNBDfkgZwQBgCYlCAzRCUQb4cwQWkyFBN/2AszQd7iF2jGGk4lwF1wOGuY
 YxJ7g8UPNbN+SyYcx7x8j6JOE/tjgqGWXkSIl0ztbQsqVVkZ2frSn4De3tZ28sl/mp803lJn
 ZEHv2ZyMudVrzsja+jxf1L9DHyICIZWmMMnYgiWnXbj/YqGGnQC6o+ep9jGBbYU1xmEvePUL
 h0E26Etl33Ux/90c3w7Y8rs+hoKLD9/+XDFfxrX+U38MYE4SUmkbI9ocV/li0T8OFCcAAwUF
 /igeZYOgYVQmZx3XAW6IT4WUhAOcsnV3owKeWV+sIN56dGUDTwPfPuASiwwpCe7pf14rFqIR
 Ni+4I5LFrukqRffFTP/0uVlir2Igdas8d+TONo48y7U1vAHoZLIRVPitSKaVvpX76J6nXwke
 xONWsl/H0wyUt5xA2biqUmp9EHxigPe99R5Mu3Aq/0JGAW6M6CnCQYOszayKvXO7ybWKDw5Q
 Wu/HBMOvesOrTN2waL6NKMh8pBph+/oR0jYZxPJYYcJGBBgRAgAGBQI35IGcAAoJEH5/bm/W
 RNcaupAAnR+BFmDXaDCBVGeFtI/Q0O7aSpBYAJ4qONtheNt7UTA8WDfF5fRc+BId1w==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I noticed that there an undocumented interaction of the --exit-code and 
--ignore-space-change flags to git diff, when the diff only contains 
file moves. Specifically, --ignore-space-change will cause git diff to 
return a zero exit code in this situation.

I am not sure if the problem is with the command behavior, or with the 
documentation.

STEPS TO REPRODUCE:

git init
echo foo > a.txt
git add a.txt
git commit -m "A"
git mv a.txt b.txt
git commit -m "B"
git diff --exit-code HEAD~1..HEAD # returns exit code 1
git diff --exit-code --ignore-space-change HEAD~1..HEAD # returns exit 
status 0

EXPECTED BEHAVIOR:

Both of the last two commands above should return nonzero exit status.

WORKAROUND:

As one might expect --no-renames undoes this behavior, although it also 
changes the diff output if not using --quiet:

git diff --exit-code --ignore-space-change --no-renames HEAD~1..HEAD # 
returns exit status 1

OTHER INFO:

Tested this on git 2.39.2 and git 2.41.0, both on Linux.

Regards,

Ian Turner

