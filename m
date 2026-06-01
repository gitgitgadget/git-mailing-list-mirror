Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F73DB62A
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327229; cv=none; b=nl12+K0nLaKLfFYUKl2/KumGLbUSW0zhEhdaSc1B2OnF6N6tMF61FsC0MEOg13JrTnq5PCGelJoivYfjGqUjuA1Fdcm2+ZyRlNIYGVEVhQ43emQ1YJxIQyeyeFm0gpTeWl2+mkrq3hZQl7LzN0yiEfY4jd5/lkmYm/iYWpvOTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327229; c=relaxed/simple;
	bh=CXDiMQC48gkB6kQRrAdcuT+H4d/lUR+hB/2k7roFQpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEg+s3NZCMb8M0tu8HDPu0gaPvimgdMcCyNgQUKznYJ6Abg9Y8fqA4vWC4z9oyHP31Z9nPdy+RZRcA1YLChm6r1PB7QsmhRl4qloDA/zTqpMS00E4oTUYGjPc/Ug77XI6iD3ZicHmKd29Q5QqyfyLraBMVMqKrqk/5rXfdpBppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biGpXs6G; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biGpXs6G"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so1416206f8f.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327226; x=1780932026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2QQrke9QBxF0psqPTRLmIW4Aub4nualcSaLAi3Sq33Y=;
        b=biGpXs6G4M+CpPY6cHIXk4v39RCtRmlExT2NpfS6wL4XFVSo11yeEFgH6xZsJbjQ1e
         LwlRoHdKDDxWh8qdxYzH183uYclfm0LkFoeJI35QTU0P4zJxkQVR7+MP5adD9ur5KCqd
         x9vPxSR6dIYJPxb3pYjTO6E90u0wzAYIL2C8vBWfW/XvZAYpObA6sjRZ9RT5H4c+VFMt
         UfSQmE5TtGuph76ENygJ3H/T26nhdmn+sro9//wKxZHH8VzDdxSVbxkjD9mBT4+qiMS0
         Msq4yFW34NEHaI71tXQZ8HcHPznRPucoxs8kCPrxOqa64iXd4pI73hZnKMD5kchdw3Od
         fATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327226; x=1780932026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QQrke9QBxF0psqPTRLmIW4Aub4nualcSaLAi3Sq33Y=;
        b=WaRTzOmYgywk50faPeVIJNX5j0fLPhHmQqJcvQCyPAWLPEoMtUtozEsDa1ywHm8YIk
         usNaFBro66GfLcPkHLuZDohRHZaevlZF2lOJZFoaReTP8kTIECVMfYSkp4sl4oYDDjlq
         Zvwn/FmwOju13D6s0UQwyzdsjw8x4cL/GUFxPOIEowS0ep/QSX9tT4uQZT74vzGD44Dw
         LRx1WCQVe3UTsDy3YHNbebBQQHYsA+eFgmq/a6XvFw7MSKGYN2vGfj9T9Rs/hm1PRdNU
         I9BYNd4AWGxXFe8LNU0xUkvPm5coLkezhO8bUmOJASJ1VxqM9ZfIhJWTMXcqdn7ZsLHB
         NTaA==
X-Gm-Message-State: AOJu0YxwaVIoHR4FQtlnGelalBDPk3oPBDpYbsZcYcvGI+QI+wQGVmHF
	TRmqFUFOshI/OJnTKMiFR/5qv73Mq3r/fXzfobOcJIP2oB5JMLJhISty
X-Gm-Gg: Acq92OH61K20C9d37g8J6BAbJkymyyzuYybLpPpOh8RRCNZrgwUa/wbqUw8KKr5LYhl
	TDVwBk8YzEIMQwrQ/KOAjjKMchAyIb7AudPzxPrbcoVe5NXUm/3tC1OTrMYOxwESnF8k7AFmDJ2
	ovElIwxYfpt83CTWL5PJs/pcQdXyP+nJLc7NFjB11GEuewOOJIq4CMaCyWmFamR8Hu+gzD91fju
	SETGbcOatuIZ/OjWDLwnXZeyiR5f7TIJemTUUEgvf8dZlgI9vnSa/goIZCtpv2Xijw5p5qOeF0i
	NK0dS0Ow1QXltdnvszZn3zWBqY+L1+SZZwNQ0UXCPUnK/ITY2mvNYb5OXkEokogWYwMpe0+oy3R
	8GH9Azwj9HgCzZdEReppOY5h7jathCsdJoT5hS7IVEWDYV9qKlNeRsm0b/61B/Ywl0tVvnGzaPd
	wShF5ZAwvWJrh9g7UuaT6EsR6RQUOEdN7/K8O4iXpVQQL+0Y+04i+89oQukebYRKgJTikxpLa0B
	Bq5H+0psDhSUw==
