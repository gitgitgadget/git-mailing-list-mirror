Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4586EB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 07:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFZHvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZHvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 03:51:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD507128
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 00:51:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f14e14dc00so725285e87.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687765899; x=1690357899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gGGP2HQs/jF3oxsapR/n9QTh0dxibjVebsqS9qg4/4=;
        b=pzqdyGmjsiQqcvXFGk2eOrAEfY1hB0BtGxHyfDyLMWH0SPU589JRdRbKuSgtdIHhB6
         WNhWjtIzf6Hq5or8l/U1xpEdQFtcgIOiEYacuW9jGhLTHiPo5V71PeFHQPJ3Sj7Ae0+P
         k+r0MTHuj1YsG+PiXgqC67aP53yyqbI5FtEv4ZKyjeCmTsB7E+cVkkmP4YSkbqKLAakf
         DCc5WfeBXL10ycDdG7kNtfY9mCpmaYkTiVum+S2LCNhevAnkfZZy4Cjq175vKsKPOppO
         65Kw9WSJmP61pyB2oy86CpdCspcJ8Wu2n3vtwELVOGe14i8gl2oSZiIlc4tErXWnRFAS
         VA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687765899; x=1690357899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gGGP2HQs/jF3oxsapR/n9QTh0dxibjVebsqS9qg4/4=;
        b=DM4xxnXC0gWLVqAVSSNHWyqK0bSf+kLTW51ZNdx0hB5NigPxmBt84KqnGGmoUWOlF9
         Hx4ZtW+GFv4TxG4aGaZyUYBF0Rq7K4mXytB+1t6PZOLx/CF/vryNpcIW5i8FibHWiGTJ
         DCPHZLteYId1DPUKEL6txi7FSMef1jrIFD6Im+IzPQsZiyxvJCEJmxImnWzC/IB5BcVu
         a/KRGfcU4T8IaAy7AISRzq/cNfgG5EVRO00jdHfvrdrzoVhzSleM0Be/Nukzo4xIUv67
         klDveKAwasPEEinJu4BhIl/Asl7gtYf07LOOs+/lwcanruZDWrxRBhvQDL46snK5pKNo
         1dBw==
X-Gm-Message-State: AC+VfDzaLdjzFhxlrEgZr7dBho0Vf2+WG2k8Uaeo15CpIwtbDRzwcYwL
        qM0ITrgm8Amax4I5gWmZ9Pf9OQ9nGLPOuWIuTurrphGQt4M=
X-Google-Smtp-Source: ACHHUZ6IsO29hekBXBT1avSRoqyCjsSlMQKTHE+UXpvtPKDj+M63qBr7pD1StmHosRK7sW0nGqcz3dIB/XkDfHS0gqo=
X-Received: by 2002:a2e:b4ab:0:b0:2b4:750c:4d2 with SMTP id
 q11-20020a2eb4ab000000b002b4750c04d2mr10963576ljm.0.1687765898545; Mon, 26
 Jun 2023 00:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
 <20230624011234.GA95358@coredump.intra.peff.net>
In-Reply-To: <20230624011234.GA95358@coredump.intra.peff.net>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Mon, 26 Jun 2023 09:51:27 +0200
Message-ID: <CAHGBnuPO63Hi8mfA+MkAGES-gs0eNCDPG2FcPZT=YsnVzKd30A@mail.gmail.com>
Subject: Re: Clean up stale .gitignore and .gitattribute patterns
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Peff for the suggestion. I ended up scripting something via
JGit [1], as we're anyway using it as part of our Gradle build system.

PS: As a future idea, it might be good if "git mv" gives a hint about
updating .gitattributes if files matching .gitattributes pattern are
moved.

[1]: https://github.com/oss-review-toolkit/ort/pull/7195/commits/e01945d410=
12db2d0bc2e53d7be4abd513888ba6

--=20
Sebastian Schuberth

