Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993D158DC8
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953764; cv=none; b=iT2LE/hdmAOk4L7677YW3134DGM9DWK1RFAwopokYf/mCXgtSZoQdHHpX25Xb/aIuhxFH75GzkXwXIDu/fc0W/XuUIKzqtpjOAYAmstXXC1uELeLqG9vKPe6BmyRIN0nDV5sFhmlIR/ncdEpGtgWHe0gl2+oUJ8hG0mTcJ+3pmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953764; c=relaxed/simple;
	bh=tp3/9dlHv903t2XbZkbbzQIQBWU5hL1o/v6jh0tFnDk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F6ud9o7aASfb72bP+ZkbHHMYOFm43Q6xHkcdvlFmuLGsqVpFI1nh22lHG6DQUdjuVJ/GmTVS+pCaI9GkOiF9SAbhWIcm4jz1lFm7wogk4PVjYCJ/lTYsrTwLU73TYq7pmAhHiLpVlUZvl0xxcE6EIBNq2pVfJBeptxLChLrW+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1QKmZNg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1QKmZNg"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34a7e47d164so4185585f8f.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713953761; x=1714558561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vc97f4PFaU4rs3O1f+iCEqUsZht/kZMaiJHJu+FnDlk=;
        b=C1QKmZNgF1c08I9tO9WziwVnTCxhjWI5RZ8uW1EmbGyqgxbpS6GopXYsfuJodFT5wW
         emdd4SkVgYj6NMvC5HFAzuZvFOqcHX/ah0dDYd34S3FlUaxn/0k490/k3IlA2nVg0qcw
         pJLTMN8G3on8ZFfDZSDvYGDp3NMu8NZ6hhxoJX2OC6diGbeX+PStJgI8fKDS3K+ilNlW
         tK8y7QMw3lPZc5uCTKsLE+YX4Di+DbH4hCIE2wL1wb9O+nnj1a/8KraEWx6VCO8vv9Vk
         +lVr9ULp4wkjJXetE+x6tE2zNL1q/vTPwIMYvMjMgQuC9PVG/dkDH0agC+K8eZS5lDVI
         rpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713953761; x=1714558561;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc97f4PFaU4rs3O1f+iCEqUsZht/kZMaiJHJu+FnDlk=;
        b=MOCFkv6pixWuGep0VVbVUMc4zYjbh9t2sjJqWgf7jwave2iK6NQU+ESn02KNesLvY9
         wvIj90RqpglMrRWChidkLhgqXRxuNmJeHScRS1TDEm2awlsN9LlrJS4IhX4zTFh+e0Tj
         p1eKJfDidFQtClZqF75CIJmMAcG4rnDldV8FS6RspvCD4zNm+fniZ/vMFhRHRIbB9Kgo
         ve+pGskydm7gAoWcKc/7Qc03Vg6aDKegOlPApowEW40wGUA5iNdGVxEPzY/BxZmPukRp
         54P4Dyfg0L7zPAWEPu3Yaell2/AkyfdBH47pFbLbrpLuZM9Z4wDGr05IwzVLoxbu4LUs
         W3Vw==
X-Gm-Message-State: AOJu0YzVCfn7RgG0LEEXLQ5kvATooU19m6EUahBbDAiTGraQdbUp8DGT
	smUxVGEn64OMxMWRvgMe6QExAJdz8JOWsp2B0/Omv1ANHawipHEH
X-Google-Smtp-Source: AGHT+IFEZrybTVSGvfBVyfKMUt42C1k4qI5RxBQXR2C1S+hInZfF/7kD6gnufL7sdEVNwySNFT+v5Q==
X-Received: by 2002:a5d:69d1:0:b0:34a:5bf3:8b9f with SMTP id s17-20020a5d69d1000000b0034a5bf38b9fmr1268372wrw.37.1713953761156;
        Wed, 24 Apr 2024 03:16:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id g18-20020adfa492000000b0033e9d9f891csm16955561wrb.58.2024.04.24.03.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 03:16:00 -0700 (PDT)
Message-ID: <41d23496-0bd3-47c7-a470-39334588f520@gmail.com>
Date: Wed, 24 Apr 2024 11:15:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] add-patch: response to unknown command
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com> <xmqqv849xups.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqv849xups.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio

On 22/04/2024 16:50, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
>> 1:  0317594bce ! 1:  b418b03f15 add-patch: response to unknown command
>>      @@ t/t3701-add-interactive.sh: test_expect_success 'warn about add.interactive.useB
>>       +	test_when_finished "git reset --hard; rm -f command" &&
>>       +	echo W >command &&
>>       +	git add -N command &&
>>      -+	cat >expect <<-EOF &&
>>      -+	diff --git a/command b/command
>>      -+	new file mode 100644
>>      -+	index 0000000..a42d8ff
>>      -+	--- /dev/null
>>      -+	+++ b/command
>>      -+	@@ -0,0 +1 @@
>>      -+	+W
>>      ++	git diff command >expect &&
>>      ++	cat >>expect <<-EOF &&
>>       +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
>>       +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
>>       +	EOF
> 
> Interesting.
> 
> My first reaction was "how is this different from checking just the
> last line of the actual output?  The early part of expect and actual
> both come from an internal invocation of 'git diff', and they must
> match by definition".
> 
> But that may really be the point of this test.

Yes - we want to make sure that we are not printing the help and the 
only way to do that is to check the whole output

Best Wishes

Phillip

> That is, we may later decide to tweak the way "git diff" hunks are
> presented, and we expect that the way "git add -p" presents the
> hunks would change together with it automatically.
