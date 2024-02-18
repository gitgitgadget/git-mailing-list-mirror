Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D8CA6B
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278891; cv=none; b=rBrj3BAen/PWEGhZDOMDZ2njQK7qpnrcUbTcwZeI6ekyhGDL7Z7eatYmm3fAkihquMu4IEvgwg8ytrcXOUvl1splkWOXCFr5b7WrC/Dt35MwEq6Uf4gHCYV5CpahbUBg77TDR9WWj6DUmMTtujDtmbvinuSRzMESvqDYecDeJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278891; c=relaxed/simple;
	bh=nJ4lMZKcdd5J0OlooNytOZrWOUV2ooTfC64eWewkcEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FtQ37mILH5dk/TayjnwKo2dAQhLVplxn4mI7gPRhsFl+pRdx3BS7vKlG1Cacfepmzu7aiFsisnpeV9vSR5P0wSSvCre8w6rQI8iquqC31gYISAb8oN2u1SQtnu7uQApXJl+nfEsalgOKHsz/A3IBICacJN3ypjwhheuHkvtt1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2KO8CRI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2KO8CRI"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7874a96a120so79380985a.3
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708278889; x=1708883689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qpYzEWDtL49jCIf4wC0wBZav3tPo1rM8ilQZXLika0g=;
        b=K2KO8CRITbLjy6DoUiH7Cfge16hp1LoiGQ5qNkWniP25l0PUSiLG8q+CQcgc+l8yj2
         y9Sg9UxZK+ZYAMcEvyxpk8gyPTtnjP+L0QXvzUDoEugnvF7SlL6N7GibcdqKwktZ0yYx
         jkdJ31gxQ3L1zVniHu5DfzivmdvsTVtxltw0cKDt2wNZ1WWiIuy+DJswLQ2bhaHt5MWs
         iCLfW9/VKOWb3V7xi7EsomQdJFUPW7yE1fAxHnVFW6yrDwH7agYDvZZBbpjwV3M5Ebo/
         wk1UVbsiL4Ig5mv+LV0ZJgSI+eBss3/4Fqe15ltAdFWgVbjIpBw7En2aG3Wyc3ln4s+J
         H1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708278889; x=1708883689;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpYzEWDtL49jCIf4wC0wBZav3tPo1rM8ilQZXLika0g=;
        b=RUHghnY+h4HGupVvNCwexuODmNt4I9gDu4dmkA6wxV6DY4WeRT5l560ztcULk2mat5
         gIdkKLPMZ24R4uSg5iJKAZeYYeGjhWpD4p1mL6fZgJW1LJ9YK+iIr3tLavWXT4gzkJgU
         hc2iSwIbRAOp1sDzJUEo86kfl57tA0gr+XAMPzUO1oZvx3I7lcBFhwDnaNJ2S/srNzIZ
         0gJV9TGRNOv1DPYI3Y7iNVYqZatmXOx7AM4Op6O4pePdLcvkcaNMeW1rKOrkxUbVnLe8
         9jgpbuxPwU8E5duDr23t+oOuUU2pQmy4kU440p453l6rBAhmGIza0CUJNKkkETbafLfP
         r7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Vx1y2kuK14gQtVuQjpYxgw46iGJerk1vZ+rHNPj8z1+1uI20hEB5w1k3Ztiht+G4lyviwJB44g2KER2pUAkiMgD6
X-Gm-Message-State: AOJu0Yx0BZGqX8ie7ibnKp43dSvYbuD9cX/qYquZZF54c6iyg2XKpgYu
	ceLbr3r+vNvK6FCpmXM85qC1NsopD2z7SD7uP+hpyEx3oDBUXy+OupVHLJpQ6TY=
X-Google-Smtp-Source: AGHT+IEOERsPMSi2V+8VUzLCe+QoMN+3Jz+b6+gwkwXIo06ZA3zbhcgOLYfDY5Ps27gCnPkiQ3d9bQ==
X-Received: by 2002:a05:620a:199f:b0:787:1602:9c74 with SMTP id bm31-20020a05620a199f00b0078716029c74mr14622072qkb.54.1708278889153;
        Sun, 18 Feb 2024 09:54:49 -0800 (PST)
Received: from [10.197.96.0] ([152.3.43.40])
        by smtp.gmail.com with ESMTPSA id z4-20020ae9c104000000b007874e64c879sm1515863qki.116.2024.02.18.09.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 09:54:48 -0800 (PST)
