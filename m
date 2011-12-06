From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/13] credential helpers
Date: Tue, 06 Dec 2011 13:40:17 -0800
Message-ID: <7v7h29fkfy.fsf@alter.siamese.dyndns.org>
References: <20111206062127.GA29046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 22:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2kT-0004ul-4y
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab1LFVkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:40:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab1LFVkT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:40:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E595F64E9;
	Tue,  6 Dec 2011 16:40:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vyp2C1ZoNMMGpCrGZ228JcPuK4E=; b=QyievP
	T6uZ2qAxwRTR78USxYW5GPYVY2uMjkN0919M69kc3K2saGeF5s5Ta6FuginpjoQZ
	FOK8Ac0p4hsM4EVkyje8aTrVA2CfNbRJVUI1AuKVZSJ7GFu41OfC3HxNxXEY+Pag
	QfNwo8eEyBV5e0+tmTImV/GYJiWd8HE5MUUFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B81aYoBh+u5OP+FRByUxSkaHDK/cB/6T
	wAdekNsiaMPlrwiSdVWqbsCPcClMARYKGwXwHlFcOJQI5v86wQKyyKP1sIT4drhB
	rF1x6wwm26FP345iSIJksjMaDdiQYAMWZ/wACNo1Elrtld9R5gIxEs22YdlYs23q
	f6XZZC2Pswk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB8DA64E8;
	Tue,  6 Dec 2011 16:40:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D02F64E7; Tue,  6 Dec 2011
 16:40:18 -0500 (EST)
In-Reply-To: <20111206062127.GA29046@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 6 Dec 2011 01:21:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4209416-2052-11E1-B484-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186391>

Jeff King <peff@peff.net> writes:

>     ... You can now
>     do: "git credential-store erase </dev/null" to erase everything
>     (since you have provided no restrictions, it matches everything).

That "justification" does not sound so true to me but perhaps that is
because it is unclear what "erase" means and what it means to give the
operation parameters.

When I see "erase $foo", I would find it natural if $foo meant "if there
is something that matches $foo, then please remove it, but keep everything
else intact", and not the other way around "Match the existing entries
against a pattern (or a set of matching patterns) I am giving you, and
drop all the rest". So if I happen to give you an empty set, I would
expect nothing is removed.

Perhaps the root cause of the issue is that you are treating the input as
"restriction" instead of something that produces "positive matches"?

Confused.
