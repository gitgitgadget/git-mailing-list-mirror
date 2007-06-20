From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-svn strangeness with tags and Squirrelmail repo
Date: Wed, 20 Jun 2007 21:13:18 +1200
Message-ID: <46a038f90706200213p2d1e3ba3nf58107584afe4901@mail.gmail.com>
References: <46a038f90706192205y71a77f5al5ca199b3ac382d71@mail.gmail.com>
	 <20070620072446.GC25010@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 11:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0wFd-0005u4-Ds
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 11:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbXFTJNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 05:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753694AbXFTJNU
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 05:13:20 -0400
Received: from ag-out-0708.google.com ([72.14.246.241]:43983 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbXFTJNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 05:13:19 -0400
Received: by ag-out-0708.google.com with SMTP id 35so139060aga
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 02:13:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aNjZF18sxfskHdll2C7U7Y8VZn43LjCdkPR+nP9JM8Z0dm1hu+uPgo3XAI3Az5YbHJRUWc/4eC4iIm7xrqGsS6WC2xDNfr8OtZrssXkdLNEH1ZbYs+LrHIn29GF9sK4A0+ZwlLWPISTg2a6mVoBjRzYWAPb+AyL1dvKu2U/H5Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=isPEDex+bCf+ERvhGhh9b5h+CnYoKZMogO2Oxze570FOjbSQdp+Pj0Kwf0fcDtY6wdNxuStLWcAnayO3raEGU2JmIcgiM/LbhK+svwjTYryYW9YomDgyJrwIKA9OnS4/0sQKj83+2JfTLWpI4HuXary0XWIozaizKoAWrDjZaYc=
Received: by 10.90.91.14 with SMTP id o14mr106345agb.1182330798071;
        Wed, 20 Jun 2007 02:13:18 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Wed, 20 Jun 2007 02:13:18 -0700 (PDT)
In-Reply-To: <20070620072446.GC25010@muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50552>

On 6/20/07, Eric Wong <normalperson@yhbt.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > First -- kudos to Eric Wong and company: git-svn can deal with the odd
> > errors and invalid chunks of XML or UTF-8 that SVN spits at me every
> > once in a while. And it "just works" in 99% of the situation. Great
> > stuff.
>
> You're welcome.  At the same time I'm not reallu sure what you mean by
> "odd errors and invalid chunks of XML or UTF-8 that SVN spits at me"
> unless it's some joke about SVN I'm not getting :)

Oh - the Squirrelmail SVN repo is one of those that have commits that
SVN itself cannot read due to invalid data. So git-svnimport, by
virtue of using the Perl SVN bindings, fails to import it.

git-svn, by some other virtue, imports it perfectly ;-)

> >   [svn-remote "svn"]
> >        url = http://squirrelmail.svn.sourceforge.net/svnroot/squirrelmail
> >        fetch = trunk/squirrelmail:refs/heads/svn/trunk
> >        branches = branches/*/squirrelmail:refs/heads/svn/*
> >        tags = tags/*/squirrelmail:refs/tags/svn/*
>
> git-svn expects 'refs/remotes/' in the local ref name.  Otherwise,
> the left-hand side is correct.

Good to know!

> > and when I do that -- trunk and branches do what I want, but tags
> > aren't imported anymore. :-/
>
> Now its odd to me that trunks and branches even works with those ref
> names.

I'm lucky then ;-)

My reason for the "alternative" locations is to match a bit better the
v1.5.0 behaviour re branches, tags and remotes, and to run the import
directly into a bare repo on git.catalyst.net.nz

 - Tags, by virtue of landing under refs/remotes are being treated as
heads rather than tags. That's why I want to have them in
refs/tags/<bla>/*

 - If branches + trunk end up in refs/remotes then my bare repo /
gateway doesn't work well - -refs/remotes aren't cloned or fetched

 - gitweb refuses to show those heads/tags (maybe it's because it's an
old version?)

cheers,


martin
