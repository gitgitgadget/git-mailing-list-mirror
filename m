From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-update-index: report(...) now flushes stdout after 
 printing the report line
Date: Tue, 05 Jan 2010 17:04:07 -0800
Message-ID: <7vwrzwoxh4.fsf@alter.siamese.dyndns.org>
References: <loom.20091119T221732-624@post.gmane.org>
 <loom.20100103T114055-16@post.gmane.org>
 <be6fef0d1001031503h11cb65c6ha34eee345b9b7055@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Thiel <byronimo@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKK1-00064g-0n
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055Ab0AFBEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962Ab0AFBEU
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:04:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab0AFBET (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:04:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E25EA8E23B;
	Tue,  5 Jan 2010 20:04:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=1is4Dp7ITCttngpfda1B3E9vScU=; b=Y7pVSlKCgFKgcsDI2Fcub/q
	knXl1hfa53c0qqYzUQ6AWSWPRgn467BvPbFnJEyimH8w9w64yoVqvHbim4jCGhiC
	n6C4NpPJSWqoOR8TeCuxwoE1jcUFoe7dXql4DhpoY6ypYVKFIbWEoJlHIcwmGBFC
	ny7PJPfsDj6qSc+RWVZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OQ2j1bhfQb4WLYBlP1+Eoyf+0ER7Yo1uJT4ShUaLW+T4QSJ9x
	49jHS0D8A4uceGRaAKmqNB++xjZRwZESrU8Kh4x0gPEMpEQLLDZLqpym98FUiDOh
	uwJyf5QCn0bu3bPzUxKxfrg/IxhbLHsNXsrhakc2q2igHgS98oRqT6UkhE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 890EC8E239;
	Tue,  5 Jan 2010 20:04:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76D798E230; Tue,  5 Jan
 2010 20:04:08 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67A22186-FA5F-11DE-AD0A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136225>

Tay Ray Chuan <rctay89@gmail.com> writes:

> from your above message solely and setting aside your original patch,
> I presume that you want to introduce the ability to force progress
> reporting even if stderr isn't a terminal.
>
> I am working a feature (display progress for http operations) that
> happens to add this ability to git-push and git-fetch, by specifying
> the --progress option.
>
> Regarding git-pull - I guess it's only git-fetch (being
> transport-related) that reports progress?

Are you talking about this topic?

 * tc/clone-v-progress (2009-12-26) 4 commits
  - clone: use --progress to force progress reporting
  - clone: set transport->verbose when -v/--verbose is used
  - git-clone.txt: reword description of progress behaviour
  - check stderr with isatty() instead of stdout when deciding to show progress

What do people think about it?  I vaguely recall that somebody asked to
add a warning to release notes on the behaviour change to this series, and
I think it may be a worthwhile thing to do (e.g. "Earlier we did X but now
we do Y; change things in this way if you want us to keep doing X"), but
otherwise I think it is a sensible change.
