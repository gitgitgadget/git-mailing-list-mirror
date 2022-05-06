Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F88C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 04:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbiEFEqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 00:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiEFEqR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 00:46:17 -0400
X-Greylist: delayed 316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 21:42:34 PDT
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006E3580DA
        for <git@vger.kernel.org>; Thu,  5 May 2022 21:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651812150;
        bh=SJ+z+YvHtjHpqA6goIaFFEPmrfSnW9HW4mld+AUqHLk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=THMT9RGu9/9dHKI8F1ZOOWmEB2hDYxEzzoH0M986ewRp0reUk8MBNYE5NUYHSiidV
         DbPdtpEAx7MuX8tLV6nMZvRvfHUnhVm3IT+j0Jpwtsyycro6owtxNe+dznvrPF4TuW
         j2odGta1Yy8Vqs+7lES9P+Nnhkb92Bl0mXL9Nh/s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1oCVTr3l02-00jy2T; Fri, 06
 May 2022 06:37:05 +0200
Date:   Fri, 6 May 2022 06:37:03 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jason Hatton <jhatton@globalfinishing.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
Message-ID: <20220506043703.gqoi62t3mbnbga44@tb-raspi4>
References: <CY4PR16MB16552D74E064638BEC11ECB1AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR16MB16552D74E064638BEC11ECB1AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:UTWvJRXzihAEYKXLOa4D8ZKB1FIAVKw4cmBKGkClxh8e26Qv/9+
 k2oc7ZGEq3MDjHa/zIqH5K/ogzGCALGnvpCG5vKBm+cAe6cZlVrGLmyIcb9at/bVBILkbuE
 kyG7ohgK+c8DrJYi8smu5tajTdVZXGXouejlKBdDiWfxUiy2KAXAWqBBuJIeJWfwgTge0I5
 7gG42HxmJe7a0pZtv2OZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IgdBnN8etEg=:Y/+iRi6V7zpzvUC+sJ5Ggg
 iTVQrNtWtmyWkujKRcAFdCkogG63u1++Iv77BuLxIAhDZ09V8SYhhfFm55802N3dsoiMfmVTU
 BKv30nwrYnwfbO1eaV4g4hmeaKNa+6EpZtMgqYgXt1/e4KVj9dypWPj494sv4G0wc4N8xOClc
 VfmWh0JXx2aktex/KEszsPcSTEN4ZbH5GKG58vqW7cMcYpSiFlC6QiiQWdgPfwyoz6MSIqxMz
 mt1qu7ghu9zeb0o612X8S/7dvj3pQzJAVjkTJf/WThC0h8UPNYmh29GMETWtw/6f/moVR6qV/
 we4ecN3CJ1CCrr6Y74MfHEiG7gDyiheuFzfyb1iHthNXnHRdmJNjpV1MM28zmEEuDyG+GymII
 a9feNbx4aoMdz+HEY45mIISlalD4OgsI+Wbvza5pr/niUspdTOvBqVL4C5SbzjTTGAKIO8tWO
 dJMFRnGurRXfW2W4v37C2lgWBgzWM5B+P4Cer2snvb1NLm+MF+xkrUePqOnBioQ7Zf3mYT5IA
 IHfL9krN0hp0ovtvA6NP2g8mEV6l7yBRE2pVBC6GdqvcM8Biyyt4ii9ZD+dsZlfMzigXxL0LM
 tdamMbVhihzc+pP9pGoZ3T3XB2jg8EZBNcJVMdG/omFubb1K+Vn5iCxxOVOmSgIStf1NBqf49
 5fhEw3lG7xvV2j8w/pULAY9qsb+VP3CSZnT0kSeRxvX4W49QuE0aKFm/ZaN9VEmTGBg1EkaQl
 t1uB/zXJpyb3w33vKTZAxfVOZ/OtJPVlOacJbKU2OkDyWBwb7YqcAnXL3z7igHJm6LL67K1Pb
 csc7XSveCrVEHV/8Pa/czm9Wg44dnwhU7xzndbbE7w+kd3isD3Mkp18ta/bIIJSDTR+Dwt4V9
 GGSQRT5zxhCgdJH+vc67U1tXn9hX7VaEeJlk49l34MiQvAfWZCL6wiK1bZ+FHCGp1gHb5EYND
 9UWV9nO6MUZLhOMr0BD1L5arqp9JMPj4vCcHxoYZm/4cm73OQP/HMpJUnxZGjrgDMF4Wxd8/E
 o503C36uSpNCQNGU8MV7Xa08DUV8ajxTQJxGH6IqXMsnBRS4NMXsadSw4cL3fOPTDQnBNuDN1
 okUOkoNUUzSmfc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 12:26:53AM +0000, Jason Hatton wrote:
