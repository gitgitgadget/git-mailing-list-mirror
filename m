From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more
 user-friendly
Date: Mon, 21 Jan 2008 16:30:40 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801211539320.13593@iabervon.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org> <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org> <47946F67.5060601@gbarbier.org> <7vmyqzzdhf.fsf@gitster.siamese.dyndns.org> <47947399.3000507@gbarbier.org> <7vabmzzbcc.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801211212010.5731@racer.site> <7vejcbx795.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Gr=E9goire_Barbier?= <devel@gbarbier.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:31:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4Ed-0003YJ-4H
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbYAUVao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754988AbYAUVao
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:30:44 -0500
Received: from iabervon.org ([66.92.72.58]:49644 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbYAUVan (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 16:30:43 -0500
Received: (qmail 1068 invoked by uid 1000); 21 Jan 2008 21:30:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jan 2008 21:30:40 -0000
In-Reply-To: <7vejcbx795.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71347>

On Mon, 21 Jan 2008, Junio C Hamano wrote:

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
> 
>  * Is the code in 1.5.3.8 any better?  IOW, did we make it worse
>    during 1.5.4 cycle?

I believe that the move to transport.c didn't change anything except 
cleaning up linking conflicts and moving the dispatch by URL method code. 
I suppose something could have gotten messed up in dealing with the 
linking conflicts, but I don't think it actually did.

I think that the bad combination is requests getting aborted and 
USE_CURL_MULTI and early curl versions. I think that requests getting 
aborted is not normal, anyway, but not something easy for users to debug 
if it happens, and possible to have happen to anybody.

I don't really know much about http-push, and don't have a testing setup 
for it, so I can't really say if it works without USE_CURL_MULTI or how 
hard it would be to make it work.

	-Daniel
*This .sig left intentionally blank*
