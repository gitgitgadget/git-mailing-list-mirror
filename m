From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reserve a slot for argv[0] in default_arg.
Date: Sun, 04 Oct 2009 15:20:21 -0700
Message-ID: <7v4oqen6my.fsf@alter.siamese.dyndns.org>
References: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
 <20091004133333.GA13894@sigill.intra.peff.net>
 <20091004141355.GA15783@eideticdew.org>
 <20091004182746.GA22995@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petter Urkedal <urkedal@nbi.dk>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 00:23:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuZUK-0003Pv-LC
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 00:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZJDWVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 18:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbZJDWVP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 18:21:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbZJDWVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 18:21:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC4D64B635;
	Sun,  4 Oct 2009 18:20:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UDlghqz7pWahzQWpOYZ0PA8jN1o=; b=rf1XNDagRb24/HXGSLwsIZy
	++VpQZIfwHw6tISmS5eG+CmoIlYjqOEoq1Qs8N8hdzYuVaj7zI2IgIGpnxtiGOhK
	0zGqG1tsCfytA9fMKfhq8msRLbWj2+pImi8UzNqBsCLayqZbt8R9Quf6yvgiFWIw
	PEYpdtjMT6RZMtYu6nJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=eQWqAOs6qiWMerXrAxbT1NN+sLL1/Mxm2aNBQwOBiKqt2r3br
	N4CUvJUXM7yANsgnOoiSbodLEgalH1MB8jvsZQcGEPwyiPY+UnZL+z2zCvvlUHZt
	KSGFSY+XOo6Vjyq4vBpj630kziv88pjsqjMy9RvoNJ3980DynVi4qMrn2g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 887564B634;
	Sun,  4 Oct 2009 18:20:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3FCC4B633; Sun,  4 Oct
 2009 18:20:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1E75C784-B134-11DE-A312-92E639D9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129521>

Stephen Boyd <bebarino@gmail.com> writes:

> On Sun, 2009-10-04 at 14:27 -0400, Jeff King wrote:
>> 
>> Ah, thanks, for some reason I wasn't able to produce it before, but I
>> can easily replicate it here. I think it's a regression from converting
>> show-branch to use parse_options, which happened in May, but I didn't
>> actually bisect it. I'm not sure showbranch.default has worked at all
>> since then (which I guess goes to show how many people are actually
>> using it).

It is a command specific aliasing mechanism; not even I use the feature
these days, since "alias.*" is much easier to use.  But there is no strong
need to remove it either; it is not too much hassle to keep it for people
who do use it.  Perhaps deprecate it and remove it in the long run?

> Correct. Junio sent a patch to fix this problem in June[1]. I guess he
> must have dropped his own patch, or he wasn't satisfied with how parse
> options clobbers things.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/121142

I had it kept still in my Inbox; thanks for noticing.  Petter's patch does
essentially the same thing, but the old patch had a better log message
that described where in the history the fix should apply, so I'd probably
use that with your test squashed in.

Thanks.
