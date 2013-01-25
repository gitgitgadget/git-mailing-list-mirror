From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: Add tortoisegitmerge helper
Date: Thu, 24 Jan 2013 23:21:21 -0800
Message-ID: <7vvcal683y.fsf@alter.siamese.dyndns.org>
References: <50FBD4AD.2060208@tu-clausthal.de>
 <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de>
 <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de>
 <7vpq0u8bxd.fsf@alter.siamese.dyndns.org>
 <CAJDDKr5O70tTfwuipWcYVJL6gM3bUyQh-22yVO89xn8OFsQOpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 08:21:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tydbf-0003Bs-Gv
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 08:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab3AYHV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 02:21:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63319 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab3AYHVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 02:21:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED5D16A01;
	Fri, 25 Jan 2013 02:21:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s8V9BrbnIS44ePS9w7JPLrLgk0g=; b=BX3+G0
	6GPblbFVbhu3Xfti1TpkLCAc+tjDlr2S0vCWmAZL0VFnnd/x8w4V3+eQ3KNus6AC
	EiWwR8Eja/ZsJoPQNUmRNWLz4UVyke1dmbSBqDRe1a2QMmY5jrbEAZYguezbqrad
	8gjhr2s/l4xCrjcKxgsIk7OMFrMzYV8GkLBpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQQtP8Q2L4NXXD98kGbSfSwW7OJbhJS3
	5mUcQ0y8d2mEf5mESZ2AVnh4e/WKBDIgaodpRXSJYFeugwY8jcoRNIm9iV7pafvT
	Klhsy8rdQPrbZjZyTc/o6nMJcd0+Op6fLJo62DVat75Q4FtXBrMv9Uc9DKpfcIcD
	RxGXnWYt0W8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D16EB6A00;
	Fri, 25 Jan 2013 02:21:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3338D69FC; Fri, 25 Jan 2013
 02:21:23 -0500 (EST)
In-Reply-To: <CAJDDKr5O70tTfwuipWcYVJL6gM3bUyQh-22yVO89xn8OFsQOpw@mail.gmail.com> (David
 Aguilar's message of "Thu, 24 Jan 2013 22:11:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D293374E-66BF-11E2-835B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214507>

David Aguilar <davvid@gmail.com> writes:

> Even though the old tortoisemerge and the new tortoisegitmerge
> have completely different syntax, could we still use the existence
> of one when deciding which syntax to use?
> ...
> ...and then later merge_cmd and diff_cmd
> can delegate to {diff,merge}_cmd_legacy() and
> {diff,merge}_cmd_gitmerge() functions to do the work.
>
> It's just a thought.  translate_merge_tool_path()
> is too low-level to do it, but it seems like we could
> get away with it by having some extra smarts in the
> scriptlet.

Sounds like a far better approach to me.  I'd like to at least see
an attempt be made to make that work first.

>>>> This paragraph needs to be rewritten to unconfuse readers.  The
>>>> original is barely intelligible, and it becomes unreadable as the
>>>> set of tools subtracted by "minus" and added by "plus" grows.
>>>
>>> But I think this should not be part of this patch.
>>
>> I agree that it can be done (and it is better to be done) as a
>> preparatory step.  The current text is barely readable, but with
>> this patch there will be two "minus", and the result becomes
>> unreadable at that point.
>>
>> It also could be done as a follow-up documentation readability fix.
>
> Another thought would be to minimize this section as much
> as possible and point users to "git difftool --tool-help".

We had a similar discussion here:

  http://thread.gmane.org/gmane.comp.version-control.git/201913/focus=201976

and Documentation/git-{diff,merge}tool.txt have stayed quiet since
then.

But Documentation/merge-config.txt tries to list everything that _could_
be enabled, and I do not necessarily think having one single
location that lists everything is such a bad idea.

Is there a way for me to programatically tell what merge.tool and
diff.tool could be enabled for a particular source checkout of Git
regardless of what platform am I on (that is, even though I won't
touch Windows, I want to see 'tortoise' appear in the output of such
a procedure)?  We could generate a small text file from the Makefile
in Documentation and include it when building the manual pages if
such a procedure is available.
