From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] If `egrep` is aliased, temporary disable it in
 bash.completion
Date: Thu, 06 Dec 2012 10:01:47 -0800
Message-ID: <7v4njzjbzo.fsf@alter.siamese.dyndns.org>
References: <20121129151418.GA19169@redhat.com>
 <7vpq2wqr3v.fsf@alter.siamese.dyndns.org>
 <7vk3t4qpoe.fsf@alter.siamese.dyndns.org> <20121206140541.GA4892@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Adam Tkac <atkac@redhat.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 19:02:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tgflz-00054s-DZ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 19:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946145Ab2LFSBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 13:01:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932863Ab2LFSBt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 13:01:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B62C9F09;
	Thu,  6 Dec 2012 13:01:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rXWl8KgdLsdz6fUMaVdQF1xpNI8=; b=yHG98D
	42+xWmFViGU2HnL2hyFayhXb8aoYggrOCMAe/3QZ90+riggPbHBNBlRRSxLYM+VB
	6m6ndFP0PaSnQXfPgY7dCkBt0t/lIvsRebGxLsCZoZo9eZVkkbb5ggMT694+HkSw
	FYo8f+V1JKzb/pYD6yoUa7tY+3X4dg0hPXG5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uwv8YXly/cmMct1eJDNO1p5dzOE0cJ1F
	cSNU1TQZ5crhoYqEAXQYpJ1Yz7QYj80AukTwwcbYiu8gV95uPrezc/GGYZviqHEp
	DQBTNzCyvmsvckvBEWqJz42Jw0aU2tZ4uA9EYLQALV3mFvnXV+zeA0K+uBb/qM40
	QDh+BJ58AJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18A5E9F08;
	Thu,  6 Dec 2012 13:01:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BC1B9F07; Thu,  6 Dec 2012
 13:01:48 -0500 (EST)
In-Reply-To: <20121206140541.GA4892@redhat.com> (Adam Tkac's message of "Thu,
 6 Dec 2012 15:05:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 012EC072-3FCF-11E2-BA2D-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211168>

Adam Tkac <atkac@redhat.com> writes:

> On Thu, Nov 29, 2012 at 09:33:53AM -0800, Junio C Hamano wrote:
> ...
>> IOW, something along this line?
>
> This won't work, unfortunately, because shopt settings aren't inherited by
> subshell (and for example egrep is called in subshell).
>
> I discussed this issue with colleagues and we found basically two "fixes":
>
> 1. Tell people "do not use aliases which breaks completion script"
> 2. Prefix all commands with "command", i.e. `command egrep` etc.
>
> In my opinion "2." is better long time solution, what do you think?

Judging from what is in /etc/bash_completion.d/ (I am on Debian), I
think that others are divided.  Many but not all prefix "command" in
front of "grep", but nobody does the same for "egrep", "cut", "tr",
"sed", etc.

If it were up to me, I would say we pick #1, but I cc'ed the people
who have been more involved in our bash-completion code because they
are in a better position to argue between the two than I am.

Thoughts?
