Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948492905
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753910365; cv=none; b=MqdvdrlOkF87ydNtS1TIfq23nqxRxsB6iBIFRhq47fr0Pnq7wbbJeJCZS2BgpOrb+RQjjQfc631O9kjLJwSQFqevQprEpcedMVLP3EtdGrbSylCLGklZ2QVw+r7JIaybzUevURRbo6fUDteCW0hgpfyrPY/7FCQXuhqXuc45Vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753910365; c=relaxed/simple;
	bh=rhIHzvzKu8LNPcy96iWCIfI4vB170vI1T8o7tktW9+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnhdaDDAdet6gyio/lz4ExoaNitNVOmI1z9QtCizzht07M8j7uZRAIZ69gD/RCJZ06eq11a2VOkJdrWXoWX6IJk6s7CGrAaSq977TkmE2c6fFPyqJ4b5Ki9fuVP5Zijos8lh2zQtT9YrhyRn2nDErUxPrFlB3x0FmS0Mt60ZhLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db4wHwk6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db4wHwk6"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fada2dd785so2670956d6.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 14:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753910361; x=1754515161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhIHzvzKu8LNPcy96iWCIfI4vB170vI1T8o7tktW9+o=;
        b=db4wHwk6dPAGwulFXR+/vaSyf0eHRuybWEotiEbjIkUZ7QwkEQrQBkCin/+gtPWcOX
         l1LR/PxNUbdXB82a5pdXCZTwxTNMUmzerc+4K7CxltTRJKktBnTYdggxQZXjG06C+tlI
         ZpTe8hywi4T9XZBOiH0f1ey9pfvmNxnYG52L8YSNkU1lH5infDRLZkpDlA/MhLOPAw1Y
         1Kn+M68elAyIk1qqwziuV4XhRUYHeAeWch7YGV9O1onXb1RAMxvPOVpQxEEsG9sk3FHA
         LW1UffXqVfDmXqlG5Z+sAis7U4XK230+2CuR6Ojl5Rx57jnEd3xlFnLlqvJxtkoFfCAX
         wnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753910361; x=1754515161;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhIHzvzKu8LNPcy96iWCIfI4vB170vI1T8o7tktW9+o=;
        b=CrD2vJ3k5bWZePELznl9hiN3eGmFXemIS0LoeB29jnDWbq9+OmIJHEH+WvL9B1RVLe
         KxXnu59gcxe0xkEeWCzMO4BB7Ha1VjMmSw58F+EnfJw2NOSfCLrDJy0T6FcoUF3dvfN7
         N1jAlR3CuK/U/0HKM0xIIZuOSoMa2E5ILPThYFZmVC/sTQlJ23WC3r8yHuG4fVpJY0zx
         abokH385fsaeN4DVwp4vtpzRxTeaL6CH0EE9yNdiO78eT/mNxnh3G4ivDK+mdxhpYfiP
         +PFUz7QoEmLygvQL2re0dzLfALTK2QJabOSUdBkpzov7jP9L/36GTp66b7KEqND1Ydrc
         Qnjg==
X-Forwarded-Encrypted: i=1; AJvYcCU3jkK31gqbkpzKO6ipP11tKY70Pjcmpfr5Q8piYv27AqzbDERWO1DgJKLXX8b4dYPLDzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxO81gAA1q0t+zaDsVMo99OgYsc5toBUCKjyUmrrk2c2zeIL2
	46Vc49vVcJB0zVG/WPRVxHJnakmJF0u81Y3t+vn+a8vV5xHURQjZ2L4J
X-Gm-Gg: ASbGncttgMBhj7ni2YsvGw00OePNVCLXUWzBn9MNmBom1jIoRegqBrKmKR3El+/uTC/
	+BbylV6955Ruq/3P7nG0PbJ5foIvhEZPQIdn1meDbgZzfs4uhtVreaudxvbp45gThY5Nx2hkcjX
	EFf5y58+NY9V6XAUyLhyQwPxBjsgfFKUTYaQg8PwwLE8sKBXgCW9dzGfY105Y3LOYTlfU5/JHAw
	wvwuymZFL9FJaSpY7ZEmuWhWHmJLJ3GqNqRgOgf75QWwbpxmZ+81LTd/XJ6LLEwadA3jtuls6oR
	Fl6awjKzZt+fCdtjFmk5ymkCK7IEsFbWi9Qu58HtIh+x0YKotiURWZq3XWa4OW4XQtwAgmTu+2K
	vf7R1yogAEcO+j5UijifrK3mpvVZgGlZxkP+AB1YsjfeJN0MjVEDDq1FYCkjPvqXDqh8xYpbf8w
	==
X-Google-Smtp-Source: AGHT+IFR5skuYffBdrdMZak79r3OYYt34HmQpyS1o7Tsp/wboXj9FK1cU6ZgeMt8ZD1idVeYVqH9pQ==
X-Received: by 2002:ad4:5aa4:0:b0:707:4958:ec29 with SMTP id 6a1803df08f44-70766d5506bmr60224906d6.6.1753910361293;
        Wed, 30 Jul 2025 14:19:21 -0700 (PDT)
Received: from [192.168.8.183] (pool-173-73-185-17.washdc.fios.verizon.net. [173.73.185.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c157cdsm66593786d6.66.2025.07.30.14.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 14:19:20 -0700 (PDT)
Message-ID: <cf81b5f5-06a5-404c-9edd-e94b902aa455@gmail.com>
Date: Wed, 30 Jul 2025 17:19:20 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] git-gui: ensure own version of git-gui--askpass is
 used
To: Johannes Sixt <j6t@kdbg.org>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250730164052.15371-1-carenas@gmail.com>
 <20250730164052.15371-6-carenas@gmail.com>
 <ce964e5a-fe30-42da-bf8d-969893e3907f@kdbg.org>
From: Mark Levedahl <mlevedahl@gmail.com>
Content-Language: en-US
In-Reply-To: <ce964e5a-fe30-42da-bf8d-969893e3907f@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/30/25 3:04 PM, Johannes Sixt wrote:
> Am 30.07.25 um 18:40 schrieb Carlo Marcelo Arenas Belón:
>> Propagate the `git --exec-path` that is defined at build time
>> and use it when defining which askpass helper to use by default.
>>
>> This is specially useful in macOS where a broken version of that
>> helper is provided by the system git.
>>
>> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>> ---
>

The expectation is that git-gui--askpass is colocated with git-gui, and not with git. This
directory is found at runtime as

   [file dirname [file normalize $::argv0]]]

It seems to me we could just put this into git-gui.sh instead of [git --exec-path], and
the patch is much simpler.

Mark
