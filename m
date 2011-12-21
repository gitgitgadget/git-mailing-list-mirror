From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* How to generate pull-request with info of signed tag
Date: Wed, 21 Dec 2011 10:39:14 -0800
Message-ID: <7vobv1hir1.fsf@alter.siamese.dyndns.org>
References: <874nx1korf.fsf@linux.vnet.ibm.com>
 <7vbor8jw0h.fsf@alter.siamese.dyndns.org> <871us3l45o.fsf@linux.vnet.ibm.com>
 <7viplfdlpb.fsf@alter.siamese.dyndns.org> <87iplch79e.fsf@linux.vnet.ibm.com>
 <7vobv4mj4r.fsf@alter.siamese.dyndns.org>
 <7vk45smilc.fsf@alter.siamese.dyndns.org> <87liq6xwr8.fsf@linux.vnet.ibm.com>
 <7vzkemh0de.fsf@alter.siamese.dyndns.org> <87ipl9yik6.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 19:39:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdR4V-0004Vq-3q
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 19:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab1LUSjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 13:39:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56126 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525Ab1LUSjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 13:39:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A87FC55C7;
	Wed, 21 Dec 2011 13:39:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5F44Xlih/CQjRY1afx7nGwrw8AM=; b=hz33Js
	TMyZ7KttbTm1pwomhQt4S8J0LEp5wtO9J6m5h7WfQ51rB/aJ21zHtk4s70DSjxbr
	qak7bxD6yTkAWbgstHztLa8ZnbCObOno/IGIXRrGOb5HgPV+P/sM156nvm75F6ZS
	ua7KxYCSUEL+Neld4zHQ36Pd43jEcToFn/bEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=irWeYLsL2g84IuJ72Vs/pWsojbinweSZ
	oZZdZNpMNB9W14cEKhpZ+Og/h4xSqh78+nnjNvP0HT5295+5sFsdk7N3m9Q8wxR9
	f4S6kv+aGr6aGgRfpomrH2K0qTYPAQ5YW6clS9rKVgGlzpA01Y4/J+TFK7+qQaXc
	SgVpS411Ikw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D42055C6;
	Wed, 21 Dec 2011 13:39:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BAE555C5; Wed, 21 Dec 2011
 13:39:16 -0500 (EST)
In-Reply-To: <87ipl9yik6.fsf@linux.vnet.ibm.com> (Aneesh Kumar K. V.'s
 message of "Wed, 21 Dec 2011 22:21:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15E85266-2C03-11E1-8F15-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187576>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> With an entry like below
>
> [remote "github"]
>         fetch = +refs/tags/*:refs/tags/origin/*
>         url = git://github.com/kvaneesh/QEMU.git
>
> when i do git fetch github for-anthony i get the below error

When you give refspecs from the command line like that, the default
refspec remote.github.fetch will not be used and what you configure there
is immaterial.

> [master@QEMU]$ git fetch github for-anthony
>>From git://github.com/kvaneesh/QEMU
>  * tag               for-anthony -> FETCH_HEAD

Sounds sane.

Does "git cat-file -t FETCH_HEAD" report "tag" (it should)?  After doing
that fetch and inspecting "git log -p ..FETCH_HEAD", you should be able to
do "git merge FETCH_HEAD" and it should be like you did "git pull github
for-anthony".

> Also trying to do
>
> [master@QEMU]$ git fetch git://github.com/kvaneesh/QEMU.git  for-anthony:aneesh/for-anthony
> error: Trying to write non-commit object 12916047784615b7d8b879d9d39be6c1559e1b1b to branch refs/heads/aneesh/for-anthony
>>From git://github.com/kvaneesh/QEMU
>  ! [new branch]      for-anthony -> aneesh/for-anthony  (unable to update local ref)
>  * [new tag]         for-anthony -> for-anthony

Sounds sane, too.

> I understand that replacing the above with below works. But we should
> not be required to specify refs/tags there right ?
>
> [master@QEMU]$ git fetch git://github.com/kvaneesh/QEMU.git  refs/tags/for-anthony:refs/tags/aneesh/for-anthony

If the "for-anthony" name is ambiguous between branches and tags, then you
must disambiguate. I am guessing that the unqualified LHS "for-anthony" is
found in the branch namespace of the remote, and that is why RHS is qualified
with the same refs/heads/ prefix to store it to the branch namespace.

On the other hand, if "for-anthony" name is unambiguous, then you may have
found a bug. I cannot tell.
