From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] stash: Don't overwrite files that have gone from
 the index
Date: Sun, 18 Apr 2010 16:11:21 -0700
Message-ID: <7vpr1wtkyu.fsf@alter.siamese.dyndns.org>
References: <9eaa7a4672f2010c9e6e3b3f473f1c09abcfcc45.1271614677.git.charles@hashpling.org> <20100418182805.GB29329@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jeff King <peff@peff.net>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Apr 19 01:11:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3deY-0000y2-7E
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 01:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298Ab0DRXLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 19:11:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755718Ab0DRXLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 19:11:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57A7EAC9F3;
	Sun, 18 Apr 2010 19:11:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=0YV0OW0RYk4Sfe0a4FWEUsHzYQE=; b=oEMolmBuwOGVMnhlaAQkU6u
	Xk3wfJlydNs/hBkK2KAghfeToatGpdfp7FmrfhlW9P1Y+vJ4Bhf5DgWIHI5JUY24
	+QShtgfxFn8IG3C/cwQ6BPRnLb8G78bpeNacyBDteuGGCIxvaMe4beXV0AULi1bR
	/Fpei4qdHdCo4KxSESM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JdFrzFJsNmypeG4Uw7N0bP8hoyQ8DWauHMfd2CeuZZlUuG6Ml
	UpSRs0YgKSKuKyf5Y2GCwtJp9LuYWRkHqlYzIXPzVVmUCIFbWh9sIOVYPCEzyIXq
	Q2LkRh029bZ/k31Z+yo2Y7RZ0O3lVhIK36/y2R0ytxnR0wiDZ5aqurxPHs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10324AC9F1;
	Sun, 18 Apr 2010 19:11:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44C4DAC9EF; Sun, 18 Apr
 2010 19:11:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B70AD6E2-4B3F-11DF-BF2B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145257>

Charles Bailey <charles@hashpling.org> writes:

> To be complete, any work tree file which differs from HEAD needs to be
> saved, regardless of whether it still appears in the index or not.

Sounds quite sane.

> -			git add -u &&
> +			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&

Paths that exist in HEAD but not in the index will be caught with this;
what about paths that do not exist in HEAD but is in the index---they will
be kept in the index so they are fine as well.  Good.

Thanks.
