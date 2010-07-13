From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] revert: don't print "Finished one cherry-pick." if commit failed
Date: Tue, 13 Jul 2010 23:06:33 +0200
Message-ID: <201007132306.33828.chriscool@tuxfamily.org>
References: <20100712115455.12251.47449.chriscool@tuxfamily.org> <20100712163934.GA1869@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:06:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmgb-0007Gp-I8
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab0GMVGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:06:36 -0400
Received: from smtp2f.orange.fr ([80.12.242.151]:35661 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab0GMVGf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:06:35 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id D203780009F3;
	Tue, 13 Jul 2010 23:06:34 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id C472E80009F9;
	Tue, 13 Jul 2010 23:06:34 +0200 (CEST)
Received: from style.localnet (ANantes-156-1-132-89.w90-12.abo.wanadoo.fr [90.12.251.89])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id A369580009F3;
	Tue, 13 Jul 2010 23:06:34 +0200 (CEST)
X-ME-UUID: 20100713210634669.A369580009F3@mwinf2f14.orange.fr
User-Agent: KMail/1.13.2 (Linux/2.6.32-23-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100712163934.GA1869@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150915>

On Monday 12 July 2010 18:39:35 Jonathan Nieder wrote:
> Christian Couder wrote:
> > And, while at it, refactor commit code into a new run_git_commit()
> > function.
> 
> Probably should be two patches.

Ok, I will split it in two patches.

> > +++ b/builtin/revert.c
> > @@ -492,48 +518,17 @@ static int do_pick_commit(void)
> > 
> >  			mebuf.buf, help_msg());
> >  		
> >  		rerere(allow_rerere_auto);
> >  	
> >  	} else {
> > 
> > -		fprintf(stderr, "Finished one %s.\n", mebuf.buf);
> > +		if (!no_commit)
> > +			res = run_git_commit(defmsg);
> > +		if (!res)
> > +			fprintf(stderr, "Finished one %s.\n", mebuf.buf);
> > 
> >  	}
> 
> Ack for this part.  Thanks.

Thanks,
Christian.
