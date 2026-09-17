Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01103DD85C
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643269; cv=none; b=rM+/0VFkhKsejiD37nT/f6IfbN7mUjAndInjxrPjz6b0vstKAdsjBlsKc5Hrdl6hqpoLpLiAWWN+4DcKNoYdMZsvKKYZzi+O8cCA36eN96ktww30EZdsmwPakyKj1Y4/zEuCF7Su1zX98dQDqXRS/1xhNgW7K/d5bu8vjeFi1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643269; c=relaxed/simple;
	bh=bWI9Uf1snK0WibXMGfB01k1egyBfTxPHT5Fn1GqCqM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtVgMessxzUhWDxDJ4/VeOLxfPPyxPQBj1KsUMu2SgRten7JcagqPMAm4uUipDQwm3R9vaT14Mew2ISNxRtSqFCKuKfPBE6gr0LbcNxqW5Mbn2FNveD8pE5FBb4i7YPIhbfYyil/uPKj/2UqR9KRENNDKugjM1O092VuKf6tkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8OPHSuW; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8OPHSuW"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc515bef69dso389487a12.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643257; x=1790248057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RSaCWT7txK1EcS/Y/vmWV3lVHZNaEQVQ+ks1jFCukP0=;
        b=F8OPHSuWVd+UA0LFYTvqu9a2ng6ymLtJfOPHr61E/TC9pmzr9DVeGYTImbEffljb3b
         ASaCMsxdooj/uZDBp+OLONZVkZNoR/uvSXX/ZnmwPEfyGc+AhSiZf6SLTT0P6XLCXEZs
         qt6bqbOC49r8zKdvTB0eOUwVn63NabnslJynQ/qejP21zyktK2yPspviyt4/GWw0Ax32
         lq55Zby3RMuttYu16TN+D9CTbS8xd1tEB8kUQg5ZIlpgCJ3MzVXcjJghHup1gvKlrAxl
         o/Sl4JIPZZ7YRAojtx9ajmUtQhplpRaoVpL/v7xMgus/Vm4dR0VNnzLUomVeiLtwiKhK
         lxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643257; x=1790248057;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSaCWT7txK1EcS/Y/vmWV3lVHZNaEQVQ+ks1jFCukP0=;
        b=E9gj5TNKhFNH0Sb1Z/UP94o5mlqBAF9OBtYZNli3xHb8gDcKUXVMCRj/NUqM49p+46
         sDhws4DYXh7tCtrOgFsXlWIZX/fm2ekCSOsmFWuUmI4Gf+DgsQ8fje0kHypXY6nnNdUK
         1rrjXsMpKZrlx8y5ZpqymLScd5hXFfyrUlwxT/YjtV1+pe3mhv1jbCDK1VYLB2Zeudcc
         CPTuhPKSoaUP45sGvyU/CFxzAgre1BqXAdTdM18ZNqWKj21HUGNzggTximf6BatEE4Nb
         kHDh62QKBncdCFSezIa1QxWTF0jG9s9YQhB1XboHZwiKNfUhDXHVHPfj/bSOXdoREV9t
         LVMA==
X-Forwarded-Encrypted: i=1; AKwUvBwkS8PmWgvd5f+OgB5F8C1G08NcF9k9lORhyZsDceoeFA8eRzLy/fGo/CiYedx5NsKAAIM=@vger.kernel.org
X-Gm-Message-State: AFuF++lwHosRTjsr9K4wbnrjLl80bXTUvGPEYgyYCnPHcRaY9idLl4CT
	1la/5dGNjWUXghUfdg35RYXry61Pedw8x+EvZgNB+VxGkMTdKbNKZyJtmhhv2Q==
