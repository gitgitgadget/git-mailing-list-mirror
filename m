Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFD238C0D
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448076; cv=none; b=AxW3UMCwctgp++y9xnt2rGBYbbHpaWr4RS2hQi8EZEXEAczKmo8SSzG7lE7zjOUpueGa7S0MpM2o4jQUt2kp7UC3EESt/YXdYpkpOVm26V0luf+X0ISEQRAjfvNLkQSZAlhqf6UB0VgjcOgfPcIcGRNtQdrM1bFS/9GMpap7ppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448076; c=relaxed/simple;
	bh=AB6pQD4/vlqcJEky3jO7AkGl4VGAVu37zaGYfzljuJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uReqfTCr0VI8Gvm7DokDlR2cwZvk0S8VmbXmmHc6nBdjUzezq55im0vcDY/pEF2XgXknRxpJ9J++TEvrNV+PnS0YZtA0zNewTNHlyqdHJuy7TpYPXCysgTXuJapuhuaG7w/BMixKNA1EfT/8bcGn565If97TUxSSiFANj6aItqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuHVxSFE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuHVxSFE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-236377f00a1so66931115ad.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751448074; x=1752052874; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKSqIpk5z7gMJZ+JGKD+x1/TFvngGc7YwOk4+u3tPqw=;
        b=MuHVxSFE3tdV4agdaGCl/xcu5XpZ/Jpr41JcmBcXyzvFJEiKVqgmUQGcqCEaW31ZS5
         9XL/kTLlcaq/iYcG1sRWBrBH0kC2hWr8rBUGFDldlDKdV9i89kYiuseus6BkTXqOnKQh
         heP5+T8a6iKDg//Hoy0icLQsidcd6mktHZ/hTlqtUM+tmv9pWKmKvoNaemh6YlIug3J5
         tg4njtmo86V5LZ3MEx3uSmarkhSjms3mPFv5PKfyeeJnR6VLZXcaOmK9sc2lVAj/ZCme
         BK1x9RveeOGdfAQ7gLFzYmGy9NhN5mqYtCg8mQ6wfj2HWOT19kZ6cxa+M+0TUjyvk2NQ
         KhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448074; x=1752052874;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mKSqIpk5z7gMJZ+JGKD+x1/TFvngGc7YwOk4+u3tPqw=;
        b=WxOzjcLQj6hJPh0YeqfybSSPXWnjB6b6l+/8VIT4o6WnFWsQEAb8ru2pkDxcczgLE6
         EjBdAoaMaWPhwCRpT5gpAYrGbk0dxhn02dhSD9LA65WDkCrQ7/ze7kgYYXgIODM8gnCp
         aBfF2orTEi4/jBc8Qq1GceIxZv+le0yrYxRmCGld0Yjt24+dWwX6TAs9yv+1CBqaZaWr
         jgGQ9tLay94It6IPnw1MabrJg5gBPMln/ECSt2Gic94aRcd3WyejA/QLS39vZM6XPu5i
         gvQkz0LG8auF5lQgbFa9CRT1Y+7bifiRjO5bYsItiGUcTvk6rSzzAC0JKpiKCNTcUyvM
         YBRA==
X-Forwarded-Encrypted: i=1; AJvYcCXrbkf8fYbBt6yKYt/L9zs6H/zcOWGDMf6cJznkmxAYQ416b4i838pWhvk91IaBjMwA+M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZOuWMnpJGcTPNbv8J07uYBVemAsLtqYB6BnLWxCt8fTaWJaw8
	iU35WzvOoJo+t/MrMLpaXdMvgeJ/Y4hhDqNS/UD6aKNQFchCvactMmUg
X-Gm-Gg: ASbGncuzX34oiSKtn5GkecD6qKYZuS5e/6O/u9IYHvgaLhUbx7AUlrcdVCXN0LZe/km
	TSfUqUkYjcuDxPxMgYd/UGwnu6dqejElwUmzO4vysPkuw4NL3kOjkOPzeFMlnyrmi8fuxe5I0l+
	RJVzgkP7Un9oDCmnC5rk6WIdIQVEKKQruWeoYr9o5QUzhMOmBOtXjUqLwFHPArU6L9/knisRb+e
	T7YTbC1pFvxdn3bwvpPkJOj75pXS92x34bIbBPngutxw0Zyp06tjqOh8uB6iz5uxZoedv1DlMDD
	BJSHxR+kCbXwvM6RmGy5w9p0i5hr6ohO8SmBaNuHwyReWmfjvZOMP+SUVQcubaS1+zjoxOvPbz5
	Khmq4cQLR1UOEC8IKbyddqE5OPcw=
X-Google-Smtp-Source: AGHT+IHrLCUrMrlk3daK7GQJXhbfGj1rNvp4tan9wNnBmZfB/t/bpifEm/C4fJPzFn+keDL7e1AIeA==
X-Received: by 2002:a17:903:2acc:b0:234:986c:66bf with SMTP id d9443c01a7336-23c6e4d3049mr27669395ad.11.1751448074025;
        Wed, 02 Jul 2025 02:21:14 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3acc62sm133498355ad.143.2025.07.02.02.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:21:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com,  ps@pks.im,
  ben.knoble@gmail.com
Subject: Re: [GSOC PATCH v5 3/3] environment: remove the global variable
 'sparse_expect_files_outside_of_patterns'
In-Reply-To: <CAE7as+YeTuQh_BzZSLuVTimrddp5-OBtpMa81KFhd+3zDqDiMg@mail.gmail.com>
	(Ayush Chandekar's message of "Wed, 2 Jul 2025 05:23:12 +0530")
References: <cover.1751309770.git.ayu.chandekar@gmail.com>
	<45c84a6615aa15f19b34b7f3d73a6e418c178427.1751309770.git.ayu.chandekar@gmail.com>
	<17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com>
	<CAE7as+YeTuQh_BzZSLuVTimrddp5-OBtpMa81KFhd+3zDqDiMg@mail.gmail.com>
Date: Wed, 02 Jul 2025 02:21:12 -0700
Message-ID: <xmqqecuzeynr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> Yes, I get your point. However, if we look at settings which are
> shifted to `struct repo_settings`, the behaviour is to set a
> fallback/default value in case of an invalid input, instead of
> throwing an error.

So the user will not be told about misconfiguration like they used
to?  Is that an acceptable way forward, I have to wonder...

