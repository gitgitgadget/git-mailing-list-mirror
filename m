Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E0358388
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073103; cv=none; b=RGLfi/o2KpODIEW/fO8A2WZHykshDkIJFlTj6W9MhMZ3h8lSpa8AuvLHIBad+zHf7yKfJFxAioMhg/EuWEwErLR+Yeb81+yP/D1+DCQbi7ewY+T36P0aWc2pJR3/VM0wX1fc4RXDjt7mPTJz2GebVhovKeUg8dNtfWyiuzPemBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073103; c=relaxed/simple;
	bh=0G7QnzyWRmNozCjV1M1KVQjsOuBw39K6508OlCzbOgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alJFc1wW6H8GvKy1i23EzVA34BFrppjDho5Va73INujcPu+HUbwfe9CubY6AngTyijESJK82X2rAs/iWnZNJ5YH/2iTNr+qzb+na9khPck5EK2JIP6N1XIuiGLkNT8Y7g/BIhbx276b4L/DtLxuq4JB6VzvgrAPJ6NbLswF8alw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIZukkYu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIZukkYu"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso212303f8f.3
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073100; x=1783677900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IrHZdmNN8/JQ59XXV6GoxCe8Fc826eSBxAy2gA46YsQ=;
        b=SIZukkYunpcx1jvqGoBw5Z06wwDZp4oaE7pkH+P/BCUceMPnFl3p0/RLpbJ6M4Dta/
         uVDzoN7tbZm3PB1RyknRkEgy6nbup8hvTbtZlGGH/HAHnLb01rQlE6gAdQ2l2kY6w3Vp
         uEsXezr7IUGaJdb3cJ/FrmGl6O1aG7ivMB5RYtXDSCWRKnURGvOUcGLiDgwf0KYouhzo
         ujTf0bnAyzfmfbgrc52/33qisaHi/1h5H+AJZUWgDnugrYIkX72uYF3HmN/lIV6o1zgu
         3hgmcnr5qC8iKdQRfLjPybxPDIsJeSsJOmx2HFrFE3LZVoF/wCVA6srHnGnxO53H9NLd
         r8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073100; x=1783677900;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrHZdmNN8/JQ59XXV6GoxCe8Fc826eSBxAy2gA46YsQ=;
        b=DRtByvpluaKzhr9eE6d1wtWteiI3PXLjOy6jbbrhJYgo6A0goH+fUsS1Fue+6JRRJx
         drgYLzJrHgsmLusKmJoRkOzVAUA13Fed7imH4CaAiZffH1LRrTWg9QkEJJmg+yV0ozWR
         I7163933MAXpkxMFzsaI91BNwA68umYxtjzWOo6KhuWv3tt+GQ8u+HAmphYznAhyKfmf
         sq02KQTyPlIzMP7waCwE9GHbFNTO3GoDfu4Opma5xmunFVTMlTDMKBIFEnVyqN51SZX4
         4StKCSC/4PY0g+YPd75fakwmq0FsBx9dhO0mgvhGKfzRP8Utwk80HZlXksXzD667vvbb
         sTRQ==
X-Gm-Message-State: AOJu0YwSq85rndnp23N33KNk+5neSnLUA4dCZDTIn5Eyz1VMhec3gCNw
	H8a/vYc8a/gzNERxQWQZBQrU5mMaSkz28rpPg1cEjczCEFLIF+FGAkwS
X-Gm-Gg: AfdE7cnqqZigP7VIbRpD+PzpRtd5c47MRfBrqiJhrLLPkHHJKdEcTITrSVoOCeRwc8K
	UXbFVkmx0vG4SzoLpPkzYNAHjyHAuXAl+90iwdcxQnwoMMi3qLKmPGwEA8WpzMUp+GHQryWfJVa
	Kd3RIxTBKGmmjkhHAbjehQRQJNKhkJIZgY3UjSqfPnfHpF0gdvqOcmAhdlNSWjugw0gu3vs6PX2
	vjfWAgG9W2pzCC+5N07AG2QpRXTYvQETQOZBI76VS/E8nce6AXL4DkQrq23dDYcvLHp8NKH8+oZ
	TNghogCthZN3CKWbgDedtintquQWEcToOup5h9aFaE4w7Uknlh869XmuJdkNGyKOSkqa4UckPtX
	1mNz2Kzub6O6dcCHTJhSAqu7VMi0ssxbgsyEcuN23SgzRGibSO3FAMGT/WMPobsQujT0WxqHHWx
	2bLHNWc6IazYcQ3JQzktNjgswD+UpOWsJz3KoYwHVsISxlQep8h94TEhGOAwtZIA2gZqOSg42z1
	eKuLw==
X-Received: by 2002:a5d:5f54:0:b0:472:3090:d878 with SMTP id ffacd0b85a97d-477571cb785mr14187021f8f.4.1783073099973;
        Fri, 03 Jul 2026 03:04:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94cec5sm16221144f8f.19.2026.07.03.03.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 03:04:59 -0700 (PDT)
Message-ID: <5827a94f-0f13-4747-8257-b67fb9d79ecd@gmail.com>
Date: Fri, 3 Jul 2026 11:04:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Unexpected recursion in 'git rm'
To: Patrick Steinhardt <ps@pks.im>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0J/Qu9C4?=
 =?UTF-8?B?0YHQutC40L0=?= <eugene.pliskin@gmail.com>
Cc: git@vger.kernel.org
References: <323134122.20260702104910@gmail.com> <akdzSHrJ4DfdUWoS@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <akdzSHrJ4DfdUWoS@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/07/2026 09:31, Patrick Steinhardt wrote:
> On Thu, Jul 02, 2026 at 10:49:10AM +0300, Евгений Плискин wrote:
>> Hello.
>>
>> The following git command does recurse directories as contrary to the
>> reference (https://git-scm.com/docs/git-rm):
>>
>>      git rm -n *.json
>>
>> Without directory specification before '*.json' this command is not
>> expected to recurse directories, but it really does.

Are there any ".json" files in the directory where you're running this? 
As the glob is not quoted, I think maybe what is happening is that there 
are no matching files in the current directory so the shell is not 
expanding the glob as you expect and is passing it to git which treats 
it as Patrick explains below.

Thanks

Phillip

> This is expected behaviour, as the argument to git-rm(1) is a pathspec,
> and "*" matches directory separators by default, see also gitglossary(7)
> under "pathspec":
> 
>    • the pathspec up to the last slash represents a directory prefix. The
>      scope of that pathspec is limited to that subtree.
> 
>    • the rest of the pathspec is a pattern for the remainder of the
>      pathname. Paths relative to the directory prefix will be matched
>      against that pattern using fnmatch(3); in particular, * and ? can
>      match directory separators.
> 
>    For example, Documentation/*.jpg will match all .jpg files in the
>    Documentation subtree, including Documentation/chapter_1/figure_1.jpg.
> 
> Could you maybe clarify which part of git-rm(1) made you think that this
> wouldn't happen?
> 
> Thanks!
> 
> Patrick
> 

