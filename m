From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: lost all my patches again
Date: Wed, 28 Nov 2007 10:34:03 +0100
Message-ID: <20071128093403.GB12977@diana.vm.bytemark.co.uk>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com> <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 12:23:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from [129.240.10.42] (helo=mail-forward.uio.no)
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKJV-00011h-Qx
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 11:38:41 +0100
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxJM9-0007sW-15
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 10:37:21 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxJLu-0000Gu-IR
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 10:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbXK1JeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 04:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755179AbXK1JeI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 04:34:08 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2036 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbXK1JeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 04:34:07 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxJIx-0003ZJ-00; Wed, 28 Nov 2007 09:34:03 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: E337BBFF1E39C41E0DA2150D3B6428743403E133
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 74 total 724242 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66286>

On 2007-11-27 18:12:49 -0500, Jon Smirl wrote:

> As Jakub pointed out to me "git reset --hard $(cat
> .git/patches/<branch>/orig-base)" would have recovered from the
> rebase command. But I had already typed 'stg repair' which
> compounded the mess.

Unless it has a bug, the only thing "stg repair" will do is

  * create some new applied patches out of commits reachable from HEAD

  * mark some applied patches as unapplied

  * mark some unapplied patches as applied

in order to make sure that the applied patches are precisely those
that are reachable from HEAD, and that the sequence of applied patches
doesn't have "holes" in it (that is, commits that aren't patches).

In particular, it should not ever modify your existing patches, and it
will never move the branch head. Just resetting the branch head to
wherever you want it to be (and then running repair again) should fix
literally all problems.

> This is way too easy to do. One simple mistype of 'git' for 'stg'
> and you're in a mess.

You're right, this is not user friendly. A pre-rebase hook sounds like
a reasonable idea.

It would also be convenient with a post-commit hook that turns new
commits into patches automatically. And gives "git commit --amend" the
semantics of "stg refresh".

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
