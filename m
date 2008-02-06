From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/4] Retain extra blank lines between the summary and
 the body
Date: Wed, 6 Feb 2008 17:17:46 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802061711231.13593@iabervon.org>
References: <alpine.LNX.1.00.0802061141320.13593@iabervon.org> <7v4pclx1xu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMsaz-0002cD-FQ
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758376AbYBFWRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758243AbYBFWRt
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:17:49 -0500
Received: from iabervon.org ([66.92.72.58]:52719 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758054AbYBFWRr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 17:17:47 -0500
Received: (qmail 19121 invoked by uid 1000); 6 Feb 2008 22:17:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 22:17:46 -0000
In-Reply-To: <7v4pclx1xu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72862>

On Wed, 6 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This is so that it's possible to have a message that will generate an
> > email with the first line blank. If the email you're generating is
> > actually a template, you may have a single line filling in for a
> > ~3-line paragraph, meaning that the space starts with a blank line,
> > which was impossible before as output from the message-splitting code.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> >  pretty.c |    4 ----
> >  1 files changed, 0 insertions(+), 4 deletions(-)
> >
> > diff --git a/pretty.c b/pretty.c
> > index f82380b..98efac2 100644
> > --- a/pretty.c
> > +++ b/pretty.c
> > @@ -713,7 +713,6 @@ void pp_remainder(enum cmit_fmt fmt,
> >  		  struct strbuf *sb,
> >  		  int indent)
> >  {
> > -	int first = 1;
> >  	for (;;) {
> >  		const char *line = *msg_p;
> >  		int linelen = get_one_line(line);
> > @@ -723,12 +722,9 @@ void pp_remainder(enum cmit_fmt fmt,
> >  			break;
> >  
> >  		if (is_empty_line(line, &linelen)) {
> > -			if (first)
> > -				continue;
> >  			if (fmt == CMIT_FMT_SHORT)
> >  				break;
> >  		}
> > -		first = 0;
> >  
> >  		strbuf_grow(sb, linelen + indent + 20);
> >  		if (indent) {
> 
> I have to wonder if this regresses the normal codepath to
> cleanse commit messages that have extra blanks at the
> beginning.

When we discussed this ages ago, I think we came to the conclusion that it 
didn't matter. The code doesn't remove extra blank lines from between body 
paragraphs, so it's a bit arbitrary to remove them between the first line 
and the following paragraph. And people tend not to have commit messages 
with blank lines there (in fact, I think git strips them out on commit).

	-Daniel
*This .sig left intentionally blank*
