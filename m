From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] submodule: drop the top-level requirement
Date: Tue, 09 Apr 2013 14:00:52 -0700
Message-ID: <7vobdnpgfv.fsf@alter.siamese.dyndns.org>
References: <cover.1365364193.git.john@keeping.me.uk>
 <cover.1365539059.git.john@keeping.me.uk>
 <4a6394e9e7124c2ad5a3ce232dc746e85cb1c600.1365539059.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 09 23:01:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPff1-0007fb-UP
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 23:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936364Ab3DIVAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 17:00:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34766 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936020Ab3DIVAz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 17:00:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCCAC150C5;
	Tue,  9 Apr 2013 21:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r/SxL8VnzJ16DVBTkXQ92+3XJGk=; b=cpwoQD
	rK1lwbjokCtLnL66wGcNoV0VOlqU8ASDYdSbxtwxskCx5Vw9rpWl1xLGL4e5/Vl8
	QYUUHYIIAWDLy7LceJPGU63vIvHhYDDmVi3XQX4iu+7eRk4XRFc2t5VhJn2ROh2q
	EuJNl603CO42F5AdazuGJ+6w3QR17tdD3OMHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m6behjpcF0khWAuRj6+j0uMCDi0MjG5J
	zmZ2PmtecI7VPZ+gc4n27Y2/mrEN7UjUzcmr5uBrqRzCxB5v5MRGtm9bg06BvHK2
	TA74/WJ2NJt/1h77lkqcJUrzskahAPTW0Q7RSDYEy5t+b5OLhPU3966u8kaHTGeH
	LDn37lz13Rs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4C22150C4;
	Tue,  9 Apr 2013 21:00:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26E03150C3; Tue,  9 Apr
 2013 21:00:54 +0000 (UTC)
In-Reply-To: <4a6394e9e7124c2ad5a3ce232dc746e85cb1c600.1365539059.git.john@keeping.me.uk>
 (John Keeping's message of "Tue, 9 Apr 2013 21:29:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91502868-A158-11E2-9A4C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220634>

John Keeping <john@keeping.me.uk> writes:

> +	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"

This may be handier than having to do the "for arg" loop git-am uses
yourself.

>  	(
>  		git ls-files --error-unmatch --stage -- "$@" ||
>  		echo "unmatched pathspec exists"
> @@ -335,6 +339,8 @@ cmd_add()
>  		usage
>  	fi
>  
> +	sm_path="$wt_prefix$sm_path"

But this is doing fine without "rev-parse --prefix" at all.
