From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 05 Sep 2009 00:02:35 -0700
Message-ID: <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 09:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjpJR-0006ob-DB
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 09:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbZIEHCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 03:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbZIEHCq
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 03:02:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZIEHCp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 03:02:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B15C726881;
	Sat,  5 Sep 2009 03:02:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+nxCgr1xY27gGu3TJYKWnbVAxlE=; b=a+kuJc
	Rs5U4AitdTM8qW3cuZnWJXi1JXuXWZXSaumtmE9a2hgqEVQwjOZX0RLT8pSDxbV3
	eJ3X6xCHUIhNK2TQuIroRVmmIKqx/9dqVGOfBeM8+PiZFzZ/1WCiqQXIlJd1NGRv
	dkRYBpXbzyclp54abMXcDC/a1HCdMo8pYoDz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNlEcTBrr+xXkoXJvG3egenhBpwex6KB
	LS8YvNka6f8XU7vVVnIgVHM/CX3eOxTpJkPJlH9KULO7kWiAcKId9yY0ytHKMfOG
	Br5iOy5Dz/gno1H7o7j/lsKUEuLRUnEu1ruBwWOQ6iNjmD4WQUfhkZ5K3pSiC4kf
	Q84jvrGMKpU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7920E2687E;
	Sat,  5 Sep 2009 03:02:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A07E22687D; Sat,  5 Sep
 2009 03:02:37 -0400 (EDT)
In-Reply-To: <20090905061804.GB29863@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 5 Sep 2009 02\:18\:04 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B28198A-99EA-11DE-9F34-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127786>

Jeff King <peff@peff.net> writes:

> I suspect it is too late to change it due to compatibility issues. OTOH,
> I think the intent of v1.7.0 is to allow a few small breakages like
> these. You could always write an RFC patch and generate some discussion;
> I'm not 100% sure that there are enough people that agree with us to
> change the default.

The intent of 1.7.0 is to fix usability glitches and warts that everybody
has long agreed are problematic.  People have *just started* discussing
about this---it is not remotely close to "everybody has long agreed are
problematic" criteria.  It is too late for 1.7.0.

I agree that there are parts of git that is very whole tree oriented, and
the later "usability" part that are cwd centric.  "add -u" and "grep" are
examples of the latter.

I personally find "add -u" that defaults to the current directory more
natural than always going to the root; same preference for "grep".
Besides, "add -u subdir" must add subdir relative to the cwd, without
going to the root.  Why should "add -u" sans argument behave drastically
differently?

Speaking of cwd-ness, I sometimes find ls-tree irritating, but I think
this is in "if we had known better we would have designed it differently,
but because we didn't, because many scripts already depend on the current
behaviour, and because we have an --full-name escape hatch, we are not
likely to change it, ever" category.

If "git add -u ../.." (I mean "the grand parent directory", not "an
unnamed subdirectory") did not work, it would be unexcusable and we would
want to devise an migration path, but otherwise I do not think it is such
a big deal.  I would say the commands that are used to incrementally build
towards the next commit should be friendly to the practice of limiting the
scope of the work by chdir, i.e. they should be cwd centric.  On the other
hand, the commands that are used to review the next commit as a whole,
e.g. diff and patch, should be whole-tree oriented.

Oh, "git grep -e foo ../..", however, does not seem to work.  That might be
something people may want to tackle.
