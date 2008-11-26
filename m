From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Fix Pine address book parsing
Date: Tue, 25 Nov 2008 22:44:46 -0800
Message-ID: <7vy6z7gf4x.fsf@gitster.siamese.dyndns.org>
References: <1227668100-5563-1-git-send-email-tpiepho@freescale.com>
 <7vod03hyna.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0811252137250.5161@t2.domain.actdsltmp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Trent Piepho <tpiepho@freescale.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 07:46:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5EAI-0000Og-TY
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 07:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbYKZGpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 01:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbYKZGpH
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 01:45:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbYKZGpG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 01:45:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF50C8176F;
	Wed, 26 Nov 2008 01:45:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D2BE18176B; Wed,
 26 Nov 2008 01:44:48 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0811252137250.5161@t2.domain.actdsltmp> (Trent
 Piepho's message of "Tue, 25 Nov 2008 21:59:45 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C0BD9332-BB85-11DD-9D5A-F824C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101705>

Trent Piepho <tpiepho@freescale.com> writes:

> The tech docs I linked to just say pine continues lines with leading space,
> but not how many spaces exactly.

My reading of the wording "spaces" it uses is that any number.  I agree it
is underspecified what would happen to them.

> It also appears to only split lines between whitespace and
> non-whitespace. ...
> ... like "a b \n   c \n   d\n".  If I didn't eat the leading spaces in the
> continuations, it would be re-assembled as "a b    c    d".  This might cause
> an address to become "John     Doe <jdoe@anon.org>"

Which would still work.  If you had two addresses a and b and smashed them
together into ab on the other hand it wouldn't.  That is why I asked.

If you know for sure (e.g. by reading the Pine source) that it only splits
a line at a whitespace to non-whitespace transition, that it keeps the
whitespace at the end of the first line, and that the non-whitespace and
everything after that on the second line (prefixed by extra unspecified
number of spaces as the continuation sign), then I think what you had in
your patch is exactly what we want.  I just wanted to make sure you know
what you are doing, as I do not use Pine nor its address book myself.
