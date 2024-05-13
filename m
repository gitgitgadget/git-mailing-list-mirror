Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385557C99
	for <git@vger.kernel.org>; Mon, 13 May 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613374; cv=none; b=jAJyUGIxHog3dEmnG+PzNNLbds2YwQOD7ih33HxvafDPCUZUle8spnRgVY5VCliwQ/EWdyj8Xnh2FsWMcx7iEttCuZ969gYlrsdrl+IUK1zizn//S+qvm+x0xRRuWqZ4CPyFjzN+SfogDk7BQzdxhm4NfQgS2PUMQfrCUsbkELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613374; c=relaxed/simple;
	bh=oZwANQB3J5X9ug8X3acXLbKNWAtVV5TBYLzKW51yZOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRRicx5NydpTA7l6CoGqnRnIPyJR9ZCCPk39bCp/MAp7YSffXH83s3n9ZrIa2k4u3CyvDQdrV+wa4xwOjGIv8h4GtslyxhjNUGqV0GmjpcITnGsqFrnb0G24IYSF3A8qYclZZZFFlcUiM+6iFpjav+ULRX+W4frG++GlBhVxLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaWA+shn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaWA+shn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4200ee78f35so15762325e9.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715613372; x=1716218172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K7/6rPkDDsLQ1PDDG7EXu/C8w23eIt5UKJ0GKDxIDeM=;
        b=KaWA+shnZ2fCQ81Q3V+Sb4/TxVnDmSyiK4+0N/S8NbWMD24u7auYEQLJJevGe3XhNw
         lDtMC5EubMaw0gvl8282drNW8m+nx0BHOkMfxGGVcGjInXS8tFsAcGL79Y4LlOCySg65
         ZIGW43C/977umSnZ3dQHlsZ2Vch3qb5SSLZszWxSS9/g/ciNTmCDTfh3relIg3w5c8tm
         hPuvTQLfQp5mpGs2tFP38qjT1Egk0VZPokU10pRx+wUDLjd2Ok3NpwUOCld54dFOwD+C
         kziMrQKdMcjumkFyqin8WyH/PnjMf7ayGr43dYY8v8LzsvQTI9S62/lF0Z5u94MOrLRD
         ByTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715613372; x=1716218172;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7/6rPkDDsLQ1PDDG7EXu/C8w23eIt5UKJ0GKDxIDeM=;
        b=FdOJZo3hclINBxdLuy0OF1OrhcIRzjL4n2p6jGmShregFuYTqqHZZXkpriBLkgOB5u
         HT9yXL3L3tTT8TEqx93KFQk27BFc3TR0heNySWSKoNz7+W/k0D1de7ak5ETtuy5XuLk9
         ohoD/noN7yFM/MzUa9/RSxLWrrilPggZqmCalrazsawHxDKz/py+L2mRTjMoYaGZ6LJC
         /zPc844UfR9278U4GwZW4hkqh8c/W54cP6q8qoRNjVTztBHytvAMZN9LkzOxGtUBOvjO
         KNrBCODS0X2TjaZ1orEdCYZfivTtdKKmcZwZ7Wrr6zYOa0Tjh0TVDW0T+nBSZfo4BTIu
         jioQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFAp+F/IMM/xljHmF5q7cjOU90Ys2rzdQ/DwP0FAgGP/SWaaLusuzNVBUFoLmXt6ojkbJpoBwZjkWAetORySLDIxNT
X-Gm-Message-State: AOJu0Yyhhs8AB68g7HVPSlvh/u37YYRq+AL9JJc8V/WAh2JEiy7sjTpQ
	AIYBYrYYvBaurui0bWbLWTXUEOUdZGZvRkYw8PdhJ2lwSTucL9sl
X-Google-Smtp-Source: AGHT+IEjwgtT8wPeGgxr6pyFOYgIW4DxzCSvpjlFCxPYQewlZ+4SjcWo5Tof8IOX0xFd0hA0gY9HAA==
X-Received: by 2002:a7b:ce0e:0:b0:41f:bcd7:303f with SMTP id 5b1f17b1804b1-41feaa38a8emr106940205e9.16.1715613371636;
        Mon, 13 May 2024 08:16:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41facbd295fsm179991585e9.36.2024.05.13.08.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:16:11 -0700 (PDT)
Message-ID: <6519a197-76be-4723-be27-b9a5cd75731a@gmail.com>
Date: Mon, 13 May 2024 16:16:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-cherry-pick(1) -- path
To: Alejandro Colomar <alx@kernel.org>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
 <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
 <9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com> <xmqqcypt61lo.fsf@gitster.g>
 <bpjfsabhstkbuvo6ksj3owoxvutgquripmqmqi63ykaquhky2u@r7mfrwucgnye>
 <3a48b2fe-78c0-41f4-9e60-4146f15dfa97@gmail.com>
 <fz7tgtvp6qp7h3vcaviibn3rktkwg5q4qjeuvmciejqn2m7uow@3o5hi6hdbkt5>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <fz7tgtvp6qp7h3vcaviibn3rktkwg5q4qjeuvmciejqn2m7uow@3o5hi6hdbkt5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex

On 11/05/2024 21:08, Alejandro Colomar wrote:
> I've been thinking this evening that since
> `git format-patch ... | git am -3` works so well, and since the behavior
> of cherry-pick -- path isn't so obvious (we're discussing different
> strategies), maybe we should just not do it.  I fell in love with am -3.

I agree that using "format-patch" and "am" is a good enough solution

Thanks

Phillip
