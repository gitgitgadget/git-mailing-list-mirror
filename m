From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can `git grep` have `--Author` option?
Date: Wed, 06 Apr 2016 08:22:16 -0700
Message-ID: <xmqqegaizrrr.fsf@gitster.mtv.corp.google.com>
References: <8737qztya5.fsf@gmail.com> <vpqshyzw9u3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Chen Bin <chenbin.sh@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:22:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anpHn-0006U7-U0
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 17:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbcDFPWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 11:22:21 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751428AbcDFPWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 11:22:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B42545117B;
	Wed,  6 Apr 2016 11:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8qYfiFONKQep4WDw6C6viIZJIg4=; b=x4K98+
	3kxA5lDVKGqeHB6K50ensiEfZkoqWH5rRMeX77fLfpB7etFt4DLJqCL+YG6fA914
	Nh8R1DKlVksRCAWeizrONTQz2sKq+1o4dgResH6Lzq0GHvXvlheccCYPN18xM23V
	pUAK74z7wbOfd+YyZzJu2pCBWQ7n/NZAPI5Es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hO+6MS6FfbDZvtd037lKPrMtmFnoO/vv
	i9QVAZMETjoilWpnltduWW4Wraw64nBCWg5M9qSodCP69EgtzyINx8DWsw0PHOdj
	OkivHWEKRaBsZ6xKOmRQOmjE+V1S5UlMeBbz1wuCgbQQ9srACvJa3yzfjttdcyKK
	AV7suxS9GkU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB01F5117A;
	Wed,  6 Apr 2016 11:22:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0F0B751178;
	Wed,  6 Apr 2016 11:22:17 -0400 (EDT)
In-Reply-To: <vpqshyzw9u3.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	06 Apr 2016 08:05:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 597B542E-FC0B-11E5-8CC0-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290844>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> A "git grep --author" would need to blame all files before searching
> inside them, or grep first and blame each line in the result to filter
> out lines from the wrong author. That would be possible, but relatively
> hard to implement and painfully slow. Which probably explains why no one
> implemented it yet ...

More importntly, it would not be all that useful in practice.  I can
see "git log -p --author=me" might, but people usually go from what
the code does and then figure out who wrote it, e.g. you try to see
if there is already code that does something similar to what you
want to do in the current codebase, and then run blame on the found
block to see what commit brought it in if you want to avoid
borrowing code from questionable parties, not the other way around.

One possible use case would be when you asked to produce a code
sample for interviewing or something, but then "log --author=$me"
may be a more effective way to find one.  It would allow you to
demonstrate not just the quality of code but also your ability to
clearly explain your idea to others.
