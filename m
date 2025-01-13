Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2931BFE05
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736808665; cv=none; b=nnxy9eHb15ktHrJft0V16DT6QuOzE76H6mZZtYIWXHsXdpV+w9dEKcHpT49JrxXZmDzqsyo/xOai7CgAgv7veQ9Du/KpHHZ8/fFOZubxxIGcfSmL2kipQRpbHlfKSiAVDimfY/PoyVrJiI94annH0v4F/G9wdCIiCoMhkUDMbDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736808665; c=relaxed/simple;
	bh=uR9TWNxUQ7oucQkpOwTvrUywtmAi5NqsBtVZdSkYZrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dyu+GK09xSupcwlLo0IPeRPVsXCVGih1vzjH548hWTrOlLaNH07MKP0vTLOghdmoQZcgoR/Cyim4TAK/xjVkgFw6NXCgyB8qr/tlW0cqduKul9OGJnSGFKNQNQetUMlLGMTzwoC9/PA52NJLlRMHWr6CAmTQPe6ql/V+tiK1WcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INi548H1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INi548H1"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385df53e559so3888717f8f.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 14:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736808662; x=1737413462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cixb4Y39Zru+UTE7GdHbXxiOTHEotTkupoc2vloyegc=;
        b=INi548H17KFYuvvO8yQqIBM6IM6WitAyrRzx7EK2i8YdhE4Y/o7J0VztEzxx4S2opv
         BhZ/nBpkEyd0wOvP/i06NGLolK4/r8Sno0XO7LllwRcBYk+RNPbO1p0Hs0+RT7Dq7YBQ
         IfTFA0X8FfQhKICEe9+Nj61WTB/aV3Mh4JSms0WRNffrotwZGfD1JHILC7ISzuNDaADU
         VjE4oEkxQd/jyH2K9pu5LzXzkGRfyrmJp5bYh84XV/CW1p1MVAVz2u/x1Wi/fRY9wnMW
         76CyK/pWj29T6sZHX2fn/ZS7edrf1TCZVCGpR/LSL0IIEHTg5fXaRB/awrwuAjuqDV2f
         Bx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736808662; x=1737413462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cixb4Y39Zru+UTE7GdHbXxiOTHEotTkupoc2vloyegc=;
        b=ZuuqfAJV1UhR2Ejco8/GQQQ/RG2j0iMTE3F+DJrgsk0QRZRh+5P4lDpR70inZvY0oB
         jTLuo9c2WUD59c178UzESWl8ns0Yw2jrJ8Hs98Y7CT6CI1/e0TYEOxu+xNhtzWbORcWm
         WZ1kkKV3O1l7TJ7G2M6M8+H/SW/snyFsNwkyJCerkT1eFEyfICgvAdqFye4EAsLhn+IC
         Vrs2ZBfhgG+sj/8Z8nqCbxZvgZ2EBorQ5iG0g8n7NiU80t5AdorNDd3/U20l4AnwBhpk
         97UE+urhOPV83LhyJFCm4eHvrQHQaKeMULcyRo3uFZ+M/P8GOJn1hIDqbUvl1ZEUOx8H
         nUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUINSIOK0AAPP5LsSFAi+HDpMtGe2LYbw93PsaV7sFFjwkxzudTnZtHaHbb3uz1hBMOppw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFir8DSm3va+1cR/qhEh52yxo9F0U8DliGTB46rALyqed1lPZP
	FZopgrERZB4WDtRWPqwgv/rjyIH6Q4bkqTbqYm0InF0CSLBawRNv
