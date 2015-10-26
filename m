From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] detecting delete/modechange conflicts
Date: Mon, 26 Oct 2015 14:46:42 -0700
Message-ID: <xmqq8u6pfgl9.fsf@gitster.mtv.corp.google.com>
References: <20151026213502.GA17244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 26 22:46:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqpbP-0004dY-Jc
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 22:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbbJZVqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 17:46:47 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752677AbbJZVqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 17:46:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56E6427218;
	Mon, 26 Oct 2015 17:46:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1E9TPI2g4eOn4dHOPE0Y/2QWplE=; b=nMVrbz
	vqatxdwOR5pb5I/YTGo9e+N/FeYoPd6eESlaH/WsqtCv7LVkCKFIDDBlT7WJ55pw
	hGkGkwFUbpksWBHdDf+8mTEUd1Z9c6GcXr3W09/wFZjLlvod+y2q1hyNMaal1ShR
	9F3Ev9gvTi5w4EQ0X0ARc/UnO5HFSXxc142sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=suqACo2XZJWuzatAm1wRtT9SQ5IcQblf
	DgQtGyXxT432EGOHAimTXEUGdMr/IIDMuSYUZjm2mytjzIXB9C/hxVh6yFJYL3zL
	0Oam/xyWqnugNLk1j9enUy1dIl0/KtyCqInjMbiJ9SvgFiSum1TCWdoyLf4/1ow3
	9PnCN42xtk8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5008627217;
	Mon, 26 Oct 2015 17:46:44 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CDA4927215;
	Mon, 26 Oct 2015 17:46:43 -0400 (EDT)
In-Reply-To: <20151026213502.GA17244@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 26 Oct 2015 17:35:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C6C399C-7C2B-11E5-B8CB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280230>

Jeff King <peff@peff.net> writes:

> After looking through the history and the list archive, I don't _think_
> this was intentional, and we simply missed the case in both places. But
> maybe somebody else knows something I don't. It seems like we should be
> punting to the user under the general principle of stupid and safe
> merges.

Yes, I do not recall ever discussing and agreeing with Linus that we
should resolve to deletion over mode change, and I agree that it
would be very likely that this never came up in practice simply
because in real life removal is already rare, mode change is rarer,
and these happening to the same path in the same timeperiod to
matter in merges is even more rare.

We should definitely signal a conflict.

>   [1/3]: t6031: move triple-rename test to t3030
>   [2/3]: t6031: generalize for recursive and resolve strategies
>   [3/3]: merge: detect delete/modechange conflict
>
> -Peff
