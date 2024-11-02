Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51842155336
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730564790; cv=none; b=E+rkSOePCHLC3OgiDzdqh+AqZwMcRSTEq0n81nz48VQ+f31+xECMNTaW3o3mF7pL5bD2AFWeJu9RLaqW7OhfiiBlL35WWlW+Z8bHYE7WeG4s8hwO3BgFlc516WPYLdflaIFdMQkNX6+/qs4GIjDnnfOPllRj2EUVrtAHQTh9IGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730564790; c=relaxed/simple;
	bh=Zlh/urkT1azboRrPWTFVykxCxhVw/Md6rUeoyg/shDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lH6d7eMuQ25Hx/4ptQ//M4kUGr4vQCwCXgzl5Hnq0DaheY3bjg7RCVZ5gYOQMJO1zk0Aog+TOTcSnXuMuwn3QOoNS2U8RgCrE+musfeslDsQNHMl6opqjTSkXC9Q4/Oh4jVHbXrB+v/cg2U1nCOl1MC+svk7c4DVdTi2puRYai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL7kvRMs; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL7kvRMs"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ede6803585so2881699a12.0
        for <git@vger.kernel.org>; Sat, 02 Nov 2024 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730564787; x=1731169587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PAAkqS/ZEoxnhnycwYu8SWryrnHchJJtRFu5MRwQrrI=;
        b=cL7kvRMsElBBusihlTGQKfFoKvSLfx7YiaUbQqiL02QGSTlLteqxPBjKRwuiUz1Mbq
         aJAro4oJXUIFpIyx8e0krLN/jnHPo5amRH7LxZDeJVHGj19IWMiu55yFu/ek9olPUs06
         KyTiZ3vHr/EabVw84DThxk9VFsMomsTW9Q8iK+Ye2iuHpZjyQAJd6AHD8/Rakpei+Ixa
         VtdnSxLeicAbt4vi9At7AzRxy+VvnnBQLVtaLU4ZZwHnOevWSEWztEzJEAdrV3gUqSNs
         y5yMKBLAKH9p1aCuIXl2uZKv0LEplh3woZYqs++ooC6Nrhwcw/a67o9e3fOugEpyG3F3
         2Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730564787; x=1731169587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAAkqS/ZEoxnhnycwYu8SWryrnHchJJtRFu5MRwQrrI=;
        b=LR7GelnIVlk2ezy+d54WfBnWfszzhc0BsbvHTz/re+VYNLvu8mEREQNNqy0PJH9aas
         tgjJuPp7rnKl/mAThFQOYgvXA2RRh+BS7215pDEiNTap9XXue8rWh7h3NSrK6DeOfbGR
         2o18+UyjkMOYruSG4a8Bq2lqXVy1XYxLtZwspdK8xb/1at5APg3ohDfF7Q3fZlKOjVwL
         QOyuMhr/Px/0wH9mUe6O+0aVJzEmsuLaaZbmWMufELT8CGb/nRuEPswzvrkavN1p6pF9
         YoiyT6xvBSg00Hl6yVuIQdL5eSIdlPvsjV78QwTtTzCkKwutiDoMyzXXDPQxSK1My6V5
         L1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUcPcKm/lg6jsq1ix0S130aibA61osMCOaRP1qSrP3H7maGO3PMT92Z/LzN9B8YSY69xYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHurqgPVhEYJtBCWzt4vSPlf8tWSfJEOGMWH++2dpzM1F3T1pD
	tA2AbnZU0DHbo2vP9nBOmGzdUtBzP4RRkAt+Nwtu2t99DEVNXOdf/vyh7Q==
X-Google-Smtp-Source: AGHT+IGe/YTsFTWsDS4TxqduMmvB/TAqkbpjzI0DeO8EcMkKfSuNNh8yriqhpO5+JsvwjfJTNWEQfA==
X-Received: by 2002:a17:90b:388d:b0:2c9:6abd:ca64 with SMTP id 98e67ed59e1d1-2e93e0abfb7mr15085322a91.9.1730564787228;
        Sat, 02 Nov 2024 09:26:27 -0700 (PDT)
