From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Sun, 9 May 2010 20:18:52 +0200
Message-ID: <201005092018.54580.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005091439.26310.jnareb@gmail.com> <20100509164723.GA4638@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 09 20:19:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBB62-00045O-3E
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 20:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab0EISTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 14:19:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59135 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab0EISTK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 14:19:10 -0400
Received: by fxm10 with SMTP id 10so1817512fxm.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QNSSZ23/rWkbkYDZupEL2JqBzJCL/afWJ1gTx+EiE6g=;
        b=WKAF00qhyezVHmPVzJx5vK8oyh3krf++VtReRNKQR0h5qRVAMo6TR533+CERVJaJFy
         jl67dmwiFOTCS6KgVegMTrgZ3uNoNQJEjV61d36JFYWJcC0nEB0j6sqQ29/yc9lnrMrZ
         tSSQYbOG/rSAz5eOXKa4VDTHT5DjlHvxSOOHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QSf67FExzmozwEC8MGBmPJWrmY31YjIm9/IRBzqSK4SKoC8zBKsOMEIRVExOzvqSfX
         ObJ37Unry1TwKAGCoMftRQvjC/TNWkOHLpMgG9W5tQhZM5TqfEbuKeZzg9+brb66nuz6
         gw+CZeEY/3hck8xu9xVB9MUivaNIuNzjZaI4I=
Received: by 10.102.222.5 with SMTP id u5mr1607579mug.134.1273429145170;
        Sun, 09 May 2010 11:19:05 -0700 (PDT)
Received: from [192.168.1.13] (abwi51.neoplus.adsl.tpnet.pl [83.8.232.51])
        by mx.google.com with ESMTPS id s10sm16890146muh.35.2010.05.09.11.19.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 11:19:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100509164723.GA4638@screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146735>

On Sun, 9 May 2010, Peter Vereshagin wrote:
> I'm face to face with Jakub who sold the world?
> 2010/05/09 14:39:23 +0200 Jakub Narebski <jnareb@gmail.com> => To Eric Wong :
> 
> JN> Yes, it can.  CGI::Compile is used for example by CGI::Emulate::PSGI,
> JN> and you can run PSGI app on standalone Perl web server (pure Perl
> JN> HTTP::Server::PSGI, or HTTP::Server::Simple::PSGI which in turn uses
> JN> HTTP::Server::Simple, or Starman, or Twiggy, or Perlbal).  CGI::Compile
> JN> just compiles given CGI script into a subroutine, which can be called
> JN> many times in a persistent web environment like FastCGI.
> 
> Thanks a lot about that!
>
> I took a quick look at the patches and see this:
> - FastCGI people are not always happy with CGI.pm and thus with CGI::Fast that
>   derives from it. They prefer CGI::Simple, e. g. for the Catalyst on fastcgi
>   and other CGI.pm replacements.

CGI::Simple is not in core.  For Catalyst folks it is not a problem, 
because Catalyst (one of Perl MVC web frameworks) is not in core either.

>   Despite the CGI::Fast is somehow the part of the perl core distribution
>   the FCGI.pm and CGI.pm which are the required dependencies are not.

Actually both CGI and CGI::Fast are in Perl core distribution since 
perl 5.004 (Perl 5.4.0).  I assume that CGI::Fast simply degrades to CGI
if FCGI module is not present.

FCGI is the single non-core dependency of CGI, see 
  http://deps.cpantesters.org/?module=CGI;perl=latest
so when I upgraded CGI (locally, using cpan client and local::lib), I also
installed FCGI.

>   Needless to say that the CGI.pm is not at all (because 
>   it tries too much to be) a 'killer app'. I myself is about to stop using
>   CGI::Fast in FCGI::Spawn in favor of regular FCGI.pm and the CGI.pm variant
>   chosen by the user. Needless to say that this can make the CGI.pm patching for
>   FCGI::Spawn unecessary.

That's nice.

