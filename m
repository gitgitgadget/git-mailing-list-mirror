From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
Date: Fri, 24 Aug 2012 20:58:09 +0200
Message-ID: <005401cd822a$67687a30$36396e90$@schmitz-digital.de>
References: <004001cd81f9$21e68e10$65b3aa30$@schmitz-digital.de> <7vsjbc1dg1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Erik Faye-Lund'" <kusmabite@gmail.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 20:58:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4z5T-0002Z8-Cx
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 20:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759878Ab2HXS6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 14:58:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57650 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859Ab2HXS6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 14:58:22 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MWBZZ-1TBHfe1SfZ-00XNbO; Fri, 24 Aug 2012 20:58:19 +0200
In-Reply-To: <7vsjbc1dg1.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQD+UJbyfpuh0NvtD/0Nf09ZKJpnFgHbe408mPjWdCA=
Content-Language: de
X-Provags-ID: V02:K0:rg3e7BE368Jp30ncOvFIP/sCRsHi8Y5x2sAjsecQu0p
 g0ORTiC1H5Eeb35aT9lXkJfyZsSVx/l7TL8W05v2kwOjBYoeCh
 6WnkLqTK5Uj4Bj0IpHaTRVRv7RbkfnjXxUh9Oem571FTwWq+lG
 JjumWgaSR/G6sHbXS5nSOUA3MlKGgCls22uUGWbOEPGlOglOCu
 69EtiZmeoPBvlnMAkWFtUg7XS3Gtu1zFbgh9P5jgbj4qN6wOqh
 rKF37O3awg6BUw6OW3yI3xdg09XRsyc40MkDjxzR+j8XIStLNn
 HKUkXW8RCeYw91w1FoPgtjlW//68HUCqnaVhUlKejv5/v1QxT7
 54j3/V6UzkOyVoxsJQ70pxyb4CsCimxkazhZC+iszHE+8JGL4B
 dzdxjZ4ugSdTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204227>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, August 24, 2012 6:07 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; Erik Faye-Lund
> Subject: Re: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > There is a downside with this: In order to make use of it, in Makefile it
> > adds "-Icompat/win32" to COMPAR_CFLAGS. This results in
> > compat/win32/dirent.h to be found, rather than /usr/include/dirent.h.
> > This should be fine for WIN32, but for everybody else may not.
> > For HP NonStop in particular it results in a warning:
> >
> >         };
> >          ^
> > "... /compat/win32/dirent.h", line 17: warning(133): expected an identifier
> >
> > And this is because there it uses an unnamed union, which is a GCC extension
> > (just like unnamed struct), but not part of C89/C99/POSIX.
> >
> > One possible solution might be to move compat/win32/poll.[ch] to compat/.
> 
> I think that is the most sensible way to go, because poll.[ch]
> 
>  (1) has proven itself to be useful outside the context of win32, and
>  (2) the code is coming from gnulib anyway.
> 
> I thought I already suggested going that route in my previous
> review, but perhaps I forgot to do so.

No, I believe you did, but I had forgotten about it. Could/should that be a 2nd patch?
Or a v3 of this one?

Different, but related question: would poll.[ch] be allowed to #include "git-compat-util.h"?

Bye, Jojo
