From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: use printf instead of echo
Date: Thu, 20 Mar 2014 09:42:00 -0700
Message-ID: <xmqq4n2s255z.fsf@gitster.dls.corp.google.com>
References: <20140314235735.GA6959@ibr.ch> <20140315001855.GK15625@google.com>
	<xmqq61nceidp.fsf@gitster.dls.corp.google.com>
	<20140318221844.GA828@google.com>
	<xmqqfvme5cql.fsf@gitster.dls.corp.google.com>
	<20140320001718.GM15625@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe Storbeck <uwe@ibr.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 17:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQg2n-0001DQ-GB
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 17:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757754AbaCTQmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 12:42:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64243 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757116AbaCTQmF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 12:42:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5841D76C65;
	Thu, 20 Mar 2014 12:42:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bgIYcj3EsVlm8GWsGwWwrH8dphU=; b=fQtlb8
	WYoz46b/lvG4wZaWwpOI1YNIPimg721yti9qDK6JtdAs0HYjRtW8lDmn7mp9bnjP
	u2B9lA5x9IFLpmvoFcRF3/7edoEKl7SRc5jrYmoyxVO/+ifSWntULiKpBQCp12HH
	2sXDQvaS2t0o5Wm64fAJWeqnrS+GlcYKw3ihg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HS/jYGMIYmJCzSwiI+fGOsYLOCbWE9c+
	jXgK9gN8YkEbsUOPoV8wmeMGllywh3P6ZDvv6GQYe56Rwiu6E8fCqzxc2I4X6Ppp
	mjwa5HlsNICb7nCsEs6+O1BwWNp0W7t6TPp3+DrZQO5fa9MgZOeMshAHzlvMhZGr
	jpbkEKGcDdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 424F076C64;
	Thu, 20 Mar 2014 12:42:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3138176C62;
	Thu, 20 Mar 2014 12:42:02 -0400 (EDT)
In-Reply-To: <20140320001718.GM15625@google.com> (Jonathan Nieder's message of
	"Wed, 19 Mar 2014 17:17:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 900F9582-B04E-11E3-AC7B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244555>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>> I am a bit reluctant to name the helper "sane_echo" to declare "echo
>> that interprets backslashes in the string is insane", though.  For
>> these "print a single line" uses, we are only interested in using a
>> subset of the features offered by 'echo', but that does not mean the
>> other features we do not want to trigger in our use is of no use to
>> any sane person.
>
> In a portable script, uncareful use of 'echo' is always insane.

I agree that makes sense and I actually think that it is a bit
stronger than that.  If a script is meant to be portable, there is
no way to use "echo" on a string whose contents is unknown sanely.
There is no "careful use is OK".

> In a script tailored to an environment where echo behaves consistently
> it is perfectly reasonable to use 'echo', but that's a different
> story.  In the context of git, saying "Here is the thing you should
> always use instead of echo" is a good thing, in my opinion.

That is true in my opinion, but that thing is also what you should
always use instead of "printf '%s\n'".  A guideline more useful for
the users is "Here is the thing you should always use when literally
emitting a single line.", isn't it?
