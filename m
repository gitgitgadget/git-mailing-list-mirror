From: Jeff King <peff@peff.net>
Subject: Re: Feature request: Store comments on branches
Date: Wed, 21 Oct 2009 10:13:52 -0400
Message-ID: <20091021141352.GA24230@coredump.intra.peff.net>
References: <20091021133702.GA470@lisa>
 <18071eea0910210646l41f18deam8c75f1218df7e25a@mail.gmail.com>
 <28c656e20910210656m5ad597b9h7668e33eeb86b096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Patrick Schoenfeld <schoenfeld@debian.org>, git@vger.kernel.org
To: B Smith-Mannschott <bsmith.occs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 16:14:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0bwx-0003qw-1V
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 16:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZJUONx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 10:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbZJUONx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 10:13:53 -0400
Received: from peff.net ([208.65.91.99]:47029 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbZJUONx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 10:13:53 -0400
Received: (qmail 16121 invoked by uid 107); 21 Oct 2009 14:17:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Oct 2009 10:17:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Oct 2009 10:13:52 -0400
Content-Disposition: inline
In-Reply-To: <28c656e20910210656m5ad597b9h7668e33eeb86b096@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130921>

On Wed, Oct 21, 2009 at 03:56:51PM +0200, B Smith-Mannschott wrote:

> >> What do others think about this? Would this be useful
> >> for others, too?
> >
> > This feature is already being worked on as "git notes" -- see the "pu"
> > branch, I think it's still in there, unless it has graduated to next;
> > I forget now.
> 
> Really? I was under the impression that the nodes were meant to
> annotate commits, or more generally things with SHA-1 IDs. (commits,
> tress, blobs). The SHA-1 ID a branch uses to refer to its HEAD commit
> changes with every commit, and the branch itself doesn't have an ID,
> just a name.

Yes, I think you are right. If I understand the OP, he really just wants
to annotate the refs themselves, not the commits they point to. So you
could probably get away with setting a "branch.$name.description" config
variable and then showing it during "git branch". The downside of such a
scheme is that it is purely local -- there's no way of pushing or
pulling your descriptions (which is maybe a feature, if you are thinking
of the descriptions as something only for you yourself to see).

A related technique is to maintain a separate meta repository which has
a list of branches, their status, etc. This is what Junio does with the
'todo' branch of git.git. The advantage is that it is fully version
controlled, and you can do much more than just set descriptions (e.g.,
'todo' also has scripts for maintaining the list of topic branches,
calculating branch dependencies, building the pu branch, etc). The
disadvantage is that it's a lot more work to set up and maintain.

-Peff
