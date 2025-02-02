Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536BC111AD
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738497151; cv=none; b=Rnrzh80otXnwdl1bnU38fCMXFLqTAS5QAbK40Jiqnj8Mh10YN5jqFqJta9YnZWJ7vh13+EgGUtiN0GTFlPL3UPfjqEWrUcBPfKo0QeDi4mod6qAeWlmxLgKF04z+iZob6easXEJqo4zyCcKm/Jay7eXW9X94bRRk7q9Oqp8/uyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738497151; c=relaxed/simple;
	bh=AHlS1jB34I44RDRz1DUMPHD2jmOeMs/IKAUp0+Y0Qt0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XKj2wtHkkbUzlqmhKDD02ONLsE66m1L51rLkKcDrnzTL/n7IzJsup45m9Vu8G6z63PFdsfzcEzvoHEgaNs6q/enmZNmHEbQoxrBMnaodeTBipjG089XBbiisBg4pu1wmZ6artFIno7BqD2DmiZn/9/IDKaSUzqCg0/z+gCss53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsjKQ9WD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsjKQ9WD"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so4428897a91.2
        for <git@vger.kernel.org>; Sun, 02 Feb 2025 03:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738497149; x=1739101949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rn2Y9EczZGdJTIWrGDHIrCwfhuCHuf3ow/1/z5CNr1A=;
        b=IsjKQ9WDkam4dzdRl6hbHpGYAltB1vZRnTJkaX9ue9zMe4Wu9ujGDV5SzKkDvCDrEa
         XS8LC5Ecuy55upf8xbeGIDVVWrvQmwjkNT6QYtHXeBphPbrAoc//9kc4cpEOOjUNyT0P
         +rJVvGgnTyfmfVXehWjcZe/CehIM11A96+qABv26ZsSrwNnhwHcoy3peicFbw6hIP3ik
         SNoHBnNIBxqlqkDnvE7r1iMIUKW/VXRdb/4l6YacHAH6tF/Be3D1SnVQgJnQ5MCdWD/V
         Ywxqa8enrZhB1ixXB31NLesIDlyB427Kzfe6wxc+LomUhoPYdYl3RuXJkj1KBPpIMxIO
         fFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738497149; x=1739101949;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn2Y9EczZGdJTIWrGDHIrCwfhuCHuf3ow/1/z5CNr1A=;
        b=uuZt+SZGl/+uF/VwJC15r8X/Am9Z+37+I1oghDo+uKdRSTuqv3gfjyOAqKrYFi0mg9
         V8I6XM0GUWKukjCviyBjBk3FftwJsU/gnTf/D1JaFQF1JeKEMPHXWrtoJ2ylhveL5Od+
         50NDf3c7KFxKPwjL62KoVBYO6u40SA0KxdBsw0mZ/VYMMH6lxVs24eJc5FfBhqXd+MOp
         s7UqwRz+cpnoC9kFQnsWcggHWCeH9sC5XNGMoq/JQ7RDUECpYBKtmntm8eEuoqjEN664
         6Uk2vWI1mprNrxc4zm3r3Jh/SjiX0y/tcs8j2Z2wCWRMaaRdWsvxFPJgQ9LI8PGEj5Xu
         Fesw==
X-Gm-Message-State: AOJu0YyU5GXwS5SB0qjd0tvW90sTvsp+Is66gxqCExEW0fcMcZm9WWgf
	IGIRZmhr9YazGhiO5wcucSNSwMlHnixdO7CwUTL/5LuilaPabx6x
X-Gm-Gg: ASbGncsf9rGBnZ05cS66u9/6seYnfnnbEHOafvjF3F2X7x5iyL7wopaz74gh3sOjdGD
	V7+ewcbM0FujJqcZqfZO2w6+emz3dvrq/AfLFxNpxv0ge8hKSDJTcsnVMa5G+eOoyYW0pvotsdn
	t9b/E9qNiPGVphaM5bOUHZsXSUzCpl8WAO4MEAn8X5vQvbN147kU6slHViWDx3oju+UNr7ih4Nt
	ZNUs6tBR2jq9vZ5Uw3IdHol2q1k0bY3XtryZc2wWJhl4bP/KLPk12pFfjN8ucgALqnpMe0u0GJU
	L9nZpopWtYI7DuoWN1fAZn6D
X-Google-Smtp-Source: AGHT+IF+hSVEFay6spgAbi7q2K3I+toy3HRZXmGo08wMcHMeXUrNJ+LkMaxXW3e0EtNSdzZKl3R4qQ==
X-Received: by 2002:a05:6a00:1411:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-72fd0c60405mr22444256b3a.15.1738497149391;
        Sun, 02 Feb 2025 03:52:29 -0800 (PST)
Received: from [192.168.0.7] ([106.51.24.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1d212sm6529612b3a.179.2025.02.02.03.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 03:52:29 -0800 (PST)
Message-ID: <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
Date: Sun, 2 Feb 2025 17:22:05 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
Content-Language: en-US
In-Reply-To: <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Christian, Karthik, Jialuo, Patrick and all,

On 28/01/25 23:00, Kaartic Sivaraam wrote:
> 
> Thank you for suggesting these ideas, Patrick! I've incorporated them 
> into a draft ideas page for now. You can see them here:
> 
> https://git.github.io/SoC-2025-Ideas/
> 
> Kindly suggest any corrections to the description, project size /
> difficulty as necessary. I've mentioned potential mentors based on what
> I'm aware of so far.
> 
> Patrick, Christian and Karthik, kindly mention the ideas that you're
> interested to mentor.
> 

Gentle reminder that the ideas list needs completion. Specifically, the
following ideas only list Patrick as a potential mentor:

   - Refactoring in order to reduce Git’s global state

   - Machine-Readable Repository Information Query Tool

The following idea mentions Karthik and Patrick as potential
mentors.

   - Implement support for reftables in “dumb” HTTP transport

The following idea mentions Jialuo and Patrick as potential
mentors.

   - Consolidate ref-related functionality into git-refs

It would helpful if you all could chime in to let me know if the
existing allocation is fine and to what other projects you need
to be mentioned as potential mentors.

--
Sivaraam
