From: Sergei Organov <osv@javad.com>
Subject: Re: Amending merge commits?
Date: Tue, 29 Jul 2014 00:53:24 +0400
Message-ID: <87lhrdb3y3.fsf@osv.gnss.ru>
References: <22F01493C523F940B4B5E53BB6D0F5352275F207@G5W2738.americas.hpqcorp.net>
	<20140725221911.GL12427@google.com>
	<22F01493C523F940B4B5E53BB6D0F5352275F25B@G5W2738.americas.hpqcorp.net>
	<20140725223146.GM12427@google.com> <87vbqhb7g9.fsf@osv.gnss.ru>
	<20140728200037.GN12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Besen\, David" <david.besen@hp.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:53:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBrvH-0002pb-A4
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 22:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbaG1Ux1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 16:53:27 -0400
Received: from mail.javad.com ([54.86.164.124]:36652 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaG1Ux1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 16:53:27 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id AE44061855;
	Mon, 28 Jul 2014 20:53:25 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XBrvA-0008GO-1Y; Tue, 29 Jul 2014 00:53:24 +0400
In-Reply-To: <20140728200037.GN12427@google.com> (Jonathan Nieder's message of
	"Mon, 28 Jul 2014 13:00:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254355>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sergei Organov wrote:
>
>> Is there any scenario at all where pull --rebase=true wins over
>> preserve?
>
> Basically always in my book. ;-)
>
> When people turn on 'pull --rebase', they are asking for a clean,
> simplified history where their changes are small discrete patches in a
> clump on top of upstream.

I think they rather ask for avoiding tons of meaningless automatic
merges resulting from periodic pulling from upstream.

Those subset of the above who only do small discrete patches don't do
merges to their tracking branches, except by mistake, right? If so,
'pull --rebase=preserve' makes no difference compared to --rebase=true
to their normal workflow. Moreover,if someone merges something to his
tracking branch by mistake, how is it different from making merge to any
other branch by mistake? Just fix the mistake by resetting to previous
state.

On the other hand, if someone decides to merge something else to his
tracking branch by purpose, both --rebase=preserve and --rebase=false
perform as expected, while --rebase=true may easily lead to huge
surprise. Please refer also to this thread for one such case:

http://www.mail-archive.com/git%40vger.kernel.org/msg55605.html

> When someone has made a merge by mistake (with 'git pull' before
> remembering to do an autosetuprebase, or with 'git merge' instead of
> cherry-picking some patches they needed), the current --rebase=true
> behavior can be a good way of cleaning up.

Once again, in case of mistake they are free to use --rebase=true, and
even then using 'git rebase' directly is probably cleaner. That said, I
don't argue --rebase=true could be sometimes useful. It's just that I
think --rebase=preserve is safer, so it should be a good idea to suggest
to use it (in favor of --rebase=true) in general.

> That said, in some specific workflows, --rebase=preserve may work
> better than --rebase=true.

It does indeed, and I don't think my aforementioned workflow is too
specific.

> My hunch is that even those workflows are not currently handled well
> with --rebase=preserve, alas.

--rebase=preserve works fine for the aforementioned workflow. At least
simple tests I performed so far ran fine. I'd like to learn though which
nasty drawbacks --rebase=preserve has for tracking branches compared to
--rebase=true, if any.

> A clearer explanation of --rebase (maybe with sub-headings for each
> choice *true*, *false*, and *preserve*?) sounds useful.  An
> illustration in the EXAMPLES section of git-pull(1) of the difference
> between these three modes and when to use them would be even more
> helpful.

That would be an improvement anyway, indeed.

-- 
Sergey.
