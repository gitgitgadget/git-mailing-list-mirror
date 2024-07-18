Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C02DDB8
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312583; cv=none; b=D8mzVI5RFeCxoiT2Oe6fn/FqQgNg9W4aLqsNFv6zLbeQNm3D6tOHKurauNkvV2Z3EXn5lRyqTgUACdl7ve2tYRNKEZUlQM8pwAxeD5dkUPhCYXtF+fkq+f7sN+Nejx0jjRIfPpCEIDqDW+9nmisxmG/EUpFtuuKipJlE3rwvhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312583; c=relaxed/simple;
	bh=FRpaWGod5mkBUTNbbTrdihbqhAcNz13QnULuUFfKUTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBNv88zXCY3DADe27nL0IOc0YrHlhyP5g6tyS5BI7iGyPlUO9Ep8fwy0nsO6jaBElyigYnvb2/yzlNk+7wUqj2zAJIK0fKWGPzoaKUUFGFufv55iCzamq27s0Vl4QDVDpKj+hYIEAAZEPbydq2sZAt4HqzEWq4aPv83wjJWyjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBkKI0gk; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBkKI0gk"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eefeab807dso11583061fa.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721312580; x=1721917380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jwup1fj0Jx8ug8EjFQokbQUFQSpUuaTfgP87jRwfZwI=;
        b=YBkKI0gk4S4aV6kfI+n4zwX97JlzDauJGelQcqbsqW2BbxyZuQk6qGMPXDPO3jw5Ad
         ETGGeVsBoll8UPlku//rjtZ4++03Myik4Yx+7eIiZ29H3CGpfWDHj1slWi7TCW6kYD9T
         f2LGVBdZR7XrdLSFUzOqZDKsz7pCJXA1Rzy0MQQIiZrP9M3MxSkNLam4Eh0BimlTtoHZ
         aAcwbEc4IqV95zL3zpVeOxoAq8SuNdwkR8itMpYlfkUH0r4hLQdEwV8rYtZKos92ZSnF
         yLKPCF+qb6TJUYmaHd7lPlbDI6pBVBAlof2o/cCGwLhCzqP9iyZc3k7GkAnImQONaK0n
         rxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721312580; x=1721917380;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwup1fj0Jx8ug8EjFQokbQUFQSpUuaTfgP87jRwfZwI=;
        b=CfapQnwVKr/ujeDc+k+dPEGrscXxMGIlA8QSg+dvqf8mkDPgPqrk4CdC7U7RscFnpH
         0Z5nipKyv6yV5tpJbMiqXX/0HbJAjU/GAXmRXTx5mfyTKokZujVy/tej94Ujj2Jn9yib
         PBjdj/Fdsx0wgKeG040fYSIkNXz2WdXeAzYbOVUWfxwIn+le/Wx5qx7vEOjK6QMxIKNp
         I1pVmsjotN5vOWTSWWXxNa7HWraVM72ifeoKIxml1APk9JjlXjWNCZAEM5IAL9Etz9y6
         4qdYlzo0mkiMIcFeoALpHAavDas9mk8P08MZeACOJzJhVb1yayOrvnSnkxLN+1AkqpoW
         KNRg==
X-Forwarded-Encrypted: i=1; AJvYcCWAXocbdlENQL5l+y3CmOYM1I7dQKYkg7tx9zs9oSICfBFjE0hakG3LsA6U2ZIO4xGR5dHlpN5lhcOjKQPSqPaAskI+
X-Gm-Message-State: AOJu0YzuMVHA49tm7WT0KgmnzpfwK7BWCcgXUILqQsIAa8nIadBvgN7C
	5KoiffYIZq2mzl8yyyn8E/RQeepY2beMCZqj8Xy7rzsSK0slKVuN
X-Google-Smtp-Source: AGHT+IE1Ft3rwcaWVXUikzNapMA2P8Ccnlj7UUg9nBGsP68r689sDkhKi0+4lVgpBv7G6U6C0vI3Jg==
X-Received: by 2002:a2e:8e8d:0:b0:2ec:68d9:f3d2 with SMTP id 38308e7fff4ca-2ef05c7990amr19297521fa.20.1721312579463;
        Thu, 18 Jul 2024 07:22:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36853e239cfsm1800260f8f.56.2024.07.18.07.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 07:22:59 -0700 (PDT)
Message-ID: <fce1483f-a963-48ef-9613-ec683e34ec6a@gmail.com>
Date: Thu, 18 Jul 2024 15:22:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC/PATCH] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Ilya Tumaykin <itumaykin@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
 <ab974e62-098c-4200-bee3-7de8d9115516@gmail.com> <xmqq4j937pyf.fsf@gitster.g>
 <20240710093610.GA2076910@coredump.intra.peff.net>
 <d5d27cad-bacb-4a79-bb50-e65d2bb6808b@gmail.com>
 <20240711212628.GA3648684@coredump.intra.peff.net>
 <622849f1-de52-4b92-9465-931014c8d3eb@gmail.com>
 <20240713212105.GB554779@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240713212105.GB554779@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/07/2024 22:21, Jeff King wrote:
> On Sat, Jul 13, 2024 at 02:19:39PM +0100, phillip.wood123@gmail.com wrote:
> 
>>> Do you want to just re-send your patch with a commit message to replace
>>> mine? (Feel free to steal the non-wrong parts of my message ;) ).
>>
>> Thanks, I'll do that
> 
> Thanks. Note that mine is in 'next', but I think it would not be a big
> deal to revert and replace (I'm not sure it is even on track for 2.46
> anyway).

Thanks for the heads-up, I see that Junio has reverted it in the latest 
what's cooking email

Phillip

> -Peff
> 
