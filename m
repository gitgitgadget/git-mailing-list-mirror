Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C921362
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264586; cv=none; b=UG6zht5fz4vQM7IDiR5rd83J1v7nWsUTIVR2Q70y9Zk3FWC1bCi4UxWBk3pNewdA6JJhs5Z3jgiUq3fD647z5x7ZFczyJ9ipHtw+aOZDZfyEtDu0v5KKTN+yECDsZfH5s2CguGsWG5Zd6u3s0eqTO8bZ5jByuetrEwiWeY4V+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264586; c=relaxed/simple;
	bh=jOFBrvMS7bVvUyXZJ5TDqDx9emOFgTjlSFXjwQG8Z5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrYrpg4KXFO+nWEqmmvJVArxVOmJYLmUG8ziDkh0NsIrqOzQDf9MaBYfQAbzTtvdhULLvtlyjEaxcVqiYUB93jR1VpWIAyxXj8zods5JuA/7dA76XiX/FUuqfQ6/0kmK963ElOaniIWoP8OEBg00bDr1z95hPUiCGeLsaTDmlOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm6YHpdS; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm6YHpdS"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8418a2f596fso198064939f.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 14:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733264584; x=1733869384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz/Cp7SJnjA2wCAf2gs2+fGXqM1I/dPlAYoqkCnq3Pc=;
        b=Hm6YHpdS01eOooXy1IruE/PXEeQuLKLyYQmlDd3ro3Hh7JcTbZ0Md83h3eGwjs0QX3
         X7XjAHs5EmrmuNCc43/Mb4+ssp0kRCg1qOy3xqOFun9NF3X0d0v3C8AtbSDMX/r88dBz
         kBT5qavJmnobXgxiL7OOwxjkvtPMuStB7PaHAQQoAMUoxNxcZbGKXAXb0IqWthUJI8sf
         Jarlseqznru0U/SoxzbWglp+hsFStvfjvxBIXDywrD3TOd9VLEwSCltzLwCEZsJINi+y
         +c6sL5M33rz2qblZkq+A6zL8DjZUYPuw1g797guS5T9CI+gEp802TgmB4Zd7FfCudVER
         DI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733264584; x=1733869384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rz/Cp7SJnjA2wCAf2gs2+fGXqM1I/dPlAYoqkCnq3Pc=;
        b=Eiq96RYJWq1OCw0XhCeY7AFGIFAdN4D2rQ1NMVHQXVZsJSkljppTtvF4/SORcD8YCg
         rBd+0lGr4hU+kKdO9S/eifLiqt6n+LUOv9Ry1WBBP2vCl2luo3Ir5xdLDk3rcpD70Ep0
         eG8oDGjdqfL1atIpLsRfdIYzKKWbgozoKmYEF6wo83jN8gJjof/LJrPm9vyu2GheLg1d
         Woep5MAPEPB4Ao1TmEAsYxzIsPgOMS3SQdkEMJX1Wt82JI5qIVhZsBwaTz1Imyq8qo5s
         9wIF4WrQy2Yx5OJJs7wcqEa06Y/8nHdcyXWylX+JenoQFF9b9Rn5ouDi1oHTiwlPwkqC
         5MKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHh5ILqyIUTobcMxBg2kpydi/L5jlLmhUH4tmihm+6BvgY2YnP30auwKddOXBm2fPgg48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFG8vij0UO1JVoxnSRPEiesslUYrWPy1MHE/euyFxfzsLuao6d
	WzL++vfVKJLD5jwrwEYFRPVJFrHrVfoU7t3G1F4KPqVeQpYBNiDOWYpGVlT/DkAribbwohm5Q9D
	Zb06u/UXrM5MRdyO84ncq1TykP4M=
X-Gm-Gg: ASbGnctK8iEkatGrYO6NqnAuV4RWb33XqciXV9eJW7dptxmb4cW/K2S+ajONsRBa4HZ
	UF11bqaRI8znAceb14je9rNT6Urr0CcwZXx9hbvTG+IeH1Q==
X-Google-Smtp-Source: AGHT+IFTtLRKP3dMNv/20Ja+pDb9FkGW9AWHNSlVKh24lmAwMpZvSzmIAoqycJn6yEPB0/8P67Y0NwpNMFp5tEiaMsE=
X-Received: by 2002:a05:6602:1546:b0:841:a80a:f536 with SMTP id
 ca18e2360f4ac-8445b5e36d5mr531088339f.14.1733264584510; Tue, 03 Dec 2024
 14:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
 <pull.1832.v2.git.1732928970059.gitgitgadget@gmail.com> <20241201214014.GC145938@coredump.intra.peff.net>
 <CABPp-BGP8zrSzxcacTzLY-EuYAQW5EwyDGNAMh196udGN18fmg@mail.gmail.com> <20241203210652.GA1413195@coredump.intra.peff.net>
In-Reply-To: <20241203210652.GA1413195@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 3 Dec 2024 14:22:53 -0800
Message-ID: <CABPp-BGFxss5m0OU-mj8XSxqMrrxu_NRb9f5qdb-88bjj3+Y9A@mail.gmail.com>
Subject: Re: [PATCH 2/1] t9300: test verification of renamed paths
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 1:07=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Tue, Dec 03, 2024 at 12:01:51AM -0800, Elijah Newren wrote:
>
> > > On Sat, Nov 30, 2024 at 01:09:29AM +0000, Elijah Newren via GitGitGad=
get wrote:
> > >
> > > >     Changes since v1:
> > > >
> > > >      * Moved the check to a higher level, as suggested by Peff.
> > >
> > > Thanks, the code change looks good. Is it worth tweaking one of the
> > > tests to do "R innocent-path .git/evil"? Otherwise I don't think ther=
e's
> > > any coverage of the file_change_cr() call at all.
> >
> > I would say yes, but since this patch too has made it to next and is
> > marked for master, I'm kinda tempted to just leave it as-is...
>
> Is is tempting. :) I wrote this up, though, which can just go on top (of
> en/fast-import-verify-path).

Thanks!

> -Peff
>
> -- >8 --
> Subject: [PATCH] t9300: test verification of renamed paths
>
> Commit da91a90c2f (fast-import: disallow more path components,
> 2024-11-30) added two separate verify_path() calls (one for
> added/modified files, and one for renames/copies). But our tests only
> exercise the first one. Let's protect ourselves against regressions by
> tweaking one of the tests to rename into the bad path. There are
> adjacent tests that will stay as additions, so now both calls are
> covered.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t9300-fast-import.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index e2b1db6bc2..fd01a2353c 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -553,9 +553,16 @@ test_expect_success 'B: fail on invalid file path of=
 .' '
>         commit refs/heads/badpath
>         committer Name <email> $GIT_COMMITTER_DATE
>         data <<COMMIT
> -       Commit Message
> +       Good path
> +       COMMIT
> +       M 100644 :1 ok-path
> +
> +       commit refs/heads/badpath
> +       committer Name <email> $GIT_COMMITTER_DATE
> +       data <<COMMIT
> +       Bad path
>         COMMIT
> -       M 100644 :1 ./invalid-path
> +       R ok-path ./invalid-path
>         INPUT_END
>
>         test_when_finished "git update-ref -d refs/heads/badpath" &&
> --
> 2.47.1.707.g92f6f18526

Change looks good to me.
