From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] gitweb wishlist and TODO list (templating)
Date: Thu, 25 Sep 2008 19:10:29 +0200
Message-ID: <20080925171029.GQ10360@machine.or.cz>
References: <200809251230.11342.jnareb@gmail.com> <B3B6996F-EC51-49DC-8ECE-DBA25E8F61DE@wincent.com> <20080925133320.GK10360@machine.or.cz> <200809251852.23315.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 19:12:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiuNS-0005Ch-2Z
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 19:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbYIYRKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 13:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbYIYRKc
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 13:10:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44368 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150AbYIYRKb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 13:10:31 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 58F9A3939B43; Thu, 25 Sep 2008 19:10:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809251852.23315.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96784>

On Thu, Sep 25, 2008 at 06:52:22PM +0200, Jakub Narebski wrote:
> I think that making gitweb use something like Gitweb::Template, where
> action appearance is governed by templates, be it something like
> git-for-each-ref --format or StGit *.tmpl files, or XSLT / XSL,
> could be a good idea.  But I think _that_ would require almost writing
> from scratch, certainly making it long-term gitweb fork, perhaps even
> with different name (and not residing inside git.git repository).
> 
> We can discuss this idea here in this subthread.  For example: do
> create Gitweb::Template like HTML::Template or use Template Toolkit;
> which parts put in template and which in "gitweb" driver, etc.

Actually, my implementation works quite differently - the idea of the
templates is that you just specify data from which files to show and
whether to take them right away or tabulate them in some way - so it is
something very abstract, and agnostic to _presentation_ layer, which is
still provided by gitweb. An example of made-up template configuration
file would look something like:

[action "summary"]
	sections = metadata overview README shortlog forks

[section "overview"]
	type = csv
	row = Project Title,(info.txt:title)
	row = Project Authors,(info.txt:authors)
	row = Bussiness Impact,(info.txt:bizimpact)
	row = Base Equation,[formula.png]

[section "README"]
	type = html
	content = (README.html)

(where info.txt is another gitconfig-ish file in tree root, one that
the user actually touches).

When I post the patch, I will probably apply it to repo.or.cz too so
that I can show-case this in practice.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
