From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] Remove ciabot from contrib
Date: Thu, 26 Sep 2013 22:33:02 +0200
Message-ID: <1380227582-7836-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: esr@thyrsus.com, git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 26 22:33:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPIFN-0008D5-Hy
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 22:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553Ab3IZUdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 16:33:04 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:44267 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab3IZUdB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 16:33:01 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so805563eek.30
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dBekUGd4FaQGZBrkb/FAl664XHFs9WdHmbolcqLYV1U=;
        b=jSL8PWqzkN1HeviLCuK76L8TBSv+IslWIWWM6+WlPqbHO3ymU3LvoYpde79zXQiGuG
         dS1kflug360ges1qJ/tQ4DqkM2MpmW/LOdpwhooJS3wkoX0hDJQKcr68dJ6QWOsYL4Hl
         pNWSbTgtc1VRPHzwSobGXsza+153ro0eOi7WHXIAcQap6OmQ7Rtl1186zBpHm4BsHlou
         n4nfekbYZMF7oJ4cWLxq0oy5civ02rkVEKUAv5YKt+/mkrfIaFM6h8/Z394+Dub5Jy2E
         mFqLN+iJ76dFXNj1i0deSKPvB1HeoJE78djtlkyuWrYU2y8BRQlQYq7KgVIqEhE6o6D/
         BI6g==
X-Received: by 10.14.180.73 with SMTP id i49mr4128576eem.55.1380227579597;
        Thu, 26 Sep 2013 13:32:59 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id i1sm8045487eeg.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 13:32:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.474.g128a96c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235432>

According to
http://thread.gmane.org/gmane.comp.version-control.git/212649
Eric, the original author of ciabot, doesn't want the ciabot
no longer be included in git.git, hence the removal of the
whole directory.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---

I found out about this task by browsing 
http://git-blame.blogspot.de/search?q=leftover


 contrib/ciabot/INSTALL   |  54 ----------
 contrib/ciabot/README    |  11 --
 contrib/ciabot/ciabot.py | 255 -----------------------------------------------
 contrib/ciabot/ciabot.sh | 233 -------------------------------------------
 4 files changed, 553 deletions(-)
 delete mode 100644 contrib/ciabot/INSTALL
 delete mode 100644 contrib/ciabot/README
 delete mode 100755 contrib/ciabot/ciabot.py
 delete mode 100755 contrib/ciabot/ciabot.sh

