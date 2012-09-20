From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Wed, 19 Sep 2012 17:05:08 -0700
Message-ID: <7vfw6deeyz.fsf@alter.siamese.dyndns.org>
References: <20120906151317.GB7407@sigill.intra.peff.net>
 <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
 <7v627aiq47.fsf@alter.siamese.dyndns.org>
 <20120919182715.GF11699@sigill.intra.peff.net>
 <7vzk4lg5yf.fsf@alter.siamese.dyndns.org>
 <20120919194213.GB21950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <n1xim.email@gmail.com>,
	gitList <git@vger.kernel.org>, Matthieu.Moy@imag.fr,
	andy@aeruder.net, chriscool@tuxfamily.org,
	dmellor@whistlingcat.com, dpmcgee@gmail.com, fonseca@diku.dk,
	freku045@student.liu.se, kevin@sb.org, marius@trolltech.com,
	namhyung@gmail.com, rene.scharfe@lsrfire.ath.cx, s-beyer@gmx.net,
	trast@inf.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 02:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEUGi-0003Fq-GE
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 02:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab2ITAFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 20:05:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab2ITAFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 20:05:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 962268648;
	Wed, 19 Sep 2012 20:05:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lIuec8UG5QMm2zb0Mxm4/fvNe1A=; b=g62s4t
	nZMabwQ9oB+7fk842HEcxymGjBIQftpp+vWRidEcMdf2lwC27nKLP/UE6sElHYls
	LISASVcVKQWYULVQmvutj1tCbG00FTK7jJyuXnEW522R5JUT1U1l5UEblBcZzLxV
	mRQC6kPgDRqRARCFVm+SflP6jz+RhUY/CO2eU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mfyv7C7xSl9V/boMbF6gne9Mp3SZKckE
	cbKCpN0Nxgwx8IUpXF2s9P8qiR3g4xLVwS9e/HMKY93ZP2hBdvL/PPgi+mcfw9yd
	noSXRqlLVoiKmEmO745C8jevgQuW4y0hAmHewPy3kDBZ8WPnuA9NP/ByF5lsmnnK
	4Xhfn5NgG5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F7A08647;
	Wed, 19 Sep 2012 20:05:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 434428643; Wed, 19 Sep 2012
 20:05:10 -0400 (EDT)
In-Reply-To: <20120919194213.GB21950@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Sep 2012 15:42:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7D94EEA-02B6-11E2-9204-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206017>

Jeff King <peff@peff.net> writes:

> I guess it depends on your perspective. I can see the argument that
> blame is already doing what --follow would ask for, and thus it is a
> no-op. I think of it more as --follow is nonsensical for blame.

Is "--follow" a nonsense in the context of blame?  I am not so sure.

I think it all boils down to this question:

	Does "blame" that does not follow rename make sense?

When you think about -M (allows us to keep track of the origin of
lines inside a single file when they are moved around) and -C
(allows us to keep track of the origin of lines that migrate from
another file), "follow across whole-file rename" is another optional
mode of operation in the same class to tell the command to pay more
processing cost to buy better precision.  When you know what you are
interested in happened entirely inside a file that was never
renamed, "blame -M" without "-C" and without whole-file rename
tracking is a sensible way to set that trade-off, even though we
currently do not have a way to say "--no-follow".

Eventually we would review and accept a patch to fix "--follow" by
somebody and that patch will make "--follow" truly follows renames
by keeping track of a single pathspec used to limit the changes per
ancestry traversal path, instead of switching one global one, which
is the current hack does.

Once that happens, what "--follow" does will match exactly what the
current "blame" internally (and unconditionally) does. The current
"blame" pays no attention to "--follow" because it wants to do the
right thing without letting the broken "--follow" logic to take over
and do a half-hearted job at following renames.

So if we were to do something special for "--follow" inside blame, I
think the right thing to do is probably to silently ignore, and in
addition, accept "--no-follow" and disable the whole-file rename
tracking logic.  When a true "--follow" comes along, we may be able
to rip out the whole-file rename tracking logic from "blame" and let
the version of "--follow" implemented correctly for the "log"
family.
