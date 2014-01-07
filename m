From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] format-patch: introduce branch.*.forkedFrom
Date: Tue, 7 Jan 2014 15:40:35 -0500
Message-ID: <20140107204035.GA27932@sigill.intra.peff.net>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
 <CALkWK0=g5-9r05vTkys8Tk7iv7PqPZJvMvkYsAOnN_F90Mtgxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 21:40:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0dS7-0004BY-Dz
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 21:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbaAGUkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 15:40:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:56671 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751541AbaAGUkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 15:40:39 -0500
Received: (qmail 22555 invoked by uid 102); 7 Jan 2014 20:40:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 14:40:39 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 15:40:35 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0=g5-9r05vTkys8Tk7iv7PqPZJvMvkYsAOnN_F90Mtgxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240148>

On Wed, Jan 08, 2014 at 02:00:44AM +0530, Ramkumar Ramachandra wrote:

> On Wed, Jan 8, 2014 at 1:59 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> > A very common workflow for preparing patches involves working off a
> > topic branch and generating patches against 'master' to send off to the
> > maintainer. However, a plain
> >
> >   $ git format-patch -o outgoing
> >
> > is a no-op on a topic branch, and the user has to remember to specify
> > 'master' explicitly everytime. This problem is not unique to
> > format-patch; even a
> >
> >   $ git rebase -i
> >
> > is a no-op because the branch to rebase against isn't specified.
> >
> > To tackle this problem, introduce branch.*.forkedFrom which can specify
> > the parent branch of a topic branch. Future patches will build
> > functionality around this new configuration variable.
> >
> > Cc: Jeff King <peff@peff.net>
> > Cc: Junio C Hamano <gister@pobox.com>
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

I have not carefully read some of the later bits of the discussion from
last night / this morning, so maybe I am missing something, but this
seems backwards to me from what Junio and I were discussing earlier.

The point was that the meaning of "@{upstream}" (and "branch.*.merge")
is _already_ "forked-from", and "push -u" and "push.default=upstream"
are the odd men out. If we are going to add an option to distinguish the
two branch relationships:

  1. Where you forked from

  2. Where you push to

we should leave @{upstream} as (1), and add a new option to represent
(2). Not the other way around.

Am I missing something?

-Peff
