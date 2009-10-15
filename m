From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD  was
Date: Thu, 15 Oct 2009 13:34:41 -0700
Message-ID: <7v3a5k4cri.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 22:43:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyXAD-0005UP-E8
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 22:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935491AbZJOUfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 16:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935489AbZJOUfl
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 16:35:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935483AbZJOUfk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 16:35:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91F9D5AF87;
	Thu, 15 Oct 2009 16:34:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=caqVXlH7DvTnKnuenaUWJM4hwt8=; b=lxVCZx
	6nMw/ElsvIIdlNxUfSJHaG/7NqAbNkL+pWUH5wM1LwB9o7wTm8OSWDg93m04i/DL
	HRtDyKIGsxna2QwH4h5hmKlzF2D31JEgseDOLhdxC+43tJX16qXWZYbvtyv6eKqo
	1+Vbj9TJvaBQWc2caeoDJ9/nS915iXzZozwTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8JZ/xK0s7xqvnedjnGgj9ohd/ab4KMy
	xrnTkBx+PgNz2VEGQGG6jpKOWrHMD3GztFUd2m+8yyjgOk+DPPapwM7VoVQJ5kHq
	/jW1/0MZWp7Nv3DRgSrpCm1Q8gK+DUQHL7d0fH/BYFA3ASelbXaeI5OZ2Y6BFWMB
	t4oDxoVsUY8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A01C5AF86;
	Thu, 15 Oct 2009 16:34:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D4945AF82; Thu, 15 Oct
 2009 16:34:42 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0910151523020.32515@iabervon.org> (Daniel
 Barkalow's message of "Thu\, 15 Oct 2009 15\:31\:13 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3044CC6E-B9CA-11DE-90DA-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130420>

Daniel Barkalow <barkalow@iabervon.org> writes:

>  $ git checkout origin/master
>  $ git fetch
>  $ git checkout origin/next
>  Uncommited file '...' would be overwritten.
>
> If HEAD is a symref to refs/remotes/origin/master, and you update 
> refs/remotes/origin/master, git will subsequently see that your index 
> doesn't match HEAD, and when you switch branches, it will try to apply a 
> revert to the branch you're switching to. It's the same issue as pushing 
> into a non-bare repository.

I think the idea here is to allow HEAD to point at outside refs/heads/,
e.g. refs/remotes/origin/master, but forbid commit and other commands from
updating HEAD and its underlying ref via update_ref() unless HEAD is
detached or points at a local branch.
