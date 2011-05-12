From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
Date: Thu, 12 May 2011 05:53:25 -0500
Message-ID: <20110512105325.GA13490@elie>
References: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu May 12 12:53:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKTWW-0006YU-Jz
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 12:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248Ab1ELKxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 06:53:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57451 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab1ELKxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 06:53:34 -0400
Received: by iwn34 with SMTP id 34so1301467iwn.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 03:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3gQJi8LzfOHEoA+dE/VluofoBmXA9GPFf3WX/eJQEHk=;
        b=Huyhlfrp4Oc/LsagEBvt6nMlidybK4toJP0mHDYCyErtHQ/m7tqjD/pne6P2Bax8rv
         KaLk7wlKHV7vpgSlaIP46DMe2bCuusxmCndyuJf6xGO9mpaqgtJtsNI4qU3IWiv7F0ng
         CLUqtXT8scUofe5Cef6Y//T8GRnUeqvuSUA4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u/U5vaOWhn3BjS7LLrDJclm3Jel7crjTB9Fx8MBHw6NYYOTk/w40951g67zHSGolC5
         QfepOZVFg1Y8WWXA7Ujk01gSeNN+p7C/e9XOMekgZRqTk6QABo0YF3Dq+DdGYyfe89uh
         PFOb1jvtMQ1Ka2wl27BiuWdhpNlVq8Wm3vQcI=
Received: by 10.42.222.72 with SMTP id if8mr31415icb.390.1305197613651;
        Thu, 12 May 2011 03:53:33 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id d9sm470092ibb.53.2011.05.12.03.53.30
        (version=SSLv3 cipher=OTHER);
        Thu, 12 May 2011 03:53:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173456>

Hi Drew,

Drew Northup wrote:

> This is a work in progress. Much of what is in it has been pulled
> directly from the README and INSTALL files of gitweb. No effort has yet
> been made to de-duplicate any of this.

Thanks!

> TODO:
>   * Clean up README and INSTALL files
>   * Add Makefile rules to build man / HTML pages.
>   * Remove or rephrase redundant portions of original documentation
>   * A lot more...

I agree with this TODO list. :)  It should be possible to reuse rules from
Documentation/Makefile if you put this under Documentation/.  gitweb already
keeps its tests under t/ for convenience; I think it's okay if it
puts some documentation under Documentation/.

> If you don't really need (or want) to be on the CC list let me know. You were
> in the output of 'git blame'....

I've aggressively culled the cc list for my reply to avoid punishing
kind people who improved gitweb by swamping them with mail.

> --- /dev/null
> +++ b/gitweb/gitweb.conf.txt
> @@ -0,0 +1,294 @@
> +gitweb.conf(5)
> +==============
> +
> +NAME
> +----
> +gitweb.conf - Gitweb configuration file

It sounds like a tautology.  Maybe "configuration for git's web
interface"?  Except that there is at least one other web interface for
git (cgit).  Hm.

> +
> +SYNOPSIS
> +--------
> +/etc/gitweb.conf

gitweb will also look for gitweb_config.perl along @INC, and
the $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM envvars can override
these paths.

> +
> +DESCRIPTION
> +-----------
> +'Gitweb' is a CGI application for viewing Git repositories over the web. The
> +configuration file is used to override the default settings that were built
> +into gitweb at the time Git itself was compiled.

Style nit: I'd launch into what gitweb.conf contains right away, like
so:

	The gitweb CGI script for viewing Git repositories over the
	web uses a perl script fragment as its configuration file.
	You can set variables using "our $variable = value"; text
	from a "#" character until the end of a line is ignored.
	See *perlsyn*(1) for details.

	The configuration file is used to override the default
	settings that were built into gitweb at the time it was
	installed.

> While one could just alter
> +the configuration settings in the gitweb CGI itself, those changes would be
> +lost upon upgrade. Configuration settings my also be placed into a file in
> +the same directory as the CGI script with the default name
> +`gitweb_config.perl` &#8211; allowing one to have multiple gitweb instances
> +with different configurations by the use of symlinks.

Good point; I hadn't thought about the multiple-configurations use case.

> +DISCUSSION
> +----------
> +
> +The location of `gitweb.conf` is defined at compile time using the
> +configuration value `GITWEB_CONFIG_SYSTEM` and defaults to /etc/gitweb.conf.
> +The name of the per-instance configuration file is defined in gitweb by
> +`GITWEB_CONFIG`.
> +
> +*NOTE:* Values defined in the per-instance configuration file override both
> +values found in the gitweb CGI as well as values found in the sytem-wide
> +gitweb.conf file.

