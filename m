From: Junio C Hamano <gitster@pobox.com>
Subject: Re: different git-merge behavior with regard to submodules in
 1.6.2.4 vs. 1.6.2.1
Date: Tue, 28 Apr 2009 11:29:49 -0700
Message-ID: <7v4ow8my1u.fsf@gitster.siamese.dyndns.org>
References: <gt7err$3m4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Olsen <tim@brooklynpenguin.com>,
	Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Apr 28 20:30:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lys4H-0002M2-IM
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 20:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbZD1S35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 14:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbZD1S35
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 14:29:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbZD1S34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 14:29:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F065912C20;
	Tue, 28 Apr 2009 14:29:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 13C3912C1A; Tue,
 28 Apr 2009 14:29:50 -0400 (EDT)
In-Reply-To: <gt7err$3m4$1@ger.gmane.org> (Tim Olsen's message of "Tue, 28
 Apr 2009 13:36:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91F0B4A6-3422-11DE-8FA9-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117802>

Tim Olsen <tim@brooklynpenguin.com> writes:

> $ git merge origin/deployed
> fatal: cannot read object 83055ffdddde60d41d9811aae77e78be50b329f8
> 'rubydav': It is a submodule!
>
> Nothing in my history suggests that rubydav was at one point not a
> submodule.
>
> I looked at the 1.6.2.4 release notes and noticed the following:
>
>   * "git-merge-recursive" was broken when a submodule entry was involved
> in a criss-cross merge situation.
>
> So then I downgraded to the last debian package of git which is 1.6.2.1.
>  Now I get a result which is more approachable:
>
> $ git merge origin/deployed
> Auto-merging rubydav
> CONFLICT (submodule): Merge conflict in rubydav - needs
> 167a344227c4745031d50a210869e6fb59a5ac03
> Auto-merging server
> CONFLICT (submodule): Merge conflict in server - needs
> 82a74ae791c8563ca65f29187d2fe5ebfbc167ea
> Automatic merge failed; fix conflicts and then commit the result.
>
> Both merges are from freshly checked out clones.
>
> Is this a bug in 1.6.2.4?  Please let me know what other information I
> can provide to help debug the problem.

Thanks for a report.  I think the following commits are involved.

    39d8e27 simplify output of conflicting merge
    0eb6574 update cache for conflicting submodule entries
    f37ae35 add tests for merging with submodules

Clemens, these seem to be yours.  Thoughts?
