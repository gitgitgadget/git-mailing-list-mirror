From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/26] transport-helper.c: refactor set_helper_option()
Date: Wed, 25 May 2016 02:47:56 -0400
Message-ID: <CAPig+cR--ZK1eGfOKfE-PhKha80EqwVi-AH90GxOQt4vka3=tg@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
	<1460552110-5554-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 08:48:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Sc9-0006gA-92
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 08:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbcEYGr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2016 02:47:58 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33203 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcEYGr5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2016 02:47:57 -0400
Received: by mail-io0-f171.google.com with SMTP id t40so26671459ioi.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 23:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=geYK2yv7VyDOkfMXaBTaLIc9Wdsmc+YB3JBlHWAOn/w=;
        b=N56KgeawUKrNkw6GwXC4Ocrn/bHVuibJTCfrSSPuoGpH6G2ZxQVuFCyclpjXIgl591
         tkN/dkH036yMDvBGi+dSPPI65TdxbXR5ySSqLLHeP9oiE0Dq2HLOflFc6hi2Wu9/DDWB
         FkOGAqsfEYKougX8aVaYupv+/xfMmX7FnxRPDYx7K26NZseLdNUUvtB0+7YfQOl574Qn
         9vVBkcs50gcDC8ltMh1YIBnFeoTtKZ37t8Vn0OUmPnIDe6RhvFdYjVJVpVs1SAJjhm+W
         f3KscFU7b0K3TkLD+ko60hTcfGWkWSvb7nKAVOdm2zbIVhzCNX5iBIQlDrcpvfugMSSg
         gk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=geYK2yv7VyDOkfMXaBTaLIc9Wdsmc+YB3JBlHWAOn/w=;
        b=cynzm+/uX4DB2VQ98SUxG/ZOF1sGyFBaIgpn0+hNI4MXx7AWj0s6UnKDdEg/ftncdF
         7vQWrxXUhWWiPINZb+3JJgtNeYZPH6ViaoUbWs0K8EgNCSGO3bdl6buQiWZEU9s8oTyV
         5yyvSL/h48BzihHuNmWO2waQ0+6IoU5LwPp7mDb06mZBVWktSPWy/nOnL1gx5l6d/nOv
         pGeHrgBBfDpY/RthlTvNLOtMo/BvlfwhWNEFDmcYdSrJYxugDkP23XKqtUAqL7HcgLYd
         Fyh88VZYsDLZBeKatUXLjhBwdj4dFMTK7YxX6eTKTujyTAL3W0Cp8pzo9SyeiqN8oRSZ
         qFbA==
X-Gm-Message-State: ALyK8tJL3xq+tdH47e6lubNtPb4WDTvL45a3YD+o/KCJTMuLYS5VqKSZ9l+w8JK/YwZigGmkKAPZfQpTNhy4eA==
X-Received: by 10.107.47.37 with SMTP id j37mr2261837ioo.168.1464158876918;
 Tue, 24 May 2016 23:47:56 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Tue, 24 May 2016 23:47:56 -0700 (PDT)
In-Reply-To: <1460552110-5554-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 3tJ-HOviX4a4lh7bR8IifDqhyeM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295564>

On Wed, Apr 13, 2016 at 8:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> For now we can handle two types, string and boolean, in
> set_helper_option(). Later on we'll add string_list support, which do=
es
> not fit well. The new function strbuf_set_helper_option() can be reus=
ed
> for a separate function that handles string-list.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/transport-helper.c b/transport-helper.c
> @@ -260,6 +260,28 @@ static const char *boolean_options[] =3D {
> +static int strbuf_set_helper_option(struct helper_data *data,
> +                                   struct strbuf *buf)
> +{
> +       int ret;
> +
> +       sendline(data, buf);
> +       if (recvline(data, buf))
> +               exit(128);
> +
> +       if (!strcmp(buf->buf, "ok"))
> +               ret =3D 0;
> +       else if (starts_with(buf->buf, "error")) {
> +               ret =3D -1;
> +       } else if (!strcmp(buf->buf, "unsupported"))

You could use this opportunity to drop the unnecessary braces. (True,
doing so makes it something other than pure code movement, but it's
minor and probably a worthy cleanup.)

> +               ret =3D 1;
> +       else {
> +               warning("%s unexpectedly said: '%s'", data->name, buf=
->buf);
> +               ret =3D 1;
> +       }
> +       return ret;
> +}
> +
>  static int set_helper_option(struct transport *transport,
>                           const char *name, const char *value)
>  {
> @@ -291,20 +313,7 @@ static int set_helper_option(struct transport *t=
ransport,
>                 quote_c_style(value, &buf, NULL, 0);
>         strbuf_addch(&buf, '\n');
>
> -       sendline(data, &buf);
> -       if (recvline(data, &buf))
> -               exit(128);
> -
> -       if (!strcmp(buf.buf, "ok"))
> -               ret =3D 0;
> -       else if (starts_with(buf.buf, "error")) {
> -               ret =3D -1;
> -       } else if (!strcmp(buf.buf, "unsupported"))
> -               ret =3D 1;
> -       else {
> -               warning("%s unexpectedly said: '%s'", data->name, buf=
=2Ebuf);
> -               ret =3D 1;
> -       }
> +       ret =3D strbuf_set_helper_option(data, &buf);
>         strbuf_release(&buf);
>         return ret;
>  }
