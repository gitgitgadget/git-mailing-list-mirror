Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E840C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 22:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiL1WHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 17:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiL1WG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 17:06:58 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06D8140A9
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672265209; bh=/NgZZYkjHRStn/dBwSMtIFavTOqgFvsS/zFEunGd3A0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mYFBxaDPZq56PJqKy/0Z7o+lYbPqrUYKz9GYrLD8ah4ySd+HiNx+UmZHMJnG/pVDn
         uh8QgWo0/kcd6IQBEtXSeRjaEQhjVXrGd5Y0RKauuYjYgwCacHlVehfU9SXXHVObwL
         69h2L42oti2H5YFm5Ls0DpxLAWOWJYT+xgqRJy10bG5Nb/Y52K4ZRnEZZJs9dbpkFv
         u1GGm2zZpD8p73el/OHN3j4Ury+wOwYuqaHrntqHhUclS46GTbwHusw5Lzz7Qe1Mms
         0vo729jjvz/VAbkLIClm5hVP9MSAsbmjFx+AP5Fg2F/SJomvW1XeOtn4o5iIkmKl1u
         8Jz0kcUcX91uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McIgY-1oY0Mn0D9g-00ctso; Wed, 28
 Dec 2022 23:06:49 +0100
Message-ID: <473c71c1-2456-fe03-a758-4952cb0835c5@web.de>
Date:   Wed, 28 Dec 2022 23:06:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 15/20] builtin/merge.c: always free "struct strbuf msg"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-15.20-8deeee4278d-20221228T175512Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-15.20-8deeee4278d-20221228T175512Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4F+0DibSbn/XfbrI+c1Vfh+Gp4EyJrnhK3laYi0KNcIECbhLbit
 /cWC9CkMlDIwPZkECCsS0BGVQcCvYbKByPRAT5H8JUZ3XDOoew6lyCvlAHkxG6uLE9gGTYt
 8cXBzSMPNpzvtj0GLlrRy80uL38QB1/yzRMOqs8zKmgDmEJQ8oNxBZJvYcJ3EKGdGCXmgVP
 3cowbmUN/P6VIxyAZdsKQ==
UI-OutboundReport: notjunk:1;M01:P0:a1+QZPZ1kcQ=;u9emUTrhkd71sQT53zjfHWKMpDN
 ROJdaDujP8MjloQzcJUjHjCz7AZ5TM30thkonaq+nE9DLjPlfsELF9YTHljLTjyIb3bmo+fj6
 beguNsxXYbigZ2E+YTFgwDkkfG+fyjp746Vjo92RAMNb8xKghys/P4fijaxhBJB6rpGqmXr7F
 FJYHWBFIYSwwtZt72UAKBofhdXx5PPZ86AL9lBZmSAtj9ay/g0pxcmX8oTc9GPCocsUr15xdF
 h7QZXZifqcisTAUN2D5GXKyRNssWjVgXpiI0KZ6/QogDhcmTrIPVwI79CSm8Zfgs1l5LWuHCi
 +fmOmJcjeJAJF+7uBBTiA7fAfUlDGSxGied14wzSODM7Z7NbQyjF+e85V7DlLXDXu0ph2F8uy
 5GbUO1zdu2+ukYMUpZPiF7NoWnTFkIyS1ZYAP/7ovKStM7MK5GOY5OY4h/0jpzKG90cKxiyVh
 +IGJwgEyatqJOw5lD91+S/EZpNyyxH5PRKfPVSrJDyf4XlWEGbXdaw6e4vv2zCKXT6sDQhJc2
 oekdq5UyYjEHmH15bXzAAs337YOimohrpyRW1vprEKZ59aDyEt16jaTmJUghwcDQxsCskxr2c
 PgUipheqsI8yGyg+cFprZlulj4j2cgYWHWT7sNcyzx7CrIyD1ko6p6bheyzydDXCYMRCPhD/J
 Zy0mQzcMz5vEZ0ea5Ekzzc6APpOffFdpL7FsL0yugMPTbqFjmJPV6CDxt3Hkc8lLuALo93YeD
 GHV5Gom1JILOHf2ErMBuWjX6BdEdaB7lgeL7vmTgJhZGta8X9gbteadbeGbo4tFrsPyQnKJ1Y
 T10o5f//MJ4qDfe1Tgnh4e0NV1lI0koA+4ZlypXUsE80JsIMRFJ7+1oAUYjU1yBTO1KlzQWWq
 gj3cjciTYt0w+7uLidkEagWGQqOIwniIVyUbgxEhBSHu1PMY1GNgOp7MtBYnv873ezfTgb3f7
 6z4Gph3MduKyb6QyOlPSRhAxNm0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.22 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Follow-up 465028e0e25 (merge: add missing strbuf_release(),
> 2021-10-07) and free "&msg" also when we'd "goto done" from the scope
> it's allocated in.

OK, but quite some trouble to go through to get one of two static
strings out without leaking.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/merge.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 0f093f2a4f2..8f78f326dbe 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1577,6 +1577,7 @@ int cmd_merge(int argc, const char **argv, const c=
har *prefix)
>  		commit =3D remoteheads->item;
>  		if (!commit) {
>  			ret =3D 1;
> +			strbuf_release(&msg);
>  			goto done;
>  		}
>
> @@ -1589,6 +1590,7 @@ int cmd_merge(int argc, const char **argv, const c=
har *prefix)
>  					  overwrite_ignore)) {
>  			apply_autostash(git_path_merge_autostash(the_repository));
>  			ret =3D 1;
> +			strbuf_release(&msg);
>  			goto done;
>  		}
>

How about not using strbuf instead?

 builtin/merge.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0f093f2a4f..91dd5435c5 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1560,7 +1560,9 @@ int cmd_merge(int argc, const char **argv, const cha=
r *prefix)
 			!common->next &&
 			oideq(&common->item->object.oid, &head_commit->object.oid)) {
 		/* Again the most common case of merging one remote. */
-		struct strbuf msg =3D STRBUF_INIT;
+		const char *msg =3D have_message ?
+			"Fast-forward (no commit created; -m option ignored)" :
+			"Fast-forward";
 		struct commit *commit;

 		if (verbosity >=3D 0) {
@@ -1570,10 +1572,6 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 			       find_unique_abbrev(&remoteheads->item->object.oid,
 						  DEFAULT_ABBREV));
 		}
-		strbuf_addstr(&msg, "Fast-forward");
-		if (have_message)
-			strbuf_addstr(&msg,
-				" (no commit created; -m option ignored)");
 		commit =3D remoteheads->item;
 		if (!commit) {
 			ret =3D 1;
@@ -1592,9 +1590,8 @@ int cmd_merge(int argc, const char **argv, const cha=
r *prefix)
 			goto done;
 		}

-		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
+		finish(head_commit, remoteheads, &commit->object.oid, msg);
 		remove_merge_branch_state(the_repository);
-		strbuf_release(&msg);
 		goto done;
 	} else if (!remoteheads->next && common->next)
 		;
