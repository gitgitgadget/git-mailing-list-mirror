From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH i18n 01/11] Add three convenient format printing
 functions with \n automatically appended
Date: Mon, 16 Apr 2012 12:26:54 -0500
Message-ID: <20120416172654.GU5813@burratino>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
 <1334580603-11577-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:27:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJpi3-0006JG-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 19:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400Ab2DPR1E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 13:27:04 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59865 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab2DPR1C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 13:27:02 -0400
Received: by yhmm54 with SMTP id m54so2592487yhm.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QOPhmduQcaPSVtJkFquxTPw+azBrvDH3DpQXJWhPhK8=;
        b=I9ns5oADQoAD6F/ymZ2MJz5/UV2mV2eGtNfa3fVukR+9y2hEs3ROvO4Zt26KLYE4wM
         t3pmB8CIfNqYqNOffW6NvMZV52zZiFT1dzx8IfiOPt9fWRWggp8D464t/Nw2gIiD0uBl
         fEqtM0gWdscubp0budvsOjaFgwyLSYUPzKwbvKGwTazWuY7El5O37ap+w0LwWkQJLOgW
         m5/ELmM8c+7UjHYiY9k+9KD2eUvTqfkwt/XEXuNEoYsSata1Ez19dYe1BbPZG5oJVkwp
         tPnX+TAeFo7Dbupat0vVEFLVJTAh7FVKOyoz4/4fkIw1RhYiEmh645TvU2NVTs6iZsLN
         yFKQ==
Received: by 10.50.194.228 with SMTP id hz4mr6690968igc.35.1334597221775;
        Mon, 16 Apr 2012 10:27:01 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n1sm11635759igm.7.2012.04.16.10.27.01
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 10:27:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334580603-11577-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195668>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>     printf("hello world\n");
>
> can be converted to
>
>     printf_ln(_("hello world"));

=46un.

[...]
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -464,3 +464,36 @@ void strbuf_addstr_urlencode(struct strbuf *sb, =
const char *s,
[...]
> +int printf_ln(const char *fmt, ...)
> +{
> +	int ret;
> +	va_list ap;
> +	va_start(ap, fmt);
> +	ret =3D vprintf(fmt, ap);
> +	va_end(ap);
> +	if (ret >=3D 0)
> +		ret +=3D printf("\n");

What happens if the second printf fails?
