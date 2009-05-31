From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 05/11] winansi: fix compile warnings
Date: Sun, 31 May 2009 21:52:11 +0200
Message-ID: <200905312152.11434.j6t@kdbg.org>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-6-git-send-email-prohaska@zib.de> <4A22C674.603@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun May 31 21:54:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAr7E-0000ah-Hb
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 21:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbZEaTwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 15:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbZEaTwN
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 15:52:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:49832 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597AbZEaTwN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 15:52:13 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 31A89A7EB4;
	Sun, 31 May 2009 21:52:12 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EC36842601;
	Sun, 31 May 2009 21:52:11 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4A22C674.603@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120427>

On Sonntag, 31. Mai 2009, Johannes Sixt wrote:
> Steffen Prohaska schrieb:
> > diff --git a/compat/win32.h b/compat/win32.h
> > index c26384e..d531130 100644
> > --- a/compat/win32.h
> > +++ b/compat/win32.h
> > @@ -1,5 +1,6 @@
> >  /* common Win32 functions for MinGW and Cygwin */
> >  #include <windows.h>
> > +#include <conio.h>
> >
> >  static inline int file_attr_to_st_mode (DWORD attr)
> >  {
>
> I assume this is to remove the warning about missing declaration of
> _getch(). Can we have this patch instead? I don't have conio.h in my
> oldish MinGW environment.
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 52961ee..53053ad 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1211,6 +1211,9 @@ int link(const char *oldpath, const char *newpath)
>   	return 0;
>   }
>
> +/* from conio.h */
> +int _getch(void);  // FIXME: really look this up in conio.h!!!!
> +
>   char *getpass(const char *prompt)
>   {
>   	struct strbuf buf = STRBUF_INIT;

Ok, forget this patch; I'll upgrade my MinGW instead, and let's assume all 
other mingw.git h4ckrz who aren't using the latest msysgit will upgrade as 
well.

Nevertheless, I think that the #include <conio.h> is in the wrong file: it 
should be included from compat/mingw.c.

-- Hannes
