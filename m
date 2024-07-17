Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E8181337
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228148; cv=none; b=jo2z5JRI/mPenxwuycN8lN+Rj2Go8zFs6OeUOTpi9E6qlGUpGsZY3tRveJNi6CKmsk4g168rVrY39wes5ID1cDmUDJs1Y5Wa2csxZ5yV4a2UPGkXjRR8C/+hwHL2XW1y/bZPRiuuB9UXKGRAr3cRHimq1pAUxzESzFVG+ZyOQig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228148; c=relaxed/simple;
	bh=889S7UiqnoKzvthncvju5AxKKb81wcYAoKIAxaUkpyk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IUuYt4GO03Q0a5H2JlRlvSIklNJXhMMT/IYKpdX0bvJxnLMU4qnPPmOTQooAnbvVCy7e2ZrZmTWB0FIq9FlMHkfGHmBmsgQZFlU7bJGKfXAtTN59iOibaJHG114bfbmRtcIB3OZMSzSQTXuqwPxUNqZD0m3PBk2ryz3cIZ+uRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjZ/Ge+I; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjZ/Ge+I"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427c4843840so4594805e9.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721228145; x=1721832945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3beJRL3MmdRXDH6bbpw6qbwAp9VwEtUtKnHfbEzGF6U=;
        b=QjZ/Ge+IqIuzNX0xk1KsCSQVyey62LcWa7INk+dQb+Ijlbz4/z7cag41PD49kJ9Usr
         Py9gV6C8p6BpwpF37BzEkTk9iGDjK+1Fq2klf0aYG8Ph4WM2Jv1CrNrT1fPbskRQLOhq
         nhSU5D6s7gEaQsfDk7WtwZbSI/NxG08pVSKO9zENy93J+7pbH2tkzWXY3J6WKdWNhwjS
         4XUgZrJv+4xhxg5mDvHg0FHCozcik+Ol3hXtdg5jZgU8q44zokJ/HW/C9+T6AJzAvjt3
         9fi0Wgqe4gTAFEFKzqHec44CFz+dMfS5t287cuvYDuG40ZE0wG/B/V01GMYhe0yoEK83
         /OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228145; x=1721832945;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3beJRL3MmdRXDH6bbpw6qbwAp9VwEtUtKnHfbEzGF6U=;
        b=CdSTD8REidYLMRDh9OCw4hdCYJtCxexpPJ8CBfQdXdJkWadD1Ka/P1nwTEVmEFZaLT
         90qXohTrUAoNQjLeIhVZktudsmqVtQe3ydFpaeUI9I4eKlxw9bfPAIGF+44RmdoZnhj8
         R5Jg6aX0UqK2zKWoGKROqJtnFqlf2L4V2EmomI97/u7j2NcNQ1ThI/wL2lgyqV5VTVK4
         D3Z0Lbo4R7XnqOhMOf7nrxW6+yT96luP7+8fHf0SRh/D0ws244xyY3MmIdDNfP4Uwaix
         uE5PWYXQu1+0/XMAID55j0dajMhl1aRVjuyLPJjkaBXLQSqPZx0QnGRCUnzXQ1LDKP+d
         GntA==
X-Forwarded-Encrypted: i=1; AJvYcCXSdk/3OlCbzApiCJcbsrn1zgO6pt1JTlAY4JZzh4ZccPXYcAFFaCKfBCxuLFcu72cQkw5zmK77YxCjtl9XFy+5gmvQ
X-Gm-Message-State: AOJu0YwTHyxhwCgpMvoYXI9KjvWafNC0/Y4OA6WHVqtU9suaWGcUl/Wn
	e+Cz1bf1pX/Cx4uH2oGtPlYsHTLdrbDxiv437VHfvCp044BIX1w7
X-Google-Smtp-Source: AGHT+IERrbiakcZ3dwv3sNymFh43+pt1Vt7sedYWz0veBOIfTQ0S6uoAFkjyP190Z4SLtjq3VKyXOA==
X-Received: by 2002:a05:600c:4e03:b0:426:6707:9be4 with SMTP id 5b1f17b1804b1-427c2cb3bd8mr12216755e9.14.1721228145539;
        Wed, 17 Jul 2024 07:55:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77ec9dbsm900885e9.27.2024.07.17.07.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:55:45 -0700 (PDT)
Message-ID: <fdb26d61-d755-4daf-ab5d-6e1a36b7b871@gmail.com>
Date: Wed, 17 Jul 2024 15:55:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] var(win32): do report the GIT_SHELL_PATH that is actually
 used
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 phillip.wood@dunelm.org.uk
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
 <8612a47b-18c4-4071-8827-56b4f3bd0d80@gmail.com>
 <66345b2d-6662-710a-5513-6cc70507b4d0@gmx.de>
Content-Language: en-US
In-Reply-To: <66345b2d-6662-710a-5513-6cc70507b4d0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 11/07/2024 13:03, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Tue, 9 Jul 2024, Phillip Wood wrote:
> 
>> On 08/07/2024 14:02, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Thanks for putting a patch together so quickly
>>
>>>    static char *shell_path(int ident_flag UNUSED)
>>>    {
>>> +#ifdef WIN32
>>> +	char *p = locate_in_PATH("sh");
>>
>> If I'm reading is_busybox_applet() (which only exists in git-for-windows)
>> correctly then this will return "busybox.exe" under mingit-busybox rather than
>> ash.exe, so the calling program would have to know to set argv[0] (which is
>> likely not possible unless the calling program is written in C) or pass "sh"
>> as the first argument. As the code to support busybox does not exist upstream
>> I guess that's best handled downstream.
> 
> BusyBox-w32 is unfortunately displaying strange performance patterns. It
> is partially (and expectedly) faster than the MSYS2 Bash, but in other
> scenarios it is substantially slower (which is totally unexpected).
> 
> Some time ago, I tried to make this all work and investigate the
> unexpected performance issues (and hoped to fix them, too), but ran out of
> time [*1*]. That was almost two years ago, and I am unsure whether I will
> ever be able to elevate the BusyBox flavor of MinGit to a non-experimental
> state.
> 
> My original plan was to eventually no longer include `busybox.exe` in
> the mingit-busybox packages, but instead a copy of that executable with
> the name `sh.exe` and thereby have it work without that hack in the Git
> code to call the `busybox.exe` with the `sh` argument inserted before the
> regular command-line arguments.

Thanks for the information.

> In the context of the patch (or now: patch series) at hand, I don't think
> we need to let BusyBox play any role.

Agreed

Best Wishes

Phillip

> Ciao,
> Johannes
> 
> Footnote *1*: Interested parties can find the latest state here:
> https://github.com/git-for-windows/git/compare/main...dscho:git:busybox
