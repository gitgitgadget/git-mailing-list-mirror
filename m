From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid problem with xpg4 grep in Solaris that broke t9400
Date: Thu, 19 Apr 2012 13:39:06 -0400
Message-ID: <1334857109-sup-7979@pinkfloyd.chass.utoronto.ca>
References: <1334002409-5708-1-git-send-email-bwalton@artsci.utoronto.ca> <1334445524-sup-1455@pinkfloyd.chass.utoronto.ca> <xmqqfwbzslt2.fsf@junio.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 19:39:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKvK8-0007Zx-85
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 19:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab2DSRjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 13:39:10 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:39249 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016Ab2DSRjI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 13:39:08 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:36557 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SKvJz-00006C-0j; Thu, 19 Apr 2012 13:39:07 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SKvJy-0005Fk-Vu; Thu, 19 Apr 2012 13:39:06 -0400
In-reply-to: <xmqqfwbzslt2.fsf@junio.mtv.corp.google.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195955>

Excerpts from Junio C Hamano's message of Thu Apr 19 12:55:53 -0400 2012:

> Is it really the character class, or is it the GNUism "\+", that breaks
> this?

Yes, you're right, it is the \+.  I didn't look carefully enough when
I saw that test_cmp looked like the way to fix this.

I'll re-word the patch...

> In other words, does it work if you patch it like this instead?

> -    grep "^master[     ]\+master$" < out &&
> -    ! grep -v "^master[     ]\+master$" < out
> +    grep "^master[     ][     ]*master$" <out &&
> +    ! grep -v "^master[     ][     ]*master$" <out
>  '

This does work and if there is some significance to the space or tab
then it's a better patch.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
