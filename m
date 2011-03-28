From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add two grep config options
Date: Mon, 28 Mar 2011 11:39:20 -0700
Message-ID: <7vy63zxf6v.fsf@alter.siamese.dyndns.org>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
 <7vlj024wal.fsf@alter.siamese.dyndns.org>
 <4D9037AA.9090601@drmicha.warpmail.net>
 <20110328115421.GA9232@sigill.intra.peff.net>
 <7vvcz3yxs8.fsf@alter.siamese.dyndns.org>
 <20110328172122.GA20817@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 20:39:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4HLn-0001mi-Bl
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 20:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab1C1Sje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 14:39:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1C1Sjd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 14:39:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B0C9031F2;
	Mon, 28 Mar 2011 14:41:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=AI8jKfq05JOxUeEkBgpQk6KrsrQ=; b=CiaX3GDhHpss70rfvgo8
	RhlbFEfB5Eqy2YWe68qf3mrUB18Y+9bSTZX11u9FDlvRWDYCEaPuayLW6jXJaaHW
	B2ImAUpIqaXXCjoZhVO5IO4oHeQgaBWVHgqJiO1NT+s/+XOK1kHNq5rG2vFpIj2R
	QzQLhgw5nGgj217QQ4lTTaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=umu0A48LrQn+UivZ8WA0Z6eeQKKEBhrZC3ofpQHMjrFhwu
	nR2+cuDbuG+d/ezILsyx3YO0pxG/rpUtfz6gNktICM3GNUqyaxJDJL4boABsDqpr
	gmES7Q1RJ/MhVDRpwwohlkoGgiiQ6hCK+yRN8UYqwT1oyodegYFbi+xXgzmUE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70F9331F1;
	Mon, 28 Mar 2011 14:41:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E706631F0; Mon, 28 Mar 2011
 14:41:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F59BB28E-596A-11E0-B152-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170174>

Jeff King <peff@peff.net> writes:

> I dunno. I generally prefer to use extended regexps when I can, but I
> don't remember ever having been annoyed that they are not the default
> with git grep. Perhaps because 99% of my greps are for literal symbol
> names (whereas in my editor, I am often doing substitutions, and I am
> continually annoyed at having to use backslash to make my parentheses
> magical).

I do not think I've ever been annoyed that "GNU grep" needs -E to enable
extended regexps, either.

As much as I hate GREP_OPTIONS and GREP_COLORS environment variables that
force us to write a "sane_grep" wrapper to run "grep" while disabling
these, I have to admit that the approach to use these environment
variables is far easier to disable than having a set of configuration
variables that cover many commands we have, which is harder to disable
selectively.

Having discussed all this, with an addition of --[no-]line-number synonym
to the existing -n option, I don't think this particular incompatibility
is a huge issue.  At the worst, we might want to wait until a version bump
like 1.8.0, but I personally think a prominent notice in the release notes
in 1.7.5 would be sufficient.
