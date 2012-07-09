From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Restore umasks influence on the permissions of work tree
 created by clone
Date: Mon, 09 Jul 2012 16:07:16 -0700
Message-ID: <7v1ukkjzyz.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1207061700060.2056@iabervon.org>
 <20120707215029.GA26819@blimp.dmz> <7vobnpn224.fsf@alter.siamese.dyndns.org>
 <20120709225829.GA8397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 01:07:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoN37-0005yO-0V
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 01:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab2GIXHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 19:07:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523Ab2GIXHS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 19:07:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 158109E11;
	Mon,  9 Jul 2012 19:07:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xzTzrrAf+qfTxpVogRopFjf4yuI=; b=m18cHJ
	F96k2khAtuFYpMb0ARBr6GnhhjDjjDhEd77pVkKhU/O2vLFuN1S3VnZycE+wdlIy
	sTGkF1E2Jh/7wzbtRMclUH9RopuZl4yzdrXyQgcCDTmgOWZp5JgOAyVvElicwpaq
	nKl4B2Y07e8eyukr/gjJhCODEWs61TE98rfM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KY1rNLOj82ekWHOUlFTG18UIHXW6VZTN
	nLVmJcrZl4VInsH3YlhlOJdVYa+MM+5g76BugAh2QnV0or8pOjkFlPNkhktwxT7o
	0kbffNCKxnZVtb+/nUa3nBsKXnT5E6NHHJceeJ+1dj6pFaHUXkkkveJv/qeWJAfq
	DfHbDPGj2Ws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CD979E10;
	Mon,  9 Jul 2012 19:07:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A01A9E0F; Mon,  9 Jul 2012
 19:07:17 -0400 (EDT)
In-Reply-To: <20120709225829.GA8397@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 9 Jul 2012 18:58:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D43AF844-CA1A-11E1-933D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201232>

Jeff King <peff@peff.net> writes:

> Does the mkdir of "rr-cache/*" in rerere.c make the same mistake? The
> rr-cache root is made with 0777, and the files inside each subdirectory
> are created with 0666.  So it is the only thing preventing users of
> shared repos from using rerere.

Quite possibly yes.  I do not recall tightening permissions on
purpose, and it was a long time ago ;-)
