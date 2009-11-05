From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Automatically remote prune
Date: Thu, 05 Nov 2009 12:05:13 -0800
Message-ID: <7v3a4sagau.fsf@alter.siamese.dyndns.org>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
 <7v639qi2un.fsf@alter.siamese.dyndns.org>
 <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
 <7viqdpemki.fsf@alter.siamese.dyndns.org>
 <43d8ce650911050005l6d120cb0h374f3c04b3948b25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:05:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N68aI-0007tC-9D
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 21:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758841AbZKEUFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 15:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758820AbZKEUFQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 15:05:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758763AbZKEUFP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 15:05:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52BF375A25;
	Thu,  5 Nov 2009 15:05:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=YrVW+pb1F3ROiE3FdjPnEDe16A0=; b=fRjqdl
	TPM/Ubp/fKUdQjvzlWdlIg+O7GaeYeSvjO9fpwVgOWLB7QYvqxkV9m5EgqnJLqIP
	Ysja8XJVChbA/ugKi/DUmgNWLMfpLdMCWBA0yXXc5W2lO3NifkkV0YpPlDMcvX5l
	SFT5hdr+GRbpkEMiBVJxv385oNH6aDFU97DhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bmJB6yztpVnZUN1ENL7mRkPWRqcSPjj6
	rDDcACp3zA9XUHsbHgHQZVCsczBa0hAZPqPvVZeQFXoORHtztHbAjoqfxhueeCjv
	FUiRS88REvSBascswb6FMgy2dLZmQuL8SLitgg9+Ioyd7AOawY73neTkkKlYPW/G
	nRXsvXjcUdw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3460075A23;
	Thu,  5 Nov 2009 15:05:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FE3575A1C; Thu,  5 Nov
 2009 15:05:14 -0500 (EST)
In-Reply-To: <43d8ce650911050005l6d120cb0h374f3c04b3948b25@mail.gmail.com>
 (John Tapsell's message of "Thu\, 5 Nov 2009 17\:05\:50 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A24822E-CA46-11DE-9C82-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132240>

John Tapsell <johnflux@gmail.com> writes:

> I omitted it just because, imho, it's not what I 'care about'.  I'm
> not trying to help advanced users (Users that _want_ to keep
> remotes/origin/* clean and users that _want_ to be careful to not lose
> commits are both advanced users, imho).  I'm just interested in
> reducing confusion for non-advanced users.

I _think_ you are saying that your non-advanced users expect "branch -r"
output to be in sync (to the extent possible without going over the
network every time it is run) with the remote side. It is the same thing
as keeping remotes/origin/* free of stale remote branches, i.e. they are
in the first camp.  There is nothing advanced about either of the camps.
The former wants the view to be in sync, the latter wants a way to avoid
information loss.

It is understandable to expect "branch -r" output to be in sync with the
other end, especially if one has CVS/SVN mentality but even if one
doesn't, I would say it is a reasonable thing to expect.

I am open to an optional feature to "git fetch' to prune them, but I would
not make it the default from day one.  When introducing a change that
causes information loss, our migration strategy has always been "Give an
option first, release and wait for two releases or so, and then start
discussing to change the default behaviour."

The necessary change to "git fetch" shouldn't be too hard to code, as we
are already doing this in mirror mode.
