Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361E36BCD5
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930861; cv=none; b=DQed+4hQ0VURhnNZDcALiJFPcuB15vWX0muUESYe9IO8jigkbOfF/JmRLpGwHKBq4z1Q2pWk/pfOUVM3Ami7F83OYrHnYYp0aGxO3LkWKnOy3ZWpm38CQrp00cILEXvy1chd8w5BUAFmVfPh73XLP1e1xfytG/npKyTmEEPH5SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930861; c=relaxed/simple;
	bh=QRGtr/NOvNB+BZ0Og2tlLGkLRZq6r5AJHXpsIGH53mM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GHDvGa/t7tu9D7VXHWs45ElETP6iiSTv88U3KPG/dTqNKTtsUbO7nRBL2cBO44JGVwpMIU9jOB68YjbtgsBT+2izqh83FbUxgvV9X93FvI/qtX+Fzo/6oDV/1pSK8tP+5/89M6N+/4Y6Kqz7/NaYLmVDNWktA8Q/pTYx+qd+Ld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMVUUuhL; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMVUUuhL"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b8fd976e90cso725030466b.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 03:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771930859; x=1772535659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWIjKMsOitCp5jTzZTq+Mh3pwniljKfNuZjSgRZB8T4=;
        b=CMVUUuhLTruh3ov6Rsmk36nUkVuH0q8gvg+gY42TkmxhOJlfKT3xjJ20eAMd+l444s
         Gr2ObSsgVYsTd3wIcumQZ2U55Y4z8IlG0LBIik/0/n53BfcGo6y6COK3NN09+lzCXIu7
         lhvAoxIg0KobXpHVfPu0/7HcW8srPXppzEVY0k6NSxYdxOPEEcCHGWENI4k0ZV19eMMu
         rRDMnrd2Ka8PAJWjHCyb2tLjb8wXfwzd/Zj6ILBMzGwxVD25XEaMQJIm0PEFiAOxjCFv
         LHL/LHKD4iD5MzC0A75VZjeW3WgomZWzEJ946oTYsvh4fTOj/ej6nd88KEklnNE3/6pD
         icFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771930859; x=1772535659;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWIjKMsOitCp5jTzZTq+Mh3pwniljKfNuZjSgRZB8T4=;
        b=T6ntnpwNohhUy/Lc1qOleDevDfYLfphxg4gkJGNuhhuSRePf2tFOjkODdrbfgk7cKn
         pomXSBp0u8SCHAWXRoZMU7UL5vY/OT1pKYuOrQoSYNfvpQ+5kK2HpHIKuKX+GTlw/s0a
         KClH6yyyMlkg5O7RD5P8ZEHSahpDW/a3l7QdxHKqx5v38eb/h1GrgnemsGKihk/bPEHs
         coRF13zSAvEnqVrKFySOTH92z8ZaKQxlN3CY9kxTMZNecaJOxY4W27NUvAZVemPnalGn
         xQe28mXL2eUllD54AfrnAybvnRCQCg82fpCrujkSV4lm9Bju19HKvfF2KG0ftbPpBFvG
         FOkg==
X-Forwarded-Encrypted: i=1; AJvYcCXmmTvgZU4KQg4t2GEnsLP5tm3ZZ2UdiKkpOyfYvkJuLDs7nj4R6Kqvv2WIdC6VR8wq9kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeT9BFfAmWhl5YW0h8SACF6kqhMLy1P6JZwyAODOxJulrZodg0
	kSppyaO/k8QEY1r1Arh92T0GtcG+sMrbJnFQ8ysQ0B88RLsphnfuC3g0
X-Gm-Gg: ATEYQzypQohpmRfrcKCHEBfalmdVw1dvNOrvn4UMI2SACK8ABUorytuL4SOvNIiMgZ1
	zZf9X3i1QB8sMwq8j01+TkyUOzv35aopMlG9Fur1TNiJuyif09lcr5rcVtwSwjfkrVqIgeyK7pc
	QAvt6edXM2wzt1J3HGTzVFjSAWM1kdsx95NElg2P2/GL02cxMgxe+/qYaPkfZV6BkTpAFv6+Rpr
	ldmrEa7tP+vXEhLJgm4ddAXofDWGCGV5AM0IWTjwDARsxeNp8lfPiz9+Hg09G53HxSGIl1gT7mU
	D6ShvL342QoV+zg4gpqE9iGWOsHNzqlo+aeSldHg+peKEV6xhicqaTmJhkmJ4GMhMhJZYAjkt7K
	GTeTZGHI21pA1gYTEKf2jCJKfArfiQE2L9kZaz77kpNDBJCBzHCp2F/F3wMEIkEgWtGL2nUHkD3
	fkEIr4HmqeYX8eaKPP/sdrGUFoB5hOqkW3DQSXEaKzWmW6sFZ2+gUupIUkG1rBVNrKl8jvzCMp0
	dOOKw==
X-Received: by 2002:a17:906:48ce:b0:b8f:bf7e:e19d with SMTP id a640c23a62f3a-b9081b41c78mr521286366b.34.1771930858419;
        Tue, 24 Feb 2026 03:00:58 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9338baee1dsm5594666b.58.2026.02.24.03.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 03:00:57 -0800 (PST)
