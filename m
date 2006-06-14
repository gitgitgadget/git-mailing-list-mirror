From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Wed, 14 Jun 2006 23:30:56 +0300
Message-ID: <f36b08ee0606141330l28330d79hab1aec5c741188c7@mail.gmail.com>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
	 <7vver3cxlw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 22:31:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqc0y-00031Z-DP
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 22:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWFNUa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 16:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWFNUa5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 16:30:57 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:44719 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932239AbWFNUa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 16:30:57 -0400
Received: by py-out-1112.google.com with SMTP id i49so29385pye
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 13:30:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qSEuq0T0QTYFvPrkBqMuGKPvEA+Y4XDLoK2or4owp91U5aVN0+WE8+QPxPUo/rYR6GBHH9mHIhZJDqaqOrmBl/3HIJL4pGlkAP2vI5q0JUj0qXD/P8qWHmPNDxSPioSmCLWSXLtI7iakcEUfOVHkgNmudYjHRI0Xx1wnVoLxKCE=
Received: by 10.35.114.16 with SMTP id r16mr1675654pym;
        Wed, 14 Jun 2006 13:30:56 -0700 (PDT)
Received: by 10.35.14.20 with HTTP; Wed, 14 Jun 2006 13:30:56 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vver3cxlw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21860>

On 6/14/06, Junio C Hamano <junkio@cox.net> wrote:
> Yakov Lerner <iler.ml@gmail.com> writes:
>
> > Many times, I mistakenly used 'make prefix=... install' where prefix value
> > was different from prefix value during build. This resulted in broken
> > install. This patch adds auto-detection of $prefix change to the Makefile.
> > This results in correct install whenever prefix is changed.
> >
> > Signed-off-by: Yakov Lerner <iler.ml@gmail.com>
>
> I do not mind this per se, and probably even agree that this is
> an improvement compared to the current state of affairs, but a few
> points:
>
>  - please make sure you clean that state file in "make clean";
done

>  - we may want to make the state file a bit more visible (IOW, I
>    somewhat do mind the name being dot-git-dot-prefix).
I renamed .git.prefix to GIT-PREFIX. Is this ok.

>  - we might want to later (or at the same time as this patch)
>    do "consistent set of compilation flags" (e.g. run early
>    part of compilation with openssl SHA-1 implementation,
>    interrupt it and build and link the rest with mozilla SHA-1
>    implementation -- then you will get a nonsense binary without
>    linker errors).  It might make sense to prepare this
>    mechanism so we could reuse it for that purpose.

Do you think two separate GIT-PREFIX and GIT-BUILD-FLAGS are needed,
or just once GIT-BUILD-FLAGS will do, which will include
prefixes (as passed with -D... to cc) ?

I think single GIT-BUILD-FLAGS
is enough, which will cover prefixes, too. Is this OK ?

BTW, I think it's useful to add Makefile itself as prerequisite for all *.o,
so change in Makefile will cause recompilations. Shall I include this
into this patch, too ?

Yakov
