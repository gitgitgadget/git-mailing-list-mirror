Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A812BF0F
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209495; cv=none; b=WDBPs+jzcE5PRjW9eGX1blG6ZdGkZMYBu/ok4VNakHWc7faJULgzIgoezyak2XecN1MO/COtvmKtsqTypQGqSbczJJs5gEXOA60Z3E5I4wFvo3KUr5+7e5jvGU2zScJNKRuhIZcQXYBUG2rKrBcXwMdm3mAmAspoGJbc3ZpO+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209495; c=relaxed/simple;
	bh=Yp0T6dD1tTQo5jLKUn6ULWE5Tiie2Sm1Er+S9OndE8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pp0iQwemc+Smst/hbJFvogEI2DUw2eMNu2/2uynPU/ASzs9AVRwKywYkRp+E52VPc6zlW727rW/yQGNJH3Grjxy/94StmQ6rVpRlXCYbTtllfH633DdKapRq5ZFkZ6A6EYnpm8KuvxFylky3YtNlxdg4AY5kCS+uFub8qtJzCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+86JBew; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+86JBew"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so6966609a12.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707209492; x=1707814292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yp0T6dD1tTQo5jLKUn6ULWE5Tiie2Sm1Er+S9OndE8Q=;
        b=T+86JBewzIhcK9cbAQi2/zLif4TSD29JDHMIOMDE37g5UtETPwFMBkUW/K/mKbn0jl
         I+APel6xzdY5l+45Ci4ATDo4NLp+2XzUuixQcbX/b5ITc+T50H/R2w594U497bb+7xgq
         2HPbJ2+qLzRhezDJJ4fR+PUalVz0KR/99ioiyO2bNvItXNHbvSD4bmw/QJFr762a0zmD
         6nP0mocwcRikZx4SZWmNx9EjqwctuSmPlNzzXNTBfcP+Y8438SpMIa5PKRurbtF94SRH
         T1H+t9TOxpQby3Wf+SLR4q9AHA1r7ddKmozuOeRZp+0J/eOUVqrLrP8qyD06JCBLmaGU
         cVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707209492; x=1707814292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp0T6dD1tTQo5jLKUn6ULWE5Tiie2Sm1Er+S9OndE8Q=;
        b=hFzMC+/NRDN6XvSzC2hBR4eapwQGbJoaExx+nYanzOHD30ieVsZM7PkCfJn0nOyIMp
         cuytTtlahKXop5xdAEXYW8gFRDvVsmtzmlgpOulz9fMYOq0RDvSllm+jtqjLiJ62ZPxb
         iqY+n6HMbmYF1nULVhz950Zd3qib+Qc3GTCrC5pa3B9wRLeI0IZp2ynEUjPkOQvB1afn
         atv6Iecdy6jFO6is4QoRMGqN29hzE6eaU1ep/6pVyHO7Nh7WlbZbsWUlZaX78pyCjsyW
         1Hhd8HjzvynIVEMD9b8L6NWqLJ2RVn9DwRymTEkcrFDNxr5tBHzZn7XWA8kmF+6DANDZ
         cp2w==
X-Gm-Message-State: AOJu0YzwO7A8c8HvdusUMzC1WsK1ENPNIQUzTeyAjYHSnW/Mg4lbiVFd
	UoKC3M/hW6gfX3t4m7UflHPfZ4W7RX8zHMNXD2WreGCgQLEA6Fpc9YZG14BRLcZfL8P0q2bb/4v
	qM70QEIc+eU9kPbc2zv/la/7z7Qc9CqTg
X-Google-Smtp-Source: AGHT+IGG2eYf0O8LFYMhKKgN/+jZOMgh9e/3IXPXvODBMwJTjsXOwTrEGiEtZf1VA1mXgOnRinSDMuXuYbxzSt5Vvw8=
X-Received: by 2002:a05:6402:38f:b0:560:dfa:61c7 with SMTP id
 o15-20020a056402038f00b005600dfa61c7mr1169341edv.3.1707209492201; Tue, 06 Feb
 2024 00:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl> <fa98146f-9308-4844-bec9-4605575b9cd9@app.fastmail.com>
In-Reply-To: <fa98146f-9308-4844-bec9-4605575b9cd9@app.fastmail.com>
From: Maarten Bosmans <mkbosmans@gmail.com>
Date: Tue, 6 Feb 2024 09:51:21 +0100
Message-ID: <CA+CvcKRkj9HZ4jtN4R_KZo9U_0AjtAFhyLPzaLNzgow2ag=Esg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Speed up git-notes show
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Op di 6 feb 2024 om 08:08 schreef Kristoffer Haugsbakk <code@khaugsbakk.nam=
e>:
> Nice. I=E2=80=99ve seen a few tools that do that:
>
> =E2=80=A2 https://github.com/spotify/git-test
> =E2=80=A2 https://github.com/mhagger/git-test

Cool to see others are doing something similar.
The first git-test stores the test results in a local cache though,
not in git notes.
The second git-test stores the results in a note attached to the tree
instead of the commit. This is a clever idea, as you avoid running
tests twice on the same tree (e.g. the merge commit of a `git merge
--no-ff` merged branch that was already rebased to be current). Down
side is that git log and can display commit notes after the message,
but cannot display tree notes.

In our setup there's one CI server running these tests and pushing the
notes to the repo. This way everybody (developer, reviewer) can see
the state of in-progress work without having to run all build test
variations themselves.
Anyway, good to see wider usage of the git notes feature as
inspiration for new possibilities.

Maarten
