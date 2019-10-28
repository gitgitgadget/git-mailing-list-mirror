Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB4151F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 21:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404151AbfJ1VHi (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 17:07:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:39577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404060AbfJ1VHh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 17:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572296852;
        bh=W0S47yqGXmscWTsen+UtDEfdO5o6kU7IAwTR+NDGSgE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OtaOG4u671zAvkEzv8ZRzMulcN0EHOD1xmHLlx1Sys80GqSI3u5NJVtXfPY7Lz2tS
         /bS7n/6RksSteUXBn8/VjBNn0tu1tOl8AY2bdbhOqgwtnV/wu03VYJ2DdsX4NSioE+
         ZM0/olGPXJul4ft/SNDI2o8xiqdJa4VIFdzuqtxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1hmGa200NC-00hdxr; Mon, 28
 Oct 2019 22:07:32 +0100
Date:   Mon, 28 Oct 2019 22:07:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/2] update-index: optionally leave skip-worktree entries
 alone
In-Reply-To: <xmqq36fda3i8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910282206081.46@tvgsbejvaqbjf.bet>
References: <pull.355.git.gitgitgadget@gmail.com> <c263eb54b30b3e93abb74662d120d8bb882322bb.1569483748.git.gitgitgadget@gmail.com> <xmqq36fda3i8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tbBVdnnJoV8+YYilBf6SL4CBi3bAlVPV/7eUHRUB+uq2ONtkb+5
 2z1daJ2IawU3TYyU99cwTP/SbmF98+CfETJNrykBFGxccY1k3etG1pFyGBzoJV7mrW05tKE
 XagfcGX97VJpNuFsvj+qCeQzL9/EkU3IWbov/CJjCYmmMTPfMO1VmTfky1PhBrV9dUJXF57
 OioLZGZJ6Pe7hG5efcsUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZL35q+nbZlE=:ISdzTltyyWRLg/nMG3A36e
 4UDpI7hCFz3w3DGLjSUbNIITDkg6LBZv0w/4FM0SS5fikX3/AVSll5Jt/WFWo9ZyyfTniiepx
 0kkFuPBSlCeyjYfxtvI82a7gQsMwCgyaC9ceyWTKNsDziQhn+AYaEBYcPRg6GtkFtQBZZtV+o
 kM0KZvJFgUuVHQnkA7Dq+WFtv/saN+dovvVsYpOtUh/jnn8dpQWTEDhFbFFjQXDas7KodZ6/a
 WNcpIBTMfapj4IvMkRbMz6ZOPgxN437nXias92Bcf740PFTqi/3TnyrmllFYgGcG1GqZ/qsSW
 g51ljMKsYIeDS9iOnRYq6gX2URMxVBnirpSzzuLIYAx/R060ZxebE1f5FzXRePUFYWMtjC8ZH
 p98YzoQKpjcsj79mJWA/hoo7VMBoxbtx3CweNcE0KP1z9C3cNLHJDW8I1HuJhmuGcRCD4PkIa
 2ByWgDYWMvdkYE6N57GCmmC+T47P1UcKVMBSGTwc6sEdW6KsWsb6+vnDQPeyMPSTTfB45UnOc
 oiZyIJFOp1Uzb0gOgSeya9Wddz5+zkiVoOM/MxUTztW49BCjMi1t0sS0V4AybVhEggOBwq7zx
 YirLLSxrjdDP43r4xvbQZaKJ9RxrntQSd1buvKHgKot+WOT3jzzRI/z89ZCplAt5xxal1g6X4
 ZO2vtM8uAWd4EjksaWMhEPWyW+wo0XQRtSoBYQHML90vvLauyXxoXvy+XW1ViNrNz7DJRZ/9N
 2fNFwWeTu7vBORmxUltsqyVlJF/+pWuY1xzNSXneFqoaopgWNnBeCLzBaDnfYKj3YYk6QAl66
 gMbwmNRWVKKQW87vUqA82zLtoqmBOjGDIPw2heuetU5I6LmYO7mj3ezNoigegL+5L+S5gmTGr
 sib4Ks9cxmdI492GEdsYh/lv6ocJVNruzFnSH+UOQa4bEWAlWBspSzpl+n59rHKApIHDT4Jpr
 dBXstC6QZRRWrgkUj4tJ7Az4JZlA4Lw4mRbW7IDn2uEvt4DPKplL2FFfcVB+ct5Hfe1+AUc+H
 zPR2jQ2f2+JFgL+pGojRUHsbbSCakXeySa77pH0zBDVwCw6AVxVdbPd8FQvSvbIYlVvi7yv+K
 SJxElBWbg1a1/ypTOtnKn1DxIx88/AS8+wEjmtc+fX5NOoRjy7RaMoKyOsPb1XQgEb7ztJnm6
 FWPkN4Oe4Zxvpv6zxAulR0vJFG+MW9s3nW8Zl1xg8wHyUyXvPkQtPxJ/g9uSsqiruackI81er
 acLPhy1vPxKg9wSKKoDnlG8zoXPe1DBgRQbQU/0BTG7Dr4eunX1660/4arpE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > While `git update-index` mostly ignores paths referring to index entri=
