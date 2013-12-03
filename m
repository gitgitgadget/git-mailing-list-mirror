From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Tue, 03 Dec 2013 10:32:20 -0800
Message-ID: <xmqqtxepokej.fsf@gitster.dls.corp.google.com>
References: <1385922611.3240.6.camel@localhost>
	<20131201190447.GA31367@kaarsemaker.net> <529DF64A.70801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org,
	ingy@ingy.net
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 19:32:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnulo-0003XS-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 19:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab3LCScZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 13:32:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab3LCScY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 13:32:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D71F75594B;
	Tue,  3 Dec 2013 13:32:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tcGderPeZ4kl314lRvleH9jm4cY=; b=DRRgiC
	peNghk9CqwOkbmzOD/dMRgIfpMPSfXFIzyzLZkBJWk7nJ7BwBpT4N5krdma9ZE87
	c7aLArJpMAcQEC06H23ogseLnAgD7KSgetWwU4nqApPf9bKAcBwrvX125KpZH/gx
	LBRbzgbBs2EQKfh0eyxqjiiXmyJQuC9QwATNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j/jJw2rLH63QsyQ4316OF3GpnAjOVAqb
	IabJTdQemQvxa+9LRaqxXKA+ivoTQyRmT2V1FlTm4oeiVDTkjPfiqAeEwQpsWeTj
	29TW5g9SzXBeUlvh/s8E7G3226kQeac+JZ7dKnArCOU8l7bYbW5k9UOI9DhGY5cJ
	vTIdBcs7SGY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7E4355949;
	Tue,  3 Dec 2013 13:32:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2721A55945;
	Tue,  3 Dec 2013 13:32:23 -0500 (EST)
In-Reply-To: <529DF64A.70801@gmail.com> (Karsten Blees's message of "Tue, 03
	Dec 2013 16:18:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40423D7E-5C49-11E3-9817-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238709>

Karsten Blees <karsten.blees@gmail.com> writes:

>So I figure that GIT_DIR is not meant to _rename_ the ".git" dir,
>but to point somewhere _outside_ the worktree (or somewhere within
>the .git dir).

Correct.

> If we don't want to support this, though, I think it would be more
> approrpiate to issue a warning if GIT_DIR points to a worktree
> location.

But how do tell what is and isn't a "worktree location"?  Having the
path in the index would be one, but you may find it out only after
issuing "git checkout $antient_commit".
