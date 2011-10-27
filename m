From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git alias and --help
Date: Thu, 27 Oct 2011 15:50:41 -0700
Message-ID: <7v8vo6xd4u.fsf@alter.siamese.dyndns.org>
References: <j8clg9$ldh$1@dough.gmane.org>
 <7vfwiexe6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 00:50:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJYmj-0008Ml-3i
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 00:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab1J0Wup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 18:50:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab1J0Wuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 18:50:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4DCE6E91;
	Thu, 27 Oct 2011 18:50:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vgdu1mVUxtvnrK/5qJ8wKP2Vnwg=; b=UM88G7
	vjVI1I5V4eVdERb4GNEZOwTBlud8/ulWxNXaipANMDoOQtxwMfS+gBjqRJ/6nXJC
	hOEXWwj1je5XeYZlrtZsuYxp8tmdrgJMDJTd5pLlFwRQBKWg0BuLZqsYB0QvO4E5
	ytxAtjXh81EFuSCls8LGtQsHXyRBB8mX4Edoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VXr1HbOFpoiRW2xExWpiH6dioXEMD/F0
	EYZfIkOpdOhzhm+Wi0tllMPIq/YwXDLTDBC2zdNgUFyCeAYWBGU66vdIN0ZuaX8+
	l9RQEAZyL2b01wOKOeeMBhnWp580T8EX9TwVWTIklRIsz7lXCRUSGkK7a8MH6h92
	wRfw62s4Y9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D4646E90;
	Thu, 27 Oct 2011 18:50:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 353096E8F; Thu, 27 Oct 2011
 18:50:43 -0400 (EDT)
In-Reply-To: <7vfwiexe6m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 27 Oct 2011 15:28:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19C377C0-00EE-11E1-B6E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184328>

Junio C Hamano <gitster@pobox.com> writes:

> Gelonida N <gelonida@gmail.com> writes:
>
>> Is there any trick to get the help text of git branch without
>> having to type
>>
>> git branch --help
>
> How about "git help branch"?

It was bad of me to write a tongue-in-cheek answer, get distracted and
ended up sending it without the real answer.

The reason why we do not do what you seem to be suggesting is because
giving the same behaviour to "git b --help" as "git branch --help" is
wrong.

To see why, imagine you have configured an alias that is not a simple and
stupid substitution "b == branch", but something like "bt == branch -t",
and then want to know what you should write after "git bt".  Giving the
manpage for branch without giving them any hint that they configured that
alias to produce customized behaviour that is different from plain vanilla
"branch" is not quite acceptable.

I think you _could_ make a patch that special cases a simple and straight
substitution and skip the "foo is aliased to bar" step, but I doubt it is
worth it to lose consistency between "git b --help" vs "git bt --help"
that way.
