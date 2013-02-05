From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Tue, 05 Feb 2013 12:23:00 -0800
Message-ID: <7vd2wese6z.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <7vip66sftf.fsf@alter.siamese.dyndns.org>
 <87bobyr0ju.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:23:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2p3O-0001PC-Is
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 21:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615Ab3BEUXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 15:23:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51456 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756400Ab3BEUXC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 15:23:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 501C2B92A;
	Tue,  5 Feb 2013 15:23:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vd7lCK1XdL+uwsDnAlq79ZkaFqg=; b=DbRzgh
	1zldz+e87NncY4e6BwBI94Fk8MLh78fbmVvaqzRpjDxDJ35qhfhhZkpigsSfCZP7
	VLRDOOzTiZPsK9ezrU/8iq5yPvYQr/5nePslcW2GhBfkvR1+WOACI5bpcvyUFENM
	K1ugaiz48rP1t/Z8iZD8EN14HSpMr0cygSOdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qujkCzP9mxZ3Z8KB4I2SVuyRicir3M+i
	Nzt0bmkL/BjlUtgPpUdYnGVy/6+46/rJPlL5Y32ybYlKDoVsO+1mPU8wyLL8oWBW
	RptIh2kFC226wfoLXO8R9Vj0Dz3emun2085BjM90cgjIyestcMlL/yAAylQu3nku
	ThK7CUywpnw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 454EFB928;
	Tue,  5 Feb 2013 15:23:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A64EEB925; Tue,  5 Feb 2013
 15:23:01 -0500 (EST)
In-Reply-To: <87bobyr0ju.fsf@lifelogs.com> (Ted Zlatanov's message of "Tue,
 05 Feb 2013 15:03:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6C923E4-6FD1-11E2-AA5F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215533>

Ted Zlatanov <tzz@lifelogs.com> writes:

> JCH> You still need to parse a file that has a "default" entry correctly;
> JCH> otherwise the users won't be able to share existing .netrc files
> JCH> with other applications e.g. ftp, which is the whole point of this
> JCH> series.  Not using values from the "default" entry is probably fine,
> JCH> though.
>
> OK; done in PATCHv4.

Hmph.

Didn't you remove that from your version of net_netrc_loader when
you borrowed the bulk of the code from Net::Netrc::_readrc?  I see
"default" token handled at the beginning of "TOKEN: while (@tok)"
loop in the original but not in your version I see in v4.
