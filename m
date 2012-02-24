From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Fri, 24 Feb 2012 13:14:05 -0800
Message-ID: <7vk43cx7c2.fsf@alter.siamese.dyndns.org>
References: <4F46036F.3040406@gmail.com>
 <20120223102426.GB2912@sigill.intra.peff.net> <4F462E61.4020203@gmail.com>
 <m34nuhelnf.fsf@localhost.localdomain> <4F4643BB.8090001@gmail.com>
 <20120223193451.GB30132@sigill.intra.peff.net>
 <7vy5rt2u0c.fsf@alter.siamese.dyndns.org> <4F475689.4040203@gmail.com>
 <20120224095253.GC11846@sigill.intra.peff.net>
 <7vsji0xalg.fsf@alter.siamese.dyndns.org>
 <20120224204615.GB21447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikolaj Shurkaev <snnicky@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:14:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12T2-00064Y-5Z
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111Ab2BXVOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 16:14:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab2BXVOI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:14:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01ADA6EEB;
	Fri, 24 Feb 2012 16:14:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kwBxqTTvOdsBRGcn6Rte2So/Nmg=; b=d2U5Ay
	0x3x0k5M5bAYCLORrGxqMSSDPNum3hASCArMuk1c+cxXWXk9SUjHRDod2Yw9c23i
	ukuqVHVk+pb0OfjNXbqVFeRN2ObYjmlSzy6KN6Xu2x225FcXBTV6DaBz2IuIEOpw
	b35nDw2Txz0wztcBW8Sa8pTrZKhY7jNRFWvz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a6UiAJ90nJkSJ7Lh5VZbpqYLqqmzOqjj
	qEyTGoh7aYdhfVpxTaFHK689gsEaA1CG2xYzfSlRxFDsXV2h/757Hk/pHFK/2C64
	MRpkWRWWFBn1IVR+E5yjUk8DE8P7J9tkQV39VH62HFVxsN7cfMmB9Q8+S5iB+daz
	BujEiST3hPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4AE86EE5;
	Fri, 24 Feb 2012 16:14:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68F2D6EE4; Fri, 24 Feb 2012
 16:14:07 -0500 (EST)
In-Reply-To: <20120224204615.GB21447@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 24 Feb 2012 15:46:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CC69522-5F2C-11E1-A806-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191480>

Jeff King <peff@peff.net> writes:

> True. That is also a slightly dangerous thing to do, though, because you
> are omitting full patches in the middle that touch the same paths as the
> patches you include....
> ... So
> perhaps we are better off to refer the user to git-log(1), say that
> commit limiting options in general would work, but be careful with
> sending a partial result.

You seem to have spelled out everything I originally wrote in my reply
that I later deleted before sending it out, and I think the reason that
brought you to the three-line conclusion is the same one that made me I
delete them ;-).

Using a partial patch essentially has the same risk as cherry-picking a
commit into different context, and it is a more generic issue that this
particular manual page should not waste tons of space to teach readers
about.  I think "Be careful and clueful" is sufficient and the best we can
do without writing a textbook on distributed software development
disciplines.

> ... I tend to think the
> commit-limiting options are the useful and working ones, which is why I
> suggested mentioning them explicitly above.

I think I agree that is a sane thing to do.
