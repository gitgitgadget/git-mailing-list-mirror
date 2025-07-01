Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272E1F03F3
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389717; cv=none; b=I5cm/Gkeg4v5/EblAxHNyeS6RN8mb8KbTGiFAgY+hZd7Nm0RLwRNFjWDjDrixdB0wLlLX+cPoby28ql6bT2iFpbKsU/5qHPs8Eqt/hZsQy8DlkAoHApZnDg12DbvMb3+ea+W3Rkae22mIif9APF8k/hJLO30j1HDk7kxDCDazkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389717; c=relaxed/simple;
	bh=wJjqepovhlL7fGCAxrdpGkyu7xXBeLRca7kTke/JUbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SLMLEYtd3Ep3VKIUk8HA6t9jCyYnZmLwzPA4YWBYDiphxhZov47s0Ky0PMa43yD9ZgZLq8casV+bJ59AAYoDebK0/acxa+F87t7ciDTjvBrqSyZUj7HgJJIH9OQMNK8N3mSeCoFRS7WjSKFd5MhXQwWtzOBppgzs/695Bx7RRvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z58jrvnl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z58jrvnl"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so4764960a91.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751389715; x=1751994515; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiyhzK9o9wrtdqoq5cJNOv5svUiLGPN0Cvhp1skFNx8=;
        b=Z58jrvnlj/PJ6KyedCbUSBNtkZVbeWCgPqlJLQxj2hnHxHVEHvBJl/REsJu8H7Cm8w
         kwiQqjrMCDpr97sQ8CjLNGKJWU+Xy/kRK/QXB4i3bD5EObalXfjc+DBFPCfoW/w8Sy9N
         wHuN9uu/B3T7fiulKpfsa2UUMvxsCnaWhzEDao1iWD50GPkZUHDL72iB35o5W5o2m9kg
         eRWDzYpjsCHP1y4rIR2eivAWGyWGqyoTJrJ0upnNc8tCSpW6Z4UY+juCAxN12mu0OwnB
         2DT3xclvWkZX4ZSys2kQGsbCY/opSm2CC9e6e4ludeDmLc/8e+cG14aP4Tsss6cdW3Ny
         VGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389715; x=1751994515;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wiyhzK9o9wrtdqoq5cJNOv5svUiLGPN0Cvhp1skFNx8=;
        b=PlC923/5Yy845SjZgsepn6ZlSY4vO7YXKuKeG7AnQapcO+2I9j4xuUa7RSUnTr6LRC
         m3mRbAqze801JdfxEpqCLugUjKHWnWPWNzdHYEKuewRihVKIzcM4nbZts47V9Aoii0A3
         lLc6T7HRGyBY7qZEBnBQfrrJ2ZUCeIIYTxeQEtpsph4Oy0plG3rak9Dc23qLezes0nKq
         yqOqLH4Z5CdBQaqmTt/RpsEx8IcxuQsB909os8EhYDrORzCzW2QCfzP8ABNa6dtRW3u4
         hA3l1WJTgVckMf4d0HmCf3kdA0BrRJqCniiBOUtTfc9jp2/C5EWJQ0qu5pkzvu2jb7FR
         0Jbw==
X-Gm-Message-State: AOJu0YzjczIrlCXbMFWEZBmocOYJYTdTS2RcBauN+MPzVuUgwUku1Z+z
	9hct4ARmMrZul+KH5pdU3RLgf5A5yOlpBHkYRuU/1xTXfQpMv4qPSe83AyWM2w==
X-Gm-Gg: ASbGncvvqEjYAu2D/V8wIDsoff2Xcy51ctHRY0gG0TNW1G55zq/iHB5xyATBWVnK0kO
	p48Z4cuL8KyjIv6gdO069Xme4jQh8zNRLJaoZGhkqxs+Dp51PH1LwyAhW2JkqQC0fUClMQJ92en
	LxxVbnZetjYCoM1JtiwRhMox1ZK4D8p2upNAl7Ax28+wLcwLnq3mVhJdcRjhz1+h3kuAFpu+ebx
	vnXkGRlmrvZpZX6nHh/OWdNff4Dw9KqNFkaDYR+P+Ega2ZMbkgNpoxDvhXqrt4+7Z6cCmt8uhlC
	P4A9k8RxMcNVp/ySY1mhvnLXtZP/LWS8RPQSecTwj5gzs0rp+4GbkD397QiVbTz0KWsGHtnqYe7
	TZMD9CzVn5UkIyD/hMoc14zOoTRk=
X-Google-Smtp-Source: AGHT+IHx+C1eRjg3FhGGeHCayx/A6Gq7lGGfsNY+61BWFUuHS3tnHa8W7OskdLssGhGDhP0pe8RylA==
X-Received: by 2002:a17:90b:58ed:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-318c8eb9aa8mr28855701a91.2.1751389714685;
        Tue, 01 Jul 2025 10:08:34 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-318c14fd0d3sm12485189a91.36.2025.07.01.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:08:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via
 '--skip-until'
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	(Karthik Nayak's message of "Tue, 01 Jul 2025 17:03:26 +0200")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
Date: Tue, 01 Jul 2025 10:08:33 -0700
Message-ID: <xmqqfrffltym.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The `git-for-each-ref(1)` command is used to iterate over references
> present in a repository. In large repositories with millions of
> references, it would be optimal to paginate this output such that we
> can start iteration from a given reference.

I haven't looked at the patches, but should the end-user's mental
model of the process be like this?

 - We have a native order in which references are sorted and that is
   what "git for-each-ref" without "--sort" option gives them.

 - They can use the "--skip-until" option to seek in the above order
   and start iterating in the middle.

 - If they give "--sort", the set of refs to be shown would not
   change; skipping is done in the native order and then the
   remainder is given sorted.

Please make sure that the documentation is clear enough to avoid a
misunderstanding that this feature would kick in after we grab all
refs and sort them.  If it worked that way, it would allow us to say
"going from newer to older, but skipping the most recent ones that
were touched within a week", which would have been nice, but that is
not what we are doing with this feature---I think it is OK but we
need to be clear about it in the documentation.

> This series adds a '--skip-until' option in 'git-for-each-ref(1)'. When
> used, the reference iteration seeks to the first matching reference and
> iterates from there onward.

OK.  Even the filesystem backed ones we internall sort after doing
readdir() loop, so this is feasible.  Nice.

> Initally I was also planning to cleanup all the `refs_for_each...()`
> functions in 'refs.h' by simply using the iterator, but this bloated the
> series. So I've left that for another day.

OK.
