Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244522E92A8
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376120; cv=none; b=BYbQ1VWGZSCXgsUCE31z9UHcRKYHbD7Ng62pnm3pieukFrOIoQ5VM4cyL22bZJPZQygBqGr7kLYDt0ltWi5p+VpUbJ+bwRkV0tKY4VdOx0w6D22nUojExKBh1x/QgMMaii+ttO/DrhM720EA37r+WXmRk3U4yNAUIksDa1Wr0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376120; c=relaxed/simple;
	bh=e4BIfn7XC2JrfM++lC7I89lUSke0HPzOabsrDVRgiwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L506OU6E0PLwREHipP/aqhhUe+OgWNH5ER94T28K6DE7gYCRBGNkTZIEILErSdyN1b/3W9goFdI5raATim+vN5K8wla6HF+E/6V7qtv69asufKohecaJNS4md69GUG328j5g/4SQyb8dwtMmiR/Y65LtwDtZeNqCR7zztTTYq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBYFnglI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBYFnglI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235ea292956so11333135ad.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753376117; x=1753980917; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyVI+gx7araKVk8obJg6ix2Qe5N0ikZxZ3mxaMmmqt8=;
        b=YBYFnglIAZMGJmd3PwNyLSjAg0fcIcof/DYJ5NtWeyEsmgFPKVPx6g2z/7Q8Gq6z5h
         WmS3EL3dxsLp3Nu1erMWFht7vq66UMAO0UcT9tD/ksAZcr/lT7U4d6t5861hQlK59+ZY
         g8vsn1T2Cv7jolQxGTZInzQkV5fMHAN9Ud7hdI7GX0PMpa6dbEjkctlSkPb8QPnjuPTp
         2ghmy8CF49/kn9Kv+4LGDwC6204jCHK1x2v595+nn53h0p0yqktDj5Cf51KnSbOPo6+r
         SeldJtzl0WXMqMaXLTEv2qgBFgTDdRljQjLaoDu3c1r7Bu7XUpwL/pvE3ZXWhJAKiigE
         dYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753376117; x=1753980917;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyVI+gx7araKVk8obJg6ix2Qe5N0ikZxZ3mxaMmmqt8=;
        b=dNuirpVQPhAT5HQxtFQqpzH042df0TWBg+FUAyb61D1LwnlYqt54aioW9CxYKqqe/A
         9Rt8obus0K9XWW7L7nrhuBkTf9BGxEqfqa2QZqzU4Xr5EiBOQznww+pa17JzXaQIuMEg
         AEHEdF3RCafucmIIYnNBhmsnEl9zy7RW9BjRNEJgc7AVs/Doco419U5n10L2ojeVaGVb
         mNK+N21NgTbPr+2gOMbQkM5nJNSyT3m6x1e88UlsI9lfzdxbaR8cvJgqiL+bIdExE/53
         fcJw5ebDpDMXc/mnoC0D1epYdhkKoD6n5bada4q9kd8BDkUO3InYjoJI/sg/EBl3o5SB
         wgQg==
X-Forwarded-Encrypted: i=1; AJvYcCUiUoiQJSMnZFGZXPWIZ0DWXN5EQeFr9Ri/aWoL7HkBG+WLmk5ixZRZyIMWi28+xAd8YAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMrv8VF5FPsVKcdf3VrEoOP2eL+Ry1a3k7J9HOAhMa/ObNklv
	4sGXsVETkv6yKqgjftKci5FPaE80HvZFbKjgRTQreuzzjMjwQhz2PbSy
X-Gm-Gg: ASbGncvLSL95iqJaK8BbHwHvUdMmGFXmZ6z7MQKnbmtdcHfjSROpyPU6smFn5j9dTgQ
	U7VfEXQT8nZae942Fij6GHKymxXyn6sSmSf/UKGFkDGDqVu2q5MtQ8+yRV7ohjxkQ6zsI1jvXVO
	6DCyYjcna80X+L784DEw0gYganL0IodVCATxDvkyuOeYR/nv1s5GP9ogGP4zc5oGuSE6r42hw/t
	2jELI3QJF1PPdYszGyxxuxEBVawXi7js3oc7GEvzZwvW+y/Bhm7MR4+7rHpefMc+8C7ZOTmsRtZ
	+y1xJSpM59e2Pv+molk3avTcaZwoAuMDrxaGJO/ftVV08aWzwGBVxdLIF2a0XkFVdOvXRbPKAiv
	bgfG6oq+gSuWKUYwqBqR3tdHlC3/cGIuJ4CDk5C17aX4E8pYjI+wJuUZ521jrS3iQtH0+rfC2iJ
	k=
X-Google-Smtp-Source: AGHT+IEiJNKMU8vuC1YuOuaNF6nVv6baTTjNyoMEGKIvLA0o5Sk2030vMmj/9h0sOc1QGRSUpzR2Eg==
X-Received: by 2002:a17:903:2f92:b0:235:ef87:bd50 with SMTP id d9443c01a7336-23f981d23d8mr131500505ad.45.1753376117462;
        Thu, 24 Jul 2025 09:55:17 -0700 (PDT)
Received: from XTHCYRY1WD-Collin-Funk (redis-162.tisch.gvad.net. [207.135.66.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f38csm19849685ad.32.2025.07.24.09.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 09:55:16 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document test balloons in flight
In-Reply-To: <xmqqms8tilvs.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	24 Jul 2025 09:39:19 -0700")
References: <xmqqldoen5v3.fsf@gitster.g> <xmqqecu6n1pt.fsf@gitster.g>
	<aIHY-PXYYzE8JULj@pks.im> <xmqqms8tilvs.fsf@gitster.g>
Date: Thu, 24 Jul 2025 09:55:16 -0700
Message-ID: <m1seily1e3.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Wed, Jul 23, 2025 at 12:31:26PM -0700, Junio C Hamano wrote:
>>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>>> index c1046abfb7..0776d15a95 100644
>>> --- a/Documentation/CodingGuidelines
>>> +++ b/Documentation/CodingGuidelines
>>> @@ -298,6 +298,14 @@ For C programs:
>>>     . since late 2021 with 44ba10d6, we have had variables declared in
>>>       the for loop "for (int i = 0; i < 10; i++)".
>>>  
>>> +   C99 features we have test balloons for:
>>> +
>>> +   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
>>> +     compound literal syntax, e.g., (struct foo){ .member = value };
>>> +     our hope is that no platforms we care about have trouble using
>>> +     them, and officially adopt its wider use in mid 2026.  Do not add
>>> +     more use of the syntax until that happens.
>>
>> Nice. I like that we now have an explicit deadline for people to
>> complain about this feature not being supported on their platform.
>
> I do not think the firm deadline has much practical effect.  Test
> balloons are designed to be placed in a stable and non-optional part
> of the codebase that is exercised by everybody, so even if your
> update cycle from your upstream is once a year, you'd have four or
> five major releases to try building and noticing that your platform
> is unhappy about them.
>
> So the only effect it would have is to smoke out truly slow platform
> maintainers; if their users are happy enough with such slow upgrade,
> they have lived and they can live with versions of Git that are
> years stale that we no longer care about.


For what it is worth, Gnulib and threfore Coreutils, among others, began
using compound literals in 2017 and it seems to have not caused any
problems [1]. Even 'pcc' supports them.

Collin

[1] https://github.com/coreutils/gnulib/commit/3a8af1e38bc026a9efb3b47c4686e4e54b633436