Received: from ?IPV6:2409:40c2:8053:9c02:ad48:afdd:946a:640b? ([2409:40c2:8053:9c02:ad48:afdd:946a:640b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a60d6sm35200055ad.124.2024.11.02.09.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 09:26:26 -0700 (PDT)
Message-ID: <74c0eddf-8bf9-4fb7-a0cd-edea8acaa938@gmail.com>
Date: Sat, 2 Nov 2024 21:56:20 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] show-index: fix uninitialized hash function
To: Junio C Hamano <gitster@pobox.com>
Cc: me@ttaylorr.com, git@vger.kernel.org, ps@pks.im,
 sandals@crustytoothpaste.net
References: <Zx/NE/9HFNr9V2H7@nand.local>
 <20241101172800.21997-1-abhijeet.nkt@gmail.com> <xmqq1pzuylm6.fsf@gitster.g>
Content-Language: en-US
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <xmqq1pzuylm6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/24 15:59, Junio C Hamano wrote:
> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
> 
>> In c8aed5e8da (repository: stop setting SHA1 as the default object
>> hash), we got rid of the default hash algorithm for the_repository.
>> Due to this change, it is now the responsibility of the callers to set
>> thier own default when this is not present.
> 
> "their own default".
> 
>> As stated in the docs, show-index should use SHA1 as the default hash
>> algorithm when ran outsize of a repository. Make sure this promise is
> 
> "outside a repository".
> 

I will address those in v5, thanks

>> met by falling back to SHA1 when the_hash_algo is not present (i.e.
>> when the command is ran outside of a repository). Also add a test that
>> verifies this behaviour.
>>
>> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
>> ---
>>  builtin/show-index.c   | 6 ++++++
>>  rm                     | 3 +++
> 
> Huh?
> 
>>  t/t5300-pack-object.sh | 4 ++++
>>  3 files changed, 13 insertions(+)
>>  create mode 100755 rm
>>
>> diff --git a/builtin/show-index.c b/builtin/show-index.c
>> index f164c01bbe..645c2548fb 100644
>> --- a/builtin/show-index.c
>> +++ b/builtin/show-index.c
>> @@ -38,6 +38,12 @@ int cmd_show_index(int argc,
>>  		repo_set_hash_algo(the_repository, hash_algo);
>>  	}
>>  
>> +	// Fallback to SHA1 if we are running outside of a repository.
>> +	// TODO: Figure out and implement a way to detect the hash algorithm in use by the
>> +	//       the index file passed in and use that instead.
> 
> 	/*
> 	 * A multi-line comment in our codebase looks
> 	 * like this; slash-asterisk and asterisk-slash
> 	 * are placed on their own lines.  We do not do
> 	 * double-slash comments.
> 	 */
> 
>> +	if (!the_hash_algo)
>> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> 
> OK.  This is in line with how the command is documented to behave.
> 
> Having said that, I am not sure if it was an omission by mistake
> when 8e42eb0e (doc: sha256 is no longer experimental, 2023-07-31)
> marked SHA-256 as non-experimental, or it was deliberate.  It would
> have been an equally plausible, if not more sensible, position to
> take to say that, since SHA-1 and SHA-256 are now on equal footing,
> we won't "default" to SHA-1 anymore, when 8e42eb0e declared that
> SHA-256 is no longer a second-class citizen.>
> In any case, we can further remedy that, if we really wanted to, by
> tweaking the documentation to require the option outside a
> repository without any default, for example, and then change this to
> die().
> 
> Of course, we may want to use the hash that is used in the index
> file we are reading, if we can, as your comment said.
> 
> These incremental improvements can be left outside the scope of this
> change.
>

I see. So while this behavior not completely ideal, we are at least able
to resolve a segfault. I take it that it is OK to leave it like this in
this patch and address it separately after.

>> diff --git a/rm b/rm
>> new file mode 100755
>> index 0000000000..2237506bf2
>> --- /dev/null
>> +++ b/rm
>> @@ -0,0 +1,3 @@
>> +#!/bin/sh
>> +
>> +echo rm $@
> 
> Please don't.
> 

Oops, this is embarrassing, that probably slipped in from a different
thing I was experimenting with which is unrelated to this patch. I will
verify that my patches are free of such errors in future before sending
them, apologies.

>> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
>> index 3b9dae331a..51fed26cc4 100755
>> --- a/t/t5300-pack-object.sh
>> +++ b/t/t5300-pack-object.sh
>> @@ -523,6 +523,10 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
>>  	test_path_is_file foo.idx
>>  '
>>  
>> +test_expect_success SHA1 'show-index works OK outside a repository' '
>> +	nongit git show-index <foo.idx
>> +'
> 
> If we are not using a hash that is not SHA-1, we should then be able
> to do the same check with
> 
>     nongit git show-index --object-format=<hash> <foo.idx
> 
> i.e., with an explicit argument.  I do not think we have any hits
> in the t/ directory from
> 
>     $ git grep -e 'show-index .*--object-format' t/
> 

Would that look something like this?

```
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 51fed26cc4..78047604e4 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -527,6 +527,22 @@ test_expect_success SHA1 'show-index works OK
outside a repository' '
        nongit git show-index <foo.idx
 '

+for hash in sha1 sha256
+do
+       test_expect_success 'show-index works OK outside a repository
with hash algo passed in via --object-format' '
+               git init --object-format=$hash $hash-repo &&
+               echo foo >$hash-repo/foo &&
+               git -C $hash-repo add foo &&
+               git -C $hash-repo commit -m "commit foo" &&
+               oid=$(git -C $hash-repo rev-parse HEAD) &&
+               echo $oid | git -C $hash-repo pack-objects $hash &&
+               mv $hash-repo/$hash-*.idx $hash.idx &&
+               nongit git show-index --object-format=$hash <$hash.idx &&
+               wow &&
+               rm -fr $hash/ $hash.idx
+       '
+done
+
 test_expect_success !PTHREADS,!FAIL_PREREQS \
        'index-pack --threads=N or pack.threads=N warns when no pthreads' '
        test_must_fail git index-pack --threads=2 2>err &&
```

> so such a test might be worth adding, either as a part of this
> change or as a separate patch.
>    
>>  test_expect_success !PTHREADS,!FAIL_PREREQS \
>>  	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
>>  	test_must_fail git index-pack --threads=2 2>err &&
> 
> 
> Except for these minor nits, everything else looks great.
> 
> Thanks.



