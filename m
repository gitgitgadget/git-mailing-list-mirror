From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-format-patch should include a checksum
Date: Tue, 26 Jan 2010 15:21:30 -0800
Message-ID: <7vljfkxxj9.fsf@alter.siamese.dyndns.org>
References: <871vhcmr5b.fsf@trurl.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Juliusz Chroboczek <jch@pps.jussieu.fr>
X-From: git-owner@vger.kernel.org Wed Jan 27 00:22:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZujU-0007F5-Hr
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 00:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab0AZXVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 18:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539Ab0AZXVl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 18:21:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab0AZXVk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 18:21:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BEDDF94C4A;
	Tue, 26 Jan 2010 18:21:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e15mS8DxVz8sa0M82Lubv9J9XL4=; b=bBeLLe
	XQg8B4VHBFli+atAdXs0QEYFkEwt1gMvFG8Xm+yuDzKtSuKG4aUhaUih3m6doETZ
	FhkmPr8gBBc9VuVwptIQjrhjDQyMgQ+VbOSKVSEW714CpETwf8pVETY/9wBbW/7a
	6Xbp9+r8HuOc6sOS5hZJENonHXcuaxHiyaUos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZkmqgJazVPL2xir+O8zvCLh+no00KDTw
	eWCdvzV6CvcyyHDiIUBsNZIGdi5+Noxo2QreJLhHfBDAYD6xgAXjHjHouYX2XcyJ
	4m718M7M5p6eP8RsIIej6ceg12oYuVo1keRxrnwp+fqmyX6Yw6KLXx71ZyDo74fK
	cfmYRSVAjI8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E6CD94C48;
	Tue, 26 Jan 2010 18:21:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EABB994C46; Tue, 26 Jan
 2010 18:21:31 -0500 (EST)
In-Reply-To: <871vhcmr5b.fsf@trurl.pps.jussieu.fr> (Juliusz Chroboczek's
 message of "Tue\, 26 Jan 2010 23\:34\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B46C66E-0AD1-11DF-AC62-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138087>

Juliusz Chroboczek <jch@pps.jussieu.fr> writes:

> I'm seeing Git patches being corrupted by mailers and still apply
> correctly.  It would be great if git-format-patch could include a hash
> of the patch body (and commit message); git-am should check the hash,
> and refuse to commit if the patch was corrupted (--force should override
> that, of course).

Do you have an example of such corrupted and incorrectly applied patches?
What kind of corruption are you talking about?

format-patch/am pair is designed to be lenient, allowing people to write
additional messages after the three-dash lines after the output is made
but before it is given to the MUA for sending the result out, for example,
so adding a checksum over the entire output and forcing a check upon
application is really a bad idea, even though, provided if the patch is
done cleanly, it might be acceptable as an optional feature.
