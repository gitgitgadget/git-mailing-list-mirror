From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Require a struct remote in transport_get()
Date: Wed, 4 Nov 2009 02:27:57 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911040221100.14365@iabervon.org>
References: <alpine.LNX.2.00.0911032133540.14365@iabervon.org> <7vbpjin8v0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:28:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5aHi-0007lf-OA
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbZKDH1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 02:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbZKDH1w
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:27:52 -0500
Received: from iabervon.org ([66.92.72.58]:52286 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbZKDH1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 02:27:52 -0500
Received: (qmail 25749 invoked by uid 1000); 4 Nov 2009 07:27:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 07:27:57 -0000
In-Reply-To: <7vbpjin8v0.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132054>

On Tue, 3 Nov 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > cmd_ls_remote() was calling transport_get() with a NULL remote and a
> > non-NULL url in the case where it was run outside a git
> > repository. This involved a bunch of ill-tested special
> > cases. Instead, simply get the struct remote for the URL with
> > remote_get(), which works fine outside a git repository, and can also
> > take global options into account.
> >
> > This fixes a tiny and obscure bug where "git ls-remote" without a repo
> > didn't support global url.*.insteadOf, even though "git clone" and
> > "git ls-remote" in any repo did.
> >
> > Also, enforce that all callers provide a struct remote to transport_get().
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> > This is sufficient to stop the segfault when tring "git ls-remote 
> > http://..." outside of a repo, but not to make it work, which requires 
> > either something simple but not ideal or something complex.
> 
> Thanks; I think this and your other patch are important fixes, and should
> go directly on 'maint'.  Do you prefer to queue them on 'next' to cook for
> a week instead?

I don't think a week on 'next' is likely to turn up any new information; 
these are all uncommon code paths. It might be worth seeing if the 
original reporter is happy with how it's behaving now, though.

	-Daniel
*This .sig left intentionally blank*
