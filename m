From: Junio C Hamano <gitster@pobox.com>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 16:25:36 -0800
Message-ID: <7vtywba6bj.fsf@alter.siamese.dyndns.org>
References: <cover.1259524136.git.brlink@debian.org>
 <7v8wdnooza.fsf@alter.siamese.dyndns.org>
 <20091130185540.GA5764@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 01:25:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFGZ2-0005ay-0F
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 01:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbZLAAZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 19:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbZLAAZm
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 19:25:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbZLAAZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 19:25:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDCBD844C9;
	Mon, 30 Nov 2009 19:25:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=KF6JlPyYF2JGbD73Ee+CCJHNr3o=; b=ImxLssLnY6HZ1rPJz1iNAyn
	fQbTYfC/Tfs9d9DU0KCo8qARel3XzWAqNm4//ODudVwa/xrch8zsvE1ml1pgC04N
	u7gWv9eqlQnjHFt+TNDQkLG/y98YluRQ6bm3g3iKzGrA/RDhm5QLZbjbwXZFsw5u
	7GUo4q5ffoWszGqJZiFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=x2vlsOIB2mY98MlVqCKh1sSESHHChGdY0SiNcBoX5ghNbwh1h
	C0lmJbykoXsPkS4vlfgvftD/gS8KyXPnWMG36ncOb537DYEoiZpyRT9+heUum/n1
	x/Nv4cYWmbjdOMo5fFdjTc1h4jnFguYs81TAzdNTnZdB3/fOB459BCXpkU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25128844C7;
	Mon, 30 Nov 2009 19:25:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7159D844C5; Mon, 30 Nov
 2009 19:25:37 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0DDD8228-DE10-11DE-979C-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134158>

"Bernhard R. Link" <brlink@debian.org> writes:

>>        3-------.
>>       /         \
>>      0---2---W---B
>>       \         /
>>        1-------Z
>>
>> That is, Z and W records the interdifff between 1 to 3 and 2 to 3
>> respectively, and B is a same-tree merge of 3, W and Z.
>
> I think changing it to get this would be easy (though only in the case
> where the very last commit was such an equal tree merge), but I do not
> think it would be actually better:
>
> - it is no longer possible to see the history of changes by just walking
>   right on every equal-tree-merge.
> - commit a no longer exists. If some downstream already has
>   cloned/pulled, no fast-forward is possible any more.

Oh, I wasn't suggesting you to change it to use an octopus.  I however did
want to know if you considered pros-and-cons with such an alternative
(there perhaps are other approaches as well), and I agree recording one
iteration at a time like you do is better.
