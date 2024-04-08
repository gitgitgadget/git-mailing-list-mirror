Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86914387F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604835; cv=none; b=P538lhmSa4m6tTHaijIpYwJO9eERMOgHuZhFJHZfP/qbte1wuxs2kvrM+r24TT2u835IQmYIlfwl1Alw2u6PDwU51UtvKEZ1Pz+ntGFFbRRA1+sNdDHItBcUrCuOHITlmKc+LdlU404be0z8v2pLAJlSjf6aJYQ1JcHcJ7cMzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604835; c=relaxed/simple;
	bh=Yks1/fW1rj4miFCWylF0pqxE8crk9Wt/o8mKfmFPCus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUYUQXmFY98rEV5ZO7i3JX/RJD6bvZ6bR8G+IWkLEiwT5ThnyLZdrHlAuMzUe/jiyW4ckuVucTFiwh2Awhn6AX0lYYX71eziiCGap3Cs7Y2URw2Hqg3BM0lx+JsGGW6B4hp76+bKcVwKZ99zd3Iv7S5bYlZbRF38pl5ZSWFP3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hINsB2Ls; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hINsB2Ls"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-345e1c645c4so568819f8f.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712604832; x=1713209632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRnpz9SE2gdFnB8TZt3JEmc5VBIS62Hz9AcyKEw4a0g=;
        b=hINsB2LsQ23EGz5je8emDfWQdACbh+gVRfQHlabFcRrkab2FpdUFDJrRVyO/357zid
         8dnA17KHDgG1b562GiP1tshIsm85jhBiUsNZzrLY9hFoc/HCaMwx8a5wo+wcs1nANZpB
         KOEom4gbAgObxD3jmLaTI8dssxoH9Kp5FrbNayyP0jn3euQOrKgFCMbl2J1RloqieYkP
         LhBloQ1enU+nMxQnSUVGg5Q4ixjnVfPsYwD98HmJ5du7SaDqiPbaf/jnkIsiTkWmifwr
         NSO5VAym4BzvKGX+hOMSwSPCsN6adLfWGctaXivuwhGQWXECeOBpLvrnjnwFkUOOGaL4
         rqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712604832; x=1713209632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRnpz9SE2gdFnB8TZt3JEmc5VBIS62Hz9AcyKEw4a0g=;
        b=Lzp/TuGc2cfbronER5Dmvxn8q5e3zh6ok3cElcl/GhhHMb2obUtwFksNxqBN6lYxZH
         SvcraChAfVj7d2hLwnK8KI9JvjJFY8dMuXfRHIVjAr3WPWwOyGrTmwE4coqN9kAlcEW/
         zb+QMTPjnV7JYKH+wojoBaYYz43T6zOMVmYS53hMhn6aoLkj5jUwysoAARilaJHQ/12L
         EtLSl67RVX1ytpRob6WW0jgegL/8XN1kfwx8mp3UBJy7iqOEdXUUJS0UQlKtyFe76QQ5
         sUz8ROXBhslnb9Ek4W9ike+fTtVmx6DHws+FMWpIdWPczcV6KbBFskHvmwhjZNu+erKT
         DgkQ==
X-Gm-Message-State: AOJu0YzRItEVAwrUhSrLfaSRwVveQ395x54pvmY6O724cOW09wADFgd1
	N9rDv1gGN6kR8w/VUSUPHHvzE2SrCyXV7RGQDYMNi9pXcCeGamsd
X-Google-Smtp-Source: AGHT+IFUHxlI7mGugolX/CBGDMRrdB0CjpmtiegWQ6mQiNKHIOL2NH+pJnKjYuaFwXwMA8rZbV+zeQ==
X-Received: by 2002:a5d:4d85:0:b0:343:9308:3af8 with SMTP id b5-20020a5d4d85000000b0034393083af8mr5808040wru.23.1712604832046;
        Mon, 08 Apr 2024 12:33:52 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id d11-20020adff84b000000b0033e7a102cfesm9686373wrq.64.2024.04.08.12.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 12:33:51 -0700 (PDT)
Message-ID: <89a2db74-2bb6-4c62-ad8a-bc4fe5fe49fa@gmail.com>
Date: Mon, 8 Apr 2024 21:33:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] fix a leak with excludes_file
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
 <xmqq7chajs3e.fsf@gitster.g> <1323321b-554e-4b16-a814-03710c50db99@gmail.com>
 <xmqqy19nbvtt.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqy19nbvtt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Apr 08, 2024 at 10:36:30AM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > It does not have to be like that.  We may no longer need the current
> > and problematic git_config_pathname().  However I did not want to go
> > that far in this series.
> 
> True, but that one and only true interface we will end up with MUST
> NOT be strbuf based one, and that is why I said the patch as posted
> will not take us into a better future.

It doesn't have to be having a strbuf-based-only interface, either.

It is about introducing an interface where callers:

	- can take advantage of a not-always-allocate interface, and

	- can stop worrying about freeing previous values, when reusing
	  variables.

This latter fixes the leak while the former introduces a nice "if you
set n-times the same value, we'll allocate once".
