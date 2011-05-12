From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
Date: Thu, 12 May 2011 17:01:25 +0200
Message-ID: <201105121701.26547.jnareb@gmail.com>
References: <1305141664.30104.11.camel@drew-northup.unet.maine.edu> <20110512105325.GA13490@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 17:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKXOS-0004eE-A9
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 17:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab1ELPBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 11:01:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34829 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab1ELPBa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 11:01:30 -0400
Received: by fxm17 with SMTP id 17so1146798fxm.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=vfzqiWpCNdEfM3Sd59xwlEb1zU7DRstBsvx4xbvB6nM=;
        b=w935HNt3aAVUU1xQbcdAs8NliCZ1SDh7EKQ7VChpsZoEsXNi3RNw7mzKVjWmBLJqxh
         yjyvtZ+ky+GQkLaG44c0dkBg7SYO/XjEjgj8UTlCixuu+mr+7SUaQ8ORaIDD2VYiBB0W
         GVUfiFsR7w7nEW+9AnvWt2jHf86CCIb5hLAp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=day9JpZfpn3OOaLJqZi1byqFqJWD6ty/b6VVt9Yr85g6Q7qqkln0juw9Fa1FWad9Nq
         hZAWtHbBQjeHfZn6eYoTnZNchLLjkouOJEt2C82u0M5MV2R8b9JxEJI7ERsU3AKFy0k4
         uyACv9OJ6DrpKcBfwTNBLlipOlHBsqlG/kV44=
Received: by 10.223.113.193 with SMTP id b1mr379423faq.47.1305212488475;
        Thu, 12 May 2011 08:01:28 -0700 (PDT)
Received: from [192.168.1.13] (abvl88.neoplus.adsl.tpnet.pl [83.8.209.88])
        by mx.google.com with ESMTPS id 18sm249899fan.1.2011.05.12.08.01.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 May 2011 08:01:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110512105325.GA13490@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173475>

On Thu, 12 May 2011, Jonathan Nieder wrote:
> Drew Northup wrote:
> 
> > This is a work in progress. Much of what is in it has been pulled
> > directly from the README and INSTALL files of gitweb. No effort has yet
> > been made to de-duplicate any of this.

While it might be a good idea to split main part of gitweb/README into
gitweb.conf.txt (documenting configuration), and perhaps also separate
gitweb.txt (main page for gitweb, like SVN::Web manpage), I don't think
that much of gitweb/INSTALL should be moved.

> > TODO:
> >   * Clean up README and INSTALL files
> >   * Add Makefile rules to build man / HTML pages.
> >   * Remove or rephrase redundant portions of original documentation
> >   * A lot more...
> 
> I agree with this TODO list. :)  It should be possible to reuse rules from
> Documentation/Makefile if you put this under Documentation/.  gitweb already
> keeps its tests under t/ for convenience; I think it's okay if it
> puts some documentation under Documentation/.

Note that git-gui and gitk both also keep their manpages in Documentation/
as Documentation/git-gui.txt and Documentation/gitk.txt

We can add "doc" target to gitweb/Makefile, which would delegate work to
../Documentation/Makefile, similarly to existing "test" target in
gitweb/Makefile.


> > --- /dev/null
> > +++ b/gitweb/gitweb.conf.txt
> > @@ -0,0 +1,294 @@
> > +gitweb.conf(5)
> > +==============
> > +
> > +NAME
> > +----
> > +gitweb.conf - Gitweb configuration file
> 
> It sounds like a tautology.  Maybe "configuration for git's web
> interface"?  Except that there is at least one other web interface for
> git (cgit).  Hm.

Let's take a look how it is done in other section 5 manpages documenting
configuration files:

  dhclient.conf(5):  dhclient.conf - DHCP client configuration file
  ldap.conf(5):      ldap.conf, .ldaprc - ldap configuration file
  yum.con(5):        yum.conf - Configuration file for yum(8).

So it is not much of tautology, I think.
 
> > +
> > +SYNOPSIS
> > +--------
> > +/etc/gitweb.conf

I'd say

    +SYNOPSIS
    +--------
    +gitweb_conf.perl
    +/etc/gitweb.conf