X-Gm-Gg: AYBFou07z+4+0sYsc2DZmVOfP15Qn+hRZBZY+xbeoLkY6fNcBBHHSwsBfahP2iCs2Jx
	Iatj2LTa8Sgj+QVGv0C/1iwmIiWDbkm2GZ1UtmETTG88FGvF0y1UHCpddjA17HNpHtQdBGsSrXT
	43CuWAziLfPffb4D5KizY3I4g2ra08MSrJm/I/CmwNRX/N70J+IBl5EefmwvKFddglf9XErxV/+
	x4pq3Z+8y9ZDvowADEhVFIm3T7YhKZTFaDTST+KsWFBciLqn5tvFbt12RkwXcfWS2ZUfqN7rst5
	hatHfkN0A0WHzDGI5ac0xko7JBB2Y2IZf0wX1+hlX0DPqTKgX93jSpmTcAeMn/rJmJ5+WbnPkab
	XiPMw9DAVLQYqSXiO714tEc5IDjrGYj0W3dLZW3jm70d1jz61g1X6OOHCkafH8+7jnG0pKEzB8B
	OHO6ZJ+pe+SRmuN6VmfOaLRw42RBb/N6oISZNXvBfcsgRlN8drtlETcJJOYIGkL7CfdW7jtp3fW
	lcH3Ekm4P2wmjg=
X-Received: by 2002:a17:90b:560c:b0:399:1f8b:d255 with SMTP id 98e67ed59e1d1-39e1e277431mr14666564a91.5.1789643257337;
        Thu, 17 Sep 2026 04:07:37 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a1a5sm16076423eec.5.2026.09.17.04.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:07:37 -0700 (PDT)
Message-ID: <fbed7a60-57ab-439b-a550-2d2b76ff24c0@gmail.com>
Date: Thu, 17 Sep 2026 16:37:33 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Participating in Outreachy's December 2026 cohort
To: Christian Couder <christian.couder@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git <git@vger.kernel.org>,
 Git at SFC <git@sfconservancy.org>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>, Tian Yuchen <cat@malon.dev>
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
 <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
 <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
 <DLEWITFIKFFK.NSANTRY5XBCB@gmail.com>
 <1b904e64-e681-4744-b83e-690f3ca94ea1@gmail.com>
 <CAP8UFD3kd=6QHp2oB+t+g-2D8bY-Oe5+_Vk+RJeaCa_xhxGrsA@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAP8UFD3kd=6QHp2oB+t+g-2D8bY-Oe5+_Vk+RJeaCa_xhxGrsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/17/26 02:28, Christian Couder wrote:
> On Mon, Sep 14, 2026 at 11:41 AM Kaartic Sivaraam
>>> I've applied as co-mentor for the libification one, this way we have at
>>> least one mentor for each project.
>>>
>>
>> Cool, Pablo. I've approved your application and also Usman's. Right now
>> we appear to have 2 mentors per project:
>>
>>     - Reduce Git’s global state to enable Git's libification
>>
>>       - Usman Akinyemi
>>       - Pablo Sabater
>>
>>     - Improve how command arguments and options are scanned and parsed
>>
>>       - Christian Couder
>>       - Siddarth Asthana
> 
> Great, thanks!
> 

Just for clarity, this is tentative mentor allocation. We may need to 
shuffle it a little bit based on the applications we receive. We'll see 
how it goes.

>> Given that we already have enough mentors for both the projects and I
>> have some bandwidth, I wonder if it would make sense to also propose the
>> projects that we proposed for GSoC but were not actually taken up by
>> anyone. The following are the projects:
>>
>>     - Implement promisor remote fetch ordering
> 
> I think it's indeed a good idea to propose this project, even if it
> seems more difficult than the other projects we already propose.
>

Thank you, Christian! I have proposed the project. Kindly check and 
approve it at your convenience. We have until Oct. 5, 2026 at 4pm UTC to 
approve it.

If anyone is willing to co-mentor it, please chime in.

>>     - Enhance promisor-remote protocol for better-connected remotes
> 
> This one seems even more risky and difficult to me. I would suggest
> only proposing the previous one.
> 

Cool. I've skipped it for now.

> Anyway as you will mentor it, feel free to propose the project you prefer.
>

I will mentor it but may need some help / guidance from you as you have 
a more experience with this area of the code. I hope that's fine.

-- 
Sivaraam

