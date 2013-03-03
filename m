From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "graph.c: mark private file-scope symbols as
 static"
Date: Sun, 03 Mar 2013 15:32:08 -0800
Message-ID: <7vzjyk83gn.fsf@alter.siamese.dyndns.org>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
 <87haktwr2a.fsf@pctrast.inf.ethz.ch> <20130303102946.GH7738@serenity.lan>
 <7vk3pob38d.fsf@alter.siamese.dyndns.org>
 <20130303214206.GL7738@serenity.lan>
 <7vppzg9k0n.fsf@alter.siamese.dyndns.org>
 <20130303232413.GN7738@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Lars Hjemli <hjemli@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Mar 04 00:32:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIOY-0003r5-Jn
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 00:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab3CCXcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 18:32:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754663Ab3CCXcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 18:32:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4E2CB2F9;
	Sun,  3 Mar 2013 18:32:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v6llQRXiMyv4yGdQ93DSlmJCr2I=; b=DFzPiV
	Wb0qD3MwLjUL/YPWx2/gX3tcB9lRwC+hVMnzzcLOKqYiS7tjBP6Vue81k78xtzi0
	LCxMy/rOYKej0dENMnK1HIXyLoYHyZ2VSpqoniEqc830E6aQ00LckSp0gWL3SVP6
	BuFP5Ep2GuwpjjyiRp29BErrmDvaYrfdMmdfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q3lK22oYuGI/Y7XYwTLpIFpL6FIvWyYT
	nbi9l/Tu9aOJHqZ3xRBYvbgW6L0NdatTroRKNYslNHjZfhjEWgp5ZR2lV1LHE/5k
	y9x+iZpD11rXxA/gOihEwO3seBogsjDKueUwJ03Pt09oZhoHrXcmxa6PCNI8bSAv
	PitQl4yEX+0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8ED5B2F8;
	Sun,  3 Mar 2013 18:32:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46B87B2F5; Sun,  3 Mar 2013
 18:32:10 -0500 (EST)
In-Reply-To: <20130303232413.GN7738@serenity.lan> (John Keeping's message of
 "Sun, 3 Mar 2013 23:24:14 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91D2F380-845A-11E2-9AF8-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217367>

John Keeping <john@keeping.me.uk> writes:

>> Also it probably is worth adding contact information for folks who
>> work on CGit (http://hjemli.net/git/cgit/ might be sufficient),
>
> The current CGit homepage is http://git.zx2c4.com/cgit/

As the hjemli.net address is what I got as the first hit by asking
[CGit] to websearch, it makes it clearer that we do need such
contact information there.

> I think CGit expects to have to respond to changes in Git, so I don't
> think it's worth restricting changes in Git for that reason - it's just
> a case of exposing useful functionality somehow.

I think you misread me.

It is not about restricting. It is to use their expertise to come up
with generally more useful API than responding only to the immediate
need we see in in-tree users. We want a discussion/patch to update
the graph.c infrastructure to be Cc'ed to them.

For example, with the current codeflow, the callers of these
functions we have in-tree may be limited to those in graph.c but if
there are legitimate reason CGit wants to call them from sideways,
perhaps there may be use cases in our codebase in the future to call
them from outside the normal graph.c codeflow.
