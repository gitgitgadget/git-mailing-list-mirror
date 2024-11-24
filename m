Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A485C2500C2
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732476457; cv=none; b=reBSsGjIaE1LIkJEfbTVn2SxW4nuwl+QGDNU+pmtn6XXza03gvW7fXXStAYXPjA26hFUZm0s7CEv9zDWING3lhwlhIBn3TZN3zSTEWmXqbxW/s5kzhIDeLTad3MUy+Koi5XmXakymIt72KETZlweTysBGWXBH2IK/Gx4D6EtxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732476457; c=relaxed/simple;
	bh=GGUrhlD5PLWDJluD/onX16ixMCkT3p/k3RT88TPEICY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VoyG1FVhcgHJ/mKZFGvVSg6qrnh3kJ8WChznyDti5VbMUUhDghF2dQHkKJd4qtN+Wu6yigyqn0xFV8uf6LDNMZkNyc6OD+yWSWSG74jrsyGFOT5a9NLjjoUq0q6Mb7/kj2qPKm74jTFwB5xXn03ghGQLseN07QyI1b224vsOnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxkauQPc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxkauQPc"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431ac30d379so34588805e9.1
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 11:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732476454; x=1733081254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTmjcHwInbdLmIcVgfXNZZwGwETGScJqV0zQNdQFVBs=;
        b=KxkauQPcDsUO98klzKk9l8CIwIM2qmrbADaIw1LVWMTflBdk5KnBF2vxhzA/iYrEVe
         D9N9hvLWZCVjwHtOUVgwihI2tfsAZJd3Vw1llkXElw0R/S99Y0EDUOeHH8JN2NGSnzL/
         2BOqW9AX+o1iSVwajer9EgKwlgTvysq/bUynd7s6+cLmNC+vUujCOCJAWueFteilTKIp
         otdNdcIJxLREgBYOEYwQwzx/z+pEFJZFCeci6Zsp3J7Jsyba3MlbnZi3eGgm2Bz6NRvI
         jkAsVFyYg/VT0kRZIoE65669RFiWKQ0rARNgkqIYUxAmRktJPYpbzlOIICLGe1TiTMag
         bjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732476454; x=1733081254;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTmjcHwInbdLmIcVgfXNZZwGwETGScJqV0zQNdQFVBs=;
        b=d/MDkjk35bmNUxTAkyyhb25tPymSzcRNQdJWGhiDNVlFlxjGxLGcncO+cCVEUFPh9S
         i3DfSz5Q86idsyI0R73u8S3LUpCtxkQn05Yf+HC81NA3K2inGqY3DtuayRyLeMcAmgyU
         98/FiMADarn9W6RIiHh5DG94qjTzhTP8cVv1AowAon921W7QQJN8FY7MT4VJB1CRRdVD
         zjklFJTFv0G+XEwJgi+XLULE92V53Qsi14M4WSZUNSDH1fzFwhDomzf1noUrMGXjJnlP
         fYz/RTGMhO1rzUzSBnOp1Rbc9HPAQ8SdJNuBkgk8k7KIwHyIvMSd24J7TRTUZLml7E7h
         eP3g==
X-Forwarded-Encrypted: i=1; AJvYcCWXobVBXp9Nyg/4ERbky0Xb6QqRzcdmtZbw5bXnASpEhsOMJUHCpDLMP2aGKexBFmSY2cI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15rM5BeYO6d97yEtmmB+xH4FLmSv+axY8wrxSl5mF/zz9h0Wg
	R0W/zp+74KbKGaXxwlXQyoxfgWlsM5r/A0BG+Pef0fltQ9aJzSUy
X-Gm-Gg: ASbGncvBubYy8XTBsnvtX6LRsBMsmQMyjBirtiWEPgjjc22iIVJm850V0wY93Z85p6L
	fTixXOIdR+vgxh+0uwZJ6jmCSEuXeiFBTAeri082mdFR5KsV8g8LP1nzz1wguKaoRPVHNV9JvhO
	3erJcdeut3rI3p91aGxpDFaNw+VFAggC3SFSsnNtR6Nl8NRqGcXgjuDfD5PpQ4YBfV4+cuHdgO8
	OkzEBqfz+C2BsKrk3pzU9HHW6YcaYAtypU13ItZ3vFoq/Yrax99wifN7fQeoLJqoWBk8jf0lQEn
	L8sQZsXo3RmfA2FKl8KS4xuwVZCY
X-Google-Smtp-Source: AGHT+IEpKKfSWwVs7UuGvK0R2isLhRnsUNltlmbVFzRGxAlTRygMUV6OBhe7k3qo3YuQj9SqXW/NbQ==
X-Received: by 2002:a05:6000:1a8c:b0:382:49f3:4f8e with SMTP id ffacd0b85a97d-38260b5a6ccmr8420859f8f.18.1732476453755;
        Sun, 24 Nov 2024 11:27:33 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b? ([2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349e80e51esm20904995e9.33.2024.11.24.11.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 11:27:33 -0800 (PST)
Message-ID: <60325a17-82e3-4a4c-a6fd-d3b597f1c2bc@gmail.com>
Date: Sun, 24 Nov 2024 19:27:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 7/8] worktree: add relative cli/config options to
 `repair` command
To: Caleb White <cdwhite3@pm.me>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241031-wt_relative_options-v4-7-07a3dc0f02a3@pm.me>
 <135739ad-6722-449b-9f9b-31c0bbc9f9cb@gmail.com>
 <D5TBGJS8FWBE.3QYEZWZUS0C71@pm.me>
Content-Language: en-US
In-Reply-To: <D5TBGJS8FWBE.3QYEZWZUS0C71@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 23/11/2024 05:41, Caleb White wrote:
> On Fri Nov 22, 2024 at 9:55 AM CST, Phillip Wood wrote:
>> On 01/11/2024 04:38, Caleb White wrote:
>> We used to update only the ".git", now we'll update both. In the case
>> where we're changing to/from absolute/relative paths that's good because
>> we'll update the "gitdir" file as well. In the other cases it looks like
>> we've we've found this worktree via the "gitdir" file so it should be
>> safe to write the same value back to that file.
> 
> Yes, there is an edge case that a file is written with the same (correct)
> contents, but I think this is acceptable given that it would be more
> complicated to check if the contents are the same before writing (which
> would involve reading the file).

That's fine - it might be worth explaining it in the commit message 
though (the same goes for the other patches where we start writing both 
files instead of one).

>>>    	strbuf_addf(&dotgit, "%s/.git", path);
>>> -	if (!strbuf_realpath(&realdotgit, dotgit.buf, 0)) {
>>> +	if (!strbuf_realpath(&dotgit, dotgit.buf, 0)) {
>>
>> This works because strbuf_realpath() copies dotgit.buf before it resets
>> dotgit but that does not seem to be documented and looking at the output of
>>
>>       git grep strbuf_realpath | grep \\.buf
>>
>> I don't see any other callers relying on this outside of your earlier
>> changes to this file. Given that I wonder if we should leave it as is
>> which would also simplify this patch as the interesting changes are
>> swamped by the strbuf tweaking.
> 
> I'd like to keep this if that's okay.

Let's leave it as is and see what Junio thinks - my worry is that if 
strbuf_realpath() gets refactored in the future it could break this code.

> All of the strbuf tweaking was
> so that way there is a consistency the variable names across the
> implementations---all the calls to `write_worktree_linking_files()` use
> `dotgit` and `gitdir` as the strubuf names so it should be easier to
> follow now.

Yes the end state is nice, I just found it a bit confusing getting there.

Best Wishes

Phillip

> Best,
> 
> Caleb
> 

