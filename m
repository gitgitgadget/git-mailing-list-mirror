From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
Date: Wed, 20 Oct 2010 04:59:03 -0700 (PDT)
Message-ID: <m3bp6pkrf0.fsf@localhost.localdomain>
References: <20101018051702.GD22376@kytes>
	<8043579.526738.1287452576766.JavaMail.root@mail.hq.genarts.com>
	<20101019064210.GA14309@kytes>
	<1287563970.2673.12.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 14:02:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8XMu-0007kS-US
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 14:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0JTL7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 07:59:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41114 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab0JTL7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 07:59:08 -0400
Received: by fxm4 with SMTP id 4so2598136fxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=qAUbtTQ+VyJj/6wWiKUNyBeHmoazSn80W3EMJrKbQlA=;
        b=ELBGLWj16GIkX3BfFDgAI1h2D2XdTSUlsxwjOx3K8GPty70MPXPA3PZdyv6zt9r22i
         UgoYgxYZOS34HO8KeL+/KrXZxW9i3rMfXU58qPgImbRbIKJImsOMYPOm+Lg9/+L9XkkO
         cIkZ962MKBrL9gyor4KFS8OxJaWktCo8E/hOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WleJOSwqbIqaaFV5qOtuFYmmzdINdKFxRlm098nvK7JnlehIEVEBT7mJHaMRa7AdCj
         JYVGZ3zKdLIKtfv+yq19Y/COpcXl3c/gw7nJTHPveyf0Bf24Y9EzW5T0scTI2ijG7DEb
         pGiQ3glp/3p+xCcBa6ZBad2HqSG5hk89ydbfs=
Received: by 10.103.223.19 with SMTP id a19mr6534837mur.24.1287575946367;
        Wed, 20 Oct 2010 04:59:06 -0700 (PDT)
Received: from localhost.localdomain (abvx10.neoplus.adsl.tpnet.pl [83.8.221.10])
        by mx.google.com with ESMTPS id r22sm45334fax.45.2010.10.20.04.59.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 04:59:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9KBwEj7028871;
	Wed, 20 Oct 2010 13:58:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9KBvdps028865;
	Wed, 20 Oct 2010 13:57:39 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1287563970.2673.12.camel@wpalmer.simply-domain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159407>

Will Palmer <wmpalmer@gmail.com> writes:
> On Tue, 2010-10-19 at 12:12 +0530, Ramkumar Ramachandra wrote:
> > Stephen Bash writes:
> ...
> > > 
> > > I have 32 SVN revs in my history that touch multiple Git commit
> > > objects.  The simplest example is
> > >   svn mv svn://svnrepo/branches/badBranchName svn://svnrepo/branches/goodBranchName
> > > which creates a single SVN commit that touches two branches
> > > (badBranchName will have all it's contents deleted, goodBranchName
> > > will have an "empty commit" as described above).  The more devious
> > > version is the SVN rev where a developer checked out / (yes, I'm not
> > > kidding) and proceeded to modify a single file on all branches in
> > > one commit.  In our case, that one SVN rev touches 23 git commit
> > > objects.  And while the latter is somewhat a corner case, the former
> > > is common and probably needs to be dealt with appropriately (it's
> > > kind of a stupid operation in Git-land, so maybe it can just be
> > > squashed).
> > 
> > Ouch! Thanks for the illustrative example- I understand now. We have
> > to bend backwards to perform a one-to-one mapping. It's finally struck
> > me- one-to-one mapping is nearly impossible to achieve, and I don't
> > know if it makes sense to strive for it anymore. Looks like Jonathan
> > got it earlier.
> 
> It's been a while since I was involved in this discussion, so maybe the
> design has changed by now, but I was under the impression that there
> would be one "one-to-one" mapping branch (which would never be checked
> out), containing the history of /, and that the "real" git branches,
> tags, etc, would be based on the trees originally referenced by the root
> checkout, with git-notes (or similar) being used to track the weirdness
> in mappings. How does the "multiple branches touched in a single commit"
> complicate anything other than the heuristics for automatic branch
> detection (which I assume nobody is at the stage of talking about yet).

I think there might be a problem in that in git commit is defined by
its parents and its final state, while revision in Subversion is IIRC
defined by change.  Isn't it?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
