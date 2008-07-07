From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Describe projects_index format in more detail
Date: Tue, 08 Jul 2008 00:07:53 +0200
Message-ID: <20080707220530.8439.33340.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 00:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFytH-0000VU-09
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 00:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbYGGWH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 18:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbYGGWH6
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 18:07:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:51133 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbYGGWH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 18:07:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so899492fgg.17
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=nzLcMvfg3F3qtlhtR4853PFS9XKsqlg2WlltKnezUlM=;
        b=vIXfZsv6vEblD2EBBJJjkY9wpY5oshoq/Kn44GiiykJlCav7qY1poYeX5B6+SSJ0lI
         DiV4n8bakVp528bRjXvshX7SMVX2y329zcXzrx89lqC/GhHSW6Bpwpxr+QJ4HHs9sTPp
         SRm379GEP1E2UCba63sNLr7MAQma1p7D08Kwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=c21Z1cuF6Fc7r6/vgFcIjdUICRFzsUGkNkRyqll518W0hKAP1857iC9luulDo7B5UR
         1pEAjXw5Ty4VMuIdjB/8XWaGPeb+/6pg5Y4nuAFz3fqNfq/jHZ/1kTC7zYFX61hTif70
         0SC2TEBsJOac9MzYyKCKwgSwDS+m/t8B3YWtk=
Received: by 10.86.30.9 with SMTP id d9mr1363385fgd.37.1215468475261;
        Mon, 07 Jul 2008 15:07:55 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.206.62])
        by mx.google.com with ESMTPS id d4sm5525360fga.8.2008.07.07.15.07.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 15:07:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m67M7rbj008482
	for <git@vger.kernel.org>; Tue, 8 Jul 2008 00:07:55 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87660>

Update and extend information about $projects_list file format in
gitweb/README and in gitweb/INSTALL.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This was part of
  "gitweb: Extend project_index file format by project description"
patch send to git mailing list (but not applied).  I thought that
updating documentation can be done independently, so here it is (minus
of course information about optional repository description field).

 gitweb/INSTALL |    6 ++++++
 gitweb/README  |   46 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index f7194db..26967e2 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -144,6 +144,12 @@ Gitweb repositories
   Spaces in both project path and project owner have to be encoded as either
   '%20' or '+'.
 
+  Other characters that have to be url-encoded, i.e. replaced by '%'
+  followed by two-digit character number in octal, are: other whitespace
+  characters (because they are field separator in a record), plus sign '+'
+  (because it can be used as replacement for spaces), and percent sign '%'
+  (which is used for encoding / escaping).
+
   You can generate the projects list index file using the project_index
   action (the 'TXT' link on projects list page) directly from gitweb.
 
diff --git a/gitweb/README b/gitweb/README
index 356ab7b..6908036 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -156,10 +156,11 @@ not include variables usually directly set during build):
    set correctly for gitweb to find repositories.
  * $projects_list
    Source of projects list, either directory to scan, or text file
-   with list of repositories (in the "<URI-encoded repository path> SPC
-   <URI-encoded repository owner>" format).  Set to $GITWEB_LIST
-   during installation.  If empty, $projectroot is used to scan for
-   repositories.
+   with list of repositories (in the "<URI-encoded repository path> SP
+   <URI-encoded repository owner>" line format; actually there can be
+   any sequence of whitespace in place of space (SP)).  Set to
+   $GITWEB_LIST during installation.  If empty, $projectroot is used
+   to scan for repositories.
  * $my_url, $my_uri
    URL and absolute URL of gitweb script; you might need to set those
    variables if you are using 'pathinfo' feature: see also below.
@@ -214,6 +215,39 @@ not include variables usually directly set during build):
    ('-M'); set it to ('-C') or ('-C', '-C') to also detect copies, or
    set it to () if you don't want to have renames detection.
 
+
+Projects list file format
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Instead of having gitweb find repositories by scanning filesystem starting
+from $projectroot (or $projects_list, if it points to directory), you can
+provide list of projects by setting $projects_list to a text file with list
+of projects (and some additional info).  This file uses the following
+format:
+
+One record (for project / repository) per line, whitespace separated fields;
+does not support (at least for now) lines continuation (newline escaping).
+Leading and trailing whitespace are ignored, any run of whitespace can be
+used as field separator (rules for Perl's "split(' ', $line)").  Keyed by
+the first field, which is project name, i.e. path to repository GIT_DIR
+relative to $projectroot.  Fields use modified URI encoding, defined in
+RFC 3986, section 2.1 (Percent-Encoding), or rather "Query string encoding"
+(see http://en.wikipedia.org/wiki/Query_string#URL_encoding), the difference
+being that SP (' ') can be encoded as '+' (and therefore '+' has to be also
+percent-encoded).  Reserved characters are: '%' (used for encoding), '+'
+(can be used to encode SPACE), all whitespace characters as defined in Perl,
+including SP, TAB and LF, (used to separate fields in a record).
+
+Currently list of fields is
+ * <repository path>  - path to repository GIT_DIR, relative to $projectroot
+ * <repository owner> - displayed as repository owner, preferably full name,
+                        or email, or both
+
+You can additionally use $projects_list file to limit which repositories
+are visible, and together with $strict_export to limit access to
+repositories (see "Gitweb repositories" section in gitweb/INSTALL).
+
+
 Per-repository gitweb configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -225,8 +259,8 @@ You can use the following files in repository:
  * README.html
    A .html file (HTML fragment) which is included on the gitweb project
    summary page inside <div> block element. You can use it for longer
-   description of a project, to provide links for example to projects
-   homepage, etc.
+   description of a project, to provide links (for example to project's
+   homepage), etc.
  * description (or gitweb.description)
    Short (shortened by default to 25 characters in the projects list page)
    single line description of a project (of a repository). Plain text file;
