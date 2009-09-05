From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 05 Sep 2009 01:23:50 -0700
Message-ID: <7vy6ot4x61.fsf@alter.siamese.dyndns.org>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
 <20090905072017.GA5152@coredump.intra.peff.net>
 <7v3a717rgl.fsf@alter.siamese.dyndns.org>
 <20090905080249.GA8801@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:24:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjqZC-0004ms-JW
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbZIEIYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbZIEIYF
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:24:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbZIEIYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:24:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B22226C77;
	Sat,  5 Sep 2009 04:24:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4aHnIbR+dJ4Vuz34voy/JXpiZA8=; b=CPSNhz
	+3VzHZQFrMTpJJ7ZAvTFFXTNvbTjHrZukvm7SaZtVUMx9SmJN0x7HOWlF/N+Fw36
	xAZA4snNEyclZTLde6Am7IXFiUBIl+2GdyCfmJjRIv4JyiX3PFtI9+3MUUJnI7sK
	Nx3mGzB7UlJOpFY6Q290hBYImuRxP++F+F9MY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tat18SIqo3WywJjuuJgxiRFWjjn6dSh1
	5MwbYCl2i1HDwcr2nBJ/4UT+sIjBwqZVU90zspFgIiD/XCP44ea1nBlJm0vomlnw
	5UumRlhoeMz14gbnZLpTnp7ioXPqUNxZbYhJZ7ipm+Xh90f3NVAx6t3uqVTAq+L9
	7qO0OZ2NUY4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57C3026C76;
	Sat,  5 Sep 2009 04:23:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B2CA26C75; Sat,  5 Sep
 2009 04:23:52 -0400 (EDT)
In-Reply-To: <20090905080249.GA8801@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 5 Sep 2009 04\:02\:49 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75FE6AF2-99F5-11DE-9537-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127795>

Jeff King <peff@peff.net> writes:

> I agree that we agreed to disagree. But there is still one open
> question: would you take a patch for a "full-tree" config variable that
> would impact add (and probably grep) for 1.7.0?

Unless there is a simple and sane way for script writers (and by "script",
I do not mean "Porcelain that is supposed to be written using only the
plumbing", but things like scripts you would give to "git bisect run",
which would freely use Porcelains like "git reset" etc.) to defeat the
configuration without much pain, I am fairly negative on adding any
configuration variable of that nature.

We could probably declare "In 1.X.0 everything will be relative to the
root and you have to give an explicit '.' if you mean the cwd".

Three questions:

 #1 What are the commands that will be affected, other than "add -u" and
    "grep"?  Are there others?

 #2 Do all the commands in the answer to #1 currently behave exactly the
    same when run without any path parameter and when run with a single
    '.'?

 #3 Do all the commands that are already relative to the root currently
    limit their action to the cwd when run with a single '.'?

If the number of commands in the answer to #1 is not too excessive, it is
a plus, but even if it is more than just several, we will be getting
consistency and sanity if #2 and #3 hold.  However, if there are even a
single violator in #2 and #3, we would need to fix them first before we
can proceed.  And the transition clock starts ticking after everything is
fixed (if such a fix is indeed needed).  As usual, I'd prefer to keep the
clock running for at least 6 months, preferrably longer, and during that
time, we may need the usual "You invoked me without any paths, but this
command will start behaving differently in 1.X.0, you have been warned."

A command line option to explicitly ask full-tree can be added anytime
without waiting for 1.7.0.  I do not think it will be ready for 1.6.5 but
we can always have 1.6.6 if needed.