Message-ID: <df020dcc-afe8-4dd8-b476-4ca032206214@gmail.com>
Date: Sun, 18 Feb 2024 12:54:48 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <20240218033146.372727-2-rpc01234@gmail.com>
 <99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
Content-Language: en-US
From: Ricardo C <rpc01234@gmail.com>
Autocrypt: addr=rpc01234@gmail.com; keydata=
 xsFNBF/CgusBEADfmlG7pWQxAHusA73zB3bkOk3MpbhDA2mEZjOVLB5Q5egd9AdUcym85/cT
 l0Hjab/NUhAt48gdXhPnVoqieKvG6qYL0aUGVGkbgexmbDqDygOUca5TMfENVuKImPh7nRwr
 r31+NoFRSZA0p6cMQDgMpnJ6lJ4eVTO0nsryIP5CTph+sXTwZZBL0uk2GOJuzmskOcJJO61e
 RmyxJdtzX+3Pjmzk3dDzVy5B6L3Jzrr/fT10lPs4BsN1gMt2en6HFCS4R9VXy5AxCEYJt3RI
 d/75yH7fHeInVGybhyU87clO21S8LV8/ttu/qKZCVdWS/S0UNURuU7DQFxWEJs4okzsKsecv
 8zk4LXVKUmwEocj2ooKnU+SZiuIV88gQo3FlWupMuEp2k67aCP8uM+V1Jj64oAmYApOQnWcg
 tYDV/zWUooVUB2d86KH3Lr84FokY9MkgsWslbBSDi8DMfbfydAoPGHV4kF6ITHhsqnx+0242
 NLOlBx7moNL1oJ+LzmVaaI+s3DTVcdC46TKhTM9xZVChd+9TLD5YcJJOLWKb6UQt3c8ZOYSM
 za9EKSvchEM7kpwluWldna2mUlbJsZcS2B7tz2TJDCqjpEOQe6tN7QgomPpOoo0PKCcJI3UE
 Efs7Lhg2pnsCG23z41I2KHopxlsvcEJujL7CsAAewcftVO3qVwARAQABzTdSaWNhcmRvIFBy
 YWRvIEN1bmhhIChNaXRoaWNTcGlyaXQpIDxycGMwMTIzNEBnbWFpbC5jb20+wsGOBBMBCAA4
 FiEEABuPMGh96TZ1R8Gz/qj3JPKADkAFAl/CgusCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgEC
 F4AACgkQ/qj3JPKADkCMvhAAxoSOdTTg7Wp5VPhscEAmQXbYBfUxLurxZTP7srsk26pUGyMg
 87DrIWeLY/GmYK1JZcvz+qlp0iQ2ZliqBTnk35+cxviObbcATxmy30b1/uChrK884fTay2NK
 wx6hVC52yYktTJAH4ZbRJTVaHU/iEnuoe8Ds567Obw8y+IYtQM8yk35jSaENgrr52kVB9l+2
 Z0HiW7lMHNmOuwghUuBgtrku2civXc/yl8XiFy/9yd/o8KCWl89KsdWJQj0zghV5iW7ay718
 hulv2QxTkSZ8vwUB7+n1WouFvKO9SnREWLuEI+ep7iBaGJmlvEeoBEnx+lotdAX485GM5sqc
 ESlK+atnMxUoIGziqI63s39it1JHYcrht4NnV1kDqQp7l7VAxYVSOijSxORbCOmy6841FkKW
 UuQ9hC65wv1KucTxbIZNIii/JaZt9IR0TYYHQ5I05FYoRIFBHzqtGxuOdOW3uE8yk0nKld6j
 4m0BwFFt/ht+qKDs+6xR99XEEWgogW6YDIgygOBCD5NmlLA2dyXXhPXm2P09i7XnXgHg1Qh0
 BRpfQSEE0ZLuR5xD2dZHpKS2m1Chi9sKFL8sVHtfpwpkPLKDjmDV1eyuRz8+sfZeLczNgS1l
 BY6GIY6dri/+o9nCtixhiuL2TWfGw9McJ+2Wx3JYX6hQdQc2ouJvTvK8nCLOwU0EX8KC6wEQ
 ALg6PtqQKHAP7n77EAkVQEoR9YRVWk6TUXRnWNCy7skcfP0Y/tooBa8b44c5fzF+hyeNuQiM
 2iOuftRPO8zrJ/VEKVfFvwlRSxXL/rRQKngZoe9+i0hj8LbFFIS3bQgOgf87drOiuDBrcYBB
 Hnm4jHR7BoSsNWnQ+1wbcCQB54l2Z3zkZCbPNgUrfrCSTKs9VFWtJ7PtxTdGCtVJekppebIv
 bLpEiXqcbZCvaZ9jJXZr5MgOHhAKyGgpU/pVOZiJ7qm22UNGN1mxigpUlEr8c5Jj7RjX1l7b
 uP7NxGW8/yWh21xcpYst5YzT+JblS8PuN16IT/Tpf0pO2pwJ7z6TSegevz9pYphVAgI0PDKd
 yP8sC4JWwknVUqgRxzaGcDzJKMsX7oWP1UQWGKhRXr+Z/RBzrmRBfCE08m8205lf2XdHxDt2
 zVRvAz5mERYIR+/M9iKxaAsXq+aOH+hX7s1blUCtx71CXiUZ3Rm+7FsZnYmOjEumMBV9yym0
 iMIn2Sh6vAs0zGHN7c47000NhkTimwxwU07vuFWyNCpnaBIKLjA+8ua0V5SNy9WALQF2oIkQ
 1m42PrbiaJ9YUSxH77AFI66AnHvK8UIGIiFt2Zd7BhbuBWMzcmihkjL88fSbZp6Z6OuVnaUt
 SmgFs13Jn0G6unLybQTIF0NXPBJvtdOaRJChABEBAAHCwXYEGAEIACAWIQQAG48waH3pNnVH
 wbP+qPck8oAOQAUCX8KC6wIbDAAKCRD+qPck8oAOQP5vD/9mzINwihJLWdDWck1Jb6fO7oCH
 shz8RbW/5R5s1SIdKLgE7IBfP+PAghvgxG0XHRzPlu5uWBlcGjn4MJvgV49dmGbWFj3Ngpz0
 iGtxnb9H8ELzt7r1DVCKngVqaR1JlW1cUJSO9UaPHAXRDujMFqRHGHslNcTeIk3h1kCP8XMR
 eHITrY+Q9iTVJa2Qjjy96OE7EYfjp5cUxWMysbKD9n58+l2v1mttjKLjvmRqRI+mgx/NSHzS
 AlN53AlXLn4p9fYMkeEi4OntaM6TeiJdo9xmSviTlXmHEBbb4q2S/FLfwO/25ct6x+plgSuS
 i3QSWcPvfZA6bposKuR/EWwuarLpTMpfkjrxGku3TI6UGxokatuvTtqEdCPBJFySKLrNJOM2
 zPzLU3a2y1gpaS/qA+p0k4L3aYjCGGc1KQr+DVgobjiwJcdo3zfGsL4RH819Qsn7Cd/CRZg8
 9wq7X+Tgqk9XG8oJ1lk/xeE8d/zt0QayHWJqzkj/A5yqd/SBrvvxsOphdNaI5i+O8JFcq6ub
 /Oeuv0yIFeYFh0/lg2s7tNPbPWocEydhkltifR+BIqwZdKN4A44BxqLaDiq4R6uiEFhOAxH6
 HIt5tP7Rr2sWDRTC8Gyk3VhuVjLb0xJ17zU1SnvIRiwpp0HY/H/HN1I6eU3eXSKNEjMWFB/V
 jjbjCH/5+g==
