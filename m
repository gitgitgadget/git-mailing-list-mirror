From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Thu, 24 Jun 2010 13:21:49 -0700
Message-ID: <7veifwchb6.fsf@alter.siamese.dyndns.org>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
 <20100624111757.GB3453@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:22:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORsw2-0007rb-Qw
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab0FXUWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:22:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab0FXUV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:21:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E36F7BEBD7;
	Thu, 24 Jun 2010 16:21:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=49nHpVMklB9K8iS1mZV4tOn0j+U=; b=N0IxHq
	lb8/Lrma8nANATSSXdsYenJxng6Gyn2Aw/uBU9EGSMqj70gdqLpFyn6adLmYGflH
	2+lS2g9BXEeH+wv7s1DxgNrobLGGvctY8M107tMAMBXpbnZGu2BnxEhi7wzEoU4L
	tQPrGLt9ik0d0w3jovXwLrKyw6/obhC82GUCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qOzqdAfGxsDNPVPN6qoMGdUDaxn2Exs5
	kLeFkkUldrN5s5yqHjms9AF53unvM+INjusYlYDS277WSRAvcTXMEjlQiL0z++pA
	i7+g2+CpOzg3Q3Y8B2NsVUFWJD5bXOElP4/xDL4cdJB50jqKefcaTwNwjmCErELe
	BhIGtpHrvKs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACAD1BEBD5;
	Thu, 24 Jun 2010 16:21:54 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E596EBEBD4; Thu, 24 Jun
 2010 16:21:50 -0400 (EDT)
In-Reply-To: <20100624111757.GB3453@pvv.org> (Finn Arne Gangstad's message of
 "Thu\, 24 Jun 2010 13\:17\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2185ACF0-7FCE-11DF-B631-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149636>

Finn Arne Gangstad <finnag@pvv.org> writes:

> On Wed, Jun 23, 2010 at 03:09:32PM -0700, Junio C Hamano wrote:
>
>> * eb/double-convert-before-merge (2010-06-16) 1 commit
>>  - ll-merge: Normalize files before merging
>> 
>> If running git-to-worktree and then worktree-to-git _fixes_ something, it
>> means that these are not roundtrip operations; there is something that is
>> fundamentally wrong.  The commit log message doesn't help explaining it,
>> either.
>
> If .gitattributes is different on the different sides, or if you
> enable autocrlf, the current repo contents may change after
> git-to-worktree and worktree-to-git again.

IOW, g2w-then-w2g may not be an identity function.

If we were to encourage use of this codepath to wider audiences, we may
need to have a document for people who write smudge/clean filters.  In
order for the result to be stable, applying g2w-then-w2g once again on top
of the result of running g2w-then-w2g on anything should be no-op, no?
