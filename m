Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B59EC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 08:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjBAIak (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 03:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBAIae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 03:30:34 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A4F976F
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 00:30:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g9so9996897pfk.13
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 00:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+EW3qDMMjwKBJ9Zoy5a3yYLqa0SlEMOipieWm9zODU=;
        b=O/3pxnOM/yJe7J6/Zu7s+a6f3imeVzadB3+4kg0ldKTd8bvUI325BO/MPAvBMVN/+t
         GRTydYf3Ebbf9q7dtqhJofZC+azIJELFEZw7viz+4a0xZjnDqxtMriUJSZXsCzUNbF6k
         iTrCfzJecI+UktKxHYUxYxUCJx8SUv5IhurHvPbpWZKTA6xMpJnzlcBEuPCONwS6glrW
         jYwESLnUu4C4Zqgnhir9S7QLCvhRxs3cXugGK6+f3rw14zfCst3t09gDTUU6MrW5ez4U
         cvHT4awZUepksdnFON/3t7RLIDpRZTUTkcOH7fyTrv0cqIbt3bXkgJWT+12dliaLE7Kg
         WwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+EW3qDMMjwKBJ9Zoy5a3yYLqa0SlEMOipieWm9zODU=;
        b=jYiH4FY4530BEIaUqdiaNOeH/O2ezYrw40pxY1/NIPgxTjYkrJU1W56x5H07G+jVGk
         uRuCVP9W9XmmzYxCZnITz+TgtG4oUgCN72MYAJ+cGDyh3md7DGLVev2ABKCk8+sPzDO+
         tgTI+Qa6dXP/5u2TMKDee1G0FLxTdqESzW662wkRzJbcMfULv09HVzv3NF3O13o2qCT4
         SbLScg7x3LuhpMdy9k6HzcTvfk9S4pXeQWOOzslGkJlU/o6KwrnmgvB+QiOQHmbdLagn
         BlTb2YxWEbIlBY0TpfRYV6Z/YP7Q40JxdYS/jkbvp1U4e2238SvphYCulpWNOdC+Y4sG
         wBWA==
X-Gm-Message-State: AO0yUKXm+PfK86d+kZ0GMM9MEYlE1lkhx73HV/+eX2+anuDS54gAPY/o
        XT0I0ex49f6ke/c2nnxcRWkndMQLcr6LBXzTW48sgrljjNu2lQ==
X-Google-Smtp-Source: AK7set9+z6fvTXUH9cu508NtWMaZeT1h+r/xAzveYrB14XUUge12vmaHibSZ7NYia3y1jTQCtGheMCaTmcLJptjhN6o=
X-Received: by 2002:a65:5a41:0:b0:4da:a8a3:339a with SMTP id
 z1-20020a655a41000000b004daa8a3339amr256125pgs.28.1675240232742; Wed, 01 Feb
 2023 00:30:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com> <xmqqpmax5c4v.fsf@gitster.g>
In-Reply-To: <xmqqpmax5c4v.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Wed, 1 Feb 2023 08:29:56 +0000
Message-ID: <CAGJzqskO0sGNtuuSkKWxknh1qv523TfA3U17X_9higDdYdg+PA@mail.gmail.com>
Subject: Re: [PATCH] credential: new attribute password_expiry_utc
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 29 Jan 2023 at 20:17, Junio C Hamano <gitster@pobox.com> wrote:
>
> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > If password has expired, credential fill no longer returns early,
> > so later helpers can generate a fresh credential. This is backwards
> > compatible -- no change in behaviour with helpers that discard the
> > expiry attribute. The expiry logic is entirely in the git credential
> > layer; compatible helpers simply store and return the expiry
> > attribute verbatim.
> >
> > Store new attribute in cache.
>
> It is unclear what you are describing in the above.  The current
> behaviour without the patch?  The behaviour of the code if this
> patch gets applied?  Write it in such a way that it is clear why
> the patch is a good idea, not just "this would not hurt because it
> is backwards compatible".
>
> The usual way to do so is to sell your change in this order:
>
>  - Give background information to help readers understand what you
>    are going to write in the following explanation.
>
>  - Describe the current behaviour without any change to the code;
>
>  - Present a situation where the current code results in an
>    undesirable outcome. What exactly happens, what visible effect it
>    has to the user, how the code could do better to help the user?
>
>  - Propose an updated behaviour that would behave better in the
>    above sample situation presented.
>

Thanks for the guidance. Writing a better commit message clarified my
own thoughts.

> Curiously, what you wrote below the "---" line, that will not be
> part of the log message, looks to be organized better than the
> above.  The first paragraph (except for the "Add ...") prepares the
> readers, It is still unclear if the second paragraph "when expired"
> describes what happens with the current code (i.e. highlighting why
> a change is needed) or what you want to happen with the patch, but
> the paragraph should first explain the problem in the current
> behaviour to motivate readers to learn why the updated code would
> lead to a better world.  And follow that with the behaviour of the
> updated code and its effect (e.g. "without first trying a credential
> that is stale and see it fail before asking to reauthenticate, such
> a known-to-be-stale credential gets discarded automatically").
>
>
> > +`password_expiry_utc`::
> > +
> > +     If password is a personal access token or OAuth access token, it =
may have an expiry date. When getting credentials from a helper, `git crede=
ntial fill` ignores the password attribute if the expiry date has passed. S=
torage helpers should store this attribute if possible. Helpers should not =
implement expiry logic themselves. Represented as Unix time UTC, seconds si=
nce 1970.
> > +
>
> A overly long line.  Please follow Documentation/CodingGuidelines
> and Documentation/SubmittingPatches
>
> > diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-ca=
che--daemon.c
> > index f3c89831d4a..5cb8a186b45 100644
> > --- a/builtin/credential-cache--daemon.c
> > +++ b/builtin/credential-cache--daemon.c
> > @@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
> >               if (e) {
> >                       fprintf(out, "username=3D%s\n", e->item.username)=
;
> >                       fprintf(out, "password=3D%s\n", e->item.password)=
;
> > +                     if (e->item.password_expiry_utc !=3D 0) {
> > +                             fprintf(out, "password_expiry_utc=3D%ld\n=
", e->item.password_expiry_utc);
> > +                     }
>
> Style (multiple issues, check CodingGuidelines):
>
>                 if (e->item.password_expiry_utc)
>                         fprintf(out, "... overly long format template ...=
",
>                                 e->item.password_expiry_utc);
>
>  * Using integral value or pointer value as a truth value does not
>    require an explicit comparison with 0;
>
>  * A single-statement block does not need {} around it;
>
>  * Overly long line should be folded, with properly indented.
>
> > diff --git a/credential.c b/credential.c
> > index f6389a50684..0a3a9cbf0a2 100644
> > --- a/credential.c
> > +++ b/credential.c
> > @@ -7,6 +7,7 @@
> >  #include "prompt.h"
> >  #include "sigchain.h"
> >  #include "urlmatch.h"
> > +#include <time.h>
>
> Don't include system headers directly; often git-compat-util.h
> already has it, and if not, we need to find the right place to have
> it in git-compat-util.h file, as there are platforms that are
> finicky in inclusion order of the header files and definition of
> feature macros.
>
> > @@ -21,6 +22,7 @@ void credential_clear(struct credential *c)
> >       free(c->path);
> >       free(c->username);
> >       free(c->password);
> > +     c->password_expiry_utc =3D 0;
>
> Not a huge deal, but if the rule is "an credential with expiry
> timestamp that is too old behaves as if it no longer exists or is
> valid", then a large integer, not zero, may serve as a better
> sentinel value for "this entry never expires".  Instead of having to
> do
>
>         if (expiry && expiry < time()) {
>                 ... expired ...
>         }
>
> you can just do
>
>         if (expiry < time()) {
>                 ... expired ...
>         }
>
> and that would be simpler to understand for human readers, too.
>
> > @@ -234,11 +236,23 @@ int credential_read(struct credential *c, FILE *f=
p)
> >               } else if (!strcmp(key, "path")) {
> >                       free(c->path);
> >                       c->path =3D xstrdup(value);
> > +             } else if (!strcmp(key, "password_expiry_utc")) {
> > +                     // TODO: ignore if can't parse integer
>
> Do not use // comment.  /* Our single-liner comment reads like this */
>
> > +                     c->password_expiry_utc =3D atoi(value);
>
> Don't use atoi(); make sure value is not followed by a non-number,
> e.g.
>
>         const char *value =3D "43q";
>         printf("%d<%s>\n", atoi(value), value);
>
> would give you 43<43q>, but you want to reject and silently ignore
> such an expiry timestamp.
>
> > +             // if expiry date has passed, ignore password and expiry =
fields
>
> Ditto, but if you used a large value as sentinel for "never expires"
> and wrote it like this
>
>                 if (c->password_expiry_utc < time(NULL)) {
>
> then it is clear enough that you do not even need such a comment.
> The expression itself makes it clear what is going on (i.e. the
> current time comes later than the expiry_utc value on the number
> line hence it appears on the right to it, clearly showing that it
> has passed the threshold).
>
> > +             if (c->password_expiry_utc !=3D 0 && time(NULL) > c->pass=
word_expiry_utc) {
> > +                     trace_printf(_("Password has expired.\n"));
> > +                     FREE_AND_NULL(c->username);
> > +                     FREE_AND_NULL(c->password);
> > +                     c->password_expiry_utc =3D 0;
> > +             }
> > +
