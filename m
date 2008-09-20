From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 01/14] Extend index to save more flags
Date: Sat, 20 Sep 2008 14:59:20 -0700 (PDT)
Message-ID: <m3skrulbrd.fsf@localhost.localdomain>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
	<1221904913-25887-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 00:00:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhAVF-0006Y4-Mp
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 00:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbYITV7Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 17:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYITV7Y
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 17:59:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:14254 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbYITV7X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Sep 2008 17:59:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so943519fgg.17
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 14:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=Ln8uH3kxZ7i7vGAlLwUFzhlHke4SvskQNRdkSzYeUVc=;
        b=ixKPFlRMq3ZKkmjTrG1rZs1rQWZNbmc2y2EfB31LK73umvHEF69lCTtqm+ORrPlhm/
         VC05HDNeU2QNFlNMS/9pqOzyTuFyl60ED2ZjsThgB3iWB+JM1REPGXa5rMNb8zDvNAw3
         k0aYa+EcMtkrc3pOEbNaFNpKbBB3TDXGOTJSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=qUQn8+UH6AElZ23NtMaKyAYrNg4RpphhMJqXBEJDFu3g+BOXvfaWX68tn74jb+mYRm
         G6FX8YHyxHJhYVKSW6j4Qb2NbeUOxt6h4LuzOGU4pPGeuy6kuR6dK5B4xFgJY0IvIWaQ
         0os1Bs92141XbZi/ls2Ys0WdrsZIcSEwIQ7dw=
Received: by 10.86.93.19 with SMTP id q19mr3408003fgb.76.1221947961773;
        Sat, 20 Sep 2008 14:59:21 -0700 (PDT)
Received: from localhost.localdomain (abvc201.neoplus.adsl.tpnet.pl [83.8.200.201])
        by mx.google.com with ESMTPS id l19sm3157080fgb.7.2008.09.20.14.59.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 14:59:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8KLxKEK001322;
	Sat, 20 Sep 2008 23:59:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8KLxJSS001319;
	Sat, 20 Sep 2008 23:59:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1221904913-25887-2-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96369>

Comments below are just nitpicking. Feel free to diregard them...

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> The on-disk format of index only saves 16 bit flags, nearly all have
> been used. The last bit (CE_EXTENDED) is used to for future extension=
=2E
>=20
> This patch extends index entry format to save more flags in future.
> The new entry format will be used when CE_EXTENDED bit is 1.
>=20
> Because older implementation may not understand CE_EXTENDED bit and
> misread the new format, if there is any extended entry in index, inde=
x
> header version will turn 3, which makes it incompatible for older git=
=2E
> If there is none, header version will return to 2 again.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

It would be nice if at least this part of series got accepted...

> ---
>  cache.h      |   58 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++----
>  read-cache.c |   51 +++++++++++++++++++++++++++++++++++++++++-------=
---
>  2 files changed, 95 insertions(+), 14 deletions(-)
>=20
> diff --git a/cache.h b/cache.h
> index f4b8ddf..77b6eb3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -109,6 +109,26 @@ struct ondisk_cache_entry {
>  	char name[FLEX_ARRAY]; /* more */
>  };
> =20
> +/*
> + * This struct is used when CE_EXTENDED bit is 1
> + * The struct must match ondisk_cache_entry exactly from
> + * ctime till flags
> + */

Errr... "must match"? Wouldn't "does match" be better?
This type is defined below, not is to be defined...

> +struct ondisk_cache_entry_extended {
> +	struct cache_time ctime;
> +	struct cache_time mtime;
> +	unsigned int dev;
> +	unsigned int ino;
> +	unsigned int mode;
> +	unsigned int uid;
> +	unsigned int gid;
> +	unsigned int size;
> +	unsigned char sha1[20];
> +	unsigned short flags;
> +	unsigned short flags2;

flags and flags2? Why not flags1 and flags2, or flags[2], or flags and
flags_ext/flags_extended?

Just nitpicking.

> +	char name[FLEX_ARRAY]; /* more */
> +};
> +
>  struct cache_entry {
>  	unsigned int ce_ctime;
>  	unsigned int ce_mtime;
> @@ -130,7 +150,15 @@ struct cache_entry {
>  #define CE_VALID     (0x8000)
>  #define CE_STAGESHIFT 12
> =20
> -/* In-memory only */
> +/*
> + * Range 0xFFFF0000 in ce_flags is divided into
> + * two parts: in-memory flags and on-disk ones.
> + * Flags in CE_EXTENDED_FLAGS will get saved on-disk

Semicolon at the end of below text to separate, I think. Or at least
comma.

> + * if you want to save a new flag, add it in
> + * CE_EXTENDED_FLAGS

Nice comment.

> + *
> + * In-memory only flags
> + */
>  #define CE_UPDATE    (0x10000)
>  #define CE_REMOVE    (0x20000)
>  #define CE_UPTODATE  (0x40000)
> @@ -140,6 +168,24 @@ struct cache_entry {
>  #define CE_UNHASHED  (0x200000)
> =20
>  /*
> + * Extended on-disk flags
> + */
> +/* CE_EXTENDED2 is for future extension */
> +#define CE_EXTENDED2 0x80000000

Perhaps CE_RESERVED then?

> +
> +#define CE_EXTENDED_FLAGS (0)
> +
> +/*
> + * Safeguard to avoid saving wrong flags:
> + *  - CE_EXTENDED2 won't get saved until its semantic is known
> + *  - Bits in 0x0000FFFF have been saved in ce_flags already
> + *  - Bits in 0x003F0000 are currently in-memory flags
> + */
> +#if CE_EXTENDED_FLAGS & 0x80CFFFFF
> +#error "CE_EXTENDED_FLAGS out of range"
> +#endif

I don't quite understand the above fragment (especially with the fact
that CE_EXTENDED_FLAGS is defined as (0))...

> diff --git a/read-cache.c b/read-cache.c
> index c5a8659..667c36b 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1096,7 +1096,7 @@ static int verify_hdr(struct cache_header *hdr,=
 unsigned long size)
> =20
>  	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
>  		return error("bad signature");
> -	if (hdr->hdr_version !=3D htonl(2))
> +	if (hdr->hdr_version !=3D htonl(2) && hdr->hdr_version !=3D htonl(3=
))
>  		return error("bad index version");

By the way: what was index version 1?

[...]
--=20
Jakub Narebski
Poland
ShadeHawk on #git
