From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Wed, 14 Nov 2012 16:09:10 -0800
Message-ID: <7v8va3afrt.fsf@alter.siamese.dyndns.org>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
 <7v4nktdwtp.fsf@alter.siamese.dyndns.org>
 <CAEUsAPYvrR6WsVWCvwoEWA21gzL6Sib0sTyx-c_2tH=8ni69yQ@mail.gmail.com>
 <CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com>
 <7v390ccoak.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9DAwaLw2bTqj5x_zxRcFqn7s=nmGi=Jc_SD38vFoszBZg@mail.gmail.com>
 <7vmwykay4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git <git@vger.kernel.org>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:09:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYn1L-0002AT-Eo
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946000Ab2KOAJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 19:09:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945955Ab2KOAJN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 19:09:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22D11A1BE;
	Wed, 14 Nov 2012 19:09:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YwyNBNKsBdShWjLQ7PTYfeqvM+g=; b=ZB/t+A
	rf3KIPNBXfJR/x+pO4lgvTJEUYFSteW6Rl1qQLP0DLUR0Cy2fPcFp40H3Pxl6CLb
	NevYmLhPGB9HfnkocONpLtxyQLkOa6/OqIdprL5tA3kQmRukjkCxysIIDgZTGPSb
	Szd/aW/zA/phBhmZcdd3DIm5euY4gK2OGE1tY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ykunfWOi9bazfkcgzxbkQe+m66BQaqXp
	Jqtjvw+NX8Jc9xBb5+z9juac8LEYL7binBXoVwHheEV/lOV88eWmxfZc5SGJ4lM4
	xHp0r0oaZnAO8Gxl4mWlKjpIYVy2KArD6KYkd9mSNRPMYtd5JLjRtXhf6ybCHV9d
	8G2yvbPxKNQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C1CEA1BD;
	Wed, 14 Nov 2012 19:09:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D138A1BC; Wed, 14 Nov 2012
 19:09:11 -0500 (EST)
In-Reply-To: <7vmwykay4n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 14 Nov 2012 09:32:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEC54EA4-2EB8-11E2-B534-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209762>

Junio C Hamano <gitster@pobox.com> writes:

Addendum.

> In any case, I thought this series was about users who run "push"
> voluntarily stopping themselves from pushing updates to tags that
> may happen to fast-forward, so if we were to go with the
> configuration route, the suggestion would be more like
>
>     [push]
> 	updateNeedsForce = refs/tags/:refs/frotz/
>
> or perhaps
>
>     [remote "origin"]
> 	updateNeedsForce = refs/tags/:refs/frotz/
>
> if we want to configure it per-remote, to specify that you would
> need to say "--force" to update the refs in the listed hierarchies.
>
> Then your patch series could become just the matter of declaring
> that the value of push.updateNeedsForce, when unspecified, defaults
> to "refs/tags/".

The above is not a "you should do it this way" suggestion, by the
way.

I was just explaining what I meant by "it may be a good feature, but
may not necessarily be limited to refs/tags" in my earlier message
in a different way "... and a possible design that lifts the
limitation may go like this".

I am *not* convinced that the "refs/tags/ is the only special
hierarchy whose contents should not move" is a bad limitation we
should avoid, but if it indeed is a bad limitation, the above is one
possible way to think about avoiding it.

Thanks.