In-Reply-To: <99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Phillip,

On 2/18/24 05:32, Phillip Wood wrote:
> How does "stash.keepIndex" interact with "git rebase --autostash" and "git 
> merge --autostash"? I think both those commands expect a clean index after 
> running "git stash". They could just override the config setting but it might 
> get a bit confusing if some commands respect the config and others don't.

Both `git rebase --autostash` and `git merge --autostash` seem to be hardcoded 
to clean the index, regardless of the configuration or CLI flags. They do not 
use regular `git stash` to do so, but rather `git stash create`. This is 
unaffected by my changes, since it follows a different code path and does not 
accept `--keep-index` nor `--include-untracked`. I'll add some tests for `git 
rebase --autostash` and `git merge --autostash`, just in case this behavior is 
changed in the future and causes breakage.

> I've only given the patch a very quick scan, but it looked sensible. The only 
> thing that jumped out at me was that quite a few tests seem to do
> 
>      git init repo &&
>      (
>          cd repo &&
>          # test things
>      ) &&
> 
> Our normal practice is to run all the tests in the same file in the same 
> repository rather than setting up a new one each time.

I was doing this because it makes comparing different commands easier, but 
looking through other tests again, it seems like I should be comparing the 
outputs to hardcoded files anyway.

Thank you,

Ricardo
