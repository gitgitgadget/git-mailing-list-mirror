From: Junio C Hamano <gitster@pobox.com>
Subject: Re: {Spam?} push pull not working
Date: Tue, 24 Jan 2012 12:12:54 -0800
Message-ID: <7vty3k3lmh.fsf@alter.siamese.dyndns.org>
References: <1327431631.21582.209.camel@thor>
 <20120124194153.GB19534@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rick Bragg <lists@gmnet.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 24 21:13:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpmjo-00038g-Uh
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 21:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab2AXUM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 15:12:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755264Ab2AXUM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 15:12:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14B507AC1;
	Tue, 24 Jan 2012 15:12:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u99Dii2cvrHFO/ogJGBjVgHg+dc=; b=yiSGgn
	4eIyefSi7h5e/o0K/h7APG3CgBaVnB2A0Iwr9VHJXt3Pr9KsePjJmeM7uKBQFIOJ
	AE64uzCJSzKBd5UtB/0HUKbAuszDgsoKtSwkl2NrONRu+GYKJ0tygl5ObYLwLhBR
	8vQiO4zlLJHBA4qHioOXnETx6CnUtGsl6s5xM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kI6esP6n6fte2Ur0zJv8Nk2OQrxoqyiD
	3q/nprsfjTckWEBGWCNZ+Khg2Xka6FWdo33uR5iBQfsk9bCghhfHmYL1WQm0tg6C
	/kUDrGAvReGyWRaJv/qFyKvlvVRmnSn4MdeMzoN/0L3w8UeZJAyvDmoLwolbisSo
	accxoQp/wbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C66D7AC0;
	Tue, 24 Jan 2012 15:12:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 968CA7ABF; Tue, 24 Jan 2012
 15:12:55 -0500 (EST)
In-Reply-To: <20120124194153.GB19534@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 24 Jan 2012 14:41:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD661B7E-46C7-11E1-9C1F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189064>

Jeff King <peff@peff.net> writes:

> For example, imagine repo1 has two branches, "master" and "foo", and the
> "master" branch is checked out. When you clone it, the resulting repo2
> will have remote-tracking branches for both "master" and "foo", but will
> only checkout the "master" branch. Now imagine you make commits on
> "foo" in repo1, and then try to push. Git's default behavior is to push
> only branches which match (by name) a branch on the destination. So we
> would attempt to push "master" (which is up to date), but not "foo".

Technically you are not saying anything incorrect, but the above is not an
appropriate paragraph to give to a total newbie, I would have to say.

It does not make it clear that it is insane to push to repo2 with matching
push (or "current" or "upstream" for that matter), after cloning from a
repository repo1 with a working tree to repo2 with an working tree, and
making changes at the original repo1 repository. Instead, you are giving a
false impression that pushing both "master" and "foo" explicitly would
solve the problem OP is having, which is not true.

If repo1 and repo2 with working trees want to criss-cross-exchange their
histories, both should "git pull" from the other, not "git push", and if
one side cannot initiate a connection to the other, "git push" that goes
in the other direction should be pushing into remote tracking refs of the
other in order to emulate a "git pull" that goes in the other direction.
