Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0A1C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6BF610E5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhJ1RUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:20:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60309 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJ1RUC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 13:20:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3614153C1C;
        Thu, 28 Oct 2021 13:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RV8aJjyuddy4
        49HA8Hu+P6GJF5miiOhbMBgghSS5zdU=; b=URomFaZxh6BK6R0vdj4T/zSHckU7
        V3k5hwsj2Wd9OVGkH+rIFz+VpsjHwJmEK1txGpOrgsW0aN+Ckks7kgt4CDQOD2VX
        zQSyTY84y3ZTPsaVv540xn8LymakrJnYge+wmhzuPKbiUYcuzvriLbTuKIPVeaS6
        Xs1PRGFhrbzWPdI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB30C153C1B;
        Thu, 28 Oct 2021 13:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6A03153C19;
        Thu, 28 Oct 2021 13:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 9/9] doc: git-init: clarify file modes in octal.
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
        <7eef3538f3c3015c4f446961ddca78e2868fe644.1635438124.git.gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 10:17:29 -0700
In-Reply-To: <7eef3538f3c3015c4f446961ddca78e2868fe644.1635438124.git.gitgitgadget@gmail.com>
        (=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Thu,
 28 Oct 2021
        16:22:04 +0000")
Message-ID: <xmqqilxhrrva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EEDBEFD0-3812-11EC-B7E2-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> ---shared[=3D(false|true|umask|group|all|world|everybody|0xxx)]::
> +--shared[=3D(false|true|umask|group|all|world|everybody|<umask>)]::
> =20
>  Specify that the Git repository is to be shared amongst several users.=
  This
>  allows users belonging to the same group to push into that
> @@ -110,13 +110,15 @@ the repository permissions.
> =20
>  Same as 'group', but make the repository readable by all users.
> =20
> -'0xxx'::
> +'<umask>'::
> =20
> -'0xxx' is an octal number and each file will have mode '0xxx'. '0xxx' =
will
> -override users' umask(2) value (and not only loosen permissions as 'gr=
oup' and
> -'all' does). '0640' will create a repository which is group-readable, =
but not
> -group-writable or accessible to others. '0660' will create a repo that=
 is
> -readable and writable to the current user and group, but inaccessible =
to others.
> +'<umask>' is an 3-digit octal number prefixed with `0` and each file
> +will have mode '<umask>'. '<umask>' will override users' umask(2)
> +value (and not only loosen permissions as 'group' and 'all'
> +does). '0640' will create a repository which is group-readable, but
> +not group-writable or accessible to others. '0660' will create a repo
> +that is readable and writable to the current user and group, but
> +inaccessible to others.

Giving it a name that reflects the meaning is a great change.

Unfortunately, I think the original text is wrong to call it umask,
as this is bitwise opposite of umask(2).  umask 027 for example
means that we *drop* bits 020 and 007, causing the group members
*losing* write access, and other folks *losing* all access, from the
resulting filesystem entity.  But with this, as the description
says, you would write "0640" to mean "group members cannot write,
others have no access".

How about calling it <perm> (or <perm-bits>)?

----- >8 --------- >8 --------- >8 --------- >8 -----
From: Jean-No=C3=ABl Avila <jn.avila@free.fr>
Subject: [PATCH] doc: git-init: clarify file modes in octal.

The previous explanation was mixing the format with the identity of
the field.

Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Giving a "3-digit octal prefixed with `0`" would work fine, but
   technically, the value is parsed as an octal without the `0`
   prefix and there is no requirement for the number of digits,
   either.  But giving a stricter-than-necessary instruction is
   probably a good idea in this case.  It makes the description
   simpler.

 Documentation/git-init.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index fdb7b3f367..af0d2ee182 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -79,7 +79,7 @@ repository.  If not specified, fall back to the default=
 name (currently
 `master`, but this is subject to change in the future; the name can be
 customized via the `init.defaultBranch` configuration variable).
=20
---shared[=3D(false|true|umask|group|all|world|everybody|0xxx)]::
+--shared[=3D(false|true|umask|group|all|world|everybody|<perm>)]::
=20
 Specify that the Git repository is to be shared amongst several users.  =
This
 allows users belonging to the same group to push into that
@@ -110,13 +110,15 @@ the repository permissions.
=20
 Same as 'group', but make the repository readable by all users.
=20
-'0xxx'::
+'<perm>'::
=20
-'0xxx' is an octal number and each file will have mode '0xxx'. '0xxx' wi=
ll
-override users' umask(2) value (and not only loosen permissions as 'grou=
p' and
-'all' does). '0640' will create a repository which is group-readable, bu=
t not
-group-writable or accessible to others. '0660' will create a repo that i=
s
-readable and writable to the current user and group, but inaccessible to=
 others.
+'<perm>' is an 3-digit octal number prefixed with `0` and each file
+will have mode '<perm>'. '<perm>' will override users' umask(2)
+value (and not only loosen permissions as 'group' and 'all'
+does). '0640' will create a repository which is group-readable, but
+not group-writable or accessible to others. '0660' will create a repo
+that is readable and writable to the current user and group, but
+inaccessible to others.
 --
=20
 By default, the configuration flag `receive.denyNonFastForwards` is enab=
led
--=20
2.33.1-984-g9137471b0c
