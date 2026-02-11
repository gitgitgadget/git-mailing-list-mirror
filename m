Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC435FF4C
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803097; cv=none; b=YA6TnlOgOyM1xQcBjQW8XJ8bS5JbLczSpFyQUKhz6ytwcxRlB8/rUp1jH7ug9x5lV/GeVTbwcOK+QTmRp2gIEyb9uRmeNqzqodq7MYq97jxBUGDnhaaR4ZZvcWmELeFgwYhNuBqB4TBFgYiMUUM4p+cOYQD6vpQcQvmMoD4bQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803097; c=relaxed/simple;
	bh=CoTCYUieW9f/9u1vPeh/vIz0CY+yHtjgNwKcDvflUSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=di3jGsyg8+0ON2EjTCCav7YpiTpLvKT4/UM9xghA8hW76ghzLG664nrKI8vDU8ZaxTNwIU6MX+15Zzyer9u2yZIs1WrC3fvsAgyif0Y2ddkkSyHcox2kKnzb0kcCr0VpePuuP2g0X3jPcTEu1+/CVQ2ihsHTXaX0yVK4GJwUyqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qy1t7JSl; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy1t7JSl"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48069a48629so59465585e9.0
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 01:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770803093; x=1771407893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2MDS6JahC3nmKYDjCtgmLBu9IwTJv55e55JlqbADc4A=;
        b=Qy1t7JSl9zTUZ7Fec1Tv9YhI97kAQrVTGj4cCyaFp4eH1j9d04W+KeQQHrXmNH7wn4
         TMechJJCKKIOCBskbDBGOlKBf3bQKX0TPxriQWOfIQgL0xoBsp+Q5FAIZPwojmrPZOnX
         7+YbBQ8AA15y6VXXwcnWFqLDb6Eclm6oVxzZiX9hnjnJc7xxOYbtuzDSq7/2ET+f+kVq
         bxWnYFQwg+PoQa7txXOhSi1KUh42lud1HxcaI5bS4A11CmC8JYzIh/UiYk/9M9L33+ev
         vKa8lZdn0P7Uan5L1OwL6MEYbEi8sdPzqh7/jB3qOsTAKe33cq1n/iXmWhaHwpdgsgAc
         Nxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770803093; x=1771407893;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MDS6JahC3nmKYDjCtgmLBu9IwTJv55e55JlqbADc4A=;
        b=BwiVSeFY13QsdYyOD6WiFfhTUTfVuKPtvM34mT3jik93+XgsZFFZglybpVRHrN+6sU
         /w/KSh21LeenqWTlyV/LP+4X4yf25j64sHYedq43Am4lQai/PW9IvuwCrPfRrWYlDhZn
         A1k88KlNO3jETGMO/w5O8SFduIKRB2s5peYqpUr4bM6STFjtUhzjdVH9XKYVJnzIeW6P
         uMbdd7D7HZ5MgXkDbUdcBCTk999d+Bkgzc78umkHtNww7hkx6GSkfdggtKsd+IOiYFFt
         h1IIh/UDGzmm5aB3OoHWXcyMrPn9/Z90lLQeoQtNZxYchlldEcqvk7rgvAVl4qsX4aU5
         DpvQ==
X-Gm-Message-State: AOJu0Yy7iN0mYXg6cAO9Q0Guif8xaGf9Eq+SICxwXWx5Kg1Pjfs0LgOE
	ukvPv81IFhDpuB1FR80zKwLpWM7RE35zQVozDqX0/bMh3SHlgGuvYOsY67K5bpbc
X-Gm-Gg: AZuq6aIk82Jyzh9fAz9AsCFpEYsyx7dA7si+GnaoSMMH4SQtyb1zjmtbcNMi1Qzb1e7
	089cnASiurQrN2EokVFagZaxmZZlK2A84z/anzvbGHPzB1IlgV6A2gzDSMc6grPRcfsOVahtHDD
	p251CFOEL8gNgn6qBH5UuET+GJQ5wM+DF5vxvwmks6EIf+eeQiqOBek92VRYxkSlRCMypQ15LKa
	LnWM81cKbpoIqTKb2CimVdWex+e71YDv8rOp2YvxWrygR3SPm6dQLEJBVq5x4WwsChwjG0yvatv
	zL2c364/YeUZuHDQJbb3jn2qq0U8MlNBXGubPZCBCFSeZ6dr40/6e+7/VIH64jA2iN8w+VRZUdD
	Bpvxp5Vstjh4C0seDldQTGNoMaCdS0MDna2bX3QJicUd4L+6iIbvCKJuvjYFWGfe8PMZG6T7aaS
	sxICqx8oOIcWg7BbgIcyyQMjxZc7fszW1qMShX84SSWFYno34xQ2Oq4Vtykc8Zl8OBkg5CxRLLe
	3LXEA==
X-Received: by 2002:a05:600c:4ed3:b0:480:4b59:932e with SMTP id 5b1f17b1804b1-483507e184amr68187425e9.11.1770803092554;
        Wed, 11 Feb 2026 01:44:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a610e72sm18137965e9.2.2026.02.11.01.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 01:44:51 -0800 (PST)
Message-ID: <4a566010-821b-4078-9563-9ca00ada55a0@gmail.com>
Date: Wed, 11 Feb 2026 09:44:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation
 changes
To: Patrick Steinhardt <ps@pks.im>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Evan Martin <evan.martin@gmail.com>
References: <aYn8XKv2hH2HX2xO@pks.im>
 <20260209215015.25867-1-ben.knoble+github@gmail.com>
 <aYwzAt-dugh_acj9@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aYwzAt-dugh_acj9@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/02/2026 07:42, Patrick Steinhardt wrote:
