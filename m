Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A41372ED7
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658172; cv=none; b=fh6SBhXlr2Bp/2tfpIC55CQsH4t60Xig6gpppyEGu770RU+vB+BmzALmgIcDKdh9HO870Qa6saz7b4lEdSNuJCjMwtULZ0Gj6O0TdKFNBHq7ulasDARkGd3F3mjVZOQay/ROlG/6b1tFrV1AEW4YOFFsPg/ccjUqBYyDWe7Gw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658172; c=relaxed/simple;
	bh=mcEHn7YJGIY4Pz43arjWE66myaAYj5Uzy8vdFYWapiU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IXiM/GBjKdHQ5QyIheJz4wbo+dSdU+Uk+6QnbxK+BPh9FQChWX+j+ENJ/SZF3yjmc2JpuZGsLfU9ANrgW8cN974jXJxoPMANkRANefRQogXizqmSt8CbUK57VoVJXaATon4SfeMJuPiGVLOzA1SQVllU5FRjnmJC+SafITy/sXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM4Sshv6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM4Sshv6"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so3890920f8f.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 03:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658169; x=1774262969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCv2wbvdtwm3fIUZxBk4UJ9Q1H35sT5wpwjgI9A9bEk=;
        b=PM4Sshv6qcy7PfFBKW0E3grin61GTmSTBJgm7d1ax1YLDfm4DSK95UKDhWMyvNy7cg
         b9zVBUqxG7Oz041BAj6fcKjfbVUkWL9GUrviYQwWsZ74+MEmSowHd5JIc108h8ZFmmKf
         t/FRo9sQwG4EgWI/CuyU5l7hVT6S2Zga+A9BE8A+fx8xS0CFqW7rH8qXQfHPNj7OeYYO
         EtIf7vxT9bc0VBzgyTmoJ5bgiWt470xgK4drb/JOHOp93dS2dcxC6EBcx/55CtOgYoxv
         anWmBMaI2ScS9NIXkON5kMOsBZB5VfmH8UVdSDFYHvJfeA1QmlrmEv8Kdwc2Fj8jqaI3
         WLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658169; x=1774262969;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCv2wbvdtwm3fIUZxBk4UJ9Q1H35sT5wpwjgI9A9bEk=;
        b=nTx6lRi9yc8FK2Gn4326gJkz94GRj0vSo81d2EbnqgvR6Tva6/DvDrt+KobSDzkP/b
         SVI7aselL4zdlUXOv1956txhJ2NcEfwk183fT622izFVsq8LJ1A6hhWOIgohU6SS5pS6
         T+3Oa0syG/cg1cm9+37G95eBDMEYdb+M3JiFlVGqLo6flMpMccRekjVuEyEpn2yavykt
         wekL2/OKbmHRNG/Rx+4DRB6p5tqf3Lj5oHPqTP9Or9voSIIMPVsM9giTe8eRDqFGdPah
         uhnouA+TTZCX7iR2JsnFQtdh7CyglK/9m48ZenVI1L9ObnphzMnfhK4Q0Zd/p/FVKUpE
         V01Q==
X-Forwarded-Encrypted: i=1; AJvYcCVy8dq2z1VfFC4hLj4N7DieY35SAyF5OzOD5hQqVbgULW5Vk62ciUb4HA6D8gP9HHl4JvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIx86MdRamdjNrlYnleZe924ALnX0G9bmOLQIbcQiORJFQjVqa
	3STfwnql84E58hWfo53iWNUi1hgIlonjEOrvivJG5ENQ8QN4HLOmBXRh
X-Gm-Gg: ATEYQzyg3mijDXnd4rGZh09Ik3l9ayyqdK+etemcFyvyMfEXxntb1jwwNrW3XPImW94
	S64jxNPXA81wGjsdxwYpzzvIYjqozgxkayW0/ePrf/+25KfiQWOojib+CQHSQgpQ9AexzujZ7Pl
	cCZyFkXZQDzwSntkFM4oQRE/1KqTBOeTJK0c6Gua1nA9S6Zez0cyRN9w/TkPY9u6WggPKTv9+Q3
	Y56UO9yvAi2sfiv4QX0UuZeyQ+AX3tUak8WDIZXBSxKrg0tYebrlNIQTTcfMff1Caz/T2RyquYo
	7QH7CR2WpmmxzXo+U0ccZe+KVYWUALawrzFYtfiE5wlcaMQl+s4tVtdG4HuYcypOipo9lP5KB6f
	daGSDteT2HQt3cndCtYiXy6mDxGux7V3zkrNve7kqu4qRYRiP70MuNJj0tar0x0LsnfxNTz+EcS
	rwduHoSgelUSCykrJrWOAyw5Rp0Mudo6LbrmBuwKp5+Ku55kinfG0KZuul/+w6a99AuOVM2YqRo
	mEIqQ==
X-Received: by 2002:a05:600c:8b28:b0:485:3c11:de84 with SMTP id 5b1f17b1804b1-48555b47ac7mr197910845e9.14.1773658169235;
        Mon, 16 Mar 2026 03:49:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855725572csm179158085e9.2.2026.03.16.03.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:49:28 -0700 (PDT)
Message-ID: <75c85249-1cff-425a-8e77-98d55215c324@gmail.com>
Date: Mon, 16 Mar 2026 10:49:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] remote: use plural-only message for diverged branch
 status
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com>
 <xmqqqzpmwdyi.fsf@gitster.g> <xmqqtsuiuugy.fsf@gitster.g>
 <ca6e021e-0301-496d-8bd1-b646487ccbf6@gmail.com> <xmqqjyvdvo7t.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjyvdvo7t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/03/2026 02:08, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> There can be more than one form of the plural string though. The gettext
>> manual has the following example of the Polish translation of "file" for
>> different numbers of files [1]
>>
>> 	1 plik
>> 	2,3,4 pliki
>> 	5-21 plików
>> 	22-24 pliki
>> 	25-31 plików
>>
>> ngettext() handles that correctly, translating a single string without
>> an associated count will not.
> 
> That is a very interesting example, and a valid reason to have me
> retract the #leftoverbits that led to the patch being discussed.
> 
> But wouldn't that lead to an awkward conclusion, i.e., hits from
> "git grep '[^Q]_("[^"]*%[id]' \*.c" are potential bugs that need to
> be updated to use ngettext().

I think it does - maybe we should suggest fixing these as a miroproject 
for GSoC and Outreachy? It certainly looks like there are plenty of them.

Thanks

Phillip

> Of course, we need to exclude messages like "the error code %d was
> returned" and "you have a bug on line %d", but there seem to be real
> errors in randomly selected hits from the "git grep" output, e.g.,
> 
> add-patch.c:						 _("Split into %d hunks."),
> archive-zip.c:		return error(_("path too long (%d chars, SHA1: %s): %s"),
> builtin/checkout.c:	    die(_("'%s' matched multiple (%d) remote tracking branches"),
> builtin/credential-store.c:		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
> builtin/describe.c:				_("found %i tags; gave up search at %s\n"),
> builtin/fsck.c:		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
> 
> You can notice that I started from 'a' and stopped very early in 'b'
> ;-).
> 
> Thanks.

