Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AB3A4523
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674094; cv=pass; b=QoBst/mngQHAWRdYszMBShgnUWPtYO7LRWYIa3OPnccYkfnv3M9jRwB4jp0WWv3vWU8hZ0KSwZbe1B56rVHQO1w+/wDiuDjwrMhv+ueCxxc7dtsVvD89l5hlK9zMUOow75KpCgdxUm+ZLzZw2rPonS0VEl98QirC1eyOuCfIrKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674094; c=relaxed/simple;
	bh=eOdDEBA9XFosTh34rEfc3XZPFIm6LTQI3NalSK5DcpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeL33HWwwAe+MLcP/Dv6OojGf7Aa74A5rj+zNm1coIjeUtEzHSnDNAllMUNY1uoVEYLuyJ7/r4n3fge7pTPv3/NfajdrU0Drpqpi1OHF4CD7UFJC5ngrrlqTBCrp6X8NCkwXlhK88zM0+Kv4KIpGTSmvmrbgOsOwiTZ8UMDrPSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UImNoVbu; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UImNoVbu"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb88abebdso461560a12.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 02:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790674086; cv=none;
        d=google.com; s=arc-20260327;
        b=LXMp4CZ0153HPiAqjRGBPJNnVBdkIuY9RNjbRxxqXSMf2zZ36jhoF5hCHzJUwIQ1Am
         ZsSPvUGxQMcRsbeFhC9mxoIoKcUx6rHxdcGhTq1YI2Z4DsqLIYZ5YCu0NA8/u+Ci1AiH
         I2bl7leeGaNs3DdtsWUn+YIwlhtzCFOLEwI/Bl6DLfTmYIcrq+FU7k3rq+G08yl6Ag7P
         6RD2SU/4G+9VZMP7Z/AeA33/4zSkwASfGM90Hp5YnywBWKwEkc9eE0yOYNrsYVgZOLPM
         NYtp+NiDRbroNhrQjyRCaFRAmnb234BgU2uwunsCgpet36RL7KhT8dKfNUMG68buzgJS
         yPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VTENuU9zQxOAI1zaJz3rzioRi2j+gjWjpvJWYBRgAW4=;
        fh=F6JraozJT63bWUQfBlcE0UkCJ6hLjBTt6s0PqcRPgcY=;
        b=JYIh4r86zEqcnq4NfvS6ynuO90NTOpWurezR3UNT40zZ3bxcNjJXAgFKUlLfWfaLam
         ZVw0T7Nv3hz7HcI6gzeVU/ZYTJL/kTwpIahaccn+aV9QD+CqY5raevhbaOBba3fYRfPz
         wr9zAhCGgYsEV6v6Di39YDU01KJK9Ic3A42cqbO539DhWf59iiJmpPD4dWspeAEgxX+C
         omG8jR0Fh6WYvBk1IjvppW+LKDTnMfKOqeXMBGvcDbQS92DYc4CbOf1/12Vk2QZXBayN
         o+hwsppdV22AI46f27do1UnzaiWe91WstxCz18UGowxBdMlRonp8dy9mjhuC3ehcQqB9
         O3Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790674086; x=1791278886; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTENuU9zQxOAI1zaJz3rzioRi2j+gjWjpvJWYBRgAW4=;
        b=UImNoVbuDrjp+nIRmY4dKBVCWxXDfRfyDNs9kKXQPVJGNmbBjamSv47JrwTRuG8QSH
         oaD5gJyLPhhKcrJV3s5fylyg1chbSYHpF2H+u10LNJVA8/lSMEqMTLoV6+mIRgsMdylp
         0f2RFVRAFfFVv9gGyAuiqPplZ37SF6PVA7nvTFqOMrXR9FBvdSd5N82aHKVy28Amy1g3
         4i1/amXdXtnDFE1HJUYSwnnUcIZPctM5mucLqUAiQ8UUWj+J7UowQQo0GYJKa08wkdWu
         tBdY5O9Kn29Qso8UeOPFRjnddcHOBkC+KKA5jDFS3NDz605P9oMNKNDB7QWuZTGaz65Z
         zSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790674086; x=1791278886;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VTENuU9zQxOAI1zaJz3rzioRi2j+gjWjpvJWYBRgAW4=;
        b=FVXjMXTi7caKZV+OyXCRGjRHCUsYHspkWth6zGK6YhsjQktM7Vl7+iMbIXGAnM0PqS
         Ryhs0lVkU0mE+g1SEXwUMPYcdAMiiJPF5Hqn8ncm83R85clPnFFbFSSG7ZBmFyh3kdbP
         WR5AiLhh2IJRYjT3+/ZKfycVXpMOqyXSnCFNv0wGo3a4Q9xbfSTl4re5wCQ9VNUstbcE
         ko/lU56+EPgzkI8Zgnr6/R0bwnsibdMWr5JK/K8BY8OE4586PB59/t9CrR3IjC1BFSa7
         ORu0iOkFd9SFUdsGPekk10AwW/eKnTkafaMuScxOiCd3Y7iokzTsndBAolT+wcabnnle
         Nu4w==
X-Gm-Message-State: AFq9FYKjTDL/JaP2SZDNedpue3UH7S4+idd3chaeM562GMwC9NWkO2BC
	4W/GHok0gT8FUPJARTr7/qNgcFCaZhHtv4xWyvnDUjmzqTENKXNmBC6E41F6n1qVO2jogjYrZuY
	RFWg4iotUTc6Pe621/AVPWz5qStTVszwfbN9/
X-Gm-Gg: AYBFou0lHvb1HqHINDk2ljDKEsJwXGOg0ingxqE8XfwTr64O85lANE02MGVt66ToMrf
	T/RP7X7LUUdOOehcF+8StLdg4mFaPfL3XvVg+L4WZbi0tR9jQKf01WSm+2iaeYAzPWxfmTVTthY
	MCyXnJc++knkvDxTVASo/Ko7I0NtHsNLyZpDSNA1tIo6f+aLJjueLYXr+REtSbFa/Nq06GtCBNX
	8WmmM9PCujw1Rz+org/YGRcneIOUCfLBc95/tqqCehURAhVDc73ZbLjZDJk4sjx0qCExSDAGYkW
	YayFGm4gnnNGt7gdcKtnYgSr6Br+MwdAqqmdL3imITkqIiJUp3YT8lU=
X-Received: by 2002:a05:6402:4398:b0:6ac:8dce:5a75 with SMTP id
 4fb4d7f45d1cf-6ac8dce6202mr3328625a12.23.1790674086283; Tue, 29 Sep 2026
 02:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com> <45b26e2bb292f31eb36d88e2fcf8801eb8313374.1790673598.git.gitgitgadget@gmail.com>
In-Reply-To: <45b26e2bb292f31eb36d88e2fcf8801eb8313374.1790673598.git.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 29 Sep 2026 11:27:29 +0200
X-Gm-Features: AclHuK-W3BevzS-ya13fgw50i8V-91f9rF5TPpxiq1EdGTkPn-Dfn84mE6XkbsI
Message-ID: <CAHwyqnX2O1e+f6qss5+AL3f-Q-PHQmZjbayiph2cQiQGDjSAkA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fetch: infer branches to fetch from a refmap-only remote
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> +test_expect_success 'a bare fetch needs nothing until a branch is tracked' '
> +       (
> +               cd client &&
> +               git fetch upstream &&
> +               git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
> +               test_must_be_empty actual
> +       )
> +'

I still don't think it makes sense that bare 'git fetch upstream'
doesn't fetch the HEAD branch to then allow me to do

    git branch --set-upstream-to=upstream

But maybe that's for another topic.


Harald
