Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD881E3772
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902830; cv=none; b=M3TvS7jZI9qmVjMVAifgsXg26WXtICaGmEbT3D/SkxfPY0WrDxV8AFkRXakNI5XmrtHJe2cCqjgnGHDBb+yXIdFwRDyY52v8RqlILbAti3pPA3j7/WdG5roFMVo/ISfT77XELtUpsxybRJV9tQhOX/V/YEp9JB18VQBl7pc43fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902830; c=relaxed/simple;
	bh=7gSzJ0bYBKz8LA3hBoivMYKPuzZFcySMXC3DL0Y3WzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O6ZiYVOFqMoRNEP6QDzE+Bj6yMYLhCuzuh3aUyq8g6vkcraAVs5wdnp+29kXrohdzfu7QEKKl+ua9d2eIoVnr/Q39BtFNyJ36U5badjTyNadhmdGLu3Iicx8eODSxF+vdnwtWQJo4I1BC7G8N6Pzexy1Yv8smoknfX3L0bVwswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdNAA7nZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdNAA7nZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236377f00easo41503205ad.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 08:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751902828; x=1752507628; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSBefm835XIt4dl+PSdKJG7zF6eK93T1ZYf/g9590UY=;
        b=IdNAA7nZZmuzXX1gqkEpqYpC3jZJLaO1+gO/Kef4sq0w1OQhkZ5dEAYOa2Vz6Btarn
         HJvbXEBi7BJN2GIVAH8KG7CIvZyhq3QZPxbMlsibGi5TQksj/xYl5dUA5wSNLfOF/Fb2
         M+auyBMkwWTdVRPLMHPTKhIu7YL/SKkhgOzhfMLxnVb6W/3UiWKgCz3O2XLKU5l4sTqP
         BXR4fC3AX5phaZmhQ4e1yG0IPJOg6ptIRT3wgpOb4zEh24bXLPXTUpzg7SEgvlVnTl/L
         Ay/TWzEfxA9iiHiHeXq01uHtpLhreRbHB9TLwnBhy13sUvRwN0YkvO4RpnUGuAtLLiUl
         cg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902828; x=1752507628;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XSBefm835XIt4dl+PSdKJG7zF6eK93T1ZYf/g9590UY=;
        b=mb3K4ZWaiKvJ2Csc5qEmozFGqOY9WT0YlJNCTErYgT6LdRgOkYii67dtd+3EHO1I6x
         Y58OVh/tLwDOyfi2p4BbOM7HQyv5uY2KhEu6lixY5DXp726ICpwqqDr5fbM7RD2hBwZ9
         paAmOPb7auBltvudaikOlKC5eZjn+0tN3yGm04t0C2anmDhNaDhbyKX8Jr6UdGuu77Qp
         rhXMqIyykYIs8gWfreMXrxGRXEyDgra7uOXHLOTOl5ccFlCQrhRHvhXrEPT1REMRe8a5
         Cq6oyNZWg+RSx/+9aa6v2ay7NIPmOLJrCd/t+fbDxytLx2fVX7Ti5Va4RnRibrz4hmAP
         ZRYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTY08EcmRqrGym2szRRu50qMbvx93XanvqGgj3VeklmHl3PvI5FebaLaU7I4q9uE7aUmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/Bw2aiFUXDuFWPhRHqv4nRdk5xtqulkmRmYQtwS0cCEGIl0Z
	Y1Dj2o2tcw8q6vnh+uUvzFncpUAJgJMRPx6XgLw9sPWou/xlVcJJyz4u
X-Gm-Gg: ASbGncsflrqlcpjcbHKB7xT/Yrpj9lpqWpki5kiXSshUPK/vCxzOWyrYt0cSLgDc+Kq
	B165z88AdcDJsbJP5Hqs+bvGOkS41KDQpkapzPXmR0auAlCaiIJhN2NHOB2lsf4EL/2l56dFkGw
	M9xJ2FQGpWayqK138MpcDN/13xk9jOH1m7bHMRfQPcb2wnV2qh2DLMFsl95/Z6CiUbPhZ9G1JQH
	uFv9VwAKQj+pIHKuGhPu00v50Msb20rGyoGLZ/gxmkkYUoiKqIPGrzARCZALq0sTmDEet2DHB2l
	DmfKGF1DruEOpeSnE57wdhrc/z+QxvM7vA/FJDRKV/X3GFpq0TjYISlF90qMDIGjrBSov3c0AaK
	AqZvKCCXeVZS7fdLb5yqALhFJoo4=
X-Google-Smtp-Source: AGHT+IGBXavFJ9pi53J8Gj790gXwcByq6TFEc5gvysi5juRNT0cP0RSU9JGzu1wzoih4x92Last+Nw==
X-Received: by 2002:a17:903:1b30:b0:234:a139:120b with SMTP id d9443c01a7336-23c85d9f04cmr211843535ad.11.1751902828381;
        Mon, 07 Jul 2025 08:40:28 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c845bf52asm87520375ad.241.2025.07.07.08.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:40:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  GIT Mailing-list
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Renato Botelho
 <garga@freebsd.org>,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH] build: fix FreeBSD build when sysinfo compat library
 installed
In-Reply-To: <CAPig+cTybBgkwFEsMVNNu2o1w9T5qnhau4chvGU2opEPJO78zg@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 4 Jul 2025 19:49:53 -0400")
References: <e6a80163-47ef-436b-98a6-2ac39c477080@ramsayjones.plus.com>
	<CAPig+cTybBgkwFEsMVNNu2o1w9T5qnhau4chvGU2opEPJO78zg@mail.gmail.com>
Date: Mon, 07 Jul 2025 08:40:27 -0700
Message-ID: <xmqqzfdg3t78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>>     need to link a separate library (-lsysinfo). (This would require
>>     a similar change to meson.build).
>>
>>   - change the order of the preprocessor conditionals in the total_ram()
>>     function in 'builtin/gc.c', so that the *BSD sysctl() function
>>     (in the HAVE_BSD_SYSCTL block) takes priority over the sysinfo()
>>     function (in the HAVE_SYSINFO block).
>>
>>   - suppress the setting of HAVE_SYSINFO when HAVE_BSD_SYSCTL has been
>>     defined (in both configure.ac and meson.build).
>> ...
>> The second solution would only be required by the autoconf and meson
>> build systems, the Makefile already sets the build variables to the
>> required values (since they are not 'auto-detected').
> ...
> The final solution is almost certainly good enough (and is definitely
> simple), although the second solution has the benefit that it "fixes"
> the problem once and for all even if someone defines both
> HAVE_BSD_SYSCTL and HAVE_SYSINFO (say, in config.mak), assuming I'm
> understanding correctly.

Yeah, I think I agree with this assessment.

>> In order to fix the FreeBSD build, move the sysinfo() check after the
>> determination of the HAVE_BSD_SYSCTL build variable, suppressing the
>> setting of HAVE_SYSINFO if HAVE_BSD_SYSCTL is defined. Apply this logic
>> to both the configure.ac and meson.build file.
>
> Nicely described. I wasn't really following along with the discussion,
> but this commit message summarizes the situation well, so I can
> understand the reason for the change and (I hope) the implications.

Agreed.  Thanks, all.
