From: Jeff King <peff@peff.net>
Subject: Re: Filter-branch's "move tree to subdirectory" example fails with
 BSD sed?
Date: Mon, 16 Apr 2012 13:13:07 -0400
Message-ID: <20120416171307.GA11221@sigill.intra.peff.net>
References: <20120414160028.GD1012@gmail.com>
 <4F89CF11.7060309@kdbg.org>
 <20120416152737.GB14724@sigill.intra.peff.net>
 <7vr4vnwqwo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Christopher Tiwald <christiwald@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:13:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJpUL-0003Db-H2
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 19:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab2DPRNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 13:13:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36393
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab2DPRNL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 13:13:11 -0400
Received: (qmail 26502 invoked by uid 107); 16 Apr 2012 17:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Apr 2012 13:13:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Apr 2012 13:13:07 -0400
Content-Disposition: inline
In-Reply-To: <7vr4vnwqwo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195667>

On Mon, Apr 16, 2012 at 10:03:03AM -0700, Junio C Hamano wrote:

> >   git filter-branch --index-filter '
> >     git ls-files -sz |
> >     perl -0pe "s{\t}{\tnewsubdir/}" |
> >     git update-index --from-scratch -z --index-info
> >   ' HEAD
> 
> Wouldn't "git read-tree --prefix=newsubdir/" suffice without the pipeline?
> I.e.
> 
>         git filter-branch --index-filter '
> 		rm -f "$GIT_INDEX_FILE"
>                 git read-tree --prefix=newsubdir/ "$GIT_COMMIT"
> 	' HEAD

Yeah, I think it does (at least it makes sense to me, and worked on a
simple test case). I think I might use "git read-tree --empty" instead
of "rm", as it is a little more obvious what is going on. But other than
that, it is much more readable.

It is a slight shame not to show an "ls-files | update-index" example,
because that is the most general form. But since this form is quite
often cut-and-paste by people, I think simple is better here. If we want
to show a more complex example, then we should add it separately.

-Peff
