From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 0/4] Signed push
Date: Sun, 11 Sep 2011 11:51:46 -0400
Message-ID: <20110911155146.GA15820@thunk.org>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com>
 <7vipp1otyp.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hWVPCEeJKKccp4Wc-j+XMSFXqRf6VYd7ngLER8RhODRQ@mail.gmail.com>
 <7vehzopdga.fsf@alter.siamese.dyndns.org>
 <20110910192225.GA5397@thunk.org>
 <7v4o0jq2fx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 17:52:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2mL2-0008Rz-Rb
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 17:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885Ab1IKPvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 11:51:48 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:58715 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843Ab1IKPvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 11:51:47 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1R2mJs-0000vj-1F; Sun, 11 Sep 2011 15:51:44 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1R2mJu-0004OF-CI; Sun, 11 Sep 2011 11:51:46 -0400
Content-Disposition: inline
In-Reply-To: <7v4o0jq2fx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181176>

On Sat, Sep 10, 2011 at 06:42:58PM -0700, Junio C Hamano wrote:
> Perhaps we shouldn't worry about tag namespace contamination to make
> things easier and simpler and stop using notes tree?

With the appropriate conventions, such as using a tag name such as
signed-<email>-<timestamp>" we can at least avoid name conflicts, at
least for all practical purposes.

There is the additional problem that "git tag -l" gets painful.  At
least for me, though, it's already mostly useless:

   % git tag -l | grep ^v[23] | wc -l
   858

I can work around this with git aliases that filter out certain
prefixes that I normally don't care about, but maybe that's something
that should be directly supported in git-tag with some git-config
parameters.

The final issue that I'd worry about with using tags is performance.
If we have hundreds of thousands or millions of tags of the form
signed-<email>-<timestamp>, is this going to be a problem?  This does
seem like something that could be worked around --- in the worst case
there could just be a locally maintained reverse index from git commit
id's to tag names.  (Although as I recall Linus objected to having
something like this for time skews, so maybe he'd object to this too.)

	       	    	     	       	     	  - Ted
