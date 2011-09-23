From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] get_sha1_hex(): do not read past a NUL character
Date: Fri, 23 Sep 2011 11:59:43 -0700
Message-ID: <7vaa9vulsw.fsf@alter.siamese.dyndns.org>
References: <4E7C857D.8000304@alum.mit.edu>
 <1316785116-21831-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 23 20:59:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7AyU-0004UI-Dc
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 20:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab1IWS7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 14:59:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab1IWS7p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 14:59:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 230D86F30;
	Fri, 23 Sep 2011 14:59:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HoonVPbYFQSGdM4LwxsqrC3EatI=; b=nJnr2l
	drC5Z8ogdyTOFhATSIxu7JaOVu1GaHrwNZixUn1+/oY54jf22g3SF2XnpRb2kljX
	JNqyD2n/BEx88rkuX4w64826PAqmiCxtbAJv24flG+lskslLu0KLQd2KPKyZnm1r
	Wvr3yBwZLggqMc0cMzLPkzZEcVPeP+CjqDQ24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cMGtujBsDkRvIclG0AZS4IVzpTan50aP
	uxOj3SFwYMnNP0e1091VlQWZz7OrQSb19dQndVg7ETYJSNlYLuzOBWdOkmLL5AVu
	yUH4ABDywaM+/Zy8TQ31V/Ql7dNo+if8f+DDFFktLavSIQFd9akBEuLpIJuHgdjZ
	fO7KlDeITo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A4416F2F;
	Fri, 23 Sep 2011 14:59:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6DB06F2E; Fri, 23 Sep 2011
 14:59:44 -0400 (EDT)
In-Reply-To: <1316785116-21831-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Fri, 23 Sep 2011 15:38:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33638564-E616-11E0-B4F2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181990>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Previously, get_sha1_hex() would read one character past the end of a
> null-terminated string whose strlen was an even number less than 40.
> Although the function correctly returned -1 in these cases, the extra
> memory access might have been to uninitialized (or even, conceivably,
> unallocated) memory.
>
> Add a check to avoid reading past the end of a string.

Makes sense; thanks.
