From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Fri, 29 Jun 2012 13:23:54 -0700
Message-ID: <7v4npt50kl.fsf@alter.siamese.dyndns.org>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
 <7vobo6cazk.fsf@alter.siamese.dyndns.org> <4FE9FF0C.8050409@web.de>
 <7vobo5c0n0.fsf@alter.siamese.dyndns.org> <4FEA380D.8070001@web.de>
 <7vzk7p8z38.fsf@alter.siamese.dyndns.org>
 <CAD77+gSyhR+4vdv3dEVSuEvyt7mT9ojT-F2BrwTL4FsXpNFeHA@mail.gmail.com>
 <7v8vf551iu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 22:24:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkhjV-0006Zn-O3
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 22:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929Ab2F2UX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 16:23:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932268Ab2F2UX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 16:23:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1E059BD1;
	Fri, 29 Jun 2012 16:23:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yjF+dCtvSvp/cbjkJJ+NsMZT6YY=; b=Ylei5W
	eprHkRhKprMMY2QURWYO076iWD3o99S6DKq7tE+ClE0Zyh+wIQd2tyx0ZVzKi6HK
	G2/esjcM/faaZM67dv7Vn4o87X4ykFZ83h1JYaiIeonlae0B5uu+6aKMzWAaJPKA
	gd+MxdmfNlLxnmpdB8be6a8Z4uSjHeRqrc2l4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W6z4cyK6LvBZKJqA/na+rr9vw1jwyele
	zhUmcbzsAcCUUEt3hLZdsQOw79V7UgBjehN3kqAbeDfjXNOCYKjT6fjTPf+XrOv6
	JreSrP6833OTeOfuL9gKkDRgm8f4yxpnElnNUjSqe5g2wLwhT03/8+OMnoWyz6yJ
	2R9X1fOCoL4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A888C9BD0;
	Fri, 29 Jun 2012 16:23:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BA5B9BCF; Fri, 29 Jun 2012
 16:23:56 -0400 (EDT)
In-Reply-To: <7v8vf551iu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 29 Jun 2012 13:03:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59FA9584-C228-11E1-9F33-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200829>

Junio C Hamano <gitster@pobox.com> writes:

>>> Declaring that a checked out submodule _must_ have its controlling
>>> repository as ".git" at its root level, i.e. it should be accessible
>>> without using GIT_WORK_TREE/GIT_DIR at all just like a normal Git
>>> repository is, would be a clean way to avoid the issue altogether
>>> and it still will allow the top-level superproject to be structured
>>> in a funny way to require GIT_WORK_TREE/GIT_DIR to access it,
>>
>> I fear this would make vcsh unable to support submodules, ever.
>
> Then think of a workable alternative.  As it stands, I would have to
> say that what vcsh tries to do with git is broken with respect to
> submodules.

Just to avoid misunderstanding.  I didn't mean "vcsh and vcsh alone
is broken while other solutions work just fine".  What I meant was
"I agree with you that what vcsh tries to do is unworkable".
