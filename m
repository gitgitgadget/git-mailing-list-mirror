From: "George Spelvin" <linux@horizon.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: 5 Aug 2009 14:17:55 -0400
Message-ID: <20090805181755.22765.qmail@science.horizon.com>
References: <7vljlzjorh.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, linux@horizon.com,
	torvalds@linux-foundation.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 20:18:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYl3u-0001DE-J1
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbZHESR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbZHESR6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:17:58 -0400
Received: from science.horizon.com ([71.41.210.146]:28505 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1749667AbZHESR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:17:58 -0400
Received: (qmail 22766 invoked by uid 1000); 5 Aug 2009 14:17:55 -0400
In-Reply-To: <7vljlzjorh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124940>

> Three classes of people compile git from the source:
>
> * People who want to be on the bleeding edge and compile git for
>   themselves, even though they are on mainstream platforms where they
>   could choose distro-packaged one;
>
> * People who produce binary packages for distribution.
>
> * People who are on minority platforms and have no other way to get git
>   than compiling for themselves;
>
> We do not have to worry about the first two groups of people.  It won't
> be too involved for them to install Perl on their system; after all they
> are already coping with asciidoc and xmlto ;-)

Actually, I'd get rid of the perl entirely, but I'm not sure how
necessary the other-assembler-syntax features are needed by the
folks on MacOS X and Windows (msysgit).

> We can continue shipping mozilla one to help the last group.

Of course, we always need a C fallback.  Would you like a faster one?

> In the Makefile, we say:
>
>    # Define NO_OPENSSL environment variable if you do not have OpenSSL.
>    # This also implies MOZILLA_SHA1.
>
> and with your change, we would start implying STANDALONE_OPENSSL_SHA1
> instead.  But if MOZILLA_SHA1 was given explicitly, we could use that.

Well, I'd really like to auto-detect the processor.  Current gcc's
"gcc -v" output includes a "Target: " line that will do nicely.  I can,
of course, fall back to C if it fails, but is there a significant user
base using a non-GCC compiler?
