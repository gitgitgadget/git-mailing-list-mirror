From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD} Use regex's in :/ revision naming machinery
Date: Mon, 05 Apr 2010 18:51:29 -0700
Message-ID: <7vr5mtl55q.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 03:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyxxB-0004Dr-JL
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 03:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab0DFBvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 21:51:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444Ab0DFBvj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 21:51:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A20FA8BC5;
	Mon,  5 Apr 2010 21:51:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ABmY1dqbHl7YXEgADc9Ibsblmto=; b=l3NsDg
	eFhFEQqWPO4t3DfamGGtfZqGl05vSw+VF6rVzCuo4Y4ekG+VMv2r4hc0TDvKlw2L
	KFoX60Jw3guUmmm5fJLiNdHDNWe2kfbG+SaBCi4h6+MnfkowXiY9Yi9BJvk9QLHX
	VZfjYOiUy3UWgwkiAR89a/U8iKiXcgSwWDD+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G05ONiw1zdj1FVTX460xNuzys96z32I6
	1iaIrW8nsE7hNPUCsHTBrYbYIikU5Kvut/IFxa74emvw3FMUdRUC1DUPBFtWp47F
	Mr9v6y3cI1RpsXpS5+Fp0I5OVn5KtXD+kl4obPe6XWBYW446zOfOW3GTVtDbaFPa
	uaVS5gb2nVA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C067A8BC3;
	Mon,  5 Apr 2010 21:51:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77FBCA8BBF; Mon,  5 Apr
 2010 21:51:31 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org>
 (Linus Torvalds's message of "Mon\, 5 Apr 2010 16\:00\:59 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE0A62B4-411E-11DF-803F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144083>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So this is very much debatable, but I'm including a patch for the 
> discussion to start.
>
> I never use ':/', and part of it is that it's so horribly cumbersome. I'd 
> _like_ to use it to do things like 
>
> 	gitk :/slabh..
>
> which would (right now) show what happened since I merged the 'slabh' 
> branch. But that doesn't work, I would need to write it as
>
> 	gitk :/"Merge branch 'slabh'"..

A related but a larger issue is that I suspect this "two-dot" would not
work, as the syntax looks for "Merge branch 'slabh'.." (two-dot taken
literally).

I also happen to think that the current ':/' is more or less useless
because you cannot tell it to start digging from only these branches, and
it becomes dice-throwing which commit it would find.

Compared to these, I don't think anybody has much against using regex.  I
personally am all for it, but I am not sure how much regex makes it more
useful.
