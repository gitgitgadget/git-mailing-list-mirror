From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git commit --short' without touching index?
Date: Mon, 05 Jul 2010 13:10:43 -0700
Message-ID: <7veifhy9j0.fsf@alter.siamese.dyndns.org>
References: <loom.20100703T102242-536@post.gmane.org>
 <20100703091748.GA11714@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel <friedan@muon.rutgers.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 22:11:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVs0K-00034E-5d
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 22:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab0GEUKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 16:10:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab0GEUKy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 16:10:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD800C1F41;
	Mon,  5 Jul 2010 16:10:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0R5hTHjBFJ/zpYdaIIJaVD6RZiQ=; b=QhyBrk
	csN2gTwP0VR2+pT4LCgQK+1VmZ38TyF+8v995OtC1I+WRMsBS9tdjLCvq7Qu2oxb
	Bgxa8Zq2C3jeXq3lS+vrPG9uafDPN9er6NHoxA9rn0cKqLe8pmsZ0vwUIRL5DZj0
	EFpwqTkobego2h3G/nFRb33azPJA1nHpRbRl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EMbU8l6u1Fedrlh0XrDrgm5NBLPhJYmi
	kpVe1BPc9sB2fVGttN1YH0NtS0tpSmH7DyuAURK475ZHq0iiGEAzB1Cmgvd9GDyu
	ZFgBlntlzLLzCeAkOyopdbuTaUGr6TVqXn6ihoDFS640GM//brcncMRWSXga4+0X
	qU6Jib5H7KE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C8D5C1F40;
	Mon,  5 Jul 2010 16:10:49 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF08CC1F3E; Mon,  5 Jul
 2010 16:10:45 -0400 (EDT)
In-Reply-To: <20100703091748.GA11714@sigill.intra.peff.net> (Jeff King's
 message of "Sat\, 3 Jul 2010 05\:17\:48 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67889F18-8871-11DF-BB1D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150292>

Jeff King <peff@peff.net> writes:

> It would be nice if the index-refreshing code only wrote to the index if
> there was something worth writing. I'm not sure how hard that would be
> to implement, though.

Hmm, don't we already do that with "istate->cache_changed"?

In any case, we should diagnose "commit --short" (and "--procelain") as an
error, perhaps by splitting option parsers for commit and status further.