or

    +SYNOPSIS
    +--------
    +$GITWEBDIR/gitweb_conf.perl
    +/etc/gitweb.conf
 
> gitweb will also look for gitweb_config.perl along @INC, and
> the $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM envvars can override
> these paths.

I think that we don't need to describe envvars in synopsis, but we
should have per-gitweb configuration file (gitweb_conf.perl) in
"Synopsis" section.
 
> > +
> > +DESCRIPTION
> > +-----------
> > +'Gitweb' is a CGI application for viewing Git repositories over the web. The
> > +configuration file is used to override the default settings that were built
> > +into gitweb at the time Git itself was compiled.
> 
> Style nit: I'd launch into what gitweb.conf contains right away, like
> so:
> 
> 	The gitweb CGI script for viewing Git repositories over the
> 	web uses a perl script fragment as its configuration file.
> 	You can set variables using "our $variable = value"; text
> 	from a "#" character until the end of a line is ignored.
> 	See *perlsyn*(1) for details.
> 
> 	The configuration file is used to override the default
> 	settings that were built into gitweb at the time it was
> 	installed.

I agree with Jonathan here.
 
> > +While one could just alter
> > +the configuration settings in the gitweb CGI itself, those changes would be
> > +lost upon upgrade. Configuration settings my also be placed into a file in
> > +the same directory as the CGI script with the default name
> > +`gitweb_config.perl` &#8211; allowing one to have multiple gitweb instances
> > +with different configurations by the use of symlinks.
> 
> Good point; I hadn't thought about the multiple-configurations use case.

Right.

> > +DISCUSSION
> > +----------
> > +
> > +The location of `gitweb.conf` is defined at compile time using the
> > +configuration value `GITWEB_CONFIG_SYSTEM` and defaults to /etc/gitweb.conf.
> > +The name of the per-instance configuration file is defined in gitweb by
> > +`GITWEB_CONFIG`.
> > +
> > +*NOTE:* Values defined in the per-instance configuration file override both
> > +values found in the gitweb CGI as well as values found in the sytem-wide
> > +gitweb.conf file.
> 
> Doesn't gitweb_config.perl suppress the effect of gitweb.conf altogether?

Yes it does.

The sequence is as following:

1. Per-gitweb configuration file is given by envvar GITWEB_CONFIG; if it
   is not set, then by default gitweb_conf.perl is used (one can override
   the latter name via build-time configuration variable GITWEB_CONFIG).
   Note: relative path means relative to installed gitweb.cgi script.

2. System-wide configuration file is given by envvar GITWEB_CONFIG_SYSTEM;
   if it is not set, then by default /etc/gitweb.conf is used (one can
   override the latter name via build-time configuration variable
   GITWEB_CONFIG_SYSTEM).  Note: sysconfdir is not taken into account
   by gitweb/Makefile, but perhaps it should.
 
Gitweb obtains configuration data from the following sources in the
following order:

  1. gitweb's installation configuration file ($GITWEBDIR/gitweb_conf.perl)
  2. system-wide configuration file (/etc/gitweb.conf)

First existing config file is used.


Sidenote: we could replace GITWE_CONFIG and GITWEB_CONFIG_SYSTEM in 
gitweb.conf.txt during building documentation.

> > +
> > +The syntax of the configuration files is that of PERL, as these files are
> > +indeed handled as fragments of PERL code (the language that gitweb itself is
> > +written in). Variables may be set using "'our $variable = value'"; text from
> > +"#" character until the end of a line is ignored. See the perlsyn(1) man page
> > +for more information.

Actually using 'our $variable = <value>' is a safety check: if newer gitweb
does no longer use given value, using 'our' wouldn't cause errors.
 
> The perl manual spells the name of that language as "Perl".  I think
> it might make sense to mention the syntax earlier, since it makes it
> less daunting to dive into the file right away.

I think it might be good idea to provide bare-bones example here.
 
