Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414919F43A
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743285003; cv=none; b=QlrdHlisfGCTdrUksZ+l2VIZyhvz/9QT/v9zH09u0ze5npFqAv6F/UeIM3+WLR32niBbRSbWPlJTrdpcXD1ETMn5tHIBNIDmA0H76nYCK9YxLrbxG3X1tT6aCd7fJWkg8bXUoXf27TtC2VRNLoBUr6dH0gHMf++OrklQF6rk9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743285003; c=relaxed/simple;
	bh=2bweN6wYAVbBF/jfooDP+413ULqP9r5gd3nCTwPmWTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuzJ/kNSv99Fb+5Fl3f9tzAL5qGvnG/OltAreR2eACdUp0nxkZ38Y/giI8n2G4x647fpzH0h7VNEfrP7tT5r1u+tOnYswSDmDbpHPN+QdOpnYOvnoFb2z7qEnzULPLudiun235IXTQVsUbJ08bwfAxSDKSYIeZnMOqp7f3h1T5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGK8ZKrr; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGK8ZKrr"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e904f53151so29633616d6.3
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743285001; x=1743889801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uHuDOfGxHtiLhwxW1iJ9VqknPCigx0E6Km21Agk7uA4=;
        b=ZGK8ZKrr94slhE5/zvv9CJcA+aB3ooiH59IKl17+L+LgawJLCRFMXP87pygTt8oOiT
         tntFaa0JDreYRnc7QKkdwpdnMTrESCrbDScXCpjJgu812PwYGhCZp44VhYRawjwXzTOc
         A7roP9fsuBrMeEUraE0mA16eIxyz0PZp5ljuvTDtnjg/rOeYnvrtupQtVIt5T1tqlvMx
         dHWODMAcd47bp/awdLeAo+vA3HCR90yd/IR470g8T1XB4cpD7C6h0QDF8xCauLe+sFII
         xPrqR7/iQvNEZAqclr7KuRHiG+z8CWxd1zwfK6M3agD2nc3auRBWrFY0KShGkLPvDJOZ
         oduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743285001; x=1743889801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHuDOfGxHtiLhwxW1iJ9VqknPCigx0E6Km21Agk7uA4=;
        b=LQFX6osuUPijJUCu54lB+UWPDitDeo4cIOPu2NwLt/utL/OkwJWLcf0DPUyjRMlH0V
         VgKfh93LeMmo+44/tKuDgohLtIjEiVoQRVgHRtu3k9TY7GziPYEM0g23ENeH4dkv7gq2
         iqZrhcLKdd5P/uNyYXXW1DnD4KnVWCaO7lkAPPPuiU8/oNHz04b9XbcKN5wyZ/E6YhCk
         rFNCfIz2UwLvPwoTkvOEabFPyrmOuUEo9CavUjKtQCREaiV4FlCwscAl7+Q1kRfTZTya
         7J3a7qcj+TOqpTGE155fORi9GbA4WzB8+5PSz5TG/IuR9mvP1tstLLzmrXj+xjGMdh6j
         lI7Q==
X-Gm-Message-State: AOJu0YwEC+JHfgHSzf3CVr9nyHB92iKuhUOSmbebMP2yFTm66qCEvn49
	Wedhk2Z8KrJk45aZxKt+BoFleHk/x7wNm9j7qOE+w6w1U/WZgaYI
X-Gm-Gg: ASbGncuKsKrahtOyu/l8T9iJV7xpMbtIY2LOOTiTwHSvowcnwuoQ99Tn1Vs77SfIOrU
	zqLc3L98+mUp2qnTHmXMozogpqhycs03iObHixLhVcIPJW9KLbPGA6LznKpLeu2sn414gUcXoh7
	jHShdM+h7jwwZPvUBG1gEwM5SScpe2GMDihvsqyHeePT5IImcN3kxbOD2+GEL+o5WphYkMpbT2H
	D5rxw7wd2H8FXuD8yLx2Uc5iLqp1QhWp65WCl9E1LCMYZ7/MuSpS6xxWBfoCtwS3HrTgQw2z6rg
	lHPdwQwRDNlZcfnPSn830c1ZbY8nWDnZWFHHtBVdfaGznfokZdRLHMk=
X-Google-Smtp-Source: AGHT+IH4d7r52c+zbAfSTm5b/J2bYXRrQ/CjXLDuJuQNq1UfjLObpPTACzHSODZ/VijEzNSAkZtFQw==
X-Received: by 2002:a05:6214:1250:b0:6e8:9d00:3d71 with SMTP id 6a1803df08f44-6eed6042dcbmr64230816d6.21.1743285000931;
        Sat, 29 Mar 2025 14:50:00 -0700 (PDT)
Received: from ?IPV6:2600:4040:2644:5100::387? ([2600:4040:2644:5100::387])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec962829csm26768906d6.16.2025.03.29.14.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 14:50:00 -0700 (PDT)
Message-ID: <53c31331-97ed-48be-8399-2701581b09a9@gmail.com>
Date: Sat, 29 Mar 2025 17:49:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git v2.49.0 - gitk regression on Cygwin
To: Johannes Sixt <j6t@kdbg.org>, johannes.schindelin@gmx.de
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <23088b7d-ed98-4b78-bb9a-c3674da1117d@gmail.com>
 <7b4149e1-44f8-44d4-89f8-647734f9e674@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <7b4149e1-44f8-44d4-89f8-647734f9e674@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/28/25 1:30 PM, Johannes Sixt wrote:
> Indeed, it seems that this override is only needed on Windows. Dscho, is
> there a non-obvious reason that 'exec' and 'open' are overridden on all
> platforms?
>
> -- Hannes
>
(resending to avoid HTML ...)

Looking at git-gui's history, I see no deliberate decision to alter the 
native path search on any platform except Windows, just no effort ever 
to leave non-Windows platforms alone. The buggy Cygwin code is part of 
what I excised from git-gui in 2023 (commit 7145c654 on the git-gui tree).

  I'll plan to send a patch for gitk to revert non-windows platforms to 
native functions in a couple of days. This idea applies also to git-gui.

Mark
