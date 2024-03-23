Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4616D39
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711187120; cv=none; b=CWJvY4f4mqVtS+gOJwnVdnNQY3j2Khqg+IOLY5p6kILvbOzwozBPsc/HYt1qJKQttttFgbsHmJOKEXuBiP5yIsUcYiAvOgMBy6Fn51aRqZ1IeehFI5btUIvjtiVvPKzJOsHLCEAXDZg2ZSBSFNw+1fGQ+BzE811V78OVTo9PFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711187120; c=relaxed/simple;
	bh=InzHcIdQhao0QhY8/pFJEV64M1yxr/7jQe8pmgpqxeU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=uVcVEwXb9+kXGbRiApdSWVtKPCBud3wv+5Kjj3MgeEmkR0kj5hFWFONYb1y1+RnjTHNTo1MwWaVgB1ZgSXjfn3/BJ/hIPABc2MaTJDBEbG5K/bMR/pjyQWcKAMzjcBFfewnvKUhQ2Xdvtxox5OhlUBm4UdSpU1KfzKkYkBum+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmU0qaND; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmU0qaND"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513a08f2263so3149751e87.3
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711187116; x=1711791916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRYwLwU3opbluRWlEiL3GOPU3wAH9ElZpK8Eiuh2aak=;
        b=hmU0qaNDeGd4nQGI9kQfdBpjGA3lXY+bntPLeo7M2gnE9xKfXiDRpFqOvMbiWICJi3
         0Ja2vX5rIqbMVm17QrI1ZM6RYqw2WmQvnuAzo4YYavwDmh0/uxUamVbNJOE5cMyA8fex
         iWoxbTorihJbJPCioyprLLaLLxqgoCNLDembqwKT8Gf5t4l92GiBrzylUvm/7ACTSK/G
         kd9IyieH5V+BTJ8+4qLkPnWx6AzAvZ5w/NEP3KYoA/qdWCkYLGvUPU3rR1mFSF+JamKK
         U4stSfmUZR1fNeI3n2eIfNHW8dKPt6g0RgBXFr5jN4UJIcuMOW8p6L51U5imHPW1TbiF
         YZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711187116; x=1711791916;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRYwLwU3opbluRWlEiL3GOPU3wAH9ElZpK8Eiuh2aak=;
        b=KrpnSRTqiG/9y7ITBg1PwRO1q69csxDy1n5d4T4ukb5SReyOcORx4flAMrV7KvbmrU
         3SWN5UhJ8fe7ugvcS8wWL5YEfgnc2rScOb2X0G28uNwjjTWT1yKrl1FHHwNOM+F+PhCl
         +VOnDBPtOCIvZxOO5TzDVMVc6ZWpZlAmUL3P7n+RCKSxcLvk7fIaJeocQLjjUfhiW/no
         K350xhHadmFP8F0oUJukfw4K5sCPnxqzqi00yMxA5h7bXK7UXGaNlmOnACPONLsOi3BO
         KyVK7jqhNmqYnIvhekseFYEc7Ff1fR4Hw8tn0LmkT9Lyz/R1YFtSZwl74QKEZCgLHTJs
         pr7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9+n1mZsKZOazfeHfpwSIe6WsVMp0cnSxETBmoGwma1UdtZiBpvm+LkEkyRHXT1InzlIcHOVcoNsVCkVZXLXR8ypZu
X-Gm-Message-State: AOJu0YzVTQiZFqmIC6Airkn72rn0NIXzY0Ovn6UKoUxaVE3rGWUlCYAG
	UZ1OQ0rFklKN9OHYYhZoLV/J0DglveytyV5RWnwctdZMX9bD0sX2
X-Google-Smtp-Source: AGHT+IEoXU/4ovsKO2INHdq0Z2LPPDXpl8msBCAvXTIvcmThMmkqO65Ed5BrnD7ktmcB9AAowXrggw==
X-Received: by 2002:a05:6512:3123:b0:513:cd23:3d60 with SMTP id p3-20020a056512312300b00513cd233d60mr1220982lfd.0.1711187115828;
        Sat, 23 Mar 2024 02:45:15 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b0041408af4b34sm1995678wmb.10.2024.03.23.02.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 02:45:15 -0700 (PDT)
Message-ID: <146fbb87-9047-4d96-8d06-76f5710ca9e1@gmail.com>
Date: Sat, 23 Mar 2024 10:45:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
Subject: Re: [PATCH] gitk: add "Hightlight commit name" menu entry
To: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
 David Aguilar <davvid@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Denton Liu <liu.denton@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 Beat Bolli <dev+git@drbeat.li>
References: <20240130085308.5440-1-rgallaispou@gmail.com>
 <27b9c158-5cb1-46bf-851a-88a02448fa2d@xiplink.com>
