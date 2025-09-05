Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF4626FA5E
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098988; cv=none; b=WtFGvGUJrPmmGmOVNn+qjfKyC2rMnnP6lvSkioaTI8dEeRUp0TDMZBpCp/KBfljDWIqs7fF7wSLloxb64VzLZ3RGervApjJg2hBeqLvzfHbzQ3BtFPDJXYgx2XIYfaE1c9HpvsfN7Cul5EdcW1vzv/Q/t4TOniTiJTyzVZgvXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098988; c=relaxed/simple;
	bh=fJkzUDvxgyFmRLjYLmvLJ7R+chIIBFji5c/UiBEUsu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liV7fs3ZO++5XnBEfnMggQJHHlglI381tCMS+SSeZKHqHMr1G0yTbpVW3maj+nwOwT5vJR6DshxN5vI3XCifwotCbuDLU+egAxKDtXol5/V9aWKL8ryM+yEcyVVN7V1DSgeNB6bF+eGwV7vjGWpT3ybr3HQakaZinfUTGoHyBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPOwNrVN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPOwNrVN"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70dfcc589a6so26888266d6.2
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757098986; x=1757703786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qsN3gwzs4JW0bv5r66z275d6hRRSAbw+8kLeV28fIg=;
        b=bPOwNrVNwYozIQ46UQ8H4R/OWyeW2rbCknrlhFnmtoehtbGyIJqZhC9AYyEdJ+Tzlc
         ojDIdZzY0RKvnrMLwDYwwIm3vrl/3blSvcXeozqUfDMFR1wTOUikQfpC3Y58ujDRPlej
         BuCVZN12lOA2l5E1QhPOt7FlFUtik6ccY7BmVKpAh+79np5GAuGVzZ1My0yyIblx4s5B
         58AuvLoNbMDMuQsHTl9JwBKjmUNEdN1sTF1Yfj0PO/rIDhGc4HH0nrSjMreRGMfNaWAE
         evxf8N5yk/e99HtPz4bTRkVnhLLrvmnpalGPBXAhAv1cw2hb8weVtoAnUgO+N0XLDZRH
         r0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757098986; x=1757703786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qsN3gwzs4JW0bv5r66z275d6hRRSAbw+8kLeV28fIg=;
        b=ZmNzSYNQB5vS7lC39sKRnyaXlIX0cbvSVLMHXC20oXILh5/cbFcC3nnjd8th9Pj/U7
         Auz1vKKIuPfBHtzA7vlADXyd+/YsEkf8T2Mmj0n7YpLD7hQtZcHoIz2bIxI5sdxJSnH3
         kG5h01n4Bgh3j7p/H3xAY6VHbsfw7+RBbvdi4KEq0kfcDEnYHYq0066dqT9kuRQMv2pB
         ATUT+FSbLt8flWFp8wQ4cAWYeJTwzHrr+xlJ2pibYSWyS/K2GhtuvRRvIsueIyIsUkq+
         8JelGhSNLW9jjLP80tmymDlSLL3fr4flTicCdrqJlKG95AQYW4vVekHggMkCT5krwV3h
         hrsg==
X-Gm-Message-State: AOJu0YxnkxqDQJ0ofsjJ7/G3MXNdr7w90mF6kQXMhOT3sPSgoE+/65UN
	C0eUrDzXbYKj/zW/QuzKMkjv1bVzZxInE55QoNV8LStkPDpFH0vfG8c1
X-Gm-Gg: ASbGncsGUDt/O9wgxWTz0QvoW/KTxmjnSITCeXaW0asl+u+SwBQVEub5xFbgpNmnEvB
	9IaNCCvarLRzJO3gFsFA0X1dqW0wT2qpeEZxcJN/yv9QrSvgNRl/sA+DpDT3VmucNHxE2+llN6r
	44bCyZaTBtvQRvITSfagLp4Dh3N5OPb/yKr3D4putChzW6MNAmV01nGlaOedMYUSPSO0KN0KaF1
	h/b21RP/I4IgKxRKJhsqG9t3oDjsnnJ9ZIffbY0gFWClNJi8w6XYYhmtzxlzRs4NHGMuIdVg2XI
	gITHG8l0pQiZq9QneV7M1IbkzEFMWfCL5VJO4MWU3SHW8D/CPySPbL6oCh8oFN+H3g7N89tBEI1
	b3JuW+5B6x9Pfv5Vt9bc+Em5bK/Wb1+A1F/+GoN/XLm1S/IKVbcaDi6C4
X-Google-Smtp-Source: AGHT+IHBaKXhyVwz2727G3WojTCcK+gW0O7HQS/rMy4wsqBvqLJm3CE+J+Jal872kx8mooQkBhO6tA==
X-Received: by 2002:a05:6214:4a4c:b0:728:8e7e:f691 with SMTP id 6a1803df08f44-7288e7f12bfmr58256806d6.1.1757098985506;
        Fri, 05 Sep 2025 12:03:05 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-727d637082fsm40300236d6.34.2025.09.05.12.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:03:05 -0700 (PDT)
Message-ID: <18ff26d7-6e9d-4a8d-9d58-aff69ee8b2bb@gmail.com>
Date: Fri, 5 Sep 2025 15:03:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] midx-write: put failing response value back
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <a1dd3ed87437322e298bb192fbfe4a9641d1356e.1756589007.git.gitgitgadget@gmail.com>
 <aLgVLMnbGiUAviXZ@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aLgVLMnbGiUAviXZ@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2025 6:15 AM, Patrick Steinhardt wrote:
> On Sat, Aug 30, 2025 at 09:23:23PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/midx-write.c b/midx-write.c
>> index 070a7f61f4..0f1d5653ab 100644
>> --- a/midx-write.c
>> +++ b/midx-write.c
>> @@ -1104,6 +1104,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>>  			m = m->base_midx;
>>  		}
>>  	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
>> +		result = 1;
>>  		goto cleanup;
>>  	}
> 
> Would it make sense to also convert this command to return negative
> error codes?

(Yes, in patch 6) 
>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>> index 49705c62a2..008e65c22e 100755
>> --- a/t/t5319-multi-pack-index.sh
>> +++ b/t/t5319-multi-pack-index.sh
>> @@ -1100,7 +1100,10 @@ test_expect_success 'load reverse index when missing .idx, .pack' '
>>  		mv $idx.bak $idx &&
>>  
>>  		mv $pack $pack.bak &&
>> -		git cat-file --batch-check="%(objectsize:disk)" <tip
>> +		git cat-file --batch-check="%(objectsize:disk)" <tip &&
>> +
>> +		test_must_fail git multi-pack-index write 2>err &&
>> +		grep "could not load pack" err
> 
> Nit: this should probably use `test_grep`.

You're right. I think I misremembered the preferred use back when
test_i18ngrep was deprecated.

Thanks,
-Stolee
