Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BAE257824
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696749; cv=none; b=WvOLEqDNJ223slo9P0A1uoQu+ARRXU2lxm+dhYWQ2KG1ZggtluqMy6daewHFHuwLnBJnk5SEG6oh0Yq+pLiD7SJmUq76sZnuppubQ4GSWKQWz3g/ATnAdqNmwf7xEkI52DqHoW/tzxryfidI7YfCBdvHevPUhJGSRXRaTYvGUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696749; c=relaxed/simple;
	bh=UIYxiGdENEonpGwsUB4o35/zkLXmh0qE+sd9qwm9Bxo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R2UmSqsSkVwpEAjje9V3hHFV4OWe8bSOA5oGLsYL/v5yVvSPJO7QBg3Cq3AGJ9SjKp4/jWraFyEJJ4pr33QKpEvStPyQN+mZKJuK+WHcsmkFnfI93XuMWvb6nyKLuPH3YwesgeX1K6ujCdYkpyi+dEx3V6N43rLV5b7Iw3jBbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByYTfEOg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByYTfEOg"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15f360851aso158199666b.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783696746; x=1784301546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o8WP2eL0x+SNtsmLV2uduaPSaQ1IOVzdNQkA8jV8dCw=;
        b=ByYTfEOgXmhc432K6AYaXYqovwZV86A6kpy022STAdDPBUTWlAw7nDaKKLi8Xff12n
         TLYQQbKqV888fUG2CSsld8nNyYe5CLdS11fxPCVIhSMAIDYmO/OUwsH9MMGr+sV5P9Hp
         5tY4Cl2nyG4tEFqHNZym+uqxya5vPCXDMVw/dEDI6yFsEa7Fv+hcKYew2g3zdKZYyy7J
         DLicNdPjRLtJkXpZpipxU6LDBIbkBCF/2pfbM2Q+TthMyyU01sOKEMkkVaAlFkqheose
         FYg3WoZuLwGuK3IM5svNOADD8P+vzjYlYR44zvznRrv2A5PF0BjiH3fZ2G8ptn6XSuTk
         10WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696746; x=1784301546;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o8WP2eL0x+SNtsmLV2uduaPSaQ1IOVzdNQkA8jV8dCw=;
        b=K/3F2C9P1V0IMjgB8Pk2ovxgrStbVOFY0U6EimjB73nLlIpl//2XiRW29ckuiKlugZ
         3X2wCbp0ZOEy+oR7E6S6EF0w/x9j+ZVnm9n2Fap2MmqsWWnNTJb0Ba8MMHQ+AbpdBoEt
         WQCbaBo1JYFpKyq/eman9qqs58leDtN8Sb6JgyYArwQRcc/V3U+AcqbKzA/aklBxeh9P
         d+VBnlnd3ksvzNsuSPbA+GhMIYcMCSB/6mS23WkN7DXBAHSTaHv9EowtS75jG7mM0pNT
         KekR9pmEUb0Cxm7UQoNTogs9Asvybdlmwqr/kavoPveELlnZBCSfj20hT8UWkulGTgak
         G5UQ==
X-Forwarded-Encrypted: i=1; AHgh+RqykWmfl9+Tqi8SAYOc4RBKx4Bb85JQJObG3SPyGFrv48b8Not4mPqV1etSUsN2WBcAaJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8baKlVyG3Wrz/hML+T6/JvYJsc5RtLzDFPTmdJ+pwkZU6H7q5
	8wHHMAyAETQU0eVrhG7WUny/ZlqxNWCSJ3l/+uw/jaWX6ob8nOTLMixL
X-Gm-Gg: AfdE7cn26v+kdMlLW/RxWGPzJ10336qR3k6FLSFa816pbUnxdvHP0XkZo5kwPcI1WTi
	2nccRlQnMbxsNqtb9ojBW2xKFbF0OOyMaegJlDFgbbBEuD9z1Z158sub62eDDx/EoAhQQQKd5S7
	m2SO9Ar79u75Ixc7Q701zBkyjQSWORrJT3XadveC/42OXVyLW4u9J67qAkP1k4oAPXFitbkOqUP
	2BzOtTx/k9zS1ExgUgU0N8nnHQLqMfCWuTdQ07igu5WXvau978JV4lHTAgMACPNhM5fx49Blj2p
	qMP3GsWnJKbMA/R3h8oeR6cd6C1Z+g2koRlzI8CIyMGssyrIwhLeqbYjuS3CUILjRnalZlDPHEv
	6TKbFuJyLpK4H4M6c9Fscl3/g+PWRNpq0UkbyEuxG006I2Be6jLvNwdzUqbE1wOWSLKtEtzyfhP
	y8DV9qh+EpWMtiuufm4o3blnBBasrxrMIOTy4MktFAsrFM55GHHXqeuTBXJq/nHJB0LME=
X-Received: by 2002:a17:907:980f:b0:c15:f0b8:eb91 with SMTP id a640c23a62f3a-c15f0b8f111mr270419466b.7.1783696746040;
        Fri, 10 Jul 2026 08:19:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15b1a1011fsm619997166b.58.2026.07.10.08.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:19:05 -0700 (PDT)
Message-ID: <97554903-95b2-4b50-9c60-d13edca77e5e@gmail.com>
Date: Fri, 10 Jul 2026 16:18:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v18 3/7] branch: let delete_branches skip unmerged
 branches on bulk refusal
Reply-To: phillip.wood@dunelm.org.uk
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <a0fd5b4a6c1b9d7823b431be703ee1696ea41f6c.1782338106.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <a0fd5b4a6c1b9d7823b431be703ee1696ea41f6c.1782338106.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/06/2026 22:55, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> @@ -235,6 +240,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
>   	int remote_branch = 0;
>   	bool force;
>   	bool quiet = flags & DELETE_BRANCH_QUIET;
> +	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;

The same as the last patch and for the next patch - as we're modifying 
flags lets keep it as the single source of truth.

Thanks

Phillip

>   	struct strbuf bname = STRBUF_INIT;
>   	enum interpret_branch_kind allowed_interpret;
>   	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
> @@ -319,7 +325,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
>   		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
>   		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
>   					flags)) {
> -			ret = 1;
> +			if (!skip_unmerged)
> +				ret = 1;
>   			goto next;
>   		}
>   

