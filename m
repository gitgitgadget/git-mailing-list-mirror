From: Seb <spluque@gmail.com>
Subject: Re: interactive rebase results across shared histories
Date: Sun, 21 Feb 2016 21:32:43 -0600
Organization: Church of Emacs
Message-ID: <87y4ad5sis.fsf@gmail.com>
References: <87io1j6laz.fsf@gmail.com> <56C91D21.90306@moritzneeb.de>
	<8737sm6kmk.fsf@gmail.com>
	<CAPig+cSxmWc_Guab0UoQbRMEkVLr-qhF=LCiVk10G5AdnTqnGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 04:32:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXhF5-0008Bd-4b
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 04:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbcBVDcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 22:32:55 -0500
Received: from plane.gmane.org ([80.91.229.3]:44830 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbcBVDcy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 22:32:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aXhEx-000851-Qu
	for git@vger.kernel.org; Mon, 22 Feb 2016 04:32:52 +0100
Received: from s0106503955564c1f.wp.shawcable.net ([24.77.8.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 04:32:51 +0100
Received: from spluque by s0106503955564c1f.wp.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 04:32:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s0106503955564c1f.wp.shawcable.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cancel-Lock: sha1:rayN0dOvAq45bYozbU/b6T+HzBk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286876>

On Sun, 21 Feb 2016 14:08:44 -0500,
Eric Sunshine <sunshine@sunshineco.com> wrote:

[...]

> What you're probably missing is that you can't actually edit commits
> in Git. Instead, what you think of as "editing" actually creates a new
> commit with its own commit-ID, and the original commit still exists
> with its own commit-ID. Since Git commits are chained together by
> their commit-ID's, any commits pointing at the original commit-ID
> continue to point to that commit, and only commits rebased atop the
> new commit-ID of the "edited" commit point at it.

> In your example, you're "editing" D and E, which creates new commits
> D' and E', so your resulting graph looks like this:

>     D'---E'---A---B---C topic / *---D---E---F---G master

> So, "master" and "topic" really are not sharing D and E (or D' and
> E'). You could "fix" this to match your intuition by rebasing F...G
> onto E' (see git-rebase --onto, for instance), which would give you
> this:

>                   A---B---C topic / *---D'---E'---F---G master

> and then "master" and "topic" would really be sharing D' and E' as
> common history. (Of course, rebasing "master" or any branch may not be
> desirable if you've published it, so applicable warnings about
> rebasing apply.)

> By the way, the problem isn't restricted to when you rebase "topic"
> (as your problem description implies). You'd see the same behavior if
> you'd rebased D and E in "master" to become D' and E'. "topic" would
> still have old D and E in its history, and not D' and E'.

Thank you for this excellent explanation.  I will look into git rebase
--onto to have both branches share the history that should be shared
after the interactive rebase.  Fortunately, this is a private repository
for now.

-- 
Seb
