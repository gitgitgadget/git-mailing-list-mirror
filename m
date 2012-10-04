From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Thu, 04 Oct 2012 09:39:02 -0700
Message-ID: <7vobki19ax.fsf@alter.siamese.dyndns.org>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
 <CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com>
 <7vbogj5sji.fsf@alter.siamese.dyndns.org> <506D5837.6020708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:38:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtdg-00033L-6F
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933445Ab2JDQjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 12:39:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933434Ab2JDQjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 12:39:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90CEA88AE;
	Thu,  4 Oct 2012 12:39:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ahPZdUmTqG1DU/4s4y1zkY6tzIg=; b=Mf407D
	HcQ3b/Vrt37wz4P6VDx0FWU/2ZpWeb49xXnTFQuftrjDSlKN4w2FLEjEjP2MOLZa
	G1t/HF9HCBOhC07ZflxN6WgD2oIdemaVcBgmNBzcDFyzDXTQ238eo8lxz20dIcnt
	uA/bFKdIXBHslmZOq20XhoclQBy2Q0jHjFrxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BdcMHNdMKXfFV2CwWUGPgtqW+ofBt7OP
	95/nE1o6joDkg5RYYhBfEbhw6x1LMqsJaY0iIDxAVJhxDhBQA+eaMuahTzZ04lDV
	bk8yROxG3XWsY9FI0BXYCrPA081pqzj7Q7PqNAYZcGUfq5CRVXs+RZpkf/jvavP6
	N92N9r86sdg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77BF588AC;
	Thu,  4 Oct 2012 12:39:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEC5488A8; Thu,  4 Oct 2012
 12:39:03 -0400 (EDT)
In-Reply-To: <506D5837.6020708@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 04 Oct 2012 11:34:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01FD5586-0E42-11E2-AE6A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207013>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 10/03/2012 08:17 PM, Junio C Hamano wrote:
>> 
>> What is the semantics of ** in the first place?  Is it described to
>> a reasonable level of detail in the documentation updates?  For
>> example does "**foo" match "afoo", "a/b/foo", "a/bfoo", "a/foo/b",
>> "a/bfoo/c"?  Does "x**y" match "xy", "xay", "xa/by", "x/a/y"?
>> 
>> I am guessing that the only sensible definition is that "**"
>> requires anything that comes before it (if exists) is at a proper
>> hierarchy boundary, and anything matches it is also at a proper
>> hierarchy boundary, so "x**y" matches "x/a/y" and not "xy", "xay",
>> nor "xa/by" in the above example.  If "x**y" can match "xy" or "xay"
>> (or "**foo" can match "afoo"), it would be unreasonable to say it
>> implies the pattern is anchored at any level, no?
>
> Given that there is no obvious interpretation for what a construct like
> "x**y" would mean, and many plausible guesses (most of which sound
> rather useless), I suggest that we forbid it.  This will make the
> feature easier to explain and make .gitignore files that use it easier
> to understand.
>
> I think that 98% of the usefulness of "**" would be in constructs where
> it replaces a proper part of the pathname, like "**/SOMETHING" or
> "SOMETHING/**/SOMETHING"...

I think it is a good way to go in the longer term, if we all agree
that "**" matching anything does not give us a useful semantics
[*1*].

Is it something we can easily get by simple patch into the wildmatch
code?  I'd hate to see us parsing the input and validating it before
passing it to the library, as we will surely botch the quoting or
something while doing so.

When we require "x/**/y", I think we still want it to match "x/y".
Do people agree, or are there good reasons to require at least one
level between x and y for such a pattern?  Assuming that we do want
to match "x/y" with "x/**/y", I suspect that "'**' matches anything
including a slash" would not give us that semantics. Is it something
we can easily fix in the wildmatch code?


[Footnote]

*1* The message you are responding to was written in a somewhat
provocative way on purpose so that people who like the way rsync
matches "**" can vocally object. I would like to see arguments from
the both sides to see if it makes sense.
