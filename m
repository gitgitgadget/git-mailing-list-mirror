From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 03/21] pathspec: make sure the prefix part is wildcard-clean
Date: Mon, 7 Jan 2013 08:10:27 +0700
Message-ID: <CACsJy8AHZhrXMziaERxXRg_s9aXa0SX=JzHbpvOA_BhG0-c59w@mail.gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com> <1357453268-12543-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 02:11:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts1FG-0003lq-S9
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 02:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab3AGBK7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 20:10:59 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:42776 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab3AGBK5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 20:10:57 -0500
Received: by mail-ob0-f177.google.com with SMTP id uo13so16445757obb.8
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 17:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LCfRW6zdJXIu9OG+1xwJtlhlQvGDXl/amUQe9TiQ8mg=;
        b=I/IGftdQf+gFzUXPDk4gADN4RzPnYxa4D5AZu60FuDVPlYaf6HYMWvAAZBm7VpwQN5
         pgM8eatCwDq3HcHWVpOpsdmbsdD0qrNT4rP2xvl0RTKaMB8iUuEsfi2biOHp5zedTVVt
         VJSM3g7t1YnDj332KqUH5F/50jBirM6dydN074PeI1x8Af0Ix6e9m+mRNbZy9JhBwOfk
         tFYIEGfYeRPIEnO6ds1bBjKH4IYZM7loj526iJBlqLj9yPTAC6fjVVtlQGOatyONL5Kj
         S2hzB3Vm831+mrk6HInQqHLwz1A/yTGB6inewn2YRHkkvdkjbXZ90cQAbd0OtF0NObiK
         ajdQ==
Received: by 10.60.3.1 with SMTP id 1mr32564548oey.138.1357521057227; Sun, 06
 Jan 2013 17:10:57 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 6 Jan 2013 17:10:27 -0800 (PST)
In-Reply-To: <1357453268-12543-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212862>

On Sun, Jan 6, 2013 at 1:20 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> --- a/setup.c
> +++ b/setup.c
> @@ -250,6 +250,8 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
>         *raw =3D item->match;
>         item->len =3D strlen(item->match);
>         item->nowildcard_len =3D simple_length(item->match);
> +       if (item->nowildcard_len < prefixlen)
> +               item->nowildcard_len =3D prefixlen;
>         return magic;
>  }

This is wrong (so much for the last-minute patch). Prefix length
depends on actual pathspec (e.g. abc, ../abc and ../../abc use
different prefix length). This patch should be discarded (it does not
have any real impacts anyway).
--=20
Duy