> On Mon, Feb 09, 2026 at 04:50:06PM -0500, D. Ben Knoble wrote:
>>> On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
> [snip]
>> Only, things are behaving oddly. For example:
>>
>>      λ meson setup build2
>>      λ ninja -C build2
>>
>> works fine, but
>>
>>      λ ls -l build2/config*
>>      -rw-r--r-- 1 benknoble benknoble 17169  9 févr. 16:39 build2/config-list.h
>>
>> I don't see the dependency file.
> 
>> Further, re-building seems to get stuck (I get
>> similar symptoms if I add or remove a relevant config.adoc file, but let's keep
>> it simple for now):
>>
>>      λ ninja -C build2
>>      ninja: Entering directory `build2'
>>      [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped by meson to set env)
> 
> With "stuck" you mean that it doesn't do anything, or that it doesn't
> actually rebuild?
> 
> I guess it kind of makes sense that a new file wouldn't trigger a
> rebuild, even though I would have expected a removed one to trigger one.
> After all, the dependency file only tracks the set of _existing_ files
> so that we know when to rebuild, and of course the dependency file only
> gets regenerated in case any of those files changes.

If anyone adds a new file under Documentation/config/ they will need to 
update Documentation/config.adoc which should then trigger the rebuild. 
That rebuld will then add the new file to the list of dependencies. If 
they remove a file we should pick that up with the dependencies that are 
already listed.

Do we need to create the depfile when meson is setup? What does meson do 
when the depfile is missing?

> The thing is that build systems like Meson really want to know the list
> of files ahead of time so that they can have an optimal build graph. So
> we could of course list all the files that we actually depend on. But I
> guess that's something we want to avoid?
> 
> There's another, alternative approach: you can have a separate build
> step that's marked as `build_always_stale: true` that lists all the
> config files. This step would then always run, and it would only update
> its target file in case any of the files has changed.

It would be really nice if we can avoid regenerating the depfile with 
every build.

Thanks

Phillip

> Combined with the depfile we'd then rebuild in all cases:
> 
>    - When a file gets added or removed, as that would cause the
>      `build_always_stale` target to be rewritten.
> 
>    - When any of the files changes, because that would cause the
>      dependencies in the depfile to change.
> 
> Something like the attached patch (note that I don't perform the
> necessary changes for the Makefile). I confirmed that it works for all
> of the above cases.
> 
> Thanks!
> 
> Patrick
> 
> --- >8 ---
> 
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 75c39ade20..17605e6f77 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -1,13 +1,6 @@
>   #!/bin/sh
>   
> -SOURCE_DIR="$1"
> -OUTPUT="$2"
> -
> -if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
> -then
> -	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
> -	exit 1
> -fi
> +set -e
>   
>   print_config_list () {
>   	cat <<EOF
> @@ -30,9 +23,50 @@ EOF
>   EOF
>   }
>   
> -{
> -	echo "/* Automatically generated by generate-configlist.sh */"
> -	echo
> -	echo
> -	print_config_list
> -} >"$OUTPUT"
> +case "$1" in
> +generate)
> +	SOURCE_DIR="$2"
> +	OUTPUT="$3"
> +	DEPFILE="$4"
> +
> +	if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
> +	then
> +		echo >&2 "USAGE: $0 generate <SOURCE_DIR> <OUTPUT>"
> +		exit 1
> +	fi
> +
> +	if test -n "$DEPFILE"
> +	then
> +		printf "$OUTPUT: %s\n" "$SOURCE_DIR"/Documentation/*config.adoc \
> +			"$SOURCE_DIR"/Documentation/config/*.adoc >"$DEPFILE"
> +	fi
> +
> +	{
> +		echo "/* Automatically generated by generate-configlist.sh */"
> +		echo
> +		echo
> +		print_config_list
> +	} >"$OUTPUT"
> +	;;
> +deps)
> +	SOURCE_DIR="$2"
> +	OUTPUT="$3"
> +
> +	if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
> +	then
> +		echo >&2 "USAGE: $0 deps <SOURCE_DIR> <OUTPUT>"
> +		exit 1
> +	fi
> +
> +	TMPFILE=$(mktemp "$OUTPUT".XXXXXX)
> +	printf "%s\n" "$SOURCE_DIR"/Documentation/*config.adoc \
> +		"$SOURCE_DIR"/Documentation/config/*.adoc | sort >"$TMPFILE"
> +
> +	if ! test -f "$OUTPUT" || ! cmp "$TMPFILE" "$OUTPUT" >/dev/null
> +	then
> +		mv "$TMPFILE" "$OUTPUT"
> +	else
> +		rm "$TMPFILE"
> +	fi
> +	;;
> +esac
> diff --git a/meson.build b/meson.build
> index dd52efd1c8..6b9147a39a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -716,14 +716,29 @@ if not get_option('breaking_changes')
>     builtin_sources += 'builtin/pack-redundant.c'
>   endif
>   
> +configlist_deps = custom_target(
> +  output: 'config-list.h.deps',
> +  command: [
> +    meson.current_source_dir() + '/generate-configlist.sh',
> +    'deps',
> +    meson.current_source_dir(),
> +    '@OUTPUT@',
> +  ],
> +  build_always_stale: true,
> +)
> +
>   builtin_sources += custom_target(
>     output: 'config-list.h',
>     command: [
>       shell,
>       meson.current_source_dir() + '/generate-configlist.sh',
> +    'generate',
>       meson.current_source_dir(),
>       '@OUTPUT@',
> +    '@OUTPUT@.d',
>     ],
> +  depends: [ configlist_deps, ],
> +  depfile: 'config-list.h.d',
>     env: script_environment,
>   )
>   
> 

