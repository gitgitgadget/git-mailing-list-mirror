From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Mon, 24 Nov 2014 20:55:13 -0800
Message-ID: <xmqqy4qzubf2.fsf@gitster.dls.corp.google.com>
References: <6997784.RuzRO1AFsK@al> <1660121.8PEbpzfRYH@al>
	<20141124225457.GA9942@peff.net> <283403992.8FOSVk7RPR@al>
	<20141125040826.GC19301@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Peter Wu <peter@lekensteyn.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 05:55:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt8AO-0007AL-JB
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 05:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbaKYEzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 23:55:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750770AbaKYEzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 23:55:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47CC31FBFA;
	Mon, 24 Nov 2014 23:55:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DYYwd3Leb7CfPhYkIAghfefm1jA=; b=Ue6LNr
	pKz6RH88Qmn1Qi0zf6yocTW87A1hcBHQIH+0pfucQQzZBJFYu1UofxtgANGLwXXd
	vizVJANqtoCQst/9Pkl4WX/FRf53aTq//VIo9yppx+rS84hJOmG0SNa9FpYStWPq
	esIrwWULgFzjN0pzShjwjhxsHPfuX6rHkJ8m0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t57zAIFXEmV/3TdDN3EeOtAA9RlJp1sU
	Ze0+icjwL2zpog1ZRqLlSd0GGMK67KedjPql4CICtm0En/xg+Vtmwo0XlbLp30Ui
	vockPe46D02w5ANRPSZYFKeoqDywu4AS2OF1zY+zsOXb45S2hc6DWfGwuuXK3+SE
	CmoZgjXhkaA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DFFF1FBF9;
	Mon, 24 Nov 2014 23:55:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA9DE1FBF8;
	Mon, 24 Nov 2014 23:55:14 -0500 (EST)
In-Reply-To: <20141125040826.GC19301@peff.net> (Jeff King's message of "Mon,
	24 Nov 2014 23:08:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3E91B638-745F-11E4-AD99-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260191>

Jeff King <peff@peff.net> writes:

> However, I think what removed the confusion for me in your --only=both
> proposal was the presence of a "both" option, since it made it more
> clear that is not what no-option means. So what about just "--push",
> "--fetch", and "--both"?

I think that is the set that is most sensible, at least
syntactically, among the ones I heard so far in this thread.

However, one thing still makes me wonder....

After doing "set-url --fetch" and nothing else, because the user
never said "--both" or "--push", does the user get a configuration
where "git push" fails?  Or does "set-url --fetch" still gives us
remote.nick.url and causes "git push" to also go there?

If that is the case, then did addition of "--fetch" achieve anything
to reduce confusion?

After doing "set-url --push" and nothing else, I suspect that having
remote.nick.pushURL alone without remote.nick.URL will make "git fetch"
to fail, which would be in line with my expectation.  I just expected
anything we do in the name of symmetry or consistency would work the
same/symmetric way, I cannot see how "set-url --fetch" would work to
make its effect symmetric to the "set-url --push" one.

Puzzled...
