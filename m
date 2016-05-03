From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/41] builtin/update-index.c: prefer "err" to "errno"
 in process_lstat_error
Date: Tue, 3 May 2016 12:52:01 -0400
Message-ID: <CAPig+cRASxkmgRt_gK89-qtqVPuWzq5TynaXzBY4iqcCdo2Cqg@mail.gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 18:52:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axdYV-0000iy-5v
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbcECQwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 12:52:06 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34991 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281AbcECQwD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 12:52:03 -0400
Received: by mail-ig0-f195.google.com with SMTP id fn8so3158189igb.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=+uUcRSaq4q5Av3k7Ca6CvQIZc3U753bU483tKi9ue2E=;
        b=vVoB8rS512AwlHQLZO21tbKGWIdjZcDyGOyNj0bxwympdYPmWKDJOh56lzDQyCOAyH
         5z47WkVl0SGKRvuZSsV89rZi7HAaTy5CupI+/VonPCVSBWjxi/lSmiJbEE4Pgg5tgi3s
         oyVDMnwTMSYrD1QkWbrs8cgsctrn45Q5sV0qNF/fjS7R7qxIQHn3bU/7bbHpfo7efMtB
         azmJFitDvWWECWDMUD48O5EjjEWJk1jkufWlGqs3C7Aur2WrhmR/5RfnOrfqNozQO6/J
         wdYh4sFPBf6VZSD+94UT9IgAHTtQ88VIPFMFyz1ByRoTRasclhFoSv+Gt/esWeprd01b
         +hQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=+uUcRSaq4q5Av3k7Ca6CvQIZc3U753bU483tKi9ue2E=;
        b=J0xW+T9p3Jjkl3N8tKAPqaMLu3UAb7LB5ww9nrIIR8XbRvc1AXua6EDadKvhAz9PoC
         uXuVlbxH2Y7VkkmwuWErDlX37Jec3Xt1ELSFpnSuxvrlbVn58PPrhQKl0enKHDusF3Hy
         ir9yIQrGphXyVka3+iXWBXPQl+5IJ4oUuTlMNtvqxQAdqCDIvmKX3V6/I1Vt/JzovNKX
         U2yVpXd9x4eG3IQ31NlosBd9bG19xs8vrPwrFM9mOd7lviJ9Yej3Bon/v+eEmfhmf8vc
         DmmB2oe4WUdR/kkWOujY3b117yCV/HbjAxdP1G7vrU1b69WGkQMTiSHzYhd6e+/JhrMA
         jYJw==
X-Gm-Message-State: AOPr4FXVzQVzhreWc4Hl5JyuEnr04XIDnEwalgBIamwgmisp1cDAPT46I5jFrhY4eYhg4dTDTun/I1gNIGqFqw==
X-Received: by 10.50.224.148 with SMTP id rc20mr14634733igc.73.1462294322022;
 Tue, 03 May 2016 09:52:02 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 3 May 2016 09:52:01 -0700 (PDT)
In-Reply-To: <1462277054-5943-13-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Nn9D0oX5cqrDExGHRq5SgguM3XU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293417>

On Tue, May 3, 2016 at 8:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> "errno" is already passed in as "err". Here we should use err instead=
 of
> errno. errno is probably a copy/paste mistake in e011054 (Teach
> git-update-index about gitlinks - 2007-04-12)

Thanks, this version is quite sensible and doesn't trigger any
feelings of discomfort[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/293150/focu=
s=3D293205

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/update-index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 1c94ca5..b8b8522 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -255,7 +255,7 @@ static int process_lstat_error(const char *path, =
int err)
>  {
>         if (err =3D=3D ENOENT || err =3D=3D ENOTDIR)
>                 return remove_one_path(path);
> -       return error("lstat(\"%s\"): %s", path, strerror(errno));
> +       return error("lstat(\"%s\"): %s", path, strerror(err));
>  }
>
>  static int add_one_path(const struct cache_entry *old, const char *p=
ath, int len, struct stat *st)
> --
> 2.8.0.rc0.210.gd302cd2
