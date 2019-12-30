Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A30C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 14:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E322920722
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 14:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mit9aV/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfL3OnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:43:12 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39033 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfL3OnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 09:43:12 -0500
Received: by mail-ot1-f42.google.com with SMTP id 77so46464699oty.6
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 06:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwdJWVClQnXz+y1Um5v5Es1byahvwD9YSnSGX3zab1k=;
        b=Mit9aV/FUN4rECo/GD2PcipK5SBBMwFGHnn+DHQCdPsSikwnHv6bJZiW9nuzIb4mZP
         MyKZAGXpyKjit/2GtVT6CTAVO5l/v4q4Uk0ShjHHJLmitrg5/eY38kNpRs554SjZlx1A
         FAL/FEMEEpcIpqXxKCvx45yWHdHsw9+oB2KBnF1jKhouyi08+HN7WpbrXcJ5sQsR30kp
         4gkFurfyEROEwBkCpgrS3yg0Q6l4b7ayLtUHdaERuZgXe3r4XoSqPZOUbOEH2aDgPpj8
         i1U2mP+e29TAtfYiqzFiSMfkPpEw7OJ02UUKh2mgNXMWTw5qNdVqr10jQQe6aMM1Bjib
         hFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwdJWVClQnXz+y1Um5v5Es1byahvwD9YSnSGX3zab1k=;
        b=pEgZfm/+QH9Z/mbApicITHnTOeiCLwhKRPLISkrgC4T1C189FQW5yFSkzrFmWDtczj
         u+qtxdPzJEYEStqRRI2cEAEJTVS/o2VTq+pPF7LXcfKUqFhHlm015/p4LkRyl1YBWih7
         WcAzERdAm/0104VEJna/kTDbTdJRKEv+Y4RthMjQUPjWi+z++29g7RSltPFyi/RdxgwM
         Ra2CaFwLx08kxZhsq3+OxugHppj0p8lc0rq3fLYxqkwiAPzLXeU6LxkJ994LYe39NwuV
         6D0v2dd3e8vXT5ziGCOWgdrguhOeyNEt1MqIQQ8xOoQhG/+mGU6AyViI2n0e37THG68U
         HpzA==
X-Gm-Message-State: APjAAAXvi4pV4HhAnjDIyy7rYzfmepRTzSodbce5X3yViTc44svIAdo3
        rZVfZYOo/Tkz9/GAorhrkJE+xScTMX+QyiV6o0w9DtDF3V4=
X-Google-Smtp-Source: APXvYqwk0Kj/wa9EuN4WWqA3tqLeNNCAZM0HMucCkpJ4SG15f0TY8MqkDoegWvMxICsRSAxipMUHxsAtHT8+GryCKOI=
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr66698994otk.189.1577716991409;
 Mon, 30 Dec 2019 06:43:11 -0800 (PST)
MIME-Version: 1.0
References: <CALqn52MbeiCrEzphMkcjeU6bPbLLaQOa-vzht2156uqVw1wL_g@mail.gmail.com>
 <ea322b4c06dce0332ead3521e45514d10f2a76b8.camel@kaarsemaker.net>
In-Reply-To: <ea322b4c06dce0332ead3521e45514d10f2a76b8.camel@kaarsemaker.net>
From:   Adrien LEMAIRE <lemaire.adrien@gmail.com>
Date:   Mon, 30 Dec 2019 23:42:35 +0900
Message-ID: <CALqn52MwvhTZ-dAfpg+8VSOQdv84uFei07vYRSj5=jiTYtmPxg@mail.gmail.com>
Subject: Re: git filters don't get applied to dotfiles
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis, and thanks for looking into this.

I cannot reproduce this issue anymore, and it works as expected:

$ GIT_TRACE=2 config add .mailrc
23:31:05.135580 git.c:439               trace: built-in: git add .mailrc
23:31:05.135902 run-command.c:663       trace: run_command: 'sed -e
'\''s/gmail.com:.*@smtp/gmail.com:PASSWORD@smtp/'\'''

$ config diff --cached
diff --git a/.mailrc b/.mailrc
new file mode 100644
index 0000000..2698128
--- /dev/null
+++ b/.mailrc
@@ -0,0 +1,4 @@
+account gmail {
+  set v15-compat
+  set mta=smtp://lemaire.adrien%40gmail.com:PASSWORD@smtp.gmail.com:587
smtp-use-starttls
+}

To answer your question, yes I first added the file without a filter.
But I'm pretty sure I did a `config restore --staged .mailrc` after
creating the filter (and I actually repeated the operation several
times before contacting you the other day), but I must have been wrong
about that.
I didn't know about the GIT_TRACE environment variable. Thank you for
teaching me something, and sorry about the false bug report.

Best regards
Adrien

On Mon, Dec 30, 2019 at 1:02 AM Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
>
> On Fri, 2019-12-27 at 16:51 +0900, Adrien LEMAIRE wrote:
> > I'd like to report a bug regarding git filters not being applied to
> > files beginning with a dot character "."
> > Using git version 2.24.1
> > Please let me know if there is a better way to report bugs. The github
> > page only mentions this email.
>
> <snip reproduction recipe>
>
> I was not able to reproduce this in the git test suite with a quick
> patch (see below). Your output does not show any git add command, is it
> possible that you added the changes before configuring the filter?
>
> If you set GIT_TRACE=2 in your environment before doing the git add of
> the .mailrc file, you should see it run the filter command. It should
> look something like:
>
> + git add test test.t test.i .mailrc
> trace: built-in: git add test test.t test.i .mailrc
> trace: run_command: ./rot13.sh
> trace: run_command: ./rot13.sh
>
> (which is a part of the output of GIT_TRACE=2 ./t0021-conversion.sh -x
> -v -i)
>
>
> diff --git t/t0021-conversion.sh t/t0021-conversion.sh
> index 6c6d77b51a..32c27d513b 100755
> --- t/t0021-conversion.sh
> +++ t/t0021-conversion.sh
> @@ -77,6 +77,7 @@ test_expect_success setup '
>
>         {
>             echo "*.t filter=rot13"
> +           echo ".mailrc filter=rot13"
>             echo "*.i ident"
>         } >.gitattributes &&
>
> @@ -88,9 +89,10 @@ test_expect_success setup '
>         cat test >test.t &&
>         cat test >test.o &&
>         cat test >test.i &&
> -       git add test test.t test.i &&
> +       cat test >.mailrc &&
> +       git add test test.t test.i .mailrc &&
>         rm -f test test.t test.i &&
> -       git checkout -- test test.t test.i &&
> +       git checkout -- test test.t test.i .mailrc &&
>
>         echo "content-test2" >test2.o &&
>         echo "content-test3 - filename with special characters" >"test3 '\''sq'\'',\$x=.o"
> @@ -102,6 +104,7 @@ test_expect_success check '
>
>         test_cmp test.o test &&
>         test_cmp test.o test.t &&
> +       test_cmp test.o .mailrc &&
>
>         # ident should be stripped in the repository
>         git diff --raw --exit-code :test :test.i &&
> @@ -110,9 +113,12 @@ test_expect_success check '
>         test "z$id" = "z$embedded" &&
>
>         git cat-file blob :test.t >test.r &&
> +       git cat-file blob :.mailrc >.mailrc.r &&
>
>         ./rot13.sh <test.o >test.t &&
> -       test_cmp test.r test.t
> +       ./rot13.sh <test.o >.mailrc &&
> +       test_cmp test.r test.t &&
> +       test_cmp .mailrc.r .mailrc
>  '
>
>  # If an expanded ident ever gets into the repository, we want to make sure that
>
