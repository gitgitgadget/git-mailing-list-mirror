From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Update and improve gitweb/README file
Date: Mon,  3 Dec 2007 00:22:02 +0100
Message-ID: <1196637722-1471-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>,
	Alan Chandler <alan@chandlerfamily.org.uk>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 00:22:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyy8v-0001bG-8F
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 00:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbXLBXWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 18:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXLBXWN
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 18:22:13 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:58529 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbXLBXWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 18:22:11 -0500
Received: by mu-out-0910.google.com with SMTP id i10so201236mue
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 15:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=U4Z4VcHKCZ8/yACwSGF0nhnXr03cYMWcuIkMCRlimXA=;
        b=Jgx4Xc76deo77V0yyCMaNkDfa1XGLWque8ELTOiYoF6LFWNNE73YSgn0vviHdDRnIioKzMXvqKGAlIHlE5mWOARypZhX2fB31+DTqCJYjmG9tE5+vG/MC1XPfT0D3WZTt6ZQYaIQ5cDl2KlF60cMlsIA1z0wtLJqSCGzIEYKN0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=dom4ovadUeMQ6LPkId/dZTFmuAPpW5ZYYqOluzl+toGmlZcW46XQ4A75seTPxpDR11GaNrykIHwotmStMasxV3VDqazPskOtX/sj88W57bKSkdQPxpWYRbfJhAHMkp6rVzwal3NOw8k3SSIgJPC4SRvyRlXz/iscfq6LHkQp8/I=
Received: by 10.86.50.8 with SMTP id x8mr9961306fgx.1196637728757;
        Sun, 02 Dec 2007 15:22:08 -0800 (PST)
Received: from roke.D-201 ( [83.8.251.146])
        by mx.google.com with ESMTPS id l12sm5766869fgb.2007.12.02.15.22.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2007 15:22:07 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB2NM560001487;
	Mon, 3 Dec 2007 00:22:05 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB2NM3k2001486;
	Mon, 3 Dec 2007 00:22:03 +0100
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66835>

Update list of build configuration variables, add references
to gitweb/INSTALL, add description of runtime and per-repository
runtime configuration.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/README |  215 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 197 insertions(+), 18 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 7186ced..b28f59f 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -10,28 +10,96 @@ From the git version 1.4.0 gitweb is bundled with git.
 How to configure gitweb for your local system
 ---------------------------------------------
 
+See also "Build time configuration" section in INSTALL
+file for gitweb (in gitweb/INSTALL).
+
 You can specify the following configuration variables when building GIT:
+ * GIT_BINDIR
+   Points out where to find git executable.  You should set up it to
+   the place where git binary was installed (usually /usr/bin) if you
+   don't install git from sources together with gitweb.  [Default: $(bindir)]
  * GITWEB_SITENAME
-   Shown in the title of all generated pages, defaults to the servers name.
+   Shown in the title of all generated pages, defaults to the server name
+   (SERVER_NAME CGI environment variable) if not set. [No default]
  * GITWEB_PROJECTROOT
-   The root directory for all projects shown by gitweb.
+   The root directory for all projects shown by gitweb. Must be set
+   correctly for gitweb to find repositories to display.  See also
+   "Gitweb repositories" in INSTALL file for gitweb.  [Default: /pub/git]
+ * GITWEB_PROJECT_MAXDEPTH
+   The filesystem traversing limit for getting projects list; the number
+   is taken as depth relative to the projectroot.  It is used when
+   GITWEB_LIST is a directory (or is not set; then project root is used).
+   Is is meant to speed up project listing on large work trees by limiting
+   find depth.  [Default: 2007]
  * GITWEB_LIST
