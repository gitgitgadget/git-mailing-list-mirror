Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330D2F56
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705781378; cv=none; b=o6tg2l4VO0ffRHvR4HGoI0z+P39hOpi4FKqT/9lxd2AVIFEbPxuzE7Kvh+wNKRy/HVdWdt+rD8Q2jBh4/D1HgNSjzRojBYOoX5LUbt4bMGXLfViUNHHPVW9zYCR8O5gwhOQKR6DP7Rmp1Rxy/qUh0grDmjiaOgoMQa9Pxs1p/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705781378; c=relaxed/simple;
	bh=a5SUQCiye3Kjnjp9bvDikdbGLKFcXGOL+d7Ernovtuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AUG9mKgE4pR/KspqaXETn0GwmXURox49fDn/HdnjVcvQQgpToolKGEGAORGG9t5986FD77uwsVTulCCuQ/KYJInJLuPerBcIu7QcEBu3Z/v1wJlgilhSv9nRpOvkf7bINRZ5U/0UD8bZHyNJb5BPjVo8JYnn6AodbmWl2Hn3TRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=30AUWKgr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="30AUWKgr"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f250d8f876so33932657b3.3
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 12:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705781376; x=1706386176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2A3ZUuTvCOQk38P44Xg0M8WXs+4nQkJmQB+4cMKA5wI=;
        b=30AUWKgrLdrmXM9hQlSDWf8OjRyBv7y3H68oE/vcjM5j/mVt7pghwutoH/TJC39Xy0
         TempxMDaXwBQbuW8L5CPXQZNWfYekgbJYUoHq51WayHmnDs93QYJp/nXMxVmUdA94Cum
         kOPJbUJAELOfL1NwBIfTtbckwd1IagCQa8WuUVlVfGN7MgtaFYSS+mx1ELHGI6wvgath
         qrUujhJ65wyChOcw80jksRC6H2UaGL68kgAUTXfT0Faavnc0Ui6QIahYwPZO372sX3jA
         BixqWNXbswlkBmnmd72czCnYC4jQIqrNXIiO97gOwJnS5DZq1iHGkqoEfdAKuQsKShSw
         D8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705781376; x=1706386176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A3ZUuTvCOQk38P44Xg0M8WXs+4nQkJmQB+4cMKA5wI=;
        b=tG8/2fqU8KiD6hBtcRUhfmE3SLH5yLpwVS/yOtOgqlVI85Kykp3zwJyRauFAmHUgGE
         4HBvTMJ5HyYk7RAKVL88DftM51vT5uKvw+UU+uUkF6r1tga7nPcesZI+uhu38ucL8A+z
         dSePwf/rRAi1eicSyD5SlgOpBTYD3HYT8WRxCC4ImUd2mbvjGiHplal/vjGMW4V8orR1
         HAQglAD23x/WB8VY7g62sFkzQiuw2fu1JORxGgTretFDnu6TkpWz0vrAJPRelhGtX7Vq
         fi34eTBU4PLFqhuups/F+QCzX9xMIwZEZUX/amUn8ZK4siL4FkDStfCUK54zDSCS2WFp
         nWEQ==
X-Gm-Message-State: AOJu0YztPQMkJEofYKB/JFoElsvsJ4hLKEV4gTYjZWLPa3vCQZfbXorr
	WtlyLmISygJZv1KlMmFF0pAZGY8QH1HCOuurRXNeKO2uVU05JRp5g1hK31QyWBPUzQ1TqjD+1yM
	U8A==
X-Google-Smtp-Source: AGHT+IGF4g7GVRDBrPrPRc/bTkvtJN4onXtlzsI1PdOoM9yA8wJfvHaM12CF0kHa30tykH8NTq2RJLd7070=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:9808:0:b0:5d3:a348:b0c0 with SMTP id
 p8-20020a819808000000b005d3a348b0c0mr911257ywg.5.1705781376465; Sat, 20 Jan
 2024 12:09:36 -0800 (PST)
Date: Sat, 20 Jan 2024 12:09:34 -0800
In-Reply-To: <xmqqttnam8wd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <9183990583f9a591c79301a20fa327462bb50cf9.1704869487.git.gitgitgadget@gmail.com>
 <xmqqttnam8wd.fsf@gitster.g>
Message-ID: <owlyil3nhim9.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 07/10] trailer: spread usage of "trailer_block" language
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "info" is a word with so low information contents.  At least "block"
> would hint that we are talking about a block of text that makes up
> the trailer attached to a single commit.

There is also "conf_info" and the whole "key"/"key alias" vs "token"
lingo which (if we are going to rename things for consistency) needs to
be updated to match documentation. In the larger series I've cleaned
this up as well.
