Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D938FA6
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222122; cv=none; b=SpKrbhSXdKKqoJhZMXctAQMQoYZUGRRhffnMUcqADKFXSDVl/tfxBXN1szD5+ByObEESi4D9trqAcSlRktPeYzaspqUpkloXneMs44dt2k0ds2WUjQYWqB4RB0SkOMCVJvnVSSr64gk8PoIuSY7ByMSXFZsY2oywYaYG/OwMojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222122; c=relaxed/simple;
	bh=9VSjNv1ZvgpFGdSIh119gFXNUD7j5TidcDRdffzNfI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f+dS9F66tMV6hvx3jm3EJ/EoVE2hGfgDXWSL5mopIOcU4GlJ1ogK/FcF769gnRIqIQ7yJvqbFV1M4SexVfldAm3k729nEcidvpa4wq4lJ4TIH303u7s+YEA0D1DcVVf7+azsXiLy92JtsXsAM69RDbqfP01t5G90DQnz9mysKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbYArLyQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbYArLyQ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748f5a4a423so3809328b3a.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753222120; x=1753826920; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoXjpaUM7N+9ZPHC3IOllXZpwYSkP2+0d/KXSKV6Gbk=;
        b=XbYArLyQ2o8t2SPSPLbcatJhF7Zy+1Wf668EoTIPiX9a/FUc4M6INUFynsyqzG3vOu
         O0alo+O8JHZBbHViqsYXtplYrbfdQKgA+Lg23+Chjly3pSHX/CAhUnMdcJXwZlEbOGBS
         HCvl2BzOxuiEqwha46Cgy/i2FgJ2hViVV0j89yHYIYIGCdtJwyhH7IMrLlv9KqkQTzYG
         ZnM6+I+4wLcTaOSUSTo9dGZMidTRLqgTlpPZvdIwa6jqLlveKPOGqaTikVMrBR6xfqjb
         kjevLn/IkIn1WL+uDP6AgeK8TlcXOSY3wdrvh82Q00WsKE9jzw8RcDo9u6mNPHXiKyBx
         DMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753222120; x=1753826920;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoXjpaUM7N+9ZPHC3IOllXZpwYSkP2+0d/KXSKV6Gbk=;
        b=bpe/2wkxRxjOb8E8zmvY/vB2HbrRsrzuUhkj9Fn+A2d554ApRcLw3NGrovOWN1F5u7
         DeMPQhuauorhsNVbVL5o+0iLgIkZNVEbhLfnIw0kLT1MZWAx02VNqMmbEkrvNWBz9zFL
         YNa+eXmqvHN+0gvkmUjzGiCuXfjMpJmXyGIMkcMaA6xb2vo6Q+ztvvT3jy83nBaPxw9s
         za792M7z9e125hrCPvgXhoFAdMIQiMLFnOUoyovygODcCzf+pEajL3zbN+bY0JLcHCXk
         qxx0iup6Ovu+EEItV3OezkRzZhm46lY30eKSUwcXgfiHIMWFOoN9K57Lbo9hA0HtC7aC
         M3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWrSIjJQSbMDpiDLoJTM9CktboyXgNLI5k7r6QdIenJc6RVb7eRHXm0TnFoLvEKyLClVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/sygG3RVU1C7m5S9IY4Da5LWMJgV1rfQXySoE5XCd1zNtu9q
	fqp+XpsdiqA0dbCOebI63aNC2gqeNloFjG37jvcgzkMPfADNRR8+uvbQ
X-Gm-Gg: ASbGncubDb3J/vVbegIYetaAuJ4pKu/1IHKrm/6qDc4s47WDtgUBsNhYHibidTCEOlU
	M03+ReqG8dHN0fYyR85ZHyaHl+UVWOnbKhGJ+JtIKo/ZDXv0PvBPh32aTCCFEPYAH/KmgLu+nul
	cy9SXlJaGCuXQkQoWS+AjEvJG4SRM+aHRTmIL1hFb7aJoLo34FGvf8RMi7BLLOpUhH7TgFAUjs8
	xWCdWNSouhDoounJygAFWRPeKaJGPTTCOXKs4m9x8peV8r+0eFO6JYzAK8H9seZEAXiI+Hpuams
	/DDrFMAVyqQjmWDmF7iOkFymw3B4lJx3PEcKFnNk6V9VFi05cbtquMVxwhmLXjtkY6RFqvaS1I2
	53Ae+2qJIXpciXQ==
X-Google-Smtp-Source: AGHT+IGMC9b2Hu7NNOKd0cX71IhmEcFJy4hbr3xARexwxyltXUwMfvsKArfCkznaqWH7OU3vmGwLSw==
X-Received: by 2002:a17:902:e892:b0:234:b41e:378f with SMTP id d9443c01a7336-23f9814e994mr8163825ad.15.1753222120120;
        Tue, 22 Jul 2025 15:08:40 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::69a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d85d2sm82860345ad.168.2025.07.22.15.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:08:39 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Sam James <sam@gentoo.org>
Cc: Elijah Newren <newren@gmail.com>,  me@ttaylorr.com,
  ezekielnewren@gmail.com,  git@vger.kernel.org,  gitgitgadget@gmail.com,
  sandals@crustytoothpaste.net,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <87o6tbevql.fsf@gentoo.org>
References: <aHl4U98BBvpA5eKF@nand.local> <87seiofc0x.fsf@gentoo.org>
	<CABPp-BEf2O12jx-wN5ig941SyoL=X2OJkQY26bac=8+v+jx8ZQ@mail.gmail.com>
	<87o6tbevql.fsf@gentoo.org>
Date: Tue, 22 Jul 2025 15:08:38 -0700
Message-ID: <871pq7yj2x.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sam James <sam@gentoo.org> writes:

>> Further, I'd like to comment a bit on the support of our users from
>> another angle.  We're also responsible for security for our users
>
> Supply-chain issues become more of a problem with Rust if we end up
> making heavy use of crates. A policy moderating their use is something
> we should talk about.

+1. I find it a bit worrying when I see 500+ dependencies (mostly
transitive) being downloaded when running 'cargo build'.

Not saying we should go to the extreme of Not Invented Here syndrome
[1], since easy use of packages via 'cargo' is a major reason why people
enjoy Rust. But we should consider whether they provide enough value to
be included.

Collin

[1] https://en.wikipedia.org/wiki/Not_invented_here
