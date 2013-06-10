From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/45] parse_pathspec: support stripping submodule
 trailing slashes
Date: Sun, 9 Jun 2013 21:36:35 -0400
Message-ID: <CAPig+cQ_7iN8gFYwmc2d24dq2m_TO2PB84VYph2HpUsT7PLSow@mail.gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
	<1370759178-1709-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 03:36:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulr2H-0006Sy-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 03:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab3FJBgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 21:36:37 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:44984 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab3FJBgh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 21:36:37 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so850424lbd.1
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 18:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hCtCdjuFc8Ys9RUnnPlUa2sEgoBR3VsPQHJg5YlgKuo=;
        b=xZz+v79Ph+wkJMWaO4FoxPNf5Q2lsyxY8OFX/TM1OY9glpaFdDE8rPyKql0+N831/C
         1ZxVFDlGWyEDfFT9BdtOQr3P8Gn3nNZKpvaDdfKVnGvZvb1Awc4xdXg8OmGEyngz5OJH
         JFPnabO8Yc56VzFGMeaxsr+s+E8Goffj90iSBY0GfY4d9ZeoMdGbR6FVkDIaBsWC/WdL
         1E837YOyMiZBqbLOaYyX1a5Ua2R2rAyIo1eH6efh0kcvGeluG6EBB71lzR7gEOVDKRAO
         qTi9X9FUT/OM5eQbpPpQci7pkOCYvZVMuB2vmsLaIu5OS27lnd8njYKC3SaDqHSxBXbX
         +OLw==
X-Received: by 10.112.181.71 with SMTP id du7mr5426480lbc.24.1370828195436;
 Sun, 09 Jun 2013 18:36:35 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 18:36:35 -0700 (PDT)
In-Reply-To: <1370759178-1709-11-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: NCTdPW5XlY1wEivO9ATXV-kXxMU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227227>

On Sun, Jun 9, 2013 at 2:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This flag is equivalent to builtin/ls-files.c:strip_trailing_slashes(=
)
> and is intended to replace that function when ls-files is converted t=
o
> use parse_pathspec.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/pathspec.h b/pathspec.h
> index aa98597..7935b26 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -31,6 +31,8 @@ struct pathspec {
>  #define PATHSPEC_PREFER_CWD (1<<0) /* No args means match cwd */
>  #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everythin=
g */
>  #define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid *=
/
> +/* stripping the trailing slash if the given path is a gitlink */

s/stripping/strip/

> +#define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<3)
>
>  extern int init_pathspec(struct pathspec *, const char **);
>  extern void parse_pathspec(struct pathspec *pathspec,
