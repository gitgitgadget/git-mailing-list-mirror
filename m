From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/4] duplicate objects in packfiles
Date: Wed, 21 Aug 2013 15:17:17 -0700
Message-ID: <xmqq38q2u1si.fsf@gitster.dls.corp.google.com>
References: <20130814181718.GA7911@sigill.intra.peff.net>
	<7v4nast9bv.fsf@alter.siamese.dyndns.org>
	<7vvc38ruah.fsf@alter.siamese.dyndns.org>
	<20130816150138.GA4823@sigill.intra.peff.net>
	<20130821204955.GA28025@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 22 00:17:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCGib-00033Q-8X
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 00:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003Ab3HUWRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 18:17:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936Ab3HUWRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 18:17:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E9723B862;
	Wed, 21 Aug 2013 22:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l4D3lERqtJYSaHwC7WzGrp+1gpQ=; b=uy9UFt
	X0JKdZCXDZHOxpPJAoh/sxT8xhszdJromVRBXOv1iz4Dl9P6b+ah+XcULO97lpAn
	Wn7An15ioSmLmRNtSEFZayeHYM2fACdee+v5m6J8WXC6ZpogvyZTMQkYBrlnfq4f
	aPQ8Uukq1WtD3ZIFY9F3Z/5rsuus5/2S6Erog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hp2NgbICqhLFJBEyP8r+pES415adXSPM
	gc7HMaELXHcivaS4g/+RnEOqtRWZ1SfSxaHy/4jTzud+fUQzBkxoioqGnEMmDsC8
	019RXNhLGmv77Ml21aGW+F2SoE1N+/Mub04gm42CmydpKECHICJKSxss7r9z/q5R
	diAa08R+JVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12F013B861;
	Wed, 21 Aug 2013 22:17:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 676BF3B85D;
	Wed, 21 Aug 2013 22:17:19 +0000 (UTC)
In-Reply-To: <20130821204955.GA28025@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 21 Aug 2013 16:49:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 71B2BFB4-0AAF-11E3-B43C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232744>

Jeff King <peff@peff.net> writes:

> Which leaves the open question: should the default for index-pack flip
> to reject duplicates rather than allow?

I'd say so.

In am emergency, people with broken packfiles can feed them to
unpack-objects ;-)

More seriously, an alternative emergency mode may be an option to
unpack-objects that does not unpack objects but streams to a new
pack or something to resurret the objects that are salvageable from
a corrupt packfile.
