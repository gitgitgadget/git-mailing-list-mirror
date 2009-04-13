From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Question] Why sometimes the unmerged file doesn't contains any 
 conflicts
Date: Sun, 12 Apr 2009 19:47:18 -0700
Message-ID: <7vk55pxoax.fsf@gitster.siamese.dyndns.org>
References: <488807870904121935nab40117n56070570ecd31aa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johnny Lee <johnnylee194@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 04:49:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtCEF-0001hy-WC
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 04:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbZDMCr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 22:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbZDMCr1
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 22:47:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbZDMCr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 22:47:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 545DDA93D3;
	Sun, 12 Apr 2009 22:47:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1FE93A93D2; Sun,
 12 Apr 2009 22:47:19 -0400 (EDT)
In-Reply-To: <488807870904121935nab40117n56070570ecd31aa7@mail.gmail.com>
 (Johnny Lee's message of "Mon, 13 Apr 2009 10:35:06 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A559DCA-27D5-11DE-ACCA-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116401>

Johnny Lee <johnnylee194@gmail.com> writes:

> Sometimes when I merge two branches, the unmerged files don't contain
> any conflicts.
> When I edit the file, I can't find any conflict information. Usually
> all I have to do is manually "git add" them.
>
> I do the merge with a clean workspace, all changes have been committed.
> This doesn't happen all the time, usually the unmerged files contains
> the correct conflict information inside.
>
> Do you know what's going on here?
> The version of my git is: 1.6.2.1

Do you see something like these output when it happens?  If that is what
is happening to you, then it is perfectly normal, and the command even
gives explanations on what it did to you.  The only thing you need to do
is to read them ;-).

    $ git merge lt/pack-object-memuse
    Auto-merging builtin-pack-objects.c
    CONFLICT (content): Merge conflict in builtin-pack-objects.c
    Auto-merging builtin-rev-list.c
    CONFLICT (content): Merge conflict in builtin-rev-list.c
    Auto-merging list-objects.c
    CONFLICT (content): Merge conflict in list-objects.c
    Auto-merging list-objects.h
    CONFLICT (content): Merge conflict in list-objects.h
    Auto-merging revision.c
    Auto-merging revision.h
    Auto-merging upload-pack.c
    CONFLICT (content): Merge conflict in upload-pack.c
    Resolved 'builtin-pack-objects.c' using previous resolution.
    Resolved 'builtin-rev-list.c' using previous resolution.
    Resolved 'list-objects.c' using previous resolution.
    Resolved 'list-objects.h' using previous resolution.
    Resolved 'upload-pack.c' using previous resolution.
    Automatic merge failed; fix conflicts and then commit the result.

Notice the last set of lines "Resolved '%s' using previous resolution."

Another possibility is the common ancestor of the two branches did not
have the file in question and you added the same file on each of these
branches in a non-conflicting way.  That sometimes suggests a bad
workflow, but in an environment where two people independently pick up the
same patch on their branches and you end up merging with these two people,
it is also perfectly normal.
