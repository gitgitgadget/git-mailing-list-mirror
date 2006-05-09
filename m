From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 18:30:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605081828250.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <1147048587.17371.13.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
 <Pine.LNX.4.64.0605081905240.6713@iabervon.org> <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
 <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 03:31:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdH48-0004cP-Qa
	for gcvg-git@gmane.org; Tue, 09 May 2006 03:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWEIBbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 21:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWEIBbE
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 21:31:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9604 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751064AbWEIBbD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 21:31:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k491UxtH010067
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 18:30:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k491UulO027819;
	Mon, 8 May 2006 18:30:58 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19807>



On Mon, 8 May 2006, Junio C Hamano wrote:
> 
> You dodged my comments on the SQL-like queries ;-).  I was half
> (perhaps 3/4) joking, but some people actually might like to be
> able to say:
> 
> 	git repo-config --get-all branch.name where url like 'git://%'

I think databases tend to be a huge mistake. Show me a SQL database where 
users can edit the data by hand, and it's all readable, and maybe I'll 
change my mind.

The monotone guys have almost everything in a database, and from what I 
can tell it results in (a) you can do some really funky queries and (b) 
it's confusing and slow as hell.

Now, the speed issue doesn't matter for a config file, but there the 
editability very much does.

> Oops, by the way, why does a [branch] have url as its attribute?
> I think this was a bad example -- we are talking about [remote]
> here.  But the main point is about syntax, so that is OK.

Yeah, "remote" is clearly better than "url".

> I am reluctant to buy that argument (I see it is an easy way
> from the implementation point of view) -- it appears to me that
> it would invite this easy user error.
> 
> 	[branch]
>         	name = linus
>         	url = git://git.kernel.org/../torvalds/linux-2.6
> 
> 	[branch]
>         	url = git://git.kernel.org/../jgarzik/libata-dev
>         	name = libata

Yes, that would be a silent and confusing error.

		Linus