Content-Language: en-US, fr
In-Reply-To: <27b9c158-5cb1-46bf-851a-88a02448fa2d@xiplink.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marc,

Le 21/03/2024 à 16:51, Marc Branchaud a écrit :
> 
> On 2024-01-30 03:53, Raphael Gallais-Pou wrote:
>> When working with diverged branches, some patches can appear several 
>> times
>> on different branches without having the need to merge those branches.
>> On the other hand you may have to port a specific patch on another
>> branch you are working on. The search with a SHA1 cannot be applied here
>> since they would differ.
>>
>> This patch adds an entry in the main context menu to highlight every
>> instance of a commit.
> 
> Thanks for working on gitk!
> 
> Unfortunately, I don't understand the description of your new option. 
> How is this different from the existing "Find containing:" feature? Gitk 
> can already highlights commits that match a specified string. Please 
> explain what gitk does when this new option is selected.
> 
> Also, please explain how your code identifies "every instance" of a 
> commit.  When I think of a "commit instance" I think of the
> "git patch-id" command, which I don't see here.

It is based on the name of the commit. I agree that it is not ideal 
since the name can change between two versions.

As you stated below it is exactly a shortcut, and now that we are 
talking about it I think this is not the right right approach to do what 
I want.

I was not aware of the 'git patch-id' command, but this it clearly a 
better idea to base the search of the commit instances on it.

One thing that I wonder is that 'git patch-id' seems to be based on 
standard input. This means that in order to highlight every instances of 
a commit the algorithm would need to parse each and every patch and then 
proceed to hash them and compare to the one referenced.

Wouldn't it be a tad long to process ?

> 
> (It looks to me like this is basically a shortcut to auto-fill gitk's 
> "containing:" field with the subject line of the selected commit?)
> 
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>>   gitk-git/gitk | 23 ++++++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>> index 7a087f123d..4b15230a16 100755
>> --- a/gitk-git/gitk
>> +++ b/gitk-git/gitk
>> @@ -2672,6 +2672,7 @@ proc makewindow {} {
>>           {mc "Make patch" command mkpatch}
>>           {mc "Create tag" command mktag}
>>           {mc "Copy commit reference" command copyreference}
>> +    {mc "Highlight commit name" command highlightcommitname}
> 
> This line is indented with a tab, but it should use spaces.

I will change my setup to use spaces instead of tabs one this file.

> 
>>           {mc "Write commit to file" command writecommit}
>>           {mc "Create new branch" command mkbranch}
>>           {mc "Cherry-pick this commit" command cherrypick}
>> @@ -9002,13 +9003,13 @@ proc rowmenu {x y id} {
>>       if {$id ne $nullid && $id ne $nullid2} {
>>           set menu $rowctxmenu
>>           if {$mainhead ne {}} {
>> -            $menu entryconfigure 8 -label [mc "Reset %s branch to 
>> here" $mainhead] -state normal
>> +            $menu entryconfigure 9 -label [mc "Reset %s branch to 
>> here" $mainhead] -state normal
>>           } else {
>> -            $menu entryconfigure 8 -label [mc "Detached head: can't 
>> reset" $mainhead] -state disabled
>> +            $menu entryconfigure 9 -label [mc "Detached head: can't 
>> reset" $mainhead] -state disabled
>>           }
>> -        $menu entryconfigure 10 -state $mstate
>>           $menu entryconfigure 11 -state $mstate
>>           $menu entryconfigure 12 -state $mstate
>> +        $menu entryconfigure 13 -state $mstate
>>       } else {
>>           set menu $fakerowmenu
>>       }
>> @@ -9481,6 +9482,22 @@ proc copyreference {} {
>>       clipboard append $reference
>>   }
>> +proc highlightcommitname {} {
>> +    global rowmenuid autosellen findstring gdttype
>> +
>> +    set format "%s"
>> +    set cmd [list git show -s --pretty=format:$format --date=short]
> 
> Why bother with the $format variable here?  Couldn't you just quote the 
> --pretty part?
>      "--pretty=format:%s"
> (FYI, I am not a TCL/TK coder.)

I also am not a TCL developer. I pretty much duplicated the 
copyreference{} procedure to get what I wanted.

Best regards,
Raphaël
> 
>          M.
> 
>> +    if {$autosellen < 40} {
>> +        lappend cmd --abbrev=$autosellen
>> +    }
>> +    set reference [eval exec $cmd $rowmenuid]
>> +    set findstring $reference
>> +    set gdttype [mc "containing:"]
>> +
>> +    clipboard clear
>> +    clipboard append $reference
>> +}
>> +
>>   proc writecommit {} {
>>       global rowmenuid wrcomtop commitinfo wrcomcmd NS
