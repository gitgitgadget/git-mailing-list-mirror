From: j.sixt@viscovery.net
Subject: Re: [PATCH v6 2/3] compat: add a basename() compatibility function
Date: Sun, 31 May 2009 10:11:02 +0200
Message-ID: <54809.1243757462@viscovery.net>
Reply-To: j.sixt@viscovery.net
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: <gitster@pobox.com>, <peff@peff.net>, <markus.heidelberg@web.de>,
	<jnareb@gmail.com>, <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:17:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAgEt-0005ZC-CK
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 10:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952AbZEaIRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 04:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756928AbZEaIRo
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 04:17:44 -0400
Received: from server270-han.de-nserver.de ([85.158.181.22]:45033 "EHLO
	server270-han.de-nserver.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756807AbZEaIRn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 04:17:43 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 May 2009 04:17:43 EDT
Received: (qmail 11113 invoked from network); 31 May 2009 10:11:03 +0200
Received: from localhost (HELO localhost) (127.0.0.1)
  (smtp-auth username atmail@mail-routing.com, mechanism login)
  by server270-han.de-nserver.de (qpsmtpd/0.40) with ESMTPA; Sun, 31 May 2009 10:11:03 +0200
X-Mailer: AtMail PHP 5.2
X-Origin: 93.83.142.38
X-User-Auth: Auth by atmail@mail-routing.com through 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120385>

On Sun 31/05/09 06:42 , David Aguilar davvid@gmail.com sent:
> On Sat, May 30, 2009 at 09:37:54PM -0700, David Aguilar wrote:
> > Some systems such as Windows lack libgen.h so provide a
> > basename() implementation for cross-platform use.
> > [...]
> > diff --git a/compat/basename.c b/compat/basename.c
> > new file mode 100644
> > index 0000000..c45716a
> > --- /dev/null
> > +++ b/compat/basename.c
> > @@ -0,0 +1,19 @@
> > +#include "../git-compat-util.h"
> > +
> > +/* Adapted from libiberty's basename.c.  */
> > +char *gitbasename (char *path)
> > +{
> > +	const char *base;
> > +
> > +#ifdef USE_WIN32_FS
> > +	/* Skip over the disk name in MSDOS pathnames. */
> > +	if (isalpha(path[0]) && path[1] == ':')
> > +		path += 2;
> > +#endif
> 
> Thanks for bearing through this series everyone.. ;)
> 
> Can someone with better win32 knowledge let me know if the
> USE_WIN32_FS stuff is needed for msysgit?

No, you don't need it: use

	if (has_dos_drive_prefix(path))
		path += 2;

without any #ifdef.

Thank _you_ for going through so many iterations.

Unfortunately, it may take me a day or two until I can test the patches on 
Windows again.

-- Hannes
