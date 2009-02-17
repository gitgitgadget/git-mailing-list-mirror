From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FETCH_HEAD question
Date: Mon, 16 Feb 2009 23:18:59 -0800
Message-ID: <7vr61x8ra4.fsf@gitster.siamese.dyndns.org>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
 <7veixxaale.fsf@gitster.siamese.dyndns.org>
 <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 08:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZKIZ-0004VA-Gd
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 08:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbZBQHTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 02:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbZBQHTH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 02:19:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZBQHTG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 02:19:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D3F732B4E4;
	Tue, 17 Feb 2009 02:19:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2168A2B4DD; Tue,
 17 Feb 2009 02:19:00 -0500 (EST)
In-Reply-To: <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>
 (Jay Soffian's message of "Tue, 17 Feb 2009 01:21:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 417D202C-FCC3-11DD-A441-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110319>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Tue, Feb 17, 2009 at 12:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> [... explanation of how git pull and git fetch communicate via FETCH_HEAD...]
>
> I'm aware of all that, and I apologize for not making that clear,
> since I made you do lots of extra typing. :-(

Your "git merge FETCH_HEAD" after fetching random set of refs by the
default wildcard refspec in .git/config made me suspect you aren't.

>>        $ git fetch git://repo.or.cz/his.git for-linus
>>        $ git log -p ..FETCH_HEAD ;# to inspect
>>        $ git merge FETCH_HEAD
>> ...
> That makes sense, but I was confused why git merge goes through the
> trouble of stripping out the not-for-merge tag which in the above use
> case wouldn't be there.

Because it is designed to handle a lot more general case of fetching all
remote branches into your remote tracking branches with wildcard refspecs,
and most of the entries need to be marked with not-for-merge marker.  If
you left only the for-merge branches, you would not have any sane way to
learn what refs were fetched after you said "git fetch" (and no, looking
at timestamp of files in .git/refs/remotes/origin/ is not a sensible
answer).
