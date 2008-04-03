From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] merge --summary vs. merge.summary
Date: Thu, 3 Apr 2008 06:30:56 -0400
Message-ID: <20080403103056.GD6673@coredump.intra.peff.net>
References: <1207213396-17370-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhMjP-0006QE-Vx
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 12:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYDCKbA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 06:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbYDCKa7
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 06:30:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3856 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806AbYDCKa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 06:30:59 -0400
Received: (qmail 10116 invoked by uid 111); 3 Apr 2008 10:30:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 03 Apr 2008 06:30:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Apr 2008 06:30:56 -0400
Content-Disposition: inline
In-Reply-To: <1207213396-17370-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78744>

On Thu, Apr 03, 2008 at 11:03:14AM +0200, SZEDER G=C3=A1bor wrote:

> So the '--summary' option controls the printing of diffstat, while th=
e
> 'merge.summary' config variable controls the behaviour of 'fmt-merge-=
msg',

Think that --diffstat is probably a better name. But your series
actually _changes_ the meaning of --summary, which is probably a bad
idea for people who have scripted around these.

The problem is that you have two concepts with the same name; giving on=
e
of the concepts the name means that the other concept breaks.

I think the most compatible way to go forward is to use two new names:

  1. --summary (and --no- form) changes to --diffstat; --summary remain=
s
     as a compatibility alias for --diffstat.

  2. merge.summary becomes merge.something_else, along with
     --something-else support. merge.summary remains as a compatibility
     option for merge.something_else.

Though I can't think of a good "something_else". Given that there isn't
even a command-line equivalent to merge.summary now, maybe just leave i=
t
as merge.summary, stop advertising --summary (even though it is a
compatibility alias, we officially call it --diffstat), and then there
is less confusion on the part of documentation readers (though perhaps
more on the part of those who blindly try --summary).

-Peff
