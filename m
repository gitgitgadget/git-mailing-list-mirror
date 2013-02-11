From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Include xmlparse.h instead of expat.h on QNX
Date: Mon, 11 Feb 2013 13:49:48 -0800
Message-ID: <20130211214948.GB19113@ftbfs.org>
References: <1360616395-18912-1-git-send-email-kraai@ftbfs.org>
 <7vip5ylekj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:50:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U51GU-0007AG-MO
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717Ab3BKVtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:49:53 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:57412 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932674Ab3BKVtv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:49:51 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1U51G0-00053E-Tx; Mon, 11 Feb 2013 13:49:48 -0800
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <7vip5ylekj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216097>

On Mon, Feb 11, 2013 at 01:34:52PM -0800, Junio C Hamano wrote:
> Two points and a possibly irrelevant half:
> 
>  - If a fix is platform specific (i.e. tempts to use #ifdef
>    PLATFORM_NAME), we would prefer to see a patch that that is
>    isolated to platform-specific compatibility layer, which would
>    involve:
> 
>    . add compat/qnx/expat.h file that #include <xmlparse.h>
>    . to Makefile, add -Icompat/qnx/ to CFLAGS
> 
>  - Is this really a fix for a problem specific to QNX?  It looks
>    like this is for any platform with expat 1, no?

It should apply to anyone trying to build with expat 1.1 or 1.2, but
not with 1.95.0 or later.

>  - What happens to people with QNX older than 6.3.2 or newer than
>    6.5.0 (assuming they will eventually start shipping expat 2) with
>    your patch?

Git will fail to build http-push.c.  I don't know if QNX will ever
update expat, though.  expat 1.95.0 was released in 2000, expat 2.0.0
was released in 2006, and QNX 6.5.0 was released in 2010.

> Assuming that this change is about building with expat1, it would
> probably be better to do something like this instead, I would think.

expat 1.95.0 through 1.95.8 used expat.h; should I still use
EXPAT_VERSION = 1 to signify that it should use xmlparse.h, use
EXPAT_NEEDS_XMLPARSE_H as Jeff suggested, or something else entirely?
