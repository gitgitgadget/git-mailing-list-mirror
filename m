From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: update the right file in multiple checkouts
Date: Tue, 25 Aug 2015 09:38:23 -0700
Message-ID: <xmqqlhcz1fy8.fsf@gitster.dls.corp.google.com>
References: <CACsJy8A2sUEcaY2JryTHj3hvES-VDJt_eMgogP5WjVA3FiXDsg@mail.gmail.com>
	<1440498646-25663-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 18:38:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUHF0-0006JB-89
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 18:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbbHYQiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 12:38:25 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36821 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbbHYQiY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 12:38:24 -0400
Received: by padfo6 with SMTP id fo6so12645066pad.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 09:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=A3V/oNA1T3kWRNPd6ku3ZB5dYwyQbvwYL9jiAmr2VpE=;
        b=In0A7FnKzeylZUgr4/QSEswE1JVxzIYOvD3jet5vllJmBqMHk5XrtMT7t8tk3HMQYV
         GDf7SdQ/RMjpc5hpbK5P6xqi/J4LBEgRbc2xr8G+acvBKa/1AsMDvdtyrzvNG8V6S1fW
         stZbgwouJs8cm5LJBFgcEJ15iWdwSJeEZf7vtQoND7+CpZXgH0Kocg2Oww4nZcqDqSne
         bjZYSSOxqzL813xSOvtC2UQXCMDWQ2aTLHKN37n0ZyTuR+97ZpmGOgeiURlb8h1fWq69
         lgXDdLuMyAZ90SHHeVLlEjrzaK8kfxr4RMsSS+nH5Jb6mJf3f3wUV8HqSOX7p3Y/QZpG
         Lt1A==
X-Received: by 10.67.8.106 with SMTP id dj10mr48107662pad.123.1440520704109;
        Tue, 25 Aug 2015 09:38:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id e6sm21701377pas.35.2015.08.25.09.38.23
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 09:38:23 -0700 (PDT)
In-Reply-To: <1440498646-25663-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 25
 Aug 2015 17:30:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276536>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This code is introduced in 23af91d (prune: strategies for linked
> checkouts - 2014-11-30), and it's supposed to implement this rule fro=
m
> that commit's message:
>
>  - linked checkouts are supposed to keep its location in $R/gitdir up
>    to date. The use case is auto fixup after a manual checkout move.
>
> Note the name, "$R/gitdir", not "$R/gitfile". Correct the path to be
> updated accordingly.
>
> While at there, make sure I/O errors are not silently dropped.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  The code was right in v2 [1] and became "gitfile" since v3 [2]. I
>  need to reconsider my code quality after this :(

Heh, don't sweat it.  Everybody makes mistakes and sometimes becomes
sloppy.

Thanks for double checking and correcting.  Perhaps this could have
caught if we had some test coverage, I wonder?

>  [1] http://article.gmane.org/gmane.comp.version-control.git/239299
>  [2] http://article.gmane.org/gmane.comp.version-control.git/242325
>
>  setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 5f9f07d..64bf2b4 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -402,9 +402,9 @@ static void update_linked_gitdir(const char *gitf=
ile, const char *gitdir)
>  	struct strbuf path =3D STRBUF_INIT;
>  	struct stat st;
> =20
> -	strbuf_addf(&path, "%s/gitfile", gitdir);
> +	strbuf_addf(&path, "%s/gitdir", gitdir);
>  	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
> -		write_file(path.buf, 0, "%s\n", gitfile);
> +		write_file(path.buf, 1, "%s\n", gitfile);
>  	strbuf_release(&path);
>  }
