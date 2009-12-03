From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Documentation: set a base URL for relative links
Date: Wed, 02 Dec 2009 18:16:08 -0800
Message-ID: <7vy6lk7qfr.fsf@alter.siamese.dyndns.org>
References: <20091203015005.GH23717@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 03:16:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG1F2-0004NP-7g
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 03:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbZLCCQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 21:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbZLCCQK
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 21:16:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbZLCCQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 21:16:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44965845C3;
	Wed,  2 Dec 2009 21:16:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fw3DIzSbSfGtSkyhHWs11Ca/t0I=; b=T5/zCY
	vcZUZZNvUQSzNWWlufmC8wZL9ejWSOjCSaGSLpQp7ofPBKTR3SgaYColRpzVUugo
	nZmFNGXYbHvW3CKYRMrQl5VwojeKwF7o3cdsY80rR6gjimmI8GLoZaENa1jfcbNy
	I/85g6W9vRgmNEqT5+rjUsC2sI/utIk7rbs1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vfVVjg8JvP/bDYbk6j8rBbNg2qaavyOs
	0PTt9jNBZr7Oae0wbIjNFz5VpcVMb7q7i0ChO1n2KeX2C6uXTD88Myv3beHyCmIF
	svYgDddIJCBOzJaFYSmzAlwy50ccCeNWsRL9MH6WMMuuVb26KxHSCE9yW8ufi4WU
	l+tWSYkgSmg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23292845C2;
	Wed,  2 Dec 2009 21:16:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78708845C1; Wed,  2 Dec
 2009 21:16:10 -0500 (EST)
In-Reply-To: <20091203015005.GH23717@inocybe.localdomain> (Todd Zullinger's
 message of "Wed\, 2 Dec 2009 20\:50\:05 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4444A08-DFB1-11DE-9FD5-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134427>

Todd Zullinger <tmz@pobox.com> writes:

> I don't know the doc toolchain well enough to know how best to fix
> this without breaking anything.  It would be ideal if the base URL
> used was substituted and controllable via make variables.  That would
> allow packagers to make it point to the on-disk documentation and make
> git's documentation even easier to use when disconnected.

Thanks. It indeed appears that update to FC11 at k.org brought a few
issues to the documentation area.

I think we can do something like this and let distro people to decide what
URL to use.

 Documentation/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f59952..abb75eb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -104,6 +104,10 @@ ifdef DOCBOOK_SUPPRESS_SP
 XMLTO_EXTRA += -m manpage-suppress-sp.xsl
 endif
 
+ifdef MAN_BASE_URL
+XMLTO_EXTRA += --stringparam man.base.url.for.relative.links=$(MAN_BASE_URL)
+endif
+
 # If your target system uses GNU groff, it may try to render
 # apostrophes as a "pretty" apostrophe using unicode.  This breaks
 # cut&paste, so you should set GNU_ROFF to force them to be ASCII
