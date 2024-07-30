Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B318A92F
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353611; cv=none; b=rWKIpohdYwy238a8MdQnRSZy4ivsd2ivP8eG9XiujFQHEjVda8i+KJ/vk5v5I3na6BKKFltVfwsUcaDdty6j0gTsQlhhUquJ0ZIEWkgIwwqptSXz0PgafThBLZyoQTyhN11bCygLuptxzH+4LvgVvfWOIVft0aGrKyx9PsfcrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353611; c=relaxed/simple;
	bh=A3NmIT8zLj77M3KwYzjz6PUzYqo/aA4ByH+E+LuzHEs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fWcCK8+yBoxd2zNcHIITHoyCmpokupoNcYerCJzyUppL+TeeouY7OJpn/7Q6TrZFGvU7VcG9jOV29awfve8kz1iKo3H8uRNuLc9Pd0NU01c4EXSyiLVkc7ARRwfLIiHxaxSW0aMMGt0NXBGiqsS7ibKCJAeykYQu7M3yWDZpLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kcl12pDh; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kcl12pDh"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0875778facso3145110276.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722353608; x=1722958408; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8nLMMo6k7b8uSKeVhx3XX86CFAdpNiwHVJK9D4Cy44=;
        b=kcl12pDhNUW15rq2pr04U0jqWkeTCp9OPQSJ5DtwVb8o+8ytDHgaMY5PlMKPYdZXtZ
         7Pwx5ua4MpG1ze6LrY+ziyRI5HCViXmMeSvwaHbyuWJNMa4QmEOo1QXTA+UCYfrGaVP0
         M6DGtjyIabrrEVRSqMZkZ5PiB6MNtG0l7XEdRNMaWAR05iqyQwur2DefKlmfOAdI6RJg
         P2IIAtDH9iYewk+ddoxi+VaJbftPvAwKv+aKC2OydsapgkFMpQt60og0YZ2CCcnGz4iP
         ror4eSHhF6833u+wrR5D/Sr6HZ+GtfnsVPMROwWaV4CRxKEVqIhBe6CWlHCq2vKL4no4
         ER4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722353608; x=1722958408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8nLMMo6k7b8uSKeVhx3XX86CFAdpNiwHVJK9D4Cy44=;
        b=LsfLejP0CYjonEZldHNlaRsvNEIHBOoILRNqADOmZgQNZBzTELquUQHM7pjIPDCgHx
         UB2MLeBcbjXIjKZillx3vnQVU3jg6KIj8T1PKHHP8zRLsrNE73tTuZK2AOMTIITShpXg
         rWiM+Kg/ndFF/wWJ4qXC2a+Tlzmx6QSZy+pe+k/+rhQz7SIDps8SNSuOxVBAYAjikRtY
         6AgbUhxlZiW7QyS1o0QZ/5EBbA75+13sCzA4K7a+uXBfljCOhIJqnHtQIK2EutdSvyWt
         /9//KIq6joxW7CXe2ZxYjd8i/mLmORHdKo/ZPEe/4VPJpTDhFHeUgLj1q1DPfVvpOPbu
         MaIw==
X-Gm-Message-State: AOJu0Yyvlir+d9mqzf+WGW31wrjTw0jFGgvnnM82SjOZpcAiRpY4AU/i
	RzaGHDstiKE3BGfxjpNnokJlzBpra4qUHfDahSk3QqDpjhTJ6qTVy72AjbIB12i/OvVHZsuQBz+
	P
X-Google-Smtp-Source: AGHT+IE+XSoTlxvHjdNRLHkbrMLjy5yV/To8QP6DvcSsXf/urZFJobsnglhoJrogWzqWpDgEKGvv9w==
X-Received: by 2002:a0d:f8c3:0:b0:631:43e1:6b99 with SMTP id 00721157ae682-67a06727c1emr137461987b3.12.1722353608035;
        Tue, 30 Jul 2024 08:33:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd90dcsm26052907b3.1.2024.07.30.08.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:33:27 -0700 (PDT)
Date: Tue, 30 Jul 2024 11:33:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>
Subject: [ANNOUNCE] Git Merge 2024 CFP deadline extended
Message-ID: <ZqkHxvDx7dlh0RX6@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I wanted to share an update that the Git Merge 2024 CFP deadline has
been extended by a week from August 1 to August 8. You can apply by
visiting the main Git Merge website here:

  https://git-merge.com/

, or see more details from the original announcement[1].

We've already received a number of great submissions. If you have a
great idea that you have yet to submit, hopefully you have a few extra
days to do so!

See you in Berlin!

Thanks,
Scott Chacon (GitButler)
Taylor Blau (GitHub)

[1]: https://lore.kernel.org/git/ZpU0WwsrXCF8BC1f@nand.local/
