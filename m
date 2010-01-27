From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Testing if a certain commit is in the current branch
Date: Tue, 26 Jan 2010 23:24:23 -0800
Message-ID: <7viqaorowo.fsf@alter.siamese.dyndns.org>
References: <201001270819.39819.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Wed Jan 27 08:24:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na2GS-0006j1-Vs
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 08:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab0A0HYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 02:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348Ab0A0HYd
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 02:24:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab0A0HYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 02:24:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D78AF94876;
	Wed, 27 Jan 2010 02:24:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lf0lnThlshyw26lxxJ4K4UuB+hM=; b=VqpwCw
	rZc4KERAPaecqMgJ2lumkELSoMlazLBrIr+knZQw9BvFhoYgohUhDwGoNqsQtUjU
	PT3BPGep9ZX9SwvOoljY12ajQKx5bbVtrc5FH21V3No37nIH6yZXBsoOEJRfI6LQ
	CxI8nezcLpghPjFXgxE+3ENg6O/8eeI/Du/t0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fBq2JRzbZGZPBagsXfHrq3ETueTSa/m6
	CHVKrPJm/20Nt4V01lqB/6D/A4AxVxDoPnksNDNkQZdhGci7CSlqFcEk2jxKHQv9
	9bjNNSJR0Wa6ZqIfn9xPwWX+bs0iTToUZlgCKaO8CqTMgQmcknsDxq8AWQDmZmG1
	vzEEqFrPDEo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0CBE94874;
	Wed, 27 Jan 2010 02:24:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A38F94872; Wed, 27 Jan
 2010 02:24:24 -0500 (EST)
In-Reply-To: <201001270819.39819.elendil@planet.nl> (Frans Pop's message of
 "Wed\, 27 Jan 2010 08\:19\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 009C5B7A-0B15-11DF-8135-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138111>

Frans Pop <elendil@planet.nl> writes:

> I'm currently using the following command for this:
>    git log --pretty=format:%H | grep -q '^<commit id>"
>
> Problem is that with large repos that can be quite slow.
>
> Is there a faster way to do the test?

test "$(git merge-base HEAD $commit)" = "$(git rev-parse $commit)"

But this is a literal answer that could be a less than optimal solution if
you are having an XY problem.
