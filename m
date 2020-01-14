Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6589C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 23:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C4B222C3
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 23:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaMvWaiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgANXNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:13:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40590 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgANXNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 18:13:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id w21so14369566otj.7
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 15:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wANP7B9gh5q9kiCx22x5dIiwTPufOrnXxBQmO11wpos=;
        b=DaMvWaiYAMIlncw8khbMy8B/KG3e4HAeyVb617VEK1RrAr50dpbPqzA3Ddnc+hvGjW
         AaNUAn9aHgrERU31p3e0Va2RCnANVjAW+fzilz82o7lxIUI7xU/3N3aHzJx0c1QX4eLq
         a+gn31wXHDTDBHQ5QhSh8exaJMkoNrwPXxbrUmf1eK9eLfYOllmaX22/Vr9zL7HRjyuv
         iCF5o8KkGNkaZ/IjhO1so+GSzvkC85LqVzA1FtWXuGIj62Jc3JV6iFpoX/1Y1YMPYCQH
         1yXKkFXOpfCROdv/VScoYns+vGRYKs+zL3yw6tkic2Kd0/lbO6t47VXwbl220OAZJ8k4
         zRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wANP7B9gh5q9kiCx22x5dIiwTPufOrnXxBQmO11wpos=;
        b=cxIc3Uncht+U5YT5Y198LLgsgx6H9HbxL+tmP+7wfzZwZRPiXmE2Ero8mKSIVRFXBL
         Bx1IsXlEvTc8O6UoLPY9JCypR51OHjC3F59uEzGI6EWWznVyvB8B6DpBpKp3VojHRl0u
         SKyrU/Uc9BwoQm9e+82hgdq+IeJ5kFi46pc7SLFkRzwQ3TLvkdj3Kvrsfx+c/APVuKhM
         6BeOUM+nR3ZQqlKJim8FEiQMIg6OzA44pUZQx55kxEqTlGik96atJ48S8v5YWFHmnGkD
         8mW1N1Bq76wCWzbPRWZFhRmwtgEt7ndQvLOZJqYM06s2NhJcxVZDuL2/uWTGbRyfSNFy
         nfAw==
X-Gm-Message-State: APjAAAW15hvtXjijxqybYHdT9aeY+RGc3ZHwC5wLf+ftHhF70zzXzfFo
        yPsvGn28vl1zC/eB4MqOImCRqHC8JLZ1RF0Mu18=
X-Google-Smtp-Source: APXvYqzHA9YvJExCgbsZwp5ZJR8tGGNiCe1QcLN5B1ieQfFSo6Xw+Mk5Z7qY8x2rPtOvLfLYY0Ih8I2rCkoti3q7W4s=
X-Received: by 2002:a05:6830:16d1:: with SMTP id l17mr607793otr.21.1579043634496;
 Tue, 14 Jan 2020 15:13:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxWpLAnj3w8DGLMFbfy-A-pBjDxNdMeiM-fyuu-gnZyg+Q@mail.gmail.com>
 <20200114222802.GC3957260@coredump.intra.peff.net>
In-Reply-To: <20200114222802.GC3957260@coredump.intra.peff.net>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Wed, 15 Jan 2020 01:13:17 +0200
Message-ID: <CAHMHMxVajKxjBweG=mps0gLwE1o8M69DvPb1iUQYgLXx0VO5AA@mail.gmail.com>
Subject: Re: Git alias syntax help
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 15 Jan 2020 at 00:28, Jeff King <peff@peff.net> wrote:
>
> On Tue, Jan 14, 2020 at 05:21:20PM +0200, =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 wrote:
>
> > I am having an issue with git-aliases - specifically, the intricacies
> > involved in their syntax.
> >
> > In general, the syntax is confusing to me, especially when it is
> > _wise_ to use quotes inside a `!sh` alias.
> > e.g. which one would be the correct one
> > new =3D "!f() { : git log ; git log \"${1}@{1}..${1}@{0}\" \"$@\" ; } ;=
 f"
> > new =3D !f() { : git log ; git log "${1}@{1}..${1}@{0}" "$@" ; } ; f
>
> Only the first one is correct. In addition to the quotes in the second
> one being eaten by the config parser, the unquoted semicolon starts a
> comment.

Could somehow the latter "become" the correct option?
Especially in the case of `!sh`:
1) You need to quote everything after `=3D` sign ("forced" double quotes), =
then
2) `sh -c` needs another set (singles are most safe here, I think), and
3) If, for some reason, you need to quote further ("$@" would be a
common suspect usually)

Apart from the [1] feeling unneeded (the equivalent of Python's
`alias_cmd =3D cfg_line.split()[1]` could be enough), this brings a
quoting mess on [3]

> > The alias confusing me is more specifically this:
> > https://git.wiki.kernel.org/index.php/Aliases#simple_diff_ignoring_line=
_number_changes
> >
> > diffsort =3D !sh -c 'git diff "$@" | grep "^[+-]" | sort --key=3D1.2 | =
uniq -u -s1'
> >
> > The output of:
> > $  colordiff -su <(git diffsort HEAD^..HEAD) <(git diffsort HEAD^^..HEA=
D^)
> > Files /dev/fd/63 and /dev/fd/62 are identical
> > is a little unexpected, since I know for a fact that one of the
> > referced commits is not a code block moved.
>
> The issue here isn't with Git's alias mechanism, but a quirk of how "sh
> -c" works.  You can run with GIT_TRACE to see what we're passing to the
> shell (though note that your double-quotes don't make it through):
>
>   $ GIT_TRACE=3D1 git diffsort HEAD^..HEAD
>   17:22:47.644542 [pid=3D3959333] git.c:708           trace: exec: git-di=
ffsort HEAD^..HEAD
>   17:22:47.644648 [pid=3D3959333] run-command.c:663   trace: run_command:=
 git-diffsort HEAD^..HEAD
>   17:22:47.645038 [pid=3D3959333] run-command.c:663   trace: run_command:=
 'sh -c '\''git diff $@ | grep ^[+-] | sort --key=3D1.2 | uniq -u -s1'\''' =
HEAD^..HEAD
>   17:22:47.650319 [pid=3D3959336] git.c:439           trace: built-in: gi=
t diff
>
> The problem is that "sh -c" takes the first non-option argument as $0,
> not $1. For example:
>
>   $ sh -c 'echo 0=3D$0, @=3D$@' foo bar baz
>   0=3Dfoo, @=3Dbar baz
>
> You can add any extra string there to become $0, like:
>
>   diffsort =3D "!sh -c 'git diff \"$@\" | grep \"^[+-]\" | sort --key=3D1=
.2 | uniq -u -s1' --"
>
> which will do what you want. You can use whatever string you like, since
> you know that your "-c" snippet does not ever look at $0.
>
> -Peff

Thank you very much for a complete explaination of all of this .

Can some of this be documented somewhere?
Are they somewhere and I missed them?

If nothing more, a link to this e-mail chain either on the wiki (if
https://git.wiki.kernel.org/index.php/Aliases is an official page) or
on git-alias help (here
https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases or in some
"advanced" section, which I cannot find)

If https://git.wiki.kernel.org/index.php/Aliases is an official page,
then: was this written for an earlier version?
Could it also be updated?

--
Ntentos Stavros
