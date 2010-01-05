From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git add -i" with path gives "Argument list too long"
Date: Mon, 04 Jan 2010 21:31:02 -0800
Message-ID: <7vzl4t6ru1.fsf@alter.siamese.dyndns.org>
References: <36FEB8A0-968D-4B43-AEFB-9B0E227A1F88@wincent.com>
 <20100105041438.GB12574@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 06:31:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS20z-0004ne-T4
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 06:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab0AEFbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 00:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269Ab0AEFbP
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 00:31:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0AEFbO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 00:31:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCD638E00A;
	Tue,  5 Jan 2010 00:31:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bVTfDlELFRl9gov4CSNg27RZpKg=; b=wOo7bH
	gMspg7LU0cN/K1ffKx9pl+hXJcS7Vg0Ew0nGfnzgWh6BO+XU+KephNaDATrkd4WC
	5dSI2lPKw7cH1N63sfk7ZDBuIRRWOMNRFM3kvK/2+uncMM3pd/h0uUihuuashjnH
	Y1snHVFouaWUfL0HXn2ImBs+fhf4p8G8y8jk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=suFANYQUu9oPpSaETov4TuV8mSOV3EpH
	PUYKm3WOmjyKdXZLkmSuRTTiMxoDypi+2CPUZobcK6QDIFpi9rFRyV8nDCZFtAxb
	PeCBb+jLp5N+wViFLni0bIAAjw0trxj5PGWFoFrAMw6eH1uILJJSHwfusZwViILo
	TCfU3DCtm8E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 847788E006;
	Tue,  5 Jan 2010 00:31:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF35B8E005; Tue,  5 Jan
 2010 00:31:03 -0500 (EST)
In-Reply-To: <20100105041438.GB12574@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 4 Jan 2010 23\:14\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 864D9A74-F9BB-11DE-AF1A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136163>

Jeff King <peff@peff.net> writes:

> I seem to recall Junio noting in the past the inconsistencies in git
> about what is a path and what is a pathspec. Is this one of those
> inconsistencies, and would it be a positive thing to fix it?

We actually never take paths and everything we take is pathspec.  One
longstanding gripe I had around this area is there are two kinds of
pathspecs.  "diff-tree" family of pathspecs only match "leading
directories" while "dir.c" and "builtin-grep.c" pathspecs allow both
"leading directories" and "glob" pathspecs.  Teaching "diff-tree" family
to also grok globs would be a very nice thing to do, and the listing of
paths with ls-files in the sample patch you are removing is indeed a
workaround for this issue.
