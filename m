From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/7] add generic terminal prompt function
Date: Thu, 08 Dec 2011 13:48:33 -0800 (PST)
Message-ID: <m38vmmivkc.fsf@localhost.localdomain>
References: <20111208082118.GA1507@sigill.intra.peff.net>
	<20111208083323.GE26409@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 22:48:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYlpc-0000RI-Jy
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 22:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab1LHVsk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 16:48:40 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33273 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab1LHVsj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 16:48:39 -0500
Received: by eekc4 with SMTP id c4so79942eek.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 13:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=wIp0uqucWwvi4lVgtrYLUiaehOEectFrW6KchOjXQ2U=;
        b=SHjdkTH+efYPKOEQZngP0nswEVY6+ZuoMux3tog1ch0b/nirOlVnsbC7mi3Ate/x0J
         otAyBtlphUkFQpPkHQlcLr1KzJXFDLqYTwReYgjeXzq7YJUDo7gL2htKkvF7xA4E6BXU
         67HAlanpzJBTMNEUMZzTe9IwWCcVSjPK9Qaas=
Received: by 10.14.11.13 with SMTP id 13mr363904eew.98.1323380918264;
        Thu, 08 Dec 2011 13:48:38 -0800 (PST)
Received: from localhost.localdomain (aehn28.neoplus.adsl.tpnet.pl. [79.186.195.28])
        by mx.google.com with ESMTPS id q28sm22552736eea.6.2011.12.08.13.48.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 13:48:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pB8Lmbwe010653;
	Thu, 8 Dec 2011 22:48:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pB8LmaLN010650;
	Thu, 8 Dec 2011 22:48:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20111208083323.GE26409@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186598>

Jeff King <peff@peff.net> writes:

> diff --git a/Makefile b/Makefile
> index b024e2f..2a9bb3d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -227,6 +227,9 @@ all::

> +# Define HAVE_DEV_TTY if your system can open /dev/tty to interact w=
ith the
> +# user.

> @@ -833,6 +838,7 @@ ifeq ($(uname_S),Linux)
>  	NO_STRLCPY =3D YesPlease
>  	NO_MKSTEMPS =3D YesPlease
>  	HAVE_PATHS_H =3D YesPlease
> +	HAVE_DEV_TTY =3D YesPlease
>  endif

Here you use HAVE_DEV_TTY (by the way, I wonder if it could be
automatically detected by ./configure script)...

> diff --git a/compat/terminal.c b/compat/terminal.c
> new file mode 100644
> index 0000000..49f16ca
> --- /dev/null
> +++ b/compat/terminal.c
> @@ -0,0 +1,81 @@
> +#include "git-compat-util.h"
> +#include "compat/terminal.h"
> +#include "sigchain.h"
> +#include "strbuf.h"
> +
> +#ifndef NO_DEV_TTY

> +#endif

  +#endif /* NO_DEV_TTY */

=2E..and here you have NO_DEV_TTY

--=20
Jakub Nar=EAbski
