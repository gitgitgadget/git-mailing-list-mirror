From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Sat, 20 Jan 2007 14:17:17 +0100
Message-ID: <20070120131716.GA4684@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <eojn5c$v9u$1@sea.gmane.org> <20070117205301.GH9761@nan92-1-81-57-214-146.fbx.proxad.net> <200701191040.17476.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 14:17:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8G6S-0001gM-BP
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 14:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbXATNRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 08:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbXATNRi
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 08:17:38 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:37869 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932889AbXATNRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 08:17:38 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1098DA6B;
	Sat, 20 Jan 2007 14:17:36 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 267B02014; Sat, 20 Jan 2007 14:17:17 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701191040.17476.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37271>

On Fri, Jan 19, 2007 at 10:40:16AM +0100, Jakub Narebski wrote:
> First, "stg rebase" when on some git branch might mean rebase StGIT
> stack to head of current branch (because there were some git commits
> on top of this branch). So it would be "stg rebase [--onto <target>]";
> it would be command without non-option arg, but this arg would be
> optional.

I'm not sure I understand.  Since the "current StGIT stack" is the one
pointed to by HEAD, how do you specify, when HEAD points to the target
branch, which stack to rebase ?

> Second, if you were to implement separating commands into subcommands
> (perhaps just as alternative names) depending on what they act on:
> "stg stack <subcommand>", "stg patch <subcommand>" etc., this would
> I think belong to "stg base <subcommand>".

Hm, the operation is not just about moving the stack base, it also has
to reapply patches, so, whereas the central concept is about moving
the base, the whole operation is indeed about the rebaseing the whole
stack.

I'm not sure we need to expose the "stack base" to the user as an
object she could manipulate all alone, I'd rather think it should only
be kept a read-only attribute of the stack, which gets changed when
the user rebases the stack.

IOW, the conceptual base object is private to the stack object, (it is
indeed just a simple text attribute) and only stack methods are
allowed to call base.move(), when they have ensured it can be done
safely (ie. popping all patches first).

Best regards,
-- 
Yann.
