Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B4471CE9
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589018; cv=none; b=PHrfRQZ+OiEBpUNlyRzrzwz0MsJHU5mFweD0KeaKIn1axy/JVG4v+VeZsEym1HkAHweL4x1BA1uq3spkEogqkSSnCOlDzO4HXf022OStqrRfHVSw/kTCqPD0k2rX+abY+zxIzRxOh4wekYLM4e1VsAsXiacSU6M2+UYNLzcDQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589018; c=relaxed/simple;
	bh=iYzd+OXMz+g38F9U3MyagQVj6cziT6zepSHWD5TFqmM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D5aQ17piP1GJz7+rNWmO7wzmS/oYGNRp6Z50LQa/Ddywnoe8/QqBjV+ysWauWV7bj7zEv0EVHJmwQ2KkLB+JTk0PiBXPzwIe86Cn/jSEheixwvTRXS0YZ9M7kVu0BxuYZEc8fGzGBEZt+dYGAejQ5G3ZWNiKeJB5tXOxx1ygkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhZ+o92y; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhZ+o92y"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so409456566b.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 02:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790589015; x=1791193815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vxfD9hit3ibjHNp0f0YX+0EVewz2ljUJW9UTe6syj3w=;
        b=fhZ+o92yYk18mPhPbQ/S+tsWKY7qQ47GNV76GOuuye+L/Viv7MvQhWOgmZV2blopK/
         XIc4Xs9a0az6arTYjoA4F1aNrJI47NruOO0Mi0hKMcVw515wVVINJXcPYjka+IRjmWXl
         92oi7a2MUVhV0BBrosPSSlJShnBmuLnSVwsrqy2gEa//8Ex3aD+9uDp732NIIZTnmfTE
         cRZYSKvIv6/1nvNhGRSFeWFgugJ6zIt5TBMDRM3NAl5KYWiUBReLZNgWPeHHiz4ff2nY
         cYybTZMpUGR3UT8mri5AUoagi7ST2S/AFj9jtvIVJj61x3M1iiIKv9XC0FOHOoA5NJT4
         pfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790589015; x=1791193815;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxfD9hit3ibjHNp0f0YX+0EVewz2ljUJW9UTe6syj3w=;
        b=sM6xscbO4EfWdXIK921Ie9qDZVPrULcXfEUYnbt2ozpMX3E6h0pnItB/87yz5NxrXY
         INBQjMdIfhnA8JVLWdtgsPLmkcpmn/yw6Q4ly428E84dV4EMkbwxd4XruI1+rzhO0JNe
         0KWlAW0LcRYTfOv4pxVUi17SlcDozzzfm2BHZq39AuIrKEhzoZ/ygg9Jn1wvSKPYjtzk
         IuK63W6RJtAIQFoJlj8ECP7mFzF83u+Yjo2zgDN0QWjx7HLgjYNDpCFO+OAqdsnlAS1c
         VrkM0sHZLmCPG5iN/Gjt6HDAehOSvcrxouj3x+k1CZS1MOecCELv/47SEQaemb6JahvS
         42bw==
X-Gm-Message-State: AFuF++mpL4IArWRAJpI6PrYvvhQJHj+XkvoMVJANPSGxOKgYJ0CCTnEk
	HXYT+cwd5Bj4UbF+x9FZ6TkUUSx98PgcY+oRYTAB20gzNpP6aFBLKADJ
X-Gm-Gg: AYBFou1JM6GbajyzhnwL1tHa4RrWIxvv9OUhgxH+ILaGo7SEgjznOKvJzFcVQzbVhyV
	7dtBOKYkPaIn1l71WlD/TUnfekgbJZQ1gxPPnhGIFfTBuh9/+fKPULCnPv89qJZWvGwqlXzqgId
	xhVzNxc37GECeEbz8FTuiQQ+REvGClX/s3pIKi/T5z1+3zetPFIO5iVJ7e8xjzOsmhFurX5T4Hf
	AJ4zdZ4fwEkfaE+2h6A90mdH29NKIYkkeJoGamZOtlQh/t7ALCsgFzfsSAWcJxQ+J+hkDRMU8i8
	4ReNunUffME3wtUJraqG8Pd42H6+MBvaLwnuCMF8TOzmoA4ezQyvZCCG4AMKq2CgXQI/LpoZ1v4
	ixFdoNO+CatVpiRodVifXrwHH6S+igVse8lwTM++Ws+YpsLgY5zxwQ+Vb4KTMTyRqK/ITmq2Uy+
	DN7lDD1xsGwCylkyk+iItocOtIFvGSCoSrd+shKLDJMGGvTG5NjFLiFRQSKvMAu45ZHYxY3a/ls
	bDpa/paeItFKxxTOmmJpzvYKOR/0+3FTft2JQO87QmgtzwH34QygQ==
X-Received: by 2002:a17:907:d89:b0:c25:b620:d676 with SMTP id a640c23a62f3a-c2ac240e8e2mr1151715266b.15.1790589015105;
        Mon, 28 Sep 2026 02:50:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbfde3194sm243378966b.4.2026.09.28.02.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 02:50:14 -0700 (PDT)
Message-ID: <346c4209-9600-4302-817f-e8f6b364ce6a@gmail.com>
Date: Mon, 28 Sep 2026 10:50:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1790168285.git.ben.knoble@gmail.com>
 <cover.1790425008.git.ben.knoble@gmail.com> <xmqqjyo6qz3z.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjyo6qz3z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/09/2026 20:21, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> 
>> Hi all,
>>
>> This small patch series fixes a bug reported by Eli Barzilay in the
>> interaction between autostashing, staged index entries, and
>> stash.index=true.
>>
>> The first patch is an incidental cleanup, and the second re-arranges one
>> line to make the change easier. The third and fourth add missing test
>> coverage (which catch breakages from prior incorrect rounds of this
>> series), while the last holds the interesting bits.
> 
> I may have reported this on the previous round, too, but 'seen'
> seems to break t5520 when this topic is merged.  I'll eject the
> topic from my tree for now in the meantime.

I'm a bit stumped by that as the failing test (5520.69 '--rebase -f with 
rebased upstream') does not stash anything. There seems to be something 
funny going on with pull's fork-point detection. If I add GIT_TRACE=1 to 
"git pull --rebase" then on 'seen' I see

trace: built-in: git rebase --no-autostash --onto 
ae9857430e281d178a3755aecfc5e29c46a02306 
f29aa667ce68e4d514557081ca7f54b12e108922

but with this series I see

trace: built-in: git rebase --no-autostash --onto 
ae9857430e281d178a3755aecfc5e29c46a02306 
ae9857430e281d178a3755aecfc5e29c46a02306

so the upstream commit has changed. The previous test also checks the 
fork-point behavior and the failing test just runs "git reset --hard" at 
the start rather than re-creating the reflogs which seems a bit iffy to 
me but I've no idea why this series causes it to fail. I tried a merge 
of 'master' and 'seen' just in case the failure was caused by the base 
I'd used for this series but that passes.

Thanks

Phillip
