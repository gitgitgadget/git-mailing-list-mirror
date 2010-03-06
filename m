From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for git format-patch --to and format.to config
 option
Date: Fri, 05 Mar 2010 18:21:42 -0800
Message-ID: <7vr5nykx55.fsf@alter.siamese.dyndns.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
 <20100306003946.GD27414@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Mar 06 03:22:02 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnjeQ-0008Ub-0X
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 03:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab0CFCVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 21:21:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab0CFCVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 21:21:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 924559FCBF;
	Fri,  5 Mar 2010 21:21:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J6l3jwjPllfV9s45EXSglu/dXtA=; b=ve49c5
	qUlodZIpHPZFnQJPMnGTVVOkonoPVp9ZZsRwveh7RbN2BAFIWG4Bhe2GtWhfKWXb
	/JAxZ0abhyLNLBdP0XC/bNQ3fiEWQVZOoaL+QrhbBC37ZCNOf8MFW3h4+Lsmn72Y
	wdxYVCdPzXXPCr7TJhOnRlkXRscGV47G9jWuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J8gCIdC7v7zAg3my0b44asD6RFaRmT+g
	nEbnRUI9eoyJPxu7sCqi9EvIbRs8VQEjpXtsgjcLEXojgHsNtj92TMXSDgNPs4XS
	qbeRLC8976cPJwyZP8jwt3edNp0jVZ6fllxmDEMzQHKyIod1eaubSj3wUBoyYYIR
	8G1KXNgPT4o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 563F49FCBE;
	Fri,  5 Mar 2010 21:21:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96E8F9FCAD; Fri,  5 Mar
 2010 21:21:43 -0500 (EST)
In-Reply-To: <20100306003946.GD27414@genesis.frugalware.org> (Miklos Vajna's
 message of "Sat\, 6 Mar 2010 01\:39\:48 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03E1A93C-28C7-11DF-A731-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141603>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +test_expect_success 'additional command line to' '
> +
> +	git format-patch --to="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch11 &&
> +	grep "^To: R. E. Cipient <rcipient@example.com>,\$" patch11 &&
> +	grep "^ *S. E. Cipient <scipient@example.com>\$" patch11
> +'

This reveals that --to does not follow the usual rule to override
corresponding configuration.  Is that really what we want?  IOW, when the
command line says scipient, shouldn't we stop sending to recipient that
comes from the configuration?  How else would a user override this?

So I guess the topic wasn't ready for 'next' yet, after all.

Thanks.
