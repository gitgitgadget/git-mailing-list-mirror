From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] grep: Add --max-depth option.
Date: Wed, 22 Jul 2009 10:08:44 -0700
Message-ID: <7veis8myqr.fsf@alter.siamese.dyndns.org>
References: <1248213064-1541-1-git-send-email-michal.kiedrowicz@gmail.com>
 <4A66BB64.5070106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 19:10:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTfKa-0006qT-IH
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 19:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbZGVRIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 13:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbZGVRIw
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 13:08:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbZGVRIv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 13:08:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C8DEFD9E;
	Wed, 22 Jul 2009 13:08:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8C3A0FD9D; Wed,
 22 Jul 2009 13:08:45 -0400 (EDT)
In-Reply-To: <4A66BB64.5070106@gmail.com> (Stephen Boyd's message of "Wed\,
 22 Jul 2009 00\:10\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 540AC336-76E2-11DE-B0B5-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123757>

Thanks for a review.  With the suggested changes the patch looks better.

I had to wonder what would happen when you give an input like this,
though:

    $ git grep --max-depth=1 t Documentation/howto

If you look at the way the loop in pathspec_matches() is structured, it
becomes clear that the depth limit is applied independently to each of the
pathspecs given on the command line, and re-reading the description of the
option in the documentation _with_ that knowledge it becomes obvious what
should happen, but I couldn't figure it out before looking at the code.
Perhaps the documentation needs a bit more verbosity?  I dunno.
