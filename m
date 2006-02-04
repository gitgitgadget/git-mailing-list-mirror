From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH 3/3] daemon: Support a --user-path option.
Date: Sat, 4 Feb 2006 10:02:35 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrndu8utr.2i8.mdw@metalzone.distorted.org.uk>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk> <20060203202706.1895.70864.stgit@metalzone.distorted.org.uk> <7vr76kcggx.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 11:02:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5KFo-0002WV-FA
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 11:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945994AbWBDKCs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 05:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945996AbWBDKCs
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 05:02:48 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:44075 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1945994AbWBDKCr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 05:02:47 -0500
Received: (qmail 21081 invoked by uid 110); 4 Feb 2006 10:02:35 -0000
To: git@vger.kernel.org
Received: (qmail 21067 invoked by uid 9); 4 Feb 2006 10:02:35 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1139047355 21065 172.29.199.2 (4 Feb 2006 10:02:35 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sat, 4 Feb 2006 10:02:35 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15582>

Junio C Hamano <junkio@cox.net> wrote:

> I am probably slow as usual but I do not see how this is useful.

I don't want the git-daemon roaming all over the file system.  Partly,
as a systems administrator, it makes me nervous about security (not for
any particularly good reason, I admit), but mainly because I don't want
to be exposing my local filesystem structure in my git://... namespace
-- it just seems like a bad idea.  This is what --base-path is all about.

I do still want users to be able to publish their repositories.  But I
also don't want git-daemon wandering all over their home directories --
restriction to sensible places is what --base-path is for, after all.

> Wouldn't loosening the "request must be absolute if you use
> --base-path" check in the area your first patch in the series
> touches to also allow paths that start with a '~' be enough?
> That way ~alice/foo would remain to be /home/alice/foo (with
> /home/alice being alice's $HOME) and ~becky/bar would be
> /home2/becky/bar (with /home2/becky being becky's $HOME).

That would still expose the structure of everyone's home directories in
git://~user URLs, which is rather unfortunate.  It's better than
nothing, though.

> I suppose you are doing something similar to ~/public_html, but
> I think that is an independent feature.

This is what I'm after, yes.  The above can be achieved
straightforwardly with --user-path=. if that's what you actually wanted.
(Indeed, --user-path= works too, but this is harder to explain.)

I think I'd probably either run with --user-path=public-git or
--user-path=public_html/git -- I've not made my mind up.

-- [mdw]
