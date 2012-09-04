From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Tue, 04 Sep 2012 09:15:05 -0700
Message-ID: <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:15:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8vmb-0000am-1L
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 18:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757440Ab2IDQPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 12:15:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757223Ab2IDQPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 12:15:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFBFF8DCD;
	Tue,  4 Sep 2012 12:15:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7JMeaho4Qjj/3kD0JSdD12uSsFc=; b=RRg2ID
	NEaOwei5wCAWBFecg/zRIMLhIy5AtNB7ia7rFAfiSZwKaYjdoj10JJ8FPcIdjWDK
	P1H/zj3HR4bHCgBumef3Kz5FcR4i3EAYCu4uayK9lopRxvGlKygVItfnBbVVzqtD
	HjQyEGCQgic7np/qQZo4izxh941fSkrT0JT2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=onswBvuybve0SNamEQd7Cw5JjuX+mo+E
	oZpEWvI5ZjUpogPNYohyDcLmlYl7yTyHsksslHCeOg32a600zKrxYpVIDyOIwHHM
	5CfaldDN40h9AgkccAUagL3p4bS52VytYTWjlKM09H2W/QtV1qjulnp1GwXEPd2U
	Kc+qV74fAiI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7FA58DCB;
	Tue,  4 Sep 2012 12:15:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12A928DCA; Tue,  4 Sep 2012
 12:15:06 -0400 (EDT)
In-Reply-To: <7vpq61dfn9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 04 Sep 2012 07:30:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1371568-F6AB-11E1-8341-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204750>

Junio C Hamano <gitster@pobox.com> writes:

> Now we have f1 and f2 in the working tree.
>
>> $ git checkout e6f9 -- *
>
> That is the same as "git checkout e6f935e -- f1 f2", as the shell
> expanded "*" into "f1" and "f2".
>
>> error: pathspec 'f2' did not match any file(s) known to git.
>>
>> Note the error.
>
> Yes?
>
>> It is clear that the set of file names that git checkout is taking is
>> the union of the ones that
>> match the specified path ('*') in the work directory (gittest) with
>> the ones that match the
>> path in the specified commit (e6f9).
>
> The command tells git to check out "f1" and "f2" out of the tree of
> e6f935e, and git found "f1" but did not find "f2" and reported an
> error.  I do not see a room or need for "union" to come into the
> picture to explain what we see in the above transcript.

Actually, I "kind of sort of" can see where that "union" is coming
from, if I squint my eyes hard enough.

Yes, it makes it look like the path affected has some relationship
between two sets of paths:

 - set W, which consists of f1 and f2, that is the result of
   matching '*' against working tree files; and

 - set T, which consists of f1 (but not f2), that is the result of
   matching '*' against the tree contained in e6f935e

and the intersection of W and T (i.e. f1) is what is checked out.

But that is not what is happening at all.  What goes on is far
simpler than that.

 - the shell sees '*', matches it against working tree files, to
   obtain "f1" and "f2";

 - the shell tells "git" to "checkout e6f935e -- f1 f2";

 - "git" looks into the tree of e6f935e to find paths that match
   "f1" and "f2".

When "git" is run by the shell in the last step, it has _no_ clue
that the end user typed "*" from the shell.  It only sees "f1" and
"f2" on the command line.  There is no "set T" to be intersected
with "set W", so stop thinking in those terms, and you will be fine.

Now the question is, _you_ will be fine, but can the documentation 
be updated in such a way so that it will help _others_ to also stop
thinking about "intersection between set W and set T"?  I do not
have a good answer to that.
