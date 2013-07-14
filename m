From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 46/46] parse_pathspec: accept :(icase)path syntax
Date: Sun, 14 Jul 2013 04:48:34 -0400
Message-ID: <CAPig+cQp71KkaXzieCc5JX+hVUJ06ydGy_RDaBMtt6AKRG+SNg@mail.gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
	<1373790969-13000-47-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 10:48:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHzD-0000c7-2e
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867Ab3GNIsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:48:37 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46213 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab3GNIsg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jul 2013 04:48:36 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so8489095lbh.21
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kUg97SH96gCt95diS4Cr4mRNyxXLBIdmyAiQrWx3g/A=;
        b=iTXp10ZFJH99q9NTkJcoevkA43ejO8qTzk1lj6p3Dd2GM0UsqawuO50ma8MEQ45bFv
         a7s0E1I48QdtrZx24oo+F+U5JiGsDbkPnBw36g1woAhfwD0L4cn7AGLYjCT+4vitggiQ
         oEPVD6erXp04e7oxu507rbkdtPidmXo51vUcLNge6UEyOBSYx9resjsmFNwJ4eyOVAaB
         iZdCX369Gle7GLcXQVVPADH1zskOPOUGC75jl08JJdkSpQCj74UEsj8vIHo/7bxGSYC4
         jEaLsp8vRo4dsOUHieGZr60qMvbZ5e9pBJDYE6Fc9kA8EidKiDyr+SSbL3f0ZJrKXW9J
         iYlA==
X-Received: by 10.152.6.228 with SMTP id e4mr22322727laa.61.1373791714791;
 Sun, 14 Jul 2013 01:48:34 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Sun, 14 Jul 2013 01:48:34 -0700 (PDT)
In-Reply-To: <1373790969-13000-47-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: xtWW1tdumIZ-TV4f5AF45WuOCw0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230359>

On Sun, Jul 14, 2013 at 4:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 3571a1b..546eea4 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -879,6 +883,10 @@ GIT_NOGLOB_PATHSPECS::
>         Setting this variable to `1` will cause Git to treat all
>         pathspecs as literal (aka "literal" magic).
>
> +GIT_ICASE_PATHSPECS::
> +       Setting this variable to `1` will cause Git to treat all
> +       pathspeccs as case-insensitive.

s/pathspeccs/pathspecs/

> @@ -110,16 +114,27 @@ static size_t common_prefix_len(const struct pa=
thspec *pathspec)
>         int n;
>         size_t max =3D 0;
>
> +       /*
> +        * ":(icase)path" is treated as a pathspec full of
> +        * wildcard. In other words, only prefix is considered common
> +        * prefix. If the pathspec is abc/foo abc/bar, running in
> +        * subdir xyz, the common prefix is still xyz, not xuz/abc as

s/xuz/xyz/
