Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4EB658
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729407; cv=none; b=bwPj8aCHUIdGcNWegKZfPQndnFNIymDMxOEE+Ca0pd03l4nFCOJagFPr9LA8Pj1Y7rQuYV8YyS88yih1DIK0SkRqkErWC+5H9Y48vx4KkF89S7WLqvDq4UggG3+bQN6CHsJoQOQnENoFgEd50YPUmoieKLrzrCJHe4mz59GGqPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729407; c=relaxed/simple;
	bh=Hr5lYIP+tvG6LVPo0xcsNTqDKE8DK6askQ7A3/1eknQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmCzVLtidy8/kSCR3buN1Reuc/90fCAb1aUA4xyaVt64WJ9aVo5LdK2c0k5+U2u//JMe24vfqkP7XWNUgBMb0GzaGXrpP7RDX961Unu7cNS638CKsL+/7xDk68H2URsv2347NQFc7O8L6qkL/Y0nCrBXCZ75Rs333cs/r0aOdDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBzTbvFE; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBzTbvFE"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fd057a973so92757241.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729729402; x=1730334202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZy28HmB/acrwWkl/Nqm0kS54dLWHCy6PURP7T6icCY=;
        b=GBzTbvFESZKSQjvRFC51xFonW//nh9ik0Z8lCIhN7hpdQtX30ylye0JywY3Wz+76+n
         YlINROzjW4/yDXBNun+nfLb4/3jeyhTs2Pc7o/f0cuewfevI/lrUeLPU0DbsnF/S2Mz3
         dREhun+gAV7z2pL/aAZpbKGLUKtbx27bfKmYI6b8b0QC8JfYmykXBZB0qcRXsu+TWJ42
         Z8tTBBSKeXofpfs0V04KUQN3VgG+nShE2tzBmtn0aIaHt72lO61D4sgOcWrY0buC2VHw
         Iv1YdTUSXYj7bGX/tw65yrOKT20zykxIs8ULFmVKDA4X8HBoAbldcwjJCt2pUrkLdDbV
         +FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729729402; x=1730334202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZy28HmB/acrwWkl/Nqm0kS54dLWHCy6PURP7T6icCY=;
        b=o78xVdNNTsPlSqBPUsI8f2BJwWBARfg1Zb/nZrO4VQJwuW/PqAT5wv9YgXoz+6uuMg
         AEhDZPZsd9STs0biJCeGNl43zw0baC99jiEmm+2pTJhgZJ/ryFEIUhw+/gbgJzWkSODV
         OCqjOsk+KmD7bQl5p69rxkEEtUFvm73P1XATEb6iuOMz3C54Nk6z7a9WaPk5JwdAqtgQ
         HxAmw3Wzc8RN1mHAmDlDX9FnYxtloV9HbYJjQ6ECjHPcEOJRaSD64oE5t2nibVyic+Ob
         f7CFR3u886W8y2xChIs9I8km2dByW/KZwS+6Wng1hsFIbVAeM0yzEwWP6CCxDsxJ5SrN
         Yyzg==
X-Forwarded-Encrypted: i=1; AJvYcCU/NnhlGONQASZn57knNKC2ukmgEmmVE0NSsK61Sj7r394qb/WXid3Tu8sj7ionKrkqMJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQp75uQq2PJKMLoLsYAtt23xQA/zX6MnP0VtRe57eCJHq/8rwr
	m7PF8CA6A02hRUNS1kBhS+E/KMfUtV6DQs9jxDbCHvFcGajd5lNvIj6D2QnnaqUxW4sJLoe5Mkp
	q5d4MqGnU+UyaYoGdnWR1Vm7R+ok=
X-Google-Smtp-Source: AGHT+IHEod73FEOnvdsRoK0A8kBPBaNiy32VBWVuBwqTPim5hum045aot38CWmlJIXeXbK7o1SBq9ZJvuRQxXdb/oPI=
X-Received: by 2002:a05:6102:dc8:b0:4a4:8390:1e88 with SMTP id
 ada2fe7eead31-4a8711ce4c7mr287229137.25.1729729402491; Wed, 23 Oct 2024
 17:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
 <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com> <d9c997d7a9c8975ce845aa0cb4deaba22cbf3b94.1729669221.git.gitgitgadget@gmail.com>
 <ZxldBxx2R+fqVQZK@nand.local>
