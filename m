From: David Kastrup <dak@gnu.org>
Subject: Re: git-daemon on NSLU2
Date: Sat, 25 Aug 2007 09:12:08 +0200
Message-ID: <85zm0gdr5j.fsf@lola.goethe.zz>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	<20070824062106.GV27913@spearce.org>
	<9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
	<alpine.LFD.0.999.0708241618070.16727@xanadu.home>
	<9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
	<9e4733910708241506h6eecc11ge41b1dc313022b4b@mail.gmail.com>
	<fanmmk$f5q$1@sea.gmane.org>
	<9e4733910708241646x7b285574t94c3d7eb32bb60c9@mail.gmail.com>
	<7v1wdscwd4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 09:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOpp5-00036P-1F
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 09:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbXHYHMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 03:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620AbXHYHMM
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 03:12:12 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:36360 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbXHYHML (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 03:12:11 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IOpoV-0008Rt-Sv; Sat, 25 Aug 2007 03:12:08 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1636C1C39500; Sat, 25 Aug 2007 09:12:08 +0200 (CEST)
In-Reply-To: <7v1wdscwd4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 24 Aug 2007 17\:04\:55 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56623>

Junio C Hamano <gitster@pobox.com> writes:

> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
>> On 8/24/07, Jakub Narebski <jnareb@gmail.com> wrote:
>>> There was idea to special case clone (just concatenate the packs, the
>>> receiving side as someone told there can detect pack boundaries; do not
>>> forget to pack loose objects, first), instead of using generic fetch --all
>>> for clone, bnut no code. Code speaks louder than words (although if someone
>>> would provide details of pack boundary detection...)
>>
>> A related concept, initial clone of a repository does the equivalent
>> of repack -a on the repo before transmitting it. Why aren't we saving
>> those results by switching the repo onto the new pack file? Then the
>> next clone that comes along won't have to do anything but send the
>> file.
>
> If the majority of the access to your repository is the initial
> clone request, then it might be a worthwhile thing to do.  In fact
> didn't we use to have such a "pre-prepared pack" support?
>
> But I do not think "majority is initial clone" is the norm.

Well, as long as the majority is not affected negatively, catering for
a minority better is a strict improvement.  Most repositories will
never get cloned and won't be affected.  But there are some
repositories with a non-trivial amount of cloning.

> Even among the people who does an "initial clone" (from the
> end-user perspective), what they do may not be the initial full
> clone your special hack helps (and that was one of the reasons
> we dropped the pre-prepared pack support --- "been there, done
> that" to some extent).

If it doesn't get used, its presence does no harm, of course except
from having to be maintained and tested.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
