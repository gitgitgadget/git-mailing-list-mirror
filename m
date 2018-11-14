Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D68D1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 23:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeKOJSf (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 04:18:35 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40532 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOJSf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 04:18:35 -0500
Received: by mail-vs1-f68.google.com with SMTP id p193so10260437vsd.7
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 15:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fnh1X8otLsyLzGxzjUY5wpmC+zWy8GPFoUjHLkTclm0=;
        b=WOXjQHKxZeC2UiUevMbGuc26fBF1bfVXnkdhpZgqqb0tu2JSoEIxgRIYy81WvDOUIt
         DmhuflZlL4Qs1ko+1AE7iyMFVBruJfvsAVr1mCnfY41W73k4yRhTKY20Ss25+lygI+To
         DTntU6803gVlrXzCuHBHcGMcjEUe/0+W4k/lfNkpvV5gXbw53GIhpkdbQT0qco3SAqRS
         dJn4l4VKrNJ2NTbXvbMO3Xhxhu3KMg6ysmanxtDfjO64JUZI6gu3ferQjcvgrsRIzdCh
         hrG6q67gYywGcc6wOsCStkqOqejQPZMCWewzVXIZxRDnYssi6nFyLSnkde20sxAmXLDL
         qeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fnh1X8otLsyLzGxzjUY5wpmC+zWy8GPFoUjHLkTclm0=;
        b=bUL2aTdNmGLe0R4Rh7VOjEjpehfzscaokdObElsMKdUle3/gfGFhHOpr8p//COeYY3
         Duxqxg1oZOExsxS0fpedet61QdKItEgd8YKpFMDBg+mF3w96wehnE0j6Pqv0mU6H6ELd
         MAnXW4iETZhW/LWTJZyMEYEp40fM3cqykTxLwqwCp7XTwpgFTg/a1c9u7z6jkvRrbshH
         7hqrGgLVYDzkyPZWa3GHvcd/i7pEeP0Y4SYkuhQPhtV8GqVYQjDi27jkMaVwwoyCvSHc
         Fsb4Kd++6ONfXVG2ZhOShC+hrBczyMKyRDJkQuYU883Tx5vzRAyCDa54iKjSAGiuQyMT
         hwnA==
X-Gm-Message-State: AGRZ1gKJI1v2VoDXwyDWrCWYmM4FxnAZzF66wIp57WhVthJDU+xqq027
        NGYIBd3nFMJiN9LkX/TNPoBoyDA46C9kccqvRCM=
X-Google-Smtp-Source: AJdET5f+Mhq8mb7VxJoJbM7KVhmzPnBbwqL7qYgDyX91sIXaWc4lJIlSMb7EwLc7kbCkcsmQ23uKxW2mcVvuarBXYZw=
X-Received: by 2002:a67:3c5c:: with SMTP id j89mr1697119vsa.117.1542237195725;
 Wed, 14 Nov 2018 15:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20181111062312.16342-1-newren@gmail.com> <20181114002600.29233-1-newren@gmail.com>
 <20181114002600.29233-5-newren@gmail.com> <20181114191741.GJ30222@szeder.dev>
In-Reply-To: <20181114191741.GJ30222@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Nov 2018 15:13:04 -0800
Message-ID: <CABPp-BFGL_rbEydXASVSW=L+gZLcCOmfATdi=bmp0Kk4av90eg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] fast-export: avoid dying when filtering by paths
 and old tags exist
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 11:17 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Tue, Nov 13, 2018 at 04:25:53PM -0800, Elijah Newren wrote:
> > diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> > index af724e9937..b984a44224 100644
> > --- a/builtin/fast-export.c
> > +++ b/builtin/fast-export.c
> > @@ -774,9 +774,12 @@ static void handle_tag(const char *name, struct ta=
g *tag)
> >                                       break;
> >                               if (!(p->object.flags & TREESAME))
> >                                       break;
> > -                             if (!p->parents)
> > -                                     die("can't find replacement commi=
t for tag %s",
> > -                                          oid_to_hex(&tag->object.oid)=
);
> > +                             if (!p->parents) {
> > +                                     printf("reset %s\nfrom %s\n\n",
> > +                                            name, sha1_to_hex(null_sha=
1));
>
> Please use oid_to_hex(&null_oid) instead.

Will do.  Looks like origin/master:builtin/fast-export.c already had
two sha1_to_hex() calls, so I'll add a cleanup patch fixing those too.