Message-ID: <39acbf7e-86f4-4dbe-8b58-3c04fccd7984@gmail.com>
Date: Tue, 24 Feb 2026 11:00:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6] build: regenerate config-list.h when Documentation
 changes
To: Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Marc Branchaud <marcnarc@xiplink.com>, Evan Martin <evan.martin@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
References: <aZv54vN9DdGsvre/@szeder.dev>
 <8AB2DD1B-FAFA-4510-82FA-BBD76B442676@gmail.com> <aZ12Lk85bSajirCY@pks.im>
Content-Language: en-US
In-Reply-To: <aZ12Lk85bSajirCY@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/02/2026 09:58, Patrick Steinhardt wrote:
> On Mon, Feb 23, 2026 at 04:41:48PM -0500, Ben Knoble wrote:
>>> Le 23 févr. 2026 à 01:55, SZEDER Gábor <szeder.dev@gmail.com> a écrit :
>>> ﻿On Sat, Feb 21, 2026 at 09:07:17AM -0500, D. Ben Knoble wrote:
>>>> diff --git a/Makefile b/Makefile
>>>> index 7f37ad8f58..6f926ffb1f 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -2688,9 +2688,10 @@ $(BUILT_INS): git$X
>>>>     cp $< $@
>>>>
>>>> config-list.h: generate-configlist.sh
>>>> +    @mkdir -p .depend
>>>> +    $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
>>>>
>>>> -config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
>>>> -    $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
>>>> +-include .depend/config-list.h.d
>>>
>>> This breaks the build when something disappears from
>>> Documentation/config/:
>>>
>>>   $ git checkout origin/seen
>>>   HEAD is now at 57edfa3ce8 Merge branch 'ty/setup-error-tightening' into seen
>>>   $ ls -l Documentation/config/hook.adoc
>>>   -rw-rw-r-- 1 szeder szeder 3828 Feb 23 07:50 Documentation/config/hook.adoc
>>>   $ git grep hook.adoc
>>>   Documentation/git-hook.adoc:include::config/hook.adoc[]
>>>   Documentation/howto/meson.build:  'rebuild-from-update-hook.adoc',
>>>   Documentation/meson.build:  'git-hook.adoc' : 1,
>>>   $ make V=1 config-list.h
>>>   /bin/sh ./generate-configlist.sh . config-list.h .depend/config-list.h.d
>>>   $ git checkout 0aabf70f60
>>>   Previous HEAD position was 57edfa3ce8 Merge branch 'ty/setup-error-tightening' into seen
>>>   HEAD is now at 0aabf70f60 build: regenerate config-list.h when Documentation changes
>>>   $ ls -l Documentation/config/hook.adoc
>>>   ls: cannot access 'Documentation/config/hook.adoc': No such file or directory
>>>   $ git grep hook.adoc
>>>   Documentation/howto/meson.build:  'rebuild-from-update-hook.adoc',
>>>   Documentation/meson.build:  'git-hook.adoc' : 1,
>>>   $ make V=1 config-list.h
>>>   GIT_VERSION=2.53.0.119.g0aabf70f60
>>>   make: *** No rule to make target 'Documentation/config/hook.adoc', needed by 'config-list.h'.  Stop.
>>>   $ grep hook.adoc .depend/config-list.h.d
>>>   config-list.h: ./Documentation/config/hook.adoc
>>
>> Indeed. This might arise while bisecting, which was my original
>> motivation. Thoughts on a path forward? At least this issue (to me) is
>> clearer than a spurious test failure :)
> 
> For Meson this case works alright. So maybe we just drop the changes to
> the Makefile and call it a day?
> 
> An alternative would be to have the following patch on top:
> 
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 39ac8845ab..e28054f9e0 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -41,7 +41,12 @@ EOF
>   if test -n "$DEPFILE"
>   then
>   	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
> -	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> -		"$SOURCE_DIR"/Documentation/config/*.adoc |
> -		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
> +	{
> +		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> +			"$SOURCE_DIR"/Documentation/config/*.adoc |
> +			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
> +		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> +			"$SOURCE_DIR"/Documentation/config/*.adoc |
> +			sed -e 's/[# ]/\\&/g'
> +	} >"$DEPFILE"
>   fi
> 
> What it does is to also create an empty target for all of the
> dependencies. Which is in fact what GCC/Clang also do when you pass -MP:

Oh, I was wondering how they got around the problem we're seeing here. 
While it seems ninja is happy it ignore missing dependencies in 
depfiles, are we sure the build systems meson uses on other platforms 
are as well? If not it might be worth adding this, rather than just 
dropping the Makefile changes.

Thanks

Phillip

> 
>      $ cat main.c
>      #include "foo.h"
>      int main()
>      {
>          puts("foobar");
>          return 0;
>      }
> 
>      $ clang -MMD -MP main.c
>      $ cat main.d
>      main.o: main.c foo.h
>      foo.h:
> 
> Patrick

