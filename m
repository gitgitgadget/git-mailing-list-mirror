From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 12:54:04 -0800
Message-ID: <7vk3sd930z.fsf@alter.siamese.dyndns.org>
References: <20121219203449.GA10001@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 21:54:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlQeo-0006g1-EY
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 21:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab2LSUyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 15:54:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43011 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab2LSUyH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 15:54:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AEEB8C92;
	Wed, 19 Dec 2012 15:54:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=de9k3ieMuFPyoXSLD+mGFPeJS3c=; b=JxdRBy
	sPQToZTOhjDT0+G7yqc+XsCvcEf1QtcEpx5xHsBO/0Mlax/6G7uAFJBDw81fixXk
	fLx6dbdf4qyibZa12p7Ve5zE3vvp54l13X2swff/hsGQDWo9zA75n6+rL0o/CFFm
	VNTN+NcLAj2Bk/GwoT5dggyBVgiKynfCtYHEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAT8+s+ldd4cccOtyzJgmtJ0fOjWW9vq
	NQf+Kho94jBjtaygT1/917DjE9n6NryHvbb6BvvtNQX4zZNH2r8wNioaTlZcBYcq
	BAYGL1o+7l6+6SH9njx/QwRu6P5UeZCZD4iVnqUIBKXZCPXnQKz3RGet2e2+mZtC
	k44w4HvHsaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 483F68C91;
	Wed, 19 Dec 2012 15:54:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B53CC8C90; Wed, 19 Dec 2012
 15:54:05 -0500 (EST)
In-Reply-To: <20121219203449.GA10001@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Dec 2012 15:34:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A066BF8-4A1E-11E2-ADB6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211847>

Jeff King <peff@peff.net> writes:

> ... doing ":(noglob)" right would mean converting
> the whole codebase to use "struct pathspec", as the usual
> "const char **pathspec" cannot represent extra per-item
> flags.

As that is the longer-term direction we would want to go, I'd rather
not to take the approach in this patch for introducing user-facing
support of literal pathspecs.

Having said that, even when we have the ':(noglob)' magic pathspec
support, it would make sense to introduce a command line option to
make it easier for scripted Porcelains that call plumbing commands
to pass literal pathspecs (i.e. they know exactly what paths they
want to operate, not what patterns the paths they want to operate
would match).  I do not think configuration variable makes much
sense (unless you are thinking "git -c core.literalpathspec=true"
as that command line option).

Thanks
