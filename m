Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D518E373
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855892; cv=none; b=uFMKawrc4a9AQ9Z2NE//1f5bR5R7YC5YHP8j59zbwKDUAjGlw+/IluuVB2yHY5IAg0F7/fDtdzQO6FN3iklFOMy5ChGslP5GvGjHx59K1gtwKOcrk/Y++tVbM4oLhMbKOTtmYtu123A3JP1cjKqihHyzuSNttYw+x4BswFhKfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855892; c=relaxed/simple;
	bh=DIcBzaAWh0BLYpQBD5ybln15I/tZxDEfqMPpB317UnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxQjyugh4/cshIshANPck8RXLX9N+Z7k7gTUa7jxGO37wbNRLnam4892D1pNEBb8Xp0y0DNy41Fh8Lx5zzrtx8+Nf8e0Cyi9NGV94NhGhgvazL0t0SFJN9fUGQHhJSv/COxNdFN5ktK7saPLr7sKH6vtnBybFTSIN1STVH8dp8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bOZ0TwEP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bOZ0TwEP"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso4451569a12.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 00:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727855889; x=1728460689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a246ffZCY/Zj/ilL2qMQ3nborFeRGU6mn0bNcEXKEl8=;
        b=bOZ0TwEPWR/EJoY4vrWN9156RKwRt2NkiVqTRzRMxFaEC5kNRRNN8a2HPJVVNe8YaQ
         QGm5Htj9XeZE++tbWw3BeMj+YvGKg0Hnp3JZd6FcZ2xz4NYMN0BBVgq4WoEZEbDORqHD
         r5T1o38TjlP7FA7d+xKtejGcqWMiDZSJN3HaFBtjWxiuzuvAbZOVPx/UmxqQbY+fTTyt
         Pufar/ZL/91vXlBhQMSg1KyjVYt0sntQADVosKFKQE/z6WyGUwecZlG0q1Efin+DdC52
         KqRqrk89qr86m098EDEnbMIQ9lt8AXAUJbxHU7xZOAJ1uCQTl2EnyICnmH6N+kpuyfIo
         FdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855889; x=1728460689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a246ffZCY/Zj/ilL2qMQ3nborFeRGU6mn0bNcEXKEl8=;
        b=AMq9k24m/Np7Fx/bExzc4F4islECbS2RWKPxz+THqppSlis9Y/b/Jmi2abmlwczB3N
         rNW6x5Gaj3p+iPZAWkg2mJgjj2udrTvaZFp5N7W0mSX/GoSEcPV+xak6okpIwK0hFRpk
         xIhL9DRXCSG60yIaB3JVBwXX6WXW/0rc/ssKB8g7H6xj6pM37xpkPU4u6wIybPEvxfBc
         ziIOCmFsKBe6z6zty1MPsJ+KVkW6gi3fHwWs8j35Zvm/3y1ZptQFfcJoGdUDXd1qrK4V
         fai7gYj9rD9ZkiYwjNdWfr+DphUan1cMz59XxFn3GnfEuZOrHmAlINym+3d0Ung+vXIs
         pZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxx88wkOjrB+G+SO9NEAHnz8hXDOOIS8qzeF4sLaMa8V+3lYD/q3Z4dQfjpjJgygLVTrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZcJMjsJEj9gw5TvOIFEnbUMYsgV8MOPW6fPYZVb2aQMl8f+7
	WLPWrwhI9ONp01i8YCgT2PaCU09+8+Vb+g2CRAtgQrw5sMWZhcQUnMN/GCNnMcRfbQRZEleN0bJ
	zPKkcRJHXfN7g4LV5gYnrq5TpxgCdHzEs52Shpg==
X-Google-Smtp-Source: AGHT+IGyCuUPH+yETT7uEDbl7GLbYLAFkR4sRgOjoIiCc/YdUBjJM877LwI0rxlu1ouMYXkn0/JdCQb6HpkHVtZy140=
X-Received: by 2002:a05:6a20:9d90:b0:1d2:e839:11b9 with SMTP id
 adf61e73a8af0-1d5db136cd8mr3576754637.14.1727855889347; Wed, 02 Oct 2024
 00:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001191811.1934900-1-calvinwan@google.com> <xmqqo743qkn9.fsf@gitster.g>
In-Reply-To: <xmqqo743qkn9.fsf@gitster.g>
From: Han Young <hanyang.tony@bytedance.com>
Date: Wed, 2 Oct 2024 15:57:57 +0800
Message-ID: <CAG1j3zFUGPev2voyEocv=G8=NSUDqH2Bbr5_dpfuS9ua8tTs6Q@mail.gmail.com>
Subject: Re: [External] Re: Missing Promisor Objects in Partial Repo Design Doc
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Enrico Mrass <emrass@google.com>, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:55=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> Stepping back a bit, why is the loss of C2a/C2b/C2 a problem after
> "git gc"?  Wouldn't these "missing" objects be lazily fetchable, now
> C3 is known to the remote and the remote promises everything
> reachable from what they offer are (re)fetchable from them?  IOW, is
> this a correctness issue, or only performance issue (of having to
> re-fetch what we once locally had)?
>
> Is this true?  Can we tell, when trying to access C2a/C2b/C2 after
> the current version of "git gc" removes them from the local object
> store, that they are missing due to repository corruption?  After
> all, C3 can reach them so wouldn't it be possible for us to fetch
> them from the promisor remote?
>
> After a lazy clone that omits a lot of objects acquires many objects
> over time by fetching missing objects on demand, wouldn't we want to
> have an option to "slim" the local repository by discarding some of
> these objects (the ones that are least frequently used), relying on
> the promise by the promisor remote that even if we did so, they can
> be fetched again?  Can we treat loss of C2a/C2b/C2 as if such a
> feature prematurely kicked in?  Or are we failing to refetch them
> for some reason?

In a blobless clone, we expect commits and trees to be present in repo.
If C2/T2 is missing, commands like "git merge" will complain
"cannot merge unrelated history" and fail. Or commands like "git log" will
try to lazily fetch the commit, but without 'have' negotiation, end up
pulling all the trees and blobs reachable from that commit.

It's possible to minimize the impact of missing commits by adding negotiati=
on
to lazy fetching, but we probably need to adapt code in many places where
we don't do lazy fetching. "git log", "git merge" commit graph etc. it's
no trivia amount of work.
