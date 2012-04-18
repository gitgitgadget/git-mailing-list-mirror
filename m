From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH i18n 05/11] i18n: help: mark strings for translation
Date: Wed, 18 Apr 2012 14:30:28 -0500
Message-ID: <20120418193006.GA30361@burratino>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
 <1334580603-11577-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 21:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKaaQ-00082K-E4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 21:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab2DRTai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 15:30:38 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48130 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab2DRTah convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 15:30:37 -0400
Received: by iagz16 with SMTP id z16so10823189iag.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0riTvYOZzyGSks4tGHMWDjqdAmSZW3LgaT9g7WOsRoE=;
        b=cvZBByqyXVGdFDrmembQQYf9qHTdOUTr6L76gJmoerb9JXy/Y3COc2FjTLJXcFpEtT
         cEf+amPE/3Bvn0P8NT5YFzk09QIlBTJLRKnZsA9iEI+cE8n4mwgq8mitV0Ng0FqLKg7G
         NdAJyB3GrGGEIKnZFkK1KdijBllgQXcoNN9sojOkz/421VprK352+KGNu0lkFYJyAj8C
         5DEpTEJP9j6ueD56+es/BFHbMK/CzEgJaWSovrW/GAzXC8Jiyf+sixb53LUCVkyojaZ4
         YBPOr/wgh5Z7hQCsXj40HpOMUav7mV1k0aVI+iYUUTW896aG9ix1b9DQKnkqS8PvbtsO
         qFtw==
Received: by 10.50.17.201 with SMTP id q9mr3262433igd.19.1334777436912;
        Wed, 18 Apr 2012 12:30:36 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c2sm45873511igj.1.2012.04.18.12.30.35
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 12:30:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334580603-11577-6-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195887>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This patch also marks most common commands' synopsis for translation
> so that "git help" gives a friendly listing.
[...]
> --- a/Makefile
> +++ b/Makefile
> @@ -2282,7 +2282,7 @@ XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --langua=
ge=3DC \
>  	--keyword=3D_ --keyword=3DN_ --keyword=3D"Q_:1,2"
>  XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShell
>  XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --keyword=3D__ --language=3D=
Perl
> -LOCALIZED_C :=3D $(C_OBJ:o=3Dc)
> +LOCALIZED_C :=3D $(C_OBJ:o=3Dc) common-cmds.h

LOCALIZED_C probably ought to include

	$(LIB_H) branch.h bundle.h bisect.h fetch-pack.h thread-utils.h
	send-pack.h shortlog.h reachable.h wt-status.h tar.h url.h walker.h
	$(XDIFF_H) $(VCSSVN_H)

too, just in case.  This would involve moving the definitions of
XDIFF_H and VCSSVN_H out of the ifndef USE_COMPUTED_HEADER_DEPENDENCIES
block.

Sorry I missed this before.

[...]
> +++ b/git.c
[...]
> @@ -389,6 +397,6 @@ const char *help_unknown_cmd(const char *cmd)
> =20
>  int cmd_version(int argc, const char **argv, const char *prefix)
>  {
> -	printf("git version %s\n", git_version_string);
> +	printf_ln(_("git version %s"), git_version_string);
>  	return 0;

An odd one.  I think it's probably best to leave it untranslated for
the sake of i18n-unaware scripts. :(

Thanks,
Jonathan
