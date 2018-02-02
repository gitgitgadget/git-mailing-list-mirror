Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70DD71F576
	for <e@80x24.org>; Fri,  2 Feb 2018 10:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeBBKGm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 05:06:42 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40361 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBKGk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 05:06:40 -0500
Received: by mail-qt0-f196.google.com with SMTP id s39so30168962qth.7
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 02:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rZ3k0iXOw2NWEfL5KLfYfm72MmoYrNLGk98mJcwcaoU=;
        b=OyNq+Ygd57uH3DkxzayO/TJm9pquRuX/lMcxugGbzo9HOQyLA/2Ekc3EBnpscUHaeZ
         RJl0+hot5WM/NBCU/lik9ZRQeLjvyVmX5L7dYslzCQwOOgH0HX8yXB4aS+5zYG/nfwdH
         KHI8KezRSVgtdq9XFMwb32ENFaiJROkMBA72/Hu+W/S/z+W/2u17zaM6rd7D5hVPlt0y
         +XfYeaad8EOA2Y/HhIcVkv/YwiGve5FCBKGyO9pIqqNFJVN4t/60ApZhNLLQeZYZuEG+
         3LpDBa5842SgS8euW+dZ3dO9ZEG+uQresgJ5kKZhY4RSoiLipscQuQtz9vmBB9SSFwg5
         l7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rZ3k0iXOw2NWEfL5KLfYfm72MmoYrNLGk98mJcwcaoU=;
        b=BSQt8QpHV0um/sfIdk6VnygOiaZKTUY7X1tVJN2ulP71LeH+N5EVWJWKMyadNgpxaC
         cw1UJyUn20+pHok+WfeXkDIhBBI7R0S3o+r+IiLLHD8A4FWb0nr7VF55p4uMmcZFLEV1
         NQzSGS+N8V32cb2q2ONrE9mO906vCEgab3PN7A8+y9enjeLCBrkExGPR+c0LghzXEMgl
         xM2UllRPLrCjk+g3ANlesIaH/ToI1+woOd5tB3EbtqblF1mCfyeHoPQmIkuToGwd7sxO
         /rV7mzMqANTLzqft6qvsYeo7oiD6cQ2P3USjUU67VKNOW3RmtsrADZOtI778+0jmyA5Z
         5nrw==
X-Gm-Message-State: AKwxytf+BNF5L7ycY4SjgtN81t6rvC9IvNUTcxwpqdmCaEq48xjhIdFq
        9JwLV471hAUJNNjq7H6oUORz5VxlaMBRX/hGNjY=
X-Google-Smtp-Source: AH8x2279sny9xgi1Nw9UIHXI9Fun+P7CVhhNTsUcyZuTNvbSSOSyTTFzJcbtt1yMbvMTvoCZEeH6U2yJscTvZcUd4Eo=
X-Received: by 10.200.45.109 with SMTP id o42mr3122220qta.277.1517565999855;
 Fri, 02 Feb 2018 02:06:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 2 Feb 2018 02:06:39 -0800 (PST)
In-Reply-To: <20180124095357.19645-6-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-6-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Feb 2018 05:06:39 -0500
X-Google-Sender-Auth: 4-_wjNuzSpNIB5Ij5UU9imGci8s
Message-ID: <CAPig+cSLMt_9+5-8f_MndJM0hHgp32Q1CUmaosfJcbGEV8j-zg@mail.gmail.com>
Subject: Re: [PATCH 5/7] worktree move: refuse to move worktrees with submodules
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 4:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Submodules contains .git files with relative paths. After a worktree
> move, these files need to be updated or they may point to nowhere.
>
> This is a bandage patch to make sure "worktree move" don't break
> people's worktrees by accident. When .git file update code is in
> place, this validate_no_submodules() could be removed.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -606,6 +606,27 @@ static int unlock_worktree(int ac, const char **av, =
const char *prefix)
> +static void validate_no_submodules(const struct worktree *wt)
> +{
> +       struct index_state istate =3D { NULL };
> +       int i, found_submodules =3D 0;
> +
> +       if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0)=
 {
> +               for (i =3D 0; i < istate.cache_nr; i++) {
> +                       struct cache_entry *ce =3D istate.cache[i];
> +
> +                       if (S_ISGITLINK(ce->ce_mode)) {
> +                               found_submodules =3D 1;
> +                               break;
> +                       }
> +               }
> +       }
> +       discard_index(&istate);
> +
> +       if (found_submodules)
> +               die(_("working trees containing submodules cannot be move=
d"));

Minor (not worth a re-roll): This could be simplified slightly by
die()ing inside the loop rather than having 'found_submodules' and
breaking from the loop. Doing so will leak 'istate', but it's die()ing
anyhow, so should not be an issue (unless this code is someday
libified).

> +}
