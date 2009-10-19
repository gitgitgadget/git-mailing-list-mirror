From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebase fails because of apply.whitespace setting
Date: Mon, 19 Oct 2009 16:53:52 -0700
Message-ID: <7vpr8juei7.fsf@alter.siamese.dyndns.org>
References: <4ADCF6E9.8090704@feurix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Feuerstein <john@feurix.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 01:54:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N023C-0004Zz-91
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 01:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979AbZJSXx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 19:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755913AbZJSXx4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 19:53:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbZJSXxz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 19:53:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F5BE5FA5D;
	Mon, 19 Oct 2009 19:53:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9RbZ7klyLvkOSKi99A+AhjrxSKU=; b=ybN+c6
	uQN1FIQThDA8q0IooywlzBixdPQ7xWieb3ZY/daBFvl7BhnIKLVSp0LoL2Mc4a0L
	DhOXMB4lhHcyshHG/sAUvUTBBTbX20YHz37imS+O9S5rRkah9sRy92BIHNlz9EwT
	09XBk1svtRYgJmrOpzk9RYV9d7BZbFzGNeQ7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U7MymK4FaXr5Nd5v5E/Bweep3Eynh+aX
	xsnEEs/6KrGiiPo/YlTAJujeRCQNt0RD1w+Hr9QVElbJx8PXUUG4IMcHPdSqt+kC
	YRnVjsKOGURjzM+X+pagQZaso3z5SM4zw+KOScT4/2YeNsrolZU18S0e9Cmgh9fO
	+igkw/BWgg8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D5C25FA5B;
	Mon, 19 Oct 2009 19:53:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3A845FA5A; Mon, 19 Oct
 2009 19:53:54 -0400 (EDT)
In-Reply-To: <4ADCF6E9.8090704@feurix.com> (John Feuerstein's message of
 "Tue\, 20 Oct 2009 01\:31\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA4DC04A-BD0A-11DE-9C6F-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130745>

John Feuerstein <john@feurix.com> writes:

> I had to rewrite history recently (ugh -- private repo, not shared with
> anybody) and wanted to change the commit message of the root commit.
> During this I've encountered a failing git-rebase if apply.whitespace is
> set to "error".
>
> Should whitespace-errors really be detected when rebasing?
> (or worse: be "fixed" without explicitely asking for it when using a
> global apply.whitespace=fix setting)

I've seen this argued both ways.  Some people seem to be happy that they
can use rebase with whitespace=fix to clean up their mess.  Some people
quite rightly oppose it (I am slightly closer to the latter camp myself,
but that does not count that much).

I'd agree that whitespace=error won't help anybody here.

Perhaps rebase can be taught to take --whitespace=warn from the command
line to override whatever is in the configuration?
