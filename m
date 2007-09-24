From: "David Tweed" <david.tweed@gmail.com>
Subject: behaviour of git diff, GIT_DIR & checked out tree
Date: Mon, 24 Sep 2007 13:45:26 +0100
Message-ID: <e1dab3980709240545o32eeefcdkd4bc67abab0e5343@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 14:45:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZnJf-00086g-PU
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 14:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbXIXMp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 08:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753935AbXIXMp2
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 08:45:28 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:41493 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbXIXMp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 08:45:27 -0400
Received: by py-out-1112.google.com with SMTP id u77so2889815pyb
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=C/2skOf6OhC9zQBl3mFZ9xgYEEg3PxjxRQaIewQZEnc=;
        b=oApWF+VZFjv5cypVEiuLQXOg5ajU4DD9dnrx4vVabG7S+AMfdBmk63W16cpdkTPybBZzRLma00Cql31pRoX+N0K56IOQo+WuTOa3UFURwQ3auWnQqgVh8M43K10S0lrIq/pUd9yepV/0QX6UJry0t+FmkEg3EEhcmC4v4+VSuZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VKNBOJyEiEOc7b6gqhwUdEtK1z0xhQdS7lmoOC4rPEcE7rkX5MTpa8c/LXAbSyReY6SZuHNAArUW6fgMpa2SGYsI2wfgdjYzjU0ikxBdzCw/YDqIJZPM9wRw9EPfdAthqPLX02R1T/OZ19mR8AAdh0+7GHYqGYdIkLDkPDpX6SI=
Received: by 10.64.10.2 with SMTP id 2mr4836642qbj.1190637926323;
        Mon, 24 Sep 2007 05:45:26 -0700 (PDT)
Received: by 10.64.181.10 with HTTP; Mon, 24 Sep 2007 05:45:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59043>

I'm doing something "sensible people don't do"
-- I know this -- but I'm getting results I don't
understand, so I'd appreciate any insight.

In a git tracked tree rooted at $HOME/V with
git-dir of $HOME/V/.git, if I'm in $HOME/V then

git diff master@{midnight}

tells me the difference between the current modified files
in the tree being tracked in V and the specified commit. In
a different directory, OUTSIDE of $HOME/V, I tried

env GIT_DIR=$HOME/V/.git git diff master@{midnight}

to get the same effect but, whilst I do get a diff output, it
looks like a diff of the commit against an empty tree. (Using

env GIT_DIR=$HOME/V/.git git diff HEAD master@{midnight}

works ok.) I suppose I could alias it to

cd $HOME/V && command && cd -

but that seems a bit clunky; is there another way to explicitly
say "working tree for repo with this GIT_DIR" to git diff?

[Why I'm doing this: I actually work on files in the $HOME/V
via various other directories containing symlinks to the basic
files (with tracked files being pointed to by multiple symlinks).
So I'm almost never actually "in" the tracked tree. This
usage makes more sense for my tasks than being within
the work tree.]

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
