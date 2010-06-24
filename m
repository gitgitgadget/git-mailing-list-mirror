From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Thu, 24 Jun 2010 15:48:36 -0700
Message-ID: <7vtyosnj23.fsf@alter.siamese.dyndns.org>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
 <20100624111757.GB3453@pvv.org> <7veifwchb6.fsf@alter.siamese.dyndns.org>
 <40D1B374-E80A-4BA2-B3A2-142E8256C23E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 00:48:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORvE3-000857-Oh
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 00:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab0FXWsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 18:48:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856Ab0FXWsq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 18:48:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E77BBE2FF;
	Thu, 24 Jun 2010 18:48:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b142FiG3OgB2QeCLuusZ8rzKCgo=; b=lMLPEr
	K8ldGzcpUIrd64yW2w3OuUWE0QzMSGFfqcSR+WxVDMp9dhqHlbyqLRVUxGhytIdK
	LaywTPIP34MPG9rjSPozFCGxuCMJ4DMXVVgm/3ZjrpDhK4faSP66SQLB5+PiknHH
	I4AU6rwKA3PUvjxDe3qsBR5OjXPkUma7iaFi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mJompK9EM8cxJaNqhbccAviZPdoroSok
	+4Jcp4H3FB+AZLjP76aFRN4VP/T/6zXkzSDyWm0Yo82fYx9l/4OWjRbm39ppmcN5
	mFkKsRlL+ZCcpuHrdjJs9FZHcb5MGzFSqOC7kB072167cDcIuNpLCfh5GGq2kxpd
	7Eoqm8xR8RE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58F37BE2FE;
	Thu, 24 Jun 2010 18:48:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85AE5BE2FD; Thu, 24 Jun
 2010 18:48:38 -0400 (EDT)
In-Reply-To: <40D1B374-E80A-4BA2-B3A2-142E8256C23E@gmail.com> (Eyvind
 Bernhardsen's message of "Thu\, 24 Jun 2010 22\:51\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A34B7AF8-7FE2-11DF-9143-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149657>

Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:

> On 24. juni 2010, at 22.21, Junio C Hamano wrote:
>
>> Finn Arne Gangstad <finnag@pvv.org> writes:
>> 
>>> If .gitattributes is different on the different sides, or if you
>>> enable autocrlf, the current repo contents may change after
>>> git-to-worktree and worktree-to-git again.
>> 
>> IOW, g2w-then-w2g may not be an identity function.
>> 
>> If we were to encourage use of this codepath to wider audiences, we may
>> need to have a document for people who write smudge/clean filters.  In
>> order for the result to be stable, applying g2w-then-w2g once again on top
>> of the result of running g2w-then-w2g on anything should be no-op, no?
>
> Hm.  Isn't that already a requirement?  If a clean filter doesn't clean
> to something normalized, simply touching a file could result in spurious
> differences (much like pre-safe-autocrlf autocrlf).  I could well be
> missing something here, though.

A natural expectation would be that g2w-then-w2g is an identity function,
I think.  But the "feature" under discussion in this thread depends on
that g2w-then-w2g is _not_ a noop (otherwise it wouldn't do us any good).

IOW, we are suggesting authors of clean/smudge to make their g2w-then-w2g
perform more than just a round-trip but actively _clean things up_, aren't
we?  I don't think we have documented that suggestion, and I actually
think we might even have said that g2w-then-w2g should be a no-op
somewhere in the documentation.
