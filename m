Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE637700
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712498147; cv=none; b=fFoazF5lJFjv2M/rAljknY2XVYFBu0spK43Qgmu373S3VPnrhwngNOnhkVntQEBf6ZKi3ns4hFYl0QDCUqGgNmnO3HY4aeT0kS7oqC3XTv2ume8E+VxtttDXUZ2dxm7zZOLD7tOxqc57NTMiZcUe4FgqVhhG94432Sy5U+5zP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712498147; c=relaxed/simple;
	bh=e0+tY/xbsKiiuQlCm9r56bfnLtQwZTCG+lYV8g/yvQ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hzXAu1XaVbvuGAAoEd7pd0WOM63Mt+KXAsMsQbIuMA17GENY2CDr3w80+UTTcm0nLjWZLHbgHEV9NLWSMguoBcpkASa/WnOAwt8Zlps4LHKfe/BFA8d/FKnzw9d2DiXXF1+wMexZsgSTkLk/W04kp/wlKAPM4O1ktPRBVTB/JK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq7gTqWX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq7gTqWX"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343d1003106so2081104f8f.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712498144; x=1713102944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VR4ibfxSef8HbF4urOltY1KOhYpGV9OSrbH72nHjCqY=;
        b=Oq7gTqWXOoqFLy/rTnhdAZ/K4WPAZULjQ5HvoQhPoz7J8xtA1csMte5fs/0amEXfH3
         DaZU7yT8DvIiUPoHJ+o6Yjr3W9XA6AxUfyNiMy7wz40V1l3BDHunk2/rzS7dRfuB5TDr
         7e7zvNFkXSwiD5lCtcEBta6sHngaUQXzZgosiIpGOQ7gnsriPAtAfs6LbbBDCOK4e4sV
         y94Bt0UYzSZmNKyzz/rJLjFzI6G1uXqes2UyPthTlBS0kgqLK3uWqEubjjK2V2p2rs60
         zP5PCHrv15J888lfP51Quqjq5KWmJshHEyti3P+Tpoy1Lq9BmzSenbzWch9715rE3j5S
         Zcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712498144; x=1713102944;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VR4ibfxSef8HbF4urOltY1KOhYpGV9OSrbH72nHjCqY=;
        b=gm/5ljIHnQkd9nvGUCvM/wk0gUjwaBAS53VGHJhICG+XBvqjZA/12npmNrc31z+k9d
         JzxoqklLi8qFiH3u+lGksIRCPPtvIZ1JwB0Sq1VS86tnYWY8XJdyKDM3yAue06YIxlu0
         kiJkrYodv9Lzfu5a5XXG6UwW9Ce7t2RHa6YerLIQUtAxIrBRMxiBJgIAVty/wYUXW7VD
         Gu8s+r/XVyqX0LvElwt6J672FPVzqBpaQ/tNZnP7tO3BjvMNjKLnJmJI7yvuR4trF+QS
         j8o4go1O6xdgnbtV/CX/MHoZiHA3YvSlvDFS20e99mK30s2FNoOkBLKro4NA/0U6bldd
         nZEg==
X-Forwarded-Encrypted: i=1; AJvYcCVXw62YXhXOqfMTRJMt9x4x8eQ0lq9R6DIHyUWTDmPLa8bsHKusvLZwFmpEBB5ISeiVvmH1fFVdYjW7x8Qy/h03gVll
X-Gm-Message-State: AOJu0YxEXmz3jJZELuXmXS/NhEIPq8f5YXES1g7ZstVwXfexyZpC8O1g
	yMKAh98SSYnDa2eVX9g0RVAC9B8U8ZNjtXZ866fBL2NQ56UJTv/4
X-Google-Smtp-Source: AGHT+IFJCOh9zoypwBhuziUcg0bTdexAxANj9IZ01phYzWwBtJwkqhDqS8LEMkhPEv4zr1IUsF5kmA==
X-Received: by 2002:a05:6000:1202:b0:343:e152:4c43 with SMTP id e2-20020a056000120200b00343e1524c43mr4852713wrx.2.1712498143724;
        Sun, 07 Apr 2024 06:55:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id e27-20020a5d595b000000b003445bb2362esm4109363wri.65.2024.04.07.06.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 06:55:43 -0700 (PDT)
Message-ID: <994b3c35-b5f9-4e0b-b268-4ae19dfc6e15@gmail.com>
Date: Sun, 7 Apr 2024 14:55:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: improve error message when picking merge
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
 <57462d2e-e255-4d35-b778-176f03675df0@gmail.com>
 <dbb4615c-443f-474f-a33c-cfb4486d436b@gmail.com>
 <7e4eae67-8db9-4be3-8b96-e2e89fa82abf@gmail.com>
Content-Language: en-US
In-Reply-To: <7e4eae67-8db9-4be3-8b96-e2e89fa82abf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 06/04/2024 15:24, Rubén Justo wrote:
> On Fri, Apr 05, 2024 at 10:30:37AM +0100, phillip.wood123@gmail.com wrote:
>> On 04/04/2024 20:44, Rubén Justo wrote:
>>> On Mon, Feb 26, 2024 at 10:58:07AM +0000, Phillip Wood via GitGitGadget wrote:
>>> ... I find these repeated messages confusing:
>>>
>> I think that printing the error messages when the todo list is parsed before
>> it is given to the user to edit is helpful as it reminds the user what the
>> problem is. Your test looks confusing because it doesn't really simulate the
>> user editing the todo list.
> 
> Certainly, the test was not clear to express my confusion.
> 
> The ones that are printed _before_ the editor is run are the ones that
> confuse me, because when the user exits the editor we leave those
> lines there:
> 
> 	$ GIT_EDITOR='sed -i s/pick/merge/' ./git rebase --edit
> 	error: 'pick' does not accept merge commits, please use 'merge -C'
> 	error: invalid line 1: pick 17381ab62a
> 
> But maybe it is my interpretation.  Your reasoning of giving it as a
> help to the user makes sense.

Ideally we'd clear the error messages when the user edited the todo list 
but there isn't an easy way to do that. In principle we could stop 
printing the error messages when parsing the list before it is edited 
but I'm not sure how easy that would be. The behavior you are seeing is 
already present is not changed by this patch - existing error messages 
behave in the same way.

Best Wishes

Phillip

> Thank you for your explanations.
> 
>> Best Wishes
>>
>> Phillip
