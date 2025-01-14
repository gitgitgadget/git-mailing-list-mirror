Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F45258
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736831824; cv=none; b=TN1+zMp52kzffHLdOh40xjhfBPwTdfL6DK/PqXwcYX8ZSn6TEU2fHVXGu4+eI9OuoJqnTZCihwn3gWscmeikk015dKOBO5RiiQ1ToiofL1wfzYvqhmpXHhH62Eze0v2Ar69DlE32APHzuQonJKo+BU7nTqYuhlmuovcHA44m3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736831824; c=relaxed/simple;
	bh=UDhVDKn4ToIG2XrBY3NutXJr/03fjmLFKulnz/30iDA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BcFIfLpnaVulCzQPGSyJUgKjN5DIGQRFExJ5yifo9mK4xMG2HQhoiI5CeZOGl/4pYofI8GFJY/UuExxSeqWnLDuovGfFyYGv4NEWBxdwr/DTcwtsGjsn2KzAeJVptYtQhnMGm7YHxWStD4NEAEIIGcdOOs/AnNqFktzxOQP2voA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdmANZVJ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdmANZVJ"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so8549990276.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 21:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736831822; x=1737436622; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UDhVDKn4ToIG2XrBY3NutXJr/03fjmLFKulnz/30iDA=;
        b=RdmANZVJzGmf4Z++l9UPzbgu6Xl/l5V9KKxNZJ3an25QPYe7sb1t6TXMTOR6zchOXa
         fVjYLHKwi6tzLf9h3WrmYhdKRg+RQGqecXYfoDu6kJ8T+9dXLhBPjgGR+qvKxzIhR3dc
         e+E/pCgQKuCBlSgyLtX3Xp0oo86I/ZD7tO6Nk+qcbsIlxRt0OJplQEiuedHr1p9eZsrC
         y1l9K8CBeM4xd9DKzb0i5hJBgSfS7lxybnS/z4vQuTx5L0zRPYBIWazyHTUR3u9+5BQa
         w/afLN871aOTlsIC6n0HK/4eG1tXYV7/id9Ods1MvJF5iV9SNzMZ8ln4slqDbxhywFxy
         0o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736831822; x=1737436622;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDhVDKn4ToIG2XrBY3NutXJr/03fjmLFKulnz/30iDA=;
        b=WsfZoBXu09JAFBjgx3BOQpyMKGVftcH9rSDgODEfK9z5bYQtf40glL1YLU2SrbtuD2
         pvl1wMkgRnbAy72y6Sy1uIqAE1UHBMxDF1BHxk3ceRZ1M6TjYu0X7SNpEHcEv8EoeZyS
         fiyVuab1o3TCoFsVur+0pCmGvX1BDboTcUEQeLLnsm5xdCM7CrsUecM5oh7CclPuaAS/
         /Rg9p3UEMbTjJEjpN4+I7lyzgc1E3Q4cJZTvoTyklyA5YdqBLQlRIwGUVnAWc2PnLsyu
         vja8VXtc6EERhbLab2XgI3j1vrXX3oFcNl9TUtPzTX0UZKfV6YTa3oDC7x1RcGERly4f
         Je5Q==
X-Gm-Message-State: AOJu0YwLUlzxY+lLoY+jTqSI7BQ58RthycEIRjn3xLzh78UzQT0Cb2On
	Ex5ukvRirYjlErG764C1kFDd8TuaB1GndhBi5ms2N1msKOw00l8KhCTbaB2GvjLAl4Xgl67s2nc
	BJHh2VaSQw6Uxs5N1IN/SuQw03WQsyJvu5p8=
X-Gm-Gg: ASbGncvzmcsFNW18xBh3pO6nXeDx5Jqe/gtItZ6MG5796A4I8emZ1CIOWO6G5wGu8pC
	qLS1911GRqRPTmCG0nZz31SDm+xqeG/hYl5Ez2w==
X-Google-Smtp-Source: AGHT+IFexHEV6H2n4dIQTV+HNQc//aZLgp9ZhlV7zZcIdeXJjavbrpSg22dwezZtWN0NSVQGr5uMf8XGNq0lYDErLVw=
X-Received: by 2002:a05:690c:387:b0:6ef:c688:1b8d with SMTP id
 00721157ae682-6f5312246f8mr224030427b3.6.1736831822318; Mon, 13 Jan 2025
 21:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Josh Bleecher Snyder <josharian@gmail.com>
Date: Mon, 13 Jan 2025 21:16:26 -0800
X-Gm-Features: AbW1kvbAGR6fgrbiK65tQbW1QFNPhQzEp6dun-6CE0W0tjD2gQSf6-TjdDbT7-c
Message-ID: <CAFAcib9rWO8WFmaAwf+1Ng85+N7O3Y=QM6wG5xEz0r4tGXJ8TQ@mail.gmail.com>
Subject: Should 'git replace' respect GIT_NAMESPACE?
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I was hoping it would, so I could have different replacements in
different namespaces, but it doesn't look like it does as of ~now:


$ git version
git version 2.47.1

$ GIT_NAMESPACE=foo git replace
751eeb3b4d23c7fbde919aedde8c091f04f4f819
a9dfd084086ee4d6bf00a33b0976f28c0997457e

$ git rev-parse refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819
a9dfd084086ee4d6bf00a33b0976f28c0997457e

$ git rev-parse
refs/namespaces/foo/refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819
refs/namespaces/foo/refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819
fatal: ambiguous argument
'refs/namespaces/foo/refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819':
unknown revision or path not in the working tree.

$ git log -n 1 --oneline 751eeb3b4d23c7fbde919aedde8c091f04f4f819
751eeb3 (replaced) add go.mod

$ GIT_NAMESPACE=foo git log -n 1 --oneline
751eeb3b4d23c7fbde919aedde8c091f04f4f819
751eeb3 (replaced) add go.mod


Is this a bug in which case I might hope for a fix, or is it working
as intended?

-josh
