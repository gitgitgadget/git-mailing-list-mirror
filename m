Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0772E737E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297494; cv=none; b=J2dLzIO56LvAzYknoy0xQrkYUIGRMek73cNzUHpuaWAGkpPWZ0WIerqSlbGXqft0Gav+p+895uOlxFD8vpwAWWjbwTcDhbCGvw1jDgYQPWxRj9Cpdeo3HHZLUv6Gajqa1VyFapfrZe0NPkxDjZT0SrdIHvemFoyaP1zc5UVHN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297494; c=relaxed/simple;
	bh=BI7W9wubY/vR4THh6mpojWzOYxUuITA6CUG9wsqaScU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AZBPw/b5Ew/bOEDCHi8fywFgY+sz981FyPnCUWKiiJ1u4quXItk1mRNytYWjUofi6pggsMD0SWOOO/hJ+v1yLtJoRAhow3osWWsV43lS38XyYbbLOBRtmAJoQZ8OZfXhKql53cUmDpOOBbdu54IjrOzMFJQbh/F+fEtFtyM4aWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak7Xkf6U; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak7Xkf6U"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533778ab0bdso7642831cf.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791297491; x=1791902291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EYmj0y1ErZOarHl456j/es06mokHs16kCDUUdcoLpp8=;
        b=ak7Xkf6UlUEqn69NOE6fKPrCUDD05IMKVPs8fi01DsCxSHYXYaWJjz57RIORW7H38p
         szqovoP6yj72+eoe4bO1LWYEw27rAmiJg9U7tjQl4g+7FjbYEH6ByoAcU0PCzxyL74FH
         Qei2fZHHk5gJDjOE+BrgJEzWzThDiOCFjE+fNqSF/5eY3BChpJK2Sk4br+BuAjU3HWDw
         zFOhVu8YxjjBJC3e1jz9ob0dlr6AmGSzXdhjo6LWir+bsviKThx4Ha92gWCWLwznTS7l
         G39FnnEsrzB7B4k3jE6TqJg+oX95X6yV0wRcCJ0qm+iErvG83kREIthWFTlhHgAcIyV8
         Gndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297491; x=1791902291;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYmj0y1ErZOarHl456j/es06mokHs16kCDUUdcoLpp8=;
        b=qqx+NPUaT+MHNXm3jtvJK4uRdnG2iez5pvLaLppj+lifSuclAHuiP1dKGoPVCzWE8p
         x5LmOmfrPCCRuTjh7w2cJx6P9upXz9S8NgobB4ASnQa0kD+OmKbi39koEhdcRiz98/IG
         Clh2RAum5PPnz8zP8txQq3DTKSjQYDMuXpHjRUhD6+sHGNsJr+EJWHYIzsTMpGs8unjy
         0xqGX+i3ij71NZk11Z9H498XwIW64xjIUEvqCW1u9D12HYh0nep6sbEBgflf+hzfOCE/
         jeeYaPFwJZeeScqrV9W6iq+d1f/EiVCw3x5XoNDNM2kW3xMs6xXc39H9vybPtLWgWteL
         moNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfLcrmrveWuAr7pJGlRYEO3gXGAInGGIXb2Hw67zU0UEoLcsAT3jikNegASOqsla1YSv0=@vger.kernel.org
X-Gm-Message-State: AFuF++m7VAoVehL6bqAY+7uET4cOE6LuMsmmsCVHlS0HJ9RNv0UuVe9t
	lDw+zAIEo+K2CpD3kUyEdZeVgXYOWdiA6Oi6lMtPA+Hok2PZVSgoDreC
X-Gm-Gg: AYBFou04qxQ/KqVF5uKIuu6zOl0ri8LugnJagWum3WFG/vDOeKgAXqvf7XV2la9+HUH
	tEtLMb9Laqk+ERLonhCnzKSUecx8xRX5XQyJ+rrkbj7fe8otWfmsPBZMmskPidPkf1UxBbm+QUR
	8sK5nYsmWx/zKlk74T999cvNDgiYufA2T2paLIc1FEzdq5UNAmUDEl26yJOHo/2FV5mL6LrQcNm
	2+BeK50HuIc9K+6Mj6f2p+yezUNPQifCqb5SzcY22aCvjTy9/MgR3rAoVq7luqnqcJZZyJ8uw4U
	jbIkuCt7FMWoFKOux60UV1e1e6e9PTYJczb5T14s1F8/gOli2RPGDGWBrZeOdYCaVCdT5BXDNAR
	b9X+QxrDzh23B5sRAFc3KJFSRbAOYBySrK9sKJ/ZQAGsIE7JXwierhQGNMVmutzvLf5TawhACl0
	8PzDlT/wJ8dqdfVaAIWZT82+DCXIsamIP3Ovlvhge6opqT5yNjWDKT0J65H1QGV+XeE6tcVGcLU
	uNgrCdFJ3n2QUNs+oQKv/38lorJs3f+ZYKc1Uo0C3R//Yt5AEu4GBAt03IExlhMzhG9oRc0WLj5
	aHz26mPTT9i1gD+xJMLyuHBGqNstw1zrp/TAYhm7ycONO8nYRA4yfMXqBGxmbLSn4L2qb6HWHIT
	6ACGK4/q9H4pCGhJ1ZAtrP608
X-Received: by 2002:ac8:7e81:0:b0:535:5f0:8c04 with SMTP id d75a77b69052e-535671d9a7emr24888801cf.56.1791297491281;
        Tue, 06 Oct 2026 07:38:11 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5339883630csm124910381cf.4.2026.10.06.07.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 07:38:10 -0700 (PDT)
Message-ID: <91339226-5026-4618-a642-eb2267038f74@gmail.com>
Date: Tue, 6 Oct 2026 10:38:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: ds/trace2-tolerate-failed-timestamp (was Re: What's cooking in
 git.git (Oct 2026, #02))
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwlrviv8g.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqwlrviv8g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/2026 7:27 PM, Junio C Hamano wrote:

> * ds/trace2-tolerate-failed-timestamp (2026-08-31) 7 commits
>  - trace2: remove use of xcalloc()
>  - trace2: remove use of ALLOC_GROW()
>  - trace2: remove use of xstrfmt()
>  - trace2: remove use of ALLOC_ARRAY()
>  - trace2: remove use of xstrdup()
>  - trace2: tolerate failed timestamp formatting
>  - banned-die: create header for banning of functions
> 
>  Functions like `xstrfmt()` and `xcalloc()` have been banned from use
>  in the trace2 API codebase to prevent calls to `die()` which lead to
>  unwanted process exits and recursion when memory allocation fails.
> 
>  Needs review.
>  source: <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>

This can be evicted. It's not delivering much value for the
complexity that it adds, and having banned-die.h present in the
repo may suggest stronger protections than it really promises.

Thanks,
-Stolee

