From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] CodingGuidelines: describe naming rules for configuration variables
Date: Sun, 01 Feb 2015 12:18:34 -0800
Message-ID: <xmqq1tm99yhx.fsf@gitster.dls.corp.google.com>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
	<1422484393-4414-1-git-send-email-gitster@pobox.com>
	<1422484393-4414-4-git-send-email-gitster@pobox.com>
	<54CDB5C6.3020702@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 01 21:18:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI0ym-0003Ff-E9
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 21:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbbBAUSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 15:18:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752087AbbBAUSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 15:18:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E07D33179;
	Sun,  1 Feb 2015 15:18:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SXMeUuEtzQsraAnmc1aVjarmygs=; b=FQy4dx
	hEw6zNddMPXrB0sxkBqnv3rObYgBRgjMAKBeCMoguS9vMCMlOxEw08Hta8qnAD9g
	MTUqnZzZSjEvFq1bJ39cebie8NJ3bWdtw/LgOy4KnVwQ7xCC1sq6vy/N4J/2lNLN
	9sFXdZg4Q13XGESJBDFjJc2zkIpYkPfs0fnRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yf9MzrhGFZhoTifhSyHkOPFFB246GnGg
	7yDJFHCEoC6G1TuvPb/tbkQTLceCDGoLAo+d78Rpy8jG1f0ZNNYk1tHF9i9Ypzcd
	KQ6XBfnFps7Onb3nk2kUuZ9otX2v2DOisKdyFUl1LFPNFbKqfeCA90S/pYIto7ZE
	Lp9fFfnJl9Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 733D833178;
	Sun,  1 Feb 2015 15:18:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCB5833174;
	Sun,  1 Feb 2015 15:18:35 -0500 (EST)
In-Reply-To: <54CDB5C6.3020702@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 01 Feb 2015 06:12:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8045B162-AA4F-11E4-8275-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263238>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 01/28/2015 11:33 PM, Junio C Hamano wrote:
>> +   When choosing the variable namespace, do not use variable name for
>> +   specifying possibly unbounded set of things, most notably anything
>> +   an end user can freely come up with (e.g. branch names), but also
>> +   large fixed set defined by the system that can grow over time
>> +   (e.g. what kind of common whitespace problems to notice).
>
> I think we can all agree with this rule for "anything an end user can
> freely come up with". Such sets are truly unbounded.
>
> But what is the justification for applying it to "large fixed set
> defined by the system that can grow over time"? Any set of items that
> needs to be programmed one by one is not unbounded in the same sense. It
> is true that it can grow over time, but there is a practical limit on
> how many such options we would ever implement, and at any given time the
> set has a well-defined, finite number of members.
>
> I suppose that this is a reaction to Johannes's proposal [1] to add
> configuration settings like
>
>     git config fsck.badDate ignore

Not really.

This started after I looked at the add.ignore-errors issue discussed
and I was trying to codify existing practices by running greps,
blames and logs on 'master' to see what potential pitfalls are, and
what good existing practices to follow suit we already had.

The fsck changes were not in my mind at all.

I can see it argued that for things that are completely independent
(e.g. the consequence of setting fsck.badDate can never be affected
by how fsck.missingTagger is configured), separate configuration
variables may not be wrong per-se, but I can see that a set of knobs
that would have been originally independent, as the operation grow
richer, gain more semantics to make them related, and at that point,
I doubt "they are internally independent; expose them as independent
to the end users" argument would hold water that well.

A good example is "core.whitespace", where you would have started
with a simple set of booleans ("blank-at-eol" and "space-before-tab"
are conceptually independent and will stay to be), but once you
start supporting "indent-with-non-tab" and "tab-in-indent" you
cannot pretend that they are independent.

And that is the "existing practice" I primarily had in mind.  We
didn't do

	whitespace.tabInIndent = true
        whitespace.indentWithNonTab = true

to pretend they are independent and still internally having to make
sure the consistency of the setting.  We structured the syntax for
ease of the end user (not scripter) to shorter

	core.whitespace = tab-in-indent,indent-with-non-tab

as we need the consistency thing either way (and it is easier to see
the consistency mistakes when they appear next to each other).

And I am happy that we chose wisely in an early version that didn't
use one-variable-per-knob but used list-of-features-as-value instead.


> [2] which you didn't like [3] but I did [4]. (Did you miss [4], in which
> I think I made some good arguments for Johannes's proposal? I don't
> think you responded to it.)

I saw it, found it as an argument between "not good" and "weak" (see
above), kept in my mailbox while trying to decide if it was worth
responding, and then forgot about it after I got busy dealing with
other topics that have more relevance to the upcoming release ;-)

> I think it would be more productive to finish the concrete discussion
> about the "fsck" proposal,...

Surely.

 (0) fsck.bad-date is out.

 (1) fsck.badDate is OK.  I expect there is very high chance for
     them to stay independent forever.

 (2) fsck.ignore = bad-date,... is still my preference, only if it
     aligns with existing core.whitespace precedence that allows
     users to leverage the familiarity.


I see Peff cites "pager.<cmd>", but I think it was something that we
would rather shouldn't have done, similar to "alias.<cmd>".  They
are bad precedents we shouldn't encourage new things to mimic.

But that is not from "one-variable-with-list-is-better" (it is not
better for these "independent" ones) but is purely from the syntax
point of view.  There is no good reason to force case insensitivity
to the command names used as the key in these cases, but we do
because we made them the last-level variable names, and we have to
avoid hyphens in the command names while at it if we want to be
consistent (and the consistency was the point of the original
add.ignore-errors discussion that started all this, after all).

If they were

    pager.diff.enable = true
    alias.co.command = checkout

the world would have been a lot better place.
