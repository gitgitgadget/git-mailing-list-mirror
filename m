From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Fri, 22 Jan 2010 15:35:27 -0800
Message-ID: <7vpr51k91c.fsf@alter.siamese.dyndns.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <7vpr52gbmu.fsf@alter.siamese.dyndns.org> <201001222211.14743.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 23 00:35:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYT2e-0007L9-JO
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 00:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab0AVXfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 18:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073Ab0AVXfq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 18:35:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab0AVXfj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 18:35:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AC109368A;
	Fri, 22 Jan 2010 18:35:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5ocsgVbfNRnyZTEtyXvfX2eIkg4=; b=UJ/p7+
	x8V+XmMk5m5ClUM+RpJQAat2OqtRsVWxpd9N9Vzs5RUdv61HWVilR1pu21n92nPd
	Y5/ZAEuJ56Hci3dq1/QiST2O/jJOQQe15jAPufX90bFonAZKpM+vxiGEsch6hM8q
	CrhabBzMi4VvYnj5O0xnRgACjbQ6e71X8zT/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uXb3VKp/cosrx7xDGdOz6xEtdqCXsXPb
	59pxZj0tKDdFcOkf7eoBMx3dFvK5M5IEAMWYCUgZVcmtQWudFvlfET8gBe/Wgk7M
	XQKWdxCMBU6RnWksKENIZiZxF4qA73RMItYhYsiUelo+7Jw9ZaJRhQ9JzO9GjUCA
	c1TTDqqZbdg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E57A193680;
	Fri, 22 Jan 2010 18:35:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 118D19367F; Fri, 22 Jan
 2010 18:35:28 -0500 (EST)
In-Reply-To: <201001222211.14743.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri\, 22 Jan 2010 22\:11\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5EBB45C-07AE-11DF-86B3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137787>

Thomas Rast <trast@student.ethz.ch> writes:

> It's not about *permitted* input; the problem is simply that the
> current function gives back *bogus* paths, which causes git to fail.
> So I only went for the minimal patch to fix this.

With that logic a minimal patch would have been not to call the function
at all, as apparently the caller seem to be able to cope with absolute
paths returned when they could be made relative, no?

In other words, it wasn't obvious to me if the minimal patch avoided
returning a bogus result claiming that is a path relative to the base
directory and instead returned an absolute path (which might be suboptimal
but way better than giving a wrong thing back) in _all_ cases, or only
just on _some_ cases but not others, and if it was the latter, what are
the cases that it did better than the original.

> As for your patch, thanks for coming up with a real fix.  I read the
> amended version, and it seems correct to me.

By "amended", I take it to mean the fix-up by Hannes.  I'll queue one
for 'maint'.

Thanks.
