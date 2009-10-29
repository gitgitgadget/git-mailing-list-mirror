From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase -i: improve usage message
Date: Wed, 28 Oct 2009 23:24:30 -0700
Message-ID: <7vtyxiafa9.fsf@alter.siamese.dyndns.org>
References: <1256774549-8191-1-git-send-email-brian.ewins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@googlemail.com
To: Brian Ewins <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:25:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ORY-00067V-FO
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbZJ2GY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 02:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbZJ2GY5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:24:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbZJ2GY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 02:24:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9672D6B55A;
	Thu, 29 Oct 2009 02:25:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vbqi6sxCRoezJYzCSJtTmqxNHDo=; b=EteHU+
	k2jykxtM73vOglQIsa/WbXWF1kGNa20rqHH+Ee1e5mm6IYhtvVQuWB/MLILIzyMh
	EWMnGb/idaq06bjokXR7UVks/8/UwN8vulr4DXzqZFCUuZQJC5ODh2CQ2h3dK9MM
	kYiu6vFpa9m0kiKyrtBeqSBhrTse7j8iOD6VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b3/SUvRfRqGUpDLGMFz6eaX7Rf/l4glE
	+qbCVdNBWQVAjTGjVdbcfyU41UJLvRfX5JvVfFmfEloFDmNf93DUgKMjGJR4aolN
	VYtPEqNZrKbiBJHE3MocMdESNAy002PzwOhNbq/VJyo7bNDaQ/0mnmnyyqTSTGZy
	uQCig1CgEzM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 628656B559;
	Thu, 29 Oct 2009 02:24:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84E546B557; Thu, 29 Oct
 2009 02:24:46 -0400 (EDT)
In-Reply-To: <1256774549-8191-1-git-send-email-brian.ewins@gmail.com> (Brian
 Ewins's message of "Thu\, 29 Oct 2009 00\:02\:29 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C75ACFFC-C453-11DE-852C-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131557>

Brian Ewins <brian.ewins@gmail.com> writes:

> The usage message was confusing as it implied that interactive
> mode was optional but the default. Change the message to more
> appropriately report usage when the -i flag is supplied.
> In addition, use the same division into 3 command formats as
> the man page.

I agree; if "git rebase--interactive -h" were asked, "-i is always used"
might be a correct thing to say, but nobody will get the message that way.
Instead, "git rebase --nonsense -i" and "git rebase -i --nonsense" will be
the most common way for users to see the message (also "git rebase -i -h").

The OPTIONS_SPEC in rebase--interactive is for the interactive mode and
for nothing else, so it may be a good idea to clearly say so at the
beginning.  The user experience perhaps should look like:

    $ git rebase -i -h
    Note: this help is only about the interactive mode;
    see 'git rebase -h' for help on non-interactive mode.

    usage: git rebase -i [<options>] [--] <upstream> [<branch>]
       or: git rebase -i (--continue|--abort|--skip)

    Available options are
    -v,--verbose          verbose output
    --onto <commit>       rebase onto given commit instead of <upstream>
    -p,--preserve-merges  try to recreate merges
    -i,--interactive      (always in effect in interactive mode)
    -m,--merge            (always in effect in interactive mode)

    Actions:
        --continue        continue the interrupted rebase session
        ...

By the way, I think the main "git rebase" help should be improved first
for this improvement to make sense.

 * Its first line "usage" is too long;

 * It only mentions [-i] in the first line but does not hint that the
   detailed help on interactive mode is available with "rebase -i -h".

The user experience perhaps should look like this:

    $ git rebase -h
    usage: git rebase [<options>] (<upstream>|--root) [<branch>]

    -i,--interactive  go interactive (see 'git rebase -i -h')
    -v,--verbose      verbose output
    ...

Also see

  http://thread.gmane.org/gmane.comp.version-control.git/129906/focus=130646

I agree with Peff that the first-line usage should just say <options> in general
and have a table of options and their descriptions.
