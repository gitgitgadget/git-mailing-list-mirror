Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62510788
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720912893; cv=none; b=RohPYV+COKCkNOMQPvYdS1Jq20miVcmRVIwiJN4Ofm3dFWFZqEMrbAzDA1WZh9oD/XBWLGIWJa/xtNpUucXERB4sbIxdR92m2nmqGtq5h70poJejAV7qGCzFKU4iMZXGoQrlwEnTxXYPdy7xD64rmfsbhhf/XKRR5XiKQqMpObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720912893; c=relaxed/simple;
	bh=JNbgRcvHQIgUMKM4AUWsvOgUW5jtw8UVjxVwbfhjHAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBzyX2vu7N+5ccsX2WIxEuNTPLrqTnrWlYQQnVp7ecGddWPotxaDzUDdKzNBiJIHwMctu/T8oBWyjwftptyt+2zFcLLBOsr0iOsXRduDvAALJhw+0xIb5FHVeZbaqZSmkfedO8msDxUI9IzAt7z6oR/9FJ+0FPcGxbDTWqHtRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H31F80zi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H31F80zi"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb1c918860so30021835ad.1
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720912891; x=1721517691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1sE87Z61pLzkCX4Dlim+sBZXy2/Q3aJIr9/W7yN4C4=;
        b=H31F80zisimMo1cHaa8RfflPXkP3YMZADRTEPqJuh2uI1tfFbw/NYEIJqmEuCw+Xcv
         cZ2WhWHJAM+gR2zLp/xuEfp56N11wF4Vs8+6b0cTvhB1gjcbXdZJ5ZbYTnENqGVtXHCs
         h/bm+EhUQi5ZxBRQupJYI2TByVFPO16BkbNHPNJMkMsKxNxkpxJS1ho6R3EQh0En20ND
         WamkXte9j/CqKW2/1FmlSXt5vA28WpriWm41ywX17Q4TwWIiGbe77MlwUyks2VDxbnXa
         Vbdmadqk3TXOokotYlaqhgtPetgeS4DuVFzh+vox77jAPKxq5XKIHbvJ9O09129w+ieF
         UpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720912891; x=1721517691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1sE87Z61pLzkCX4Dlim+sBZXy2/Q3aJIr9/W7yN4C4=;
        b=E+y4ROeIKjOntDbbdwJieAbLJDhEZAsVx7hijHCthzHoYIg5l8B27p+WDyxPcbUtFd
         oX57YSb1UzpOad1A3wRlwuOrQPxar3oY0mEekqnPQfgb7tdilNl7CIAz1GUgpkky8SKZ
         BXNZ3mfzbdAcMXQO1kuuolGQ/P2DEa/eTY1telmASbmZJbNwmW8IkeDjNK7bTnEuWib6
         CzBRek+7+EaJPTU2nPdIm43DUrXeDABQV8OJra9MOOjXNI3ZD7bsENpH8Q8MA5IP05Ka
         BhOFlbNBSZv4Y7VpW1F1/nudFT8w8qGdWW4SPCTimQ8lkymLTQrO+W2W6G72Rti+/8Bm
         n3Lg==
X-Gm-Message-State: AOJu0YweVljR0u8paxf1i9WToZ9elHqDciVw6JhYnjnllMq/hYfcQSIP
	pS2hWTFkbf73JWUe+c+JOWBtRnOY/9c2S9LFtiZl+n/13neNQ1Um
X-Google-Smtp-Source: AGHT+IEM12XdlW2vatg93vkMpsyiallnwx/EjTO/5pI218pAF+3mxbVHHjxDQcV+PRYK4EYdMIFpxg==
X-Received: by 2002:a17:903:1c9:b0:1fa:1a78:b5a9 with SMTP id d9443c01a7336-1fbefb70063mr105027665ad.3.1720912891238;
        Sat, 13 Jul 2024 16:21:31 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc271e2sm15049875ad.168.2024.07.13.16.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 16:21:30 -0700 (PDT)
Message-ID: <ec13ed8a-3ad8-45d0-9120-2f5ddabc14fc@gmail.com>
Date: Sun, 14 Jul 2024 08:21:28 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] use the pager in 'add -p'
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com> <xmqq7cdpb4op.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq7cdpb4op.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Jul 13, 2024 at 10:08:22AM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >     -+	test_write_lines P |
> >     -+	(
> >     -+		GIT_PAGER="head -1" &&
> >     -+		export GIT_PAGER &&
> >     -+		test_terminal git add -p >actual
> >     -+	) &&
> >     -+	tail -n 7 <actual | test_decode_color >actual.trimmed &&
> >     -+	test_cmp expect actual.trimmed
> >     ++	test_write_lines P q | GIT_PAGER="head -c 1" test_terminal git add -p >actual
> >      +'
> 
> "make test" has this to say:
> 
> t3701-add-interactive.sh:619: error: head -c is not portable (use test_copy_bytes BYTES <file >out): test_write_lines P q | GIT_PAGER="head -c 1" test_terminal git add -p >actual
> gmake[1]: *** [Makefile:132: test-lint-shell-syntax] Error 1

Ouch. I'll fix it.  I think I'll go back to "head -1".  But I'll wait to
hear comments about the change in the message.
