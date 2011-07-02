From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Sat, 02 Jul 2011 13:23:38 -0700 (PDT)
Message-ID: <m3aacw5t5x.fsf@localhost.localdomain>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
	<20110702104313.GA10245@sigill.intra.peff.net>
	<20110702104437.GA10538@sigill.intra.peff.net>
	<CALWDD1woB0ytL6T-DwD92f824dnpz0mek=SYgz5jwqR0efnkpw@mail.gmail.com>
	<20110702185724.GA14390@sigill.intra.peff.net>
	<CALWDD1zrOUwS2FeQs1SsFuLnaDzhCHZVFLvFXv7aLex1K2v5zw@mail.gmail.com>
	<20110702195735.GA15542@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Al Haraka <alharaka@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 02 22:23:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd6jG-00069S-5v
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 22:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab1GBUXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 16:23:42 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59518 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172Ab1GBUXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 16:23:41 -0400
Received: by fxd18 with SMTP id 18so4141640fxd.11
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=CmCfpivplnT8zjDJgLUwDwxvVDY9PYDv9pKMv/Py5Oo=;
        b=ji7UjOHhkObgK64tIWkPIAwMu1bUq5E8ZliDQi+gygunCwKJD7cqUpj0ja1rXoCpiI
         vZzx0ZnJwMOz9aUNXife/kd2R0lSKnlR7yf4cktv0nARggIvNtf7oYVTdqxhRv6pwQPB
         6unnprl94K7oMugzMadxicS3G2UQ+widl9zqw=
Received: by 10.223.91.156 with SMTP id n28mr3210746fam.102.1309638219649;
        Sat, 02 Jul 2011 13:23:39 -0700 (PDT)
Received: from localhost.localdomain (abvp70.neoplus.adsl.tpnet.pl [83.8.213.70])
        by mx.google.com with ESMTPS id q21sm3319975fan.16.2011.07.02.13.23.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Jul 2011 13:23:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p62KN6QD016818;
	Sat, 2 Jul 2011 22:23:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p62KMo6s016813;
	Sat, 2 Jul 2011 22:22:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110702195735.GA15542@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176568>

Jeff King <peff@peff.net> writes:
> On Sat, Jul 02, 2011 at 10:18:55PM +0300, Al Haraka wrote:
> 
> > > which will make the repository-wide non-version-controlled gitattributes
> > > the same as the last committed version. The problem is that it won't be
> > > automatically updated as you commit and push changes to .gitattributes.
> > 
> > I thought my plan was to try and avoid this by using the
> > core.attributesfile directive, forcing this stuff to operate system
> > (well, account, besides the point here) wide on all repos with
> > specifying a .gitattributes (or, since it base bare, as you pointed
> > out yourself, $GIT_REPO_DIR/info/attributes) every single time.  Did I
> > misunderstand the mailing list thread that mentioned this a while
> > back?
> 
> Ah, I see. That seems like a reasonable solution. Are you sure that the
> user running gitweb as a CGI is the same as the user you log in as? That
> is, are you sure that ~/.gitconfig is being parsed when it is called as
> a CGI, and it's not looking in ~www/.gitconfig or something?
> 
> It would depend how your hosting is set up.

Well, there is also system wide $(prefix)/etc/gitconfig file...
 
> > This is the reason I went through the trouble of compiling an updated
> > version in my account (as opposed to the installed version on the
> > Dreamhost box; they are stuck at version 1.7.1.1; I saw this mentioned
> > on a thread somewhere and wanted to get the "latest" (well latest
> > stable version) to avoid this kind of problem?  Was that the right
> > thing to do?  Will it even work in this case?  I get the feeling from
> > your response I was expecting a lot with RTFM'ing more.
> 
> It sounds like it should work to me, but I've not tested it (nor do I
> even run gitweb; I just have an interest in textconv).

The question is if --textconv works with git-diff-tree, because that
is what gitweb uses.

BTW. we could use --textconv in 'blob' and 'blame' views (it is
documented that git-cat-file supports --textconv, and it is checked in
git testsuite but not documented that git-blame supports --textconv).
But it would require changes to gitweb.


Hoping that this email will made it...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
