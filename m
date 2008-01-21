From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more
	user-friendly
Date: Mon, 21 Jan 2008 21:29:53 +0100
Organization: glandium.org
Message-ID: <20080121202953.GA18440@glandium.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org> <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org> <47946F67.5060601@gbarbier.org> <7vmyqzzdhf.fsf@gitster.siamese.dyndns.org> <47947399.3000507@gbarbier.org> <7vabmzzbcc.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801211212010.5731@racer.site> <7vejcbx795.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-15?Q?Gr=E9goire?= Barbier <devel@gbarbier.org>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:30:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3HO-0006uC-Qo
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbYAUU3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756180AbYAUU3c
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:29:32 -0500
Received: from vuizook.err.no ([85.19.215.103]:38424 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755438AbYAUU3b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 15:29:31 -0500
Received: from aputeaux-153-1-83-190.w86-205.abo.wanadoo.fr ([86.205.41.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JH3H0-0000ho-Vq; Mon, 21 Jan 2008 21:29:45 +0100
Received: from mh by jigen with local (Exim 4.68)
	(envelope-from <mh@jigen>)
	id 1JH3HF-0004tz-TN; Mon, 21 Jan 2008 21:29:53 +0100
Content-Disposition: inline
In-Reply-To: <7vejcbx795.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71327>

On Mon, Jan 21, 2008 at 12:18:14PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > IMHO it is safer to disable it for curl < 7.0xa -- even if it affects a 
> > number of distros -- than to give the illusion that it works, when it does 
> > not.
> >
> > As for fixing it in the non-MULTI case, I have a hunch that Mike's 
> > cleanups will help that, but that this is a 1.5.5 feature.
> >
> > So, I would like to read in the ReleaseNotes something like this:
> >
> > -- snip --
> > Support for pushing via HTTP was broken with curl versions prior to 7.16, 
> > so we disabled it for now.  However, it is likely that a major cleanup of 
> > the http transport code -- scheduled after the release of git 1.5.4 -- 
> > will be supported with more curl versions.
> > -- snap --
> 
> That's tempting but I suspect that it might be a wrong approach.
> 
> I think two important questions are:
> 
>  * Do we know that the current code is broken for everybody, or
>    just broken for the majority of people who do nontrivial
>    things?

IIRC, http-push simply doesn't work without CURL_MULTI. 

>  * Is the code in 1.5.3.8 any better?  IOW, did we make it worse
>    during 1.5.4 cycle?

Changes in http-push.c since 1.5.3.8 mostly involve cleanup. It
didn't change anything about CURL_MULTI or lack thereof.

Mike