> Git cache stores file sizes using uint32_t. This causes any file
> that is a multiple of 2^32 to have a cached file size of zero.
> Zero is a special value used by racily clean. This causes git to
> rehash every file that is a multiple of 2^32 every time git status
> or git commit is run.
>
> This patch mitigates the problem by making all files that are a
> multiple of 2^32 appear to have a size of 1<<31 instead of zero.
>
> The value of 1<<31 is chosen to keep it as far away from zero
> as possible to help prevent things getting mixed up with unpatched
> versions of git.
>
> An example would be to have a 2^32 sized file in the index of
> patched git. Patched git would save the file as 2^31 in the cache.
> An unpatched git would very much see the file has changed in size
> and force it to rehash the file, which is safe. The file would
> have to grow or shrink by exactly 2^31 and retain all of its
> ctime, mtime, and other attributes for old git to not notice
> the change.
>
> This patch does not change the behavior of any file that is not
> an exact multiple of 2^32.
>
> Signed-off-by: Jason D. Hatton <jhatton@globalfinishing.com>
> ---
>  cache.h      |  1 +
>  read-cache.c | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 4b666b2848..74e983227b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -898,6 +898,7 @@ int ie_modified(struct index_state *, const struct c=
ache_entry *, struct stat *,
>  #define HASH_SILENT 8
>  int index_fd(struct index_state *istate, struct object_id *oid, int fd,=
 struct stat *st, enum object_type type, const char *path, unsigned flags)=
;
>  int index_path(struct index_state *istate, struct object_id *oid, const=
 char *path, struct stat *st, unsigned flags);
> +unsigned int munge_st_size(off_t st_size);
>
>  /*
>   * Record to sd the data from st that we use to check whether a file
> diff --git a/read-cache.c b/read-cache.c
> index ea6150ea28..b0a1b505db 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -163,6 +163,18 @@ void rename_index_entry_at(struct index_state *ista=
te, int nr, const char *new_n
>  		add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_T=
O_REPLACE);
>  }
>
> +/*
> + * Munge st_size into an unsigned int.
> + */
> +unsigned int munge_st_size(off_t st_size) {
> +	unsigned int sd_size =3D st_size;

Should this be written as
	unsigned int sd_size =3D (unsigned int)st_size;


> +
> +	if(!sd_size && st_size)
> +		return 0x80000000;
> +	else
> +		return sd_size;
> +}
> +
>  void fill_stat_data(struct stat_data *sd, struct stat *st)
>  {
>  	sd->sd_ctime.sec =3D (unsigned int)st->st_ctime;
> @@ -173,7 +185,7 @@ void fill_stat_data(struct stat_data *sd, struct sta=
t *st)
>  	sd->sd_ino =3D st->st_ino;
>  	sd->sd_uid =3D st->st_uid;
>  	sd->sd_gid =3D st->st_gid;
> -	sd->sd_size =3D st->st_size;
> +	sd->sd_size =3D munge_st_size(st->st_size);
>  }
>
>  int match_stat_data(const struct stat_data *sd, struct stat *st)
> @@ -212,7 +224,7 @@ int match_stat_data(const struct stat_data *sd, stru=
ct stat *st)
>  			changed |=3D INODE_CHANGED;
>  #endif
>
> -	if (sd->sd_size !=3D (unsigned int) st->st_size)
> +	if (sd->sd_size !=3D munge_st_size(st->st_size))
>  		changed |=3D DATA_CHANGED;
>
>  	return changed;
> --
> 2.36.0
>
