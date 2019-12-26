Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8300BC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C72620838
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ga/W94qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfLZVQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:16:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:41761 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfLZVQu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 16:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577395003;
        bh=UhAoRBD5KFlcW6Kde+fkRQG3zxBPZUa2ZZWODsqTDeM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ga/W94qpXMv2hdSYR4ITPbkYbQv8jn9ZznZ26//kNbQx1/EdhXL9U2NvFJhSrUsZC
         E8w62BJGrU3bCJiqUj5MN6rC0zdTShMVJqLRKLq5KHS4DjVc8BvwnGfktjn/Is5YAQ
         0ow+rfwXQ6vjQtOV61LQM2+UevUgZUVuAAdx6BuQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.lan ([136.243.159.11]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1jm16i46nO-013i3Q; Thu, 26
 Dec 2019 22:16:43 +0100
Date:   Thu, 26 Dec 2019 22:16:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not
 tree entries
In-Reply-To: <xmqqr20qlxtz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912262209190.46@tvgsbejvaqbjf.bet>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>        <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com> <xmqqr20qlxtz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2CJG/marxKiZDvv7NDKhkrLfctMHVgcgvEyQcVEtgRJGmyoqlHB
 1TkJr5cTDqonC0SbQgThhnUDmgoWAwehs7Jp2nBvH3Rt2G46tG4O5Yo/2WW3LexZFQcZwZi
 +Efi7RS3gJ5epxjY77D8Lo2g1KtNQuayNoQYjkIAbBJVC/bw3jABY04kaFZv98adneOwdbn
 tNF53WVLr880wqrLGAqEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OoLT6QW9+hE=:LRLD7B0RuKgLi5G/jxuu2N
 iPIJrjkDKvqhm4nw/yv/k8xl+UWg/AjFytA9Hg/IK3o2HWrXUYuFVVAHzNtIU0kHAp6pYDpmv
 axfjLLChOS39PR4tfDnoJ9gNhbeV2wIykj5Kr2HJux1YdkDlwpwByKMUI5S73SSXrJJEUs9CV
 laYeHA4YqgAnFOaniPGAvbnIBSSOLMduVqWk2T74LXiEv043HtkEdttcEim/GzMCfzVXxuk/s
 mRZk1wzYaBhz2MbPAbxJU9REqugcjIhabdIGifBvNEAVeYu47xUz7nZxdiDrRXaPz4+JBRiC4
 VGYkGPjhfubgwOQ01nQyhp0AxW0pwHoU6y1d6jw81+PQY6b3VITihXYeqgcBgsxGvt8vqhR1m
 hKRHCGKZw2+P90fzQ+YI8GLNxGstP/hzokVIutAD4SrtnMFb3djm9onq2ZwSTekNQQqyEglEH
 omsClgT5Zlru37VsJ0ArKTl+h/aap1kNu6MQ+lGlZ/rwK+aNiOzyOD58l/PgMKfIj3NeM6Nbn
 T/eM1rQEayD59d9PNsX7C3jTmp3m8q0GDhA4PttR5nUUwBC5xZFK+oj3c5vfRFx+AWwrLzAQK
 JGSA76M3h1x1nLxT2pKkGrjAHzFzmWVKDlxJmU4gWZBX6gcgJE1Mt31gVp13MBklk9LsVa9j0
 9XFBIJLFrF9iYwwRBoEl6fquSSMBUZ8x8kPAqeOQw49WkA1BQTgrnQ9ojAE1x/oJiVR22mi/V
 xIm96EDOX8o+EXJ3JDMcoKq9vsLmHHvyERfbhdZDWjwgMpXOvJReWpiJN9miIylhQm1PFis6n
 J2m7cThzkZhgSgKz+AScNUFJePvufWANmaWem2icg+Ty/0aw/3xUDPVEmdcFv3z+AUA/g7jHS
 WoFS7AXw9mrGomxFsxE0EvTi6vqaot11G1XdicVldHogUinIlkSi8Iqit0Px0eQ8adSVzdFtA
 rPwDIIJBq+le0gQIUv1IFMAuNlw4IqypO4BwQVs/9TfNmyNjYGdGSxa07DWy9/HMVGdxhorJt
 J2QMPEByTFHk/aKYyndZ21eJI60rkpT3WRq7gLK4Pbhnzosd2hm74/2uulYdLhDuMODasnE58
 +NZS6ShKo4XaHqZebydyFmqhYiZRLcY33yw/WQu+iCjzRfjtlHBkhe00VWkSCNHeBoDx48UKN
 vq2H3PJNw6xcgxgmRGhr4aRuJ4HaA55/g6ZBqkgcljuD4ypB5vSh8FyaC1N05b9KBhCEk1cSH
 jCzjfTuo65P6hxsNXhWVQxKUrpqQGezY8RYysHcWksJD3vmE7ZxVqFGHXXyo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 26 Dec 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > During a clone of a repository that contained a file with a backslash =
in
> > its name in the past, as of v2.24.1(2), Git for Windows prints errors
> > like this:
> >
> > 	error: filename in tree entry contains backslash: '\'
> >
> > While the clone still succeeds, a similar error prevents the equivalen=
t
> > `git fetch` operation, which is inconsistent.
>
> Yes, inconsistent is bad and it is puzzling.  I would have expected,
> if this gate on the transport layer is desirable, such a check would
> be implemented as a part of transfer.fsckObjects and covered equally
> by fetch and clone codepaths.  What went wrong to allow "clone" to
> go through while stopping "fetch"?  Can you describe the root cause
> of the difference in the log message?

My bad, I should have root-caused this better.

Turns out that this inconsistency is only in Git for Windows v2.24.1(2)
but not in current `master` of Git, so I simply struck that part from the
commit message.

> > Arguably, this is the wrong layer for that error, anyway: As long as
> > the user never checks out the files whose names contain backslashes,
> > there should not be any problem in the first place.
>
> I do agree that rejecting these tree objects that has a slash in its
> path component is probably wrong.  A GIT_WINDOWS_NATIVE box should
> be able to host a bare repository on it, and users on machines that
> are OK with paths that Windows may not like should be able to
> interact with it, by pushing to it, fetching from it, and updating
> the repository on that Windows box by going there and fetching from
> elsewhere.  Rejecting these names at the object validity level means
> Git on Windows would be incompatible with Git elsewhere.
>
> And It hink the same logic apply to those names like prn, con, nul,
> etc.  How are the users protected from them?  We should prevent
> these names from entering the index the same way, shouldn't we?
>
> > So let's instead prevent such files to be added to the index.
>
> ... and loosen the check that (incorrectly) gets triggered from what
> codepaths in "git fetch" (but not from "git clone")?

I rephrased it to:

    So let's loosen the requirements: we now leave tree entries with
    backslashes in their file names alone, but we do require any entries
    that are added to the Git index to contain no backslashes on Windows.

> > This addresses https://github.com/git-for-windows/git/issues/2435
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  read-cache.c               | 5 +++++
> >  t/t7415-submodule-names.sh | 7 ++++---
> >  tree-walk.c                | 6 ------
> >  3 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/read-cache.c b/read-cache.c
> > index ad0b48c84d..737916ebd9 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -1278,6 +1278,11 @@ static int add_index_entry_with_check(struct in=
dex_state *istate, struct cache_e
> >  	int skip_df_check =3D option & ADD_CACHE_SKIP_DFCHECK;
> >  	int new_only =3D option & ADD_CACHE_NEW_ONLY;
> >
> > +#ifdef GIT_WINDOWS_NATIVE
> > +	if (protect_ntfs && strchr(ce->name, '\\'))
>
> As I wondered above, names that must not enter the index may not be
> limited to those with backslashes in them.  Perhaps you'd want a
> separate helper function so that you can extend the logic more
> easily, i.e.
>
> 	if (protect_ntfs && invalid_name_on_windows(ce->name))
>
> or something like that.

I decided to perform those checks at yet another layer: when trying to
create new files. My idea was that I would want to catch even things like
`git config -f LPT1 ...` (`LPT1` is a reserved name on Windows, you cannot
create a file with that name).

Obviously, I cannot handle the backslash in the same code path, as e.g.
`git config -f C:\Users\me\.gitconfig ...` is totally valid.

Ciao,
Dscho

> > diff --git a/tree-walk.c b/tree-walk.c
> > index b3d162051f..d5a8e096a6 100644
> > --- a/tree-walk.c
> > +++ b/tree-walk.c
> > @@ -43,12 +43,6 @@ static int decode_tree_entry(struct tree_desc *desc=
, const char *buf, unsigned l
> >  		strbuf_addstr(err, _("empty filename in tree entry"));
> >  		return -1;
> >  	}
> > -#ifdef GIT_WINDOWS_NATIVE
> > -	if (protect_ntfs && strchr(path, '\\')) {
> > -		strbuf_addf(err, _("filename in tree entry contains backslash: '%s'=
"), path);
> > -		return -1;
> > -	}
> > -#endif
> >  	len =3D strlen(path) + 1;
> >
> >  	/* Initialize the descriptor entry */
>
>