What are required changes to gitweb to use FCGI::Spawn to run gitweb as
a FastCGI script?  Alternatively, how the wrapper script for gitweb 
(gitweb.fcgi) to be run as FastCGI should look like to use FCGI::Spawn?

> - FCGI::ProcManager is a piece of cake in any way, but there are 'more than one
>   way to do it' (c) and it should be mentioned on a docs as a dependency since
>   there are modules on CPAN too for the same purpose but promiseful of features
>   like OO/etc.

As PATCH 2/2 was straighforward port of Sam Vilain patch, I don't even
know what exactly the part containing FCGI::ProcManager does.

Note however that FCGI::ProcManager is require'd on demand; you have to
run gitweb with '--nproc=<n>'.  Also if FCGI::ProcManager is not found,
then the '--nproc=<n>' command line option is a no-op (does nothing).

>
> The special thank for getting rid of exit()!

You are welcome.

> 
> I'd like to propose the Git to have the Perl interface for common functions
> that can make it easy to create the bunch of tools like those made with
> (likely XS'ed) SVN::* namespace, e. g. git-svn.

>From what I remember from watching questions and discussion here on git
mailing list, the SVN::* Subversion bindings (from subversion-perl package)
are serious PITA.

Git.pm started (by Petr Baudis) with XS parts, but because of lack of
Perl hacker their compilation was unportable (IIRC it required support
for -fPIC), and was therefore abandoned.  The difficulty of creating
Git::XS is exacerbated by the fact that there is no libgit to make
Perl bindings againts, although hopefully GSoC 2010 project "Completing
libgit2" would help.


Git.pm currently wraps git commands in a *portable* way; that was the
reason behind creating it, to e.g. not have to write the same workarounds
for ActiveState Perl.  The other reason was to have safe way of invoking
git commands.  There are some utility functions there, but not much.

The "Gitweb caching" GSoC 2008 project[1] by Lea Wiemann included 
improvements to git Perl interface in the form of Git::Repo, Git::RepoRoot,
Git::Object, Git::Commit and Git::Tag.  They are available in Lea's
repository[2], but were not merged into git core.

[1]: http://git.wiki.kernel.org/index.php/SoC2008Projects#Gitweb_caching
[2]: http://repo.or.cz/w/git/gitweb-caching.git

>
> It makes me wonder why gitweb is packaged with Git but no Perl API seen:

If you ask why gitweb does not use Git.pm, the reason is twofold.

First, gitweb predates Git.pm.  It also used safe form of invokeing git
commands (list form of magic "-|" pipeline open) at least since b918298
(gitweb: Use list for of open for running git commands..., 2006-07-30),
and was intended to run on POSIX (like e.g. "/" as path separator) and
therefore ActiveState Perl workarounds were not needed.

Second, in a few places gitweb needs either to pipe output of git command
to other command (to compressor in snapshot, and newly introduced to 
highlighter when syntax highlighting is turned on), or silence errors
redirecting STDERR to /dev/null (in 'object' action to check if object
exists).  This is not yet supported in Git.pm.

Note that using IPC::Run for piping git command output to other command
would be counter to gitweb's goal of minimal non-core dependencies.

> looks like its storage is simple enough 
> to realize all of that in PP. Don't just disappoint me saying that git is used
> to be exec()'uted on some of the gitweb calls. ;)

Gitalist[3], which started as port of gitweb to Catalyst web framework,
uses Git::PurePerl, a pure Perl interface to Git repositories (which
was mostly based on Grit, a git Ruby library, which includes a partial
native Ruby implementation).  Or used to use; there was some discussion
whether to use Git::PurePerl or wrap git commands.

Note that Gitalist was based on IIRC 2008 version of gitweb, so while
it includes features that gitweb doesn't have, the opposite also might
be true (features in gitweb that Gitalist doesn't have).

Also performance matters for gitweb.

[3]: https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Gitalist
-- 
Jakub Narebski
Poland
