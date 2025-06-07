Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D7171C9
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749279717; cv=none; b=Tuk6lC5+W0I6rJlCKBy11dTSMHsePu9+QMqoR4kyfp0BqHiZG/1MvBEtR+z+HEFUEM+0Yj+JSmrPV+jQ3FmhVjoDxsnKW+AavpPnsZbJze6o/kug0w3ykCYExl10g2M+wWAT8v+u7ZYlmuVP/IDMQLzYjlfbjeSRMrIV1UiDEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749279717; c=relaxed/simple;
	bh=Kgcf0wt/VtaWNLyISLDyRzjt8VBQ5g96alOHBvyftoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+8R+gpof3/HZksT8Cvyjs0kZdZk5E2nUz38XHih+8rl3wMhEztMgmAlfP39vzV9AeG4S2zRGc0toEamd8qMZsYAaIiaGhxQkswLi0NnoTOQlJ8JrjwKr2yNTXubCRRCbp5U1oiEmnA2/H+W7VlTzh4g2HPa5cZFgI/lPhq2ZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnCO4JnF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnCO4JnF"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f6f86580ecso548573a12.1
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749279714; x=1749884514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zy++jWz5Xd/GEwZETntSKLuZJFvEpdswD3Ez4Gdeq+c=;
        b=QnCO4JnFBMl7EhAx2b8BwHKw1JMrdfUdWx9tz0GJ87bknbd+gSuaPAIoP+ZcY9+SjK
         4R0zZxNo+tv7xxcqFTlFGz0yOwYuTL3C+v2LZYSe0Qey4iQhOaN369nly3ETips2VHw7
         4hiZ4WNzrzVDUDKcTXnQJI+v8IWHRNFCeSdSpq/70/cVtwR6us0OC/1jVhCEXgNaEIeg
         AfUWJ8mXR1MViqRMgLeiBCorFBivKJlt4lFTIJGqu0ceAOaWKC+WS7QYfqCv9Q8TAjoZ
         ZF20iIXDsxJYlW1DtWmFwCZ5QOqZriuq6joJ8yX3ldx6uYkw3a3mwvsP3N3xiqjxT0ii
         0tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749279714; x=1749884514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zy++jWz5Xd/GEwZETntSKLuZJFvEpdswD3Ez4Gdeq+c=;
        b=mn/GS1mULHiUTvb989IZXbk4r1vuq1W+bFZVkcWH8lD4HXcwgatvVrMWIrd6BmQ2wd
         yb7zWVMJEwJBNCAzX6WKDC/stFCG7OcQ2uzQgjG9WOMf2ylFPZrgklzkbN93bILP6lje
         W0xKbA5FR8jI3yavtJyX7SJgSVvxxOysdT+57ER+py3QDnaWtp+VaDHoGAdqlP9RLv5W
         1m6Y+h1BRDfHNpwlAi0efcsQKYye5JouGpK1hZO4lkTwlLbdQHUavK8Ut7OrNeiSPJ1m
         oKktqw0+E9wQYrSAhURiUAcWihY59QLw7T11Ap7nDfj+cF0o0jqoUEwCMXOTSc8XT/QX
         GOcw==
X-Forwarded-Encrypted: i=1; AJvYcCV3DHd0fz7VgD+25gMfgSmPnWKwjYaCdvd9741NCCiIkG+x+vrT6Dn79IE8AGV6ufy4KTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKbyofYAv8x+sDhHBdRknAip85X2BQT2V4PkangOJGr3mD+Rz
	q3RLjC91m+q0Xo+BIW1Oyl0iQyqTNkeQo0PGz6hS0i6/udfcO+bHMmIoeert+WfJ9BKWjKrPibR
	k5LsBg4vM9KCobAlPWyPbrS2ne3P+fes=
X-Gm-Gg: ASbGncuC5eJFNW5jtQQ/zQTW9ipbSHuWnf89PEDtJfdbfwJ61B4TBi66WSLHpgzcS3o
	ApzoUCTh2qXvrKoiKWFgXET7n9d2pRQfyIxHhZBgY98Ab2PDGWl5uNczuyQLhYgHfYdAst7wTTj
	woeVwAuyP4qlRtPhu4a7KLeyrZWeniFknmqXfQAgZ4Tu/06LYj/AICdzvJcnRCscXvnha+Isnb
X-Google-Smtp-Source: AGHT+IHVHwiP36MB+PwKUifJhe5u207SZxpav1WAu/VceOyxVuGtRcIm6YRVpjALjDIYkt3GP2W9tPS7xyCdqN4ToKs=
X-Received: by 2002:a17:907:1c89:b0:ad8:8692:9a0e with SMTP id
 a640c23a62f3a-ade22b79aa4mr171805166b.13.1749279713600; Sat, 07 Jun 2025
 00:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqs=kJtPcMrWC8Dayd+VW7BvC1rmzS0zT+EwQXfLOpZ3Tfg@mail.gmail.com>
 <CAGJzqskDumbMSbC3rdYT8fZ8gNJ5MOjR_o8RAo9QS-nuvbBinQ@mail.gmail.com> <xmqqtt4u86x2.fsf@gitster.g>
In-Reply-To: <xmqqtt4u86x2.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sat, 7 Jun 2025 08:00:00 +0100
X-Gm-Features: AX0GCFspBg2GmfBtVkQBUsBBWCLk4H9XmuUlOn7PFETIniM9qI4UdKz2kl6s94U
Message-ID: <CAGJzqsksmQmY4o-_7DoPFK8VP-h59ANUjroVv2+++ZG3gDBdUA@mail.gmail.com>
Subject: Re: Fetch remote only if remote hasn't been fetched recently
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Jun 2025 at 17:55, Junio C Hamano <gitster@pobox.com> wrote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> > Hi. I'd like to fetch from a particular remote, but only if that
> > remote hasn't been fetched in the last hour. How could I achieve this?
> > Is there a relevant option for `git fetch`?
> >
> > https://git-scm.com/docs/git-fetch
>
> "git fetch" is "I want to fetch now".  If you want to pace your
> fetches, you have to keep a record of when you fetched in the past
> and work from there.
>
> I sense there perhaps is an XY problem?
>
> If "git fetch" is done outside end-user's supervision and explicit
> intent, the remote-tracking branches will become much less useful to
> the human users.  A good solusion that avoids this issue already
> exists as the "prefetch" task of the "git maintenance" suite.

Interesting, thank you.

Suppose my network connection is intermittent. While the machine is
online, `git fetch --prefetch` runs successfully. Later I am offline.
How can I complete the fetch?
