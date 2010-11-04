From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Thu, 04 Nov 2010 18:53:28 -0400
Message-ID: <4CD33968.4060704@gmail.com>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com> <1288878944-14066-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 23:53:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE8gc-00046N-2Y
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab0KDWxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 18:53:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57707 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab0KDWxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 18:53:32 -0400
Received: by vws13 with SMTP id 13so1398651vws.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=K6HhGGs5+fE4mlDCMnUfxXf+FwciQtfkBkBIYS74ycg=;
        b=nnKrXmt1ncSA3aDPWi5KGPtRVnRVoep542Q5VfjC5GwiQhXAAxK1rY6lERw45vQNu0
         CBQ3mM4QFliJ0HSkkV3CNP2BgUqgzesYUzCZvs08pEDdM6qkvU/zYmKVoYpOinvC0C5x
         4dEJ0iKh/e5lI40BNzNLmNjNn1sxM9rAwut50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=suRaSxavsenovuE5JhN4rDcOjmDx9nV0LRn0LiOCeqR9cQlAV4x3ma2YmjO06dbZpn
         14K1YGS+XmSJtCEgno83bVGfKiMK4KzmtVL8AEy0UugLpu8E3wW6ocnSBTbwkWqxBoJD
         yTi+srzShA05mF9I/+/VuwUBhcJ/D0J50wIo8=
Received: by 10.220.189.136 with SMTP id de8mr97396vcb.30.1288911211200;
        Thu, 04 Nov 2010 15:53:31 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id o17sm264388vbi.12.2010.11.04.15.53.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 15:53:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <1288878944-14066-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160791>

On 11/4/2010 9:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Full pattern must be quoted. So 'pat"t"ern attr' will give exactly
> 'pat"t"ern', not 'pattern'. Also clarify that leading whitespaces are
> not part of the pattern and document comment syntax.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gmai=
l.com>
> diff --git a/attr.c b/attr.c
> index 6aff695..f3063d8 100644
> --- a/attr.c
> +++ b/attr.c
>   	name =3D cp;
> -	namelen =3D strcspn(name, blank);
> +	if (*cp =3D=3D '"') {
> +		if (unquote_c_style(&pattern, name,&ep))
> +			die("Broken attribute line: %s", line);

The error message is perhaps a bit too generic, indicating only that=20
_something_ on the line caused a problem. Mentioning that bad quoting o=
f=20
'name' was at fault would help focus the user's attention where it is=20
needed.

-- ES
