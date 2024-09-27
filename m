Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DE16B75C
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429861; cv=none; b=QwBfotEt+WQ7RY/RsB5L8k/dNcnjHjIrEnI+/c740XLYCT0x69ldWAjQ/uMR1FbmOdlOYBrGCAhbNa07WQy7IwtNijEuaElAswk6RFPyiVgdbtgOejhKmQWi7CcfpTDdjLLVdKfMkirQhW7xyxodpew2XuUJdW2pyAwdQN3rGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429861; c=relaxed/simple;
	bh=ZDL3TkuTxBgF+o9z7EVSPvF2EPQq1rodkLXuhjOxxA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uNwrne5Z5vg0+QGitJeZPNHwZeUjlEBfKD/xnRke8BYRVEZwFxaoaHw3AZ0LwLfmcOsyzKRXxXdVt0yGsCy3SSyk+Qa9IbNFftpNkpyIvveohgdS8KtYqhTi5iSJZYMC+i97/Dm1Bu8hXp1r9E8zHA5+D/9vXU5A4T44+EKnHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTLy5Wmp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTLy5Wmp"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6db67400db4so21265487b3.1
        for <git@vger.kernel.org>; Fri, 27 Sep 2024 02:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727429858; x=1728034658; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uliE9uvvlO6Vms3iyYoDBnMJaOodsqgpdanKKZDgVGg=;
        b=aTLy5WmpjHaEh4XT97Qqx4j3fZXpV3Rktg6cVAsXmV7H1BV/YNAzVgu7pv8KXRlmPj
         rO3CzAzdnHYdjX8m636JGm3Xzf/wxewEotCcwfcvu/1X84VoaOb9i/VjFZEccO1b9Cmy
         nVUQb51e7f7ImU4pjv/XA7e46XYxJeVTG+4oc9lQnBpcodgICw/bcySDQWkm6/G4HH3v
         HIt2LGTky+CNedkxIDUl6TiZWejXaOUCcl9ioepd8qelbtGNYGShyhiWJ3347wCNheFM
         0RJI/ei9PJ/Cinp81RH/NZJBgXvUZjkB1d5VQic+XGcdswhBMNbSv5xjLV+ofcDyhz6c
         HA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727429858; x=1728034658;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uliE9uvvlO6Vms3iyYoDBnMJaOodsqgpdanKKZDgVGg=;
        b=TOYl9trAvIT9G1oJxi6kUcb7BdPYBmILPjzti4c8DwGyoWzLk1hGSqtivy8ZCv3jLQ
         kgj0NVkNNsr83PXm+eexjRqI9AZKg41REcEDD2nfEbDOeWLjO2C9h8qEUVf5fw+73LhF
         gInTF5+s2F9SgvqQ3p5MXWm6rSfXyfJNu3FBRgg+6Y6My0u40Ycf/3oSBaTPFKt1zvbD
         hd1jzOjdVpadfNJLue5Uh4dKSVHjLZqnKidYERN5szXTbyUcomykH1ie3oB0ved2bYOz
         0jk0d+iKzyouEJGl4+93ck9JCjQsGlLrF8+5ayLBqpEapUhtKXMVUD3sh6P3yWDhqBFm
         rLmw==
X-Forwarded-Encrypted: i=1; AJvYcCVKQJ8Ih/tbO2uz18YwRVswWyzf5yF6lik4ElptsBUYGGGcAS3mkpg3w4HCDBoCqepf0ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxuJ23sIHdRVMGfXdhBA8Rg3JH7e/vKnS6FmzoxhKO6yabsDM+
	9QKnv97tr/Wp3mz64SIvLTq0ZRwsyt82UiB5S52QUPQ9LXrPCLp0Okr2hQ==
X-Google-Smtp-Source: AGHT+IHYJdmob/IQNKVQZEs/YeL6WdM9n7+mLcKKEmyRlnkOo0tllLcKKeT9My6t6raWOfmnCGSw8g==
X-Received: by 2002:a05:690c:2848:b0:6db:d5e8:d612 with SMTP id 00721157ae682-6e247585df5mr15784167b3.23.1727429858263;
        Fri, 27 Sep 2024 02:37:38 -0700 (PDT)
Received: from epic96565.epic.com ([2620:72:0:6480::71])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24531d538sm2523657b3.68.2024.09.27.02.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:37:36 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: <rsbecker@nexbridge.com>
Cc: <phillip.wood@dunelm.org.uk>,  "'Taylor Blau'" <me@ttaylorr.com>,
  <git@vger.kernel.org>
Subject: Re: [TOPIC 01/11] Rust
In-Reply-To: <018401db0ed3$667bcf80$33736e80$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 24 Sep 2024 18:44:59 -0400")
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2D/b1ZJbTlC1ml@nand.local>
	<053f01db0b79$0d885b30$28991190$@nexbridge.com>
	<m0v7ynm7h0.fsf@epic96565.epic.com>
	<00a501db0db2$94d505d0$be7f1170$@nexbridge.com>
	<18d732da-ad34-4a45-b59f-cf2cb3c7238b@gmail.com>
	<018401db0ed3$667bcf80$33736e80$@nexbridge.com>
Date: Fri, 27 Sep 2024 04:37:34 -0500
Message-ID: <m0msjtmo81.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:
> I do not know whether Rust will never be available. The policy is that the Rust
> maintainers must sanction and approve any ports. I have tried to get approval
> and have not been able to do so. It is not for a lack of trying.

I do not see a proposal for "NonStop" in a pull request filed against
rust-lang/rust[2] per the process laid out by [1]; can you point me to
where you submitted this request?

[1]: https://doc.rust-lang.org/rustc/target-tier-policy.html
[2]: https://github.com/rust-lang/rust/pulls?q=is%3Apr+nonstop

-- 
Sean Allred
