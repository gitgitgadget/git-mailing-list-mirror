Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4132EC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 11:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F26E61185
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 11:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhFNL60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:58:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:40281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233240AbhFNL6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 07:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623671769;
        bh=KdazNBJt07EVMAKeXMRmX6gcpLoKODfmM1rtLQAJbos=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BgGecidBx7H1/oKr8kR5jPeiVDOo6YhwYxGS6TIvNGKu5fUMuGQee5NNIuf5Jun5j
         m4t/VV3XtmXllrLepXeClzkvn1uAtUhiIzuqmff0PoDtEhxHJDjv6+QyIUDjdsdwuD
         DUMjoxHgqHXZvqO8rBk/qPZRfT6+zOeJP/b2h7tI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1l5cWB3t4N-00wBVB; Mon, 14
 Jun 2021 13:56:09 +0200
Date:   Mon, 14 Jun 2021 13:56:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Shumaker <lukeshu@lukeshu.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work
 on Windows
In-Reply-To: <875yyk7c3j.wl-lukeshu@lukeshu.com>
Message-ID: <nycvar.QRO.7.76.6.2106141330410.57@tvgsbejvaqbjf.bet>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com> <a91ac6c18938116c4a74e19466da456b67376fa5.1623316412.git.gitgitgadget@gmail.com> <87bl8d6xoq.wl-lukeshu@lukeshu.com> <nycvar.QRO.7.76.6.2106111213050.57@tvgsbejvaqbjf.bet>
 <875yyk7c3j.wl-lukeshu@lukeshu.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XFKgNvlgaKyWi+LcmORKaIO7Doz8SJj1BmoYyeTFfBhg7xjZhvs
 Jpkm9fWOSMqQ1J/XrNJhUUdqBmwxjwBUaIxf4eP49ofVXvK42M0IRVT1aU62lnaTrGCR97G
 ecJcCUJOj7Q6esQwoDtA3nPf0v5DoOD6tBIqLzgA5MP8GpohT6hClSRXZjSvyPqYz/HcyDc
 lGGK+qKOUXq2QgH+NlaQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j2HUdIWlLSI=:v0Pgmyir/0v9bUFNqQxfDb
 9ct1ZPUdZdGAYoO47/DqIHewi59M2lW7xSv1CYwYXJFCjRgqkfl8ReYchZuCVjwi80iwMdTdQ
 GHc/ob2efmsCE0FUxNgplKXwBB4tJB/Y1DFHKFWhMfSJb7GBUGenyVd4JkSNb0k6eQAXlx72a
 sgkR6jYNjXa+QuQZwP64DtI7y5ApmMQ/Rr3h8IeVjc276tsJcoyfZDJEWzxaD3+hakw82kGVX
 eM/sn6b9LTj5NXiLClorehTCDX4MWV2+mTN2cJ6MsJKQgcUebxraH63e5GfjczQABq94k2Cwl
 CfN/dUOHWGDb7+yyhIy8tgnyTb4g5IYmfo1doKyypjEBvHABi4qqWmIiZc7XQB1SPWDSgSv+Z
 BFG9FpdZEuibWqECVMixbthFjbhkTd1rc4naDyOmOBiRuKcq3Oanb+2bxp+C7RpJEWsbDnodq
 JmUku32s4zylckjB4iI894FkEjY13tEOzmY4/zlmxUepm/G4MRosn0Ck8fRr2ZciBX99hj+9K
 dRKF/IYLy598i9YBNtJ0D44EV3yfrQqmbqHgUk9SLQzsrWSqbjiirSkUQkkED/MGxJVfr/9Zb
 u1pcn4rM3kjSos5OfJErC0NvV4jJvCmUrfMTlY+f1jQy1rigxQtNWLUhPJ2jwgoOg4AwAvCEz
 ZiLnDhSpnmSDNX19XZkd3nmvJdtd0l/UMJGV6nmnoqqHQ8g+n07JnAbpJjMH1Ay7oisYDfwRR
 YB6jbtgHG5PKcw5KI+k1gVmNN6RpYPZcGQQJyzvUlTsXTPp3Gh9xVOhBusEEdnVPU5ie+5nKp
 KpqzBkeLO+eXXg2DlxRy1lVqb049Gjpmt/3TVSSK2cIUhBHP6VyIAimlLreIMZdv0jMgxqWDb
 zGFEk9ug1wYWpHdxlbDNKVok+33akkCbvUmJ3yV0yPQF/y0myfirRGQLEELT9F2Ju+Fpa6qab
 dbwfS8/u+XxX8jJTWnqoCzzxGqduoJlduPQrmMVDPzan7W7p3PmnbvUIQbkbhKsTDTmjFVIgS
 80yGxDnqgtMDNQr+lhbY2ELphmJbAwDSKRovdS4iQ9IIS+wVf0VzRwZK3MLDzMYxuz0FMrL/g
 pV9PoWs8BEEWD7Z/nVBbeym8IgROdw/eaumIkdsQ7i5vbTDK7zIBaCtnQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

On Fri, 11 Jun 2021, Luke Shumaker wrote:

