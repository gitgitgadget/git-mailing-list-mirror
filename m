From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Allow 'git blame rev path' to work on bare repository
Date: Sun, 4 Nov 2007 09:26:23 +0100
Organization: glandium.org
Message-ID: <20071104082623.GA3514@glandium.org>
References: <1194092575-7133-1-git-send-email-mh@glandium.org> <1194092575-7133-2-git-send-email-mh@glandium.org> <7vabpuvb4e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 09:28:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioapr-00049c-HV
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 09:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbXKDI1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 03:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbXKDI1g
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 03:27:36 -0500
Received: from vawad.err.no ([85.19.200.177]:33059 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912AbXKDI1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 03:27:35 -0500
Received: from aputeaux-153-1-38-67.w82-124.abo.wanadoo.fr ([82.124.130.67] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoapE-0000KE-UW; Sun, 04 Nov 2007 09:27:23 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoaoJ-0001nn-US; Sun, 04 Nov 2007 09:26:23 +0100
Content-Disposition: inline
In-Reply-To: <7vabpuvb4e.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63362>

On Sat, Nov 03, 2007 at 10:21:53PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > While 'git blame rev -- path' works, 'git blame rev path' didn't.
> >
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >  builtin-blame.c |    4 ----
> >  1 files changed, 0 insertions(+), 4 deletions(-)
> >
> > diff --git a/builtin-blame.c b/builtin-blame.c
> > index aedc294..141287e 100644
> > --- a/builtin-blame.c
> > +++ b/builtin-blame.c
> > @@ -2294,10 +2294,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> >  			}
> >  			else if (i != argc - 1)
> >  				usage(blame_usage); /* garbage at end */
> > -
> > -			if (!has_path_in_work_tree(path))
> > -				die("cannot stat path %s: %s",
> > -				    path, strerror(errno));
> >  		}
> >  	}
> >  
> 
> Sorry but a NAK; at least limit the removal of the test only to a bare
> repository case.

I fail to see why this test is necessary here. The lack of file in the
working tree is caught in fake_working_tree_commit() anyways.

Mike
