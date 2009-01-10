From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb index performance (Re: [PATCH] gitweb: support the rel=vcs-* microformat)
Date: Fri, 09 Jan 2009 17:11:34 -0800 (PST)
Message-ID: <m33afs0xtm.fsf@localhost.localdomain>
References: <20090107042518.GB24735@gnu.kitenet.net>
	<gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net>
	<cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
	<20090107184515.GB31795@gnu.kitenet.net>
	<20090107190238.GA3909@gnu.kitenet.net>
	<20090107232427.GA18958@gnu.kitenet.net> <gk4bk5$9dq$1@ger.gmane.org>
	<20090108195446.GB18025@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 02:13:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLSPN-0001gP-90
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 02:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbZAJBLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 20:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbZAJBLh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 20:11:37 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:47739 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbZAJBLg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 20:11:36 -0500
Received: by ewy10 with SMTP id 10so10525468ewy.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 17:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=rBr0CiWMYeS+5eZWDL80X6GM7ZJpf2jYCRzYKaN8gTw=;
        b=rquMZ+OQn7S3fYGOusvwbvZsYOH4fthGIT0URX+SCIj8xnoJVRASKfVYN2mYct4AWA
         GBuL+7bjWHBbF/A9L5yytVyBHyBdD0YJNCW06oobnTw5EBIEdj+y5eZBtimfxYunp645
         8JSu4FDYo2hB2m56RYTUYY38t/5FI3H2ZEEok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=nlvHjO0MRJMlXnlx5k2IuKwt4gHHAPFGbxtuNdiEMSkVjqXmeFaZbBht3AQPlgvMay
         yaCVSxr6MREq03nfoxb+5CWjTj9aByaOosJ+9czeKctlZssITSYkn7geBsk0d/Jgswa5
         U9qkRgzNnI6a231kyYcbh5JVDTNGPRwy0FZAE=
Received: by 10.210.78.7 with SMTP id a7mr30900004ebb.156.1231549894577;
        Fri, 09 Jan 2009 17:11:34 -0800 (PST)
Received: from localhost.localdomain (abwp34.neoplus.adsl.tpnet.pl [83.8.239.34])
        by mx.google.com with ESMTPS id c25sm25754125ika.14.2009.01.09.17.11.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 17:11:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0A1BZLK028800;
	Sat, 10 Jan 2009 02:11:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0A1BXGI028796;
	Sat, 10 Jan 2009 02:11:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090108195446.GB18025@gnu.kitenet.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105054>

Joey Hess <joey@kitenet.net> writes:
> Giuseppe Bilotta wrote:

> > > There is a small overhead in including the microformat on project list
> > > and forks list pages, but getting the project descriptions for those pages
> > > already incurs a similar overhead, and the ability to get every repo url
> > > in one place seems worthwhile.
> > 
> > I agree with this, although people with very large project lists may
> > differ ... do we have timings on these?
> 
> AFAICS, when displaying the project list, gitweb reads each project's
> description file, falling back to reading its config file if there is no
> description file.
> 
> If performance was a problem here, the thing to do would be to add
> project descriptions to the $project_list file, and use those in
> preference to the description files. If a large site has done that,
> they've not sent in the patch. :-)

There was such patch sent by me, but IIRC it fall out, also because it
was sent IIRC in feature freeze time.  I have "gitweb: Extend
project_index file format by project description" in my StGit stack.

> 
> With my patch, it will read each cloneurl file too. The best way to
> optimise that for large sites seems to be to add an option that would
> ignore the cloneurl files and config file and always use
> @git_base_url_list.

Good idea.

> 
> I checked the only large site I have access to (git.debian.org) and they
> use a $project_list file, but I see no other performance tuning. That's
> a 2 ghz machine; it takes gitweb 28 (!) seconds to generate the nearly 1
> MB index web page for 1671 repositories:
> 
> /srv/git.debian.org/http/cgi-bin/gitweb.cgi  3.04s user 9.24s system 43% cpu 28.515 total
>
> 
> Notice that most of the time is spent by child processes. For each
> repository, gitweb runs git-for-each-ref to determine the time of the
> last commit.
> 
> If that is removed (say if there were a way to get the info w/o
> forking), performance improves nicely:
> 
> ./gitweb.cgi > /dev/null  1.29s user 1.08s system 69% cpu 3.389 total
> 
> Making it not read description files for each project, as I suggest above,
> is the next best optimisation:
> 
> ./gitweb.cgi > /dev/null  1.08s user 0.05s system 96% cpu 1.170 total
> 
> So, I think it makes sense to optimise gitweb and offer knobs for performance
> tuning at the expense of the flexability of description and cloneurl files.
> But, git-for-each-ref is swamping everything else.

One solution would be to limit number of projects displayed on the
page, for example to 100 projects, although that would mainly reduce
problem with dealing with large page on client size, less so server
load unless we _do not_ sort projects by age.

Another solution would be to use caching: repo.or.cz uses one solution
(caching only of projects_list action), kernel.org other solution
(gitweb caching from GSoC 2008 project).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