X-Received: by 2002:a05:6000:c11:b0:452:3677:3fb3 with SMTP id ffacd0b85a97d-45ef6b02b00mr14965252f8f.1.1780327225622;
        Mon, 01 Jun 2026 08:20:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34bcc30sm25892719f8f.12.2026.06.01.08.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 08:20:25 -0700 (PDT)
Message-ID: <4fafee2c-4151-45f4-a842-17d6b77d951c@gmail.com>
Date: Mon, 1 Jun 2026 16:20:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] status: improve rebase todo list parsing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
 <cover.1777648598.git.phillip.wood@dunelm.org.uk>
 <b80bc1e0a298e2773a2fdab3e73651d59b8d39b7.1777648598.git.phillip.wood@dunelm.org.uk>
 <xmqqbjdwcsno.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqbjdwcsno.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 31/05/2026 01:46, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> +static void abbrev_oid_in_line(struct repository *r,
>> +			       struct strbuf *line, char **pp)
>> +{
>> ...
>> +	have_oid = !repo_get_oid(r, p, &oid);
>> +	*end_of_object_name = saved;
>> +	if (!have_oid)
>> +		goto out; /* object name was a label */
> 
> Can there be a label "deadbeef123" that is unrelated to an object whose
> object name happens to abbreviate to "deadbeef123"?

In theory yes, but I had assumed it was so unlikely to happen that we 
could ignore it. If we want to be more careful then we could add a "bool 
maybe_label" argument for commands that accept a label or a revision and 
check if "refs/rewritten/$object_name" exists before trying repo_get_oid().

>> +	case TODO_MERGE:
>> +		skip_dash_c(&p);
>> +		while (true) {
>> +			p += strspn(p, " \t");
>> +			if (!p[0] || (p[0] == '#' && (!p[1] || isspace(p[1]))))
>> +				break;
>> +			abbrev_oid_in_line(r, line, &p);
>> +		}
>> +		break;
> 
> What does this loop do?  A "merge" command may look like "merge
> [[-C|-c] <commit>] <label>", and we give each whitespace-separated
> token to abbrev_oid_in_line()?  Would "<label>" that is ambiguous
> cause an issue?  You may want to limit the scope of what the loop
> does a bit, e.g., massage only the token after -C/-c, or something?

The parents can be a label or any revision so we want to abbreviate the 
parent if it is a hex object id. The same is true for "reset" below.

Thanks

Phillip

> 
>> +	case TODO_FIXUP:
>> +		skip_dash_c(&p);
>> +		/* fallthrough */
>> +	case TODO_DROP:
>> +	case TODO_EDIT:
>> +	case TODO_PICK:
>> +	case TODO_RESET:
> 
> Doesn't RESET also take a <label>?  And if it happens to be the same
> as an abbreviated object name, e.g., "deadbeef123", of an unrelated
> object, would wt-status say "reset deadbeef1", causing a mismatch?
> If this is indeed an issue, would moving this to the "no-op" section
> below, next to TODO_LABEL, solve it?
> 
>> +	case TODO_REVERT:
>> +	case TODO_REWORD:
>> +	case TODO_SQUASH:
>> +		abbrev_oid_in_line(r, line, &p);
>> +		break;
>> +
>> +	/*
>> +	 * Avoid "default" and instead list all the other commands so
>> +	 * that -Wswitch (which is included in -Wall) warns if a new
>> +	 * command is added without handling it in this function.
>> +	 */
>> +	case TODO_BREAK:
>> +	case TODO_EXEC:
>> +	case TODO_LABEL:
>> +	case TODO_NOOP:
>> +	case TODO_UPDATE_REF:
>> +		break;
>>   	}
>> -	string_list_clear(&split, 0);
>> +
>> +	return true;
>>   }
> 