-   points to a directory to scan for projects (defaults to project root)
-   or to a file for explicit listing of projects.
+   Points to a directory to scan for projects (defaults to project root
+   if not set / if empty) or to a file with explicit listing of projects
+   (together with projects' ownership). See "Generating projects list
+   using gitweb" in INSTALL file for gitweb to find out how to generate
+   such file from scan of a directory. [No default, which means use root
+   directory for projects]
+ * GITWEB_EXPORT_OK
+   Show repository only if this file exists (in repository).  Only
+   effective if this variable evaluates to true.  [No default / Not set]
+ * GITWEB_STRICT_EXPORT
+   Only allow viewing of repositories also shown on the overview page.
+   This for example makes GITWEB_EXPORT_OK to decide if repository is
+   available and not only if it is shown.  If GITWEB_LIST points to
+   file with list of project, only those repositories listed would be
+   available for gitweb.  [No default]
  * GITWEB_HOMETEXT
-   points to an .html file which is included on the gitweb project
-   overview page.
+   Points to an .html file which is included on the gitweb project
+   overview page ('projects_list' view), if it exists.  Relative to
+   gitweb.cgi script.  [Default: indextext.html]
+ * GITWEB_SITE_HEADER
+   Filename of html text to include at top of each page.  Relative to
+   gitweb.cgi script.  [No default]
+ * GITWEB_SITE_FOOTER
+   Filename of html text to include at bottom of each page.  Relative to
+   gitweb.cgi script.  [No default]
+ * GITWEB_HOME_LINK_STR
+   String of the home link on top of all pages, leading to $home_link
+   (usually main gitweb page, which means projects list).  Used as first
+   part of gitweb view "breadcrumb trail": <home> / <project> / <view>.
+   [Default: projects]
+ * GITWEB_SITENAME
+   Name of your site or organization to appear in page titles.  Set it
+   to something descriptive for clearer bookmarks etc.  If not set
+   (if empty) gitweb uses "$SERVER_NAME Git", or "Untitled Git" if
+   SERVER_NAME CGI environment variable is not set (e.g. if running
+   gitweb as standalone script).  [No default]
+ * GITWEB_BASE_URL
+   Git base URLs used for URL to where fetch project from, i.e. full
+   URL is "$git_base_url/$project".  Shown on projects summary page.
+   Repository URL for project can be also configured per repository; this
+   takes precendence over URL composed from base URL and project name.
+   Note that you can setup multiple base URLs (for example one for
+   git:// protocol access, one for http:// access) from gitweb config
+   file.  [No default]
  * GITWEB_CSS
-   Points to the location where you put gitweb.css on your web server.
+   Points to the location where you put gitweb.css on your web server
+   (or to be more generic URI of gitweb stylesheet).  Relative to base
+   URI of gitweb.  Note that you can setup multiple stylesheets from
+   gitweb config file.  [Default: gitweb.css]
  * GITWEB_LOGO
-   Points to the location where you put git-logo.png on your web server.
+   Points to the location where you put git-logo.png on your web server
+   (or to be more generic URI of logo, 72x27 size, displayed in top right
+   corner of each gitweb page, and used as logo for Atom feed).  Relative
+   to base URI of gitweb.  [Default: git-logo.png]
+ * GITWEB_FAVICON
+   Points to the location where you put git-favicon.png on your web server
+   (or to be more generic URI of favicon, assumed to be image/png type;
+   web browsers that support favicons (website icons) may display them
+   in the browser's URL bar and next to site name in bookmarks).  Relative
+   to base URI of gitweb.  [Default: git-favicon.png]
  * GITWEB_CONFIG
-   This file will be loaded using 'require' and can be used to override any
-   of the options above as well as some other options - see the top of
-   'gitweb.cgi' for their full list and description.  If the environment
-   $GITWEB_CONFIG is set when gitweb.cgi is executed the file in the
-   environment variable will be loaded instead of the file
-   specified when gitweb.cgi was created.
+   This Perl file will be loaded using 'do' and can be used to override any
+   of the options above as well as some other options -- see the "Runtime
+   gitweb configuration" section below, and top of 'gitweb.cgi' for their
+   full list and description.  If the environment variable GITWEB_CONFIG
+   is set when gitweb.cgi is executed, then the file specified in the
+   environment variable will be loaded instead of the file specified
+   when gitweb.cgi was created.  [Default: gitweb_config.perl]
 
 
 Runtime gitweb configuration
@@ -39,11 +107,122 @@ Runtime gitweb configuration
 
 You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
 (defaults to 'gitweb_config.perl' in the same directory as the CGI).
-See the top of 'gitweb.cgi' for the list of variables and some description.
 The most notable thing that is not configurable at compile time are the
-optional features, stored in the '%features' variable. You can find further
-description on how to reconfigure the default features setting in your
-`GITWEB_CONFIG` or per-project in `project.git/config` inside 'gitweb.cgi'.
+optional features, stored in the '%features' variable.
+
+Ultimate description on how to reconfigure the default features setting
+in your `GITWEB_CONFIG` or per-project in `project.git/config` can be found
+as comments inside 'gitweb.cgi'.
+
+See also "Gitweb config file" (with example of gitweb config file), and
+"Gitweb repositories" sections in INSTALL file for gitweb.
+
+
+Gitweb config file is [fragment] of perl code. You can set variables
+using "our $variable = value"; text from "#" character until the end
+of a line is ignored. See perlsyn(1) man page for details.
+
+Below there is list of vaiables which you might want to set in gitweb config.
+See the top of 'gitweb.cgi' for the full list of variables and their
+descriptions.
+
+Gitweb config file variables
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can set, among others,  the following variables in gitweb config files:
+ * $GIT
+   Cure git executable to use.  By default set to "$GIT_BINDIR/git", which
+   in turn is by default set to "$(bindir)/git".  If you use git from binary
+   package, set this to "/usr/bin/git".  This can just be "git" if your
+   webserver has a sensible PATH.  If you have multiple git versions
+   installed it is / can be used to choose which one to use.
+ * $version
+   Gitweb version, set automatically when creating gitweb.cgi from
+   gitweb.perl. You might want to modify it if you are running modified
+   gitweb.
+ * $my_url, $my_uri
+   URL and absolute URL of gitweb script; you might need to set those
+   variables if you are using 'pathinfo' feature: see also below.
+ * $home_link
+   Target of the home link on top of all pages (the first part of view
+   "breadcrumbs").  By default set to absolute URI of a page; you might
+   need to set it up to [base] gitweb URI if you use 'pathinfo' feature
+   (alternative format of the URLs, with project name embedded directly
+   in the path part of URL).
+ * @stylesheets
+   List of URIs of stylesheets (relative to base URI of a page). You
+   might specify more than one stylesheet, for example use gitweb.css
+   as base, with site specific modifications in separate stylesheet
+   to make it easier to upgrade gitweb. You can add 'site' stylesheet
+   for example by using
+      push @stylesheets, "gitweb-site.css";
+   in gitweb config file.
+ * $logo_url, $logo_label
+   URI and label (title) of GIT logo link (or your site logo, if you choose
+   to use different logo image). By default they point to git homepage;
+   in the past they pointed to git documentation at www.kernel.org.
+ * $projects_list_description_width
+   The width (in characters) of the projects list "Description" column.
+   Longer descriptions will be cut (trying to cut at word boundary);
+   full description is available as 'title' attribute (usually shown on
+   mouseover).  By default set to 25, which might be too small if you
+   use long project descriptions.
+ * @git_base_url_list
+   List of git base URLs used for URL to where fetch project from, shown
+   in project summary page.  Full URL is "$git_base_url/$project".
+   You can setup multiple base URLs (for example one for  git:// protocol
+   access, and one for http:// "dumb" protocol access).  Note that per
+   repository configuration in 'cloneurl' file, or as values of gitweb.url
+   project config.
+ * $default_blob_plain_mimetype
+   Default mimetype for blob_plain (raw) view, if mimetype checking
+   doesn't result in some other type; by default 'text/plain'.
+ * $default_text_plain_charset
+   Default charset for text files. If not set, web serwer configuration
+   would be used.
+ * $mimetypes_file
+   File to use for (filename extension based) guessing of MIME types before
+   trying /etc/mime.types. Path, if relative, is taken currently as taken
+   relative to current git repositoy.
+ * $fallback_encoding
+   Gitweb assumes this charset if line contains non-UTF-8 characters.
+   Fallback decoding is used without error checking, so it can be even
+   'utf-8'. Value mist be valid encodig; see Encoding::Supported(3pm) man
+   page for a list.   By default 'latin1', aka. 'iso-8859-1'.
+ * @diff_opts
+   Rename detection options for git-diff and git-diff-tree. By default
+   ('-M'); set it to ('-C') or ('-C', '-C') to also detect copies, or
+   set it to () if you don't want to have renames detection.
+
+Per-repository gitweb configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can also configure individual repositories shown in gitweb by creating
+file in the GIT_DIR of git repository, or by setting some repo configuration
+variable (in GIT_DIR/config).
+
+You can use the following files in repository:
+ * README.html
+   A .html file (HTML fragment) which is included on the gitweb project
+   summary page inside <div> block element. You can use it for longer
+   description of a project, to provide links for example to projects
+   homepage, etc.
+ * description (or gitweb.description)
+   Short (shortened by default to 25 characters in the projects list page)
+   single line description of a project (of a repository). Plain text file;
+   HTML will be escaped. By default set to
+     Unnamed repository; edit this file to name it for gitweb.
+   from the template during creating repository. You can use
+   gitweb.description repo configuration variable, but the file takes
+   precendence.
+ * cloneurl (or multiple-valued gitweb.url)
+   File with repository URL (used for clone and fetch), one per line.
+   Displayed in the project summary page. You can use multiple-valued
+   gitweb.url repository configuration variable for that, but the file
+   takes precendence.
+ * various gitweb.* config variables (in config)
+   Read description of %feature hash for detailed list, and some
+   descriptions.
 
 
 Webserver configuration
-- 
1.5.3.6
