From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase.sh: Use POSIX/Susv command substitution instead of backticks
Date: Tue, 05 Feb 2008 18:03:43 -0800
Message-ID: <7vve526dts.fsf@gitster.siamese.dyndns.org>
References: <lk5zxdix.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802052226340.8543@racer.site>
	<abmfxbg3.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802052305080.8543@racer.site>
	<7vhcgm7vdx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 03:04:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMZeQ-00065d-64
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 03:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760097AbYBFCEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 21:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759972AbYBFCED
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 21:04:03 -0500
Received: from rune.pobox.com ([208.210.124.79]:45289 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759830AbYBFCEB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 21:04:01 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8CB89193D43;
	Tue,  5 Feb 2008 21:04:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B4241193D11;
	Tue,  5 Feb 2008 21:04:15 -0500 (EST)
In-Reply-To: <7vhcgm7vdx.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Feb 2008 16:59:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72746>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> And then you have to do it for all scripts in one go.  Mind you, it is not 
>> really complicated: just one call to perl.
>
> Please do not do this.  If other people have pending changes,
> "cleanup for clean-up's sake" would create conflicts for no good
> reason.
>
> There are only two cases such a clean-up patch is good:
>
>  (1) When the maintainer is not yet accepting any patches after
>      a release-freeze and there is no pending patches from the
>      community, and/or if you can convince people with pending
>      patches to rebase on top of the clean-up because the
>      current codebase is so unmaintainably bad, then a
>      whole-tree clean-up patch should go in before anything
>      else, forcing everybody to rebase on top of it;
>
>  (2) If you will be working on the code in an area, you may want
>      to have the first one in the series a "pure clean-up and
>      nothing else" of the whole area, and then build your real
>      changes on top.  You still need to coordinate with people
>      whose patches may get hit by your clean-ups, but you have
>      to do this anyway because you will have conflicts from your
>      "real changes".
>
> Any other "clean-up patch" would result in a not-so-appreciated
> code churn.  Please don't encourage it.

Just to make sure Jari does not get a wrong idea,

My "Please don't" is meant against Johannes's "Do it all if you
do it".

If Jari did the patch as the first step of making real changes
to "git rebase" (making -i not forcing -m, perhaps), it is the
right thing to have a clean-up patch as a preparatory step,
before starting the real work in later patches in the series.
And such a clean-up patch should not inflict useless code churn
on other commands.

So a single patch only to git-rebase is acceptable if that is
what Jari is planning to do: preparatory clean-up before
bringing a real improvement in.
