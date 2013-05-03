From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Fri, 03 May 2013 16:45:20 -0700
Message-ID: <7vr4hnwru7.fsf@alter.siamese.dyndns.org>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<7v61yzyavo.fsf@alter.siamese.dyndns.org>
	<CAMP44s2o2EvmSwB0P_WkudxQWigUV20+ECio1rUGPt8qF5=0Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 01:45:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYPfM-0007ai-5N
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 01:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763939Ab3ECXpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 19:45:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763923Ab3ECXpX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 19:45:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB23E1B76A;
	Fri,  3 May 2013 23:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9DKnCUz5JPAaujUYBLHD7jlQn6A=; b=SwTg67
	eTPLnZStaiARbBfiLQZGQQXnOU6QOtRzUSgFR4VCbUJ/BNBFaHBdftIa6ZGdw890
	RIuTPcosLOptfdg4kiM09ApknFS/E0vj0lKUTeb9R4AWTi/ITAHtWV5IufQzjzKr
	FibSVAZiG46pqNBSIGiA+TQIofTebsW6jVeUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ts8Bu5o2Qnhj17cmDGZ4QtxYYC5hOOYq
	byDZd02WocGbRR6ra6QrRWtw7Z+gOaaSNbchfVVdpNMOS1R5ljd24XtfZd9FYm8T
	TRJj1QweXb/1urfLGy2SsGjEkKRVauoCgIICQl//F5rSBO996dqZWEYqFxu2Lxpc
	1x4K5dleUWE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE5201B769;
	Fri,  3 May 2013 23:45:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BB4F1B766;
	Fri,  3 May 2013 23:45:22 +0000 (UTC)
In-Reply-To: <CAMP44s2o2EvmSwB0P_WkudxQWigUV20+ECio1rUGPt8qF5=0Ow@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 3 May 2013 17:19:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8506FF86-B44B-11E2-80B2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223335>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> A safe and sane approach may be to teach these an option to tell
>> them to omit non-commits or to emit all kinds, and make remote-bzr
>> use that to exclude non-commits.
>
> This has nothing to do with remote-bzr, or any remote helper. These
> objects are not useful, not even to 'git fast-export'.
>
>> If the defaults is matched to the
>> current behaviour, nobody will get hurt
>
> Changing nothing always ensures that nobody will get hurt, but that
> doesn't improve anything either.

I do not quite follow.  Allowing existing code to depend on old
behaviour, while letting new code that knows it does not need
anything but commits, will get the best of both worlds. The new code
will definitely improve (otherwise you won't be writing these
patches), and the old code will not get hurt. Where is this "doesn't
improve anything" coming from?
