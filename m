From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Thu, 27 Jun 2013 14:20:42 -0700
Message-ID: <7vehbnqmhh.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130627201032.GF9999@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jun 27 23:21:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsJcs-0003wL-2v
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 23:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab3F0VUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 17:20:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933Ab3F0VUs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 17:20:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D2F72A8C0;
	Thu, 27 Jun 2013 21:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y2s8g/j0io5OqtOcM5bizRgFSIk=; b=D2ED56
	JSn7l2CxVAmxU/GkP6uB0cGnHmal/AVggmlW5qgXy+9sccET05PfqjDXEHTgst5H
	k0lUBhZjhfb16EIfm5ISyEa+i2KAiax+FwWbgPMZKq3f5gY/bx38pEfqCsG4NgTs
	4nHh4tjdXQb3lNhvspBx0A1nMrxAwduvXlNcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mP12oVBkhSNho+u1/uXQGg3Kn7znsJlv
	aUdEyaAyHmiuFTn8xpWPdI27sUnLbiuV3/v3z5qpRRngeIx6iuNpR6GhFn3O3GHB
	lorJ+KdaLDK922Ma0MN3Kd8Kgm5/bLvY03VYcB1XxT70bln9W84sv0p2zlGtM1q9
	6Hhsbh2hfKQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 020762A8BD;
	Thu, 27 Jun 2013 21:20:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BFA22A8A1;
	Thu, 27 Jun 2013 21:20:44 +0000 (UTC)
In-Reply-To: <20130627201032.GF9999@odin.tremily.us> (W. Trevor King's message
	of "Thu, 27 Jun 2013 16:10:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D55E790-DF6F-11E2-9F9B-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229161>

"W. Trevor King" <wking@tremily.us> writes:

> On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
>> Because letting a trivial merge automatically handled by Git is so
>> easy with "git pull", a person who is new to Git may not realize
>> that the project s/he is interacting with may prefer "rebase"
>> workflow.
>
> Or they may not even realize that they've just merged an unrelated
> branch at all, dragging in a thousand unrelated commits which they
> accidentally push to a central repository without looking,
> contaminating future branches based on the central repostitory without
> drastic rebase surgery ;).  I just saw one of these earlier this week.

I am not sure "running pull and integrate other's work in random
branches" is something the proposed (not by me) change would help to
prevent from happening.

Your "accident user" could have just been on a 'maint' branch,
pulled the 'master' branch which would fast-forward and then pushed
the result back to 'maint', contaminating the shared 'maint' branch
with commits that do not match the purpose of it, which is to hold
only fixes without enhancements.