> > +
> > +One good reason to take advatage of the system-wide and local gitweb
> > +configuration files is that not all settings may be set up directly in the CGI
> > +itself. Optional features &#8211; defined using the '%features' variable
> > +&#8211; must be set in one of the two configuration files.
> 
> I don't follow what this paragraph is saying.  Is the idea something
> like this?
> 
> 	The default configuration with no configuration file at all
> 	may work perfectly well for some installations.  Still, a
> 	configuration file is useful for customizing or tweaking the
> 	behavior of gitweb in many ways, and some optional features
> 	will not be present unless explicitly enabled using the
> 	configurable %features variable.

I think the idea is that not all of configuration knobs can be tweaked
during "compile"-time.  Some require setting from configuration file.

Note: we probably want to mention gitweb/config.mak or config.mak somewhere
as place to save build-time configuration, persistently.

> > +
> > +CONFIGURATION SETTINGS
> > +----------------------
> 
> Configuration settings as opposed to non-configuration settings? :)
> 
> Maybe something like
> 
> 	VARIABLES
> 	---------
> 
> would be clearer.

Perhaps.
 
> > +Standard Options
> > +~~~~~~~~~~~~~~~~~
> > +The following are not typically set or overridden at build time:
[...]
> > +
> > +$GIT::
> > +	Core git executable to use.
> 
> Ah, what a variable to start with.  Maybe this can be snuck later in
> the list somehow, so the reader can get to juicier bits first.

This is set at build time, by default to $(bindir)/git

> > +$version::
> > +	Gitweb version, set automatically when creating gitweb.cgi from
> > +	gitweb.perl. You might want to modify it if you are running modified
> > +	gitweb.
> 
> Why would I want to set this in the config file?  Wouldn't my patch to
> gitweb.cgi modify $version?

Well, for running gitweb.perl (not build!) from command line I use

  our $version = "current";

But this is I think rare case.
 
> > +$projectroot::
> > +	Absolute filesystem path which will be prepended to project path;
> > +	the path to repository is `$projectroot/$project`.  Set to
> > +	`$GITWEB_PROJECTROOT` during installation.  This variable has to be
> > +	set correctly for gitweb to find repositories.
> 
> This is an interesting one.  The description is not so clear to me ---
> I guess the idea is that if $projectroot = "/srv/git" then
> 
>  http://path/to/gitweb/installation/?p=foo/bar.git
> 
> will map to /srv/git/foo/bar.git on the filesystem (and likewise for
> PATH_INFO based URLs)?

Yes.

> > +$projects_list::
> > +	Source of projects list, either directory to scan, or text file
> > +	with list of repositories (in the "`<URI-encoded repository path> SP
> > +	<URI-encoded repository owner>`" line format; actually there can be
> > +	any sequence of whitespace in place of space (SP)).  Set to
> > +	`$GITWEB_LIST` during installation.  If empty, `$projectroot` is used
> > +	to scan for repositories.
> 
> Maybe clearer to emphasize the kinds of values it takes first?  That
> is:
> 
> 	Space-separated list of paths to files listing projects or
> 	directories to be scanned for projects.  Project list files
> 	should list one project per line, with each line having the
> 	format "`<URI-encoded filesystem path to repository> SP
> 	<URI-encoded repository owner>`.  The default is determined
> 	by the GITWEB_LIST makefile variable at installation time.
> 	If this variable is empty, gitweb will fall back to scanning
> 	the `$projectroot` for repositories.

I think to not have long wall of text here, we should reference part
of documentation that explains how gitweb finds repositories, including
format of $projects_list file.
 
> [...]
> > +Configuration Options Often Set at Compile Time
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +These configuration variables are often specified at compile time and are
> > +defined by default in the gitweb CGI itself:
> > +
> > +GIT_BINDIR::
> > +	Points where to find the git executable.  You should set it up to
> > +	the place where the git binary was installed (usually /usr/bin) if you
> > +	don't install git from sources together with gitweb.  [Default: $(bindir)]
> 
> I don't think there is a GIT_BINDIR configuration variable, though
> there is a makefile variable with that name used to determine the
> default value of $GIT.
> 
> Likewise for the others.  I don't think they belong in the manpage.

I agree.  What is important during build time "only" should remain in
gitweb/INSTALL.

-- 
Jakub Narebski
Poland
