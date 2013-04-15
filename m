From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 11:50:39 -0400
Message-ID: <516C21CF.5080705@xiplink.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 17:51:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URlgc-0007YI-2K
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 17:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab3DOPvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 11:51:13 -0400
Received: from smtp172.dfw.emailsrvr.com ([67.192.241.172]:49633 "EHLO
	smtp172.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab3DOPvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 11:51:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 073C718A989
	for <git@vger.kernel.org>; Mon, 15 Apr 2013 11:51:12 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp146.ord.emailsrvr.com (smtp146.ord.emailsrvr.com [173.203.6.146])
	by smtp17.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id E12A318A9A5
	for <git@vger.kernel.org>; Mon, 15 Apr 2013 11:51:11 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp15.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 55F61270126;
	Mon, 15 Apr 2013 11:50:40 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp15.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E5BD9270116;
	Mon, 15 Apr 2013 11:50:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221240>

In general I think it is a mistake to overload "git clone" with the notion of
adding a submodule.  If I want to *add* something to a repository, I'll use
some kind of "add" command.  To me "git clone" is not the kind of verb I
would expect to add something to some distant-parent .git directory.

Instead of mucking around with"git clone" I would much rather see "git add"
autodetect URLs and do the submodule thing:
	git add ssh://host/blammo.git
would clone blammo.git into ./blammo/ and set it up as a submodule inside
$PWD's git repo.  (This may benefit from "git clone" learning some kind of
--separate-git-dir option, but that's irrelevant to me.)

On 13-04-15 04:19 AM, Ramkumar Ramachandra wrote:
>
> Why would a user *want* a full clone inside a git worktree?

Please try to be careful with your assumptions.

I could have
	~/.git/
to maintain revisions of various personal files, config .dotfiles, scripts in
~/bin/ and so on.

I could also have various projects' repos under ~/Code, where I do my "real"
work:
	~/Code/git/.git/
	~/Code/DayJob/.git/
	~/Code/project-foo/.git/

Now, are these Code/* repos inside ~/.git/'s worktree or not?  I'd really
prefer them not to be.  I would be especially upset to have some "magic" that
automatically adds new clones inside ~/Code/ to ~/.git/.

		M.
