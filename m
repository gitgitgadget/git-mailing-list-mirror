From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 16:08:30 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903031558490.19665@iabervon.org>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com> <1235865822-14625-2-git-send-email-gitster@pobox.com> <1235865822-14625-3-git-send-email-gitster@pobox.com> <20090301031609.GA30384@coredump.intra.peff.net> <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
 <20090301100039.GD4146@coredump.intra.peff.net> <20090301170436.GA14365@spearce.org> <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org> <20090303070937.GB30609@coredump.intra.peff.net> <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 22:10:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LebsI-0004Hj-Iv
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 22:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbZCCVId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 16:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753786AbZCCVId
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 16:08:33 -0500
Received: from iabervon.org ([66.92.72.58]:48125 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbZCCVIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 16:08:32 -0500
Received: (qmail 19340 invoked by uid 1000); 3 Mar 2009 21:08:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Mar 2009 21:08:30 -0000
In-Reply-To: <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112168>

On Mon, 2 Mar 2009, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If you are going to limit it in that way, wouldn't it be better to do it
> > entirely client-side? As in, "git push --create remote" will literally
> > do:
> >
> >     ssh remote_host "mkdir -p remote_dir && cd remote_dir && git init --bare"
> >
> > ? Then you don't have to care about whether the remote side is recent
> > enough to support this, and there are no potential security issues; git
> > is merely saving you from typing the commands you could have done
> > yourself.
> 
> As with the previous "git init --remote" patch, my design constraints
> includes keeping the door open for "git shell" users to optionally allow
> this mode of operation.

One possibility would be to allow "git init" to create the directory (and 
its parents) if it is able. Then the command is "ssh remote_host 
GIT_DIR=remote_dir git init --bare". The "git shell" users can't use it, 
but only because "git shell" won't run "git init". But there's no reason 
it couldn't be configured (per-site or per-user) to allow it. Also, 
git-init could run the template's "pre-init" hook to do whatever it is 
that needs to be done for a new repository.

	-Daniel
*This .sig left intentionally blank*
