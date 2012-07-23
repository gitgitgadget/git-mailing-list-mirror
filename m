From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] commit: check committer identity more strictly
Date: Mon, 23 Jul 2012 16:53:21 -0400
Message-ID: <20120723205321.GB6745@sigill.intra.peff.net>
References: <20120723184634.GA31905@sigill.intra.peff.net>
 <20120723185035.GB27588@sigill.intra.peff.net>
 <7vvchejj5e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramana Kumar <ramana@member.fsf.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPdB-0005vE-Lw
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab2GWUxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 16:53:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59204 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832Ab2GWUxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:53:24 -0400
Received: (qmail 7707 invoked by uid 107); 23 Jul 2012 20:53:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jul 2012 16:53:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jul 2012 16:53:21 -0400
Content-Disposition: inline
In-Reply-To: <7vvchejj5e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201981>

On Mon, Jul 23, 2012 at 01:51:25PM -0700, Junio C Hamano wrote:

> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 95eeab1..20cef95 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -725,7 +725,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> >  	strbuf_release(&sb);
> >  
> >  	/* This checks if committer ident is explicitly given */
> > -	strbuf_addstr(&committer_ident, git_committer_info(0));
> > +	strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
> >  	if (use_editor && include_status) {
> >  		char *ai_tmp, *ci_tmp;
> >  		if (whence != FROM_COMMIT)
> 
> Looks sensible.  Is this something we can detect in automated tests,
> or is it too cumbersome to set up?

Sorry, I meant to mention that in the cover letter. No, we can't test
this easily, because the code path in question is triggered by finding a
blank name in /etc/passwd. We'd have to override our getpwent lookup.

-Peff
