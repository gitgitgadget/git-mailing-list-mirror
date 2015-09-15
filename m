From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5 1/7] git-p4: add optional type specifier to gitConfig
 reader
Date: Tue, 15 Sep 2015 08:34:35 +0100
Message-ID: <55F7CA0B.2010609@diamand.org>
References: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com> <1442237194-49624-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 09:34:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbklG-0006o3-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 09:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbbIOHeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2015 03:34:37 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33071 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbIOHeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 03:34:37 -0400
Received: by wiclk2 with SMTP id lk2so15540625wic.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=G0FKBmII1MA3qiAhf7WmEiuQmpuJRqBOIQX/+W+nZgY=;
        b=WcMVcuKewQYzmAB4sHK2M8Z5igxAYY4t7EFjnNv5Z8iFmxDabs/MzxKQAvvu4duxTh
         iFng3OZqZ5yF4Z6oqKVcP/iGvlsETdQsBq8DyTwD+IPkWpzWbveYGNqSNwANU51jiM7R
         H5bHrRh7Dz79GzO6WFt2+l/JKP7imAYa/KbLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=G0FKBmII1MA3qiAhf7WmEiuQmpuJRqBOIQX/+W+nZgY=;
        b=HLc4bidStYGgPDj5p1oF5W0Q9C9N4XE9kZvasXwwwFd+fV8EGoWF8RvyP2fZcvWHDb
         VhiqIESr7/OB5ES8Q7D9PuNZFfK4US2YY4o5bIZmOuOrlvvBbhxpMxLOxBj1g5sDPBs6
         MNSgQQugCiYeUzTkikK+6M4EZfa2FOk+tG2Pg4SEwmapFQ7C0I5adk1vxy/qskOBQ+M0
         zJknOD0qUabOC2eWGL4Qh92SlxKTZ6z4VKn63WFMDjL1icoaD4iE0CyhybvwankeYcDU
         8rog5dJpFsPt5C5SxWq4c3k/ddk28/CUhWIUOZ5IbZ6iRrxMVpPivGC/4C7Q9oTpZT9/
         MCVw==
X-Gm-Message-State: ALoCoQmOY8Aqyrtx9Jl+R9FJkP6CTw2RyLfsTi0n0T30ufoSVQwtXBJb2RZn+ofHNM8/rsuhHq6Z
X-Received: by 10.194.85.130 with SMTP id h2mr38866270wjz.2.1442302475813;
        Tue, 15 Sep 2015 00:34:35 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id h8sm18261361wib.21.2015.09.15.00.34.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2015 00:34:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1442237194-49624-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277892>

On 14/09/15 14:26, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> The functions =E2=80=9CgitConfig=E2=80=9D and =E2=80=9CgitConfigBool=E2=
=80=9D are almost identical. Make =E2=80=9CgitConfig=E2=80=9D more gene=
ric by adding an optional type specifier. Use the type specifier =E2=80=
=9C=E2=80=94bool=E2=80=9D with =E2=80=9CgitConfig=E2=80=9D to implement=
 =E2=80=9CgitConfigBool. This prepares the implementation of other type=
 specifiers such as =E2=80=9C=E2=80=94int=E2=80=9D.

Looks good to me, Ack.


>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   git-p4.py | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..c139cab 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -604,9 +604,12 @@ def gitBranchExists(branch):
>
>   _gitConfig =3D {}
>
> -def gitConfig(key):
> +def gitConfig(key, typeSpecifier=3DNone):
>       if not _gitConfig.has_key(key):
> -        cmd =3D [ "git", "config", key ]
> +        cmd =3D [ "git", "config" ]
> +        if typeSpecifier:
> +            cmd +=3D [ typeSpecifier ]
> +        cmd +=3D [ key ]
>           s =3D read_pipe(cmd, ignore_error=3DTrue)
>           _gitConfig[key] =3D s.strip()
>       return _gitConfig[key]
> @@ -617,10 +620,7 @@ def gitConfigBool(key):
>          in the config."""
>
>       if not _gitConfig.has_key(key):
> -        cmd =3D [ "git", "config", "--bool", key ]
> -        s =3D read_pipe(cmd, ignore_error=3DTrue)
> -        v =3D s.strip()
> -        _gitConfig[key] =3D v =3D=3D "true"
> +        _gitConfig[key] =3D gitConfig(key, '--bool') =3D=3D "true"
>       return _gitConfig[key]
>
>   def gitConfigList(key):
>