Doesn't gitweb_config.perl suppress the effect of gitweb.conf altogether?

> +
> +The syntax of the configuration files is that of PERL, as these files are
> +indeed handled as fragments of PERL code (the language that gitweb itself is
> +written in). Variables may be set using "'our $variable = value'"; text from
> +"#" character until the end of a line is ignored. See the perlsyn(1) man page
> +for more information.

The perl manual spells the name of that language as "Perl".  I think
it might make sense to mention the syntax earlier, since it makes it
less daunting to dive into the file right away.

> +
> +One good reason to take advatage of the system-wide and local gitweb
> +configuration files is that not all settings may be set up directly in the CGI
> +itself. Optional features &#8211; defined using the '%features' variable
> +&#8211; must be set in one of the two configuration files.

I don't follow what this paragraph is saying.  Is the idea something
like this?

	The default configuration with no configuration file at all
	may work perfectly well for some installations.  Still, a
	configuration file is useful for customizing or tweaking the
	behavior of gitweb in many ways, and some optional features
	will not be present unless explicitly enabled using the
	configurable %features variable.

> +
> +CONFIGURATION SETTINGS
> +----------------------

Configuration settings as opposed to non-configuration settings? :)

Maybe something like

	VARIABLES
	---------

would be clearer.

> +Standard Options
> +~~~~~~~~~~~~~~~~~
> +The following are not typically set or overridden at build time:

I suppose the above is a paraphrase of

 (with the exception of $projectroot and $projects_list this list does
 not include variables usually directly set during build):

but this shortened version just left me confused (why do I care
which variables people typically override at build time?).  The
original suggests that for build-time configuration I should look
elsewhere, which made it a little clearer to me.

> +
> +$GIT::
> +	Core git executable to use.

Ah, what a variable to start with.  Maybe this can be snuck later in
the list somehow, so the reader can get to juicier bits first.

> +$version::
> +	Gitweb version, set automatically when creating gitweb.cgi from
> +	gitweb.perl. You might want to modify it if you are running modified
> +	gitweb.

Why would I want to set this in the config file?  Wouldn't my patch to
gitweb.cgi modify $version?

> +$projectroot::
> +	Absolute filesystem path which will be prepended to project path;
> +	the path to repository is `$projectroot/$project`.  Set to
> +	`$GITWEB_PROJECTROOT` during installation.  This variable has to be
> +	set correctly for gitweb to find repositories.

This is an interesting one.  The description is not so clear to me ---
I guess the idea is that if $projectroot = "/srv/git" then

 http://path/to/gitweb/installation/?p=foo/bar.git

will map to /srv/git/foo/bar.git on the filesystem (and likewise for
PATH_INFO based URLs)?

> +$projects_list::
> +	Source of projects list, either directory to scan, or text file
> +	with list of repositories (in the "`<URI-encoded repository path> SP
> +	<URI-encoded repository owner>`" line format; actually there can be
> +	any sequence of whitespace in place of space (SP)).  Set to
> +	`$GITWEB_LIST` during installation.  If empty, `$projectroot` is used
> +	to scan for repositories.

Maybe clearer to emphasize the kinds of values it takes first?  That
is:

	Space-separated list of paths to files listing projects or
	directories to be scanned for projects.  Project list files
	should list one project per line, with each line having the
	format "`<URI-encoded filesystem path to repository> SP
	<URI-encoded repository owner>`.  The default is determined
	by the GITWEB_LIST makefile variable at installation time.
	If this variable is empty, gitweb will fall back to scanning
	the `$projectroot` for repositories.

[...]
> +Configuration Options Often Set at Compile Time
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +These configuration variables are often specified at compile time and are
> +defined by default in the gitweb CGI itself:
> +
> +GIT_BINDIR::
> +	Points where to find the git executable.  You should set it up to
> +	the place where the git binary was installed (usually /usr/bin) if you
> +	don't install git from sources together with gitweb.  [Default: $(bindir)]

I don't think there is a GIT_BINDIR configuration variable, though
there is a makefile variable with that name used to determine the
default value of $GIT.

Likewise for the others.  I don't think they belong in the manpage.

[...]
> +Configuration File Example
> +~~~~~~~~~~~~~~~~~~~~~~~~~~

Ah, glad you did this.  I would make "Example" or "Examples" a
separate top-level section so they are easier to find.

Ok, that's all for now.  Still, hope that helps.

Regards,
Jonathan
