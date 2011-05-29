From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv2 2/2] gitweb: Starting work on a man page for gitweb (WIP)
Date: Sun, 29 May 2011 21:50:26 +0200
Message-ID: <1306698626-32402-3-git-send-email-jnareb@gmail.com>
References: <1306698626-32402-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 21:51:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQm1M-0000K4-7t
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 21:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366Ab1E2TvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 15:51:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37985 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332Ab1E2TvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 15:51:21 -0400
Received: by wya21 with SMTP id 21so2241449wya.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ckuOfVUe46k7gvlQIAE2TEPbqDFzYYxmQziG3xMFWhY=;
        b=ii7o+4mGbaxDOehR1v3RT7Ps0XbCkV7gDFs4yPnIddZ/HkvpG5h0hdWSUx4/6P8635
         LCmwPMNzvHB7pDNL8TwJonfy4NtiHe0JQXQgR1NGi9n/r0cB6rsuX23572hZubjyOUi4
         JpAB5xq12zRBM0fd34F+PhsZWrptME9wt3haE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bAhi62JKciPWFpc65y+PoKLfmZjTYRcNAiniMXmVnHnJEzjVb5+93E1IPF+9/fH4KH
         +px9HQUoNrA31HrHpqqbu3S24imByf9obxkAtSclM8euFAwxtkMODoNFuHSjzzwezQbt
         vCjM5/v9WVQ994ypINYeRTW1qoUP4E3SONx4A=
Received: by 10.216.50.142 with SMTP id z14mr1816458web.37.1306698679516;
        Sun, 29 May 2011 12:51:19 -0700 (PDT)
Received: from localhost.localdomain (abvt40.neoplus.adsl.tpnet.pl [83.8.217.40])
        by mx.google.com with ESMTPS id d7sm2111077wek.21.2011.05.29.12.51.17
        (version=SSLv3 cipher=OTHER);
        Sun, 29 May 2011 12:51:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1306698626-32402-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174702>

Gitweb documentation currently consist of gitweb/README, gitweb/INSTALL
and comments in gitweb source code.  This is harder to find, use and
browse that manpages ("man gitweb" or "git help gitweb") and HTML
documentation ("git help --web gitweb").

The goal is to move documentation out of gitweb/README to gitweb.txt and
gitweb.conf.txt manpages, reducing its size 10x from around 500 to
around 50 lines (two pages), and move information not related drectly to
building and installing gitweb out of gitweb/INSTALL there.

To build gitweb documentation you can use

  make -C gitweb doc

or

  cd gitweb; make doc


This is a work in progress.  Much of what is in it has been pulled
directly from the README and INSTALL files of gitweb.  No effort has
yet been made to de-duplicate any of this, i.e. to remove contents
from gitweb/README and gitweb/INSTALL.  The AsciiDoc might (and
probably does) contain formatting errors.

Current version is almost direct translation of SVN::Web manpage, and
is missing much of information that finally are to be moved from
gitweb/README to here.

Inspired-by: Drew Northup <drew.northup@maine.edu>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/Makefile        |    2 +-
 Documentation/gitweb.conf.txt |    2 +-
 Documentation/gitweb.txt      |  334 +++++++++++++++++++++++++++++++++++++++++
 gitweb/Makefile               |    1 +
 4 files changed, 337 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/gitweb.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 74ed959..bf7d7ef 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,7 +1,7 @@
 MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
-	gitk.txt git.txt
+	gitk.txt gitweb.txt git.txt
 MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 	gitrepository-layout.txt gitweb.conf.txt
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 34f65fa..4d773ab 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -427,7 +427,7 @@ gitweb_config.perl::
 
 SEE ALSO
 --------
