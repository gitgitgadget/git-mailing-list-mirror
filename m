From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 10:29:18 -0800
Message-ID: <7vk4xbn7nl.fsf@alter.siamese.dyndns.org>
References: <20091125203922.GA18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
 <20091127095914.GA4865@sigill.intra.peff.net>
 <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
 <6839293b0911270827x54947c64q5f93e37664bc20f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, James Pickens <jepicken@gmail.com>,
	git@vger.kernel.org
To: Uri Okrent <uokrent@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:29:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE5Zc-0006aM-16
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbZK0S31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 13:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbZK0S31
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:29:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbZK0S30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 13:29:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF464A23D3;
	Fri, 27 Nov 2009 13:29:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=nsopavETClzFygG2Dae3AgRZzTA=; b=oUAggcnWylR8aKmCHOF6tIW
	mJ3OGvfKowc0lNgzQnGhbUaRli6h9hwrR8UUTCCfBIpH4B9v2wVB2v5MneOZgtCm
	C7GGuTO6Keag5zAB2bSawiSpF+U/WyNOrjPdJOitcjuCJhig8T7MzkXmY50zi/kq
	sbXEVsArSOk+64M9BChg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=AHaRR2BNMBFVXaFogdxH0sax1uQZRcTNIto2K4Ykw6hUGgdmK
	JXBCaR5Y38lb3dV8Lns1oY64JWP023+jDQpqRibQqEtg9lpc1qlq0TW6OjTd0G1J
	9PAYfY+2P/M++LqGnfcR9+GWIG/pW/Bl5ide9ROAMnya710V6MQtekVbn8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A067A23D2;
	Fri, 27 Nov 2009 13:29:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 65BB8A23CF; Fri, 27 Nov 2009
 13:29:20 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB868C92-DB82-11DE-B645-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133920>

Uri Okrent <uokrent@gmail.com> writes:

> The key once again, is managing expectations. We can't go around
> changing everything willy-nilly, and we can't be continually changing
> things. Here is where we could take a lesson from the python
> community.
>
> When they decided they needed to change things, they bundled a
> bunch of backwards incompatible changes together and went for it.
> Yes, Python 3 will break your scripts, but the most important thing is,
> everybody knows it.
>
> A similar thing was done here with the huge warning that push spits
> out, but in the general case I would argue, that the wisest course is to
> save backwards incompatible changes for a git 2 or something, where
> we know we're breaking the world, and then scratch all our (well thought
> out) backwards incompatible itches at once.

You preach to the choir.

That is exactly how we work and what people have been working hard for
1.7.0.  Check the planned changes listed in the recent (and not so recent)
"What's cooking" summary reports.

Changing "grep" is too late for 1.7.0, but we are trying to find an easy
migration path like you mentioned in your message and that is exactly what
this thread is about.