X-Gm-Gg: ASbGncsU6EGkTt4emfA07NkbVZw1EFfU5Wh3zp5sHEpg8Z+nCh3xjCvco/u0UgEOIxP
	Av/q6AFj8EharHQQZuQLHPkmLmunAqfBEhoc3Zsfw0nmcMBecX8TYrVQlmHhv/fTCU1wESFgxd9
	Ds+pj0Jds/hUPmqui+R2Tzte9ohiKsCMfYy4vkK1Bd7eNRw/mIhwc7SX+i9yTWj9ee6CwBPywu8
	SkBIPKpKpqlwYM3DuvId1mfyLtejFFko2mz6axObOnocpI938dbH+KaanTjHqk1vyzdKL/9APqA
	2SaA
X-Google-Smtp-Source: AGHT+IGz0w9XEzKMwdSZ+huKMzF5vuNB5fvWEhl2gmZEELY67RT3Thva41t3/+9ndYilW8fau7sBSw==
X-Received: by 2002:adf:8b8d:0:b0:38a:5df9:f86a with SMTP id ffacd0b85a97d-38a872eb1demr15201647f8f.26.1736808661972;
        Mon, 13 Jan 2025 14:51:01 -0800 (PST)
Received: from [192.168.1.186] ([2.26.170.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm13075737f8f.81.2025.01.13.14.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 14:51:01 -0800 (PST)
Message-ID: <2c43a19c-91b7-45d4-bf95-3157ddfe81d0@gmail.com>
Date: Mon, 13 Jan 2025 22:50:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: add vim syntax modeline [RFC]
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 M Hickford via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1874.git.git.1736802194760.gitgitgadget@gmail.com>
 <Z4WGwCwnNj_XeHiI@tapette.crustytoothpaste.net>
Content-Language: en-GB
From: M Hickford <mirth.hickford@gmail.com>
In-Reply-To: <Z4WGwCwnNj_XeHiI@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-13 21:33, brian m. carlson wrote:
> On 2025-01-13 at 21:03:14, M Hickford via GitGitGadget wrote:
>> From: M Hickford <mirth.hickford@gmail.com>
>>
>> Git documentation is written in AsciiDoc. This format is easily
>> mistaken for the pervasive Markdown.
>>
>> Add a vim modeline to help editors identify the format and provide
>> syntax highlighting, rendering and autocomplete.
> 
> I don't think this is a good idea.  To be clear, I use Vim and Neovim
> (mostly the latter), but I just don't think we should litter our project
> with editor-specific contents.  I know Junio uses Emacs, and other
> contributors use other things, and there's no uniform syntax that works
> everywhere.  (Nor could there be, because different editors have
> different names for different languages.)
> 
> We also don't set editor-specific ignore files in our `.gitignore`.
> Emacs users are responsible for ignoring backup files in the global
> (per-user) config, Vim users for swap files, and so on.
> 
>> This makes editing the documentation easier for prospective
>> contributors. This is particularly important because new contributors
>> often start with documentation changes.
> 
> I suspect prospective contributors who are moderately proficient with
> Vim and its descendants know how to do `:setf asciidoc`.  If this were a
> different editor that were easier to start with (say, one that didn't
> have tons of Internet posts asking how to quit it), such as VS Code or
> even Emacs, then I would be more convinced by this argument.
> 
>> A simpler alternative could be to rename files *.adoc. This would have
>> the advantage of being recognised by even more tools.
> 
> This I would be in favour of.  I use this extension on my personal
> AsciiDoc files and already have appropriate configuration set up.  In
> conjunction with appropriate settings in our `.editorconfig` file (to
> configure indents properly), I think this would be valuable indeed, and,
> importantly, helpful to users of all editors.

The more I think about it, I prefer renaming to *.adoc too. It's easy to 
identify and obviously distinct from Markdown. GitHub and GitLab render 
adoc files beautifully [1][2]. Visual Studio Code offers to install an 
extension with syntax highlighting and previewing.

The vim modeline had no effect in Visual Studio Code. It could also be 
intimidating.

[1] 
https://github.com/couchbase-guides/how-to-write-a-guide/blob/master/README.adoc
[2] https://docs.gitlab.com/ee/user/asciidoc.html