-linkgit:git-instaweb[1]
+linkgit:gitweb[1], linkgit:git-instaweb[1]
 
 'gitweb/README', 'gitweb/INSTALL'
 
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
new file mode 100644
index 0000000..3815ca4
--- /dev/null
+++ b/Documentation/gitweb.txt
@@ -0,0 +1,334 @@
+gitweb(1)
+=========
+
+NAME
+----
+gitweb - Git web interface (web frontend to Git repositories)
+
+SYNOPSIS
+--------
+To get started with gitweb, run linkgit:git-instaweb[1] from a git repository.
+This would configure and start your web server and run web browser pointing to
+gitweb page.
+
+See http://git.kernel.org/?p=git/git.git;a=tree;f=gitweb or
+http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/ for gitweb source code, browsed
+using gitweb.
+
+
+DESCRIPTION
+-----------
+Gitweb provides a web interface to git repositories.  It's features include:
+
+* Viewing multiple Git repositories with common root.
+* Browsing every revision of the repository.
+* Viewing the contents of files in the repository at any revision.
+* Viewing the revision log of branches, history of files and directories,
+  see what was changed when, by who.
+* Viewing the blame/annotation details of any file (if enabled).
+* Generating RSS and Atom feeds of commits, for any branch.
+  The feeds are auto-discoverable in modern web browsers.
+* Viewing everything that was changed in a revision, and step through
+  revisions one at a time, viewing the history of the repository.
+* Finding commits which commit messages matches given search term.
+
+CONFIGURATION
+-------------
+Various aspects of gitweb's behavior can be controlled through the configuration
+file `gitweb_conf.perl` or `/etc/gitweb.conf`.  See the linkgit:gitweb.conf[5]
+for details.
+
+Repositories
+~~~~~~~~~~~~
+Gitweb can show information from one or more Git repositories.  These
+repositories have to be all on local filesystem, and have to share common
+repository root, i.e. be all under a single parent repository.
+
+-----------------------------------------------------------------------
+our $projectroot = '/path/to/parent/directory';
+-----------------------------------------------------------------------
+
+The default value for $projectroot is '/pub/git'.  You can change it during
+building gitweb via GITWEB_PROJECTROOT build configuration variable.
+
+By default all git repositories under $projectroot are visible and available
+to gitweb.  The list of projects is generated by default by scanning the
+$projectroot directory for git repositories.  
+
+The name of repository in gitweb is path to it's $GIT_DIR (it's object database)
+relative to $projectroot.  Therefore the repository $repo can be found at
+"$projectroot/$repo".
+
+Projects list file format
+~~~~~~~~~~~~~~~~~~~~~~~~~
+Instead of having gitweb find repositories by scanning filesystem starting from
+$projectroot, you can provide a pre-generated list of [visible] projects by
+setting $projects_list to a plain text file with a list of projects (with some
+additional info).
+
+This file uses the following format:
+
+* One record (for project / repository) per line; does not support lines
+continuation (newline escaping).
+
+* Leading and trailing whitespace are ignored.
+
+* Whitespace separated fields; any run of whitespace can be used as field
+separator (rules for Perl's "`split(" ", $line)`").
+
+* Fields use modified URI encoding, defined in RFC 3986, section 2.1
+(Percent-Encoding), or rather "Query string encoding" (see
+link:http://en.wikipedia.org/wiki/Query_string#URL_encoding[]), the difference
+being that SP (" ") can be encoded as "{plus}" (and therefore "{plus}" has to be
+also percent-encoded).  Reserved characters are: "%" (used for encoding),
+"{plus}" (can be used to encode SPACE), all whitespace characters as defined in
+Perl, including SP, TAB and LF, (used to separate fields in a record).
+
+* Currently recognized fields are:
+<repository path>::
+	path to repository GIT_DIR, relative to $projectroot
+<repository owner>::
+	displayed as repository owner, preferably full name, or email,
+        or both
+
+You can generate the projects list index file using the project_index action
+(the 'TXT' link on projects list page) directly from gitweb.
+
+Example contents:
+-----------------------------------------------------------------------
+foo.git       Joe+R+Hacker+<joe@example.com>
+foo/bar.git   O+W+Ner+<owner@example.org>
+-----------------------------------------------------------------------
+
+
+By default this file controls only which projects are visible on projects list
+page (note that entries that do not point to correctly recognized git
+repositories won't be displayed by gitweb).  Even if project is not visible on
+projects list page, you can view it nevertheless by hand-crafting a gitweb URL.
+By setting $strict_export configuration variable (see linkgit:gitweb.conf[5]) to
+true value you can allow viewing only of repositories also shown on the overview
+page.
+
+
+ACTIONS, AND URLS
+-----------------
+Gitweb can use path_info (component) based URLs, or it can pass all necessary
+information via query parameters.  The typical gitweb URLs are broken down in to
+five components:
+
+-----------------------------------------------------------------------
+.../gitweb.cgi/<repo>/<action>/<revision>:/<path>?<arguments>
+-----------------------------------------------------------------------
+
+repo::
+	The repository the action will be performed on.
++
+	All actions except for those that list all available projects,
+	in whatever form, require this parameter.
+
+action::
+	The action that will be run.  Defaults to 'projects_list' if repo
+	is not set, and to 'summary' otherwise.
+
+revision::
+	Revision shown.  Defaults to HEAD.
+
+path::
+	The path within the <repository> that the action is performed on,
+	for those actions that require it.
+
+arguments::
+	Any arguments that control the behaviour of the action.
+
+Some actions require or allow to specify two revisions, and sometimes even two
+pathnames.  In most general form such path_info (component) based gitweb URL
+looks like this:
+
+-----------------------------------------------------------------------
+.../gitweb.cgi/<repo>/<action>/<revision_from>:/<path_from>..<revision_to>:/<path_to>?<arguments>
+-----------------------------------------------------------------------
+
+
+Each action is implemented as a subroutine, and must be present in %actions
+hash.  Some actions are disabled by default, and must be turned on via feature
+mechanism.  For example to enable 'blame' view add the following to gitweb
+configuration file:
+
+-----------------------------------------------------------------------
+$feature{'blame'}{'default'} = [1];
+-----------------------------------------------------------------------
+
+
+Actions:
+~~~~~~~~
+The standard actions are:
+
+project_list::
+	Lists the available Git repositories.  This is the default command if no
+	repository is specified in the URL.
+
+summary::
+	Displays summary about given repository.  This is the default command if
+	no action is specified in URL, and only repository is specified.
+
+heads::
+remotes::
+	Lists all local or all remote-tracking branches in given repository.
++
+	The latter is not available by default, unless configured.
+
+tags::
+	List all tags (lightweight and annotated) in given repository.
+
+blob::
+tree::
+	Shows the files and directories in a given repository path, at given
+	revision.  This is default command if no action is specified in the URL,
+	and path is given.
+
+blob_plain::
+	Returns the raw data for the file in given repository, at given path and
+	revision.  Links to this action are marked 'raw'.
+
+blobdiff::
+	Shows the difference between two revisions of the same file.
+
+blame::
+blame_incremental::
+	Shows the blame (also called annotation) information for a file. On a
+	per line basis it shows the revision in which that line was last changed
+	and the user that committed the change.  The incremental version (which
+	if configured is used automatically when JavaScript is enabled) uses
+	Ajax to incrementally add blame info to the contents of given file.
++
+	This action is disabled by default for performance reasons.
+
+commit::
+commitdiff::
+	Shows information about a specific commit in a repository.  The 'commit'
+	view shows information about commit in more detail, the 'commitdiff'
+	action shows changeset for given commit.
+
+patch:: 
+	Returns the commit in plain text mail format, suitable for applying with
+	linkgit:git-am[1].
+
+tag::
+	Display specific annotated tag (tag object).	
+
+log::
+shortlog::
+	Shows log information (commit message or just commit subject) for a
+	given branch (starting from given revision).
++
+	The 'shortlog' view is more compact; it shows one commit per line.
+
+history::
+	Shows history of the file or directory in a given repository path,
+	starting from given revision (defaults to HEAD, i.e. default branch).
++
+	This view is similar to 'shortlog' view.
+
+rss::
+atom::
+	Generates an RSS (or Atom) feed of changes to repository.
+
+
+WEB SERVERS
+-----------
+This section explains how to configure some common webservers to run gitweb. In
+all cases, `/path/to/gitweb` in the examples is the directory you ran installed
+gitweb in, and contains `gitweb_config.perl`.
+
+If you've configured a web server that isn't listed here for gitweb, please send
+in the instructions so they can be included in a future release.
+
+Apache as CGI
+~~~~~~~~~~~~~
+Apache must be configured to support CGI scripts in the directory in
+which gitweb is installed.  Let's assume that it is '/var/www/cgi-bin'
+directory.
+
+-----------------------------------------------------------------------
+ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
+
+<Directory "/var/www/cgi-bin">
+    Options Indexes FollowSymlinks ExecCGI
+    AllowOverride None
+    Order allow,deny
+    Allow from all
+</Directory>
+-----------------------------------------------------------------------
+
+With that configuration the full path to browse repositories would be:
+
+  http://server/cgi-bin/gitweb.cgi
+
+Apache with mod_perl, via ModPerl::Registry
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+You can use mod_perl with gitweb.  You must install Apache::Registry
+(for mod_perl 1.x) or ModPerl::Registry (for mod_perl 2.x) to enable
+this support.
+
+Assuming that gitweb is installed to '/var/www/perl', the following
+Apache configuration (for mod_perl 2.x) is suitable.
+
+-----------------------------------------------------------------------
+Alias /perl "/var/www/perl"
+
+<Directory "/var/www/perl">
+    SetHandler perl-script
+    PerlResponseHandler ModPerl::Registry
+    PerlOptions +ParseHeaders
+    Options Indexes FollowSymlinks +ExecCGI
+    AllowOverride None
+    Order allow,deny
+    Allow from all
+</Directory>
+-----------------------------------------------------------------------
+
+With that configuration the full path to browse repositories would be:
+
+  http://server/perl/gitweb.cgi
+
+Apache with FastCGI
+~~~~~~~~~~~~~~~~~~~
+Gitweb works with Apache and FastCGI.  First you need to rename, copy
+or symlink gitweb.cgi to gitweb.fcgi.  Let's assume that gitweb is
+installed in '/usr/share/gitweb' directory.  The following Apache
+configuration is suitable (UNTESTED!)
+
+-----------------------------------------------------------------------
+FastCgiServer /usr/share/gitweb/gitweb.cgi
+ScriptAlias /gitweb /usr/share/gitweb/gitweb.cgi
+
+Alias /gitweb/static /usr/share/gitweb/static
+<Directory /usr/share/gitweb/static>
+    SetHandler default-handler
+</Directory>
+-----------------------------------------------------------------------
+
+With that configuration the full path to browse repositories would be:
+
+  http://server/gitweb
+
+
+ADVANCED WEB SERVER SETUP
+-------------------------
+
+...
+
+BUGS
+----
+Please report any bugs or feature requests to git@vger.kernel.org,
+putting "gitweb" in the subject of email.
+
+SEE ALSO
+--------
+linkgit:gitweb.conf[5], linkgit:git-instaweb[1]
+
+'gitweb/README', 'gitweb/INSTALL'
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 582e1b0..240c10a 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -112,6 +112,7 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+GITWEB_MAN1_TXT = gitweb.txt
 GITWEB_MAN5_TXT = gitweb.conf.txt
 GITWEB_MAN_TXT = $(GITWEB_MAN1_TXT) $(GITWEB_MAN5_TXT) $(GITWEB_MAN7_TXT)
 GITWEB_MAN = $(patsubst %.txt,%.1,$(GITWEB_MAN1_TXT)) \
-- 
1.7.5
