From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Mon, 10 May 2010 01:05:48 +0200
Message-ID: <201005100105.49985.jnareb@gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Tatsuhiko Miyagawa <miyagawa@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 01:06:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBFZU-0005du-Nx
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 01:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab0EIXF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 19:05:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36708 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab0EIXF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 19:05:58 -0400
Received: by fxm10 with SMTP id 10so1917371fxm.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VXC3XlK5uQbX1og41nYOmaheB4kbNluK4FQod1+xDsw=;
        b=xUk7TvEaTvLNIwOXNCHsX6ULZKC/cbbXeMuNHZVoNQTtO6bnK6+xxEKLsaAnLXteJi
         Q0LZNOJqL68m7HdbHsJGy2+tTCsVbp//9UWxJ1holAAugL+BdYz8sYhvzeo5rmu377UZ
         n8m/4NadYHmSwrtXxO2Md4TqXQlGidXYkvjYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=REQDi6elRxaWHKbAtQUNoy15IjY+m8JwlHLCaZ3sivfj1ZdVWjn1fD9RPCGlMFiYPy
         nE0qao6f1FaeFI3SL6cVv3EI++uNUFnrholGEuTBym6lLH5b4UHvlUxG2Zv/M4uowQxk
         fpv7DW0CaCfoJDDXBrdO34ATUTDvDeBJDW7pc=
Received: by 10.223.144.84 with SMTP id y20mr3419158fau.78.1273446356465;
        Sun, 09 May 2010 16:05:56 -0700 (PDT)
Received: from [192.168.1.13] (abwi51.neoplus.adsl.tpnet.pl [83.8.232.51])
        by mx.google.com with ESMTPS id r25sm18509472fai.23.2010.05.09.16.05.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 16:05:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146753>

On Sun, 9 May 2010, Tatsuhiko Miyagawa wrote:

> I'm not subscribed to the git mailing list but:
> 
> http://www.spinics.net/lists/git/msg131014.html

You don't need to be subscribed to post to git mailing list.  I personally
read it with a news reader using GMane NNTP interface

  nntp://news.gmane.org/gmane.comp.version-control.git

but sending messages via email, to git@ver.kernel.org.  Usually people
reply both to original poster and to git mailing list, but just in case
you can mention that you are not subscribed, and to not forget to send
you a CC copy.


All CC re-added.

> 
> > Actually both CGI and CGI::Fast are in Perl core distribution since
> > perl 5.004 (Perl 5.4.0).  I assume that CGI::Fast simply degrades to CGI
> > if FCGI module is not present.
> 
> No, it just dies if FCGI is not installed

Ah, so that is why CGI distribution has FCGI as requirement!

  http://deps.cpantesters.org/?module=CGI;perl=latest

> (so CGI::Fast in core doesn't make any sense).

Yes, it doesn't.

Nevertheless gitweb would try to require CGI::Fast only when it is run
with '--fastcgi' / '--fcgi' / '-f' option.  It should probably check if
it can be require'd without errors, like it is done for FCGI::ProcManager
in
  [RFC/PATCHv2 2/2] gitweb: Add support for FastCGI, using CGI::Fast
  Message-Id: <201005080959.01800.jnareb@gmail.com>
  http://article.gmane.org/gmane.comp.version-control.git/146647

> 
> > JN> Yes, it can.  CGI::Compile is used for example by CGI::Emulate::PSGI,
> > JN> and you can run PSGI app on standalone Perl web server (pure Perl
> > JN> HTTP::Server::PSGI, or HTTP::Server::Simple::PSGI which in turn uses
> > JN> HTTP::Server::Simple, or Starman, or Twiggy, or Perlbal)
> 
> And FastCGI.
> 
> I don't understand why you implemented FastCGI interface *in addition
> to* PSGI/Plack interface.

I didn't implement support for PSGI/Plack, at least not in patch send in
"[PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script"
series.

Adding support for FastCGI to CGI application is as simple as using
CGI::Fast object in place of CGI, and wrapping running main subroutine
in a loop that processes requests, like described in CGI::Fast manpage.
Well, for gitweb it required a few more small changes, anyway...

Moving to PSGI, or adding possibility to run gitweb as PSGI script (like
the series adds *ability* to run gitweb as FastCGI script) by modifying
gitweb would not be that easy, even with help of CGI::PSGI.


CGI::Compile was referring to an alternate approach, where instead of
modifying gitweb to be able to run it as FastCGI script (you can run it
as CGI script and as ModPerl::Registry script from mod_perl) there was
added gitweb.fcgi wrapper:

JN> The alternate solution would be to add gitweb.fcgi wrapper, like e.g.:
JN> in the following patch by Eric Wong
JN> 
JN>  "[PATCH 1/2] gitweb: add a simple wrapper for FCGI support"
JN>  http://thread.gmane.org/gmane.comp.version-control.git/35920/focus=35921
JN>
JN> which was part of the "[0/2 PATCH] FastCGI and nginx support for gitweb"
JN> series.  (Note that the patch does 'do $gitweb_cgi;' without checking for
JN> errors, see the bottom of `perldoc -f do` documentation on how it should
JN> be done).

One can of course use this approach wrapping gitweb to be run on PSGI,
using CGI::Emulate::PSGI (via Plack::App::WrapCGI), which in turn uses
CGI::Compile.  The gitweb.fcgi wrapper could use CGI::Emulate::FCGI...
if it existed.

NB I use the following gitweb.psgi wrapper to run gitweb from "plackup"
for tests (after running "make gitweb", of course, and with appropriate
gitweb_config.perl, unversioned, in gitweb/ alongside gitweb.perl, the
gitweb.psgi wrapper, and generated gitweb.cgi):

-- 8< --
#!/usr/bin/env plackup

# gitweb - simple web interface to track changes in git repositories
#          PSGI wrapper (see http://plackperl.org)

use strict;
use warnings;

use Plack::Builder;
use Plack::App::WrapCGI;
use CGI::Emulate::PSGI 0.07; # minimum version required to work

use File::Spec;
# __DIR__ is taken from Dir::Self __DIR__ fragment
sub __DIR__ () {
	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
}

builder {
	enable 'Static',
		path => sub { m!\.(js|css|png)$! && s!^/gitweb/!! }, root => __DIR__."/";
	Plack::App::WrapCGI->new(script => __DIR__."/gitweb.cgi")->to_app;
}

__END__
-- >8 --

> 
> `plackup -s FCGI` makes your PSGI app a fastcgi handler using FCGI.pm,
> or `plackup -s Net::FastCGI` does the same but using Net::FastCGI,
> pure perl alternative.

It is a pity that Plack::App::WrapFCGI / FCGI::Emulate::PSGI does not
exist, so that gitweb.psgi wrapper would not require indirectly 
CGI::Compile.

> 
> Come over to #plack (irc://irc.perl.org/#plack) for more discussion.

Email not good?

-- 
Jakub Narebski
ShadeHawk on #git, jnareb on #plack
Poland
