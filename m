From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH 1/3] clone: do not accept --depth on local clones
Date: Thu, 19 Aug 2010 22:49:06 +0200
Message-ID: <AANLkTimouObkUFVff8GQgGy7cDMAHXTDxGQx0gJUOO2Q@mail.gmail.com>
References: <201008180854.18474.ComputerDruid@gmail.com>
	<1282214437-16384-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, computerdruid@gmail.com, joey@kitenet.net
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 22:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmC30-0004fj-9J
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 22:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab0HSUtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 16:49:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59752 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab0HSUtH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 16:49:07 -0400
Received: by vws3 with SMTP id 3so2252005vws.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TffW7v+pub5cHNQfwzwkknTWbEygMtDoeUcmeBuASYI=;
        b=WyQ3nFPl5VKYu1otD3QUYp+8T/GRrnuqr6oj/tqKN5Fep5NcOFVXQ5FKkFZp3Xp4QT
         P9nZ3FPm26/wj6czFo/Dw5depWSUvjr598yZkV1zfqSoYXhcBgkWP2gHh1DYI1nNJ9j+
         Or3ga/zDIe603tBT7YqfFhtjnlKoxvX5F3OHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xR2w3zjadmWcfs8tO7gKTu8uQNbgQgsXNg2urCjD8p1znggy0Ww+3c5Cfjl7EjTHvz
         7okVkWHLRxe+lRoEC37ghnk6gltoqsQB0XzUn5LJfEUt8tEOWr/DJZcHoQOgTSex6Rca
         Zj9MutLs/+OUmbbrjASTPLtHSq2bwZkA5ncug=
Received: by 10.220.124.224 with SMTP id v32mr269919vcr.4.1282250946536; Thu,
 19 Aug 2010 13:49:06 -0700 (PDT)
Received: by 10.220.191.75 with HTTP; Thu, 19 Aug 2010 13:49:06 -0700 (PDT)
In-Reply-To: <1282214437-16384-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153958>

2010/8/19 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/clone.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index efb1e6f..215c432 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -414,6 +414,9 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
>                repo =3D xstrdup(make_absolute_path(repo_name));
>        else
>                repo =3D repo_name;
> +       is_local =3D path && !is_bundle;
> +       if (is_local && option_depth)
> +               die("local clone with --depth does not make sense");
>
>        if (argc =3D=3D 2)
>                dir =3D xstrdup(argv[1]);

Wouldn't it be more helpful to also say "Use the file:///blabla syntax
instead" or just automatically fall back to that protocol when --depth
is used?

--=20
Mikael Magnusson
