From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 09 Dec 2009 11:46:01 -0800
Message-ID: <7v1vj4orra.fsf@alter.siamese.dyndns.org>
References: <20091208144740.GA30830@redhat.com>
 <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
 <20091209093758.GA2977@redhat.com>
 <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
 <20091209112237.GA27740@atjola.homenet> <m2pr6ocqrb.fsf@igel.home>
 <20091209120610.GA29430@atjola.homenet> <20091209120748.GI2977@redhat.com>
 <20091209130653.GA30218@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 20:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NISUU-0006cw-Ai
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 20:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323AbZLITqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 14:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757256AbZLITqN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 14:46:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814AbZLITqN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2009 14:46:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73D4986E19;
	Wed,  9 Dec 2009 14:46:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8o6eryZKUamF
	eMQhLprDVdLSk+M=; b=TAEyJgVqx4X5sc0B/Hy3e++0b/ahpd+sg/M4mffiZYKu
	O5gH5gcILNCM9DjR2iHzin4lqhzXB7FYRWhaapBTpaPGnLuWAzjMX2odg9FKt7oM
	FXtn42hdYZYkgATlM3L9CrEvKMZP73YlY4UxsONCDNGCCb0T6NRVfljhagG4jCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K8DDSn
	2ZCRSckhryUywOX2tI541sqbvydWTcpGzO1uBzxWf6aj8dcUNH5uR9uHQqxkeHAq
	FOIM7pmn/05pM2N9jUYJunXo47c2didLR2OR3IvGyLEtw1Nnpj9SXaZAPHMCZW4F
	2pzIJbb2zVMXyj0+UP7QKnjCtT/pLxLL41o9Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 777FE86E17;
	Wed,  9 Dec 2009 14:46:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F23986E13; Wed,  9 Dec
 2009 14:46:02 -0500 (EST)
In-Reply-To: <20091209130653.GA30218@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s message of "Wed\, 9 Dec 2009 14\:06\:53
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80AE0056-E4FB-11DE-955E-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134993>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> "merge --squash" is one of the things I really dislike, because it tu=
rns
> off the "history" part of the merge. You can say "Merging in git is a=
bout
> histories, merging in svn is about changes only" to describe the majo=
r
> difference for the merge commands in the two systems... "But then
> there's --squash which turns git into svn".

I agree with this to some degree, but I do not offhand think of a bette=
r
alternative. =20

At the first sight, it looks as if what "merge --squash" does was
implemented as a new option "--squash" to the "merge" command merely
because the way _how_ it internally needs to compute the result was
already available in the implementation of "merge" command, and not
necessarily because _what_ it does was conceptually consistent with the
way "merge" works.

But at the conceptual level, "merge --squash" is a short-hand for this
command sequence:

    git rebase -i HEAD that-branch
    ... make everything except the first one into "squash"
    git checkout - ;# come back to the original branch
    git merge that-branch ;# fast forward to it

So after all, it is "merge it after squashing them".
