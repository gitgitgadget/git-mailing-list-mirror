From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 15:46:33 -0800
Message-ID: <7vk4wtysyu.fsf@alter.siamese.dyndns.org>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
 <200912111220.40844.jnareb@gmail.com> <4B223C1E.6010403@drmicha.warpmail.net>
 <200912111500.51982.jnareb@gmail.com>
 <7v3a3h48lz.fsf@alter.siamese.dyndns.org>
 <76718490912111418i6b59056eq69671979613749f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 00:46:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJFCJ-00046k-2q
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 00:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761493AbZLKXqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 18:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761491AbZLKXqm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 18:46:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759162AbZLKXql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 18:46:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8573E87D49;
	Fri, 11 Dec 2009 18:46:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iJpwD2FvEC0e0CWPVjKXw/WQa2Q=; b=gTvivz
	9NekimB1GcAbTdKpwhiSLIAQRFayJX26j+Cl2fnLF9qV+fEtnrDe8al5/bT1TpIY
	TKIDDW9GgvADgyyVy6t2ErSen/9+n7mxJ6XNA2CIP3kFilzT/maHF66ZD2Ma8xlv
	NdRrdeAVYAb/i5ANvYSNVThYECdM/WYBeWKHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EAx+WiYgtVzaFWFe/yVwcmI+OrzimbOR
	WiHstquCo3YPrxZ7ZQM9C95BUaI5plV9JO1iTWITuTVGpl3cGm/lAMxUCJdYMn2a
	fHBvExyQSF30N4RNhKtoZ6V2VMN1zR4SbU6ZqEXpJ7i95eG6ARAChvC47A+KNJev
	YHDfpp2pE9w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3579187D48;
	Fri, 11 Dec 2009 18:46:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFBB787D47; Fri, 11 Dec
 2009 18:46:34 -0500 (EST)
In-Reply-To: <76718490912111418i6b59056eq69671979613749f7@mail.gmail.com>
 (Jay Soffian's message of "Fri\, 11 Dec 2009 17\:18\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E4D0974-E6AF-11DE-99E3-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135107>

Jay Soffian <jaysoffian@gmail.com> writes:

> Also, I think we could improve the output of "git status" during merge
> resolution, both before and after conflicts have been resolved in a
> file.

I think you are talking about something that is largely unrelated, even
though they would be a pair of good issues to discuss.  The solution to
them does not have much to do with what we have been discussing so far in
this thread, and actually should be much simpler, which is a good news
;-).

> $ git status
> foo: needs merge
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #	unmerged:   foo
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> "unmerged" is good. But the instruction to use "git checkout --
> <file>" to discard changes is wrong in this context:

You should be able to change this without any "unresolve" index extension
added to the index.  Just notice an unmerged entry in the index and reword
the message accordingly.

More importantly, note that "git status" lists "unmerged" entries in a
separate section in its output in 1.6.6 (and has been so on 'master' for
some time) and your problem report needs to be adjusted for a more recent
reality.  Here is what you would get:

        $ git status
        # On branch pu
        # Changes to be committed:
        #   (use "git reset HEAD <file>..." to unstage)
        #
        #       modified:   builtin-send-pack.c
        #       modified:   remote.c
        #       modified:   remote.h
        #       modified:   transport.c
        #
        # Unmerged paths:
        #   (use "git reset HEAD <file>..." to unstage)
        #   (use "git add <file>..." to mark resolution)
        #
        #       both modified:      transport-helper.c
        #

One problem we can see is that 'use "git reset HEAD <file>..." to unstage'
is an invalid advice if we are in the middle of a merge, but is perfectly
valid if this were during "rebase", "am -3", "cherry-pick" and "revert".

The solution to this issue is exactly the same as the next one.

> $ git status
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	modified:   foo
> #
>
> Well, yes, I can use git reset, but that just keeps my side of the merge.

If the conflict was coming from "rebase", "cherry-pick", etc., there is
nothing but one side, as there is no merge going on, and what "git reset"
does is exactly what the message tells you---to unstage.

I think "git status" should notice that the next commit you would make
from this state will be a merge commit, and remove these "reset HEAD"
lines.  Once you "git add" to resolve, it makes _no_ sense to reset to
HEAD, if you are concluding a merge.  Until "update-index --unresolve" is
revived as a modern version (and I suspect that a more logical Porcelain
interface would be a new option "reset --unmerge <paths>..."), we should
simply drop "reset HEAD" advice when we are in a merge.

Note that the "unresolve" index extension will not help you at all in
order for you to decide if you are going to make a merge commit.  You
should instead ask "does .git/MERGE_HEAD exist?", and it is something you
should be able to implement directly on top of upcoming 1.6.6 release.
