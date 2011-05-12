From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
Date: Thu, 12 May 2011 20:08:51 +0200
Message-ID: <201105122008.53322.jnareb@gmail.com>
References: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu May 12 20:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKaJq-0003Z7-7v
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 20:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351Ab1ELSI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 14:08:56 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39462 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156Ab1ELSIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 14:08:55 -0400
Received: by wwa36 with SMTP id 36so2045730wwa.1
        for <git@vger.kernel.org>; Thu, 12 May 2011 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=WBboTP4Sk/ZqTLmuTIH1dkKRFMnM9/Y6bii/1782knw=;
        b=uFeFtLKXF7ojzTQNAO7JfJXIg5hzYu2XSjkAzEsN2EwfFLcu5RG0vYGycGRZu8AWNC
         6p7sshkik+1ZDkb7kIvrvUYxQ1uJf5Tad1XNj+L2CHLnrqsF9AtwiEf3hSojAESWTNE2
         /Q4eGwiFEmH0+RrM4D1dFjIwRsHduv3KqAoiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=X3dvrDMyDaWx03rAoAPRUwHawzCqLraDPTZ79lnEw11q9Ia2T3a8HGQjMB+7UG1hIk
         dGrVv7IXwiybmWes0avvckSvzZqXIXTbJK5i96wB244UOCy4btjuWVn0+8XmLzsD++rY
         69kd/qBP6UcrfoydZyBtOx185q578F7yGNf4g=
Received: by 10.216.135.67 with SMTP id t45mr494255wei.80.1305223734107;
        Thu, 12 May 2011 11:08:54 -0700 (PDT)
Received: from [192.168.1.13] (abvl88.neoplus.adsl.tpnet.pl [83.8.209.88])
        by mx.google.com with ESMTPS id h39sm747379wes.5.2011.05.12.11.08.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 May 2011 11:08:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173489>

On Wed, 11 May 2011, Drew Northup wrote:

> This is a work in progress. Much of what is in it has been pulled
> directly from the README and INSTALL files of gitweb. No effort has yet
> been made to de-duplicate any of this.
> 
> TODO:

I would add here:

    * Move most of gitweb's README and INSTALL into gitweb.txt and
      gitweb.conf.txt, so that their documentation can be easily viewed.

>   * Clean up README and INSTALL files

This is connected to added point.

>   * Add Makefile rules to build man / HTML pages.

Note that if we decode to go Documentation/gitweb{,.conf}.txt route, i.e.
putting docs in Documentation, this point would change to the following:

    * Include gitweb's docs in 'gitweb' package (git.spec.in).

diff --git i/git.spec.in w/git.spec.in
index 91c8462..06b27eb 100644
--- i/git.spec.in
+++ w/git.spec.in
@@ -200,6 +200,9 @@ rm -rf $RPM_BUILD_ROOT
 %files -n gitweb
 %defattr(-,root,root)
 %{_datadir}/gitweb
