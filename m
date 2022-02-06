Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7000C433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 21:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbiBFVin (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 16:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiBFVin (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 16:38:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5314EC06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 13:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644183515;
        bh=00St5oGBpqbhFGsQQQm1phsqCFMB0heDYWH2weIkFIg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a0Vxg8hlw9beH96GQ+JVKT6ADJst8DMoKQpuORYkZ5oEcseI+iUFMLd0ODANDc+SC
         84ejv5HYcI+4gVZMKI2msDdpOeBN2A0TmO76DKcNHUl+vcpsmhhZrAnxn06HOTXLPs
         ZTKjkkAneGLIgTQluPO6PfTLUoumBGHwQCH2L2wc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.212.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1nTyOZ2M7s-00DEaF; Sun, 06
 Feb 2022 22:38:35 +0100
Date:   Sun, 6 Feb 2022 22:38:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Taylor Blau <me@ttaylorr.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 3/5] scalar: teach `diagnose` to gather packfile info
In-Reply-To: <0a52155c-4605-d96f-965a-104a399ae86e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202062234520.347@tvgsbejvaqbjf.bet>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com> <330b36de799f82425c22bec50e6e42f0e495cab8.1643186507.git.gitgitgadget@gmail.com> <YfHOo8Mf3RP4j0Y6@nand.local> <0a52155c-4605-d96f-965a-104a399ae86e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3DZb7yjTN72fp+MYZTmh7scuQkN1omfvSMDIc1TkMKot1sOwDbh
 8DFadFQbj8E1vITB+0mgIQaaPi5sQW6kHgzXE4jZ9inEZrAJElBFuBVvCUttuyeVz8IsYjL
 8m2m8QvVOp78o8mUJj/t/WuEn9s8gDg8MH6WaLyKMZcCw/eSllWrcM/YQaYLxghGhHlxmPT
 3FN8aQIcbMuYBNCHCEmlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nvsVIx0MRpE=:Mi1glZfQpLKgOu870egvqh
 a7AXujaOvevtNNQ6zVigMcSf/cDil0DUsMuWV5HRAFC1jtw6qlMcBeQ+Ja9s7rjciwSokFSF3
 vuDUEyPXfJkWorM/bDpF46RD/4V3ycYoNrj6lBaYDHDmadcQmmYGDr5FoSRjI+bgo8X0Ii94m
 27F5C95BAYHGJGhc5lhkk2Ug+DZs3ULh5D1+44G3yH90WDBQ/p4fuZGehKm4ZHReLFIcsr1Zz
 W7sSFfm4TDdwOTdx7P1FG7eN7gX5+OkFYLWtukSp0MK33PGxPPnbwPBUpXJLKQmRjFAAQ3E6/
 gfaiMFFGI0JcUYxxjUfZnrgLT6chq/0HSpyPJ+sH2dClonb323dVAvI6dZDoyhn+nIjczCotM
 H2QXPRiUiD6/DioSGuYVrsO05LlLgM8ek51+hFTbskFvfDrDvisYdfS4KyHYYR5ZoIKdh2SqT
 jXDv0qZo/xe6G6nhzaqVJhKwXj7WTBsiYDmHKRWsIekA38jRLe944XSieBWNBzqrI8I4pt62Z
 rVww44vpxIn0UPEWNooqlKCe8uFuuRyL6P0Jbz4HAT5xQteqtAe0woEVrBHRm4n1EiAVQVRf9
 J+R3R0hb5Bil52lrTfqzgd+uprefwIdOKfRJosQL0EFaEs3qx5MQJCVznmRSmX7I4VS4JEGVq
 +Uqz5mdCgceG38OpoJzn+0MtCd3rNbFRHQ0UW5oFML/9eDe8ZBK3d/4RjFfMONqtzkzT9VRYs
 CQ4W//N8hLAAlXaR7AmJqwOEhnqxCZmAK0TzwaQF25bv14+4Lm90eaDo7BizDXTG+isebHTTB
 ZFiKDtdIMYxqSdH3ymD08v5EA7Na4FhAhdv9kT8rYC2IPy24UambE+qz4gfJ0i8QEUhYknwr8
 4yHZ9oGCsKfF1oh7KGY207pnNjjfmsoZ/ZVsmClbnziyXjLLe4B+iv4dNQTKdei/tYeBYh9Pk
 Fz0+5u/ueefUYbTuuVOSu8EigOFFluUOL/EMwXckdDj8Osyuse8bAdvSoN9j+DlrqoNqbmmqT
 Tqng73zrNVpHyxaYo6PbOLMeEL2uYLrlBejVtCQm6gnpnwSfQ9HYyBvjJCBfOhemuWkuw9oeR
 KBiz1kxy4jXY8M=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee & Taylor,

On Thu, 27 Jan 2022, Derrick Stolee wrote:

> On 1/26/2022 5:43 PM, Taylor Blau wrote:
> > On Wed, Jan 26, 2022 at 08:41:45AM +0000, Matthew John Cheetham via Gi=
tGitGadget wrote:
> >> From: Matthew John Cheetham <mjcheetham@outlook.com>
> >>
> >> Teach the `scalar diagnose` command to gather file size information
> >> about pack files.
> >>
> >> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> >> ---
> >>  contrib/scalar/scalar.c          | 39 ++++++++++++++++++++++++++++++=
++
> >>  contrib/scalar/t/t9099-scalar.sh |  2 ++
> >>  2 files changed, 41 insertions(+)
> >>
> >> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> >> index e26fb2fc018..690933ffdf3 100644
> >> --- a/contrib/scalar/scalar.c
> >> +++ b/contrib/scalar/scalar.c
> >> @@ -653,6 +653,39 @@ cleanup:
> >>  	return res;
> >>  }
> >>
> >> +static void dir_file_stats(struct strbuf *buf, const char *path)
> >> +{
> >> +	DIR *dir =3D opendir(path);
> >> +	struct dirent *e;
> >> +	struct stat e_stat;
> >> +	struct strbuf file_path =3D STRBUF_INIT;
> >> +	size_t base_path_len;
> >> +
> >> +	if (!dir)
> >> +		return;
> >> +
> >> +	strbuf_addstr(buf, "Contents of ");
> >> +	strbuf_add_absolute_path(buf, path);
> >> +	strbuf_addstr(buf, ":\n");
> >> +
> >> +	strbuf_add_absolute_path(&file_path, path);
> >> +	strbuf_addch(&file_path, '/');
> >> +	base_path_len =3D file_path.len;
> >> +
> >> +	while ((e =3D readdir(dir)) !=3D NULL)
> >
> > Hmm. Is there a reason that this couldn't use
> > for_each_file_in_pack_dir() with a callback that just does the stat()
> > and buffer manipulation?
> >
> > I don't think it's critical either way, but it would eliminate some of
> > the boilerplate that is shared between this implementation and the one
> > that already exists in for_each_file_in_pack_dir().
>
> It's helpful to see if there are other crud files in the pack
> directory. This method is also extended in microsoft/git to
> scan the alternates directory (which we expect to exist as the
> "shared objects cache).
>
> We might want to modify the implementation in this series to
> run dir_file_stats() on each odb in the_repository. This would
> give us the data for the shared object cache for free while
> being more general to other Git repos. (It would require us to
> do some reaction work in microsoft/git and be a change of
> behavior, but we are the only ones who have looked at these
> diagnose files before, so that change will be easy to manage.)

Good points all around. I went with the `for_each_file_in_pack_dir()`
approach, and threw in the now very simple change to also enumerate the
alternates, if there are any.

And yes, that will require some reaction work in microsoft/git, but for an
obvious improvement like this one, I don't grumble about the extra burden.

Ciao,
Dscho