es
> > whose skip-worktree bit is set, in b4d1690df11 (Teach Git to respect
> > skip-worktree bit (reading part), 2009-08-20), for reasons that are no=
t
> > entirely obvious, the `--remove` option was made special: it _does_
> > remove index entries even if their skip-worktree bit is set.
>
> I think that made sense to notice removal of the path, because
> skip-worktree bit was not "apply --cached semantics instead of
> looking at the working tree files".  In other words, it was only
> about contents inside the files, and not existence of paths.
>
> I am not offhand sure if it still makes sense; if I were being asked
> to review that commit today, I suspect that I may be tempted to say
> that we should ignore both contents change and presence change for
> entries that have skip-worktree bit set.
>
> > However, in preparation for fixing a bug in `git stash` where it
> > pretends that skip-worktree entries have actually been removed, we nee=
d
> > a mode where `git update-index` leaves all skip-worktree entries alone=
,
> > even if the `--remove` option was passed.
>
> We might want to make this the default eventually (is there a known
> use case where the current behaviour makes sense, I wonder?), but
> I agree that this is a safe thing to do at least for now.
>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/git-update-index.txt | 6 ++++++
> >  builtin/update-index.c             | 6 +++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
>
> Isn't this something reasonably easy to guard against regression with
> a test or two?

I sent out a v2 with tests added to 1/2.

Thanks,
Dscho

>
> >
> > diff --git a/Documentation/git-update-index.txt b/Documentation/git-up=
date-index.txt
> > index 1c4d146a41..08393445e7 100644
> > --- a/Documentation/git-update-index.txt
> > +++ b/Documentation/git-update-index.txt
> > @@ -16,6 +16,7 @@ SYNOPSIS
> >  	     [--chmod=3D(+|-)x]
> >  	     [--[no-]assume-unchanged]
> >  	     [--[no-]skip-worktree]
> > +	     [--[no-]ignore-skip-worktree-entries]
> >  	     [--[no-]fsmonitor-valid]
> >  	     [--ignore-submodules]
> >  	     [--[no-]split-index]
> > @@ -113,6 +114,11 @@ you will need to handle the situation manually.
> >  	set and unset the "skip-worktree" bit for the paths. See
> >  	section "Skip-worktree bit" below for more information.
> >
> > +
> > +--[no-]ignore-skip-worktree-entries::
> > +	Do not remove skip-worktree (AKA "index-only") entries even when
> > +	the `--remove` option was specified.
> > +
> >  --[no-]fsmonitor-valid::
> >  	When one of these flags is specified, the object name recorded
> >  	for the paths are not updated. Instead, these options
> > diff --git a/builtin/update-index.c b/builtin/update-index.c
> > index dff2f4b837..074d563df0 100644
> > --- a/builtin/update-index.c
> > +++ b/builtin/update-index.c
> > @@ -35,6 +35,7 @@ static int verbose;
> >  static int mark_valid_only;
> >  static int mark_skip_worktree_only;
> >  static int mark_fsmonitor_only;
> > +static int ignore_skip_worktree_entries;
> >  #define MARK_FLAG 1
> >  #define UNMARK_FLAG 2
> >  static struct strbuf mtime_dir =3D STRBUF_INIT;
> > @@ -381,7 +382,8 @@ static int process_path(const char *path, struct s=
tat *st, int stat_errno)
> >  		 * so updating it does not make sense.
> >  		 * On the other hand, removing it from index should work
> >  		 */
> > -		if (allow_remove && remove_file_from_cache(path))
> > +		if (!ignore_skip_worktree_entries && allow_remove &&
> > +		    remove_file_from_cache(path))
> >  			return error("%s: cannot remove from the index", path);
> >  		return 0;
> >  	}
> > @@ -1013,6 +1015,8 @@ int cmd_update_index(int argc, const char **argv=
, const char *prefix)
> >  		{OPTION_SET_INT, 0, "no-skip-worktree", &mark_skip_worktree_only, N=
ULL,
> >  			N_("clear skip-worktree bit"),
> >  			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
> > +		OPT_BOOL(0, "ignore-skip-worktree-entries", &ignore_skip_worktree_e=
ntries,
> > +			 N_("do not touch index-only entries")),
> >  		OPT_SET_INT(0, "info-only", &info_only,
> >  			N_("add to index only; do not add content to object database"), 1)=
,
> >  		OPT_SET_INT(0, "force-remove", &force_remove,
>
