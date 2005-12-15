From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] We do not like "HEAD" as a new branch name
Date: Thu, 15 Dec 2005 17:40:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512151737240.3542@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
 <43A19962.2000202@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 15 17:42:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emw9P-0008Pe-NQ
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 17:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVLOQkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 11:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVLOQkJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 11:40:09 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53909 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750805AbVLOQkH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 11:40:07 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 63DBA13F5A6; Thu, 15 Dec 2005 17:40:06 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4A1059DE26; Thu, 15 Dec 2005 17:40:06 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3724E9DDBD; Thu, 15 Dec 2005 17:40:06 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9D3DB13F5A6; Thu, 15 Dec 2005 17:40:05 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43A19962.2000202@zytor.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13704>

Hi,

On Thu, 15 Dec 2005, H. Peter Anvin wrote:

> Johannes Schindelin wrote:
> > This makes git-check-ref-format fail for "HEAD". Since the check is only
> > executed when creating refs, the existing symbolic ref is safe.
> 
> > diff --git a/refs.c b/refs.c
> > index bda45f7..293bfe7 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -332,6 +332,11 @@ int check_ref_format(const char *ref)
> >  		if (ch == '.' || bad_ref_char(ch))
> >  			return -1;
> >  +		/* do not allow "HEAD" as ref name */
> > +		if (ch == 'H' && (!strcmp(cp, "EAD") ||
> > +					!strncmp(cp, "EAD/", 4)))
> > +			return -1;
> > +
> >  		/* scan the rest of the path component */
> >  		while ((ch = *cp++) != 0) {
> 
> If you're have to open-code it, you might want to just do it all the way:
> 
> if (ch == 'H' && cp[0] == 'E' && cp[1] == 'A' && cp[2] == 'D' &&
>     (cp[3] == '\0' || cp[3] == '/'))

;-)

I don't really care. I could have used !strcmp(cp - 1, "HEAD"), just as 
well...

Ciao,
Dscho
