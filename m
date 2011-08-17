From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Branches & directories
Date: Wed, 17 Aug 2011 12:14:08 -0700
Message-ID: <7vvctvdf5r.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
 <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Evan Shelhamer <shelhamer@imaginarynumber.net>
X-From: git-owner@vger.kernel.org Wed Aug 17 21:14:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtlZB-0001pb-5w
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 21:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab1HQTOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 15:14:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974Ab1HQTOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 15:14:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 301BA4143;
	Wed, 17 Aug 2011 15:14:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=f9SsOlK+/j44OT58AagoBXVaS8Q=; b=yFgUb4e8lqdv1qfpky2E
	WoVP7fUd0zxcYTayjuG2vGkcaAFZpOJtcxtt8Qj98QfPLpFQ/q95qCzFRZnCsJr5
	3ZBDl8gYY+VwLPaNMMUjxwbzI3DJ6olZUQ9g0stTd2jn6Fh+Ge/JtdsSGUCgjhP9
	3EAtSigOpYY9pTuiWR0swjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aIW9OKZ6yHWRKmW8aWhXv33/ggMDR2etqFWEpfPdtglTmR
	MK/wyTw/ZY8vlCDkZbQhmmEf5M8KGjvjlRqaSM8LIgcknf7Ca9GXqPphc3DDPT3U
	K0Rx2e/velpX2LLaJ/Fkva+jVRmMq+37s+JXDlfAMX3/r6L3Z43FQBIdMEu48=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2543D413F;
	Wed, 17 Aug 2011 15:14:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95688413E; Wed, 17 Aug 2011
 15:14:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15A4794E-C905-11E0-89AB-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179528>

Evan Shelhamer <shelhamer@imaginarynumber.net> writes:

> (in repo on your branch)
> mkdir test_dir
> touch test_dir/.gitkeep
> touch test_file
> git add *
> git commit -m "test commit (with directory)"
>
> Will commit the directory as expected in your branch, and when you go
> to checkout another branch it will not exist.

... unless you have untracked files in test_dir/, that is.

If the branch you are switching to does not have anything at test_dir, you
will not lose the untracked file because git does not remove test_dir/ nor
its untracked contents.

Depending on what you have at the path "test_dir" in the branch you are
switching to, the actual rules are a bit more subtle than that, though.
