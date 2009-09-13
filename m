From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merge ignores --no-commit in fast-forward case
Date: Sun, 13 Sep 2009 00:30:49 -0700
Message-ID: <7vocpfz4gm.fsf@alter.siamese.dyndns.org>
References: <A754ACF1-77C2-4036-A15C-8949E76BD2D5@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 09:33:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmjaL-0001LU-90
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 09:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbZIMHa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 03:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbZIMHaz
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 03:30:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbZIMHay (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 03:30:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F6B530C08;
	Sun, 13 Sep 2009 03:30:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MUvLv4M9ew3Ka8EAIjA94QDjcVU=; b=PcnWU2
	xpyxIlKlxbwat+DmYtf5bc1YkwN6DNCc/mMF2NP2KSKh7i41G4wVtFWLUufjm42z
	C7+Va4Csvz5dv7cQHEuf/f33VY1a91UojxYCFYuWfTA8JQ3tGwkUzvzrAQ5yOJBM
	XGZ9ySCZqIimFwJ3Ef07lxOhnWlUISyMiVzBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixFipTzN6ny+B2GKtTNolW+/Vy5gm1hk
	0wqIhDvojrGE8ya6SxbvqiBeNLc35QV80fVkgk7jotmhLjG+xt9ZMQJCuk6Mjp3O
	Rw2yJEKKEHrW4+T57tmkoudzlZbTX3X580ofUISU2Sy7LuERVjPvq3I0RKCXWB3E
	soX4Evmdrm4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53D5C30C07;
	Sun, 13 Sep 2009 03:30:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C71E430C06; Sun, 13 Sep
 2009 03:30:50 -0400 (EDT)
In-Reply-To: <A754ACF1-77C2-4036-A15C-8949E76BD2D5@dbservice.com> (Tomas
 Carnecky's message of "Sun\, 13 Sep 2009 08\:40\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5E48B9BA-A037-11DE-9BD9-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128342>

Tomas Carnecky <tom@dbservice.com> writes:

> Bug or feature?

Feature, perhaps a misleading one.  As a fast-forward merge does not _create_
a commit, and --no-commit is about not creating a commit, it is logically
consistent.  But it is not useful nor intuitive to be logically consistent
in this case.

> Three possible solutions that I see:
>
>  2) Refuse to do anything if user gives --no-commit and merge is fast- 
> forward
>  3) Document this behavior in the manpage
>  4) Quietly set deny_non_fast_forward when --no-commit was given

Heh, this is new.  People laugh at me when I number my bullets starting
from zero, like all good computer scientists do ;-)

Seriously, we should at least do #3, and as a backward incompatible change
at least _consider_ doing #2 (I think #4 is merely an implementation detail
of #2), and if list reaches concensus in favor of such a change, come up
with a transition plan and do so in the 1.7.0 release.
