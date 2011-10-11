From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 10:53:49 -0700
Message-ID: <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 11 19:54:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDgWb-0000YN-An
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 19:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab1JKRxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 13:53:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754638Ab1JKRxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 13:53:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75C5056BA;
	Tue, 11 Oct 2011 13:53:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FJWY0uh+iovapHXXhqXET7HXa/4=; b=Xa3vAZ
	M3Ca0nWPVPF9L9zGLsVf6TbnbmgL7iqZ7g4bACq2N3SSpqWsYhqHWBA9qHGFHx0Y
	uKWMVM2drscu3ymIJaC6y6v2hZoGPWZiyYj2IiaANzGlwJdlqGDAb5B2dG7ex0uq
	C4ccOtF9p6v9fnWL1TZ32DejSFy16y5arRkHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QD9JrJTWE4OdNrWxjJK2EenjoiUDdd31
	6k8U+hvw+y70i6a4Mw5g0CWnxhGGpBMb3C+uZADPymQSjmFYyaUXnCN38plyZ5nH
	8PMbJDMpDAgh6ThQu6CZQEDzS5AHO54g7B36q1kHvql9D8ROIdvNm84gQ+TbtFHy
	+WqwruQlQOU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C55556B9;
	Tue, 11 Oct 2011 13:53:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D702356B8; Tue, 11 Oct 2011
 13:53:50 -0400 (EDT)
In-Reply-To: <20111011161652.GA15629@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 11 Oct 2011 12:16:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA3009AA-F431-11E0-A833-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183313>

Jeff King <peff@peff.net> writes:

> I wonder if the right solution is for us to be more picky about what can
> be found in $GIT_DIR. Maybe matching all-uppercase, or starting with
> "refs/", which I think would match existing convention?

I think we've discussed tightening it a few years ago already.

HEAD, MERGE_HEAD, FETCH_HEAD, etc. all are "^[_A-Z]*$" and it may even be
a good idea to insist "^[_A-Z]*HEAD$" or even "^([A-Z][A-Z]*_)?HEAD$".
