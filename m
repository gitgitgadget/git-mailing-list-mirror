From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] pretty: prepare notes message at a centralized place
Date: Thu, 18 Oct 2012 02:17:01 -0700
Message-ID: <7vfw5cm96a.fsf@alter.siamese.dyndns.org>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
 <1350539128-21577-4-git-send-email-gitster@pobox.com>
 <20121018074921.GC9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 11:17:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOmEI-00088F-GG
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 11:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab2JRJRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 05:17:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41531 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754959Ab2JRJRK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 05:17:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34D839117;
	Thu, 18 Oct 2012 05:17:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f8rUNkn+neFvliPEbUXwUEn1HE0=; b=hjCDvB
	aFma+A/EWBMFFAyyiMFD4VJ4cR/Z0fE88fhkMNJZ3qA90z80u2dZgBWW7OMnxvkq
	5HQ5mHmdyet6bOmuxqvKqKQqf2hfBiZ1/CcdDwN7bG9TNmFXh3JX87z8dsWA1XCB
	jY8NlVeUdj6xSNgp0lSf4WjQHF5Q31UzGWvI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UCRaCwpTogoVnmQy6lBbCURJngi1XQgN
	I43yAnpFf2TUXYbyz5zKawXHc2Z+eLCaTU/6dq8Ez6Db9R5aoFp3utLfHLNpcMBJ
	9OkL1ThBmCZHGRjoR03tMus1Sb80G69WQnprRsPq6Do8npgYIuQ+UyqOUuI2clE9
	TcN1coASMNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 200B09115;
	Thu, 18 Oct 2012 05:17:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 818CC910F; Thu, 18 Oct 2012
 05:17:08 -0400 (EDT)
In-Reply-To: <20121018074921.GC9999@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 18 Oct 2012 03:49:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9769B9A8-1904-11E2-9C19-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207982>

Jeff King <peff@peff.net> writes:

> It's possible that switching it would create bugs elsewhere (there are
> over 100 uses of strbuf_detach, so maybe somebody really does want this
> NULL behavior), but I tend to think it is just as likely to be fixing
> undiscovered bugs.

Yeah, I tend to agree.

This "format-patch --notes" is obviously a post 1.8.0 topic, and so
is the strbuf_detach() clean-up.  Let me bookmark this thread in
case it hasn't been resolved when I came back from my vacation, so
that I won't forget ;-).
