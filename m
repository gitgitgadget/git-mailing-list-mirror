Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4598DEB64DB
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 04:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbjFOE6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 00:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbjFOE5t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 00:57:49 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63712121
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 21:57:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1b2ca09b9so20071681fa.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 21:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686805066; x=1689397066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt3nZkImIwsncerQcfCIffj/pC2YHSj4O0Rcybwff44=;
        b=HotGfAR49l1li7ze8somwFIeb3ZU6Lc0Mafl6tVickyxtc65jieuA8/NgMZ4kawQU8
         1ibQAod9kHNnZqPlI+OyugXTcPLi6NaE8KTqzUs+iAspoq6XGsdVEdQOmHnzmcMuUMsV
         JLxnjt0sXXR20oss+ggWAKIQY+6kiYMcOdX9MaDwYW6oqV/OAwJJK6lj8Oh1vJ1zl07c
         MUHuDoYicFXG9/MCk8TZbS14gXZGFsbxmeNgTcKilgansTHXAhlmVsjTWCI7n7K13wLy
         5pdE2FF0ktB9swIoJYrZZGtWiiSxdP6uf1Pyyw+WU6gi0cv1VoND3/LEmX/htkNVIwgy
         ozGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686805066; x=1689397066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt3nZkImIwsncerQcfCIffj/pC2YHSj4O0Rcybwff44=;
        b=iAGf/S6tq+Y8/2L6Ywo7+FWGAE2ZuSA1SCyCaR9kUGHhPHeuEnDL2rVF/0FI0r/pfi
         ctrmGUzIUOasqsp298pkdF9FsGtGj3WNENy3b93UT2yeI+9aPsG8CebuWKqmacBC5lcQ
         NpYjV8NpP8YcuHXrBwp3NITVYBZj2ugQyFa0BwPhh2lw/vaODbm3QgmmHJ1Coym/KbWl
         h+SdpdVrihPYNtDd4/WFzwvCB8J9MAd8zEHPf/FldJaUFxKYrWBxz5CoAOxKL1wyqxin
         0Mh087z7yZ420dKcLI0QNiw+xtnu4XW70MgtpF4o5+kvDpMMqgoA/obT2Qc2S+MAnWv4
         FpFg==
X-Gm-Message-State: AC+VfDyGNf6YFRoFgvbRedca+O67qMR82UPnUpPCuIFn+IdiVZh7cS8m
        YUyMYX98yQw51t6rnRp7Db9JAisjQI6pfHeLH3U=
X-Google-Smtp-Source: ACHHUZ5LqmC/KYPzQxcaMpEUw+h/aRJ85EcTD7Wc2PJGtgOdzQVVIcprkIfWu+S92RWSSNlGhBmHDzwKKlLhBQD7yz4=
X-Received: by 2002:a2e:94cc:0:b0:2b3:3197:37b3 with SMTP id
 r12-20020a2e94cc000000b002b3319737b3mr5643134ljh.44.1686805065592; Wed, 14
 Jun 2023 21:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
 <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com> <9b12f17dc7ebbab9b1625ad0c6058133b8a53323.1686778838.git.gitgitgadget@gmail.com>
 <20230614225116.GB1441072@coredump.intra.peff.net>
In-Reply-To: <20230614225116.GB1441072@coredump.intra.peff.net>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Thu, 15 Jun 2023 05:57:09 +0100
Message-ID: <CAGJzqsk-dNtPJFyqGxm_szi4f7Rj3uU7d_WiSybqeJqX5=4isg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] credential: erase all matching credentials
To:     Jeff King <peff@peff.net>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 14 Jun 2023 at 23:51, Jeff King <peff@peff.net> wrote:
>
> On Wed, Jun 14, 2023 at 09:40:38PM +0000, M Hickford via GitGitGadget wrote:
>
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > `credential reject` sends the erase action to each helper, but the
> > exact behaviour of erase isn't specified in documentation or tests.
> > Some helpers (such as credential-libsecret) delete all matching
> > credentials, others (such as credential-cache and credential-store)
> > delete at most one matching credential.
> >
> > Test that helpers erase all matching credentials. This behaviour is
> > easiest to reason about. Users expect that `echo
> > "url=https://example.com" | git credential reject` or `echo
> > "url=https://example.com\nusername=tim" | git credential reject` erase
> > all matching credentials.
> >
> > Fix credential-cache and credential-store.
>
> I think this was how it was intended to work all along, but I agree that
> credential-cache does not behave this way. I think credential-store
> already works, though.
>
> > diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> > index 0e6d9e85ec7..04bfb918de6 100644
> > --- a/Documentation/git-credential.txt
> > +++ b/Documentation/git-credential.txt
> > @@ -38,8 +38,8 @@ to any configured credential helpers, which may store the credential
> >  for later use.
> >
> >  If the action is `reject`, git-credential will send the description to
> > -any configured credential helpers, which may erase any stored
> > -credential matching the description.
> > +any configured credential helpers, which may erase stored credentials
> > +matching the description.
>
> I read the existing documentation as claiming to delete all such
> matching credentials, but I guess it is ambiguous (and I did not look,
> but it is almost a certainty that I wrote the original ;) ).
>
> Saying "credentials" in the plural makes it more clear we are getting
> all of them. But losing "any" makes it less clear to me. Maybe:
>
>   ...which may erase any stored credentials matching the description.
>
> is the best of both?

