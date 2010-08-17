From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: The final one
Date: Tue, 17 Aug 2010 21:29:37 +0530
Message-ID: <20100817155933.GB6947@kytes>
References: <20100817144215.GC24886@kytes>
 <15605020.115671.1282060094242.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Stefan Sperling <stsp@elego.de>,
	Bert Huijben <rhuijben@collab.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Will Palmer <wmpalmer@gmail.com>,
	Philip Martin <philip.martin@wandisco.com>,
	Jonas Gehring <jonas.gehring@boolsoft.org>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 18:01:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlObl-0007Wv-38
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 18:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757760Ab0HQQBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 12:01:41 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55604 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab0HQQBd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 12:01:33 -0400
Received: by pxi10 with SMTP id 10so2433699pxi.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=a9AUAGE2lhjEKOriKgaF1yeji+vKRlaajJQljUOwozI=;
        b=jAYuafU62CntxPHU3t8+Jkn3Q6eH4k0EtmgqWUlhtSBLz/dXre0fmUvnKp9uF5QuTx
         Z27gXTAUyyB5N3Y0cMhFt051gisDDtfyqOnr/1AArmHx3IEoufZgQAeVYrfpPINobSpa
         hQEmjLn6OzWWYdkv7pffEX+u2e/D8OcV+GTNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FCp2V7g1nqn6RXY5rKfk7g7OmCZvaReooLSk8YGYQIEIEnzO9V4AtuF8ljJSTN48P6
         IbgS0a4dJ+2jG4dEyIb03mhmgQuZ0UxO+dC3lbtB7YoixGd+Emghqf0Vyu0avIl81jDF
         PRTgZKmgtnkxt+EctpWDM88pHZ73PxvdhjbYs=
Received: by 10.143.17.1 with SMTP id u1mr4630511wfi.288.1282060892883;
        Tue, 17 Aug 2010 09:01:32 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 23sm9898725wfa.22.2010.08.17.09.01.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 09:01:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <15605020.115671.1282060094242.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153756>

Hi Stephen,

Stephen Bash writes:
> Ram-
> 
> First, congratulations on making it through GSoC.  I've been avidly following your progress since our off-list discussion at the beginning of the summer, and I'm excited to watch the work continue.

Thank you :)

> > 1. Getting the revision history out of Subversion in a sane format
> > (dumpfile v3).
> >      ...
> > 2. Converting the revision history from dumpfile v3 format into a git
> > fast-import stream.
> >      ...
> > 5. Stitching everything together with a remote helper
> > application.
> >      ...
> > 6. A branch/tag mapper.
> 
> So being selfish, what I care about is an improved method for converting SVN repos to git repos once and never going back.  It sounds to me like the major hurdles remaining there are getting svn-fe to handle dumpfile v3 and handling branches/tags.  Is that correct?

We're doing better than that- when the whole thing is complete, we
should have perfectly seamless two-way compatibility. But yes, you're
right- there are several non-trivial tasks to handle, the top three of
which are:
1. Making svn-fe git-aware (and hence handle dumpfile v3)
2. Writing a fast-export to dumpfilev3 converter
3. Implementing the branch/ tag mapper in an extensible way

Don't worry about it though- we're all working hard on it :)

-- Ram
