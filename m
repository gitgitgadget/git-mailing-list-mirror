From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Allowing push --dry-run through fetch url
Date: Sun, 08 Nov 2009 11:23:27 -0800
Message-ID: <7vfx8obz2o.fsf@alter.siamese.dyndns.org>
References: <20091106073707.GA14881@glandium.org>
 <7vfx8s0yy1.fsf@alter.siamese.dyndns.org>
 <20091106095357.GA13389@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Nov 08 20:23:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7DMT-0001fu-VU
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 20:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbZKHTXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 14:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbZKHTXa
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 14:23:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbZKHTX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 14:23:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE10A78B5A;
	Sun,  8 Nov 2009 14:23:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L4NotO5+9ysfIu77m+O6NJVUY1Y=; b=i2QpMO
	5IJOOZtyDxTmu6X2uXkytZiYgIRynlG0SEBW+nhCivSuXEFZjX88DUpW1aH1+7al
	GuxkLYBntSGqcxbaJMNwjOtu7CGpRGwE2QD/SmYQ/Q6SxCvg4gm6K18K9ErZMWLX
	Rd2DGnTt+s/bHCIrqDF3ztEsxHcPEiELnAl38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GSYZEXCTVJUzyyBZ1ExKeL8J/4tWrPIS
	MbyClsB6L6vhqeWdGUf4Oinst6kqlw0ekUROacSGTzQvYRPG8khP7zHDvmJisPcX
	KKqPIjREnYhkFUwU/PhCg9XW66gqeaN+bStRahi4RPC7MjsKTvR8GY/8g0stSNhd
	y4EL+nRChT8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF53D78B59;
	Sun,  8 Nov 2009 14:23:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31D1B78B54; Sun,  8 Nov
 2009 14:23:29 -0500 (EST)
In-Reply-To: <20091106095357.GA13389@glandium.org> (Mike Hommey's message of
 "Fri\, 6 Nov 2009 10\:53\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 336E7590-CC9C-11DE-821E-7C40EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132413>

Mike Hommey <mh@glandium.org> writes:

> Usually, when I run git push --dry-run, it's to check that what follows
> (usually the refspec part) does what I want it to do, such as not pushing
> tags I didn't intend to push(*), and stuff like that.

Ahh, that one.

That reminds me of a topic that we discussed but went away without
reaching the conclusion on adding a "confirmation: are you sure this
pushes what you want?" to the command.  I had a doubt about the patch back
then which was that it hardcoded a tty interaction and it would be hard to
retrofit it to help GUI frontends (so my suggestion was to use something
like hooks mechanism, perhaps --confirm=this-script and allow it to do its
GUI thing), but thinking about it again, they can always use "expect" to
drive the interaction with the confirmation prompt, so it may not a big
deal after all---we might want to resurrect the topic.

That was an unrelated, independent thought on your comment, but if we did
so, you might not even have to try to use --dry-run on git:// transport.
