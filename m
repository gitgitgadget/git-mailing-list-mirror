Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47E2D052
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727030461; cv=none; b=QYY+eLG91AcB1DQCjqYdQS3H5E2Y221+6o2eOr6vkUCXHWaXAuqOsHPTuNq0pKePAVSV1KJB+d0gKALHC1kG4bfuA3xIWWMwJHwlA60SGtwBHBTmyA9057wQD6HYdNt6Pq+4EOvosUTiBJztmaEEj52KpmqO1xc9BSz+ppBx96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727030461; c=relaxed/simple;
	bh=XzJg93m6AyDizIgnczWBAxATi+1Eib2+H5/FXIHnrv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+PwLX5hhnKT7X14tiaHT4FH/z/eaZYHIpsxd62pWn1bwi36gVvh9dNtYHr8YJb62MrMGpRtpDf8Ua5XjRPlL136jYNYgw7cDHWrwyYH3b8qc0f7GAk9RHK/0fqzc/bX5qjFg/+bdgup/IRMGNervqvHy2DYNp6uuQ1X2wNCSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs+ERmdl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs+ERmdl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20696938f86so27782875ad.3
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727030459; x=1727635259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzJg93m6AyDizIgnczWBAxATi+1Eib2+H5/FXIHnrv8=;
        b=Bs+ERmdl8rpWw2m3UsU9WCIt43wkOzt/NqcP8hdwkzs4PoKpPR1+ZhgGN2qadtvMEb
         polFhxdApq6GnBD8Aa3+w1fvm8ro523hlu3kIPWV9sMYnTvtCoaarokxqvSUfpJ4ObJI
         PrUOhKM9kUwzb4HJdLLxWEn5qDMViOJLUmEX6exVEcqxcUayY9x0TpCI/IeUjamxbwDK
         Y8YuWfHVqfYVW7GseG+fFdRUBCMcGfbVpQQ1Gykq77pgn6Ri2B8pt+vUBB++Ag8HvAAv
         q3NKArCdyrd17u+YWUMgczCRzFMC6KKtNRcFBSOC7A1WuuJn0bkQQ/iotteOFfeFsRRU
         OVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727030459; x=1727635259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzJg93m6AyDizIgnczWBAxATi+1Eib2+H5/FXIHnrv8=;
        b=b0TWY7zOHBQe3LlxP/QF5UlCOX8hBR1uGx55UI1jRm+fthLwZyKkUruHkOjKvRsHj3
         u7v2WonLBS4OoYOUrHiUpJfUV5K5sfvjYs0OZl4Mc3KbgFuaqIObX0bPfJEkKeRtRftB
         egKCtdGqcENH12gZc5cnY51A3VVSTETTB9DSLCHMLyX1rzO70DfHm71LWhTZwmvDAihh
         IN9EjA2lH0Zbz7wT7ErbNBA4OGfNALlD/S30bRhZUE8ueK4yPlbicS/Zd6UTKWGkUZtF
         bB+D4dXBBuy2Qn42xnlvGK5+vPoK3gL9dWKjV4XThQYNLZUFNhcGi1vCZ45k62PxG5XS
         iXTg==
X-Gm-Message-State: AOJu0Yx/q2udT+xouN7XdD4MWYAr9zeDSvoVRD1MpzCcK5hk/R+azYKq
	3NpObw8vCYVGJxk2nvINjyHgUyOlwk60wKaiunI5BEngeev9i4xN0zqkd48iqRnqT9kqD5jRAvq
	DJ2CsxylYzEwHt+JYKBDcVYQTDCnPq4/Aojc=
X-Google-Smtp-Source: AGHT+IGljJVLlB2MNw7dMDFGUUsjh0S+4z2yBa3FJvlpY6BaU5z70qnK5q0hnLU9M1dLhxVrjvFzqkTVCKfx/mGPBsE=
X-Received: by 2002:a17:903:192:b0:207:3a5e:8809 with SMTP id
 d9443c01a7336-208d988029cmr152893585ad.49.1727030459257; Sun, 22 Sep 2024
 11:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+3C1JMKoW+j03nF6uS2DjcJnKD7+0PSaiXGB-td9qyc8Q@mail.gmail.com>
 <b67c7b6b-f11b-4306-b3ba-c440e8cf7cab@gmail.com>
In-Reply-To: <b67c7b6b-f11b-4306-b3ba-c440e8cf7cab@gmail.com>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Mon, 23 Sep 2024 00:40:22 +0600
Message-ID: <CAG=Um+2g-pn3XmC4MVkA+UAGeWpHw5U6fe=zXR=6-ibu3d0qsg@mail.gmail.com>
Subject: Re: Prefetch maintenance might lead to thundering herd issues
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 1:20=E2=80=AFAM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 9/20/24 11:15 AM, Shubham Kanodia wrote:
> > The current git-maintenance prefetch command allows daily, weekly, and
> > hourly schedules.
> > However, in repositories with many active developers, timing `fetch`
> > to happen at the same wall clock time can lead to a thundering herd
> > problem for the backend server.
> >
> > Ideally, these fetch requests would be spaced out by a small amount,
> > so as not to lead to a co-ordinated load on the server.
> >
> > I don't see a way to configure this at the moment in a cross-platform
> > way at the moment. Perhaps it might be sensible to offset the cron
> > schedules slightly for users so as to not cause such an issue?
>
> This is already handled by using a random minute of the hour, as
> implemented in 9b43399057 (maintenance: use random minute in cron
> scheduler, 2023-08-10), for example. There are similar uses for
> systemd, launchctl, and schtasks schedulers (look for uses of
> the get_random_minute() method).
>
> Are you noticing that this isn't working as expected?
>
> Thanks,
> -Stolee
>

Ah, thanks for pointing that out. It wasn't really clear from the
multiple examples and cron expressions on the git
maintenance documentation page (which have examples such as `0 1-23 *
* *` for hourly). I should've looked
more deeply into the implementation.

Perhaps adding a line to the existing doc might be of help? What do
you think about adding a line to the
section on scheduling =E2=80=94

diff --git a/Documentation/git-maintenance.txt
b/Documentation/git-maintenance.txt
index 51d0f7e94b..34828cdfe6 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -217,11 +217,13 @@ on an hourly basis. Each run executes the
"hourly" tasks. At midnight,
that process also executes the "daily" tasks. At midnight on the first day
of the week, that process also executes the "weekly" tasks. A single
process iterates over each registered repository, performing the scheduled
-tasks for that frequency. Depending on the number of registered
-repositories and their sizes, this process may take longer than an hour.
-In this case, multiple `git maintenance run` commands may run on the same
-repository at the same time, colliding on the object database lock. This
-results in one of the two tasks not running.
+tasks for that frequency. The processes are scheduled to a random minute o=
f
+the hour per client to spread out load from multiple clients (e.g. from
+prefetching). Depending on the number of registered repositories and their
+sizes, this process may take longer than an hour. In this case, multiple
+`git maintenance run` commands may run on the same repository at the same
+time, colliding on the object database lock. This results in one of the tw=
o
+tasks not running.
If you find that some maintenance windows are taking longer than one hour
to complete, then consider reducing the complexity of your maintenance

--
