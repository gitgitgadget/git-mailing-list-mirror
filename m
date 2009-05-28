From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really	menas
 XPG6
Date: Thu, 28 May 2009 14:40:14 -0500
Message-ID: <kZP6fFCtTQSG03irLxGArpacn-5pYEauMj-b0VWwhzPWMGiC_XnsYw@cipher.nrlssc.navy.mil>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com> <1243106697-6424-2-git-send-email-gitster@pobox.com> <WLNdjYtfqcg2bT6yOBtAykIqOBTeSLRUdlB6-sTM2KzTjwOmzN3fLg@cipher.nrlssc.navy.mil> <20090528191940.GG13499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 21:40:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9lSk-00088U-Tn
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 21:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbZE1TkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 15:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbZE1TkR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 15:40:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57358 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbZE1TkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 15:40:16 -0400
Received: by mail.nrlssc.navy.mil id n4SJeFLh019315; Thu, 28 May 2009 14:40:15 -0500
In-Reply-To: <20090528191940.GG13499@coredump.intra.peff.net>
X-OriginalArrivalTime: 28 May 2009 19:40:14.0563 (UTC) FILETIME=[1F254B30:01C9DFCC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120216>

Jeff King wrote:
> On Thu, May 28, 2009 at 11:46:50AM -0500, Brandon Casey wrote:
> 
>> So we either require compiling with a c99 compiler (by ensuring that
>> _XPG6 is set) or exclude compiling with a c99 compiler on sun (by
>> ensuring that _XPG6 is not set).  Actually, this would only affect Solaris
>> versions which support XPG6.  Solaris 11 and 10 do.  I don't know about
>> Solaris 9 and 8.  Solaris 7 doesn't.
>>
>> Which do we want to do?
> 
> FWIW, I didn't even try using sun's cc. I have been doing all of my
> builds using gcc 3.1.1 (from around 2002, which is what happens to be
> available on the old-ish Solaris install at my university).

It's not the compiler that prevents compilation.  It's the header files.

You mentioned that on Solaris 8 there was only a single declaration for
iconv.  There was not a macro check for _XPG6.  I suspect that Solaris 8
does not support XPG6, so your compilation is just falling back to XPG4.
The same thing happens on Solaris 7.  On Solaris 10, if the macros are
set such that _XPG6 becomes set, then compilation will fail if the
compiler is not a c99 one.

-brandon
