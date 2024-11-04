Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91C1C07E4
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735809; cv=none; b=KuWORBnV9lLAHYMUqf+9snLKrja7XnVfkl/OOLnRiGgWCRWCggOeBO3vyPujBHrJXpcrJgBaqWPHCQ4fyH9fEFi07XDTGIgngxC16rU5ZuPwUUjg+DxD+pi/fp7lKVNUoyCzJtJ0yAkzOafvE6uheWvqnJYFHaJf+SpphYaR/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735809; c=relaxed/simple;
	bh=I8Ld9MUOzaiB3KQQ57EylTdNoShuuXJg1jLUwyuPs1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hv7axziZeb+F/chHfzXMHKrLZ/YaPVGvVbDU88/ugdfXgdSXuSBJeeSWZTr+390g1+Qs3PTRV633/BxkgjoNDa1X+QcDXzP78C4gupN/T6hk9WlBz2QxRjaitxR7cOBGxc0NNT26m/wj1Cng9zdvTrjoCTNVYnG57Xfa6Pq8Yus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRDvNvee; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRDvNvee"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso4148395276.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 07:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730735807; x=1731340607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVxeHL0MVuRO1K1CClEdy69GMKGKhw2Vm1t9qKtfqmk=;
        b=DRDvNveeGyO3h9akrHMI3+EhJJvL/VSCwUdIKDc/Qc1A2xEknNtR7Eyp5mqRypxwFz
         NXiyI5JGn5xxwWwSTkPKMrpwWdDfDBBTgRVpLk0bjfd7Fd/tBk/b126Gen7YScMRvcUK
         oZJ8XC5ZaG3gEQvh0WzGEtdP+rNvCWs4U3xnmNxbFlylhZ8aWUwB6pPvnxigXyvYek6M
         JRZOhh8lrQuQG8JSOih2duG/hr5+tCHYIRI0QuX4uc8207HHT6SFz7JBjMxuJ2fylGP+
         4IKzGgrByPSdh/CayLTnGYLUz6/mPJ8AjDW4IOg4EdG+5JGbrDXYw8Vl2Phke+BG8VK8
         FOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735807; x=1731340607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVxeHL0MVuRO1K1CClEdy69GMKGKhw2Vm1t9qKtfqmk=;
        b=lVP+JKw+p4Hfj5PK2UQSM5oX6bmp4uHnv5d8HsZT35EQTqBf7dchmqmDpB9E4yUSk6
         2sweF38OJbOQIp0yQU+8TWfDrhmEDoLGyXzIoAIjgPvJQAD92Um7NuZ8A+tYllD/xFMu
         bQLlIBrIVLsTSSeQ4v4kLUf3QRhSp2zoNF55Hxf1ZID9rdXZR3z4OuanYKWLQ8KdH5p/
         aOlrd9l+vYETTlYuQt4OsGoF/jtxOrDOSTuoJZDHStO+4IcNldf0mV33K82YZe8sXRzP
         8Pe3gCugociszpbohjGkFfGHhPhvum6h4LmkvagTecq2fimqOJPn/3CJNOvtARh8Ggkz
         dHwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU++4+Dud3g2rs+5WzBookIJcbnV6hGpBIeLeq4/opzXbGtRkur14wqrvd56G9BTwEXPNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1v2IFUYCDsibsueCQE22vT2X4ZWNjkmqx+QslODYSCFjYeT8s
	Me+eKy+W+GSbn+qri2nvNdi0oE7OmB4yu4wMVHYzdwzZwWSb21Xw
X-Google-Smtp-Source: AGHT+IEQUDeeA29xY5rUqmxu6mknTa7qgWDgIQaGeSTui4rMWNmDSQeR4fanrHeMYjH607MYPOdMHw==
X-Received: by 2002:a05:690c:968e:b0:6ea:84e9:1612 with SMTP id 00721157ae682-6ea84e91a7dmr56909177b3.29.1730735806922;
        Mon, 04 Nov 2024 07:56:46 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:2db7:73fd:372e:bf53? ([2600:1700:60ba:9810:2db7:73fd:372e:bf53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea7e378fd6sm10337127b3.112.2024.11.04.07.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:56:46 -0800 (PST)
Message-ID: <1b81a6a3-ba51-4d2c-8529-1063d045bad5@gmail.com>
Date: Mon, 4 Nov 2024 10:56:45 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] path-walk: visit tags and cached objects
To: karthik nayak <karthik.188@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <3dc27658526784edf46f67661d1161a8eea3ea0a.1730356023.git.gitgitgadget@gmail.com>
 <CAOLa=ZR1BjKzujxpA2icAfJHin-krqwkxTf5VPeGg14AVr-TcQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAOLa=ZR1BjKzujxpA2icAfJHin-krqwkxTf5VPeGg14AVr-TcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/24 10:25 AM, karthik nayak wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The rev_info that is specified for a path-walk traversal may specify
>> visiting tag refs (both lightweight and annotated) and also may specify
>> indexed objects (blobs and trees). Update the path-walk API to walk
>> these objects as well.
>>
>> When walking tags, we need to peel the annotated objects until reaching
>> a non-tag object. If we reach a commit, then we can add it to the
>> pending objects to make sure we visit in the commit walk portion. If we
> 
> Nit: s/in/it in/

thanks!

>> +		case OBJ_BLOB:
>> +			if (!info->blobs)
>> +				continue;
>> +			if (pending->path) {
>> +				struct type_and_oid_list *list;
>> +				char *path = pending->path;
>> +				if (!(list = strmap_get(&ctx->paths_to_lists, path))) {
>> +					CALLOC_ARRAY(list, 1);
>> +					list->type = OBJ_BLOB;
>> +					strmap_put(&ctx->paths_to_lists, path, list);
>> +				}
>> +				oid_array_append(&list->oids, &obj->oid);
>> +			} else {
>> +				/* assume a root tree, such as a lightweight tag. */
> 
> Shouldn't this comment be for tagged blobs?

Yes. This is a copy-paste error.

Thanks for the careful reading.
-Stolee
