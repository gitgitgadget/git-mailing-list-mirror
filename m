From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: a submodule-like facility that tracks branches rather than 
 commits
Date: Sun, 02 May 2010 19:05:04 -0700
Message-ID: <7vsk69u4dr.fsf@alter.siamese.dyndns.org>
References: <w2n2cfc40321005020402gdc210b79v2652afa849cf7a60@mail.gmail.com>
 <7veihuuwdj.fsf@alter.siamese.dyndns.org>
 <l2u2cfc40321005021539v573e58a5j15696d81b5e5acd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 03 04:05:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8l2F-0002wK-SA
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 04:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229Ab0ECCFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 22:05:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab0ECCFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 22:05:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C26FEB0701;
	Sun,  2 May 2010 22:05:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RyyZZawM1rUufqs43hplwM0/TTY=; b=IjwL3N
	GefQGcAU5thWoKABVNp0+CAAKjyYURWBw/JwcZHC3N0SXJW/X9AmODTa6/s9zpS0
	CQxH1P/QoxAHJzqPvsro29H+JCFThHKDRmmm1/5lkdTxb0MxABqpjicAn7JKOnzZ
	NDSLZYIX4eZ7ty0DMSdpwdCkGLCGUMHlsRWU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ijQxUwN0M1kXEt4JMO6HH2myMdK03QJl
	k35tjqd84k8w4ordwqfSoFoteP8pJJjspmrUnkgMRYMEJUpeNN3TNxNS43s+KE3i
	dXF+aryzICIDf7zsLLWqkvsNjjhopfbvAc2PWeGpxsDznMpwk6Zp/46plJy67g+7
	1VAKDUacdmU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA27B06FD;
	Sun,  2 May 2010 22:05:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E253DB06FC; Sun,  2 May
 2010 22:05:05 -0400 (EDT)
In-Reply-To: <l2u2cfc40321005021539v573e58a5j15696d81b5e5acd5@mail.gmail.com>
 (Jon Seymour's message of "Mon\, 3 May 2010 08\:39\:42 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C936530-5658-11DF-BE09-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146213>

Jon Seymour <jon.seymour@gmail.com> writes:

>> But once people realize that there is no single canonical authoritative
>> repository whose branch heads point at the same commits for everybody in a
>> distributed environment, the line of thought to touch gitlink entries gets
>> retracted or discarded as a misguided idea.
>>
>
> I understand the point about there being no canonical authority,
> particularly in a truly distributed environment - any use of branches
> would have to imply that users followed some convention when
> publishing the entire set.
>
> On the other hand, there is actually precedent for use of convention
> like that in the submodule facility - the use of relative paths to
> describe the relative locations of submodule repos only really works
> if everyone who publishes the supermodule uses the filesystem
> structure for the directories containing the super- and sub-module
> repos.

That's not exactly what I meant.

If the superproject commit didn't record the exact commit for each
submodule, and only said "the tip of branch X" (presumably "as of this
writing"), then there is no way to reliably reproduce the build product
given the superproject commit alone.

>> I however don't think it would hurt to enrich .gitmodules with not just
>> the repository information but with branch information to help clones
>> decide which commit (other than what is recorded in the tree of the
>> superproject's commit) on the named remote tracking branch to try out with
>> the superproject's commit.
>
> I can see that this could work. Presumably git submodule sync would be
> modified in this case to help switch branches.

There are two ways to use submodules.  As I said already, the superproject
commit records exact commit for each submodule by design, to ensure that
the exact state including submodules can be reproduced.  You manage
submodules as separate projects, and the top level superproject commit
picks a _good_ commit suitable for the purpose of the superproject, not
just a random one that happens to be at the tip for a given day, to use
from the submodule.

But it is not implausible for the top level maintainer of thesuperproject
of a project not to even care about what s/he is shipping exactly, and
instead wish to describe "under this top level directory, check out these
projects my colleagues have as subdirectories" and nothing else.  In such
a case, the exact commit for each submodule recorded in the superproject
still can be used to reproduce the exact state if the top level maintainer
cared, but you can instead _choose to ignore_ that information and check
out the random commit that happen to be at the tip of the named branch.
It could appear that such a use pattern is abusing the submodule support
merely to implement a glorified ftp, but in a project that is run that
way, everybody understands and agrees that the commit object recorded in
the superproject is meaningless, so there is no harm done.

> I guess there is no reason why I cannot prototype a facility of this
> kind with a local helper script. If I it ends up being useful, I'll
> consider posting a patch.

Yes, that's the spirit ;-)
