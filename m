From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Warn when calling deref_tag() on broken tags
Date: Wed, 2 Nov 2005 21:50:58 +0100
Message-ID: <20051102205058.GF1431@pasky.or.cz>
References: <20051102200751.26904.5780.stgit@machine.or.cz> <Pine.LNX.4.63.0511022115250.13746@wbgn013.biozentrum.uni-wuerzburg.de> <20051102204101.GE1431@pasky.or.cz> <Pine.LNX.4.63.0511022145010.13989@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 21:53:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXPZa-0003rc-GF
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 21:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbVKBUvD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 15:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbVKBUvD
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 15:51:03 -0500
Received: from w241.dkm.cz ([62.24.88.241]:63669 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965234AbVKBUvB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 15:51:01 -0500
Received: (qmail 30623 invoked by uid 2001); 2 Nov 2005 21:50:58 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511022145010.13989@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11041>

Dear diary, on Wed, Nov 02, 2005 at 09:47:46PM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> On Wed, 2 Nov 2005, Petr Baudis wrote:
> > diff --git a/tag.c b/tag.c
> > index b1ab75f..9cd09cf 100644
> > --- a/tag.c
> > +++ b/tag.c
> > @@ -3,10 +3,18 @@
> >  
> >  const char *tag_type = "tag";
> >  
> > -struct object *deref_tag(struct object *o)
> > +/* The refname argument is optional and suitable to use only if
> > + * we use this to resolve an actual tag ref. */
> > +struct object *deref_tag(struct object *o, const char *refname)
> 
> How about leaving dereg_tag's signature alone, and warn something like 
> 
> 	"You have a broken tag (sha1=%s).\n"
> 	"To find out which name(s) it corresponds to, execute\n"
> 	"\tgit-name-rev --tags %s\n"
> 
> What do you think?

I don't know. For multiple broken tags, or multiple invocations of
deref_tag() on the same tag, this will fill a lot of screen estate. And
if we mostly actually have this information, why not show it to the user
right aay?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
