From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last
 change
Date: Tue, 24 Apr 2012 19:36:18 +0200
Message-ID: <20120424173618.GA15600@camk.edu.pl>
References: <20120403132735.GA12389@camk.edu.pl>
 <201204162206.50631.jnareb@gmail.com>
 <20120416213938.GB22574@camk.edu.pl>
 <201204180136.08570.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:36:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMjfJ-0000te-BK
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 19:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab2DXRgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 13:36:32 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:47685 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756844Ab2DXRgb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 13:36:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 147625F0052;
	Tue, 24 Apr 2012 19:37:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id olaQi91J5jw7; Tue, 24 Apr 2012 19:37:12 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 0D8F85F004F;
	Tue, 24 Apr 2012 19:37:12 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 436804671B; Tue, 24 Apr 2012 19:36:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201204180136.08570.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196229>

I'm sorry for the late answer.

On Wed, Apr 18, 2012 at 01:36:08AM +0200, Jakub Narebski wrote:
> On Mon, 16 Apr 2012, Kacper Kornet wrote:
> > On Mon, Apr 16, 2012 at 10:06:49PM +0200, Jakub Narebski wrote:
> >> On Mon, 16 Apr 2012, Kacper Kornet wrote:
> >>> On Sat, Apr 14, 2012 at 03:16:01PM +0200, Jakub Narebski wrote:

> >>> My tests show that forks are also a bottleneck in my setup.

> >> What do you mean by "my tests" here?  Is it benchmark (perhaps just using
> >> 'timed' feature) with and without custom change removing fork(s)?  Or did
> >> you used profiler (e.g. wondefull Devel::NYTProf) for that?

> > Nothing fancy. I look at the footnote produced by "timed" feature. And
> > I see a difference between version with the following patch:

[...]

> > and the one in which  git_repo_exist() uses invocation to /bin/true:

> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 18cdf96..4bcc66f 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3156,6 +3156,13 @@ sub git_get_project_owner {
> >  	return $owner;
> >  }

> > +sub git_repo_exist {
> > +	my ($path) = @_;
> > +
> > +        $git_dir = "$projectroot/$path";
> > +        return not system('/bin/true');
> > +}
> > +

> What were the differences in timing?

The best results with the host disk caches were:

v1.7.10
This page took 66.960714 seconds  and 16517 git commands to generate.

Call /bin/true in git_repo_exist()
This page took 45.583935 seconds  and 1 git commands to generate

The patches applied:
This page took 6.090545 seconds  and 1 git commands to generate.

> Anyway, if you plan on resending this patch series, then "gitweb: Improve
> repository verification" should be be first, I think.

Thank you for writing that one for me. I will send my two patches to
omit owner and last modification time on top of it. 

-- 
  Kacper Kornet
