Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C681F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755247AbeASVJJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:09:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61839 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbeASVJI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:09:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3086FCA721;
        Fri, 19 Jan 2018 16:09:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ms4EAfb58h+d
        pgT5xvGQ84Mtlqk=; b=Y6TQX+DfGa5KQ8QtMb1hbpJL6K23rDLQHYF5xs8jdXSu
        YtQDrR6cNp9pMGoaj2LmqT8D3aUctZvmmciCdYBP/ULt2GzDIiJxzWFwwY50yc0F
        vRvgsHOXC5WPFpOi4PqbUE8k22HqgqvTtbnxW8Wstl3lWpe48LR0q9Urq8gQEeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jy1/B7
        q28aEDtSPwsGU7iwqFnBkYN3nwMRkZJoVDVH2tMoT6KnBKEr7ki1Dy3MZPeecGRx
        UQ7q2JshF1fWV675yjNdb0B6uasbrUJNQsi8w61m8wMiH1ZyZUnXE7qXwk2D176V
        vTzLS72+jZzXmIsYNR7nZFvqsnTO0IeKMm68A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A098CA71F;
        Fri, 19 Jan 2018 16:09:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 992B6CA71E;
        Fri, 19 Jan 2018 16:09:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] dir.c: print correct errno when opendir() fails
References: <20180118095036.29422-1-pclouds@gmail.com>
Date:   Fri, 19 Jan 2018 13:09:05 -0800
In-Reply-To: <20180118095036.29422-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 18 Jan 2018 16:50:36 +0700")
Message-ID: <xmqqa7x9pnda.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC19209A-FD5C-11E7-BD7D-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The call invalidate_directory() between opendir() and warning_errno() i=
n
> theory could make some system calls and change errno. Prevent that by
> warning immediately after opendir().
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  This is on top of nd/fix-untracked-cache-invalidation which is now on
>  'next'. Sorry I waited too long to send the replacement and it's now
>  too late.

Well, we'll see a rewind of 'next' soonish anyway, so you can just
tell me to tentatively kick it back to 'pu' to be replaced with a
reroll if you prefer.




>  dir.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index dd1e50c328..55736d3e2a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1795,14 +1795,14 @@ static int open_cached_dir(struct cached_dir *c=
dir,
>  		return 0;
>  	c_path =3D path->len ? path->buf : ".";
>  	cdir->fdir =3D opendir(c_path);
> +	if (!cdir->fdir)
> +		warning_errno(_("could not open directory '%s'"), c_path);
>  	if (dir->untracked) {
>  		invalidate_directory(dir->untracked, untracked);
>  		dir->untracked->dir_opened++;
>  	}
> -	if (!cdir->fdir) {
> -		warning_errno(_("could not open directory '%s'"), c_path);
> +	if (!cdir->fdir)
>  		return -1;
> -	}
>  	return 0;
>  }
