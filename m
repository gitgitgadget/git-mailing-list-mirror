From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow generating a non-default set of documentation
Date: Mon, 08 Oct 2012 09:33:33 -0700
Message-ID: <7vpq4sncte.fsf@alter.siamese.dyndns.org>
References: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
 <20121007214855.GB1743@sigill.intra.peff.net>
 <7vwqz1oqi4.fsf@alter.siamese.dyndns.org>
 <20121007230703.GC3490@sigill.intra.peff.net>
 <20121007231156.GD3490@sigill.intra.peff.net>
 <7vlifhooe1.fsf@alter.siamese.dyndns.org>
 <20121007232942.GA5685@sigill.intra.peff.net>
 <7vhaq5onig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 18:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLGH4-00020e-S8
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 18:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038Ab2JHQdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 12:33:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851Ab2JHQdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 12:33:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AAC394FA;
	Mon,  8 Oct 2012 12:33:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xth4kltlDpf4f2iZEybRqGayDtY=; b=QkSZLY
	tknaTlUT6zzDI5OCwXCWddM/8WqgGZDb3Y3QZiJBb1Cn6Y2YChT92ZmlXvqRbp42
	4tTpgORKOBechH5A/efqGqbFIeukwXoz5v0+6wfFT4iGO31WNQeMxMlFWO9ZiD5Z
	jkIBx5Lyx7gmaOAUZ42xfZ9q+1VkiSWpSCf2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I56z3GCdVlmVQGnR12YEVm+uW7DvlDsG
	f8Ho+2XVG4n2r58b1uQuKzoF0+xV+xzdwS0PXOz746lObltFj3qjiq8mtVw5VgI2
	7yDeNCCE5sZ1iTFt6pLKuD55ztII5T3JOM3ZoZ8eWfSOIvb4btsObqR4Hx7TKJQU
	mNNpU8DrHyE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6369994F8;
	Mon,  8 Oct 2012 12:33:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B825F94F7; Mon,  8 Oct 2012
 12:33:34 -0400 (EDT)
In-Reply-To: <7vhaq5onig.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 07 Oct 2012 16:44:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E77CBB76-1165-11E2-815E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207237>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Sun, Oct 07, 2012 at 04:25:58PM -0700, Junio C Hamano wrote:
>>
>>> Yeah, modulo that the "defaults" is tracked and does not have to
>>> have the dash before "include" (it is an error if it is missing,
>>> no?).  It may want to be named with s/defaults/autodetect/, though.
>>> 
>>> > diff --git a/Makefile b/Makefile
>>> > index e3e3cd5..c00fd32 100644
>>> > --- a/Makefile
>>> > +++ b/Makefile
>>> > ...
>>> > -endif
>>> > -
>>> > +-include config.mak.defaults
>>> >  -include config.mak.autogen
>>> >  -include config.mak
>>
>> Yeah, sorry, mindless copying on my part from the lines below. It
>> clearly should not have the "-".
>>
>> I'm fine with something besides "defaults". I meant it to be "these are
>> the config defaults before you tweak them", but yeah, it is more like
>> "these are the config options we picked up from uname".
>
> Let's put this on hold in the "possibly a good direction to go in"
> pile, and defer it to post 1.8.0; I haven't even looked at (and do
> not plan to before the release) these "auto-detect" bits are all
> safe to be included in Makefiles in subdirectories.

Oh by the way, by "this (on hold)" I meant not just your "move the
default-by-platform to a separate include", but the whole "a
platform may not want manpages" topic.  The patch posted was merely
me wanting to format git-push.txt and nothing else when sanity
checking a patch to that file, and it is insufficient for the
purpose of "a platform may not want manpages" without a matching
change to the install target.

Even though your "include" thing was primarily done to make it
easier to include it from Makefiles in subdirectories, I very much
like it even without that benefit.  The change makes it clear that
there is another platform specific bit after '-include config.mak'
(yes, I am looking at you, Darwin), which is a huge eyesore we would
want to do something about.
