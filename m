From: David Kastrup <dak@gnu.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 11:13:51 +0200
Message-ID: <864pi9cw4w.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <46DE6DBC.30704@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 11:15:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqyr-0003NO-Pd
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbXIEJPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755882AbXIEJPS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:15:18 -0400
Received: from main.gmane.org ([80.91.229.2]:40731 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755540AbXIEJPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:15:16 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ISqyU-0003N8-25
	for git@vger.kernel.org; Wed, 05 Sep 2007 11:15:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 11:15:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 11:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <46DE6DBC.30704@midwinter.com> (Steven Grimm's message of "Wed\, 05 Sep 2007 01\:50\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:Ad5uWRR30Q6oMuO9LCvBTSrZLA8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57700>

Steven Grimm <koreth@midwinter.com> writes:

> Pierre Habouzit wrote:
>>   Well independently from the fact that one could suppose that users
>> should use gc on their own, the big nasty problem with repacking is that
>> it's really slow. And I just can't imagine git that I use to commit
>> blazingly fast, will then be unavailable for a very long time (repacks
>> on my projects -- that are not as big as the kernel but still -- usually
>> take more than 10 to 20 seconds each).
>>   
>
> What about kicking off a repack in the background at the ends of
> certain commands? With an option to disable, of course. It could run
> at a low priority and could even sleep a lot to avoid saturating the
> system's disks -- since it'd be running asynchronously there should
> be no problem if it takes longer to run.

You'll potentially get accumulating unfinished files from
aborted/killed repack processes.  If communication fails, you'll get a
new repack session for every command you start.  If a repository is
used by multiple people...

And so on.  The multiuser aspect makes it a bad idea to do any
janitorial tasks automatically.  You don't really want every user to
start a repack at the same time.

-- 
David Kastrup
