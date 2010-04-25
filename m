From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 07/15] host-IRIX.patch
Date: Sun, 25 Apr 2010 03:39:13 -0500 (CDT)
Message-ID: <20100316085459.GD26540@thor.il.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054331.991677000@mlists.thewrittenword.com>
 <7vljdsn2yz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:39:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xN1-00072F-FC
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab0DYIjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:39:15 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:53811 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0DYIjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:39:14 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id C84F95CC0
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 09:00:15 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com C84F95CC0
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 80F96A93
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:39:13 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 3B54557C; Sun, 25 Apr 2010 03:39:13 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vljdsn2yz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145728>

On Tue, Mar 16, 2010 at 12:24:36AM -0700, Junio C Hamano wrote:
> "Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:
> 
> > Irix 6.5 does not define 'sgi', but does define '__sgi'.
> >
> > Also, Irix 6.5 requires _BSD_TYPES to be defined in order for the BSD
> > u_short types et. al. to be declared properly.
> 
> If Irix 6.5 defines __sgi and the patch _adds_ "defined(__sgi)" I wouldn't
> have to worry too much, but would replacing "defined(sgi)" with the
> double-underscore version make somebody who added "defined(sgi)" in the
> first place cry, if it was done for different version of Irix that does
> define "sgi" (worse yet, but not "__sgi")?

Agreed.  I've amended my local version of this patch to check both
(sgi) and (__sgi) now.  Thanks.

> Another natural question is if defining _BSD_TYPES everywhere has negative
> effects on somebody else's platforms, but that is what people on different
> platforms will have to apply this patch, test, and report success or
> breakage.  Help from the list audience is appreciated.

Good point.  Perhaps better to make that change in the Makefile?

ifeq ($(uname_S),IRIX64)
        # Need this for u_short definitions et al
        BASIC_CFLAGS += -D_BSD_TYPES
endif

I only have use of mips-sgi-irix6.5 machines, so I'm not sure what
other versions are affected... probably a safe bet that
ifeq($(uname_S),IRIX) should get that definition too.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
