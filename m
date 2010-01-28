From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] filter-branch: Add tests for submodules
Date: Wed, 27 Jan 2010 16:14:07 -0800
Message-ID: <7vfx5rnl0w.fsf@alter.siamese.dyndns.org>
References: <201001280041.23182.sojkam1@fel.cvut.cz>
 <1264636547-24496-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net,
	Johannes.Schindelin@gmx.de
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Thu Jan 28 01:15:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaI2j-0000mH-Q6
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 01:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab0A1AOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 19:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556Ab0A1AOU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 19:14:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab0A1AOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 19:14:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB6E694623;
	Wed, 27 Jan 2010 19:14:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SL7oDymA7shxRvqoOo6Bx8+nw5o=; b=jY+vz3
	42reCaRH7q+wk10l821NjebwBqWEOqNcNzKTXg88wAX5PvaMbyuY2meC5jm0PSDt
	yO9gzfcC+VGwvdPhY2kHObeTBBYHTF89l6hLnmKkjptZE+VTPOeCE4Tr2LQiBC25
	oA3O6SZhzv3kTd49Qev8TzneK107lAuheZKdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RJQjalZytTepqZGrlUryT2FaNcswlld2
	p8Xm8d5uAJGYu6mM79LJZLcZ59oDryE7/2knFHp/wY0i3Yya3cFPqpp3oQl9/Cqk
	tuH3JvU32OKCrIh7XymBfgFzQxZMBaSmoxWOdRyZtaIVVRpIMWIIrxn/jns8JhUj
	UjfezhEsEBg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9967594622;
	Wed, 27 Jan 2010 19:14:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FCE99461E; Wed, 27 Jan
 2010 19:14:08 -0500 (EST)
In-Reply-To: <1264636547-24496-1-git-send-email-sojkam1@fel.cvut.cz> (Michal
 Sojka's message of "Thu\, 28 Jan 2010 00\:55\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10A0D9E6-0BA2-11DF-AA86-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138211>

Michal Sojka <sojkam1@fel.cvut.cz> writes:

> There are three important tests:

It is unnecessary and counterproductive to self-proclaim the importance of
a patch or new tests.  If anything, what are important are not tests
themselves but the conditions that they check, so "Add tests to check
three important cases:" is slightly more palatable.

I'd suggest to just start with "Add three tests to make sure:".

> 1) 'rewrite submodule with another content' passes only with the
>    previous patch applied.

Sorry, but I think I am missing some context here to understand this
sentence.  Which previous patch?

> 2) 'checkout submodule during rewrite' demonstrates that it is not
>    possible to replace a submodule revision in tree-filter by checking
>    the submodule out and reseting the submodule's HEAD. Fails both
>    with and without the previous patch. This is because filter-branch
>    sets GIT_WORKING_TREE to "." which causes clone (called from
>    git-submodule) to fail.

I thought you agreed with Hannes that this is not something we would even
want to support?

> 3) 'replace submodule revision' shows that replacing submodule
>    revision is possible by direct index manipulation. Succeeds both
>    with and without the previous patch.
>
> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
> ---

Thanks.
