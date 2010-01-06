From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit: make the error message on unmerged entries
 user-friendly.
Date: Wed, 06 Jan 2010 10:15:44 -0800
Message-ID: <7v8wcbw14f.fsf@alter.siamese.dyndns.org>
References: <1262783414-23101-1-git-send-email-Matthieu.Moy@imag.fr>
 <7veim3yx5o.fsf@alter.siamese.dyndns.org> <vpqtyuz86ny.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 06 19:16:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSaQJ-0000XR-46
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 19:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326Ab0AFSPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 13:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756053Ab0AFSPx
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 13:15:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab0AFSPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 13:15:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 900918E477;
	Wed,  6 Jan 2010 13:15:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=62VvGaIE+Ne2y+bsLuFktiDd8+c=; b=NRrWvc
	TbSTsn80KD1zcJkx0RfvB0tGPviMi0ufyJKHHsz8xaiM48fmGM1BG1T4DwdTwtvM
	AEgTlUkS/oMLNVkJm9b0iz07KGb0SDw5+InznPLWSC+aR9+mrg/wA5DImQjb7ndG
	59wcg9L27ENmw2X9toUm4p0PixZGDOeoWLTl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K8oEVfAUeaEouwHltUgFOaGv5NaQFIoO
	6eYtvi/bTZJCZSsnqLJorOp7j/ZNaIHl798dOFcDSROiETSMwS8tKq9hOTdd0b/K
	Cp28ucrcZUPVHZeBDrGEw/YXaTAg/1zciuncGPb8XrPXIHW9sm8UL50e+kpFCI0v
	pJlPSAChueU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AC0D8E471;
	Wed,  6 Jan 2010 13:15:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD04C8E46C; Wed,  6 Jan
 2010 13:15:45 -0500 (EST)
In-Reply-To: <vpqtyuz86ny.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed\, 06 Jan 2010 18\:49\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83DB1E94-FAEF-11DE-B225-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136281>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Maybe "sometimes", but to me, that's sufficiently rare to be omited
> here (I don't think I ever used 'git rm' to resolve a conflict). The
> user manual says this:
>
> ,----
> | Each time you resolve the conflicts in a file and update the index:
> | 
> | $ git add file.txt
> | 
> | the different stages of that file will be "collapsed", after which git
> | diff will (by default) no longer show diffs for that file.
> `----
>
> and I don't think it makes sense to try to be more exhaustive here
> than in the user-manual.

I tend to disagree.  The user-manual, as it currently stands, is an
introductory document that covers the concepts and the surface of git.
It's purpose is not to replace the main manual, but to give the necessary
foundation _before_ people read the manual.

>> The need to give this advice on how to resolve conflicts is shared among
>> commands like 'git merge', 'git cherry-pick', and 'git status', to name a
>> few.
>
> Not sure 'status' needs anything more. It already says
>
> # Unmerged paths:
> #   (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> #       both modified:      foo.txt

This message was exactly what I was getting at.  The message in the
parentheses is what I called "advice".  As I was suggesting to share the
advice messages used by commands that deal with mergy situations (like the
one you added in your patch), looking at existing examples to find the
best one and using that in other places would be the most effective
approach.  That one line we see above is concise and does mention "rm" as
well.  Why not use it?

>> I think we should consolidate them all.
>
> Right, although "commit" is definitely the most important (dumb users
> don't need "git merge").

Your "dumb users" don't get the unmerged error from commit, either, if
they don't need "git merge".
