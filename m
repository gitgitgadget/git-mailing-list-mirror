From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Fri, 30 May 2014 13:52:11 -0700
Message-ID: <xmqqfvjr7zwk.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
	<20140530015855.GG28683@sigill.intra.peff.net>
	<CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
	<20140530065737.GA13591@sigill.intra.peff.net>
	<xmqqvbsn9pfx.fsf@gitster.dls.corp.google.com>
	<20140530170330.GA25443@sigill.intra.peff.net>
	<xmqqmwdz9nl9.fsf@gitster.dls.corp.google.com>
	<20140530183441.GA3704@sigill.intra.peff.net>
	<xmqqmwdz809b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 22:52:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqTmn-00088c-G7
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231AbaE3UwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 16:52:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55494 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbaE3UwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:52:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EF101A375;
	Fri, 30 May 2014 16:52:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aUCIsY1eO34K0j3m5B4mS9uJSDA=; b=uB7rjx
	Y9T6ZlfFefHVQta4T5yWiqiNUAM53umo8TptJT+LercoZyzdgGbSPs1t8LylgECB
	9WCXiLJ1hmYVoIqfLqUKfftKPZ5UYJNN+/+PqbEt2QeQwPe7ITZAYz3wE6p1s4cM
	JzEjC/wFJJ0RohF6DZ0w5ZlpKGzXpp5iTfROs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mc1Lrc9kmS4O+bjXEFiNosQ8o+oYDhbq
	U1Y3kJIJ92Jb61pWOd9FVR74Ckg+tPkVv5dyQlzpmr2u+ZxYVugVadD+MAdNbuHr
	GFWqoPqLTYoKSpw/l4avvaxLLkMcs4DEyQjoJyvSYPifWkGDXU4DYK9pKy6lv4us
	sX3Jcqlc6J4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5638A1A374;
	Fri, 30 May 2014 16:52:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ECFD11A371;
	Fri, 30 May 2014 16:52:12 -0400 (EDT)
In-Reply-To: <xmqqmwdz809b.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 30 May 2014 13:44:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4681400C-E83C-11E3-9819-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250481>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Subject: [PATCH] reuse commit->buffer when parsing signatures
>> ...
>> Signed-off-by: Jeff King <peff@peff.net>
>
> Hmph, unfortunately this seems to break t7510.

And I think without re-reading the patch I know what is wrong.  The
length of the object and strlen(commit->buffer) would be different,
no?
