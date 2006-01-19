From: Christopher Faylor <me@cgf.cx>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 00:29:14 -0500
Message-ID: <20060119052914.GC8121@trixie.casa.cgf.cx>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 06:29:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzSMI-0008Bk-LP
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 06:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWASF3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 00:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbWASF3P
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 00:29:15 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:37856 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161116AbWASF3O (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 00:29:14 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 822C54A84B8; Thu, 19 Jan 2006 00:29:14 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14889>

On Wed, Jan 18, 2006 at 02:47:00PM +0100, Alex Riesen wrote:
>For reasons unknown, cygwin decided to use our sockaddr_storage.
>As it is redefined to sockaddr_in it'd cause compilation errors in
>cygwin headers. Fixed by first patch, which uses a more git-related
>name (can we claim rights for the symbol, being first to use it? :-)
>
>For the other, probably unrelated, reasons, they decided to leave
>declarations of DT_* macros in dirent.h without providing dirent->d_type.
>This is what NO_DTYPE in the 0002-patch is all about.

"They" probably would like to hear about any irregularities that are found.
"They" probably don't like it when people treat an open source project as
if it was some unresponsive proprietary enterprise which does not listen
to or accept patches.

>And on top of that, they removed dirent->d_ino (or probably replaced it
>by __ino32, if at all).  BTW, can we somehow avoid using d_ino?  It is
>referenced only in fsck-objects.c Anyway, to workaround this I put
>
>COMPAT_CFLAGS += -Dd_ino=__ino32
>
>It helps, but surely is not the solution.

I don't see how it could help since __ino32 is not actually filled in
with anything.  In fact, I'll rename the field to __invalid_ino32 to
make that clear.

cgf
(cygwin project lead)
