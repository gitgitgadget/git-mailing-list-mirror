From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/8] fetch-pack.c: send "skip" line to pack-objects
Date: Sun, 7 Feb 2016 03:57:28 -0500
Message-ID: <CAPig+cT8G3q4uug4TObyb2jAYvTPPLdhEV2+GpzVKmA6KxsJ_A@mail.gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
	<1454662677-15137-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 09:58:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSLAX-0001qb-0V
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 09:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbcBGI5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2016 03:57:30 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33446 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbcBGI53 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 03:57:29 -0500
Received: by mail-vk0-f68.google.com with SMTP id c3so1668297vkb.0
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 00:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=N4LzP/9PzOYCiYkAs+YzwM2m4IgP0rBEzuRPIDLzBck=;
        b=lRDTJ4ec2tiUEWtZla0XiXk33iNi+rpwUz5+jpL81IDOlzgp1Z/zuibiJqDZT3jjOt
         5Mydh9FSRWw9OBmSdv6YOWEeycOt9HLpLr/Pn9mIblss3DgvMo3K+GlFY9OLHAoQ6uQS
         behVZrcG8HXqzetHbW5QFHgV+65nYEyMWL2i5oDvWZknZjtjDz6AODC/Lya0f/CfrnPk
         HLAqGpY9rnnhKhdmRlRISPGZdDE2TSP7wfEZT3poS7s5LI2CrLvGJFKw73JsY8wya+AV
         uP4OK9O+ePeoodTuLPFluATlTfU03usXeg2f7wbgP3hD24Auxu2YT0v38WvcBgcy4hhB
         QJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=N4LzP/9PzOYCiYkAs+YzwM2m4IgP0rBEzuRPIDLzBck=;
        b=T8Ka2DviAC4x2PLm5cspFURaTMxqZaEqIt8jtgkyNoYMiXJxWkZO995m4JztsSI0pa
         FG9qb+RL34WCsoQbkZSnU4kgKXxB42E2TIBBtKjBTV4NoiGTdUhlJKaIXjlEjjcKX6vx
         2rO2KdnE8eGmuuhr3lWD9P2FKYMy+AYuOqxLBevFaj36Ijj4tCwJhJoLqJlfbHgbeQ/6
         orRFywILymjM5AVigPdjfX4qr7qWgfKoAbGv3FWSLAvpfU6vyxwM6gLvSj3tBnmp6mpc
         L2dD6rc/2pCf1+y6n0PpTi4UUtuxAH6oNSOj+L3PvTggn4Ez+mYC6lkYQu3O5GKz4jGb
         jluw==
X-Gm-Message-State: AG10YORupbRuwY7xuCsNuP7XYMOw9s+gXtW3HwxdeNmVioeSZ4BsPwf2KLgzHw25FSpZTf2k31YqH+GifPFbwQ==
X-Received: by 10.31.150.76 with SMTP id y73mr15562003vkd.84.1454835448319;
 Sun, 07 Feb 2016 00:57:28 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 7 Feb 2016 00:57:28 -0800 (PST)
In-Reply-To: <1454662677-15137-6-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: HLnHeqREyNxywL2nQWNHjW_exc8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285720>

On Fri, Feb 5, 2016 at 3:57 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/fetch-pack.c b/fetch-pack.c
> @@ -856,6 +864,8 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
>                         fprintf(stderr, "Server supports ofs-delta\n"=
);
>         } else
>                 prefer_ofs_delta =3D 0;
> +       if (args->resume_path && !server_supports("partial"))
> +               die(_("Server does not support resume capability\n"))=
;

Drop "\n" from die() message.

>         if ((agent_feature =3D server_feature_value("agent", &agent_l=
en))) {
>                 agent_supported =3D 1;
