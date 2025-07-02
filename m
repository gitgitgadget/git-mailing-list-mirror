Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89133C26
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751420878; cv=none; b=PgmoE5tZE3A4dNVauuPXe6xYC6UtNrHCOeLgNdNO+eO85RMipfqcGNXdJc5vMg+rlRzKF2zxRMrth47D1QHZGLVG0umjqPs5YFf4m86dPhxKfbL1OOkfMTyZ8t/OSW6hH73m3qeWPOcT7AQHX3USHEo24op4j7cgjqXC+szdjdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751420878; c=relaxed/simple;
	bh=1orR5hjbqAnrvNnF+J/kUDXBgCCOX6MusmWKdPqTXcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nx/OU/PU1b8ppUgqTCGMIIN7qzyjNsWXNgLMwo+ZsRbb6NrQPcVVfCd+wXNEcqdykv2U5WeRvWuxYoFAS/kAiGF0bGDYa4KUvTcEEeYmqlrk087oDt4Z8kvewFChiLoWGNHmczq3cubrEdqdftjhmcpxI9Be2V8547jwJesragc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP1Y//tG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP1Y//tG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235d6de331fso50102985ad.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 18:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751420876; x=1752025676; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlkIXGKGezHdIM6s0ncupEAgaAUyTf1el33IbrXXs3k=;
        b=JP1Y//tGwksHlue7RsxwrUJynCfY+zs02PZSSNOXYQ5JW4+hsQMkg16Iq3V+WB4P81
         Awv6YWHLz4jE2EwsCDyvpuKSLReT+tLXJSWhmL5zaTapzaFHa11L5f0mZRrbRvkeXyQ/
         5xd35/mIFdThTYHB2xmxMuBrMUyC/GqRbGcGlj64AQz6X+VdblqFPlU19uDEbGiDFfeH
         8Es24OtzvBU3j1BF99/B83scIgHVWeBUN1muRgUg2BGntxh69M23aGNIVjBqqksBJcjG
         JNJz4sgrjGCl68XAve/v8QldEGi2gHkNALXWkFMUSkLlOhe1EWnBQ9LQiAuVXHeN7o1g
         P34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751420876; x=1752025676;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IlkIXGKGezHdIM6s0ncupEAgaAUyTf1el33IbrXXs3k=;
        b=bmRPIFt1Pj+Bcq7/cFya+Ok04s1hY/B1ZJjY9USe/LDCobwMCSzEekZTO0qK6WSx85
         +AYc0XD+W5nMUJs/Jjm/uw+wW/p+UC0+9yKFztISs5fydUlLhuNqnLdP3xB+IREZL3a+
         dYMv8z6qAvfBYRca6SNvg942AkOLgmAsMcXxVrjKQ3iG1qLfvGYKwoHOMBoBHCmLr+UH
         toafROv4W/jGum/4LPkOAaGo4dBVPzVa4xMWHShEgJvbk+nhQTcekQ4QamMVTajrgt6a
         WGQmgpBXtsFwjFbbZNsKP5TFS9DY8OvoBSJktyblWEWG8gQ1bHTGwfNP8vuAXpRXUkhC
         +X4g==
X-Forwarded-Encrypted: i=1; AJvYcCUMGTrhwornCVNYmGrpSBipjOLHOPm872xVXzebscsBAGrAn3LHkhjFdcyOT39mOYY3tV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydvlsLv/Z4H5gLrVlAfnjUb5ZDdT+8fmGyOzsfw+jw/dxbZ6f7
	LbecAeZUXaMsEKdJi/fJdwIOmTeB0UNMfq0EbPPLT8n4WQLopnKy0lI+
X-Gm-Gg: ASbGncuCh3cOUokxsgGWmvkOYvujnPsNXW0/675hd/3YpH8sOlWHgya2WxytUUaRsTo
	O0hSp4pHz6X91LOIc10cnDBoGJaBwWw5KuUqKhUZZHxcuaVxUnQRfz/qN909x2SZFyUrfFT84Rd
	y7HujcJXWfg+NNxCgNSDqJeSb16kUWPTi3ifRxNFVXyXxg3f3i4k1C/vesqF9Fxm3WMRnCAu2ST
	cqwpr9liqUjoddL9z7BpM8bv3OZM21o8uR5TofyIOFyXtrpfHGAiJEKTYY+a/5qhLZ4FtbYS5Qi
	Mh829Os/Aj6kjhpjWiLr8pAI4pWAuMXath+hYLbcoIWTZo/C/9FH326HOk+Pcg4OTwba7uR7geA
	pwuD+SZAenFcSAgmUNRohXHG7Ggw=
X-Google-Smtp-Source: AGHT+IFs3llTVs6HOCr1CwZcZOUzvmlgk/XUsaEjr+mQA7O10GueRzN3trBOc/DZPfmbe04WqTwM8g==
X-Received: by 2002:a17:902:c412:b0:234:f6ba:e689 with SMTP id d9443c01a7336-23c6e56f630mr11298915ad.39.1751420876138;
        Tue, 01 Jul 2025 18:47:56 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3ba047sm123983345ad.194.2025.07.01.18.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:47:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
Cc: peff@peff.net,  git@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH v3 0/2] fetch --prune performance problem
In-Reply-To: <xmqqms9nfjvz.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	01 Jul 2025 18:42:40 -0700")
References: <20250702005837.2813893-2-phil.hord@gmail.com>
	<xmqqms9nfjvz.fsf@gitster.g>
Date: Tue, 01 Jul 2025 18:47:55 -0700
Message-ID: <xmqqikkbfjn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <phil.hord@gmail.com> writes:
>
>> This version (V3) has three changes from V2:
>>  - Removes a header declaration I forgot to move previously
>>  - Cleans up the refs_warn_dangling_symrefs API to be more sane
>>  - Drops the ref shortening that seems ill-advised in retrospect
>>
>> Phil Hord (2):
>>   refs: remove old refs_warn_dangling_symref
>>   clean up interface for refs_warn_dangling_symrefs
>
> Hmph.  On top of which commit did you base these two patches?
> The second one does not apply on top of applying 1/2 on top of
> either v2.48.1 (where I queued the last round), v2.50.0 (the obvious
> choice for a new development), or 'master'.
>
> $ git am -s <patch-2-of-2.txt
> error: patch failed: builtin/fetch.c:1384
> error: builtin/fetch.c: patch does not apply
> error: patch failed: builtin/remote.c:1521
> error: builtin/remote.c: patch does not apply
> error: patch failed: refs.c:458
> error: refs.c: patch does not apply
>
> Thanks.

Ah, nevermind.  I'll discard your v3 and will take a look at your v4
instead later.

