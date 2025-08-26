Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B3220F5D
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213417; cv=none; b=Dzfv5kqTUTubOV7PaIfMkQgv8j+5oVMRrZ7JJYGodMN8wvyS9NhyLgk8i/jUHbGK9aggPZFpRXHhPefkhPSc82pnUwswGVEE5TdbXcuze7VkcsluCW10rkgefXfX3eWF4rZSxI+1LCstPmIJpEiot6k2pA9kHPFdWWxYYPFyhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213417; c=relaxed/simple;
	bh=304VHHJoPJawLsC1vZRuDIvfDSwkSpAbuFb2TXmkzcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXo2PcNL7QCJArH0f7DVTzxiymdnk+Pjovc07pBIIowAl1ch/N98XpCr/S30qfF/GhOfmOZoiwL7AEuAQBTmr6AR9/DOppQgB4iJOKZnvZ0PKu1Nvz3cxyr8Lx6hF1M/IPXk801bgjeiD9WXxgFevGhsPKkGs4/nMdf7dbYGV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9a7gzZs; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9a7gzZs"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb731caaaso840204166b.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756213412; x=1756818212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdXUmQF/BPA7tnjjVVF3e2xAGG0XHodNXnz7l+gWBkA=;
        b=L9a7gzZssMXLOZpjq0JGxTF1Q3Ki6LAOLFe9wsGXIq0PeXMic+rH9hVP+CUGTUSn2c
         yjzsiHB1EmiQm08HbqCVoDjJLlYOL0X+kJ/3xqz2h05V1LQhJ5uMe5YGbFzkZUgTUuOP
         xkpZBqrQNnJw+YNZMmDGjvaZjfIceBlbasml4qU1/JvRzwYajYxqwlxLugfwedUkmMi8
         e8BM4RCt/m5KHQgVVJTxRf0rBInvCsdhI6sUGFMXAL3mtpLQVyYW4TAdFxYwVfR9TUPN
         qhVex1jOAY0qDF7ft+iOlj40t4DdAoGw4mHsSaVQg2lKmK3PkejX2GHABlCLNJyZvg2U
         5AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756213412; x=1756818212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdXUmQF/BPA7tnjjVVF3e2xAGG0XHodNXnz7l+gWBkA=;
        b=iaHlR46WT0vlCbidNNY3OTEA3YE1s9LIjm/6+oXrsSsLTpE9kPpl42R/jTvs0SXP5C
         5YYlo/MtrAH9iB1h4ChcbzVksOaB7HKvXvicdYZX5CR3gy6c3VYZMDmqmD/JSVwBA8VE
         dlQNbNWrjfU+4n/JFFuq5wMjjcIZOa34Fv+3AmifAwlCdRCDKYW/5679Z8Z92R4OZpMT
         QyPs/G+X+8LQFUhGIh6WA4JBWX7k3EMAiC8vwa+CaZeVEd9t8UmS6I6fFiHmvoeUF9Bt
         vWP3c2XhfttvENFH5iq/Omq51JNd+nwgTmmgPI6MEbx1futhSGYdauUCRPTHwM040/vs
         jmPg==
X-Gm-Message-State: AOJu0YxhBTkYZ8VYbIqu0mgZ7miWZXKQIFUiDIZRHAUHi+wL+LrxWh/k
	lPKior9ZZMEwBh55i1aIcy7JZFgR8cRXL1Ilwvs5Pg/Qm3K9BJMVU2Ejv7E/NWl/p5m+YmmVpT2
	VJAthGVhBj3HH3LGKYOZLhjY5IX7C+R0=
X-Gm-Gg: ASbGnctn0Pq3tW2v9BwKlUZGBI/gNY2ZD0LFn2U3d6EDurRUXHJdjpVW8ze2UQ4he5+
	/Bnx4k+m1ucAjZFHqcpY+YYMYpxIUTm//LuRiOuS34t/SDg4CXJvQ71iVxjZ+4Oz4dH8jqJ33YJ
	gsJAyX0e3G7UMxBKyRYfjTPoM61risj9BasgbCvq0G1ZPjaFql21yLsG/z1l+niJoxgiZsTT/le
	Jh4GrEJCfeiQzuaynPhrFftK+Eu0zLlw7Fqh/WrdQ==
X-Google-Smtp-Source: AGHT+IHWYcLEiMKIHbK9+1oAVDYSXOjYE538uZJkzQzZU5BMOhhp1bmlbiV0DyJ/HQc0gaylnE8MMEoPl9L1uPxsVk8=
X-Received: by 2002:a17:907:728d:b0:afd:d9e3:9540 with SMTP id
 a640c23a62f3a-afe296b1f49mr1303748166b.64.1756213412334; Tue, 26 Aug 2025
 06:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im> <20250824-b4-pks-history-builtin-v2-9-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-9-964ac12f65bd@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 26 Aug 2025 09:03:18 -0400
X-Gm-Features: Ac12FXxa7rUN8xIjmyjMRnwKv7ap5ubTm6OzR7RPrEMfpBn4gvgiYt4s1DAzxXU
Message-ID: <CALnO6CB=ZPO33gz0qyCGrC6E2_b2S1kGZkLd-q_CS37gupvPXA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 09/16] builtin/history: implement "reorder" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 1:43=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.a=
doc
> index db5b292994..b36cd925dd 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -12,6 +12,7 @@ git history abort
>  git history continue
>  git history quit
>  git history drop <commit>
> +git history reorder <commit> (--before=3D<following-commit>|--after=3D<p=
receding-commit>)
>
>  DESCRIPTION
>  -----------
> @@ -39,12 +40,18 @@ rewrite history in different ways:
>  `drop <commit>`::
>         Drop a commit from the history and reapply all children of that
>         commit on top of the commit's parent. The commit that is to be
> -       dropped must be reachable from the current `HEAD` commit.
> +       dropped must be reachable from the currently checked-out commit.
>  +
>  Dropping the root commit converts the child of that commit into the new
>  root commit. It is invalid to drop a root commit that does not have any
>  child commits, as that would lead to an empty branch.

Fixup in the wrong commit, maybe?

> +`reorder <commit> (--before=3D<following-commit>|--after=3D<preceding-co=
mmit>)`::
> +       Move the commit so that it becomes either the parent of
> +       <following-commit> or the child of <preceding-commit>. The commit=
s must
> +       be related to one another and must be reachable from the current =
`HEAD`
> +       commit.
> +
>  The following commands are used to manage an interrupted history-rewriti=
ng
>  operation:
>

--=20
D. Ben Knoble
