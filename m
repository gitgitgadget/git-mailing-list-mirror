From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal for pruning tags
Date: Fri, 06 Jun 2014 10:18:40 -0700
Message-ID: <xmqqa99qq7m7.fsf@gitster.dls.corp.google.com>
References: <CAHd499BLX3q2FHLfFpq_14w2mmosywfRqMHVjkke0BRhAAjx7g@mail.gmail.com>
	<xmqqoay7rsgd.fsf@gitster.dls.corp.google.com>
	<CAHd499A2c09am7iFU9st-9MiNqBh_2SSyMqm+54cKL+Yq27fWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 19:18:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsxn1-0003IA-Fv
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 19:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbaFFRSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 13:18:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54664 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbaFFRSq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 13:18:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 188861BD49;
	Fri,  6 Jun 2014 13:18:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YwJtmEsl95jhp+g+IcrlAf/rQi4=; b=HsONBa
	0L4dlnql9OLYkpr7sDZOjUiHrG9udjcptknDLrp1qmG46f7On5Mt+kt7gMpnTgiR
	aTOxP3JZQOnw+WMnlMGAsmzlqNiEgM4KILJKprW420c6BfOC3ryBV4N3AtjEZXXy
	psu5IHX2SnrzXOyGFonhGsmcvGPqr4NjhwlGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tj1T6W/RUxHje7KqH4jhsrYzfJ0vVmc7
	g8ZkhyVz7XxAqqRzOXvLsoPQrhxAdDWn/Aa+kd8u1C5G8VzgOg7a3OIgkJVoCMnf
	U27EUePej5Tricw1xryaf4nRCSz9r1PBnVwUGqFap+N380VBkrixB+J9RwbD9phn
	91xQzmUyYAo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E5BE1BD48;
	Fri,  6 Jun 2014 13:18:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 56D1D1BD42;
	Fri,  6 Jun 2014 13:18:42 -0400 (EDT)
In-Reply-To: <CAHd499A2c09am7iFU9st-9MiNqBh_2SSyMqm+54cKL+Yq27fWA@mail.gmail.com>
	(Robert Dailey's message of "Fri, 6 Jun 2014 08:54:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9BAC8D5E-ED9E-11E3-9408-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250950>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> ... Having git clean up tags
> automatically would really help with this, even though you may not
> feel it's the responsibility of Git. It's more of a usability issue,

I agree with "Having ... help with this".  I did not say at all that
it is not something Git should and can try to help.  I also agree
with it is a usability issue.

The thing is, the word "automatically" in your "clean up tags
automatically" is still too loose a definition of what we want, and
we cannot come up with a way to help users without tightening that
looseness.  As you said, you are looking for something that can tell
between two kinds of tags that locally exist without having a copy
at the 'origin':

 - ones that you do not want to keep
 - others that you haven't pushed to (or forgot to push to) 'origin'

without giving the users a way to help Git to tell these two kinds
apart and only remove the former.

So...
