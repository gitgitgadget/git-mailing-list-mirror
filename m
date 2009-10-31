From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit -c/-C/--amend: take over authorship and restamp
 time with --claim
Date: Sat, 31 Oct 2009 14:24:17 -0700
Message-ID: <7v7hub5kam.fsf@alter.siamese.dyndns.org>
References: <1256958480-6775-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 22:24:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4LR2-00060g-Iw
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 22:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933276AbZJaVYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 17:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933249AbZJaVYV
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 17:24:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933224AbZJaVYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 17:24:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5804A8D65C;
	Sat, 31 Oct 2009 17:24:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1gjJA4qvSHJQk0sH+prnZODrpNo=; b=m23eXc
	8cmCTw5+2Bn2Yw0gKnm9BJw4D2nLINPV0E9EVk//65kyt+h+n5dfjdyzRSf1l4p8
	2OqXtSsyRb68Ebo/NxoeHMJCbxy22NqZRG5z3iFFtrFaPwIhuSE9jmERJKtGDHCu
	ceQCV4anzsF21Hx1lR3pFRza8Di59iyMMejFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yy7Lt6lUQEAok1G+CcnmeOZ+KmIW2Hik
	YDGe2PMaeXsYSUBCnC2vKi3jAeVS6kcBv3pGILq7YhZH7BLNQ19WLtp7VVquNSfe
	+8jcCyhS01uFUdNgMPoD4m9+rKtqk1bDaEpWkg4iv6VB1rtfXoUURtzzf3V8hkFk
	y1alvtPCsN4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3BA298D65B;
	Sat, 31 Oct 2009 17:24:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4EA2E8D65A; Sat, 31 Oct 2009
 17:24:20 -0400 (EDT)
In-Reply-To: <1256958480-6775-1-git-send-email-erick.mattos@gmail.com> (Erick
 Mattos's message of "Sat\, 31 Oct 2009 01\:08\:00 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C253C88A-C663-11DE-AD89-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131859>

Erick Mattos <erick.mattos@gmail.com> writes:

> The new --claim option is meant to solve this need by regenerating the
> timestamp and setting as new author the committer or the one specified
> on --author option.

I'll leave discussion on the option name to others.

> +--claim::
> +	When used with -C/-c/--amend options the committer takes over
> +	the cloned commit authorship and renew the timestamp thus using
> +	only the commit message from the source.

"The cloned commit" is a bit misleading; in the mind of users --amend does
not clone but rewrite, as the old commit usually only belongs to a reflog
and not any other branch.  I'd rewrite it this way, perhaps.

	When used with -C/-c/--amend options, declare that the authorship
	of the resulting commit now belongs of the committer.  This also
	renews the author timestamp.

We also would need a test to protect this new feature from getting broken
by future updates.

Thanks.
