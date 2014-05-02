From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG or FEATURE? Use of '/' in branch names
Date: Fri, 02 May 2014 15:16:07 -0700
Message-ID: <xmqq61lnakt4.fsf@gitster.dls.corp.google.com>
References: <5363D1B4.1000503@lge.com>
	<AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"simon.busch\@lge.com" <simon.busch@lge.com>
To: Keith Derrick <keith.derrick@lge.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:16:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLke-0004G4-K2
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbaEBWQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:16:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62331 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbaEBWQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 18:16:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DFDB5122B3;
	Fri,  2 May 2014 18:16:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gmWtqZxujKJ5i2QB7D6FzSxdqgw=; b=f4Sz4E
	3Z0OVgYTfUIQVpcRKPbtTEdrWI+TuXGPdd9fNULLoG3LNg9la6rkCNkJidtQEAaL
	0MCsGukdoPvUUowFECnV8upLnQwR42WEVVnQ9w5AK/F+i5XKthFswo+zSCm078E9
	5bHSujmZrscTJgO9E4DlMUa2hdg0h7ZRc+ZgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UK1vdlVVZOddcosSxPPzKFaY4MziU4Gk
	REUSrR5yLVzQo9j2QBHu9oYxcRNLLrkqTly8yERK/E5ovM3nQcFiLuqEjDAMP+c0
	AjCs6zLft3SRASU7ucrWSpCERjmfrs9yAgyWXe0wV3hk4+UoWPpWp8DJM+2TrzX6
	dCACsM+gxY8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2F8A122B2;
	Fri,  2 May 2014 18:16:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BF2B2122B1;
	Fri,  2 May 2014 18:16:08 -0400 (EDT)
In-Reply-To: <AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>
	(Keith Derrick's message of "Fri, 2 May 2014 18:04:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5C84D6DA-D247-11E3-A250-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247994>

Keith Derrick <keith.derrick@lge.com> writes:

> The problem arises when a branch already exists with a name
> matching the stem of the new branch name.
> ...
> But, for the reverse reason, I can't now create the branch named 'hotfix'

All correct.  Allowing '/' in branch names came about not with a
careful design but was done by a happy accident, and we accepted it
under the condition "as long as users know that they cannot have
branches D and D/F at the same time, that is fine".

An obvious alternative convention you can adopt would be to use not
'/' but some other separating characters (e.g. "_") as your
hierarchy delimiter, if you must have D and D_F at the same time.
