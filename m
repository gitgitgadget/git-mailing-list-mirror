From: Junio C Hamano <gitster@pobox.com>
Subject: Re: force "unmerged" for same-file auto-merges
Date: Fri, 26 Mar 2010 12:29:16 -0700
Message-ID: <7vtys2lw4z.fsf@alter.siamese.dyndns.org>
References: <hobqoc$5h3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 20:29:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFDn-0000rS-Mr
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 20:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752Ab0CZT31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 15:29:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab0CZT30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 15:29:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 158D0A520F;
	Fri, 26 Mar 2010 15:29:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sduPHn3nIDN5iQrhbXgSqw97Nd4=; b=kfo1Fo
	deTRVvPghQxine4HnazEP8ntTu52q/hl1yQlRLuPJ8TEq1ySKGI8bxG58reeJoBs
	qEaMDGEZWH2s5P9osdL4FEJqqjbS95YFlFEcO2mgAX9qF7tehPItYQ5kw6CH1Y3V
	cHulsLqDVME2l+DlvVsFjKPELARIf/mCwBjus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ufyVRciN1kHc2E1R1qLzOvBDR9LJoMup
	5ds0cd7lYEuAdCwpYGsxcYB7gGnvVcxE1UdfXjeuqgr7/2IdHaRoBcP0fV0kaSxc
	ZfcVQx0zYZtMkCkhAxUhKnDx9Xsr/XzgpL92dxbs6gcZAGOyAn54Tip70Sot9xnp
	ZaAbuRBCEwU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1F08A520C;
	Fri, 26 Mar 2010 15:29:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84117A5207; Fri, 26 Mar
 2010 15:29:17 -0400 (EDT)
In-Reply-To: <hobqoc$5h3$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Tue\, 23 Mar 2010 20\:44\:05 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E0599A86-390D-11DF-9901-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143267>

"Neal Kreitzinger" <neal@rsss.com> writes:

> Does anyone know if there are configuration and/or command-line options in 
> git that can accomplish this in a fairly straightforward manner?

I know there isn't.

Essentially what you are asking for is

    read-tree -m -u --trivial O A B

followed by no file-level automerge.  I think you can write a custom merge
strategy, perhaps using "resolve" as a template, to do that.

In practice, you will get too many false "conflicts" with such a strategy
and the quality of your "review" would degrade from fatigue, I suspect.
