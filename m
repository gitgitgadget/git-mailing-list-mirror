From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Wed, 05 Mar 2014 10:49:24 -0800
Message-ID: <xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
	<xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
	<20140305005649.GB11509@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 19:49:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLGsn-00063L-MU
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 19:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607AbaCESta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 13:49:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbaCESt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 13:49:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A558A6F931;
	Wed,  5 Mar 2014 13:49:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UckqfKkN6Lvp+dxpQ9Wio9Lce1o=; b=fKhJn9
	uXe9O5loJTwBRQju1hnC8PZfBzClH99BPFkSKO4ggfzmUeofTI6L3hgDsDKaI9pd
	KK8Q2Wga8y7Cpwcn/Lu66TKt9Dh5yXdumMWbzTYqZBTzq8mnT4w+rpypFvMJI3Ld
	zl0pcEvKQF5QNyVsJWeUSpWhArstMNg2ZXCdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AgbqsfTJ0MuVRmEus8QgmuBh4GEcS1uQ
	WiiezVX4OmmFIA9kiDn43ji9Iv1l2RrD9phGIctRDn3QZilnMiJQ00Re8Qd8KlQf
	9VNqNdo1K5VMNSS034VoUq3gt+0AuuZ+m+xaX25kyIimgQaafHOQszMloqMyYwf/
	dIsT7xuAprY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 733C16F92D;
	Wed,  5 Mar 2014 13:49:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02D716F927;
	Wed,  5 Mar 2014 13:49:26 -0500 (EST)
In-Reply-To: <20140305005649.GB11509@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 4 Mar 2014 19:56:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E086BEA0-A496-11E3-8CD5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243461>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 04, 2014 at 12:52:18PM -0800, Junio C Hamano wrote:
>
> I do not recall any past discussion on this topic, and searching the
> archive only shows people echoing what I said above. Is this something
> we've promised to work in the past?

The history lesson is coming solely from my recollection of a
discussion I and Linus had on the list back when we were doing the
original "graft" and thinking about the interaction between it and
the object/history transfer; especially the "only add new ones, but
hide the ones that the user wants to be hidden" part is something
suggested by Linus but we couldn't implement back then, IIRC.

> Perhaps the right response is "grafts are broken, use git-replace
> instead". But then should we think about deprecating grafts?

I am sort of surprised to hear that question, actually ;-)

I didn't say that in the message you are responding to because I
somehow thought that everybody has been in agreement with these two
lines for a long while.  Ever since I suggested the "replace" as an
alternative "grafts done right" and outlined how it should work to
Christian while sitting next to him in one of the early GitTogether,
the plan, at least in my mind, has always been exactly that: grafts
were a nice little attempt but is broken---if you really wanted to
muck with the history without rewriting (which is still discouraged,
by the way), do not use "graft", but use "replace".
