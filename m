From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] gitweb wishlist and TODO list
Date: Tue, 20 Jun 2006 18:51:18 +0200
Organization: At home
Message-ID: <e79921$u0e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jun 20 18:52:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsjSt-0003bo-Bp
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 18:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWFTQwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 12:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWFTQwc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 12:52:32 -0400
Received: from main.gmane.org ([80.91.229.2]:9427 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751411AbWFTQwc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 12:52:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FsjSc-0003YI-UN
	for git@vger.kernel.org; Tue, 20 Jun 2006 18:52:18 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 18:52:18 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 18:52:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22213>

I am planning on copying features from xmms2's gitweb version 
to git's gitweb, and introducing new ones.

My gitweb can be seen at http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi
Fetch from http://front.fuw.edu.pl/jnareb/scm/git.git/ (not checked!)


* HTML cleanup - ongoing process of replacing embedded style information
  with CSS styling, adding classes and ids to elements. This is independent 
  on other changes. On top of 'next', as it needs style in separate CSS
  file gitweb.css.

* Storing site-wide gitweb configuration in separate gitweb.conf file.
  Needs GIT_CONFIG patch. Not implemented yet.

  Bootstrapping: gitweb would need location of configuration file.
  Has to be changed in gitweb.cgi itself. Additionally gitexecdir or
  git in PATH is needed to be able to run git-repo-config to read config;
  the solution might be home-grown "parser" to find gitexecdir only.

  Both could be set from Makefile at install stage.

* Add git fetch URL to the project page from gitweb-xmms2. Needs site-wide
  base_url, which need not to be set as there is sane default: use base 
  of gitweb URL.

  Is it useful to allow repository configuration to override it?

* Support for categories from gitweb-xmms2. We can alternatively use
  directory structure of git projects displayed by gitweb as categories.
  Needs I think some site-wide configuration.

  Question: where store categories? .git/category, like .git/description?
  Use gitweb.category key? If yes, do convert description to repository key,
  or perhaps use gitweb.descriptionfile? What should be priority of those
  options if both are set: use repo-config for short (in project listing 
  and in page footer), and from file for long description on project page?
  What if they don't match?

* Refactor dispatch from if...elsif...else construction 
  to using 'name' => \&sub hash.

* Refactor generation of navigation bar. There are at least two
  implementations of that. With hash dispatch it would be easy to
  list all possibilities.

* Add (of course optional, like blame support) snapshot support. There are
  at least two different implementations. I'd prefer to do without second
  CGI script, but perhaps this is better from the performance point of view.
  gitweb-xmms2 has snapshot.cgi in Python: should it be rewritten in Perl?

* Code highlighting for plain view for blobs. gitweb-xmms2 did that using
  GNU highlight program and some embedded configuration (filename regexp to
  syntax used). More generic: run some post-processing. Configurable
  globally (perhaps separate "syntax type" filename or file magic mapping),
  and enabled per repository (default off).

* gitweb-xmms2 has something called committags support: it means that
  'BUG(n)', 'FEATURE(n)' and 'RELEASE: xx' in commit message are turned into
  bugtracker (Mantis for xmms2) or wiki links. It is extension of turning
  sha1-ids into references. Probably needs some extra configuration file,
  and some per repository configuration. Of course we want to support not
  only Mantis, but also e.g. Bugzilla (e.g. Linux kernel) and conventions
  for marking bugs therein.

* gitweb-xmms2 has also etags based anchors to mark function definitions 
  in blob view. I'm not sure it would be that usefull. LXR equivalent,
  perhaps...


Which of those should be implemented first?

Any further ideas for other useful features?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
