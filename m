From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Tue, 25 Jun 2013 15:01:47 -0700
Message-ID: <7vy59xzw6s.fsf@alter.siamese.dyndns.org>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
	<87ip1e2tzx.fsf@hexa.v.cablecom.net>
	<7v7ghtjwbb.fsf@alter.siamese.dyndns.org>
	<8738shi2ht.fsf@linux-k42r.v.cablecom.net>
	<7vwqpshkxj.fsf@alter.siamese.dyndns.org>
	<1372190294-sup-1398@pimlott.net>
	<7v61x127bw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Wed Jun 26 00:01:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrbJD-0001zf-5y
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 00:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab3FYWBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 18:01:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455Ab3FYWBu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 18:01:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F046B2B2EE;
	Tue, 25 Jun 2013 22:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3AdRdClT1BTbyCB5mUNX/BFIkHw=; b=eceZhu
	v+2SZt0QGo9o84W9o3uoWHINRTs+KXop8cslebJs6YW7LwLRnRgEx8gyWnSjxgYo
	rD9Yxrzx1KQ+aNgZLQGq4AZz6yivyLleDegi15gQg+CO4xx32ZCJu3RVz9uLUbi/
	+ws06Qgg6yMCr39PkJ+jWVhcb9J9JAZsp2pcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ID/2uvFcrf30i9WF+OBSuRkeLF+TUIP6
	kKGzOraDaiVIricPaEPhc48OcVjfRAQkga3Y4uVsjJm4RDap5ojj+jky/7uXTQeV
	7FZh6bG/L/v+k1z6GYtV+8grsyIZPIIjPAjEjbcmJL78bD5jsYhFuQVdhTvyN7tk
	tikwkXd+plg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E477E2B2EC;
	Tue, 25 Jun 2013 22:01:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64F562B2EB;
	Tue, 25 Jun 2013 22:01:49 +0000 (UTC)
In-Reply-To: <7v61x127bw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 25 Jun 2013 14:45:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5D2A814-DDE2-11E2-8A35-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229003>

Junio C Hamano <gitster@pobox.com> writes:

I guess I made typoes in the examples that made then unusable...

> I think it is fine not to be too smart, as long as we do not lose
> information that would help the user to compensate.
>
> After all, autosquash will give the user an opportunity to eyeball
> the result of automatic rearrangement.  If the user did this:
>
> 	git commit -m original
>       git commit --fixup original ;# obviously fixing the first one
>       git commit --fixup '!fixup original' ;# explicitly fixing the second
> 	git commit --fixup original ;# may want to fix the first one
>
> and then "git rebase --autosquash" gave him this:
>
(the result of automatic rearrangement should read like this)

        pick d78c915 original
        fixup 0c6388e !fixup original
        fixup d15b556 !fixup !fixup original
        fixup 1e39bcd !fixup original

> it may not be what the user originally intended, but I think it is
> OK.
>
> As long as "!fixup original" message is kept in the buffer, the user
> can notice and rearrange, e.g.

(and the manual rearrangement should read like this)

        pick d78c915 original
        fixup 0c6388e !fixup original
        fixup 1e39bcd !fixup original
        fixup d15b556 !fixup !fixup original

> if the user really wants to.
