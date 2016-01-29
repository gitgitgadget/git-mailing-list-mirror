From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 04/10] grep/icase: avoid kwsset on literal non-ascii strings
Date: Fri, 29 Jan 2016 01:18:51 -0500
Message-ID: <CAPig+cSrt3FE081a=7in_h2njCbhPfaSHm+S+e8-DLuvP7Ga0w@mail.gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1453982183-24124-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 07:18:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP2OX-00016e-1t
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 07:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbcA2GSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 01:18:53 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33819 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbcA2GSw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2016 01:18:52 -0500
Received: by mail-vk0-f68.google.com with SMTP id e6so2460788vkh.1
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 22:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=etOQzJHNZC9kajpBgbhkI6gguhmFzCKU2t3t4y6IhIk=;
        b=TL8OURGUjtbW/6AY9xqxeSbWUX2MUJFaIVPGEvUXCAmkhN/SjqdW6ccZC9awyGKs6H
         DQkYHBWiP3iAV1QUKGJPa3h2unA3+sZkhJHlzN2lQf/zn0Pfkrf7zdRS5FCM0jFksLpn
         WomzUCnnES/BNIjYnjKdRkYGa/shSFD+1paajIltTzz2b7BXn83nwg6lHT4x0mg0Lr1R
         eHlExKpzwsq65D8Pp7YbbbL9vlIrH7FNl6WBkhtPU5S3kXdVEsI11JUOYBPFNDv1xsW+
         wYooVDPqFQAgQZBOgcuTDairuRb63lqJ6xTutDr/A4hxpBhM5fj8UUHJEYD+ypfQCv4Y
         vCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=etOQzJHNZC9kajpBgbhkI6gguhmFzCKU2t3t4y6IhIk=;
        b=YVjsOweSCh+vcrVyCRlK3mWD1ZfXDm88zrdmA/A6T5rj34pPxbzOh7bF30s3El4eWY
         FuMWyP40Pba3ZacVSIt2tDMlcN2aweaYr1LmKep4mQzwp8HJ2f9W/E1aGvbf64B2BB5G
         PS9QmI2RLwd6BM9VQzxgii2uqgTXiWeKpjvSGiWJHKU+cLfvpYkV/cuVRJD/87z45M2P
         mdq5Vh3z8wBWibTbjAkUyav6BD3DPqIp246QOLWXw3sEaQMbJD1AsAVIeaVVla4MmR/J
         7BlerqQXpjeNYwmTdRoWq/qET98ed1Y6GFGmYaL1NHz2tkr1u2STuZ+2c6tTPjvoA491
         dJgg==
X-Gm-Message-State: AG10YOQw6nLTitErOaIEvgUohUTNGQpAOvAWsTHDE8NZBfDAKF/vSe9yQNmFXyeNoPuuGX2mUSfK4+Q/ZI3wlg==
X-Received: by 10.31.182.143 with SMTP id g137mr4709354vkf.45.1454048331798;
 Thu, 28 Jan 2016 22:18:51 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 28 Jan 2016 22:18:51 -0800 (PST)
In-Reply-To: <1453982183-24124-5-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: CqXEYc2E0cIjyYxubkgzshM3q3E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285064>

On Thu, Jan 28, 2016 at 6:56 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> When we detect the pattern is just a literal string, we avoid heavy
> regex engine and use fast substring search implemented in kwsset.c.
> But kws uses git-ctype which is locale-independent so it does not kno=
w
> how to fold case properly outside ascii range. Let regcomp or pcre
> take care of this case instead. Slower, but accurate.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/grep.c b/grep.c
> @@ -398,12 +399,16 @@ static int is_fixed(const char *s, size_t len)
>  static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>  {
> +       int icase_non_ascii;
>         int err;
>
>         p->word_regexp =3D opt->word_regexp;
>         p->ignore_case =3D opt->ignore_case;
> +       icase_non_ascii =3D
> +               (opt->regflags & REG_ICASE || p->ignore_case) &&
> +               has_non_ascii(p->pattern);
>
> -       if (is_fixed(p->pattern, p->patternlen))
> +       if (!icase_non_ascii && is_fixed(p->pattern, p->patternlen))

These double negatives (!non_ascii) here and in patch 5/10 are
difficult to grok. I wonder if a different name, such as
icase_ascii_only would help.

>                 p->fixed =3D 1;
>         else if (opt->fixed) {
>                 p->fixed =3D 1;
