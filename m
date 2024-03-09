Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3611134AA
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709949325; cv=none; b=ehhqZBWPk7naZ69qKr2eeFMTXCtbReqtAN1XqXbPhMb6sM2opufBWf1S6+4qzRyX20Aig2ukV3EY/d0TzP2ShfPu42DokP0qkHiStPiA9jpG7uX0aLPgbdVMgZcWg/2xlvC4yK84fuAiwCbXVO3xhGL9cIx92XD8waUDbP/Dwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709949325; c=relaxed/simple;
	bh=s9AwASnqcOEMJ1fj18T1O5unQ+/KYfQRjnuOeR+h4zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRKZlTs9KV7LWsVk6TNFllaWjsz42F3mYPXQ9VasSs4aQxoBG9Q5kwdn82Jbm7AV5gbSkpFMkBsA8FneH/z3caq81nfiaa6E8iQKUPBiavfhYb8HoJ8zBDEr+9DrPLO9HzKSIZMHYDupES9q3ym/uWSk86e6V1QoW4+wOruzV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3he8+XG; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3he8+XG"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690a6675e54so6642956d6.0
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 17:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709949323; x=1710554123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sP6trqddqGg/uDjEowXw+9d2oUVPFpO4/ihf1CJ2pk=;
        b=D3he8+XGs0vNlkuM/+wflbYAngJbfm82C/WNN8ZERkS8DUZWkBNlXvY5I18/DyzIfk
         javDhmOtjvIaHhh7cjBU4rr2cBOWn/RE53Sz6vv2EZGAGP8OvXnD3YWTaBV6FLBreG5f
         aEORJ1cZX/Pj+hclnvM5zLTu1KC5ZjIpuMXWFi9vafldeAImW9SABPDvJG7IngcrJs75
         Bjs27KCa5i+btC1O5CztbRiBL3io5aCHyubDjM4z2J8BzLBrEnMnhWuqbiTLoNFwO5V+
         s1fbOffLhMAgO6QpE2DsaXbWp9jRxOsN3xn7ON8cfk10UEGvXTQlDzYtcxiVt2JwVpW7
         0L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709949323; x=1710554123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sP6trqddqGg/uDjEowXw+9d2oUVPFpO4/ihf1CJ2pk=;
        b=pkKs9gH9reM/7KFiE7CV/Gr/YIyxg8Rqb9OL8MwujWBF6+hSHoN/LkXdmmCJiJS2aK
         sOqg3VAD4JYKPBFfODhu+4ztIlmZFYJvMNdtf9M5uNS+MZKfwVPDouMvhCUl4e8GTGuf
         6dVJj2chgZGYLpvnUB1VwVDRNIe0l0BgoCW6NpcripwdPMQUf8rqv/ebJW2cfMVndamX
         /HujpFdPtebd/MCX5yFnEr6d0nE76ZHD8iWyCCi1brqqki7wysJvFaCKDB91jQQgexVM
         o0S4P9htbWwTEzhJEUzBH1J5Tfcj4XjbkzzPBY3n7CObLtozjRWVy7eEcFqntZ/I3d1Y
         y2kg==
X-Forwarded-Encrypted: i=1; AJvYcCU9cEdQ2gRU2/9ND3Zzv4D7SMrhKSKPNbYZycYi51sLPc+s5W/Kza9NwrMcdJeP902g0/W3yi86Kn3KTkOdkRZpPsqt
X-Gm-Message-State: AOJu0YynCwHPQt0k3Lg1oKuFgUn+bvptVz1ZW5MZ0X8OCyEC1JhTr/dc
	AfOwsDDbTpJO7eMKh1n3hCeZ+tQzoXcLyJsNdEPIms7t3ZpEyjqvSAnnt0O5
X-Google-Smtp-Source: AGHT+IHRbesdAxt9kdaPzFmQrOJuH0bYKsB/LagGsgYZ0JuWCbEOlIy3bD5G7G/BSExD9TYBwbFB7Q==
X-Received: by 2002:ad4:4e2c:0:b0:690:c095:fcc9 with SMTP id dm12-20020ad44e2c000000b00690c095fcc9mr428717qvb.2.1709949322689;
        Fri, 08 Mar 2024 17:55:22 -0800 (PST)
