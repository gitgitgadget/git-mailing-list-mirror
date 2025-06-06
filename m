Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2826A0DB
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749208844; cv=none; b=NyqQYcVS/7OYJb5TbKMgDJi4q2xE2nXu+tYQdlLZAd7nbZ+LxHYNQ84OYJOO6hmMrTTbmD9uMh94QF/msH88WqSg8L7Zozj9t8bkhylGmqL1/M7dU61QNcsi+tjHbGloU/hdIBH9lUThWu8zt2TkquFgxBBSaYMgNZnmpmgizts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749208844; c=relaxed/simple;
	bh=hACgUkS4NXH8iEHMnCtOMQBIktV+qF6EGT/d6aZuTKc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MpO5U20eMFsi09vJkkjrqz6CvXIWjQLVq9tITjDd6L4hKExnyCJ6yLXyUM2AzoaGqeqvof8SeDTJEjF3QnVutxtpg3GkeYwgiE/XRV7Blw1PiCJRxSn/Joj2tV6TzsA/udTg0/fFTmAyGcL8OCU4QsGMlWfoxmYmup4VBbBjUEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE9YtMyW; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE9YtMyW"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8731c3473c3so57639139f.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 04:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749208842; x=1749813642; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HFt1zRDpdnNRmuaGiTdOt4N31Ye+AqZu0sVW8sgQfLw=;
        b=JE9YtMyWevIPgDZGkdlaxF/cu18xH5jmLdfC19sezgG3s+1t3rbUUnyF//DOKmohuz
         AgsRvYQMUQCX1MFz9FOG50Tl+y1Rm40j9IpGcUkCV7CV7007kst/LiGy/yWHRZ2WBKJ9
         wQXmPhZwQTSu5ds5FhnHNiGalWssgQd94bzp4au1AynYZ9rg2Domxk+Ot9CKCnvtE5Oo
         r42FMN43O4VztdDSpGfKFSig0yZCgH8AmfQhXNpzD5yFPgiNNKhGAvYSgWVEm7eRznAM
         j8OnUVxbRGIzoFLfL0BItew8jcqCc3TuXkNugYtEtZBKfizzankzL0XIoxGDdOawh8PG
         /5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749208842; x=1749813642;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFt1zRDpdnNRmuaGiTdOt4N31Ye+AqZu0sVW8sgQfLw=;
        b=DRVhGq1YrDBQJtgZ2a32bXkgCgGGjd1SECYtJ3nggpMJk96zWMX05iG4K+6ITCUE+6
         ovrAbz7busSvxdmYp9SbHpbEwSYn72yCHQlqMwkDWOYbQhG4LZlntot4fHLx5IG6b52N
         quzWMejQ2iKnjWETYFJ1aC9d3GjPZ5PEv01z6+VM3Kq6J4wLzrGOjHOJFPN0ffzrWK+S
         wFyNRP/FyLjmnpM9C84PsgKwXBAo75mCAq/JLK4Khh5YTH1TGL2h3nDLnUQFkoyECwdT
         X85D6U1E3v8K8xFmSSE+hqp8g5csdSZ+w/xQPQalEUzV/khmaFvxFn6bBV+no701PbU+
         2jzg==
X-Gm-Message-State: AOJu0YyDpVisg+1wMG6bjf3xH169izTiLuF+RHRTPksDnpcSYOgifgrD
	wfnToQaLa/m9SRGO5SBYi/FPIlmFSKPPutXORc4RPQDBzpeohPLtdVXj2Cv/IzXNzIgyEbeByr2
	l//e0L7ASfR8rgnhKROz5ViK2fW/ieAiwFniW
X-Gm-Gg: ASbGncu7zgBWz9gdQO7XBr/KRT2fY+DOw8yGLdeCmrN1MGmoJbOAJIpZ14meDM+OVfw
	b4d4y6CMrIAuFpYY13x4DYGH6GsjMW19QV0UKitCFIvitv6Fvwf8b8svkmHbSTJziweYRvxC376
	p2ZVJxLVw0NxcoyKlwt+kJffNLywpWlZo=
X-Google-Smtp-Source: AGHT+IGaVMs3EuXnS4/YMAitu7/Nv9GsM2tBXpalrEULijHhgMkE0T6MASRKZZqTcgDkhiILnHUhKCkffKZlxiji2lc=
X-Received: by 2002:a05:6e02:18ce:b0:3dd:88da:e804 with SMTP id
 e9e14a558f8ab-3ddce4533a8mr37058005ab.18.1749208841717; Fri, 06 Jun 2025
 04:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondra Medek <xmedeko@gmail.com>
Date: Fri, 6 Jun 2025 13:20:30 +0200
X-Gm-Features: AX0GCFtHz-a7UIAf7oLNuCfXVb-hEPXS0Fpxfbafk3YVubqXHObywsFL9fI4Tr0
Message-ID: <CAJsoDaFKRz8om1d4YPtaqdyuBuPAiC-xHDuvmYW=VQWEzzXAtg@mail.gmail.com>
Subject: Git push tries to delete branch twice and fails
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a git 2.49.0 (Windows) and one local working tree is kind of
broken, when I try:

$ git push origin branch1
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To file:///c:/...
 * [new branch]            branch1 -> branch1
Everything up-to-date

$ git push origin :branch1
To file:///c:/...
 - [deleted]               branch1
error: unable to delete 'branch1': remote ref does not exist
error: failed to push some refs to 'file:///c:/...'

So, the same `git push` command first deletes the branch and then
fails because it does not exist. It worked well until something
happened and since that time it's broken. I've tried `git gc
--aggressive --prune`, but it didn't help.

When I do `git clone` of the same repository to another local working
tree, then it's OK - the branch is deleted without the error.

Is this a Git bug? Is it possible to fix the local working tree except
for a new git clone?

Note: I am developing an app which uses (creates and deletes) custom
refs often. So, I've hit this bug when trying to delete a custom ref.
I have cleared all custom refs and tried that with Git branches.

Cheers
Andy
