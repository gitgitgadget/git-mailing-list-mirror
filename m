From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] t7006-pager: if stdout is not a terminal, make a
 new one
Date: Fri, 19 Feb 2010 22:53:42 -0800
Message-ID: <7vaav42ya1.fsf@alter.siamese.dyndns.org>
References: <20100219065010.GA22258@progeny.tock>
 <20100219072331.GG29916@progeny.tock>
 <20100219080819.GA13691@coredump.intra.peff.net>
 <20100219081947.GA12975@progeny.tock>
 <20100219083440.GC13691@coredump.intra.peff.net>
 <28d--OB9y5MtIy1nJel2Km6d5sqJ3yX6fVUhecDU5ehJUYJmZlE0-A@cipher.nrlssc.navy.mil> <setkR9a6yaRMOU11ekUmlY6ty8nNSPCcidBKotdDxpQsZLCxc54hKw@cipher.nrlssc.navy.mil> <20100220003950.GA18550@progeny.tock> <ee63ef31002191942h7fbbb6bt627cd36ea343e606@mail.gmail.com> <20100220052504.GA24697@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 07:54:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NijEM-0000KP-JC
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 07:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab0BTGyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 01:54:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab0BTGyE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 01:54:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84485984C6;
	Sat, 20 Feb 2010 01:53:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mD6iwBNpqTPfBYWU56zyrpLF3DM=; b=KJFOxA
	xh3wvSRqbDE8yCRzVbjWku/o5oEB3l7rih3Yiu2l1JfVhQ5Omv/ZpKkjVjnG7hBD
	W1yiBoV1vPSoeGVEYVFtVqUuuzIGYDXCudcsl8W9IoeGLu3+aS1yJ/KPrMxFuyEj
	G7bQe1IH2aOhYK5PA36cfuehT/g8sNN6qi8WE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JebDUc65B3MUnAixk6EsCyfxQMB1qT6w
	E+wnsIxVJnhr1ieLWiqPNjVOmDWvAA9yrwPyoWBWHHlD2x7AfSEst3mNCYAhTzkr
	J9QAVZ1iAsSApmGuVwarO3k1zLVGAyvRjylFErgmY+59j5U2fffg/WBvr/7DN3CD
	/uCtKj2Pb9I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C7D5984C5;
	Sat, 20 Feb 2010 01:53:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40E37984C3; Sat, 20 Feb
 2010 01:53:44 -0500 (EST)
In-Reply-To: <20100220052504.GA24697@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 19 Feb 2010 23\:25\:18 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B4DC36DE-1DEC-11DF-855B-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140517>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  - Create a new pseudo-terminal on the fly and capture its output.
>
> This patch implements the third approach.

Yuck.  You must be having too much fun ;-).

> On non-Unixlike and pre-SVR4 systems, this functionality should be
> disabled by passing NO_GRANTPT=YesPlease to the makefile.  I do not
> know whether Cygwin or HP-UX implements the required functions
> appropriately, so to be safe this patch includes that option for them.
>
> On platforms where test-terminal does not work, the test script will
> maintain its old behavior (skipping most of its tests unless
> GIT_TEST_OPTS includes --verbose).

If we are truly serious about doing this, it might be worthwhile to check
how expect (http://expect.nist.gov) does this portably.
