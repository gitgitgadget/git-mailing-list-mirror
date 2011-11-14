From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git shouldn't allow to push a new branch called HEAD
Date: Mon, 14 Nov 2011 12:22:59 -0800
Message-ID: <7vbosejvx8.fsf@alter.siamese.dyndns.org>
References: <1318591877.2938.20.camel@mastroc3.mobc3.local>
 <1318592153.2938.21.camel@mastroc3.mobc3.local>
 <1321261662.2941.13.camel@mastroc3.mobc3.local>
 <4EC0F15A.9010502@alum.mit.edu>
 <20111114111659.GC10847@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 14 21:23:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ33c-0004IP-Ez
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 21:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180Ab1KNUXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 15:23:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756168Ab1KNUXB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 15:23:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47C4B601E;
	Mon, 14 Nov 2011 15:23:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RWmTYPo4m10VOjGXVudLkWXGWJU=; b=KjLGbL
	lYISWNzRP2fsB2/U7t2wchXrPzzkurCT+PIg7mxDfe/T4Wo3MXR/O+vZUrmR4Qnd
	A0nXwpNn69jvLEmzkEkdh3Bfp4bplCQAo4RcJE+qSVOKM+3KlJ7nwJ3zaCUPHF7x
	X98BwybP4xtEdS7xDSfiXvl2BtdKRdOqdZUWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hfALdT7MjWUJaUB4gFhRGdeHzK3Xyydf
	jZsbF+neJvJLe1K0rGheIJuDGJwtom2rxC6w1R42OFzBzNAjj/Bjk9khyEch8plw
	pl1bS84Luv20FDwog1Mv7R61v2lIFVElNmTJICeKKKBt/vsJ8uY+e0/irDSRpshA
	YtLavQZCves=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F181601D;
	Mon, 14 Nov 2011 15:23:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C94EC601C; Mon, 14 Nov 2011
 15:23:00 -0500 (EST)
In-Reply-To: <20111114111659.GC10847@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 14 Nov 2011 06:16:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72CD404E-0EFE-11E1-BF54-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185395>

Jeff King <peff@peff.net> writes:

> So one solution is to block fetching of remote branches called HEAD
> (which I would be OK with). But another is...
> ... Obviously there's a lot more to it than just tweaking the default fetch
> refspecs. The ref lookup rules need to be changed to take this into
> account. There was some discussion about this over the summer (under the
> subject of possible "1.8.0" changes), but I don't think any work has
> been done.

I would say discussing and ironing out the kinks of the design counts as
work, but I agree nobody was seriously interested in laying out a sensible
transition plan and discussion died out before anything concrete happened.

Regardless of the layout chanage, which probably is a 2.X topic, I think a
good first step would be to start forbidding anything that ends with _?HEAD
as a branch or tag name, on top of Michael's "enforce the refname rules more
vigorously when a ref is created" series.
