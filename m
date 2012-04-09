From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon, 09 Apr 2012 17:09:13 +0200
Message-ID: <m2fwcdc57q.fsf@igel.home>
References: <1333935414-10389-1-git-send-email-bwalton@artsci.utoronto.ca>
	<m2sjgde7cs.fsf@linux-m68k.org>
	<1333977812-sup-4111@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Apr 09 17:09:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHGDf-0001Wd-Rl
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 17:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713Ab2DIPJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 11:09:23 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53298 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab2DIPJW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 11:09:22 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VRFKT4xz1z3hhWD;
	Mon,  9 Apr 2012 17:09:14 +0200 (CEST)
Received: from igel.home (ppp-93-104-153-14.dynamic.mnet-online.de [93.104.153.14])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VRFKR1lLQz4KK3n;
	Mon,  9 Apr 2012 17:09:15 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 7BDC6CA29F; Mon,  9 Apr 2012 17:09:13 +0200 (CEST)
X-Yow: An INK-LING?  Sure -- TAKE one!!  Did you BUY any COMMUNIST UNIFORMS??
In-Reply-To: <1333977812-sup-4111@pinkfloyd.chass.utoronto.ca> (Ben Walton's
	message of "Mon, 09 Apr 2012 09:30:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195018>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Excerpts from Andreas Schwab's message of Mon Apr 09 02:40:03 -0400 2012:
>
>> How about using 's|[^/][^/]*|..|g' instead, which should avoid the bug
>> as well.
>
> I'd be ok with that change if the changed semantics of the regex are
> ok in this application.  It's essentially the same as s|[^/]+|..|g,
> which requires at least one character.
>
> In the current code, if you do:
>
> echo '/' | sed -e 's|[^]*|..|g'
>
> you get: ../.. (from a working implementation).
>
> Your regex would see the result  be: /
>
> I don't think we'd ever be passing a plain /, but we might pass a
> fully qualified path /path/to/foo, which would see the result change
> from ../../../.. to /../../.. and that could have unintended impact.

AFAICS the variables at this point never contain a value with a leading
slash.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
