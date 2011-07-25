From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/2] Ensure git ls-tree exits with a non-zero exit code
 if read_tree_recursive fails.
Date: Mon, 25 Jul 2011 08:31:18 +0700
Message-ID: <CACsJy8Aa_=BvZOt58sM4dknVzvihH9OtHAS1aRxqPwNLxh0fkg@mail.gmail.com>
References: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com> <1311519554-16587-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 03:31:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlA1S-0003SI-Nr
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 03:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab1GYBbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jul 2011 21:31:51 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:60164 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab1GYBbt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2011 21:31:49 -0400
Received: by fxd18 with SMTP id 18so8143806fxd.11
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 18:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/ZtYqdwbHZo9PXnZ9qOhbYmw0cU6b/LbcewRDHZJ0Is=;
        b=g6CX439aOHUyvC6lPksaxdyq2ceXOzjRAy34MO+7CZIV3ErIsAakQTJ8d9+TLBcWmM
         7javRZn/fqJ4gvZ4jBQQ7G3JW/FMrFV1rJhsSTwQmyRB4Ihu5pa1YM5FcJxRYrag42eb
         ngjsxhlzeUqiA+Piy3gljE7cCDn2otMnV664Q=
Received: by 10.205.65.13 with SMTP id xk13mr1097842bkb.400.1311557508617;
 Sun, 24 Jul 2011 18:31:48 -0700 (PDT)
Received: by 10.204.59.83 with HTTP; Sun, 24 Jul 2011 18:31:18 -0700 (PDT)
In-Reply-To: <1311519554-16587-3-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177781>

On Sun, Jul 24, 2011 at 9:59 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> @@ -173,7 +173,6 @@ int cmd_ls_tree(int argc, const char **argv, cons=
t char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tree =3D parse_tree_indirect(sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tree)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("not a tre=
e object");
> - =C2=A0 =C2=A0 =C2=A0 read_tree_recursive(tree, "", 0, 0, &pathspec,=
 show_tree, NULL);
> + =C2=A0 =C2=A0 =C2=A0 return read_tree_recursive(tree, "", 0, 0, &pa=
thspec, show_tree, NULL);
>
> - =C2=A0 =C2=A0 =C2=A0 return 0;

Nit picking. Most programs return positive value (usually 1) for error
cases here. read_tree_recursive may return -1 (which turns out to be
255). Also removing the last blank line in this function would be
nice.
--=20
Duy