diff --git a/contrib/ciabot/INSTALL b/contrib/ciabot/INSTALL
deleted file mode 100644
index 7222961..0000000
--- a/contrib/ciabot/INSTALL
+++ /dev/null
@@ -1,54 +0,0 @@
-= Installation instructions =
-
-Two scripts are included.  The Python one (ciabot.py) is faster and
-more capable; the shell one (ciabot.sh) is a fallback in case Python
-gives your git hosting site indigestion. (I know of no such sites.)
-
-It is no longer necessary to modify the script in order to put it
-in place; in fact, this is now discouraged. It is entirely
-configurable with the following git config variables:
-
-ciabot.project = name of the project
-ciabot.repo = name of the project repo for gitweb/cgit purposes
-ciabot.xmlrpc  = if true, ship notifications via XML-RPC
-ciabot.revformat = format in which the revision is shown
-
-The revformat variable may have the following values
-raw -> full hex ID of commit
-short -> first 12 chars of hex ID
-describe -> describe relative to last tag, falling back to short
-
-ciabot.project defaults to the directory name of the repository toplevel.
-ciabot.repo defaults to ciabot.project lowercased.
-ciabot.xmlrpc defaults to True
-ciabot.revformat defaults to 'describe'.
-
-This means that in the normal case you need not do any configuration at all,
-however setting ciabot.project will allow the hook to run slightly faster.
-
-Once you've set these variables, try your script with -n to see the
-notification message dumped to stdout and verify that it looks sane.
-
-To live-test these scripts, your project needs to have been registered with
-the CIA site.  Here are the steps:
-
-1. Open an IRC window on irc://freenode/commits or your registered
-   project IRC channel.
-
-2. Run ciabot.py and/or ciabot.sh from any directory under git
-   control.
-
-You should see a notification on the channel for your most recent commit.
-
-After verifying correct function, install one of these scripts either
-in a post-commit hook or in an update hook.
-
-In post-commit, run it without arguments. It will query for
-current HEAD and the latest commit ID to get the information it
-needs.
-
-In update, call it with a refname followed by a list of commits:
-You want to reverse the order git rev-list emits because it lists
-from most recent to oldest.
-
-/path/to/ciabot.py ${refname} $(git rev-list ${oldhead}..${newhead} | tac)
diff --git a/contrib/ciabot/README b/contrib/ciabot/README
deleted file mode 100644
index 2dfe1f9..0000000
--- a/contrib/ciabot/README
+++ /dev/null
@@ -1,11 +0,0 @@
-These are hook scripts for the CIA notification service at <http://cia.vc/>
-
-They are maintained by Eric S. Raymond <esr@thyrsus.com>.  There is an
-upstream resource page for them at <http://www.catb.org/esr/ciabot/>,
-but they are unlikely to change rapidly.
-
-You probably want the Python version; it's faster, more capable, and
-better documented.  The shell version is maintained only as a fallback
-for use on hosting sites that don't permit Python hook scripts.
-
-See the file INSTALL for installation instructions.
diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
deleted file mode 100755
index befa0c3..0000000
--- a/contrib/ciabot/ciabot.py
+++ /dev/null
@@ -1,255 +0,0 @@
-#!/usr/bin/env python
-# Copyright (c) 2010 Eric S. Raymond <esr@thyrsus.com>
-# Distributed under BSD terms.
-#
-# This script contains porcelain and porcelain byproducts.
-# It's Python because the Python standard libraries avoid portability/security
-# issues raised by callouts in the ancestral Perl and sh scripts.  It should
-# be compatible back to Python 2.1.5
-#
-# usage: ciabot.py [-V] [-n] [-p projectname]  [refname [commits...]]
-#
-# This script is meant to be run either in a post-commit hook or in an
-# update hook. Try it with -n to see the notification mail dumped to
-# stdout and verify that it looks sane. With -V it dumps its version
-# and exits.
-#
-# In post-commit, run it without arguments. It will query for
-# current HEAD and the latest commit ID to get the information it
-# needs.
-#
-# In update, call it with a refname followed by a list of commits:
-# You want to reverse the order git rev-list emits because it lists
-# from most recent to oldest.
-#
-# /path/to/ciabot.py ${refname} $(git rev-list ${oldhead}..${newhead} | tac)
-#
-# Configuration variables affecting this script:
-#
-# ciabot.project = name of the project
-# ciabot.repo = name of the project repo for gitweb/cgit purposes
-# ciabot.xmlrpc  = if true (default), ship notifications via XML-RPC
-# ciabot.revformat = format in which the revision is shown
-#
-# ciabot.project defaults to the directory name of the repository toplevel.
-# ciabot.repo defaults to ciabot.project lowercased.
-#
-# This means that in the normal case you need not do any configuration at all,
-# but setting the project name will speed it up slightly.
-#
-# The revformat variable may have the following values
-# raw -> full hex ID of commit
-# short -> first 12 chars of hex ID
-# describe = -> describe relative to last tag, falling back to short
-# The default is 'describe'.
-#
-# Note: the CIA project now says only XML-RPC is reliable, so
-# we default to that.
-#
-
-import sys
-if sys.hexversion < 0x02000000:
-        # The limiter is the xml.sax module
-        sys.stderr.write("ciabot.py: requires Python 2.0.0 or later.\n")
-        sys.exit(1)
-
-import os, commands, socket, urllib
-from xml.sax.saxutils import escape
-
-# Changeset URL prefix for your repo: when the commit ID is appended
-# to this, it should point at a CGI that will display the commit
-# through gitweb or something similar. The defaults will probably
-# work if you have a typical gitweb/cgit setup.
-#
-#urlprefix="http://%(host)s/cgi-bin/gitweb.cgi?p=%(repo)s;a=commit;h="
-urlprefix="http://%(host)s/cgi-bin/cgit.cgi/%(repo)s/commit/?id="
-
-# The service used to turn your gitwebbish URL into a tinyurl so it
-# will take up less space on the IRC notification line.
-tinyifier = "http://tinyurl.com/api-create.php?url="
-
-# The template used to generate the XML messages to CIA.  You can make
-# visible changes to the IRC-bot notification lines by hacking this.
-# The default will produce a notification line that looks like this:
-#
-# ${project}: ${author} ${repo}:${branch} * ${rev} ${files}: ${logmsg} ${url}
-#
-# By omitting $files you can collapse the files part to a single slash.
-xml = '''\
-<message>
-  <generator>
-    <name>CIA Python client for Git</name>
-    <version>%(version)s</version>
-    <url>%(generator)s</url>
-  </generator>
-  <source>
-    <project>%(project)s</project>
-    <branch>%(repo)s:%(branch)s</branch>
-  </source>
-  <timestamp>%(ts)s</timestamp>
-  <body>
-    <commit>
-      <author>%(author)s</author>
-      <revision>%(rev)s</revision>
-      <files>
-        %(files)s
-      </files>
-      <log>%(logmsg)s %(url)s</log>
-      <url>%(url)s</url>
-    </commit>
-  </body>
-</message>
-'''
-
-#
-# No user-serviceable parts below this line:
-#
-
-# Where to ship e-mail notifications.
-toaddr = "cia@cia.vc"
-
-# Identify the generator script.
-# Should only change when the script itself gets a new home and maintainer.
-generator = "http://www.catb.org/~esr/ciabot.py"
-version = "3.6"
-
-def do(command):
-    return commands.getstatusoutput(command)[1]
-
-def report(refname, merged, xmlrpc=True):
-    "Generate a commit notification to be reported to CIA"
-
-    # Try to tinyfy a reference to a web view for this commit.
-    try:
-        url = open(urllib.urlretrieve(tinyifier + urlprefix + merged)[0]).read()
-    except:
-        url = urlprefix + merged
-
-    branch = os.path.basename(refname)
-
-    # Compute a description for the revision
-    if revformat == 'raw':
-        rev = merged
-    elif revformat == 'short':
-        rev = ''
-    else: # revformat == 'describe'
-        rev = do("git describe %s 2>/dev/null" % merged)
-    if not rev:
-        rev = merged[:12]
-
-    # Extract the meta-information for the commit
-    files=do("git diff-tree -r --name-only '"+ merged +"' | sed -e '1d' -e 's-.*-<file>&</file>-'")
-    metainfo = do("git log -1 '--pretty=format:%an <%ae>%n%at%n%s' " + merged)
-    (author, ts, logmsg) = metainfo.split("\n")
-    logmsg = escape(logmsg)
-
-    # This discards the part of the author's address after @.
-    # Might be be nice to ship the full email address, if not
-    # for spammers' address harvesters - getting this wrong
-    # would make the freenode #commits channel into harvester heaven.
-    author = escape(author.replace("<", "").split("@")[0].split()[-1])
-
-    # This ignores the timezone.  Not clear what to do with it...
-    ts = ts.strip().split()[0]
-
-    context = locals()
-    context.update(globals())
-
-    out = xml % context
-    mail = '''\
-Message-ID: <%(merged)s.%(author)s@%(project)s>
-From: %(fromaddr)s
-To: %(toaddr)s
-Content-type: text/xml
-Subject: DeliverXML
-
-%(out)s''' % locals()
-
-    if xmlrpc:
-        return out
-    else:
-        return mail
-
-if __name__ == "__main__":
-    import getopt
-
-    # Get all config variables
-    revformat = do("git config --get ciabot.revformat")
-    project = do("git config --get ciabot.project")
-    repo = do("git config --get ciabot.repo")
-    xmlrpc = do("git config --get ciabot.xmlrpc")
-    xmlrpc = not (xmlrpc and xmlrpc == "false")
-
-    host = socket.getfqdn()
-    fromaddr = "CIABOT-NOREPLY@" + host
-
-    try:
-        (options, arguments) = getopt.getopt(sys.argv[1:], "np:xV")
-    except getopt.GetoptError, msg:
-        print "ciabot.py: " + str(msg)
-        raise SystemExit, 1
-
-    notify = True
-    for (switch, val) in options:
-        if switch == '-p':
-            project = val
-        elif switch == '-n':
-            notify = False
-        elif switch == '-x':
-            xmlrpc = True
-        elif switch == '-V':
-            print "ciabot.py: version", version
-            sys.exit(0)
-
-    # The project variable defaults to the name of the repository toplevel.
-    if not project:
-        here = os.getcwd()
-        while True:
-            if os.path.exists(os.path.join(here, ".git")):
-                project = os.path.basename(here)
-                break
-            elif here == '/':
-                sys.stderr.write("ciabot.py: no .git below root!\n")
-                sys.exit(1)
-            here = os.path.dirname(here)
-
-    if not repo:
-        repo = project.lower()
-
-    urlprefix = urlprefix % globals()
-
-    # The script wants a reference to head followed by the list of
-    # commit ID to report about.
-    if len(arguments) == 0:
-        refname = do("git symbolic-ref HEAD 2>/dev/null")
-        merges = [do("git rev-parse HEAD")]
-    else:
-        refname = arguments[0]
-        merges = arguments[1:]
-
-    if notify:
-        if xmlrpc:
-            import xmlrpclib
-            server = xmlrpclib.Server('http://cia.vc/RPC2');
-        else:
-            import smtplib
-            server = smtplib.SMTP('localhost')
-
-    for merged in merges:
-        message = report(refname, merged, xmlrpc)
-        if not notify:
-            print message
-        elif xmlrpc:
-            try:
-                # RPC server is flaky, this can fail due to timeout.
-                server.hub.deliver(message)
-            except socket.error, e:
-                sys.stderr.write("%s\n" % e)
-        else:
-            server.sendmail(fromaddr, [toaddr], message)
-
-    if notify:
-        if not xmlrpc:
-            server.quit()
-
-#End
diff --git a/contrib/ciabot/ciabot.sh b/contrib/ciabot/ciabot.sh
deleted file mode 100755
index dfb71a1..0000000
--- a/contrib/ciabot/ciabot.sh
+++ /dev/null
@@ -1,233 +0,0 @@
-#!/bin/sh
-# Distributed under the terms of the GNU General Public License v2
-# Copyright (c) 2006 Fernando J. Pereda <ferdy@gentoo.org>
-# Copyright (c) 2008 Natanael Copa <natanael.copa@gmail.com>
-# Copyright (c) 2010 Eric S. Raymond <esr@thyrsus.com>
-# Assistance and review by Petr Baudis, author of ciabot.pl,
-# is gratefully acknowledged.
-#
-# This is a version 3.x of ciabot.sh; use -V to find the exact
-# version.  Versions 1 and 2 were shipped in 2006 and 2008 and are not
-# version-stamped.  The version 2 maintainer has passed the baton.
-#
-# Note: This script should be considered obsolete.
-# There is a faster, better-documented rewrite in Python: find it as ciabot.py
-# Use this only if your hosting site forbids Python hooks.
-# It requires: git(1), hostname(1), cut(1), sendmail(1), and wget(1).
-#
-# Originally based on Git ciabot.pl by Petr Baudis.
-# This script contains porcelain and porcelain byproducts.
-#
-# usage: ciabot.sh [-V] [-n] [-p projectname] [refname commit]
-#
-# This script is meant to be run either in a post-commit hook or in an
-# update hook. Try it with -n to see the notification mail dumped to
-# stdout and verify that it looks sane. With -V it dumps its version
-# and exits.
-#
-# In post-commit, run it without arguments. It will query for
-# current HEAD and the latest commit ID to get the information it
-# needs.
-#
-# In update, you have to call it once per merged commit:
-#
-#       refname=$1
-#       oldhead=$2
-#       newhead=$3
-#       for merged in $(git rev-list ${oldhead}..${newhead} | tac) ; do
-#               /path/to/ciabot.sh ${refname} ${merged}
-#       done
-#
-# The reason for the tac call is that git rev-list emits commits from
-# most recent to least - better to ship notifications from oldest to newest.
-#
-# Configuration variables affecting this script:
-#
-# ciabot.project = name of the project
-# ciabot.repo = name of the project repo for gitweb/cgit purposes
-# ciabot.revformat = format in which the revision is shown
-#
-# ciabot.project defaults to the directory name of the repository toplevel.
-# ciabot.repo defaults to ciabot.project lowercased.
-#
-# This means that in the normal case you need not do any configuration at all,
-# but setting the project name will speed it up slightly.
-#
-# The revformat variable may have the following values
-# raw -> full hex ID of commit
-# short -> first 12 chars of hex ID
-# describe = -> describe relative to last tag, falling back to short
-# The default is 'describe'.
-#
-# Note: the shell ancestors of this script used mail, not XML-RPC, in
-# order to avoid stalling until timeout when the CIA XML-RPC server is
-# down. It is unknown whether this is still an issue in 2010, but
-# XML-RPC would be annoying to do from sh in any case. (XML-RPC does
-# have the advantage that it guarantees notification of multiple commits
-# shipped from an update in their actual order.)
-#
-
-# The project as known to CIA. You can set this with a -p option,
-# or let it default to the directory name of the repo toplevel.
-project=$(git config --get ciabot.project)
-
-if [ -z $project ]
-then
-    here=`pwd`;
-    while :; do
-	if [ -d $here/.git ]
-	then
-	    project=`basename $here`
-	    break
-	elif [ $here = '/' ]
-	then
-	    echo "ciabot.sh: no .git below root!"
-	    exit 1
-	fi
-	here=`dirname $here`
-    done
-fi
-
-# Name of the repo for gitweb/cgit purposes
-repo=$(git config --get ciabot.repo)
-[ -z $repo] && repo=$(echo "${project}" | tr '[A-Z]' '[a-z]')
-
-# What revision format do we want in the summary?
-revformat=$(git config --get ciabot.revformat)
-
-# Fully qualified domain name of the repo host.  You can hardwire this
-# to make the script faster. The -f option works under Linux and FreeBSD,
-# but not OpenBSD and NetBSD. But under OpenBSD and NetBSD,
-# hostname without options gives the FQDN.
-if hostname -f >/dev/null 2>&1
-then
-    hostname=`hostname -f`
-else
-    hostname=`hostname`
-fi
-
-# Changeset URL prefix for your repo: when the commit ID is appended
-# to this, it should point at a CGI that will display the commit
-# through gitweb or something similar. The defaults will probably
-# work if you have a typical gitweb/cgit setup.
-#urlprefix="http://${host}/cgi-bin/gitweb.cgi?p=${repo};a=commit;h="
-urlprefix="http://${host}/cgi-bin/cgit.cgi/${repo}/commit/?id="
-
-#
-# You probably will not need to change the following:
-#
-
-# Identify the script. The 'generator' variable should change only
-# when the script itself gets a new home and maintainer.
-generator="http://www.catb.org/~esr/ciabot/ciabot.sh"
-version=3.5
-
-# Addresses for the e-mail
-from="CIABOT-NOREPLY@${hostname}"
-to="cia@cia.vc"
-
-# SMTP client to use - may need to edit the absolute pathname for your system
-sendmail="sendmail -t -f ${from}"
-
-#
-# No user-serviceable parts below this line:
-#
-
-# Should include all places sendmail is likely to lurk.
-PATH="$PATH:/usr/sbin/"
-
-mode=mailit
-while getopts pnV opt
-do
-    case $opt in
-	p) project=$2; shift ; shift ;;
-	n) mode=dumpit; shift ;;
-	V) echo "ciabot.sh: version $version"; exit 0; shift ;;
-    esac
-done
-
-# Cough and die if user has not specified a project
-if [ -z "$project" ]
-then
-    echo "ciabot.sh: no project specified, bailing out." >&2
-    exit 1
-fi
-
-if [ $# -eq 0 ] ; then
-	refname=$(git symbolic-ref HEAD 2>/dev/null)
-	merged=$(git rev-parse HEAD)
-else
-	refname=$1
-	merged=$2
-fi
-
-# This tries to turn your gitwebbish URL into a tinyurl so it will take up
-# less space on the IRC notification line. Some repo sites (I'm looking at
-# you, berlios.de!) forbid wget calls for security reasons.  On these,
-# the code will fall back to the full un-tinyfied URL.
-longurl=${urlprefix}${merged}
-url=$(wget -O - -q http://tinyurl.com/api-create.php?url=${longurl} 2>/dev/null)
-if [ -z "$url" ]; then
-	url="${longurl}"
-fi
-
-refname=${refname##refs/heads/}
-
-case $revformat in
-raw) rev=$merged ;;
-short) rev='' ;;
-*) rev=$(git describe ${merged} 2>/dev/null) ;;
-esac
-[ -z ${rev} ] && rev=$(echo "$merged" | cut -c 1-12)
-
-# We discard the part of the author's address after @.
-# Might be nice to ship the full email address, if not
-# for spammers' address harvesters - getting this wrong
-# would make the freenode #commits channel into harvester heaven.
-author=$(git log -1 '--pretty=format:%an <%ae>' $merged)
-author=$(echo "$author" | sed -n -e '/^.*<\([^@]*\).*$/s--\1-p')
-
-logmessage=$(git log -1 '--pretty=format:%s' $merged)
-ts=$(git log -1 '--pretty=format:%at' $merged)
-files=$(git diff-tree -r --name-only ${merged} | sed -e '1d' -e 's-.*-<file>&</file>-')
-
-out="
-<message>
-  <generator>
-    <name>CIA Shell client for Git</name>
-    <version>${version}</version>
-    <url>${generator}</url>
-  </generator>
-  <source>
-    <project>${project}</project>
-    <branch>$repo:${refname}</branch>
-  </source>
-  <timestamp>${ts}</timestamp>
-  <body>
-    <commit>
-      <author>${author}</author>
-      <revision>${rev}</revision>
-      <files>
-	${files}
-      </files>
-      <log>${logmessage} ${url}</log>
-      <url>${url}</url>
-    </commit>
-  </body>
-</message>"
-
-if [ "$mode" = "dumpit" ]
-then
-    sendmail=cat
-fi
-
-${sendmail} << EOM
-Message-ID: <${merged}.${author}@${project}>
-From: ${from}
-To: ${to}
-Content-type: text/xml
-Subject: DeliverXML
-${out}
-EOM
-
-# vim: set tw=70 :
-- 
1.8.4.474.g128a96c
