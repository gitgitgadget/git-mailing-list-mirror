From: Jeff King <peff@peff.net>
Subject: Re: [git-users] Git clone fails with "bad pack header", how to get
 remote log
Date: Wed, 31 Oct 2012 10:19:55 -0400
Message-ID: <20121031141955.GC24291@sigill.intra.peff.net>
References: <7f498800-ed38-474d-86ad-cb937be68173@googlegroups.com>
 <20121029211854.b58c791d30a6c8d68665e574@domain007.com>
 <508FEAE0.20204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git-users@googlegroups.com, git@vger.kernel.org
To: kevin molcard <kev2041@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:20:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTZ9Q-0004lk-St
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 15:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935664Ab2JaOT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 10:19:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45150 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935632Ab2JaOT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 10:19:59 -0400
Received: (qmail 14752 invoked by uid 107); 31 Oct 2012 14:20:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Oct 2012 10:20:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2012 10:19:55 -0400
Content-Disposition: inline
In-Reply-To: <508FEAE0.20204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208824>

On Tue, Oct 30, 2012 at 03:57:36PM +0100, kevin molcard wrote:

> I tried to install git 1.8 on the remote server and get exactly the
> same problem :(.
> [...]
> >>Sometimes (very often when several git clone are sent at the same
> >>time), I have the following error:
> >>     remote: internal server error
> >>     fatal: protocol error: bad pack header

I'm very confused about who is printing "internal server error". The
"remote:" indicates that it came to the git client via the sideband,
which means it probably came from the stderr of a child process (e.g.,
pack-objects). But git does not and has never generated the phrase
"internal server error".

So what program is producing that? Is there some kind of custom layer
that might be run when upload-pack runs "git pack-objects ..."? Can you
try running strace on the server?

-Peff
