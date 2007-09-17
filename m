From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] instaweb: support for Ruby's WEBrick server
Date: Mon, 17 Sep 2007 04:55:18 -0700
Message-ID: <20070917115518.GA26815@soma>
References: <618c07250709161935g333f0536q31b453bd58f2d75d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Dalessio <mike@csa.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 13:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXFCH-0001mw-3q
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 13:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbXIQLzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 07:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbXIQLzV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 07:55:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49829 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbXIQLzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 07:55:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 4B51F7DC029;
	Mon, 17 Sep 2007 04:55:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <618c07250709161935g333f0536q31b453bd58f2d75d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58427>

Mike Dalessio <mike@csa.net> wrote:
> running the webrick server with git requires Ruby and Ruby's YAML and
> Webrick libraries (both of which come standard with Ruby). nice for
> single-user standalone invocations.
> 
> the --httpd=webrick option generates a (short!) ruby script on the fly to
> read httpd.conf options and invoke the web server via library call. this
> script is placed in the .git/gitweb directory.

Nice.  I'm in favor of adding WEBrick since it's fairly commonly
installed on developer boxes and is more consistently available
if available at all.  Apache and lighttpd may not be compiled
with some modules we need.

I'm having trouble applying this patch, however.  It's
whitespace-mangled and using long lines doesn't help mailers much.

> Signed-off-by: Mike Dalessio <mike.dalessio@gmail.com>
> ---
>  Documentation/git-instaweb.txt |    3 ++-
>  git-instaweb.sh                |   29 ++++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> +webrick_conf () {
> +    # generate a standalone server script in $fqgitdir/gitweb.
> +        cat > "$fqgitdir/gitweb/$httpd" <<EOF
> +#! /usr/bin/ruby

Could we make the shebang dynamic? (capturing the output of `which ruby`
maybe, or just breaking down and using /usr/bin/env ruby).  The ruby
binary seems to appear all over the place on the filesystem from my
experience, especially with its popularity amongst OSX users.

-- 
Eric Wong
