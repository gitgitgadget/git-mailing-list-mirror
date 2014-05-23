From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/3] Add --graft option to git replace
Date: Fri, 23 May 2014 09:59:05 -0700
Message-ID: <xmqq7g5cl9d2.fsf@gitster.dls.corp.google.com>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri May 23 18:59:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnsoT-0005ce-K2
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 18:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbaEWQ7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 12:59:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64212 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753419AbaEWQ7M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 12:59:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5430183E9;
	Fri, 23 May 2014 12:59:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5uNPPgY5AcnZ+d92KuvEmzwoqfg=; b=PuYxF9
	79o/J8qhNOvCSVwPtFOrjHzOqn/ags7PFashEeuTCl8tVYhRXpd2l7LhxP/HfxI6
	HqnUK4jnq1uCCw/gktBd3TvVxzLnNxNFfvCEjXehekO4jVb2HpQ6MIZdCTcpAHqb
	GcEiChjqAPkL3gS734V/Y9EMVDPWKu4x3VvHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yHkgSrGjP+3ZxGaqb9rz7L6tFWXgmyo7
	Pr1lSlU3BywOoMZ4NbZY7/VgmS/wRK49rNnOMcIzsuxHd3LYFF0idkr+rzsgJNd2
	koi0XfCLWjSnqjFzfkP07Y+UmndJfn1v7u1saciu2CKRrMwNwZ4GgOR14zTp858v
	p5f0Fp3txn4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3C96183E8;
	Fri, 23 May 2014 12:59:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 68022183E1;
	Fri, 23 May 2014 12:59:07 -0400 (EDT)
In-Reply-To: <20140522211836.27162.80311.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 22 May 2014 23:33:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8D94CA00-E29B-11E3-9603-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249998>

Christian Couder <chriscool@tuxfamily.org> writes:

> Here is a small patch series to implement:
>
> 	git replace [-f] --graft <commit> [<parent>...]
>
> The changes since the RFC/PATCH are the following:
>
> - in patch 1/3, parse_commit_buffer() is now used to
>   make sure <commit> is not corrupt
> - patch 2/3 add some tests
> - patch 3/3 add some documentation
>
> About the documentation, maybe we should add that --graft
> can now be used instead of grafts in .git/info/grafts,
> and maybe we could add an example that shows how it can
> be done.

Or a procedure that reads .git/info/grafts, converts it to a set of
replacements and drops .git/info/grafts.  A sample script could be
thrown in to contrib/ somewhere as "convert-graft-to-replace.sh".

> Christian Couder (3):
>   replace: add --graft option
>   replace: add test for --graft
>   Documentation: replace: add --graft option
>
>  Documentation/git-replace.txt |  8 +++++
>  builtin/replace.c             | 84 ++++++++++++++++++++++++++++++++++++++++++-
>  t/t6050-replace.sh            | 12 +++++++
>  3 files changed, 103 insertions(+), 1 deletion(-)
