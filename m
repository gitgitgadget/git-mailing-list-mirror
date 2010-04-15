From: Junio C Hamano <gitster@pobox.com>
Subject: Re: failed to lock
Date: Thu, 15 Apr 2010 15:27:26 -0700
Message-ID: <7vbpdkic6p.fsf@alter.siamese.dyndns.org>
References: <j2o76718491004141349l53b53347v7f4c0edcab69e4c2@mail.gmail.com>
 <t2i76718491004141402h33bb2044g155ef1715c63904e@mail.gmail.com>
 <k2x76718491004142100v6e1ece6djc62aa540e51eed5@mail.gmail.com>
 <7vd3y0k0c6.fsf@alter.siamese.dyndns.org>
 <k2j76718491004151213xdb223ff8kd43f170eaf3a470a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 00:27:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2XXF-00051d-5q
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 00:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717Ab0DOW1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 18:27:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523Ab0DOW1e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 18:27:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB461ABA66;
	Thu, 15 Apr 2010 18:27:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rU6ASTLDac+b/gJQExEQW6LbN2s=; b=Frk4gp
	1KHjTWrfZzHcARk8qHoFm+7c2oQFCOxPzsBdNlhTJRNqIYNtJy23R4Vb+1wQBBFK
	+nG8lWYxvYwKIvxvkJwMgTHxCWSQzo2YnVSPS+RNu58mYzC4N6jJHXkGDgwCYUC9
	dso5umyp/bAAHqiQ1AyDwpcrpZ6+jcvCPlDl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/b5peyPY8jUouYJ3YFvxXkedKE54YLO
	RIt3ixrxNzAE7Lp+f90Hxv2atFu0TyyQ5f5P2pd4Svp8wRvXhApNy5jGBTcEZKE3
	lgBj3UsQr5jUXkO1R8qroi3aEJYxQWcIqbAgB3E9hTJAUfnsMspnHnAAtHxDn+6v
	H9dTcS38xJA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B9C1ABA65;
	Thu, 15 Apr 2010 18:27:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1320CABA63; Thu, 15 Apr
 2010 18:27:27 -0400 (EDT)
In-Reply-To: <k2j76718491004151213xdb223ff8kd43f170eaf3a470a@mail.gmail.com>
 (Jay Soffian's message of "Thu\, 15 Apr 2010 15\:13\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 145E9E64-48DE-11DF-A842-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145029>

Jay Soffian <jaysoffian@gmail.com> writes:

> So it seems safer to me that the destination should ignore duplicates
> in the received list.

We probably need it on both ends.

On the receiving end, it probably is a better idea to make verify_lock()
succeed if the ref has already been updated to the value we are going to
update with, as I suspect that the issue is not limited to receive-pack.
It needs some restructuring of lock/verify/commit primitives, though.
