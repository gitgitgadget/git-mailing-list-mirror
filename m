From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to check what your pulling down?
Date: Thu, 16 Apr 2009 09:46:11 -0700
Message-ID: <7vfxg8k0mk.fsf@gitster.siamese.dyndns.org>
References: <23075475.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: cantona <adam@dwpub.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 18:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuUkl-0005E6-PI
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 18:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593AbZDPQqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 12:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756001AbZDPQqU
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 12:46:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837AbZDPQqT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 12:46:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 69E7BAB2CF;
	Thu, 16 Apr 2009 12:46:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5AC15AB2CE; Thu,
 16 Apr 2009 12:46:15 -0400 (EDT)
In-Reply-To: <23075475.post@talk.nabble.com> (adam@dwpub.com's message of
 "Thu, 16 Apr 2009 04:00:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1B9FF8E6-2AA6-11DE-BC5F-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116708>

cantona <adam@dwpub.com> writes:

> I've been using basic git for a while (add,comit,push,pull) and have
> recently discovered stash,merge,branch :)
>
> My question: before I pull down I always get that bad feeling... "what am i
> gunna get? will there be a conflict?".

"will there be a conflict?" is an unfounded fear people seem to be unable
to shake off from their old scm days.  As long as you start from a fully
committed state, you can always "git pull", and if it resulted in
conflicts you cannot resolve, you can "git reset --hard" it away.

With a distributed system, you can afford to fully commit your local
changes before you pull.  If they are of dubious quality, you just create
a separete "my-wip" branch to commit them there, come back to the "master"
branch that does not have unfinished changes and run "pull".

On the other hand, even if there weren't any conflicts, it is often good
to check what you have pulled (especially if you are in the position to
say "Nah, this is no good, and I am not going to pull from you now.
Please redo these changes."  You do that by by:

	git pull
        git log -p ORIG_HEAD..
