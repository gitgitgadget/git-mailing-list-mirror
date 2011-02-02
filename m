From: =?UTF-8?Q?Daniel_H=C3=B6pfl?= <daniel@hoepfl.de>
Subject: Re: [Bug] Permissions of temp file created in git's
 =?UTF-8?Q?sha=31=5Ffile=2Ec=20correct=3F?=
Date: Wed, 02 Feb 2011 14:25:27 +0100
Message-ID: <0bd60a95adcc1cda50d6ff0e8d335216@kloeckner.org>
References: <5dfd4de157546244c86acd52564247ce@kloeckner.org> <m3vd128uz7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 02 14:25:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkciG-0008Mu-1u
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 14:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab1BBNZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 08:25:30 -0500
Received: from black.doesntexist.org ([78.46.104.147]:51734 "EHLO
	black.doesntexist.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab1BBNZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 08:25:29 -0500
Received: by black.doesntexist.org (Postfix, from userid 5001)
	id 314DD1E486AF; Wed,  2 Feb 2011 14:25:28 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	black.doesntexist.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_40
	autolearn=ham version=3.2.5
Received: from kloeckner.org (localhost [127.0.0.1])
	by black.doesntexist.org (Postfix) with ESMTPSA id 9874B1E4817C;
	Wed,  2 Feb 2011 14:25:27 +0100 (CET)
In-Reply-To: <m3vd128uz7.fsf@localhost.localdomain>
X-Sender: daniel@hoepfl.de
User-Agent: RoundCube Webmail/0.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165910>

On Wed, 02 Feb 2011 04:47:20 -0800 (PST), Jakub Narebski <jnareb@gmail.com>
wrote:

> That is why there is `core.fileMode` config variable, see git-config(1)
> manpage:

I saw (and liked) that option but I do not want to use the executable bit
on my "FAT-compatible" file system for other things anyways.

> Didin't git detect that it was on such filesystem?

I did not create the repository on the device, it was simply copied onto
the volume.
One `git init` later: Git detects that the filesystem knows about the
executable flag and sets filemode = true. (On a real FAT, it would be set
to false, of course).

> Not true.  Whether file can be renamed or deleted is governed by
> permissions in directory that contains given file, not the file itself
> (at least on POSIX).  If I understand things correctly, of course.

OK, then that's a reason to fix my implementation. (Done.)

I still think that a file that is to be written to should not be created
without the right to do so.

> Note that git doesn't store full permissions, in particular read/write
> permissions, only executable bit and "is symlink" thing.

Executable is all I need. Since there was only one bit left in the FAT
directory entries, my file system uses this bit to store the executable
flag. Writeable is derived from/mapped to !readonly. That's all I changed,
compared to a normal FAT.

Thanks for the very fast answer,
   Daniel
