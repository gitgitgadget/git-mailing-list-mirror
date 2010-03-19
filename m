From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow passing of configuration parameters in the command
 line
Date: Fri, 19 Mar 2010 12:36:38 -0700
Message-ID: <7vmxy4kss9.fsf@alter.siamese.dyndns.org>
References: <81b0412b1003190742v6e5577c9wb121d5e3cbc9fccd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 20:36:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsi08-0002Go-UZ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 20:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab0CSTgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 15:36:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0CSTgv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 15:36:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B94A6A3168;
	Fri, 19 Mar 2010 15:36:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ihbx0jHANw3F2G8QNSw7hNfJnTA=; b=uS5NDQ
	RqH5SDv+5pVCeFds1MrlgiYQW9G92OGIud+zJRWukEEdbv9M3APpSzLJcDOv4lVo
	0PGnni0G1F59Zqm+/lgS0rWrXN++F8fWtQGgcNrcfmIhL3MotnenVmzEHtyNrwau
	6d3ArhPMvlzRwgQWrz6obeGACCjaWI7tucMfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZrqerL1at5p0vJh9jC3+WBkRPGGJoh9T
	U0j2PnpsmIvH6M2zQ4FSunWgHpAFqdCc00Il9KsLYCrLGUbN+Shm9CZ+7oRK+pYr
	oqEw9jOp6K9fg+6VvKydriV6NJzS+bt6kD7lLxm0st6rjHVgyoVmWDvLHBhQNEyy
	mGa2cmSpgBI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60588A315A;
	Fri, 19 Mar 2010 15:36:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B893A3155; Fri, 19 Mar
 2010 15:36:39 -0400 (EDT)
In-Reply-To: <81b0412b1003190742v6e5577c9wb121d5e3cbc9fccd@mail.gmail.com>
 (Alex Riesen's message of "Fri\, 19 Mar 2010 15\:42\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C09257B2-338E-11DF-8935-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142640>

Alex Riesen <raa.lkml@gmail.com> writes:

> The values passed this way will override whatever is defined
> in the config files.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Someone wanted to have this once. I accidentally remembered
> that when I wanted to temporarily set some config parameter
> (format.suffix?). From looking at code it seemed simple enough,
> so I did it.

How does this interact with core.worktree and the setup sequence in
general?

By "setup sequence", I mean something I tried to extract from Nguyen here:

 http://thread.gmane.org/gmane.comp.version-control.git/141962/focus=142001
 
During the process of finding the repository (.git/ or project.git/), we
would open its config to check the repository format version, that that
would be the earliest point we might decide where the work tree is (or if
we have work tree at all).  Where should this new mechanism hook into the
sequence to give users an expected behaviour (what's expected in the first
place)?
