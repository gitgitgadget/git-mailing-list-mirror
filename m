From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Wed, 11 Sep 2013 10:24:00 -0700
Message-ID: <xmqqob7ztgpb.fsf@gitster.dls.corp.google.com>
References: <vpq4n9tghk5.fsf@anie.imag.fr>
	<xmqqeh8wzl0h.fsf@gitster.dls.corp.google.com>
	<vpq61u7akin.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 11 19:24:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJo9A-0005Aw-MC
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 19:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab3IKRYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 13:24:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47039 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755684Ab3IKRYD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 13:24:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17DEF412E5;
	Wed, 11 Sep 2013 17:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qcsl0di8/MmkNUitocESZLONLig=; b=YqzJmN
	dj0tEQ9EI8yRMJwTB4CS0e45C1pV6TZHt4qlq4cmTXqsrSC7OUCeM2SaU3i42uLX
	sUymQ3bTTAnIXtRrg0SU+6+s4khKSyL6LgWsSbZIODZjMSU1SfZWg/gkdkCiIT4o
	PjvnVEVi9qQRAt4NFnL2GkHWgGZ9n+aMTrqPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r97LIb+/22JcG53xy8VF3eKbvX/zVXLD
	n4Re4mMG1Fn3lZUndgoGb6y0R4czhkV4ZSD0DaronlceI17MEm5n1lqVAo3XE9gB
	+b5jS/NsX2QEvfABRxm/0S/03NEjRS6/j2heYX7VLnCMy7QnMOy5E5TcHFrFSP3H
	grd65bBbBRM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04940412E4;
	Wed, 11 Sep 2013 17:24:03 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE880412E1;
	Wed, 11 Sep 2013 17:24:01 +0000 (UTC)
In-Reply-To: <vpq61u7akin.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	11 Sep 2013 09:24:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F37A97A8-1B06-11E3-8644-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234583>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> But at the same time, I feel that these redundant lines, especially
>> the latter one, would give the users a stronger cue than just saying
>> that "bar is Untracked"; "do X to include" reminds that bar will not
>> be included if nothing is done.
>
> The one which draw my attention was "(use "git commit" to conclude
> merge)" which is particularly counter-productive when you are already
> doing a "git commit".

Oh, no question about that.  Nobody would object to the removal of
that one; it is clearly nonsense.

I was commented on the value of keeping "hints" like this:

      # Untracked files:
      #   (use "git add <file>..." to include in what will be committed)

The primary value of the hint in the context of commit message
buffer *NOT* being "what exactly do I need to do after I abort this
commit?", but being "Ahh, this 'Untracked' section is showing me
files that I may have forgotten to 'git add'".  If new users do not
benefit from the latter, I am perfectly fine with the removal, but I
suspect it may not be the case, hence my earlier comment.

And "the user can see these hints by running another 'git status'
after aborting the commit anyway" is an irrelevant counter-argument,
exactly because my point is that I suspect having them in the commit
template comment may help the users to *decide* if they want to
continue with or abort the commit.

But as I said already, I do not have a strong preference either way.

Will queue the two patches (but I see there are already some obvious
fixes suggested).

Thanks.
