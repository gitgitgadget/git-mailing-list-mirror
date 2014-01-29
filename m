From: Mike Hommey <mh@glandium.org>
Subject: Re: inotify support, nearly there
Date: Wed, 29 Jan 2014 16:44:35 +0900
Message-ID: <20140129074435.GA21044@glandium.org>
References: <CACsJy8CG5QUqYOM46mOHOWDKB-A45B2-fj1uS9OtgniV+P8Ktg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 29 08:44:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8PpG-0001pC-G5
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 08:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbaA2Hom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 02:44:42 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:44088 "EHLO
	jigen.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750924AbaA2Hom (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 02:44:42 -0500
Received: from mh by jigen.glandium.org with local (Exim 4.82)
	(envelope-from <mh@glandium.org>)
	id 1W8Pp5-0005bQ-9C; Wed, 29 Jan 2014 16:44:35 +0900
Content-Disposition: inline
In-Reply-To: <CACsJy8CG5QUqYOM46mOHOWDKB-A45B2-fj1uS9OtgniV+P8Ktg@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241201>

On Wed, Jan 29, 2014 at 01:47:30PM +0700, Duy Nguyen wrote:
> Just a quick update for the enthusiasts. My branch file-watcher [1]
> has got working per-user inotify support. It's a 20 patch series so
> I'll refrain from spamming git@vger for a while, even though it hurts
> your eyes a lot less than what I have posted so far. The test suite
> ran fine with it so it's not that buggy. It has new tests too, even
> though real inotify is not tested in the new tests. Documentation is
> there, either in .txt or comments. Using it is simple:
> 
> $ mkdir ~/.watcher
> $ git file-watcher --detach ~/.watcher
> $ git config --global filewatcher.path $HOME/.watcher
> 
> There's still some polishing work to do. But I think the core logic is
> done. I have some ideas what to be polished, but I'd appreciate
> feedback if anyone uses it. We may need to make lookup code faster
> later.
> 
> MacOS, FreeBSD and Windows contributors. If you have time and are
> interested, have a look at the protocol, which is basically documented
> in file-watcher.c:handle_command(), and see if something is
> incompatible with your file notification mechanism. MacOS and FreeBSD
> may reuse code from file-watcher.c, at least the unix socket part. I'm
> not so sure about Windows. It probably needs a brand new daemon
> because little could be shared, I don't know. I deliberately design
> the daemon dumb so writing a completely new one won't be so hard. My
> plan is focus on inotify and get it merged first, then new OS support
> can come later (with refactoring if needed, but should not change the
> protocol drastically).
> 
> [1] git clone https://github.com/pclouds/git.git file-watcher

Haven't looked at the code, so I don't know if you've done that, but in
case you haven't, it would be nice to have an environment variable or a
config option to make git use the file-watcher *and* normal lstat
operations, to check consistency.

Mike