Will update in patch v3.

>
> > diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
> > index 100f045bb1a..65d652dc40e 100644
> > --- a/Documentation/gitcredentials.txt
> > +++ b/Documentation/gitcredentials.txt
> > @@ -260,7 +260,7 @@ appended to its command line, which is one of:
> >
> >  `erase`::
> >
> > -     Remove a matching credential, if any, from the helper's storage.
> > +     Remove matching credentials, if any, from the helper's storage.
>
> This one seems like a strict improvement in ambiguity.
>
> > diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> > index 82f376d3351..5e3a766e42d 100644
> > --- a/builtin/credential-cache--daemon.c
> > +++ b/builtin/credential-cache--daemon.c
> > [...]
> > @@ -48,9 +48,12 @@ static void remove_credential(const struct credential *c)
> >  {
> >       struct credential_cache_entry *e;
> >
> > -     e = lookup_credential(c, c->password != NULL);
> > -     if (e)
> > -             e->expiration = 0;
> > +     int i;
> > +     for (i = 0; i < entries_nr; i++) {
> > +             e = &entries[i];
> > +             if (credential_match(c, &e->item, c->password != NULL))
> > +                     e->expiration = 0;
> > +     }
> >  }
>
> OK, so now instead of looking up a single credential, we loop and cover
> them all. That makes perfect sense. It is a little funny that we undo
> the extra parameter to lookup_credential() that was added in the
> previous commit.  I wonder if reversing the order of the patches would
> make it simpler, but it is probably not a big deal either way.
>
> > diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> > index e0ae028b1c3..85b147e460f 100644
> > --- a/builtin/credential-store.c
> > +++ b/builtin/credential-store.c
> > @@ -36,7 +36,8 @@ static int parse_credential_file(const char *fn,
> >                       found_credential = 1;
> >                       if (match_cb) {
> >                               match_cb(&entry);
> > -                             break;
> > +                             if (strcmp(op, "erase"))
> > +                                     break;
> >                       }
> >               }
> >               else if (other_cb)
>
> I think this hunk does nothing. When the op is "erase", we do not pass a
> match_cb at all, so this break would never trigger (and indeed, it would
> be disastrous if it did, because we would stop copying entries from the
> old file to the new, losing everything after the matched entry).
>
> And I think if you revert this, your new test still passes.

You're right. I'll revert in patch v3.

>
> > @@ -298,6 +300,37 @@ helper_test() {
> >               EOF
> >       '
> >
> > +     test_expect_success "helper ($HELPER) erases all matching credentials" '
> > +             check approve $HELPER <<-\EOF &&
> > +             protocol=https
> > +             host=example.com
> > +             username=user6
> > +             password=pass1
> > +             EOF
> > +             check approve $HELPER <<-\EOF &&
> > +             protocol=https
> > +             host=example.com
> > +             username=user7
> > +             password=pass1
> > +             EOF
> > +             check reject $HELPER <<-\EOF &&
> > +             protocol=https
> > +             host=example.com
> > +             EOF
> > +             check fill $HELPER <<-\EOF
> > +             protocol=https
> > +             host=example.com
> > +             --
> > +             protocol=https
> > +             host=example.com
> > +             username=askpass-username
> > +             password=askpass-password
> > +             --
> > +             askpass: Username for '\''https://example.com'\'':
> > +             askpass: Password for '\''https://askpass-username@example.com'\'':
> > +             EOF
> > +     '
>
> The test makes sense. We add two, delete them both, and then check that
> nothing is left to serve.
>
> -Peff
