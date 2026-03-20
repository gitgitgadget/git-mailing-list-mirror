Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8A03148B4
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023263; cv=none; b=OP2tMuGmAdhbuuGDoRzQh5RCzi24Z20m8R9vR7xeXSEvtZONKyr1OUvdOG/Cr61IP3NPYbYljM3OlCVYT6HStlpgeuIr+hlIZHrhfwNbdohmTCG+DSHW3Neo39SwBz5KM33qEiuOekhw+BqEYd04Wm8ZoXjm2KX5HUjg3/AJIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023263; c=relaxed/simple;
	bh=kAlOegKUmhPWtCnEyK3fARxSnpwYAjeCI+PFr7j3xzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQYkL4DP0197mb8lNUBBmTqRKoebdB3V26paD9D/fSzaQhRGZudFYXUZ1RpQFj/x8sOfjdFkfrqoblBAlyQRQap2rLsYhT5NWg6WpyA+J1Y8go6AdpOLJx1eB8VYxeEjTozCmi7aZQTbviMXs77RxCwh0y8AWnpuYmsflN4X/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFHMcfkq; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFHMcfkq"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89a07f66f4eso22511826d6.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774023261; x=1774628061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4UmY/KOLn9YaBVZl71WwAVqLKXhY4F5Qzt/E/2k60Y=;
        b=kFHMcfkqj19/rOMVAZ4aVffq6bR7hZH20PzkolkxftNUoyWuDvtHTsNy0HIW7v0vxX
         LC4Ljb2w3XA0E9SUjcBy+jcQNPv4O5nh5ZirFKhzBknf3dfw1WxJuW7k40EqVnFi6sTJ
         URizdoxBmJotW+UsPEN3XEKWjIKtyTVqa8sSIAaUpLFGyd4OMsczkVygHwr04r+1RwtP
         DwPI/pAW1/PtTmDpt0MZb1dcos31MTUduigjm6iFI0OCzY5HiU9cpXP7g3y9Zd7rekQ5
         FmnRVuiRunDqGUpC89wCkzS6UbwH/TQCGHX9BYBtTyD4xf5WEdGoXE5dGneUgMEKevMP
         +6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774023261; x=1774628061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4UmY/KOLn9YaBVZl71WwAVqLKXhY4F5Qzt/E/2k60Y=;
        b=F3nm4ONqbFFra4JILkDEVujuWQXDSS4wB2R9HV3JTC7bORGMeRbiNpEcTGwofk/db1
         3on4pwUkTo5ImjZzlBIPXlBXVrjxPqoVToBrSuF2hD4d9QQjTRM2lAqSrj2E3FhwK0ga
         Q3XSRcjLd/BiEWmd+zf7UQ/+sIyTsTJrfLM+d8QEqbQ3+wipIGYnJsallxhSHxf8l6f+
         cIhz0TKbfodKUWMv9ghgEuVjsAvD0F903qvYhzAPmcRfKNoepMe5SUTUp65CJeb2jG9Z
         uBbNC94tAAjuwKAP/GVd9F2Jtm3AbiPSEC/Te1UIPhbfrBrGRpnNT64h5/V/iQ2Qr5yF
         x0tw==
X-Gm-Message-State: AOJu0YwnQbkSGU405JO9bsf0f0k+sggrteA3VWFjwo0ZgVzh0XM9Rsbj
	m5LR1VYnktGnU75M2trgC+hnSPVlqIPytNPF8RuPFjoB1EAg+fslzxeJ
X-Gm-Gg: ATEYQzxIrDFV3QwzpcRDNNoT+WkMeq45NJg2IKbn4HVJDkxnRpsSaU9wDOMFDi/wSuC
	nTjlF0IjC6fVvi6rXu6Yn8Zod5X96AwJh0BBKlvOc0/10JguaVZgOv6s9U/WjZgxn5sJsEIrveq
	VfaW2PHfP9Jrfwt9ouYdCZevK7BEkiijp+OUApFBRYlI2W4wIKgzj9ZXFxd5WIpO0ctS1jfvTw+
	UsyR76tipdG44IuPP4gGzhTM8Ge2TAimz86nM/Mw4YtEqBW4vkBZuk0ZghPRrphFjqMyRDP46iX
	ZL+1UGxyAdgFBA79B64n6p2e1EiD0qVdffZFglBFxjQMmMrpjD5cwGzMg5ogr6dmrGJMYH2WXba
	iWnuhUB2IFK4GgK13R/SGc8bEYt+lAGrVixxBw28lT05vb6MwbZueLqU3g2F3TAjmFI/nG80fzp
	K7dcIPXAEwbP+1hRkD3SLDjzzduCs4oYZ55HJOMvUFe6lX7kqUtGu2eXWlkfOoWRmvq1gQMg==
X-Received: by 2002:a05:6214:ac2:b0:89a:15b9:a1af with SMTP id 6a1803df08f44-89c859f6e4cmr57885946d6.23.1774023261028;
        Fri, 20 Mar 2026 09:14:21 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85214a43sm23749986d6.6.2026.03.20.09.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 09:14:20 -0700 (PDT)
Message-ID: <994f92e9-3576-455a-a142-0fefc559131c@gmail.com>
Date: Fri, 20 Mar 2026 12:14:19 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] path-walk: fix NULL pointer dereference in error
 message
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
References: <20260320114823.3151961-1-ysinghcin@gmail.com>
 <CALnO6CDnwYaAPhp67kaYWtV48ULjWAR6ks1khVXmSs1oWUbRDQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CALnO6CDnwYaAPhp67kaYWtV48ULjWAR6ks1khVXmSs1oWUbRDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/20/2026 11:16 AM, D. Ben Knoble wrote:
> On Fri, Mar 20, 2026 at 7:50 AM Yuvraj Singh Chauhan
> <ysinghcin@gmail.com> wrote:
>> @@ -171,7 +171,7 @@ static int add_tree_entries(struct path_walk_context *ctx,
>>
>>                 if (!o) {
>>                         error(_("failed to find object %s"),
>> -                             oid_to_hex(&o->oid));
>> +                             oid_to_hex(&entry.oid));
>>                         return -1;
>>                 }
>>
>> --
>> 2.53.0.582.gca1db8a0f7
> 
> Interesting find. I was hoping to see an easy way to reproduce hitting
> this code, and after grepping around a bit I found a few places that
> end up in this code (git-backfill and git-repo being the primary
> callers of walk_objects_by_path), but on second glance I think "!o" is
> current dead code.

I can appreciate that the existing code is clearly incorrect, so
tooling scanning code for defects would find this even if we can't
easily create a test case to demonstrate it.
 
> Still, fixing such obviously wrong dereference is good, but I wonder
> if we should go further?
> 
> You mentioned git-backfill with a tree missing from the local odb; do
> you have a short reproduction script or test-case?

I imagine that it would be difficult to set up such a case, but maybe
it would follow these steps (based on existing 'git backfill' tests
that start with a partial clone):

1. Make a bare, blobless partial clone of the server repo.

2. Explode the client repo's object store into loose objects.

3. Delete a loose tree object, but one that isn't a commit's root
   tree. It must be a child tree.

In this case, we should hit this issue. Blobless partial clones
expect all reachable trees to exist locally and so are not prepared
to download missing trees on-demand.

Thanks,
-Stolee


 

