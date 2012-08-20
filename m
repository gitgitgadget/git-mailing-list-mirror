From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures in t4034
Date: Sun, 19 Aug 2012 17:56:17 -0700
Message-ID: <7vboi6nzym.fsf@alter.siamese.dyndns.org>
References: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com>
 <5030FD49.6060704@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Aug 20 02:57:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3GIf-0003x3-Vc
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 02:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785Ab2HTA4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 20:56:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37556 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab2HTA4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 20:56:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CCF3959D;
	Sun, 19 Aug 2012 20:56:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cpvWpSKKzbqUMlsfR3rie0v2djA=; b=tj6gog
	FkrhSMrExAJ2+OREFkHXjNH0hkzC9TbI0AT4xJRoLgpkHzgwDtbiCb6o3/r73CRU
	txmk70Jq0SsaFz5IpaDh36KCY6NwSL+G2p/d7eodlDXyGRjg1vreTuqFb91iVFhl
	UxjhcKnS5HupttMcSWb61dIl8lGwTFggPoBn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N7HxHehpGjq1hQU/mTCWDnvfeIlRHQor
	qL30MjaU4//ifXlTvBY32NaW9x2t5WBLq51qkJAaXiqJf0vkEud5enNqqKU/NGJC
	rHyOUvICSrYnQsiVNX/b+/zGR7pLAYVqAtg8Sxqv3d8rJZy9jHLqBju5Mn5rBQST
	vcA09PJ/kZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 697F4959C;
	Sun, 19 Aug 2012 20:56:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2037959B; Sun, 19 Aug 2012
 20:56:18 -0400 (EDT)
In-Reply-To: <5030FD49.6060704@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sun, 19 Aug 2012 15:50:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA0A9ECA-EA61-11E1-8F06-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203747>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> I had the same problem (or at least it *looks* like the same problem) on Linux
> last year (May 2011), which turned out to be a bug in the regex routines in an
> old version of glibc. 
>
> I don't know OS X at all, so this may not be relevent; does OS X use glibc?
> (I didn't think so, but ...)
>
> I sent some patches to the list which may be helpful. I can't get to gmane to
> look up a reference, but you need to search for:
>
>     [RFC/PATCH] userdiff.c: Avoid old glibc regex bug causing t4034-*.sh test failures
>
> sent on 3rd May 2011.

Thanks; that's $gmane/172676 for people who prefer easier to read
threading interface.

> Also, in the same thread, a reply to Jonathan Nieder on 7th May contains a
> test which checks whether your regex routines suffer this bug.
>
> These patches were not applied since I didn't think this would be a common
> problem. I simply set NO_REGEX=1 in my config.mak, since the compat/ regex
> routines don't suffer from this problem.

You also said:

  This is an RFC because:
   - A simple fix would be for me to put NO_REGEX=1 in my config.mak,
     since the compat/regex routines don't suffer this problem.
   - I suspect this bug is old enough that it will not affect many users.
   - I have not audited the other non-matching list expressions in
     userdiff.c
   - blame, grep and pickaxe all call regcomp() with the REG_NEWLINE
     flag, but get the regex from the user (eg from command line).

I think:

 - the second "this is old enough" assumption was broken again by
   Brian this week ;-)

 - the first "Use NO_REGEX if your regexp library is broken" is a
   reasonable thing to do; is this something we may want to throw
   into the platform specific section of the top-level Makefile?

 - among the fourth, "blame" and "grep" goes line by line, and even
   though pickaxe is primarily meant to take multi-line pattern, I
   do not think people give multi-line pattern when they use it in
   the regexp mode.  So I do not think they pose a real issue even
   though they get an arbitrary pattern from the user.

 - the third, combined with the fact that end user can define their
   own pattern, is a killer.  We cannot really afford to let broken
   regex library to break us.

I think a sensible way to go in the longer term, while we wait these
old regexp libraries die out, is to help people to avoid building
git without NO_REGEX on platforms where they need it.

Thanks for digging an old article.
