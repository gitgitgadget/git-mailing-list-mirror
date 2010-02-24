From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Submodules implementation
Date: Tue, 23 Feb 2010 16:40:57 -0800
Message-ID: <7vvddnwjmu.fsf@alter.siamese.dyndns.org>
References: <k76e57-g67.ln1@burns.bruehl.pontohonk.de>
 <32541b131002231559r49fc31e0i4ce46869d27190c8@mail.gmail.com>
 <201002240115.53771.bartoschek@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Christoph Bartoschek <bartoschek@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 01:41:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk5JT-00062f-Ls
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 01:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab0BXAlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 19:41:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab0BXAlI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 19:41:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA4739CBEA;
	Tue, 23 Feb 2010 19:41:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T4z/1VQCJpZ/KKNnSBtIFcx+Y+0=; b=ulnICM
	Ql1qq8UQfebb9dp8eRjGfXYocFpFB8vmTQ4e2YBanMaYwKIFkxbWs0aef4zc1+Ar
	Q5ikBsKOuH2MtVn2RwqpMhlBaAFPDINWWZn6QPT+PQjroGaXil95WN0FmZ68BQDM
	8TKUo1kHqQLNMxwNso8FrUsq+pjSm0P5HlS0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s6IQgD+mNVo+Eb6T4hDvexultA8rGUE0
	HKRcNUM5nbHpbtCBUK9jtqP+GDm1S1hNAIT1PcWtu6vMOsaAD4p95XOFgLZpaQWF
	cAGKeX+huOqeckaqUm0M3pHZQKTvjXCYTXVlz6ImHwAgRMPigO8Nw6/vz2z0Vam9
	d5fKY2pSv5Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A7E469CBE4;
	Tue, 23 Feb 2010 19:41:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8FC19CBDF; Tue, 23 Feb
 2010 19:40:58 -0500 (EST)
In-Reply-To: <201002240115.53771.bartoschek@gmx.de> (Christoph Bartoschek's
 message of "Wed\, 24 Feb 2010 01\:15\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4973981C-20DD-11DF-B8DB-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140883>

Christoph Bartoschek <bartoschek@gmx.de> writes:

> I see that in the submodule there is a .git directory with its own objects.  
> This does not look like as if the submodule objects are part of the 
> superproject.

Because they largely aren't.  submodules are freestanding projects on
their own right.

One of the primary design decisions was to support the use of a
superproject without having to clone/checkout all the submodules.

You may want to check earlier design discussion thread:

  http://thread.gmane.org/gmane.comp.version-control.git/31941/focus=32944

It is a huge thread and some of the messages there might be nothing more
than uninformed and unworkable handwaving, except for the ones from Linus
and some others.
