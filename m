Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C4C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596B420732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVN3FqO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgDMLPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgDMLPt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 07:15:49 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9AAC0A3BE2
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 04:15:49 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id f14so5038246ybr.13
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z6cLAPwJN/CSSlb+OjHBlHIKrwm5fVH87EGAlVveoFo=;
        b=RVN3FqO8LTIBs81p0xM5zoYNYNCkrT47xg+Z3ZoFHgyiUFwu9ix9rsYPJkJirxzL7Y
         Vi4oDq4luWVTLJqR6CiF1ySGfj0JJ9X6+MgdH9lRvVwfjCnn0mr7H+R6r9twCG2grLYQ
         QCuRWF3csmWvykfgDTWAt4sYRfEj/3SeJcIIHgSHFCyg18/us/aLbM9kM4Zt/Bq2G1Px
         IqVo0iVnMRanAOiN6d1AZfgKFndsqW8beBBhPGRKElgNkMogUhIR6/de547RBOh0nWmo
         M7Pscit3wRhzlcG9JYGttkhYuO7jyMo+ePizecHmE2eH5F4dm00E4RLCxP831wc8vT8P
         TW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z6cLAPwJN/CSSlb+OjHBlHIKrwm5fVH87EGAlVveoFo=;
        b=equnYe4eq1jmoTAQ18kPDOgHBGn50vLMulkVrO7TlEvhtVTDesnKmcT8twbAMdlyC5
         /iikacy2nAd6vHLBaBd4nK4t9GrZnmhA9ZUb5gPH9kE+i2PblUZ1rth1vo+kXugiV8MN
         fIS+lHXuYLvy9mqYTOr7eZ572m3wRcH76FyRrT75EwltlkkGP7bJWPCwiZTu3wFwP74a
         ypEJ2UQbYTWJKLAjVtuiDb5VlnoXBNGslu1MWuZcoc8oEWoBrslBUwhV/pch4XGyfZk3
         1tltBFOH2LayNu194M0jgKHbKARH7XQVqKDTKoc07/hPuIALR1c6nWE8sf+Jyt76rlN7
         4BlA==
X-Gm-Message-State: AGi0PubsH93QPUfEEjmZfYVhsb721NZTRrEPVn+Dlql9q7PojVSIKTi2
        l2JYhkHIY3t75uJV6E7pRMz83kUjBqX9fG2tQSIfF/7M
X-Google-Smtp-Source: APiQypK+gxHI9XZRDyv8TEZdBUyMYh/GRhZQNsNzMvIHcYW1mRPbkQwKrIsKRsF82ZaZ5eTYr8+8FimbvNk/P63jlYQ=
X-Received: by 2002:a25:4443:: with SMTP id r64mr26039803yba.41.1586776548277;
 Mon, 13 Apr 2020 04:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200407120813.25025-1-worldhello.net@gmail.com>
 <20200412133022.17590-2-worldhello.net@gmail.com> <xmqqa73ge9hj.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa73ge9hj.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 13 Apr 2020 19:15:37 +0800
Message-ID: <CANYiYbHyLw40sW49QCyMbBEEKgsdpWsScuuWSRAuPJSdxQ2NkQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] transport: not report a non-head push as a branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=884:26=E5=86=99=E9=81=93=EF=BC=9A
> > +make_user_friendly_and_stable_output () {
> > +     make_user_friendly_and_stable_output_common | sed \
> > +             -e "s#To ../upstream.git#To <URL/of/upstream.git>#"
>
> Break the line immediately after the pipe, and begin the next line
> with the command.  That way, the shell knows that you haven't
> finished giving the command at the end of the first line, and you do
> not have to use a backslash, i.e.
>
>     make_user_friendly |
>     sed -e 's/from/to/'

Will do.

> > +             cd workbench &&
> > +             # Try to make a stable fixed width for abbreviated commit=
 ID,
> > +             # this fixed-width oid will be replaced with "<OID>".
> > +             git config core.abbrev 7 &&
> > +             git remote add origin ../upstream.git &&
> > +             git update-ref refs/heads/master $A &&
> > +             git tag -m "v123" v123 $A &&
> > +             git push origin \
> > +                     $B:refs/heads/master \
> > +                     $A:refs/heads/next
> > +     ) &&
> > +     TAG=3D$(git -C workbench rev-parse v123) &&
> > +
> > +     # setup pre-receive hook
> > +     cat >upstream.git/hooks/pre-receive <<-\EOF &&
>
> Use write_script and you don't need the chmod at the end.

Yes, it's tedious to write chmod again and again.  Will replace all
the places for writing script.

> > +     #!/bin/sh
> > +
> > +     echo >&2 "# pre-receive hook"
> > +
> > +     while read old new ref
> > +     do
> > +             echo >&2 "pre-receive< $old $new $ref"
> > +     done
> > +     EOF
>
> Perhaps "exec >&2" upfront?

This works for "pre-receive" and "post-receive" script.  But in
"proc-receive" hook, stdout and stderr are different, and standard
output is used for protocol output.

> > diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
> > new file mode 100644
> > index 0000000000..6e400c0625
> > --- /dev/null
> > +++ b/t/t5411/common-functions.sh
> > @@ -0,0 +1,50 @@
>
> It is good that this omits "#!" and leaves the file without +x bit.
>
> > +# Format the output of git-push, git-show-ref and other commands to ma=
ke a
> > +# user-friendly and stable text.  We can easily prepare the expect tex=
t
> > +# without having to worry about future changes of the commit ID and sp=
aces
> > +# of the output.  We also replce single quotes with double quotes, bec=
ause
> > +# it is boring to prepare unquoted single quotes in expect txt.
>
> s/txt/text/

Will do. Found it for a long time, but forgot to correct it.

> > +                              (starts_with(ref->name, "refs/tags/")
> > +                               ? "[new tag]"
> > +                               : (starts_with(ref->name, "refs/heads/"=
)
> > +                                  ? "[new branch]"
> > +                                  : "[new reference]")),
> > +                              ref, ref->peer_ref, NULL, porcelain, sum=
mary_width);
>
> Now we say "outside refs/heads/ and refs/tags/, that's just a
> reference, different from branch".  OK.
>
> Do we ever update refs/remotes/ with this codepath?  Would we want
> to label it differently, i.e. as "remote-tracking branch"?

Can we call a reference (starts with "refs/remotes/") as a
remote-tracking branch, if it is on the remote side without a proper
remote and branch settings in .git/config?

Thanks.