> On Fri, 11 Jun 2021 04:19:17 -0600,
> Johannes Schindelin wrote:
> >
> > On Thu, 10 Jun 2021, Luke Shumaker wrote:
> >
> > > On Thu, 10 Jun 2021 03:13:30 -0600,
> > > Johannes Schindelin via GitGitGadget wrote:
> > > > -if test -z "$GIT_EXEC_PATH" || test "${PATH#"${GIT_EXEC_PATH}:"}"=
 =3D "$PATH" || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
> > > > +if test -z "$GIT_EXEC_PATH" || {
> > > > +	test "${PATH#"${GIT_EXEC_PATH}:"}" =3D "$PATH" && {
> > > > +		# On Windows, PATH might be Unix-style, GIT_EXEC_PATH not
> > > > +		! type -p cygpath >/dev/null 2>&1 ||
> > > > +		test "${PATH#$(cygpath -au "$GIT_EXEC_PATH"):}" =3D "$PATH"
> > >
> > > Nit: That should have a couple more `"` in it:
> > >
> > >     test "${PATH#"$(cygpath -au "$GIT_EXEC_PATH"):"}" =3D "$PATH"
> >
> > Are you sure about that?
> >
> > 	$ P=3D'*:hello'; echo "${P#$(echo '*'):}"
> > 	hello
> >
> > As you can see, there is no problem with that `echo '*'` producing a
> > wildcard character.
> >
> > In any case, neither '*' nor '?' are valid filename characters on Wind=
ows,
> > therefore there is little danger here.
>
> In the other email (the reply to Junio), I specified that it's only a
> problem if the glob isn't self-matching.  So * and ? are fine, but
> [charset] probably isn't.
>
>     $ P=3D'f[o]o:bar'; echo "${P#$(echo 'f[o]o'):}"
>     f[o]o:bar
>
>     $ P=3D'f[o]o:bar'; echo "${P#"$(echo 'f[o]o'):"}"
>     bar

Thank you for clarifying.

This is actually a valid concern also on Windows because according to
https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file the
brackets _are_ valid file name characters.

> > To be honest, I was looking more for reviews focusing on
> > potentially-better solutions, such as looking at the inodes, or even
> > comparing the contents of `$GIT_EXEC_PATH/git-subtree` and
> > `${PATH%%:*}/git-subtree`, and complaining if they're not identical.
>
> So the check right now is gross, but I don't know what would be
> better.  The point of the check is more to check "is the environment
> set up the way that `git` sets it up for us", not so much to actually
> check the filesystem.
>
> Plus, it shouldn't actually care if it's installed in `$GIT_EXEC_PATH`
> or not, it should be totally happy for $GIT_EXEC_PATH/git-subtree to
> not exist and for git-subtree to be elsewhere in the PATH.  So an
> inode or content check would be wrong.  Perhaps checking git-sh-setup
> instead of git-subtree though...
>
> > Those two ideas look a bit ham-handed to me, though, the latter becaus=
e it
> > reads the file twice, for _every_ `git subtree` invocation, and the fo=
mer
> > because there simply is no easy portable way to look at the inode of a
> > file (stat(1) has different semantics depending whether it is the GNU =
or
> > the BSD flavor, and it might not even be present to begin with).
>
> `test FILE1 -ef FILE2` checks wether the inode is the same.  And it's
> POSIX, so I'm assuming that it's sufficiently portable, though I
> haven't actually tested whether things other than Bash implement it.

It's not POSIX. From
https://pubs.opengroup.org/onlinepubs/009695399/utilities/test.html:

	Some additional primaries newly invented or from the KornShell
	appeared in an early proposal as part of the conditional command
	([[]]): s1 > s2, s1 < s2, str =3D pattern, str !=3D pattern,
	f1 -nt f2, f1 -ot f2, and f1 -ef f2.

Having said that, it appears that Bash implements it (what non-standard
behavior _doesn't_ it implement ;-))

And since Git for Windows ships with Bash, we can actually use it!

> > I was also looking forward to hear whether there are opinions about ma=
ybe
> > dropping this check altogether because there were indications that thi=
s
> > condition is not even common anymore.
>
> I think it would be good for it to eventually go away.  But having
> removed the hacks that allowed it to work in broken setups, I have no
> way of knowing how many people had setups like that unless they tell
> me now that it's telling them, and if those users are now broken, I
> don't want them to be *silently* broken.  So I think we do need to
> have the check for a longish period of time.
>
> > > But no need to re-roll for just that.
> > >
> > > Do we also need to handle the reverse case, where PATH uses
> > > backslashes but GIT_EXEC_PATH uses forward slashes?
> >
> > In Git for Windows, we ensure to use forward slashes in `GIT_EXEC_PATH=
`.
>
> Did you mean to write `PATH` here instead of `GIT_EXEC_PATH`?  Because
> if not, then I'm confused.

Ah, I thought it was clear that the `PATH` variable is already _not_ the
standard Windows version (which contains backslashes and _semicolons_),
but it is adjusted automatically by the MSYS2 runtime to look more
Unix-like (with forward slashes and _colons_).

Ciao,
Dscho