Received: from [10.5.50.68] ([75.99.159.58])
        by smtp.gmail.com with ESMTPSA id ep17-20020a05621418f100b0068f455083fbsm357432qvb.63.2024.03.08.17.55.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2024 17:55:22 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Jonathan Tan <jonathantanmy@google.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/2] index-pack: --fsck-objects to take an optional
 argument for fsck msgs
Date: Fri, 08 Mar 2024 20:55:21 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <67B9F50F-4499-4059-A49E-B70CBD36B9B2@gmail.com>
In-Reply-To: <20240308222439.GB1908@szeder.dev>
References: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
 <pull.1658.v4.git.git.1706751483.gitgitgadget@gmail.com>
 <f29ab9136fb4c23c5700a73731a5e220f92b7c30.1706751483.git.gitgitgadget@gmail.com>
 <20240308222439.GB1908@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Szeder,

On 8 Mar 2024, at 17:24, SZEDER G=C3=A1bor wrote:

> On Thu, Feb 01, 2024 at 01:38:02AM +0000, John Cai via GitGitGadget wro=
te:
>> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
>> index 496fffa0f8a..a58f91035d1 100755
>> --- a/t/t5300-pack-object.sh
>> +++ b/t/t5300-pack-object.sh
>> @@ -441,8 +441,7 @@ test_expect_success 'index-pack with --strict' '
>>  	)
>>  '
>>
>> -test_expect_success 'index-pack with --strict downgrading fsck msgs' =
'
>> -	test_when_finished rm -rf strict &&
>> +test_expect_success 'setup for --strict and --fsck-objects downgradin=
g fsck msgs' '
>>  	git init strict &&
>>  	(
>>  		cd strict &&
>> @@ -457,12 +456,32 @@ test_expect_success 'index-pack with --strict do=
wngrading fsck msgs' '
>>
>>  		EOF
>>  		git hash-object --literally -t commit -w --stdin <commit >commit_li=
st &&
>> -		PACK=3D$(git pack-objects test <commit_list) &&
>> -		test_must_fail git index-pack --strict "test-$PACK.pack" &&
>> -		git index-pack --strict=3D"missingEmail=3Dignore" "test-$PACK.pack"=

>> +		git pack-objects test <commit_list >pack-name
>>  	)
>>  '
>>
>> +test_with_bad_commit () {
>> +	must_fail_arg=3D"$1" &&
>> +	must_pass_arg=3D"$2" &&
>> +	(
>> +		cd strict &&
>> +		test_expect_fail git index-pack "$must_fail_arg" "test-$(cat pack-n=
ame).pack"
>
> There is no such command as 'test_expect_fail', resulting in:

Indeed, thanks for catching this.

>
>   expecting success of 5300.34 'index-pack with --strict downgrading fs=
ck msgs':
>           test_with_bad_commit --strict --strict=3D"missingEmail=3Digno=
re"
>
>   + test_with_bad_commit --strict --strict=3DmissingEmail=3Dignore
>   + must_fail_arg=3D--strict
>   + must_pass_arg=3D--strict=3DmissingEmail=3Dignore
>   + cd strict
>   + cat pack-name
>   + test_expect_fail git index-pack --strict test-e4e1649155bf444fbd9cd=
85e376628d6eaf3d3bd.pack
>   ./t5300-pack-object.sh: 468: eval: test_expect_fail: not found
>   + cat pack-name
>   + git index-pack --strict=3DmissingEmail=3Dignore test-e4e1649155bf44=
4fbd9cd85e376628d6eaf3d3bd.pack
>   e4e1649155bf444fbd9cd85e376628d6eaf3d3bd
>
>   ok 34 - index-pack with --strict downgrading fsck msgs
>
> The missing command should fail the test, but it doesn't, because the
> &&-chain is broken on this line as well.

yes will need to fix this as well

thanks
John