In-Reply-To: <ZxldBxx2R+fqVQZK@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 24 Oct 2024 00:23:10 +0000
Message-ID: <CAPSxiM9r3pLrLbyDXw6bYZKy6rZ+TtPeOCwB6c=rGh_ejXqKag@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] daemon: replace atoi() with strtoul_ui() and strtol_i()
To: Taylor Blau <me@ttaylorr.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:31=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Oct 23, 2024 at 07:40:18AM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > Replace atoi() with strtoul_ui() for --timeout and --init-timeout
> > (non-negative integers) and with strtol_i() for --max-connections
> > (signed integers). This improves error handling and input validation
> > by detecting invalid values and providing clear error messages.
> > Update tests to ensure these arguments are properly validated.
> >
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> >  daemon.c              | 12 ++++++++----
> >  t/t5570-git-daemon.sh | 26 ++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 4 deletions(-)
> >
> > diff --git a/daemon.c b/daemon.c
> > index cb946e3c95f..a40e435c637 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -4,6 +4,7 @@
> >  #include "abspath.h"
> >  #include "config.h"
> >  #include "environment.h"
> > +#include "gettext.h"
> >  #include "path.h"
> >  #include "pkt-line.h"
> >  #include "protocol.h"
> > @@ -1308,17 +1309,20 @@ int cmd_main(int argc, const char **argv)
> >                       continue;
> >               }
> >               if (skip_prefix(arg, "--timeout=3D", &v)) {
> > -                     timeout =3D atoi(v);
> > +                     if (strtoul_ui(v, 10, &timeout))
> > +                             die(_("invalid timeout '%s', expecting a =
non-negative integer"), v);
> >                       continue;
> >               }
> >               if (skip_prefix(arg, "--init-timeout=3D", &v)) {
> > -                     init_timeout =3D atoi(v);
> > +                     if (strtoul_ui(v, 10, &init_timeout))
> > +                             die(_("invalid init-timeout '%s', expecti=
ng a non-negative integer"), v);
> >                       continue;
> >               }
> >               if (skip_prefix(arg, "--max-connections=3D", &v)) {
> > -                     max_connections =3D atoi(v);
> > +                     if (strtol_i(v, 10, &max_connections))
> > +                             die(_("invalid max-connections '%s', expe=
cting an integer"), v);
> >                       if (max_connections < 0)
> > -                             max_connections =3D 0;            /* unli=
mited */
> > +                             max_connections =3D 0;  /* unlimited */
> >                       continue;
> >               }
> >               if (!strcmp(arg, "--strict-paths")) {
> > diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> > index c5f08b67996..722ddb8b7fa 100755
> > --- a/t/t5570-git-daemon.sh
> > +++ b/t/t5570-git-daemon.sh
> > @@ -8,6 +8,32 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
> >  . ./test-lib.sh
> >
> >  . "$TEST_DIRECTORY"/lib-git-daemon.sh
> > +
> > +test_expect_success 'daemon rejects invalid --init-timeout values' '
> > +     for arg in "3a" "-3"
> > +     do
> > +             test_must_fail git daemon --init-timeout=3D"$arg" 2>actua=
l_error &&
> > +             test_write_lines "fatal: invalid init-timeout ${SQ}$arg${=
SQ}, expecting a non-negative integer" >expected &&
>
> Hmmph. test_write_lines is typically called like
>
>     test_write_lines 1 2 3
>
> to write a file which contains three lines where each of the arguments
> appears on its own line.
>
> But here you pass a single argument, which causes us to write out a
> single line. Is there a reason for this? If not, I would expect us to
> write:
>
>     echo "fatal: invalid init-timeout ${SQ}$arg${SQ}, expecting a non-neg=
ative integer" >expect
>
> Or, perhaps even cleaner would be to do:
>
>     test_must_fail git daemon --init-timeout=3D"$arg" 2>err &&
>     test_grep "invalid init-timeout ${SQ}$arg${SQ}" err
>
Thanks and noted, I will use this approach.
I will send a new patch to fix this.
Usman
> since I don't think asserting on the actual error contents matching
> verbatim what we expect is adding all that much.
>
> (Also throughout you write 2>actual_err, but redirecting 2>err is more
> concise and in convention with the rest of the test suite's style).
>
> > +             test_cmp actual_error expected || return 1
> > +     done
> > +'
> > +
> > +test_expect_success 'daemon rejects invalid --timeout values' '
> > +     for arg in "3a" "-3"
> > +     do
> > +             test_must_fail git daemon --timeout=3D"$arg" 2>actual_err=
or &&
> > +             test_write_lines "fatal: invalid timeout ${SQ}$arg${SQ}, =
expecting a non-negative integer" >expected &&
> > +             test_cmp actual_error expected || return 1
> > +     done
> > +'
> > +
> > +test_expect_success 'daemon rejects invalid --max-connections values' =
'
> > +     arg=3D'3a' &&
> > +     test_must_fail git daemon --max-connections=3D3a 2>actual_error &=
&
> > +     test_write_lines "fatal: invalid max-connections ${SQ}$arg${SQ}, =
expecting an integer" >expected &&
> > +     test_cmp actual_error expected
> > +'
> > +
>
> Same notes from above in these two as well.
>
> Thanks,
> Taylor
