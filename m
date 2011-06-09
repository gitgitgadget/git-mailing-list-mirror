From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/2] Remove noreturn function pointers in usage.c
Date: Thu, 9 Jun 2011 06:59:15 +0200
Message-ID: <20110609045915.GA15448@one.firstfloor.org>
References: <1307569417-8924-1-git-send-email-andi@firstfloor.org> <7v4o3z264s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 06:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUXL3-0004sl-0d
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 06:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab1FIE7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 00:59:19 -0400
Received: from one.firstfloor.org ([213.235.205.2]:45579 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab1FIE7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 00:59:18 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 0FE721ED80AD; Thu,  9 Jun 2011 06:59:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4o3z264s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175489>

>  - There are many more NORETURN and NORETURN_PTR in the code, and the
>    proposed commit log message does not explain why these two are the only
>    ones that are problematic and needs to be worked around. It does not
>    guide other people who might want to add NORETURN/NORETURN_PTR when
>    deciding if their change would break the "fix" this change brought in.

This was the only place where it crashed the compiler.

I don't have a good criterium to decide which cases do crash the compiler
or not except for trying it.

But I believe the crash is relatively unlikely (needs quite a lot of conditions
to line up), so it doesn't deserve extensive changes all over.

> 
>  - Potential impact to people who do not use Gcc 4.6 with profile feedback
>    is not explained away well, except for "Doesn't seem to make any
>    difference."

I merely went by "there are no new warnings" (I assume that's the main
motivation)

> 
>  - If other NORETURN/NORETURN_PTR could/should also go (I don't know due
>    to the first bullet point above) when using the problematic compiler
>    with the profile feedback feature, wouldn't it be a better workaround
>    would be to introduce a Makefile variable to ask git-compat-util.h to
>    make these two a no-op, perhaps?

I don't think we need to remove the others for now.

> 
> A patch to do so may look like this.
> 
> I did not like the triple negation "make NO_NORETURN=NoThanks" and wanted
> to name this AVOID_NORETURN instead, but decided to go with other existing
> Makefile variables.

Given the explanation above (I can update the description with that)
do you still want the complete disabling?

-Andi
