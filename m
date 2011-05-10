From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 7/9] mv ":" ":" is like moving nothing from nowhere to nowhere
Date: Tue, 10 May 2011 20:30:37 +0700
Message-ID: <BANLkTinBv+aRfgdnFKM-=yedug+WtseXsQ@mail.gmail.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com> <1305006678-4051-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 15:31:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJn1u-0007LG-ON
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 15:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab1EJNbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 09:31:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50595 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab1EJNbI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 09:31:08 -0400
Received: by fxm17 with SMTP id 17so4302235fxm.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ZE27XqJ7IJtS2PQJMV1KXml9ASZpxTVLR5a6IfKPAN8=;
        b=XsJ1xmN2sXVc87/HCGkrf0yWueZkVJafSGpMAciI8ss9OJhWOzRzkTXCJGcTDnDxIz
         +eRpE9kGclPc3kZU/mPb/JZfglAlE1d7RfqB1/qXqdYhA8NAYNVY4xzUKoIO44dphOQ2
         32hEOyb0AFMLI8kQ+r1jDTbLt90D8SsM6rnH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jQ+MYSRVsjTJNPdV8mJHv4C0IpJm6KyzEcnB1uO1QLiBmj1JL+7ky+1uPoDTuHm90W
         1622IgPc6KYmgvIiduXqVPO/5hxH9XRCB8AKNdLeA05ZycabqMF6jkSlMEs9xofrJZ2l
         oV5BEsZgChHOpW2aX7sE+lhJTi8fGM2SpkuoM=
Received: by 10.223.159.14 with SMTP id h14mr1155565fax.20.1305034267269; Tue,
 10 May 2011 06:31:07 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Tue, 10 May 2011 06:30:37 -0700 (PDT)
In-Reply-To: <1305006678-4051-8-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173335>

On Tue, May 10, 2011 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 93e8995..38af9f0 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -77,8 +77,12 @@ int cmd_mv(int argc, const char **argv, const char=
 *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("index fil=
e corrupt");
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0source =3D copy_pathspec(prefix, argv, arg=
c, 0);
> - =C2=A0 =C2=A0 =C2=A0 modes =3D xcalloc(argc, sizeof(enum update_mod=
e));
> + =C2=A0 =C2=A0 =C2=A0 if (!source)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("copying from =
nowhere?");
> + =C2=A0 =C2=A0 =C2=A0 modes =3D xcalloc(count_pathspec(source), size=
of(enum update_mode));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dest_path =3D copy_pathspec(prefix, argv +=
 argc, 1, 0);
> + =C2=A0 =C2=A0 =C2=A0 if (!dest_path)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("copying to no=
where?");
>

This command is interesting. Note to self: adding support for "git mv
'*.c' to/there".

I think we could take get_pathspec() out of copy_pathspec() and call
it just once (in case get_pathspec() or its successor does fancy
things), something roughly like this

diff --git a/builtin/mv.c b/builtin/mv.c
index 40f33ca..a032789 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -32,7 +32,7 @@ static const char **copy_pathspec(const char
*prefix, const char **pathspec,
 			result[i] =3D base_name ? strdup(basename(it)) : it;
 		}
 	}
-	return get_pathspec(prefix, result);
+	return result;
 }

 static const char *add_slash(const char *path)
@@ -60,7 +60,7 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 		OPT_BOOLEAN('k', NULL, &ignore_errors, "skip move/rename errors"),
 		OPT_END(),
 	};
-	const char **source, **destination, **dest_path;
+	const char **pathspec, **source, **destination, **dest_path;
 	enum update_mode { BOTH =3D 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
 	struct string_list src_for_dst =3D STRING_LIST_INIT_NODUP;
@@ -69,16 +69,20 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)

 	argc =3D parse_options(argc, argv, prefix, builtin_mv_options,
 			     builtin_mv_usage, 0);
-	if (--argc < 1)
+
+	pathspec =3D get_pathspec(prefix, argv);
+	argc =3D count_pathspec(pathspec);
+
+	if (--argc < 1 || !pathspec)
 		usage_with_options(builtin_mv_usage, builtin_mv_options);

 	newfd =3D hold_locked_index(&lock_file, 1);
 	if (read_cache() < 0)
 		die(_("index file corrupt"));

-	source =3D copy_pathspec(prefix, argv, argc, 0);
+	source =3D copy_pathspec(prefix, pathspec, argc, 0);
 	modes =3D xcalloc(argc, sizeof(enum update_mode));
-	dest_path =3D copy_pathspec(prefix, argv + argc, 1, 0);
+	dest_path =3D copy_pathspec(prefix, pathspec + argc, 1, 0);

 	if (dest_path[0][0] =3D=3D '\0')
 		/* special case: "." was normalized to "" */
--=20
Duy
