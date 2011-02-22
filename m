From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/31] refactor rebase
Date: Tue, 22 Feb 2011 11:21:42 -0800
Message-ID: <7vd3mjdge1.fsf@alter.siamese.dyndns.org>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vd3mz33xb.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1102111811300.26684@debian>
 <alpine.DEB.2.00.1102132047500.4253@debian>
 <alpine.DEB.2.00.1102220847500.5290@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 20:22:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrxoG-0003Ck-Kh
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 20:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab1BVTWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 14:22:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab1BVTWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 14:22:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A43732E1;
	Tue, 22 Feb 2011 14:23:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ed7DwSvW6Y3rvCqSuJth/pK4V/Q=; b=kwW03q
	OvbycDmWSPxQElobxWWhfzWlCvwmkvyQUrciaASarJOYVAomaY22vP+kFOJw0xwd
	gE8l4c9v2+2DHLg5WWVKpBDClVvAmacxBb8+BmMqqg1ZsAYdi2heYRExaD89IiLT
	r1AxrIYxynJv1RKocYj8lqcaJZLnZxllWKQuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JmT8RB7cMnnVmJ9zOJDFECcN4k4v2Rnt
	wLIWCzxbL6eSPuMe9N8k1qMJEwsDS1GyBsyukJ1KlAdWTcDb/oavOBT7DE3ynQ76
	fmzA1sKrSYulMlujqNdVLf1Y0vArJqxq2VJd++jkuI/4n8hWuj6LJ58yM6ZatU01
	1UqNLWdhc8w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 271B632E0;
	Tue, 22 Feb 2011 14:23:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3DEE332CC; Tue, 22 Feb 2011
 14:22:54 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1102220847500.5290@debian> (Martin von
 Zweigbergk's message of "Tue\, 22 Feb 2011 08\:58\:09 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B846D4A-3EB9-11E0-8582-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167575>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Sun, 13 Feb 2011, Martin von Zweigbergk wrote:
> ...
>> This would apply on top of mz/rebase after dropping 95135b0 (rebase:
>> stricter check of standalone sub command, 2011-02-06). If you agree
>> with it, I will include it in a future re-roll.
>
> Any opinions about this, anyone? I have one example: I was rebasing
> some things the other day where I thought there would be no conflicts.
> After applying a number of patches, it turned out there were
> conflicts. I think allowing 'git rebase --continue -sours' would have
> been useful in that case. It's rare enough that I don't care much,
> though.

Hmm, do you think applying -sours throughout to the rest of the series
would have been a safe thing, or do you think you would rather wanted to
see -sours applied only to that particular one?

> The reason I'm asking is that I have a patch that fixes the problems
> with the command line parsing that Johannes Sixt pointed out in
> another mail on this thread and would like to know if I should make it
> apply on top of this patch or not.

It is a good idea to build a change you are more certain of first,
excluding the ones you have doubts about.

Besides, this part of the patch would need fixing anyway ;-)

@@ -288,6 +314,7 @@ test $# -gt 2 && usage
 
 if test -n "$action"
 then
+	test -n "$resume_incompatible" && "--$action used with incompatible option"
 	test -z "$in_progress" && die "No rebase in progress?"
 	# Only interactive rebase uses detailed reflog messages
 	if test "$type" = interactive && test "$GIT_REFLOG_ACTION" = rebase
