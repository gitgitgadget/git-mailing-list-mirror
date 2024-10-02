Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B691D12EF
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877677; cv=none; b=n/sYIwlAet7GhYBrtU6woHaXo6C90jIMcsnHSQlPxKHL8dboFTsuUo/9ffKNsE9s/H8CX12MqWA6zZXPDK/gwkfJaIRhn0+weeh1C+N7TePz+zdHm8jHeT/zteDsM83yK6vrVoV80pv3m7kaerkAFh5cd5q8b971W1pOjt39RiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877677; c=relaxed/simple;
	bh=VCoYK6H0TMptgKo+Xi0uUQ2wVv87qPkYxS+Wv2G/QXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mb1ZhtkArZRr0ynt0aecvwSSIsYNCdaG2dCHJjPsiv8qpj+3/X5tTShB1kGLnjQAwKWspCFlPS4xwQ/UMYFf84P7nuat2x5qx55dxewH1TFVwjbcI0coqLSe8zYUw1kdoXKr8VwRV/1+QJdGfUM/OLuF0Wm1UW8aaUmiG4SFn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AODi/hIE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AODi/hIE"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so192681966b.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877674; x=1728482474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DHa3U/ukaR+7XopluU0Zvaov+ZbYCFlHJuaERj6u1y8=;
        b=AODi/hIEM3RmbPakQpt/UC5Oxg/kFlxnprG4r7gTUZV8pKrOTe+YJl8BWDbbIA2OiZ
         lt2aIFErvzelXyt2h/CM84qkAIWnRXYurdL3YbhoCj22kn/kTNUgJVDeTJ+J/KiTtP4z
         Vq9x+P9nyWaHrIMuRqCesZ0c0To99h4oo/NatuscOjIESfBhNGM5W9ur10mS6igPua5+
         P8Cow1/1UzMhlrS8GIZMhDDZVUw4nnFnvr16RNjAzaNwJ42pQbY2f6I9OEa6mPyMFQP7
         vSp40Cz3F+fMHrJE1y7H70lX0ENpHMFlPPKHPbb/1KV3lEsJW1WXmlDiswYIObGMTrty
         o0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877674; x=1728482474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHa3U/ukaR+7XopluU0Zvaov+ZbYCFlHJuaERj6u1y8=;
        b=AnnMW6pollRadlBLkBhqspO/tvhka5SUmObHQGkrO/jvZeUh6PhSDVyaoogfwMH2rN
         YDMUmuRoEZVJWS9f2H66zImk1O5u6pgwQAAmYpa9flQkdKleaL4+//6CXG+Gt7oJVuYz
         9lKpzBN6oG5Ka4ddSJbpDZSYD5cucHPNUAb+dqJWUycrj53ItAaj21lqiqsbhVUWpXR9
         +AZmJhi8f26lx7lF1OtDTo7WTRungua8z097NTo1qVmqmhnPe2dv2PHEKuqIE1XCQTxa
         tAtZNYY+G050Dq9gh3hEFOzjLiX2i1OQKYGBaBYtKc274kMZ0Er+Nzh/o3ZU23FiYi2d
         Ds4g==
X-Forwarded-Encrypted: i=1; AJvYcCUvOb8b5XGgirdo+wCl/BDEn6a//u98olI29scjWe60nU3HnuXB4u2ZCYN1figJtADqbRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5E9f1QxUIfbV+c/LBEfXSMa+nFMDyxTLdTVQP3MaI3IZfzBrO
	q4hA8YWW1f+pnsTWCPFhNLZuls/c7P4SiwqjAEX/ndQNDs0qvF9Jf5M+Dw==
X-Google-Smtp-Source: AGHT+IEfAhQ6zduKt0a3NFIs6DwNXPX1ygiiIW0oZfgaz/YIaKS5ru0Zopk5drLXlv4zGH0LLX+sUg==
X-Received: by 2002:a17:907:3d91:b0:a7a:9fe9:99e7 with SMTP id a640c23a62f3a-a98f8372a3cmr270880666b.41.1727877674241;
        Wed, 02 Oct 2024 07:01:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2996631sm861676266b.200.2024.10.02.07.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 07:01:13 -0700 (PDT)
Message-ID: <dc1a70b3-9a0f-4c5e-931d-8b3b91335ec7@gmail.com>
Date: Wed, 2 Oct 2024 15:01:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/1] Add a type for errors
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
 <ZvwVZs-HLy0RiP3E@ugly>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZvwVZs-HLy0RiP3E@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oswald

On 01/10/2024 16:29, Oswald Buddenhagen wrote:
> On Mon, Sep 30, 2024 at 10:03:52PM +0000, brian m. carlson wrote:
>> +        case GIT_ERR_MULTIPLE:
>> +            strbuf_addf(buf, _("multiple errors:\n"));
>> +            for (size_t i = 0; i < me->count; i++) {
>> +                git_error_strbuf(buf, me->errs[i]);
>> +                strbuf_addstr(buf, "\n");
>> +            }
>> +        }
> 
> ah. i was wondering how you'd address this ("this" being non-fatal
> errors piling up), as i'm facing the same problem in a project of mine.
> 
> the problem is that one can either impose a very rigid formatting (as
> you do here), or provide formatting options, which can get arbitrarily
> complex. so i wonder whether one shouldn't pursue a hybrid approach
> instead: singular return values for low-level functions that either work
> or fail fatally, and error callbacks for higher-level functionality?

That's a good point - the rigid formatting is easy to implement but is 
not ideal from the user's point of view. Ideally we'd compose a coherent 
message with the data from the various errors but as you say that's not 
trivial. I wonder if there are any good examples out there that we could 
use as inspiration. The ones I'm aware of (rust's anyhow and svn's 
svn_error_compose) go for a rigid approach. Glib's GError punts the 
problem entirely by forbidding multiple errors.

Best Wishes

Phillip

> btw, the switch misses breaks.
> 
> 

