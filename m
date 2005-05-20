From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Fix and clean up man page building
Date: Fri, 20 May 2005 16:52:12 +0200
Message-ID: <20050520145211.GB27395@diku.dk>
References: <E1DYmy8-0003YB-JW@highlab.com> <20050519155804.GB4513@pasky.ji.cz> <E1DYnpO-0003cF-I6@highlab.com> <Pine.LNX.4.58.0505190956330.2322@ppc970.osdl.org> <E1DYpbT-0003jv-JY@highlab.com> <20050520133533.GA27395@diku.dk> <m37jhu56ta.fsf@harinath.blr.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 16:52:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ8qR-0004Ho-7Y
	for gcvg-git@gmane.org; Fri, 20 May 2005 16:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVETOwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 10:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVETOwS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 10:52:18 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:60637 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261403AbVETOwN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 10:52:13 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id D92BF6E2012; Fri, 20 May 2005 16:51:54 +0200 (CEST)
Received: from brok.diku.dk (brok.diku.dk [130.225.96.163])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 9A8536E200A; Fri, 20 May 2005 16:51:54 +0200 (CEST)
Received: by brok.diku.dk (Postfix, from userid 3873)
	id 4F49961DDD; Fri, 20 May 2005 16:52:12 +0200 (CEST)
To: Raja R Harinath <rharinath@novell.com>
Content-Disposition: inline
In-Reply-To: <m37jhu56ta.fsf@harinath.blr.novell.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Raja R Harinath <rharinath@novell.com> wrote Fri, May 20, 2005:
> Hi,
> 
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > +%.7 : %.1
> > +	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
> > +	if [ -f "$<" ]; then mv $< $@; fi
> > +
> >  %.1 %.7 : %.xml
> >  	xmlto man $<
> > -	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
> > -	[ "$@" = "git.7" ] || mv git.1 $@
> >  
> >  %.xml : %.txt
> >  	asciidoc -b docbook -d manpage $<
> 
> That doesn't look right.  I think you want
> 
>   %.7: %.xml
>       xmlto man %<
>
>   %.1: %.xml
>        xmlto man $<
>        [ test -f $@ ] || mv git.1 $@

[ Looks like you mixed up %.1 and %.7 ]

Yes, separating the rule for %.1 and %.7 might be clearer. But it would
be great if it would work for any man page in section 7 not just git.7.
Since I hope to add cogito.7 soon.

-- 
Jonas Fonseca
