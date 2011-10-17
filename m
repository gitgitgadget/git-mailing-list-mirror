From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What should "git fetch origin +next" should do?
Date: Mon, 17 Oct 2011 11:34:50 -0700
Message-ID: <7vipnnmppx.fsf@alter.siamese.dyndns.org>
References: <7v7h45s8rh.fsf@alter.siamese.dyndns.org>
 <20111017171041.GA12837@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 17 20:35:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFs1c-0002iY-Kc
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 20:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab1JQSe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 14:34:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57068 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611Ab1JQSez (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 14:34:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C14F152FF;
	Mon, 17 Oct 2011 14:34:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hJmupjSuWdhQuIDcYmyEbH621JE=; b=VuwcGq
	njQ38SgBqA66CC+r6s48enKQh1mGLH/7P/yNWgIAvYUbvKU3wguiZkk/knKtvpHf
	fHd5egRWQCY4c8NooGf0JF5PhsOAhqsskuVK4vfL1t0Bylf4TIe1uTSeve3EMV/0
	crmtgNPbnpQQWIzejOXd+A7VRCUNvZk4PapDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R10a2qXPozSnjk/36oMFGWp1BxQ4kV0w
	ef7dezzvo0kxYTF1RRRUYHUpZIv+vVJUFbHAIG7oXiCg007wCd/AEYbiTZsvV0IP
	zGY6Sf5Rc4CmKuj8RsMSzSh6i269qzg6Gt7McH1RMx4VBKq5LkYqcLMz3Q6ONcRs
	3/bkA/QVIpU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B88F952FE;
	Mon, 17 Oct 2011 14:34:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B92352FD; Mon, 17 Oct 2011
 14:34:52 -0400 (EDT)
In-Reply-To: <20111017171041.GA12837@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 17 Oct 2011 13:10:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3C75920-F8EE-11E0-8BEB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183803>

Jeff King <peff@peff.net> writes:

> I think the exact same confusion exists. I told git to update 'next'
> from origin, but it didn't touch refs/remotes/origin/next.

Except that you didn't tell git to *update* the remote tracking branch for
'next'; you merely told it to fetch 'next' at the remote.

> ...  But I suspect that is not how many git users think of it.

I am inclined to agree that it might be the case; see my other message in
this thread.

> We've discussed this before, of course:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/127163/focus=127215

Yes, you brought up the "remote state as of the time I told git to record
it is a precious piece of information" issue, and I share the reasoning,
hence I am somewhat torn.

We might be better off biting the bullet and do the "rewrite a command
line colon-less refspec using a matching configured refspec iff exists"
and defer the history of remote tracking branches to its reflog in the
longer term.
