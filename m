From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty
 tree
Date: Thu, 20 Jun 2013 16:19:57 -0400
Message-ID: <20130620201957.GC31364@sigill.intra.peff.net>
References: <20130620124758.GA2376@sigill.intra.peff.net>
 <aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
 <7v8v24vd0m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 22:20:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UplKy-0005fI-3c
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 22:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126Ab3FTUUC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 16:20:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:59545 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965473Ab3FTUUB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 16:20:01 -0400
Received: (qmail 6764 invoked by uid 102); 20 Jun 2013 20:21:00 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 15:21:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 16:19:57 -0400
Content-Disposition: inline
In-Reply-To: <7v8v24vd0m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228531>

On Thu, Jun 20, 2013 at 11:43:37AM -0700, Junio C Hamano wrote:

> Thomas Rast <trast@inf.ethz.ch> writes:
> 
> > The logic for pulling into an unborn branch was originally designed to
> > be used on a newly-initialized repository (d09e79c, git-pull: allow
> > pulling into an empty repository, 2006-11-16).  It thus did not
> > initially deal with uncommitted changes in the unborn branch.  The
> > case of an _unstaged_ untracked file was fixed by 4b3ffe5 (pull: do
> > not clobber untracked files on initial pull, 2011-03-25).  However, it
> > still clobbered existing staged files, both when the file exists in
> > the merged commit (it will be overwritten), and when it does not (it
> > will be deleted).
> 
> Perhaps making sure the index is empty is sufficient, then?

That would not let you pull when you have "foo" staged, but upstream
does not have "foo" at all. To be fair, that is quite a corner case, and
simply rejecting the pull entirely may be OK. But read-tree already does
the hard work for us, so I don't think it is a lot of code either way.

-Peff
