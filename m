Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 268AC1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 08:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfHYHxO (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 03:53:14 -0400
Received: from mout.web.de ([212.227.15.3]:58413 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfHYHxN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 03:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566719590;
        bh=G6eCPideSIoOhpbYX6lIdrptYdqHWPW+KpmdUH1X/Vc=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=JeiJQGVIhSfUuudSH7LIKkMbYlXv912AB/SlQNSiiThjU/ZWwlJXZenRvEQz/Tffr
         yOmEVF1WZWhiRpiBn5VSH8ClrIsV7u+IGdoDKUxf8QgiYPhcJwjSJl6dyjm4WqqnIL
         Cbi1sxmK9+B/C3xQLZC1vgASDfAqoWMlLaUcMZhw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlsUC-1ib89W2enI-00ZRlZ; Sun, 25
 Aug 2019 09:53:10 +0200
Subject: Re: [PATCH] fix segv with corrupt tag object
To:     Stefan Sperling <stsp@stsp.name>
References: <20190824230944.GA14132@jessup.stsp.name>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bcc29199-a4ac-6bdc-6715-9807737253d8@web.de>
Date:   Sun, 25 Aug 2019 09:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824230944.GA14132@jessup.stsp.name>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t5+LK/lvkEydGHD9XOaPpmaaHyijOpewvdOFOSLPgMKw5TjAyjQ
 ypnwsKZjMLaGdZ7wzkBtYaaxjaXE3DoFq+lkGasynmnlD10RX/2Iolc+DTqjH1toqvmaRMA
 Sc4NHHH5JfVNvdeluE1WrN3bPEJvCPZTlb3D9IQyhBWYSoEZiWI78yQiEG8r79q7IjlGvRz
 R+9jTLpN0Vi1eSoD4xVRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rsHDXiaH390=:3lVgdqOeguiIfjGiPEBIiF
 FHMUBGLD38KyVvVoPuu72qEiVhqyBKLcEMmOZiQnUzAM/FihMZmdPwCO7uEWtKL8jmTgtX1fW
 Ki8fWwfeTH1RaJZtPPP3qu9kO6kOpLYujV5x5LNVTuVcOGXTNRQHDTtvuUI59DIASoE4XldMR
 iPuzK4Nnw0DnsL+WSSD6mOokdK5xKrfq8Gc6/uezi+CTm8lO6koA3oGyqtFJEFwgNwr+l3SND
 kojbq0dfxtl29Jv5e27/ojCvZEDNFvSwVtTIxSQ8fBU6L7gmFH4etvDxPKV0/OuiglWJmadQn
 e3Prp5p8mJ7AKma3XdjNcSlcGGJBC+G04js+FJidapDgaQAj16HSjesE4b4VvkEv1mCD6JfM9
 +bLuKRigvOU1rvHjcgfOUrI16zWNQX7o+wVqTsg0mSNDZqSoapI+jmlseiG8xTnRz+kaJy3Ua
 gwuhQkwMPqe4izcm1PN0PkNaL0b3BtsBdSnq+MGGcFk9wD2/SXV4CTeGLEFT1aRhPKmDArOct
 M/AzWPmM4X3qE+JPrxyNmOd6iZt7fqxBv51lYOT03mqGc79gNt0CovyHtm0Wew41FGQV8zwKQ
 MXAnVP3iLodZoILYPYYSFuRhoZ5AOo5Oiv/Jy9oOd9lpRbA7fXeUKB8fp9aafoVyqDaayu6IP
 PyCMu0lAjjzLu9c2uU516O/Fs3fTTupV1+rVcD0hqgpbIDxPMXN6SwPGNbmJ9NAru2+jxmPiC
 Mvi2NPlvsHcKHhJ+PKbXpR/8PVj7Edu/BhamWfJjhrjaQGFWdXP/SgQGp5aJMwDlhJ+Bhj6bP
 1LWP+o808/AX7w5eOQ4nK29DfTvjbyJ9KdYtajURK29Kk5RLKByUHENDl32ZNpfEy5UCVB9Fy
 00u9sVPiVa8SMrkB1ewfzH2oLobqglwHI0/Ynw1u7BbV5i3yLbIvhzAL8tkDeuS94l0wiOXu4
 02JhEGriT60KTj1KJz63VVH9x2p3ZToMg61JdTvVCNgBWHpb9HNx28mBZz2iXjsEsHve30pOS
 bjz5JSABc/4smZFEEfejFSc1x9usWaSeJ0fuddBO4xxFI3yRseAhBM/IYRMo/RsPV13gWksR/
 Z7IZtbHb7CJdmjgeGAgKusapUYFwfJb9CrcbJ3M1XWEf/i9AfMrwXTnBxjJP5twzDIif2cdjV
 y6mSMrWME1NOJEQpey6Ye9Y/EVRyRMZv5ePppK13BDzOnB2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.08.19 um 01:09 schrieb Stefan Sperling:
> A tag object which lacks newlines won't be parsed correctly.
> Git fails to detect this error and crashes due to a NULL deref:
>
> $ git archive 1.0.0
> Segmentation fault (core dumped)
> $ git checkout 1.0.0
> Segmentation fault (core dumped)
> $

Good find.

>
> See the attached tarball for a reproduction repository.
> Also mirrored at https://stsp.name/git-checkout-tag-segv-repo.tgz
>
> With the patch below:
>
> $ git checkout 1.0.0
> fatal: reference is not a tree: 1.0.0
> $ git archive 1.0.0
> fatal: not a tree object: a99665eea5ee50171b5b7249880aa2ae35e35823
> $

Sign-off?

>
> diff --git a/tree.c b/tree.c
> index 4720945e6a..92d8bd57a3 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -252,9 +252,11 @@ struct tree *parse_tree_indirect(const struct objec=
t_id *oid)
>  			return (struct tree *) obj;
>  		else if (obj->type =3D=3D OBJ_COMMIT)
>  			obj =3D &(get_commit_tree(((struct commit *)obj))->object);
> -		else if (obj->type =3D=3D OBJ_TAG)
> +		else if (obj->type =3D=3D OBJ_TAG) {
>  			obj =3D ((struct tag *) obj)->tagged;
> -		else
> +			if (!obj)
> +				return NULL;
> +		} else

OK.

There seem to be some more placed the use ->tagged without
checking (found with "git grep -wW tagged"):

  builtin/describe.c::describe_commit()
  builtin/fast-export.c::handle_tag()
  builtin/log.c::cmd_show()
  builtin/replace.c::check_one_mergetag()
  fsck.c::fsck_walk_tag() -- I'm not sure about that one
  log-tree.c::show_one_mergetag()
  packfile.c::add_promisor_object()
  ref-filter.c::populate_value()
  ref-filter.c::match_points_at()
  walker.c::process_tag()

Ugh!  Do you perhaps want to have a go at them as well?

>  			return NULL;
>  		if (!obj->parsed)
>  			parse_object(the_repository, &obj->oid);
>


Hmm, I find it a bit sad that this function is almost a duplicate of
sha1-name.c::repo_peel_to_type(), which already checks for ->tagged
being NULL.

Ren=E9
