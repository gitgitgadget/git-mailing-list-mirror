From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rebase -i: support --root without --onto
Date: Tue, 26 Jun 2012 13:05:50 -0700
Message-ID: <7vfw9hbzz5.fsf@alter.siamese.dyndns.org>
References: <20120626133339.GT9682@arachsys.com>
 <bdb45972685db8899a46ebc62213e56c9a3d0c94.1340717793.git.chris@arachsys.com>
 <7vtxxxc22x.fsf@alter.siamese.dyndns.org>
 <20120626193817.GD30779@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 22:06:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjc1U-0001qP-Sy
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 22:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab2FZUF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 16:05:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617Ab2FZUF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 16:05:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DA5F9EA0;
	Tue, 26 Jun 2012 16:05:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DwPJOGnT0w0mlSpcjHiOVDoworw=; b=Qmjb5K
	opwk6umxFJSruiIWfItp9MEXYhVG28YvkvlZ7JsIeCkZL+I0xhetGdyiVTgUUDL+
	yOoR277QGQzH8w93F7sGP7+LgN/csEOGVvtN1TFHZ2sRGEEQYmttqwNxAi0k8VdF
	GkSdSmPe3fpaP3K8vjPKut5T5gIXfw6msfCAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o1ExseXAI1EGvCc2lFRGvaadrJBa2ipr
	LUFwFKRJw/qEaHEg79J4CzTZHDgmTuWv6+k/D5qZKNdgQliUeIk2n1QaMVTJhnFY
	TxOa8Ry+Ss7drwu0f4mh6/dM/dH6sLjKMBNDOL+E16Cb9zQYVaae03QnzGoDR9wA
	onsWrHI3y1E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 445AC9E9F;
	Tue, 26 Jun 2012 16:05:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC1FF9E9E; Tue, 26 Jun 2012
 16:05:56 -0400 (EDT)
In-Reply-To: <20120626193817.GD30779@arachsys.com> (Chris Webb's message of
 "Tue, 26 Jun 2012 20:38:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 575CA02A-BFCA-11E1-BD0D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200679>

Chris Webb <chris@arachsys.com> writes:

>> In short, my questions are:
>> 
>>  (1) what is the purpose of the first "commit --amend" to update the
>>      sentinel root commit?
>
> This first commit --amend isn't supposed to change the empty tree in the
> commit: the tree and index should be unchanged at this point. I'm only
> running it to set the commit message and author.
>
> The idea here is that I want the author and commit message already in place
> if cherry-pick (and hence pick_one -n) fails so that we drop out for the
> user to resolve conflicts.

Very understandable.  Perhaps in-code comments would have helped.

>>  (2) Is the purpose of "pick_one -n" done here to create a root
>>      commit?  Does it always do so correctly?
>
> pick_one -n cherry-picks the changes without actually making a commit. It's
> already used in the squash case, so should be well-tested.

OK.
