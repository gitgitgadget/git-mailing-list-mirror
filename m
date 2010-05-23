From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCHv3] git-instaweb: Add support for running gitweb via
	'plackup'
Date: Sun, 23 May 2010 09:19:08 +0000
Message-ID: <20100523091812.GA3426@dcvr.yhbt.net>
References: <1274356584-2400-1-git-send-email-jnareb@gmail.com> <1274392538-29687-1-git-send-email-jnareb@gmail.com> <201005222330.43532.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 11:19:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7Kw-0004zH-1w
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab0EWJTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 05:19:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39530 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855Ab0EWJTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:19:03 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B9F1F4EF;
	Sun, 23 May 2010 09:19:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <201005222330.43532.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147562>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 20 May 2010, Jakub Narebski wrote:
> 
> > The configuration for 'plackup' is currently embedded in generated
> > gitweb.psgi wrapper, instead of using httpd.conf ($conf).
> 
> A question: is this solution acceptable?  Or should the configuration
> (port, address if git-instaweb was run with '--local', root) be in
> a separate file.

Hi Jakub,

Yes, the psgi wrapper is acceptable and probably ideal.

My understanding is that the .psgi file is analogous to a .ru file in
the (Ruby) Rack world[1], and having only a .ru file is probably how I
would add Rack support to git-instaweb if WEBrick weren't in Ruby
core[2].

> Webrick, which is in similar situation, uses httpd.conf config file in 
> YAML.  Unfortunately there is no config / serialization reader in Perl
> core, so if we have to go this route either the config file would have
> to be in Perl, or gitweb.psgi wrapper would have to include some simple
> config file parsing.

I don't think we need parsing in the gitweb.psgi wrapper, we'll just
consider gitweb.psgi the config file.  This is also the case for
Rack .ru files, which can be made executable and have a shebang
pointing to "rackup".


[1] - I'm not familiar with Plack/PSGI at all, but I've been dabbling
      quite a bit in Rack over the past year or two.

[2] - of course since WEBrick is in Ruby core and WEBrick supports CGI
      scripts out-of-the-box (unlike Rack), adding Rack support to
      instaweb would be a waste of time.

-- 
Eric Wong
