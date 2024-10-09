Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F8192B70
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478275; cv=none; b=ZfZ4Cl+WzyxXxEPM5HqvJexmZu6t5AbLz7h+Jce7hPa/xMTpD3qhlZQT16ZrM0PifSh3T2Se2+efx3wckVuHY7BMhPOTZkdSVqa8xehK4cgJDxbSmSlpTotleigabPGQmtP/eNn3Nu185OxXKqIlL5rchONcLt/Sx4xs/LMhD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478275; c=relaxed/simple;
	bh=xWIiwQmgeNwDFsQq1BnBgnLqaFY0a6MUqzluqC7MpOY=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=r3ca7i3M+tCF+Nj67OnS6u+RwUw0J5FiQEmxfONSMoq8mSeY61I3OKFEvPztDINxK3QjiTmN+/pvfGm95KrbUsHHMzMdGBK53ZQTmt8cdrAbO3XNpH4xmGowU0tthdU/8hKa7kqEUAUO+ywXgsZ//Gyk6zuODickzUPgCS9q9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evxks+8f; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evxks+8f"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84fcb49691fso524241.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728478272; x=1729083072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bjattTa6KPj97/o2NeRAmLkSJ1ZIhyb7OXgk3UWUOX4=;
        b=Evxks+8fx47LdEPSsr2/6nBWeWUzIIyTHWTPASzJgabf3mdOi+Y3dLCGomjqzfF+pL
         dpt/sRCkq9mzDp+Pq59KKWgIvvYuIiNqhB/jfuNnagrakoxt4rgyuGrR2M3AvQKngEEk
         kAjxrECNujCMYx6KfpW/+IodlCNwrJaind5IPMctJw1i7sQrPAb/x/kwMqEOBsSEg4kN
         nyxcatllTEOEMOz2/muMBkN84s+o0h+Eqhn/gOD/3YuzTq8kFBJbLEtg+JR3t7EyMY99
         4FdmXe2MWMNlpNU2TyS7TOAbzj1V2QT2lbUd4Gl2wJmba8dJnVnXYVRH1/MGuoSVmfJc
         tUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478272; x=1729083072;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjattTa6KPj97/o2NeRAmLkSJ1ZIhyb7OXgk3UWUOX4=;
        b=NWr+asERY7bdSPorJPF0UfJWP38/RWmI8D4UnrX1hjkLDQ5V6A1gcRe+ULAVgGJ3pL
         BJ9aPkHKaJRFNwWw1mOBcp9JFnJCLS3R0p8b29baeTOQqgZ+wIgY3glPXSVHl3I5yvj5
         8K0If2UQbM11dM0OtiR9xsi12csuDCL4f570gOLrKKWbgbdjUGlEXVn2d9ZECm0Bn8Oj
         6K97ChyPDKtDo0MHB3sGFgtvHfWxOah1lUSxmJclQu03NsOutbgfx7Zbea/cGDlShgZ3
         QlFhj2KrfsQSgkpZ8hdeCOLzhEhtla+IzduK27Bg+tjP69BzYfBKQoyEVCTmeQ58DON0
         WbNg==
X-Gm-Message-State: AOJu0Yy0g3HJTOtZrHqGb7YueJux/hRZOcxxrAsVIbe0l6fE0T4+Aiym
	v2X3ecQrZNci2lEpeaPyWI7oVNM/MpCb2KFmghhuw+2WRDItIwyb1BGFn2JgBJ56lFXogHxEEjG
	K4+KaspJDUUcAPBYdOIEKI5pu8TcqwA4f
X-Google-Smtp-Source: AGHT+IF1x4gnHdMg+wHH/Yz8DWLgWXo+we83Kx1GTtIuswAI0OLSxGZmmY47hQERpA6p3HmPcZJ32K1DSZU+qz+VVPc=
X-Received: by 2002:a05:6102:943:b0:4a3:a71d:648d with SMTP id
 ada2fe7eead31-4a448e1e0b1mr2791236137.20.1728478272270; Wed, 09 Oct 2024
 05:51:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Oct 2024 05:51:11 -0700
From: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Oct 2024 05:51:11 -0700
Message-ID: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
Subject: [PATCH 0/3] clang-format: fix rules to make the CI job cleaner
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The clang-format CI job is currently cluttered due to too many errors being
reported. See some of the examples here:

* https://gitlab.com/gitlab-org/git/-/jobs/7854601948
* https://gitlab.com/gitlab-org/git/-/jobs/7843131109

So modify the clang-format with the following changes:
1. Remove the column limit since this is more of a guideline and we always
tend to prefer readability. This is the cause of most of the errors reported
by the tool and should cleanup the reports so we can actually focus on the real
remaining issues.
2. Don't align expressions after linebreaks to ensure that we instead rely on
'ContinuationIndentWidth'. This fix is rather small and ensures that instead of
trying to align wrapped expressions, we follow the indentation width.
3. Align the macro definitions. This is something we follow to keep the macros
readable.

I will still keep monitoring the jobs from time to time to ensure we can fine
tune more as needed, if someone see's something odd, do keep me in the loop.

Thanks

Karthik Nayak (3):
  clang-format: don't enforce the column limit
  clang-format: don't align expressions after linebreaks
  clang-format: align consecutive macro definitions

 .clang-format | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.46.2
