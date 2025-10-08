Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE7298991
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759888343; cv=none; b=GxGdPBnFt0qK6xufR6Es04GzeFrQhYp+gfg4LOzwFJfZVpQaW1/8zQFa/zrAt0/awnxqhiE6ec4SJjFhW6/An3//1dOhuK4TfanLZ53gPShAyQM0+GRHyADYo3qygfleORvoKZqxC3gfHBabtQHpdg29IQZVkHUGCbxJ4YAwDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759888343; c=relaxed/simple;
	bh=74J+LTV2sbb1rJY2oTXKZAfSZ1MC54D8lZihu/c1qAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKJIZhBisJp5SjBZuyxtmD6FjoHmx+55ScH2kT89eXAbZNKutmexgQyqueC494dZD9S956mM0nAZgoQMMySdrSNhFPO3/zqHlfFuk2UYKeXTvxDDZKExhlC6+0LfiCNSaP/c3ECpKeluZsggNK6BprCzKKhAs/PUrJuS8YGmHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs2T3M4s; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs2T3M4s"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so101513855ad.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 18:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759888342; x=1760493142; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2eSgTaCcCzy+wcz74VXAiQ6Uo5PMxL+b3ukglTUklA=;
        b=Cs2T3M4sHvG4rmjqRtcFQB6dZ932dhzkKChd+NUuNOwh7PdYc3IzMS6DRd0LKxNf8E
         mWE/guB3rsjz1b+iPuFlrQNU/8tDCVn6VgNzU42vSUUf5qjAkRcGzXqRWS4KPuXbuhnC
         FgTd58IGmx9pCq4mC3nPZlrQ0dIQAV+7wLQVbEhITg3JoymTMdafwnsmNjubza5OitRA
         mxQddmxmYfTjui9oq4ktU2rYa9oA3k8qJpiW1M3iV3KdQgT9Kri4KfUDnIQeggaFMzlA
         hL7K3P8m4+x5ah1oIo7kLjQa6cbn8c/Xq4tQSpaRnsw6Jt3UaxfUxIhpm8HRQKDnG2nM
         Cxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759888342; x=1760493142;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2eSgTaCcCzy+wcz74VXAiQ6Uo5PMxL+b3ukglTUklA=;
        b=wTJ8r8+xkbA+BwJ9MGlMHJ5WksIuwgZ8cHbD5dfDViAwc9RJjs74veYiv5W4lKJy16
         y76Fi7RnkidPVoyvDcMqznhR0YatmsbPk98ZR6s/LjpYSwPutnw1vCRQg1QTe3md3JrS
         kTFeGcjIgAoUr1I8glPZvBKGt3uYw9eC0jGts5RNHPb9nQwI4LeYeRjuncgZ+2r2r1GD
         PRfZF857LqABZMjzXwAal0/AiYcP9YjmMtiG3mf5l/UOagJXKDybKyeyV5b2nmU3w/q/
         2h+Un+fT2Ds+VIvLcWG2ZvcMbDskpTdDL6KPICm347vBi4Nr8stGRimJ4RSWMgkH+PQW
         mc7w==
X-Forwarded-Encrypted: i=1; AJvYcCWpVJq+oxIxb8kwBmLHt3XfbJDCPxp0WpHW6bTJ1f1G254uxkcA6l5j55lKzuq66f7zQhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiCQaDuxgbPBID0cSfpEfEocNjtP+0Cedz3OCIUpD0L7vZDyc
	z6pKe+AsDQQuiy4C1V3fciiF+EaDknrSjMIvnhjNiOV+Jt299RH/m3IV
X-Gm-Gg: ASbGnctI4R3L4bSs/hXPA+jEZ/hkKDMsvUaz532Mh1J7RiRJAY/tn8Jthqbx/eeEuOx
	KEGqPtIUmhV7CjCMgBXmzlf6+pg+GVLOYR7F46QUnyavR4OsfULxGrb+Q/dZPBcK15OcvkTygLY
	ffcMSuoQqKebmdL4ZRdqHPJBo8lhjTDkFEqBSeGjm5FjLhhVSqu1MzQpwE+mEig1cGTm3z0DJvZ
	/roBbZx+KOs9A3PRdPXVNpqrbnWZXjYGWQmCBeKoWny2UIx5y4SXVhvcd5BegHOtYniQx5xKWx6
	NdRSZJRujNgvDdfsH7tthfvm0NCHgcZFQefAA/UTvBloQe4jzQ42horS4YIk05kf2dObWXDGnG7
	PHyYGD5ENyqKwnIAMpjQEg2COkbFR
X-Google-Smtp-Source: AGHT+IHFf7+kzAwsTMpCpYyPertPMX2eHFsUSDeYe3LA/TEr5YF+cVoH9Xb0CDvv8SlWlwp2xoz3/Q==
X-Received: by 2002:a17:902:ccc4:b0:250:bd52:4cdb with SMTP id d9443c01a7336-290272c1971mr19702425ad.32.1759888341566;
        Tue, 07 Oct 2025 18:52:21 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::55b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba184sm179913125ad.89.2025.10.07.18.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 18:52:21 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 0/4] enhance string-list API to fix sign compare
 warnings
In-Reply-To: <xmqq1pnfof71.fsf@gitster.g>
References: <aMp8yNFiXDyk2hP4@ArchLinux> <aONhmrE0otiyZ16f@ArchLinux>
	<xmqq1pnfof71.fsf@gitster.g>
Date: Tue, 07 Oct 2025 18:52:20 -0700
Message-ID: <87frbudusr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  I didn't see anything glaringly wrong in this round.
>
> Shall we mark the topic for 'next' now?

These look good to me if you want to add:

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

I wrote a bit about the signed vs. unsigned integer for object/indexes
in another mail. Because of my opinion on that, I usually just ignore
these warnings. But my impression is that my opinion is in the minority
regarding that. :)

Collin
