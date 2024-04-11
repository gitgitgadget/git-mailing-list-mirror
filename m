Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C35027F
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859269; cv=none; b=RsH8oS7ubX1ltatOIR1BWnVqmThtgMsGqVh0UQ5Ri6yLgnM0SHsk91dTHQm2huuJO6L35pFdnGYSBaW2e2KbAEGrUy8baUhpmaQcGfuUMucpL6qQaaqDqd7QJAQFr9zEeyton0zYLUK/WdNde7DQH0qa6SQ0pw6V6/A7LPyR+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859269; c=relaxed/simple;
	bh=yT7tyPKhFkW5iHnibO/kw9SqpjiUlEMVpYzK4UCC2vI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eLhMA568WcqD/k3zSeg+BcrrejEBupgtPPi2NcHL88ln5KTxuqeQ2eF7jZsdr0lgZTfgeDeijwu/7qgRrEzm1csrwgM6JnF6wohOxorI81cGKEzHZkMA6yylBz+JAkFvJx/JaIzyJg/MMcyM5XO1sX18ibdmoO/0BXjc97WCwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCftEKpE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCftEKpE"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd169dd4183so120817276.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712859267; x=1713464067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3s45LmLiv26bdVvhTyRJs4/fkDnA56THk9sOq/1YH2k=;
        b=ZCftEKpEohHu+C7hwdM6z+9fo5+3Zs77/i7ncRHuGwFFwnaWcQoeDBOI0SNSwZkAPj
         aEE8fAml6nvuIh06EBSZZljIvoMLTsrZI1ZEv1V48RYpaDOV5Qu362x3mmk8ROawNSmx
         oaAI0Idr8Be3QQr0WA7kj8BUxpKB7MaqXB1bR/8z5lBGulcggLKZdN0vSkOgg/MLpN3i
         tO40RBf9uwH3bSOLet5fyAjwsV+bHrA82bIopodMooTDpK9Y94phmkS/aw9MZ5aaZF9C
         wpPgc4n3Go6yPkUGwz9YiCKJDd9tQWK3fn4Y39RHue3FDn/yy3F9PlmA0v0/By0bSqOg
         H/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859267; x=1713464067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3s45LmLiv26bdVvhTyRJs4/fkDnA56THk9sOq/1YH2k=;
        b=msgipxkRyfA8D7k03twxS5PpLVOEmPJj071HEZIEB8lSAKk/dyOJHb/Ne/61G/P8UZ
         yzxe9Q4pvqZ7DVWKNgNimG9b7a59W94xeTlo3/zwy0NVUH68Rramk9b5h4SSNubVsBul
         q9oAgHSH5B1INmZOwtrusTW1LVD/EXSdsov5+4f4sD/vqcpuDyA2NOzgoODmVaUJLUUY
         YWpuPjCgdaXNhX7P98JQxndR1Ff5jR0h3LlXgIHNfrhTMQpYoUmwpEjYiVuA86f8uEsK
         j22+dpLPOkxIUQNmR/zqevFymbh9N+ZPZepqbma/cW+2H5ctRi9dmCj051iwmlqrfcHM
         EDqg==
X-Gm-Message-State: AOJu0Yy1ESEFczUJV2qNtQ22MFb4rQRCsNbM7/kznqmj1YYOLNlAtwld
	Lcpe+tB0vV/zOafH/aQL/t//f9Cj8rvACCERGUdXoavfilHLo6Y5gLOYXyfgZWw7QYztZsoF2Ib
	/Eje56Cm4LwpgtsI6i9BnT/efZhHt1Z7arzbROlNwOz3WmqvlUhLKypOahLYxikYoVfXIhmSciz
	XmyE8sVOvZTeAJ4mMR3H3523I6gW76yQFfULsiaYI=
X-Google-Smtp-Source: AGHT+IGbjOQM3nrSjtiki1cwOkTmFs2HOKEfVpHlCD4GvA/60GjYWtenzcmFnqC2NLDDoxu0gxwSKIMi+y/7pg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5d8a:5a85:8673:4f76])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1247:b0:dda:c565:1025 with SMTP
 id t7-20020a056902124700b00ddac5651025mr37805ybu.2.1712859267065; Thu, 11 Apr
 2024 11:14:27 -0700 (PDT)
Date: Thu, 11 Apr 2024 11:14:23 -0700
In-Reply-To: <cover.1709673020.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709673020.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <cover.1712858920.git.steadmon@google.com>
Subject: [PATCH v2 0/2] fuzz: build fuzzers by default on Linux
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

Please note: this has been rebased onto the current 'master' [436d4e5b14
(The seventeenth batch, 2024-04-10)] in order to resolve a conflict with
the recently merged bt/fuzz-config-parse series.

Increase our protection against fuzzer bit-rot by making sure we can
link the fuzz test executables on Linux. Patch 1 is a small CI config
improvement to fix compiler feature detection. Patch 2 is the Makefile /
config.mak.uname change to add the executables to `make all` on Linux.

Changes in V2:
* Rebased onto master
* Fixed compiler mismatch issue when we override CC but not CXX
* Consolidated some of the fuzzer Makefile definitions in one location


Josh Steadmon (2):
  ci: also define CXX environment variable
  fuzz: link fuzz programs with `make all` on Linux

 .github/workflows/main.yml          | 12 +++++++
 Makefile                            | 51 +++++++++++++++++------------
 ci/run-build-and-minimal-fuzzers.sh |  2 +-
 config.mak.uname                    |  1 +
 4 files changed, 44 insertions(+), 22 deletions(-)

Range-diff against v1:
1:  75f98cbf98 ! 1:  e55b691272 ci: also define CXX environment variable
    @@ Commit message
         'detect-compiler' script only looks at CC. Fix the issue by always
         setting CXX to match CC in our CI config.
     
    -    We only plan on building fuzzers on Linux, so none of the other CI
    -    configs need a similar adjustment.
    +    We only plan on building fuzzers on Linux with the next patch, so for
    +    now, only adjust configuration for the Linux CI jobs.
     
     
2:  eef15e3d3d < -:  ---------- fuzz: link fuzz programs with `make all` on Linux
-:  ---------- > 2:  8846a7766a fuzz: link fuzz programs with `make all` on Linux

base-commit: 436d4e5b14df49870a897f64fe92c0ddc7017e4c
-- 
2.44.0.683.g7961c838ac-goog

