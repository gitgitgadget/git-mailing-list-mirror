From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] gitk: Avoid calling tk_setPalette on Windows
Date: Mon, 22 Mar 2010 21:29:03 -0500
Message-ID: <20100323022903.GA5213@progeny.tock>
References: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
 <20100320063256.GA26519@progeny.tock>
 <87tys8c6ki.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Mar 23 03:29:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nttro-0002gL-K3
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 03:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab0CWC3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 22:29:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38530 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab0CWC3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 22:29:08 -0400
Received: by gwaa18 with SMTP id a18so1276669gwa.19
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 19:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rb1G9TwC4OQRzEJwguj9el19Ycr+rrTkRISjmMmK+Ho=;
        b=FR8nnRJUvRIEfrET414jJgwm39hZGBL/aAhncbY4P3N1AcxClFeIrkHYdKHvS9hysY
         gZcWf826Yv/09IKZ2XwoPXp4ARnF7oYCv6nbB/4YqWNwEIpqWPaBiwKZBlytKFEv57H5
         7pzelEIPEcg/piFg6a9Tt6oBVXCnkoPHKLxCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DXekUBrOuM6SEVjlDkfRVoMd7lNO5Yw1pRee26ioLjrw7yyncJM79R+2vOItkbKmoy
         vZSPKNEn6WNg4n6Ad1fcOsGvrVcQ6GaadMBctyotKBYgq7BSvl6kfYDhUIARrN6eZegY
         IXPnpH4uyT5NBPxlExS1uB0zca1TJtV3RTimM=
Received: by 10.101.144.32 with SMTP id w32mr9150752ann.246.1269311346901;
        Mon, 22 Mar 2010 19:29:06 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4493946iwn.7.2010.03.22.19.29.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 19:29:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87tys8c6ki.fsf@fox.patthoyts.tk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142984>

Pat Thoyts wrote:

>>>  # For some reason, tk_setPalette chooses a nasty dark red for sele=
ctColor
>>>  # if we don't specify one ourselves, which makes the checkbuttons =
and
>>>  # radiobuttons look bad.  This chooses white for selectColor if th=
e
>>>  # background color is light, or black if it is dark.
[...]
> This has never been true for Windows which has always used the native
> images for check and radio buttons. So the comment there is relevant
> only to X11. I believe in Tk 8.5 the check/radio buttons now use
> images by default (the ttk versions will look appropriate to the
> current theme - however that may be defined).
>=20
> However, messing about with this on X11 would need testing that I
> can't do on Windows. Hence the suggested fix.

Thanks for the pointers.  Sp it seems that the =E2=80=9Cinterface color=
=E2=80=9D setting
does not have the desired effect when themed widgets are enabled.  You
can see some screenshots here:

  http://repo.or.cz/w/git/jrn.git/commit/gitk-snapshots

The text fields, buttons, and drop-down boxes retain the traditional
grey background, while the menu bar, =E2=80=9CSHA1 ID=E2=80=9D label, a=
nd =E2=80=9CLines of
context=E2=80=9D selector do change color.  The effect is very strange.

When themed widgets are disabled, the tk_setPalette issue described in
the comment still applies.

So I can understand better: are you saying in Windows themed widgets
are always used?

Jonathan
