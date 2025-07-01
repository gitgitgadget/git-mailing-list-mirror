Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9C1D07BA
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397684; cv=none; b=LWxRWkCfwc15b5RsbbcTGWzy5OF0XYzyXywPE8NdO4ClRBIrmfC6Bln/p+cTaXpW0cqoBox8BLAKGDbFS4zzRPBYc93pSDIq955q1OlcfHAdnVHWvUuMiykEG887IzHZzLn5PTLTVWOa18O1exp6k23G0SRyruuuK9fbF9Wx+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397684; c=relaxed/simple;
	bh=/2yF7scm3WBeL/+dfJdkF58TCDFvR4XxMSfGT5y5sVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ASsi9faNbWh4URjq2EwqnPzLrdFKbD5q6gGcIaheGr2g4cCgSTmQBRracLWvFKKTsPh5HwF+unM/Iqmzs5+wDp63kjk2dft6I4hMEE6ncyjgem3dDyaq6Y8gjV/PTOzc3hra+xk1f1PHc+UNftJBoZXmASyWXSjs7aXtKy77Z28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRvkFBW1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRvkFBW1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235ea292956so33865505ad.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751397682; x=1752002482; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHvIjsYRzp8IOEB3Q9dTNCFp9WAbeqN/x3xlzrqkhV4=;
        b=cRvkFBW1Fy5NUz5uou+36SkIhJUSeSv2kG8CZSiqJdTTEzEy5Z+UOCGomuwVJ2Hjh8
         gis2l7AW3P7/92+JtIv79bNryVgSt051ozZ9rC4EIJy5OECH9aB3Hn7WKzCBn0gWVCkQ
         DDWfYCcpvNJwOFQ/04YfsY95Bn7aXr9tpsu/2yy/Lsm0hFVlElsycX8rBqG1DnpltKSG
         y+ylywxMT9aRDOCemyHET7R/aAS72cOQ62DcohYhbeXZbMntouQbhD+HpEjScA54zcIM
         VtFBU3WTOciZqCJDNknVzfJsNkofcFJ5tWTqZi2NaP21RpnKw1OEHI2UnZ3CxzopphaT
         pxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751397682; x=1752002482;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dHvIjsYRzp8IOEB3Q9dTNCFp9WAbeqN/x3xlzrqkhV4=;
        b=W0EqEAHAwEZMMjQaitGQZcqWW+lzcCLveKWfwTQhNOqkDYrJKXBfnPe28mSzgxu13H
         VA1Y5sd4s4I5pXRLmLOuKuiupcC/tpaY3vqT4p/iU6biVWQ0CGkE1nrqXDWJy4f8Zu/u
         JYpFprJUrkQm+RF/sxSo9eFtwfKOqny224/ObYbVfYgvBgsIlZnZmD0n8z8SupW9+P42
         6KGN/mX6NKpgWOexhgTybmHHgt3W/rQyt+uJaisBeJ1vuX8M/qbBtztj7/jh+GShRZpB
         Kuj85JgxCtmB6rLXc1AxBB2li3zwEBeUuuWyrRV8F7oKYu1mj/hDrhwKDx8oI1VSDRqX
         vm+g==
X-Forwarded-Encrypted: i=1; AJvYcCW79lsKAoXhd+KmEy2LalF13HQ9UGsoJH4YS10aMjz/8wG2bSTJKvx4TtKKbD/+dGJP05U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JdR4XUsR7U5uoe91+sK0q/ghfcxEA6WhAeH+QlpuuqMKzOGI
	aIG9ssJptLq1uL87wbfQAaRtyqkNWxf0sV9hoSWFrtUWoaJP1w+7u842
X-Gm-Gg: ASbGncurRhdjiyHK2Iap7vrqjAW6v8DKqTxojLsb7dJkCbBoH0GDxBr0ZwSeUUUa72Z
	OZU1h7RGnAkjKoM1xTzxGgVCT2Er5XubwfzkQhVyavlB0JsyfQVmAiT8rgHSfe8W+rvQ8xjc+n4
	Kq/O29BcOYcNcrAXp8By8N8IJ/PP3YeEiC0c/GmCDuyPn8duvJP4kAqOwRpuItdQgncGUxdvH0Q
	WY8geNDjiiST4aZkA9xJdzvh1+2pXycvBKqmQOVZ8j2dE3Gy3/MxQTUidCNVy97lLj+0TYVeLT2
	d7ttbA0IAzjR+nsPu0vGDn7OZGT1M3Yy/4NxPQWVB6adQfQ6dZEmVUQqq6i5GlkUNcGNwsg5fJd
	MUUbnjsNIXIsbilvvZJUbvZQ0+kLjBQfbL4dAfw==
X-Google-Smtp-Source: AGHT+IEyNSEfA153B2DAabYotfCdFuWpUYm+38eRXFSuQe/RIWZVVVoG+s3hrjWPJxRseLcVaiauGw==
X-Received: by 2002:a17:903:2ece:b0:235:f70:fd44 with SMTP id d9443c01a7336-23ac45ce9d3mr291998015ad.21.1751397681808;
        Tue, 01 Jul 2025 12:21:21 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3ba047sm118681245ad.194.2025.07.01.12.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 12:21:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Han Young <hanyang.tony@bytedance.com>,  git@vger.kernel.org
Subject: Re: [PATCH] read-cache: report lock error when refreshing index
In-Reply-To: <t4czubzmfuihxzmefwwhcel5qyss35gmodhfhvkfyiwitb5osw@d33acdbtds63>
	(Justin Tobler's message of "Tue, 1 Jul 2025 11:08:52 -0500")
References: <20250701115719.85226-1-hanyang.tony@bytedance.com>
	<t4czubzmfuihxzmefwwhcel5qyss35gmodhfhvkfyiwitb5osw@d33acdbtds63>
Date: Tue, 01 Jul 2025 12:21:20 -0700
Message-ID: <xmqqv7obk98v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>>  		test_must_fail git stash create 2>err &&
>> -		test_cmp expect err
>> +		test_grep "error: Unable to create '.*index.lock'" err
>
> The test now checks for the explicit lock error message. The check for
> the "error: could not write index" message is also removed even though
> it should still be present in the output. Should we also continue to
> grep for that message too?

Probably.  I was wondering which part of the patch removed the
existing message while reading this update to the test.

Thanks.
