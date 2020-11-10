Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C24C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 11:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C9D20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 11:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6bscMqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKJLos (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 06:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJLor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 06:44:47 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE88C0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 03:44:47 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g15so11358370ybq.6
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 03:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O00VFvWSiDCthFpnw+ShV3bGpM6EwT4PXF83ViP+6ys=;
        b=T6bscMqZ368UhvXnJeyzuCOqktdKMPeFi+E7Wzu/jdI48VQin/fR01p9W84VFH+zI7
         EiJ6pnMFtLWAtdyp7M0zTsFlJY2e6x394yy+UBIiHYDcqC6cHW3PGfkSK3J2F2rO9Wk/
         ksU2hfomjxmqZKjqhAdn8ah2+LoOWkHFOUUSujdTiIUXAsZM22RjjkwzTt/3pw7i20Hr
         +bcr9KoI74dN+gBE/H8fbMmCvuT/CMzITADNW6dkmpULE80loEZ6fPAE2vVhtasoyXss
         Uajmd+l2UYE1/R7W9FoNt46o6kzfGqYfzruCKOq4Z9KWvUj4z/KiiSc8r0WbB61JGy8a
         6w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O00VFvWSiDCthFpnw+ShV3bGpM6EwT4PXF83ViP+6ys=;
        b=eiQrFyZOTv24plEfa2gpv7K5uF3DyGLkeNhe4BkxhWuGGsFOxuoq/Q11Jek+iPps/e
         SoZK4z0fuLP9S4sz8xV6do/PR82QJ1c9Fk9WAsrIwWfvJvB/hRy68HzOa7MmYIF72UsO
         7+u0lc4NTkpTpIZHzXmTqUBE1cY6h1BGNPBszBUd+UqhmLGhtNK32Z7yoQKVTlRSsB9Q
         gYkCRYMeteSAstfTJpfKAlhwQUNVU2w4aPgq2L7EdBnitpexgfJ3PKk4/IYvWYTiPgVg
         TBI2kKOYS5/Zr4Gmx9RlDNe0/IcOQmOMhWky69x/PsJUgzPVhPXC3wwIjqLdLOIBjsxq
         2rWw==
X-Gm-Message-State: AOAM5308goDPr2bQOh8ECo8biH5SteU5Hv8EZ+RnFazVkJ+qC2ya6bL8
        N30jKFSg2jNEVWNaepdak4nwHyxGL1ER5Ldf7y8=
X-Google-Smtp-Source: ABdhPJwUC9yojHAhOl7l0Z9sRro1OR0TXBWpuXDHeK/DQGyP7qqEuv9qKfJGvOBGo9RHP0VfreojPQuP29Ck9OR+cfY=
X-Received: by 2002:a25:dbd0:: with SMTP id g199mr22357614ybf.155.1605008686976;
 Tue, 10 Nov 2020 03:44:46 -0800 (PST)
MIME-Version: 1.0
References: <CANYiYbHQKshFg=1xAv8MFfSjmFfQ0uJRm3mQBnZMsTd1n7R-Ow@mail.gmail.com>
 <20201109105846.64303-1-zhiyou.jx@alibaba-inc.com> <xmqqh7pyb61f.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7pyb61f.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 10 Nov 2020 19:44:36 +0800
Message-ID: <CANYiYbEZu9Oq-X=o9aVzNz7BU=8HevnPCuGk=8VQSsz-o2BO6Q@mail.gmail.com>
Subject: Re: [PATCH v2] t5411: consistent result for proc-receive broken test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:59=E5=86=99=E9=81=93=EF=BC=9A
>
> > @@ -166,6 +177,8 @@ int cmd__proc_receive(int argc, const char **argv)
> >                               fprintf(stderr, "proc-receive> %s\n", ite=
m->string);
> >       }
> >
> > +     if (die_report)
> > +             die("die with the --die-report option");
>
> And at this point we have already read everything the other end
> said (if so, there is no need for the artificial "read everything
> before we die")?

In patch v3, will use "gently" forms of packet_write_fmt() and
packet_flush(), and it is no necessary to read everything before die.
And will add more "--die-*" option in test helper.

> > diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-=
protocol.sh
> > index c5fe4cb37b..5c5241bc95 100644
> > --- a/t/t5411/test-0013-bad-protocol.sh
> > +++ b/t/t5411/test-0013-bad-protocol.sh
> > @@ -55,19 +55,16 @@ test_expect_success "proc-receive: bad protocol (ho=
ok --die-version, $PROTOCOL)"
> >       test_must_fail git -C workbench push origin \
> >               HEAD:refs/for/master/topic \
> >               >out 2>&1 &&
>
> Are these expected to conflict with Dscho's changes to move 'master'
> around?

See topic "gitster/js/default-branch-name-adjust-t5411" has been merge
to master branch already. Will rebase on it.

> > -     make_user_friendly_and_stable_output <out >actual &&
> > -
> > +     make_user_friendly_and_stable_output <out |
> > +             sed -n \
> > +                     -e "/^To / { s/   */ /g; p; }" \
> > +                     -e "/^ ! / { s/   */ /g; p; }" \
> > +                     >actual &&
>
> It's the same thing but I somehow find "s/  */ /g" easier to read.
> The comparison is between "there may be two things or more---squish
> them down to one" and "After one thing, there may be any number of
> things---remove all the extra ones".
>
> Makes me wonder if make_user_friendly should optionally have an
> option to do something like this for us.  I doubt it that it is
> worth to do something like the attached patch.
>
>
>  t/t5411/common-functions.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git c/t/t5411/common-functions.sh w/t/t5411/common-functions.sh
> index 6580bebd8e..6919639c60 100644
> --- c/t/t5411/common-functions.sh
> +++ w/t/t5411/common-functions.sh
> @@ -40,7 +40,9 @@ create_commits_in () {
>  # `GIT_TEST_GETTEXT_POISON=3Dtrue` in order to test unintentional transl=
ations
>  # on plumbing commands.
>  make_user_friendly_and_stable_output () {
> -       sed \
> +       local en=3D
> +       case "$#" in 0) ;; *) en=3D-n ;; esac
> +       sed $en \
>                 -e "s/  *\$//" \
>                 -e "s/   */ /g" \
>                 -e "s/'/\"/g" \
> @@ -52,5 +54,6 @@ make_user_friendly_and_stable_output () {
>                 -e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
>                 -e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
>                 -e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git=
>#" \
> -               -e "/^error: / d"
> +               -e "/^error: / d" \
> +               ${1+"$@"}
>  }

If we call make_user_friendly_and_stable_output like this:

    make_user_friendly_and_stable_output \
         -e "/^To / { p; n; p; n; p; }

Text lines next to "^To " will not be formatted by the built-in sed's
arguments. So will write like this:

-- snip --
diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index 521a347710..b7cca2d8fb 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -42,7 +42,7 @@ create_commits_in () {
 make_user_friendly_and_stable_output () {
        sed \
                -e "s/  *\$//" \
-               -e "s/   */ /g" \
+               -e "s/  */ /g" \
                -e "s/'/\"/g" \
                -e "s/  /    /g" \
                -e "s/$A/<COMMIT-A>/g" \
@@ -52,5 +52,11 @@ make_user_friendly_and_stable_output () {
                -e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
                -e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
                -e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#=
" \
-               -e "/^error: / d"
+               -e "/^error: / d" | \
+       if test $# -eq 0
+       then
+               cat
+       else
+               sed ${1+"$@"}
+       fi
 }
-- snap --
