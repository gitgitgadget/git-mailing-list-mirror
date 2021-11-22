Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C25C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 12:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbhKVMst (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:48:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:57327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232527AbhKVMst (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637585131;
        bh=5SVrHU23D71UDaoMAogR2uJ9RHCvrOqAJg8BIUVaRuc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dEMYGp5CkxhtlnGZ+BBWSGuZOuB+khiwB57ED4Zx3zFOKpbBkJKX13xybckiyVTsu
         hQsD73Muwj87zn8cvKDTienA+S6yGSkswP2YV5MOCyXO180klRLL2fbq/xcYS0Arss
         h5Q9EFzTHmXktJLHbPo3Yab5Oe8iLS+GeoPtm2Ms=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvY2-1nBDv10TOi-00Unay; Mon, 22
 Nov 2021 13:45:31 +0100
Date:   Mon, 22 Nov 2021 13:45:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Anders Kaseorg <andersk@mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v6 4/8] worktree: simplify find_shared_symref() memory
 ownership model
In-Reply-To: <20211113033358.2179376-5-andersk@mit.edu>
Message-ID: <nycvar.QRO.7.76.6.2111221339320.63@tvgsbejvaqbjf.bet>
References: <20211113033358.2179376-1-andersk@mit.edu> <20211113033358.2179376-5-andersk@mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1636732753-1637585131=:63"
X-Provags-ID: V03:K1:lEVuv+5PKYbhHXi3+V5B2zhaCguD2d/knSsfGPa5fCQ9ZG2weDL
 Fnh64No6Knw32NojcSD6O9R0B3nWSHiYtuz0506KC0A6Z3Jv/SMqN0xNrf/5NXnFXpAcGkJ
 3LXCE/NA2IDrDcGIESR48Mz9iAmAyWS51NxKNWSVtHgt+dG8ZxHWePdkj9GKHBnWERuYLa6
 WzQm+PC73WzaUL+/RU7Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VmH/IlUT4SM=:qlTwogtLkTDIf9TUKlN9qp
 sMgsueUcqXZxNjtCgiGkBiGC/4LFu/N053fQeQY7xr+AF68kDJtaxwIVRbK3diblJbHhvH9b1
 V351aUy1cBPflC8Uie16+WSQuZ1EwBF0HlL/FhnjiQDGuKTc6ltVHVLbVc0+ZN4pSjkozHiMT
 Wn0H4PMjxyqkbuleV9VvZOzUko9MMLaOj9iuQvMysWryfOfv1PzXfKeWPhhoRZUn/K59IdRj0
 pBi/yhSyt4oeqFOL/e2yhhTHgc9LrezJjj0KTpzcVUN1qFdOY72WT1urp6U84U8/k+OI7BK9W
 ZVXqK0MdKUQiJzir/aUI1VsoKu4sbIi52K8hiL5YGZHMOiLX7F7gWaiw77WVradW+jTfXANeO
 oOI+iTSfeoBKXcWHMtkuoqGHmS0zP39tzz/1CiAm57kn1695ufB8I/iDWnc+IohHY/Lzrrhnn
 jpBJPtT3ICTVm+wxk82BOTucNr7CDx5qsJu6OnI/++FAT2Jm0J7XPDuOZlGoASsjgxoe9AFQS
 GUI7rAtWBoOTRh+poWHcEYnwK+ADK+/P7FynkHnYjSzyB0/Ba3jCgYSJlsRWNyBlmul75nLJC
 xrsE07EY2KbfTipag9NYYJEqgRTXe+sRFwjkjl7J4rg6EBjW4AK70fXF0K7MWDETgnPdRDpcS
 srs8EkknlLQOrljyvccWaBPULThab7IWkvcq5lJ6DcawpFvsGh9J9C5Gqdo6UoB/MJpqfoLuo
 eGbLTSZFhd2xb7uZM7UpM0W3qusZSE6wJgzyeDgPpKXZ34Gxt9Vu1iQJxrKi8hmJp73H55oVC
 PSH5ltj+HoDj1N9ABkFyPKrKI5LQbNlm97rkeX6D+PfyVqfhrLKlRHFRdNt2A85RB/HhHx69T
 4axiRWB0fZquMBTXBRtBwN2DJhrLpNQ85Igm3Oy42ohWQsXxfiuQP/7NDjEJnTtuQGuMrDCpW
 WXLHdptq3DUpfvxZTN5C2WnzbxBztNULbtK2gYJy5XCgKmpHxm/5ANXqmTv5/qhSU6NbVHHDe
 lhm5iBDfT0CKn6X7K1zqeNLFlXTCPXFcFQ25P+QUwBx0/p6zISNM+Tw35JP4/b+Zk0l7amCja
 MVWU4dZrdlxvqM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1636732753-1637585131=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Anders,

tl;dr this looks great!

On Fri, 12 Nov 2021, Anders Kaseorg wrote:

> Storing the worktrees list in a static variable meant that
> find_shared_symref() had to rebuild the list on each call (which is
> inefficient when the call site is in a loop), and also that each call
> invalidated the pointer returned by the previous call (which is
> confusing).
>
> Instead, make it the caller=E2=80=99s responsibility to pass in the work=
trees
> list and manage its lifetime.

Thank you for cleaning this up!

>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  branch.c               | 14 ++++++----
>  builtin/branch.c       |  7 ++++-
>  builtin/notes.c        |  6 +++-
>  builtin/receive-pack.c | 63 +++++++++++++++++++++++++++---------------
>  worktree.c             |  8 ++----
>  worktree.h             |  5 ++--
>  6 files changed, 65 insertions(+), 38 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 147827cf46..c7b9ba0e10 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -357,14 +357,16 @@ void remove_branch_state(struct repository *r, int=
 verbose)
>
>  void die_if_checked_out(const char *branch, int ignore_current_worktree=
)
>  {
> +	struct worktree **worktrees =3D get_worktrees();
>  	const struct worktree *wt;
>
> -	wt =3D find_shared_symref("HEAD", branch);
> -	if (!wt || (ignore_current_worktree && wt->is_current))
> -		return;
> -	skip_prefix(branch, "refs/heads/", &branch);
> -	die(_("'%s' is already checked out at '%s'"),
> -	    branch, wt->path);
> +	wt =3D find_shared_symref(worktrees, "HEAD", branch);
> +	if (wt && (!ignore_current_worktree || !wt->is_current)) {
> +		skip_prefix(branch, "refs/heads/", &branch);
> +		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
> +	}
> +
> +	free_worktrees(worktrees);

This is the only caller that is not in `builtin/`, i.e. it is not at once
clear how many times we would potentially re-generate the list.

I had a quick look:

$ git grep die_if_checked_out
branch.c:void die_if_checked_out(const char *branch, int ignore_current_wo=
rktree)
branch.h:void die_if_checked_out(const char *branch, int ignore_current_wo=
rktree);
builtin/checkout.c:                     die_if_checked_out(new_branch_info=
->path, 1);
builtin/rebase.c:                       die_if_checked_out(buf.buf, 1);
builtin/worktree.c:                     die_if_checked_out(symref.buf, 0);
builtin/worktree.c:                     die_if_checked_out(symref.buf, 0);

This suggests that all the callers of the `die_if_checked_out()` are in
the `builtin/` part, and only in the commands that were not touched
directly by your patch.

Which means that all is fine and dandy, we are unlikely to introduce a
code flow where the worktrees array is populated multiple times (when
before, it would only have been generated only once).

Very good.

Ciao,
Dscho

--8323328-1636732753-1637585131=:63--