On Sat, Jun 24, 2023 at 3:12=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jun 23, 2023 at 05:29:42PM +0200, Sebastian Schuberth wrote:
>
> > is there a command to easily check patterns in .gitignore and
> > .gitattributes to still match something? I'd like to remove / correct
> > patterns that don't match anything anymore due to (re)moved files.
>
> I don't think there's a solution that matches "easily", but you can do a
> bit with some scripting. See below.
>
> For checking .gitignore, I don't think you can ever say (at the git
> level) that a certain pattern is useless, because it is inherently about
> matching things that not tracked, and hence generated elsewhere. So if
> you have a "*.foo" pattern, you can check if it matches anything
> _currently_ in your working tree, but if it doesn't that may mean that
> you simply did not trigger the build rule that makes the garbage ".foo"
> file.
>
> So with that caveat, we can ask Git which rules _do_ have a match, and
> then eliminate them as "definitely useful", and print the others. The
> logic is sufficiently tricky that I turned to perl:
>
> -- >8 show-unmatched-ignore.pl 8< --
> #!/usr/bin/perl
>
> # The general idea here is to read "filename:linenr ..." output from
> # "check-ignore -v". For each filename we learn about, we'll load the
> # complete set of lines into an array and then "cross them off" as
> # check-ignore tells us they were used.
> #
> # Note that we'd fail to mention an ignore file which matches nothing.
> # Probably the list of filenames could be generated independently. I'll
> # that as an exercise for the reader.
> while (<>) {
>   /^(.*?):(\d+):/
>     or die "puzzling input: $_";
>   if (!defined $files{$1}) {
>     $files{$1} =3D do {
>       open(my $fh, '<', $1)
>         or die "unable to open $1: $!";
>       [<$fh>]
>     };
>   }
>   $files{$1}->[$2] =3D undef;
> }
>
> # With that done, whatever is left is unmatched. Print them.
> for my $fn (sort keys(%files)) {
>   my $lines =3D $files{$fn};
>   for my $nr (1..@$lines) {
>     my $line =3D $lines->[$nr-1];
>     print "$fn:$nr $line" if defined $line;
>   }
> }
> -- >8 --
>
> And you'd use it something like:
>
>   git ls-files -o |
>   git check-ignore --stdin -v |
>   perl show-unmatched-ignore.pl
>
> Pretty clunky, but it works OK in git.git (and shows that there are many
> "not matched but probably still useful" entries; e.g., "*.dll" will
> never match for me on Linux, but is probably something we still want to
> keep). So I wouldn't use it as an automated tool, but it might give a
> starting point for a human looking to clean things up manually.
>
> For attributes, I think the situation is better; we only need them to
> match tracked files (though technically speaking, you may want to keep
> attributes around for historical files as we use the checked-out
> attributes during "git log", etc). Unfortunately we don't have an
> equivalent of "-v" for check-attr. It might be possible to add that ,but
> in the meantime, the best I could come up with is to munge each pattern
> to add a sentinel attribute, and see if it matches anything.
>
> Something like:
>
>   # Maybe also pipe in .git/info/attributes and core.attributesFile
>   # if you want to check those.
>   git ls-files '.gitattributes' '**/.gitattributes' |
>   while read fn; do
>         lines=3D$(wc -l <"$fn")
>         mv "$fn" "$fn.orig"
>         nr=3D1
>         while test $nr -le $lines; do
>                 sed "${nr}s/$/ is-matched/" <"$fn.orig" >"$fn"
>                 git ls-files | git check-attr --stdin is-matched |
>                 grep -q "is-matched: set" ||
>                 echo "$fn:$nr $(sed -n ${nr}p "$fn.orig")"
>                 nr=3D$((nr+1))
>         done
>         mv "$fn.orig" "$fn"
>   done
>
> It produces no output in git.git (we are using all of our attributes),
> but you can add a useless one like:
>
>   echo '*.c -diff' >>Documentation/.gitattributes
>
> and then the loop yields:
>
>   Documentation/.gitattributes:2 *.c -diff
>
> So I definitely wouldn't call any of that "easy", but it may help you.
>
> -Peff
