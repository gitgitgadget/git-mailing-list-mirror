Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE71AF6A9
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904260; cv=none; b=LSwRTNaMqD5r0s+nOEarKB+v+0bOD/CwZjw34cciWUjmiwfV0bS0WPSvKEdCIHE1Q/IFVdPJywz+k9+ajHz4h53pepNU6oPIQf2GaZDI670l6tmR231VW2mK3kHhY7WPrRcm04H3IbmaOhyEQAGEmEgPi3lN7vCSkdXLBZ5M91g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904260; c=relaxed/simple;
	bh=1Devkux3Vz+8hi1HbmIVnugJd6XloNqhgwBjGrW0/JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StaC5HHUGEZYw1M3R7CL7flNgNRQT5Vd7jXtn/j1U09qe8CYp1scnE+BcePB5rJ6F9u+ricvUUOpyYI8P/j8harCy7Kr4W3Tn9yb6ScCTz3Cf80icwzK2cUNNmMZX0lMcsJHBqFax+IPbgKcb/Uw5Q34y9RnmZ3ioPPEGT8Ih24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4W4nQz51KJz5tqy
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 19:24:11 +0200 (CEST)
Received: from [192.168.0.105] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4W4nQq4sNkzRnPt;
	Thu, 20 Jun 2024 19:24:03 +0200 (CEST)
Message-ID: <abee589d-5bad-4376-ba91-3bd611936983@kdbg.org>
Date: Thu, 20 Jun 2024 19:24:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix default font scaling
To: Serhii Tereshchenko <serg.partizan@gmail.com>
Cc: git@vger.kernel.org
References: <20240615085345.47278-1-serg.partizan@gmail.com>
 <5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
 <Q1B6FS.FVKOG950Y3UN@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Q1B6FS.FVKOG950Y3UN@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 16.06.24 um 14:37 schrieb Serhii Tereshchenko:
> On Sun, Jun 16 2024 at 12:30:51 +02:00:00, Johannes Sixt <j6t@kdbg.org>
> wrote:
>> Am 15.06.24 um 10:53 schrieb Serhii Tereshchenko:
>>>   font create font_ui
>>>   if {[lsearch -exact [font names] TkDefaultFont] != -1} {
>>>       eval [linsert [font actual TkDefaultFont] 0 font configure
>>> font_ui]
>>
>> My setup does not have a 4k monitor, I run KDE and I do not know if I
>> have changed a DPI setting. For the test, I have removed the [gui]
>> sections from my configurations to ensure that the defaults are used.
>>
>> Under these conditions, this change does not make a difference in how
>> Git GUI appears. I assume this is the expected outcome, so I take it as
>> a good sign.
>>
> 
> You can test it, by changing DPI in `~/.Xresources`
> 
> `xrdb -query` to see your current DPI, then increase it a little.
> 
> ```
> Xft.dpi: 154
> ```
> 
> `xrdb -merge ~/.Xresources` to apply new scaling.

Thank you for this recipe. What is the expected result on the font size
with small and with large DPI values, with and without this patch?

- When I set Xft.dpi 100, I get tiny fonts.
- When I set it to 200, I get huge fonts.

And that is the case with and without this patch. I expected that the
font size is independent from the DPI with the patch. (I run ./git-gui
after `make`, but without installing.)

I also see the change in font size after modifying Xft.dpi in gitk, BTW.

At a minimum, the patch does not make things worse.

-- Hannes

