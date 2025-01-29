Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC01DF255
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148489; cv=none; b=bFu8Vz+LZ9OWerMOJyrpdCtIiMhZ8d+5QJJm028c/7qr3IaYaN2YYq7PtL8ucgMAAc3BE5YFbSWURjcnYUxHiGHwB0UMUY17ZvOjB1EAD7yIR3egt0QrS0ytqiYRGEED4d0VK/j0qqkAYUiFL0BaarjxG2R+yNOJ47vOuTfsRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148489; c=relaxed/simple;
	bh=xJADib2B3n9q6662xVfgFYEJ2XelNiN9RrDoDIvYsH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoPaOTevRTsPCT+AxTn5uBjwjA2PUlZ0Sa0Hfw0aZA6VWStTr2YnSQZReDVIXjFjE0n+ksloMbTOBOXpdGU1nCT7/Z4qptHcDelGo/0uBkjDnKMSi4iTd5QoxMvx7/4zVupwqoVld3EWcYPE0kCwJGwN+P8rjJT+hsS3YUm8yPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGG/TyAI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGG/TyAI"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54298ec925bso7751123e87.3
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 03:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738148485; x=1738753285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJADib2B3n9q6662xVfgFYEJ2XelNiN9RrDoDIvYsH4=;
        b=DGG/TyAINohCq7ghEQbAtwqmdFrpyPruOWZYnkYkgxWZS0xlnIL7WaGsZJB6ci7PSu
         8B4z+WvMCfxvzH5p7NxxiysqzEO3Qj7O+RlWRzHISzcp3Ljosyh5Og3eXUluOZIFgd/O
         0eCHktww/6IEy3US7ev8kd6ScpItU+/DL7w5P/zonwuV8S/jksNaZd+Qy7B3RlK+uvZN
         Zz+HUeHln1wULkGVNspFRnHg/EMSas49PU/OqotUT0ZMR/ARWIx+XskxdVRMH5qjqIOM
         RCDhbq6MeZlxSwZe8LXGnTVjrr8r/TPVWRwo3Kc/W6eWMoCnEc99wcZvK/XEhahJ1ijm
         fOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738148485; x=1738753285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJADib2B3n9q6662xVfgFYEJ2XelNiN9RrDoDIvYsH4=;
        b=BYgny5HX/pGrpdyWXcXgXeNOItKfuJf9beiRCg0qn17z0Qz0M7yXpQiVaY+u1in5aD
         skXN9m93r2seHursONbqoGlrR7G3LpjCeiEWWcf7kZ3W3KXYNx0Ki3gC64nYJL5JnoHc
         J/2QhJRrHmpbRFC9K3tAJwxeI8kspAbyEU4h51ePFJtzwtb7bNfza0/Ksmd+sjUiE2q1
         0EI5Fssi7Bz3S7HCRQwJNxckQaeZYMdv85bChWMPiE/CjERuC3cU5RH+T52MMrPZJdfy
         mINdKz5FW9lkbZ0nxlE3rDjXOayFsILx+R/RTHVaKa1k4fqMlOJsFeDJsLe9uUZSIu1L
         imtw==
X-Gm-Message-State: AOJu0Yw9BBlmFTfEKYrPDCHtqqLYCvjRpCkmHqWtQVGnMJd0F4xZUAzI
	/QyaYscUKY02nZBhtvbs2pEbFlbAw7N8uFATF03CtjWDBsm13fO78BesQA3Qsbds1YqRHv6bYKZ
	vr2hg30kOrP/3oF1pniz68Fyz4cc=
X-Gm-Gg: ASbGnct4GZHgUsrf2Gc0ny2gIimr+oGTjlj0KHR6KFMJqFh4nAemsii9u+RlYbuKOVg
	+PjYt4SU9hA9gevPZlkCa3AdxTDd7oYW2oyOf5PWgzl4yuaNxBhYX4oIt3DauXI8/M2GBmtSYgA
	==
X-Google-Smtp-Source: AGHT+IEIGYzyEGZb0ho4Q+priWY5T87Ya0l7zSuHcF4sdEaUhOHctEINfoy3xC5amBvMuQQInlzCOA2/rWf0oYxR57s=
X-Received: by 2002:a05:6512:3094:b0:542:9a42:7991 with SMTP id
 2adb3069b0e04-543e4bdfef9mr1048459e87.3.1738148484597; Wed, 29 Jan 2025
 03:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+U2-7GiHq9qhiyLPLgzOd1JK072gzkmZ+4vQ11V0QpKgPif=Q@mail.gmail.com>
In-Reply-To: <CA+U2-7GiHq9qhiyLPLgzOd1JK072gzkmZ+4vQ11V0QpKgPif=Q@mail.gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 29 Jan 2025 03:01:13 -0800
X-Gm-Features: AWEUYZlkn6bGmC2jL_kEGaCuJOOkKF7rt3mt2PPic3gw700Q7cgYsnruiZcryQA
Message-ID: <CAPx1Gvf+80Yty1R3O766fwYiRUysQ3Ss1XbFq7hmrfcUcawBAA@mail.gmail.com>
Subject: Re: git diff -G: Regex pattern to exclude a word
To: Raghavendra N <nraghavendra89@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 10:05=E2=80=AFPM Raghavendra N <nraghavendra89@gmai=
l.com> wrote:
> I'm trying to understand how the -G option in git diff works.
> Specifically I'm trying to test a Regex which excludes a word from the
> git diff.

"Inverting" a regular expression is technically always possible,
but is difficult to get right, and I think you made a slight error in
your attempt. See also https://www.vidarholen.net/contents/blog/?p=3D36
(which has a link to a Haskell program to generate an inverted regex
automatically).

With `git grep` you can specify perl-style regular expressions,
which allow negative lookahead, but `git diff -G` does not
support that. See
https://stackoverflow.com/questions/39789921/what-flavor-of-regex-does-git-=
use
for details.

I think it would be nice to add some of `git grep`'s options to
`git diff` here, but I leave that as an exercise. :-)

Chris
