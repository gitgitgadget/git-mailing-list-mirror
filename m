From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Sun, 09 Jun 2013 13:31:41 -0700
Message-ID: <7vk3m3owk2.fsf@alter.siamese.dyndns.org>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<51AEE1C3.9020507@viscovery.net>
	<20130605071206.GC14427@sigill.intra.peff.net>
	<51B02D81.3000700@viscovery.net>
	<20130606063754.GA20050@sigill.intra.peff.net>
	<CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
	<20130606064409.GA20334@sigill.intra.peff.net>
	<7vy5anyx1w.fsf@alter.siamese.dyndns.org>
	<20130606174032.GB32174@sigill.intra.peff.net>
	<CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com>
	<20130609001845.GC29964@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 22:31:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlmHF-0001EV-7G
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 22:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab3FIUbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 16:31:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65127 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab3FIUbo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 16:31:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCB68265D1;
	Sun,  9 Jun 2013 20:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0+8DltN7fY1y1waz9oJJUvY4ql0=; b=RLwV/R
	CfG86+L5+ks2i1h8GSUxC4cC4Q8txtVVgGb2Az223xREA5V+ERX7aNskrXtZ7Fzq
	L0haFna1r415TS8YL2PU0UXar4AZw3B2RNT2rWa69KU0UIEiHZENyP55ZySupD2T
	qjv+no+tInBawFaF0pWi35fC/nKX55DmqIelo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xrJ1r7oXHT7qRs7QnT2d1m3OPiVEvj13
	N7r0Svu3xK6VC1is/Ga+8V7pYLH08PG84pPn0D+aN/CYYt2uwbOafRop+NT2DtXr
	5Rds2paB63BJI0+4tTq8igSRAHTG0MPnQyo3f1+mugZBcLsS7Q7lRwlA6OGgD/rJ
	qdwMfhYyhrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2F38265D0;
	Sun,  9 Jun 2013 20:31:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BFA2265CF;
	Sun,  9 Jun 2013 20:31:43 +0000 (UTC)
In-Reply-To: <20130609001845.GC29964@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 8 Jun 2013 20:18:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98D9017A-D143-11E2-A2D6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227162>

Jeff King <peff@peff.net> writes:

> I'm a little negative on handling just SIGTERM. That would make the test
> pass, but does it really address the overall issue? To me, the
> usefulness is having exit values with consistent meanings.

Yes.  Unless the goal is to give Windows port pratically the same
signal semantics as ports on other platforms, I do not think special
casing SIGTERM (unless it is a very common signal on Windows and
others are unlikely to be useful) buys us much.
