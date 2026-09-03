Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37350EBF1
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465634; cv=none; b=fx6gy1GZf9LIC8/2liQhgg9Lqxuvk8VmvamWGjvVllFIWDlEii2I6j2IF6VQfz3WdytUeYhvSZ8kRzoQcsh3fPlUWBtjZrYviTsl3aDl/3lZ+Np0tKlIifK/djPrHPWWu+UQIu6z8n8SoLPEpizbtoUOwfrtpY6LeuYC+KfvzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465634; c=relaxed/simple;
	bh=02ipsiFoC4zjbT4wi22fIGEZLDWLOFdrTk/GhcgpRwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZRR5G5dViK4DcluQvDtbKphUQcEBLjn8Qv7wpEySQYsXxYmKAdUi0AVQJOOGItftfS+eYNw8aRyE3nvec/AbTBKziWclPba/l+AWf/3havstQD7K9DDi+P9LB9h878L5Cr1QodnYrX8rIG9Y/c9y8fhVANejfYkQnMJS9PG+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=UEbczK7X; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="UEbczK7X"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so3254995e9.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788465615; x=1789070415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqis/ykxL0kyxPXkQ2c+UUXHI1mOriW5bYBvfpE7nMk=;
        b=UEbczK7XSkiZBpDiFFBJIOGap+rBTUVg92xFRfOB5dVXuDmRR7yR0WppEO5ictAjCU
         JuXgSmYnQCX9C5+bEWJgRm6JCw5fI11Lad8HnO3/f4tzkIfgTlsDOr5g8Gotgp+2uPFh
         aTPfAr5RSV6yNYmXHTNy84Eccks+gT80ik24lhCfQBdY0jB7CufeVhQnSkIceAi7+tQV
         yjbSQJ8MBiIrXxxqXxf67BVVXwAGi1XyQIVwS3YMTvO4zDmkgcBUodxJ5tWluTwH/RyQ
         5laZ6DCRq8mttGLSntOukleV6ZR/LD3wZm9FWTNSVJOT8xsLX4Z4rS1n4BbA5q0fhfXh
         y7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788465615; x=1789070415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eqis/ykxL0kyxPXkQ2c+UUXHI1mOriW5bYBvfpE7nMk=;
        b=C5X3fAx9WfUo9+VzdRJA1b3D2N+NFeGg3USusMUICdCHhpB1YS5E3nLK1hrypJRwyB
         ifC0WRAlHVmZoLSSawgFR5kXtHsDY3iNWC1rs/1vs0asKjyKb31SakJhhqFkmxemiO5K
         tFV3Ne4+kA10OaK6GS8mToNmfAlBrHHJDlkHjsbm84ADz3s/7fZg8r1N8oP/9wGZDV5n
         av0z/fV48qLz5IY5eIDnIGLyE0q7U+0MN+88p0mvyaAySp6QeT+RgjrRUVjasRsQsV6O
         kTtq1L0q9GhXXMrWh7BuwXcoILvBGx5EZLNEzcvXQ/OGn6wJy2L9evVxId91HBDp0iJG
         r3uA==
X-Gm-Message-State: AFuF++klTqK2YSpIRPATtZ7BYVtyE0xQulT1lPEYFHGlxt5ATek4jF0w
	rN/4rGF56iIf3dPtExnt42MhHbPUWinH5lQXuvu8blt0bud4Ek6EihTs1KivDwFf7ts7Zlyebjm
	shR6pym+Rww==
X-Gm-Gg: AYBFou1Nv+VIPcGrJ9YV6zdYuB5ecXFKvdUs32YrRLogDcTI7RrPLDXQrLy82de4HKG
	/Ygv4Vr89oKOOKtjc+3mnTHM7JmOeNCG10aPJf11pw0E9ngeSh4uQvgWigaBZeCEgMEyI3eozCb
	EaCF1d0z+soEjKP9G6HWIksoGJwoSjGUhzLTOEjkxbdnjFQboVFbUELaV1X9Oz1ucajidICTiz+
	vqNgCZMHtswTeqtFwx0L0LXS9saa0yFy1TcvQagDgqeLcU8m0755eZ+Cyf0gjBs976ruAZUKr4T
	v+QAdsGqhymaWZEjI3z1zPm0CY9qzghwolPweytmVAiZd2O0mLsFHjPgjdGXD8zOzIQuxsyVlej
	UMtu+gOWjldgNu9iQ00NrNYgZDqVXN9aDG864I2jO4YlwtgzanxFcax32SRCcuS7eDMiMDntERd
	uGhKbwxTT2F+6/iqA5RdnQyuSlYvEtTQg5LYHfsKwoRm55a1+AhI7vR43KNL/N3NDWL5ZN77afO
	DiApwU=
X-Received: by 2002:a05:600d:8498:20b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-49cf828c65amr4420765e9.16.1788465615447;
        Thu, 03 Sep 2026 13:00:15 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5927b68sm151168935e9.1.2026.09.03.13.00.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 13:00:15 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] technical/partial-clone: narrow the one-at-a-time fetch limitation
Date: Thu,  3 Sep 2026 23:00:13 +0300
Message-ID: <20260903200013.36820-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CABPp-BGW4XBB6+2X=02ZDcXo2bz3iZ7D-30w_cV_51mD7j7htw@mail.gmail.com>
References: <20260903125531.68044-1-f@lex.la> <CABPp-BGW4XBB6+2X=02ZDcXo2bz3iZ7D-30w_cV_51mD7j7htw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:
> Maybe ask your LLM to make this cover letter more pithy?  It's unfair
> to request humans to read voluminous and likely irrelevant LLM output

Sorry about the wall of text under the scissors. I do write these through
a model since English is not my first language and it reads better that
way, but the length was my own doing. The model did not run off, I piled
the context in on purpose. Won't do it again, I'll keep the notes short.
