Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpyrDjOr"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD444100
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 08:06:52 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so8284306a12.2
        for <git@vger.kernel.org>; Tue, 12 Dec 2023 08:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702397211; x=1703002011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlIkiZubQVuliJHZzCxN5908f/WdATwjwRFbTvfj/rA=;
        b=dpyrDjOrXwNCkktJGCE8MYtVB/ebVQv19OtHvEkJhtyHlufIwT+9/gpVYUEQsZ6r/A
         CbjjMfrZq/08CpzFS5neV68TngPmjdxbeWIuGQjwt/2/R8HRr15nxGBnIwCq+tmQoFFM
         EenfSPK5sOOtEVcok76Mxs0qxYpGIIlsBUuTNpR4lScBSi4UIyhIUB5H3flZKU7WcVss
         qTCRBD7w9GdzP0VM2wh6N8+/CL2ziSAdGxSd6qz2DiXCz0ndaFcfs3cU8XaVyOKNBi0y
         Eyby2mNzqVasCOYZru5rwEBuGRU5AirM/GRmyimg3qJKa6Iqg8sVAJfYlofsJVXzb9dl
         7uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397211; x=1703002011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlIkiZubQVuliJHZzCxN5908f/WdATwjwRFbTvfj/rA=;
        b=ns0B7XTvpkhmTAI1xVnOmGYTZHDwyd5M1Cknijv84GuVn8iqMlJEOZSSwT7q1Jahuq
         rn7lpHsjerrXg5P8lz8FWkF03kdUHw5z8eG2/ECJOJvlVrqF/RHDaNc+KDzn6OYxieR5
         Mj+3My1WoBeIjLyAsXhmTkP5de/yuIBuuiZxY4/S0Mtg6hTzAYRsIMOsNR0rDaoYwaWV
         6IxMj/ukS4LBfO3C4lsCbLeAdrnCH2oxZI69v/2rHGr6UCX9HGqp+PAEhzQz+E0tlkOX
         km3uCSfY0INXvbQ7RWj4BQdUralr19t9rStIaaBsxia+EzzvC/y5gjfDoXBakvLw82Wq
         0Wrg==
X-Gm-Message-State: AOJu0YyE+MjVLWYsQ3OLf7z/sDzdpuYS+pK04tF17SifRZWAuk1ve8hp
	xmkKgQSGhuNhFCGzGZQK7KrLgKLtsclC9LyroyKFcPwISpc=
X-Google-Smtp-Source: AGHT+IExI8pktqtoVzq+qUe9f9Xvbylf7yu4PwI7if2qlCZB0hVjR2mSV8X/WdfDto3BYZ3i8JqM+J/Lu/lSnwDUom8=
X-Received: by 2002:a17:906:1d:b0:a1b:60f9:df01 with SMTP id
 29-20020a170906001d00b00a1b60f9df01mr2635675eja.38.1702397210691; Tue, 12 Dec
 2023 08:06:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
 <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com> <CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
 <CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com>
In-Reply-To: <CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 12 Dec 2023 17:06:38 +0100
Message-ID: <CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com>
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees present
To: Zach FettersMoore <zach.fetters@apollographql.com>
Cc: Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 4:39=E2=80=AFPM Zach FettersMoore
<zach.fetters@apollographql.com> wrote:
>
> >>
> >> From: Zach FettersMoore <zach.fetters@apollographql.com>

> >> To see this in practice you can use the open source GitHub repo
> >> 'apollo-ios-dev' and do the following in order:
> >>
> >> -Make a changes to a file in 'apollo-ios' and 'apollo-ios-codegen'
> >> directories
> >> -Create a commit containing these changes
> >> -Do a split on apollo-ios-codegen
> >> - Do a fetch on the subtree repo
> >> - git fetch git@github.com:apollographql/apollo-ios-codegen.git
> >> - git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
>
> > Now I get the following without your patch at this step:
> >
> > $ git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
> > [...]/libexec/git-core/git-subtree: 318: Maximum function recursion
> > depth (1000) reached
> >
> > Line 318 in git-subtree.sh contains the following:
> >
> > missed=3D$(cache_miss "$@") || exit $?
> >
> > With your patch it seems to work:
> >
> > $ git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
> > Merge made by the 'ort' strategy.
> > e274aed3ba6d0659fb4cc014587cf31c1e8df7f4
>
> Looking into this some it looks like it could be a bash config
> difference? My machine always runs it all the way through vs
> failing for recursion depth. Although that would also be an issue
> which is solved by this fix.

I use Ubuntu where /bin/sh is dash so my current guess is that dash
might have a smaller recursion limit than bash.

I just found https://stackoverflow.com/questions/69493528/git-subtree-maxim=
um-function-recursion-depth
which seems to agree.

I will try to test using bash soon.

> >> - Depending on the current state of the 'apollo-ios-dev' repo
> >> you may see the issue at this point if the last split was on
> >> apollo-ios
>
> > I guess I see it, but it seems a bit different for me than what you des=
cribe.
> >
> > Otherwise your patch looks good to me now.
>
> Yea I hadn't accounted for/realized that some folks may see a recursion
> depth error vs it just taking a long time like it does for me. Also what
> I was saying with the apollo-ios-dev repo is you may not need all the ste=
ps
> to see the issue, because its possible the state of the repo is already
> in a position to display the issue just by doing a split on
> apollo-ios-codegen.
>
> Great! Thanks again for all the feedback and guidance! Is there anything
> else I need to do to get this across the finish line and merged in?

Hopefully I will be able to confirm I see the same error as you with
bash soon, and it will be enough to get it merged.
