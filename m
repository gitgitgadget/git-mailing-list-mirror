From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] archimport improvements
Date: Thu, 17 Nov 2005 22:26:39 +1300
Message-ID: <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com>
References: <20051112092336.GA16218@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 17 10:28:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecg2f-0006K6-Te
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 10:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVKQJ0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 04:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVKQJ0l
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 04:26:41 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:50437 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750710AbVKQJ0k convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 04:26:40 -0500
Received: by xproxy.gmail.com with SMTP id h26so2325616wxd
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 01:26:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d7uEnfq/snMNOyyT15KkH1mDx9rwaDleRocllQ3sQ+tMQ6BICKQ0m4q0uevs+iZ7JNFhCWcnnUwcbf7bbvWvMKYL5mOIXo/L4iSklHpAfjtFnh4U9X8skRwX6b2D7xTcgZnE/pTl9dH8PoMKusn1OmU8wm6WoIGnBAtnwrhRnL0=
Received: by 10.64.193.9 with SMTP id q9mr6942586qbf;
        Thu, 17 Nov 2005 01:26:39 -0800 (PST)
Received: by 10.64.241.15 with HTTP; Thu, 17 Nov 2005 01:26:39 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051112092336.GA16218@Muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12091>

Eric,

I've merged and pushed out to
http://locke.catalyst.net.nz/git/git-martinlanghoff.git/#tojunio

  [PATCH 1/5] remove shellquote usage for tags
  [PATCH 2/5] archimport: don't die on merge-base failure
  [PATCH 3/5] Disambiguate the term 'branch' in Arch vs git
  [PATCH 1/2] archimport: allow for old style branch and public tag names

That last one had a small edit to rebase it to the top of the head --
will probably have a small conflict for you on the usage line and
getopts() line.

What is pending is...

*  [PATCH 4/5] Overhaul of changeset application

I am testing it right now. Finding it rather slow on an idle linux
workstation with fast IDE disks, no X.org loaded and 1GB or RAM.
iowait is pegged at 90%. Wonder what will happen on a system with slow
disk access. tla/baz are unusable under any OS where the fs stack is
not _that_ polished (OSX and friends).

The early versions of the import also used $TLA for all ops, and I was
forced to change it to get my repos transformed in a reasonable time.

Can you send me a patch that makes it optional, so users can choose
fast or correct? I don't want to force glacial imports on anyone,
specially me. Testing an import of a reasonably sized repo must be a
quick operation or I won't do it ;-) And I do work on OSX too.

On the other hand, I might just implement renamed directories tracking
separately, specially if someone can point me to a public repo with
some interesting cases of renamed directories.

These patches seem to hang from 4/5 so will need rebasing after a
reworked. The first one seems to be 3 or 4 patches in one. It'd be
good to break it up.

* [ PATCH 5/5] -D <depth> option to recurse into merged branches
* Re: [PATCH 5/5] -D <depth> option to recurse into merged branches
* [PATCH 2/2] archimport: sync_to_ps() messages for tracking tla methods

If you want to see the repos I'm testing with, register
arch-eduforge@catalyst.net.nz--2004
http://nzvle.eduforge.org/arch-mirror/ and try:

~/local/git/git-archimport.perl -v \
    arch-eduforge@catalyst.net.nz--2004/moodle-org--moodle  \
    arch-eduforge@catalyst.net.nz--2004/moodle--local \
    arch-eduforge@catalyst.net.nz--2004/moodle--local-forum-types \
    arch-eduforge@catalyst.net.nz--2004/moodle--local-lock-content \
    arch-eduforge@catalyst.net.nz--2004/moodle--nmit \
    arch-eduforge@catalyst.net.nz--2004/moodle--topnz

cheers,


martin
