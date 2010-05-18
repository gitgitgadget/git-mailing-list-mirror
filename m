From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Tue, 18 May 2010 03:06:25 +0200
Message-ID: <201005180306.27279.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005151558.12191.jnareb@gmail.com> <20100516101528.GA5761@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Tue May 18 03:05:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEBEz-0004J9-3I
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 03:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab0ERBEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 21:04:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37960 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab0ERBEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 21:04:47 -0400
Received: by fxm10 with SMTP id 10so509566fxm.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pq78ehM2b+DtrFNvA05qHHuvglpmC/x3QlHRegL4jJ4=;
        b=dLqTwZC0hSsifLBlgthEykc90XMdEK6Y7utRKz7/00IHJInTiiFBq6rxKQKwMcBB6a
         bfkopPPyVzwvffZqXZTTtDoUHL8TtHkyycq/Km7PAidffCcRopS1V/ZBhg7LSU4yKJuN
         KTzNTEDsvUzu3CFjsAhklg8jYPWKkQnzYQoeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NWE5VSJjUfNvypHrAOOxXVFm/0nwmr8qatcvNKSk4Zl3Hxl/1VkjAn1DI/RwsgvN9R
         8xT4EpN+l8YtzMAAuAy74+R9oYlYcWyNClukFmOws+OeLGDwjyp0jempNfacuvvkNffU
         A3h6TNeU/c6Sj5havmjWyCR1XEj2MYQuSuSqw=
Received: by 10.102.174.30 with SMTP id w30mr4043398mue.57.1274144685699;
        Mon, 17 May 2010 18:04:45 -0700 (PDT)
Received: from [192.168.1.13] (abwi27.neoplus.adsl.tpnet.pl [83.8.232.27])
        by mx.google.com with ESMTPS id y6sm25807736mug.20.2010.05.17.18.04.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 May 2010 18:04:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100516101528.GA5761@screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147268>

On Sun, 16 May 2010, Peter Vereshagin wrote:
> 2010/05/15 15:58:11 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :

> ===
> > >       eval "use Image::Magick;";
> > >       if ($@){
> > > ===
> > > 
> > > are those lemmings wrong?
> > 
> > No they are not.
> 
> so that code is just right, and this:
> ===
> eval( 'use Module;' ); die $@ if $@;
> ===
> 
> is 'Wrong!'. And what is the difference?

Why use

  eval('use Module;'); die $@ if $@;

instead of simply

  use Module;

or, if it is inside conditional,

  require Module; import Module;

or perhaps

  use if ($enable_module) Module;

if you 'die', like default, anyway?
 
> > I don't know if it would be complete replacement for FCGI::Spawn, but from
> > your description of it, using Plack::App::CGIBin middleware (+ plackup +
> > Plack::Handler::FCGI wrapper) could be a valid alternative to it..
> 
> There are some more features those are on by default in FCGI::Spawn if they are
> to be replaced, not sure if I will find them inside that framework.

Note that with Plack::Middleware::Static you can serve static files, like
stylesheets and images, too.

See Plack::Handler::FCGI manpage for details on how to configure FastCGI
backend for a PSGI application.

> > P.S. About Girocco: instead of writing it as set of separate CGI scripts, it
> > could have been instead written as single app, loading its modules ('use
> > lib' would help).
> 
> ... and sharing them with gitweb, right. ;-)

Well, no.  I'd rather the Gitweb::Admin / Girocco to remain
separate... perhaps with gitweb / git as submodule.

-- 
Jakub Narebski
Poland
