From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Trivial fix: Make all the usage strings to use the
 same pattern.
Date: Tue, 22 Sep 2009 12:05:03 -0700
Message-ID: <7vocp2ssv4.fsf@alter.siamese.dyndns.org>
References: <1253639330-9185-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqAfv-0001i6-L4
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 21:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbZIVTFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 15:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbZIVTFJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 15:05:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZIVTFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 15:05:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BD9F3C673;
	Tue, 22 Sep 2009 15:05:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3BGcVxkEVuynABSDLqzFN8EfSFA=; b=AbvOax
	Q/XPAmLtdZaNhwldNS2VfXyS01dk0i/L7Orcr/yfn0SNIMFd2EF4v6lulJ2yt/ou
	pxKxKMT7mpyYR2b3Q1FcA39Q7zhgqAJvmS+m4GnIKEeQSFr5AETHvo/kfdK9R3Z3
	W8BYZ4ND0NyO7CNIEWJHI6MR11W6Fov9np3tA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lqry6sq8Xfy0smtKgZYdDCqyXoYbPwAw
	TzdSqyK6ZgF0s+BYR9SQrbgKd5hEPrPMki3OK/Xmm5fI4fDMJUQPfA0RuZTgNjBy
	tjrwIf4lAN3TiOh/xvXRQZa8f9H91BjfEeN/B/Gl46rXDt+yJUbg6JDE9u+VfIyY
	TqG0/HE80E0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D57F3C66E;
	Tue, 22 Sep 2009 15:05:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59C8C3C66C; Tue, 22 Sep
 2009 15:05:05 -0400 (EDT)
In-Reply-To: <1253639330-9185-1-git-send-email-tfransosi@gmail.com> (Thiago
 Farina's message of "Tue\, 22 Sep 2009 13\:08\:50 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D82F31F8-A7AA-11DE-819C-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128952>

Thiago Farina <tfransosi@gmail.com> writes:

> They follow the below pattern:
> Git command: git command-name
> Usage string: git_command_name_usage
>
> Also changes "static char const * const" to "static const char * const" to
> match with the definition in api-parse-options.txt.

Probably it is obvious to you but may I ask a very stupid question?

People have to spend time to review 2500 lines of changes to make sure
that this patch does not contain silly mistakes, unexpected side effects
nor malicious changes.

And after spending that time, we need to suffer merge conflicts when we
merge a topic for this patch to 'next' (or 'pu'), because there are topics
that update nearby lines.

Then it gets worse.  When somebody needs to make a real change (as opposed
to a cosmetic one) to a topic that is cooking in 'next' that affects lines
near this patch touches, there are two choices, neither of which is good:
(1) make a patch against 'next', in which case I have to reverse rebase
the patch to keep the old variable name and formatting, as this "Trivial
fix" is not part of what the topic is about; or (2) make a patch against
the tip of the topic branch, in which case I have to resolve conflicts
when the updated topic is merged to 'next'.

In addition to your time spent to produce this patch and a couple of its
earlier iterations, all of the above is the cost of this whole thing.

Now that I talked about the cost, I have to ask about benefit.

What does this _fix_?  Does the benefit of this patch outweigh the cost,
and if it does, in what way?

In earlier iterations I couldn't answer this question myself, and I still
cannot.  That is the kind of patch people call needless code churn.

> -static char const * const archive_usage[] = {
> +static const char * const git_archive_usage[] = {
> -static const char * const builtin_add_usage[] = {
> +static const char * const git_add_usage[] = {
> ...
> -static const char * const git_bisect_helper_usage[] = {
> +static const char * const builtin_bisect_helper_usage[] = {

Huh?  This doesn't match what you claimed in the log message.

I see v2 and v3 were posted 15 minutes apart.  People need to check both
to see what changed, and that also adds to the cost.

Please slow down.

I do not mean "please slow down working on your patch, and instead spend
time somewhere else".  I mean "please spend more time rre-re-re-reviewing
what you are going to send."  If you did so, externally it would look as
if you slowed down ;-).

Among the topics that are cooking in 'next', at least builtin-commit.c and
fast-import.c have changes to overlapping areas this huge patch touches.
At least, exclude the changes to them from this patch, and make patches
separately for them.  That would make the cost of conflict resolution
slightly smaller.  You need to also check with 'pu', but writing this
response has already made me exceed my git time for today.
