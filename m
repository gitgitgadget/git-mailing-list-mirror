From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Add diff --porcelain option for --color-words
Date: Sat, 03 Apr 2010 12:15:42 -0700
Message-ID: <7vmxxk8i01.fsf@alter.siamese.dyndns.org>
References: <cover.1270317502.git.trast@student.ethz.ch>
 <f5741e49b2c09ec76def2d21a84a7da6ff7b8368.1270317502.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Apr 03 21:16:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny8p8-00081a-0d
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 21:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab0DCTP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 15:15:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329Ab0DCTP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 15:15:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4900A6FAA;
	Sat,  3 Apr 2010 15:15:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VDDTGZ+YSPo5c2Io3aDORz3o4hI=; b=iBET9U
	ZCRtpeF+2aNmCRRNAhTouODDuA5fQGXrSwrJjNeg29jLEIE8PZyZawykDTyyxsmq
	8ujYlzvvV3Sc9GgHaGCUrQ9gRTmTamz6zAKAbJg25kwMKhgB7M4JvITWwWPD47bh
	BD6uMLV2kAbCjZChwSkATfbeO+bUSlP+Io8lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AFinYPRXYe7Kj2xmcN935hJKqTJHw5u/
	qNsO7pyrmnrxlV9fzgsSoiQI1q8nw2ZQMxRrUKiYrhjsibKY3TlmHS7Hk5u1O1Cc
	JexOduSvCRm8YOWBx2UdHMz/8cKGTGYUmS4A10RXnD2HEzT396G1pJBNsmNSY395
	EVJ5KQCUy6Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 886BDA6FA6;
	Sat,  3 Apr 2010 15:15:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 859D0A6FA3; Sat,  3 Apr
 2010 15:15:44 -0400 (EDT)
In-Reply-To: <f5741e49b2c09ec76def2d21a84a7da6ff7b8368.1270317502.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat\, 3 Apr 2010 20\:06\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5029535E-3F55-11DF-B1F6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143896>

Thomas Rast <trast@student.ethz.ch> writes:

> This teaches the --color-words mode a new option --porcelain that
> disables color mode again and instead uses an ad-hoc format for the
> word diff designed for machine reading.

How readable can you make this for human consumption while still keeping
it machine readable?  The answer could be it already is human readble.

Two reasons I ask the above question are that I find the feature quite
interesting, and would want to see if it can be also fed to humans, and
that the combination of this new option and the existing --color-words is
misnamed.

What you are giving "git diff" is "word-level diff" as opposed to the
usual "line-level diff", isn't it?  The machinery may have already been
there, but it had a hardwired representation of the result to color pre-
and post- image words, and you are giving the result from the machinery
another representation with this patch.  If you call this --word-diff,
then it would become more clear that --color-words perhaps should have
been called --word-diff=color or something.

Besides, --porcelain invites "what does it do without --color-words?", to
which you wouldn't have a good answer, as non word-diff output is already
machine readable.
