Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D61DE2B9
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400960; cv=none; b=ViXtZPdCkmUc6xbF8XxGvOov+28HzO7w0GxrjOmx+VKsSIEIro++zHCHnuNqRViUJ8ZLgHiTT7Pc0zga7gdWZguFXzL5Kr1kRup0HgVYjjQWQbMWqImRgOThyuNTx4wYhTiqRkc0RKuzWlNKYOaXSh7K2uTD0SK7HfKlg3JRsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400960; c=relaxed/simple;
	bh=So3AHXuSsRc+82zMcjSnvEeUmO7s/VeJRyFlnyYOJ0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiPRLe/0m77tvMeVkw2yXWIoT1+nvNSfVNk1ziNDiq+waLRy/Gbz9WU5s8XLEJWsYtUtxN8zBl8TCqb+8+/LqvSI6rv7YVlGRfkifs1skmrquuL6Bi8EJAFstuiRaj/LuczRLIXrL7uOohDjFKRiURyrvnH7WxvZni44RW/bQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ireMPen2; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ireMPen2"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85da5a36679so644918439f.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400958; x=1743005758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So3AHXuSsRc+82zMcjSnvEeUmO7s/VeJRyFlnyYOJ0s=;
        b=ireMPen2r4BPc7d0caY051FnCfK0f9dOkhMyaQ9Z0nRZ8LyXFMr/nN9DxkKolo9JvZ
         OwTUof18sICd4F/Io2mOjEkGgmvPPll7Gw9rhwe0c7mGSGJvoQb2Y0WTpeaFQQDjHKbB
         TNS5L0r8C0d8b4wBjrsQjs4eOXrViBiY6QfiWOOZeUct0Dk/rPMlht28x/zqwDdmZOgV
         MCPIrzYZrfzErTzrvSfdXaY+T12BWrp0YVQJj3isSRRYu6b23F44H19fS0rwPmbGdFOB
         zXDEmToMGs9uusr2uW6oRBkjjvzU+ndLckACBzepvR0Q9GLu62EKv9xRVtSvWu/nfCVb
         Bb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400958; x=1743005758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=So3AHXuSsRc+82zMcjSnvEeUmO7s/VeJRyFlnyYOJ0s=;
        b=JIWjnG6ftiA8OIjAvrVyhKTEUJNdRWouars/ziFrEtPI7P6J67iz4BFcYGVquOeZKF
         zB26wLwruXreCOz/rwLXZzRm3etlCvpAwpGz33E4FiKrgybaTteB6lv5xuH9w4LRhBUv
         LmqtZCqTAeMnRaaI4K764Mo1k3vZoMDqfkYDQr1k50/K1umceh2yS1u145wrv4v6MldR
         t/izYCdbGKmqNq70xFeLey1HkXnOBA3sJ/Tdf5pwY/H0zZzguKj670bH8b/EC7s5Wjk4
         EVwN8AceI+LpEfAWFqI7hoEvGoQJ5hRhOq0Wd2iiFibRe2P1AB1oaLdNewB9OEiZ4JnK
         iMMA==
X-Forwarded-Encrypted: i=1; AJvYcCXltOXdj1QFkJwWNGGB2poCKnhvdxW0iGYa0H3dFgmw8BO4l6VJdDCvtov17WRfSVUELWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEGr3jUkKqW0VQwveuAf++Jl3XGqX0DhOh7IrNm24nrDpsze+
	zkx9RRZcfksJN5CxvGW/uYjtnYmqOqgGHc1m+BHOf2hZoSDQEsWnQ9Qn7prRRuhXJ8fZXyBF5BQ
	4j9eTM1YimIGL+DAffOWFPjsnB8w=
X-Gm-Gg: ASbGncuG2gckTqCkjoEPEgTKUD9u9WCVIW3jR0RtdnEnj84Wkr1u8cGXZBrAxzmj5Yu
	YVQVDfq4OWtoPk6tHedITMnpXYRl72eY+Uov2P4cYXdJyZaVRfwEIDLLNMUQljwXEATcGRMfvie
	rJYeZ5QXWT6js4gyNdqr45H6nuuAvI
X-Google-Smtp-Source: AGHT+IHgq1oU0E8gdGf4fyUD8twuyjJfh7VcFvL+9p3BmAVlHgfrdBfCX/kBO/915d7kf5+Xw57dCOAWV9jBqKr4QBI=
X-Received: by 2002:a05:6e02:1b0c:b0:3d0:19c6:c9e1 with SMTP id
 e9e14a558f8ab-3d586b5a5e6mr33504095ab.13.1742400957574; Wed, 19 Mar 2025
 09:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742336481.git.me@ttaylorr.com> <d84041580895a653648ee2370e21d7d2aa4fc4bb.1742336481.git.me@ttaylorr.com>
 <Z9rqMxlt1F7lbGk7@pks.im>
In-Reply-To: <Z9rqMxlt1F7lbGk7@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 09:15:45 -0700
X-Gm-Features: AQ5f1JrieGYhVxYdlP1-z37h6dgvdRSZlweLM0VwPd9lJz8rHn6dMjZrqwub3s8
Message-ID: <CABPp-BHsaELBSV-mB=h2e2YY9NQvLfV5fU2XTmOsPSsub-HT8A@mail.gmail.com>
Subject: Re: [PATCH 3/3] http.c: allow custom TCP keepalive behavior via config
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 9:00=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Mar 18, 2025 at 06:21:41PM -0400, Taylor Blau wrote:
> > curl supports a few options to control when and how often it should
> > instruct the OS to send TCP keepalives, like KEEPIDLE, KEEPINTVL, and
> > KEEPCNT. Until this point, there hasn't been a way for users to change
> > what values are used for these options, forcing them to rely on curl's
> > defaults.
> >
> > But we do unconditionally enable TCP keepalives without giving users an
> > ability to tweak any fine-grained parameters. Ordinarily this isn't a
> > problem, particularly for users that have fast-enough connections,
> > and/or are talking to a server that has generous or nonexistent
> > thresholds for killing a connection it hasn't heard from in a while.
> >
> > But it can present a problem when one or both of those assumptions fail=
.
> > For instance, I can reliably get an in-progress clone to be killed from
> > the remote end when cloning from some forges while using trickle to
> > limit my clone's bandwidth.
>
> Does this mean that our defaults are insufficient, as well? It's nice to
> add a way to adapt those settings for the future, but ideally no user
> should ever have to manually tweak them and Git should work out of the
> box.

Was going to comment with the same question.
