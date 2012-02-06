From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Mon, 06 Feb 2012 10:04:20 -0800
Message-ID: <7vy5sf7s9n.fsf@alter.siamese.dyndns.org>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <20120206081342.GB3966@sigill.intra.peff.net>
 <7vk4408ir6.fsf@alter.siamese.dyndns.org>
 <7vfweo8ikq.fsf@alter.siamese.dyndns.org>
 <20120206083832.GA9425@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 19:04:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuSvV-0001AV-1C
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 19:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab2BFSEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 13:04:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371Ab2BFSEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 13:04:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5AAD692E;
	Mon,  6 Feb 2012 13:04:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3/aTdOkmYbTLqO+/hJY1WvRPmbQ=; b=tyDp5C
	/clnXkqmmk0dH9qqtM5taJjZJCkaHu7k6ncl+HMi+CwxZJwmiVAnYfBvMi3T+61l
	HsI2niLp32rIls9wJE8MscNaWndJRk2J1KZKd1jHKw0V59X7O+7Lxd22npc37uLg
	hdTgFEJF9ClN4fjs/iT8Mam9I9O5x10q/veI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o7MUzo1IZyfso93iYZsNMFOEqmyb6dqY
	cDQ9Nvt3vm2exE5d8txau63z4/Xd5IcvQU5IyJz8iMwXiB/pnG/7Op5NHApMGO3/
	XyRQZj0S1AhPSeuTOd9Si2ne7ozOHcR5JAgbxa/TJuemLaYtdphwsTJJl03tnGVN
	pj5BMXPoyUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BF95692D;
	Mon,  6 Feb 2012 13:04:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 277C4692C; Mon,  6 Feb 2012
 13:04:22 -0500 (EST)
In-Reply-To: <20120206083832.GA9425@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Feb 2012 03:38:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF311620-50EC-11E1-B923-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190084>

Jeff King <peff@peff.net> writes:

> OK, that's easy enough to do. Should we show lightweight tags to commits
> for backwards compatibility (and just drop the parse_signature junk in
> that case)? The showing of blobs or trees is the really bad thing, I
> think.

I think that is a sensible thing to do.  I see many end-user documents on
the Interweb that uses lightweight "git tag", and I do not think they are
shooting for brevity of their illustration.  The authors of these pages do
primarily use lightweight tags because they do not have anything more to
add in the message more than the log message commit objects they point at.
And it is a huge regression if we stop showing them if they are used to
use "tag -n".