+%{!?_without_docs: %{_mandir}/man1/*gitweb*.1*}
+%{!?_without_docs: %{_mandir}/man5/*gitweb*.5*}
+%{!?_without_docs: %doc Documentation/*gitweb*.html }
 
 %files -n perl-Git -f perl-files
 %defattr(-,root,root)


[...]
> If you don't really need (or want) to be on the CC list let me know. You were
> in the output of 'git blame'....

I have culled CC list a bit, please notify if you want to be 
excluded/included.

[Skipping issues mentioned in other subthread]
 
> +DISCUSSION
> +----------
> +
> +The location of `gitweb.conf` is defined at compile time using the
> +configuration value `GITWEB_CONFIG_SYSTEM` and defaults to /etc/gitweb.conf.
> +The name of the per-instance configuration file is defined in gitweb by
> +`GITWEB_CONFIG`.

                 ...and defaults to gitweb_conf.perl.

> +
> +*NOTE:* Values defined in the per-instance configuration file override both
> +values found in the gitweb CGI as well as values found in the system-wide
> +gitweb.conf file.

Actually if there is per-instance configuration file, it is used, and only
otherwise system-wide configuration file is sourced.  But probably that
should be changed:

diff --git i/gitweb/gitweb.perl w/gitweb/gitweb.perl
index acdc5b8..9527cd2 100755
--- i/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -637,12 +637,13 @@ sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 	# die if there are errors parsing config file
+	if (-e $GITWEB_CONFIG_SYSTEM) {
+		do $GITWEB_CONFIG_SYSTEM;
+		die $@ if $@;
+	}
 	if (-e $GITWEB_CONFIG) {
 		do $GITWEB_CONFIG;
 		die $@ if $@;
-	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
-		do $GITWEB_CONFIG_SYSTEM;
-		die $@ if $@;
 	}
 }
 

Note: if we change it, we should mention priority of config sources, like
e.g. in ssh_conf(5).

Values in config file override default values found in gitweb sources.

> +
> +The syntax of the configuration files is that of PERL, as these files are
> +indeed handled as fragments of PERL code (the language that gitweb itself is
> +written in). Variables may be set using "'our $variable = value'"; text from
> +"#" character until the end of a line is ignored.

I think it would be nice to have an example here, something like:

-----
our $site_name = 'My Gitweb'; # or 'localhost'
-----

>                                                    See the perlsyn(1) man page 
> +for more information.

Is this how other manpages should be referenced in AsciiDoc?


BTW. What is &#8211;, and could we write it using something more readable?

> +One good reason to take advantage of the system-wide and local gitweb
> +configuration files is that not all settings may be set up directly in the CGI
> +itself. Optional features &#8211; defined using the '%features' variable
> +&#8211; must be set in one of the two configuration files.
> +
> +CONFIGURATION SETTINGS
> +----------------------
> +Standard Options
> +~~~~~~~~~~~~~~~~~
> +The following are not typically set or overridden at build time:

Hmmm... There are four kinds of configuration variables:

1. Variables with default values set during build time

   1.a. Those that usually do not need to be overridden, even if you are
        using packaged gitweb, and do not compile it yourself, like
        e.g. $GIT or $gitweb_js.

   1.b. Those that usually need to be overridden when we cannot control
        build-time configuration, e.g. using gitweb package, like e.g.
        $projectroot.

        If we build gitweb from sources, we can use config.mak or
        gitweb/config.mak to save build time configuration.


2. Variables which cannot be configured during build time

   2.a. Those that gitweb sets automatically, and usually do not need to
        be changed, like e.g. $base_url.

   2.b. Those that need to be set in config file to make use of feature.
        This includes whole %feature-based configuration.


Here there is a table:

  Variable            | type  | build value
  ======================================================================
  $GIT                | 1.a   | "$(bindir)/git"   e.g. "/usr/bin/git"
  $version            | 1.a   | "$(GIT_VERSION)"  e.g. "1.7.5"
  $projectroot        | 1.b !!| "/pub/git"
  $projects_list      | 1.[ab]| "", which means $projectroot
  $my_url, $my_uri    | 2.a   |
  $base_url           | 2.a   |
  $home_link          | 2.a   |
  @stylesheets        | 1.a   | "static/gitweb.css"
  $logo_url           | 2.a ? | "http://git-scm.com/"
  $logo_label         | 2.a ? | "git homepage"
  $projects_list_description_width
                      | 2.b   | 25
  @git_base_url_list  | 1.b   | "", which means no git base url
  $default_blob_plain_mimetype
                      | 2.a   | "text/plain"
  $default_text_plain_charset
                      | 2.b ? | undef
  $mimetypes_file     | 2.b   | undef
  $fallback_encoding  | 2.b   | "latin1"
  @diff_opts          | 2.b   | ('-M')
  $prevent_xss        | 2.b   | 0, which means false
  $maxload            | 2.b   | 300
  $highlight_bin      | 1.[ab]| "highlight"
  $per_request_config |2.b    | 1
  .........................................................................
  $project_maxdepth   | 1.a   | 2007
  $home_link_str      | 1.a ? | "projects"
  $site_name          |[12].a?| ($ENV{'SERVER_NAME'} || "Untitled") . " Git"
  $site_header, $site_footer     
                      | 1.b   | ""
  $home_text          | 1.b   | "indextext.html"
  $logo               | 1.a ? | "static/git-logo.png"
  $favicon            | 1.a ? | "static/git-favicon.png"
  $javascript         | 1.a!  | "static/gitweb.js"
  $default_projects_order
                      | 2.a   | "project"
  $export_ok          | 1.b   | "", which means feature is turned off
  $export_auth_hook   | 2.b   | undef, which means feature is turned off
  $strict_export      | 1.b   | "", which means feature is turned off

> +Configuration Options Often Set at Compile Time
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +These configuration variables are often specified at compile time and are
> +defined by default in the gitweb CGI itself:
> +
> +GIT_BINDIR::
> +	Points where to find the git executable.  You should set it up to
> +	the place where the git binary was installed (usually /usr/bin) if you
> +	don't install git from sources together with gitweb.  [Default: $(bindir)]
[...]

I think this should be left in gitweb/INSTALL, as those are important
_only_ during building gitweb.

> +Configuration File Example
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +To enable blame, pickaxe search, and snapshot support, while allowing
> +individual projects to turn them off, put the following in your
> +GITWEB_CONFIG file:
> +
> +        $feature{'blame'}{'default'} = [1];
> +        $feature{'blame'}{'override'} = 1;

I think this example requires explaining upfront what does it mean to
allow feature override, i.e. about per-repository configuration.

-- 
Jakub Narebski
Poland
