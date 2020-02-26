Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B096C4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 18:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A7520578
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 18:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QupKfDQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBZS7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:59:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35991 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgBZS7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 13:59:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so449812wma.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 10:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=20YSD6DOvZ/xFY8KjyljzJPZ/fIdTpfB/Z3o4wtfz3A=;
        b=QupKfDQBbMqJVK40Ud9zys/0cw6Ge6qhDr1PCxfD+naMW0oLnf93mwmLR58qtEOIGq
         3sO3UDRmvBGPTkSCRT8InRZuuNE+QT6z3w8a8zSDvsQIwKygUno/Z1QAwY+m6FfPfaGR
         DQJr12uNhfJSks8AQe3mA77BdsiAPEeNPKbP4gPMvXxk7Yk1bLJJQ3hF7cz4DKC2vvot
         olxy28zl5SnDG7TU57RiphxW+XnQKQHFoFt8KczBq72917HiIEy3IAuWMuLwJvQy7Hcd
         S0/oTEIOlGAqJeslGz2CrtmyiccQqZl2P42ytd42aUqsU2MHN5EzXLBFQawqt17NBARu
         KN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=20YSD6DOvZ/xFY8KjyljzJPZ/fIdTpfB/Z3o4wtfz3A=;
        b=i1LlI0ymq1chSV95GV+nmzhXm+s7vELd3LdJhvgS0zLJHAO9/tAQkas4EYaihfIjdL
         dyGUnl+3snhs3YeDiExyofi7vYJo8MJ5Dnr1QmbRh7zcs8pb5lIEQmhjUFl/i22QTGA/
         hWMy56+iiso2TS3qlx2xME5yo6fbIEkvHg8ojO6ezJZzPFMoZhcxtua1y9uW5at/pBMt
         unwoSjslXo/hb7iSxahygG0DKpS64ftSlsaiUxX3VzcBGG/X1CgjbSru6cyC9+BUWsBw
         MeCRVz7kyFUs3aeCcKoFX17+IODiezZn2mFKhtcI5/WlmhcuZoA2UL4dsztSKCRujU1m
         JJiQ==
X-Gm-Message-State: APjAAAVDRZBIkp5nRd5j2WTJgyWJo0NQwz8povXu4XKMzqFtAlx1NnTI
        sr/XWzDZUSzbaKSMRkdELlIcIxmI07LKc493WCVVRw==
X-Google-Smtp-Source: APXvYqyAOFgIb0t5CuxXGk2pa6amKqQlTsTbGUOG0OuEq+bKonceINr/p59HGVSW6FC6zG89pJm1anhbR+smaVwvEbQ=
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr280249wmf.63.1582743554138;
 Wed, 26 Feb 2020 10:59:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
 <pull.539.v7.git.1582706986.gitgitgadget@gmail.com> <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
 <xmqq8skpjjyz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8skpjjyz.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 26 Feb 2020 19:59:02 +0100
Message-ID: <CAFQ2z_PikWsjFizg8=e9+YunkiaciD64BDks8=J55185NC5oQg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] Reftable support for git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 7:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> > diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
> > new file mode 100755
> > index 00000000000..d35211c9db2
> > --- /dev/null
> > +++ b/t/t0031-reftable.sh

Thanks for your careful review. Should we not start with the C code,
though? I've written the reftable library to my best ability, but it
hasn't been peer reviewed yet.

> > +test_expect_success 'basic operation of reftable storage' '
> > +        git init --ref-storage=3Dreftable repo &&
>
> Test script bodies are supposed to be indented with HT, not 8 SPs.

Done

> > +        cd repo &&
>
> You are not supposed to chdir around inside tests, unless you do so
> in a subshell.  i.e.
>
>         test_expect_success 'basic operation' '
>                 git init --ref-storage=3Dreftable repo &&
>                 (
>                         cd repo &&

Done.

> > +        echo "hello" > world.txt &&
>
> A shell redirection operator should immediately be followed by the
> filename without SP in between, i.e.

Done.

>         echo hello >world.txt &&
>
> > +        git add world.txt &&
> > +        git commit -m "first post" &&
> > +        printf "HEAD\nrefs/heads/master\n" > want &&
>
> There is an easier-to-read helper.  Also, by convention, the file
> that holds the expected state is called "expect", while the file
> that records the actual state observed is called "actual".

Done

>         test_write_lines HEAD refs/heads/master >expect &&
>
> > +        git show-ref | cut -f2 -d" " > got &&
>
> Is the order of "show-ref" output guaranteed in some way?  Otherwise
> we may need to make sure that we sort it to keep it stable.

The ref iteration result is lexicographically ordered.

> Without --show-head, HEAD should not appear in "git show-ref"
> output, but the expected output has HEAD, which is puzzling.

The HEAD symref is stored in reftable too, and to the reftable code
it's just another ref. How should we refactor this? Shouldn't the
files ref backend produce "HEAD" and then it's up to the show-ref
builtin to filter it out?

> We will not notice if a "git" command that placed on the left hand
> side of a pipeline segfaults after showing its output.
>
> People often split a pipeline like this into separate command for
> that reason (but there is probably a better way in this case, as we
> see soon).
>
> > +        test_cmp got want &&
>
> Taking the above comments together, perhaps
>
>         test_write_lines refs/heads/master >expect &&
>         git for-each-ref --sort=3Drefname >actual &&
>         test_cmp expect actual &&
>
> > +        for count in $(test_seq 1 10); do
> > +                echo "hello" >> world.txt
> > +                git commit -m "number ${count}" world.txt
> > +        done &&
>
> Style: write "do" on its own line, aligned with "for" on the
> previous line.  Same for "if/then/else/fi" "while/do/done" etc.

Done.

>     An easy way to remember is that you never use any semicolon in
>     your shell script, except for the double-semicolon you use to
>     delimit your case arms.
>
> When any of these steps fail, you do not notice it, unless the
> failure happens to occur to "git commit" during the last round.  I
> think you can use "return 1" to signal the failure to the test
> framework, like so.
>
>         for count in $(test_seq 1 10)
>         do
>                 echo hello >>world.txt &&
>                 git commit -m "number $count} world.txt ||
>                 return 1
>         done &&

Done.

>         ls -1 .git/reftable >files &&
>         test_line_count =3D 2 files
>

Done.

> > +        git reflog refs/heads/master > output &&
> > +        grep "commit (initial): first post" output &&
> > +        grep "commit: number 10" output
>
> Do we give guarantees that we keep all the reflog entries?  Would it
> help to count the number of lines in the output file here?

The reflog entries are only removed if someone calls into the ref
backend to expire them. Does that happen automatically?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
