From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
	local branches
Date: Mon, 18 Feb 2008 20:00:43 +0100
Organization: glandium.org
Message-ID: <20080218190043.GA24240@glandium.org>
References: <1203341084-18543-1-git-send-email-jaysoffian@gmail.com> <alpine.LSU.1.00.0802181328380.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:01:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRBF9-0004tF-7Q
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 20:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbYBRTA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 14:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbYBRTA7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 14:00:59 -0500
Received: from vuizook.err.no ([85.19.215.103]:52871 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbYBRTA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 14:00:58 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JRBEN-0000wl-PJ; Mon, 18 Feb 2008 20:00:54 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JRBEJ-0006mV-Iq; Mon, 18 Feb 2008 20:00:43 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802181328380.30505@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74332>

On Mon, Feb 18, 2008 at 01:29:55PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> sorry, I overlooked that earlier:
> 
> On Mon, 18 Feb 2008, Jay Soffian wrote:
> 
> > diff --git a/branch.c b/branch.c
> > index 1fc8788..24e98dd 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -130,7 +130,15 @@ void create_branch(const char *head,
> >  	   automatically merges from there.  So far, this is only done for
> >  	   remotes registered via .git/config.  */
> >  	if (real_ref && track)
> > -		setup_tracking(name, real_ref);
> > +		if (setup_tracking(name, real_ref) == 1 && track == BRANCH_TRACK_ALWAYS) {
> 
> This line is too long.
> 
> > +			char key[1024];
> > +			sprintf(key, "branch.%s.remote", name);
> 
> To stay safe, you should use snprintf() and test the return value.

Or use strbufs.

Mike
