From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4] Documentation/urls: Rewrite to accomodate 
	<transport>::<address>
Date: Tue, 6 Apr 2010 14:08:19 +0530
Message-ID: <z2lf3271551004060138u49c15784x968966cf779e37f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 10:38:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz4JE-0004jF-5G
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 10:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab0DFIiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 04:38:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57870 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab0DFIit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 04:38:49 -0400
Received: by gyg13 with SMTP id 13so2502085gyg.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=LZXo9PQPgz2MJjwDobJnLLEpwdMlvrCFPO0L31iTV5k=;
        b=bU4vH8PrQ+t6CVE2ZtN5m+WpugLNhUunK8LlSokDQHlyWgoqpkl9g5CtcgUpWEpqri
         xo3aYsGZkkkYwl8ZE4dzmhKmZUrkp463wSNcGfktX4/ca5uNpcwXJ4Jn3nB0fFZo6siz
         Qh1lNeN+dBZePVe03YAtWzhGDjIzLprFmj/GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=jn26Bj0W56ZKgI9vjbyBMnHB55jvRHbbZ3qmIMIKDY2+3HmEdn0NymSoQAOXCRvxIC
         SrDOUzyAVT07nXyZr0OAuHQN5FWUH0bZfmKMN/7gl734ZygUrM6rQzjnu/MFgQU4uW3w
         uvA64L1mOs/Z/ZUZYLGQq2uJYSCZYpeEBT/VI=
Received: by 10.90.69.14 with HTTP; Tue, 6 Apr 2010 01:38:19 -0700 (PDT)
Received: by 10.91.58.11 with SMTP id l11mr2076428agk.0.1270543119075; Tue, 06 
	Apr 2010 01:38:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144114>

Rewrite the first part of the document to explicitly show differences
between the URLs that can be used with different transport
protocols. Mention <transport>::<address> format to explicitly invoke
a remote helper.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Added trailing slashes and removed ssh protocol's special status
 after Junio's review of v3.

 Documentation/urls.txt |   58 +++++++++++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 459a394..a473da6 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -1,44 +1,52 @@
 GIT URLS[[URLS]]
 ----------------

-One of the following notations can be used
-to name the remote repository:
+In general, URLs contain information about the transport protocol, the
+address of the remote server, and the path to the repository.
+Depending on the transport protocol, some of this information may be
+absent.
+
+Git natively supports ssh, git, rsync, http, https, ftp, and ftps
+protocols. The following syntaxes may be used with them:

-- rsync://host.xz/path/to/repo.git/
-- http://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- https://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/~/path/to/repo.git
+- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- rsync://host.xz/path/to/repo.git/
+- http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/

-SSH is the default transport protocol over the network.  You can
-optionally specify which user to log-in as, and an alternate,
-scp-like syntax is also supported.  Both syntaxes support
-username expansion, as does the native git protocol, but
-only the former supports port specification. The following
-three are identical to the last three above, respectively:
+An alternative scp-like syntax may also be used with the ssh protocol:

-- {startsb}user@{endsb}host.xz:/path/to/repo.git/
-- {startsb}user@{endsb}host.xz:~user/path/to/repo.git/
-- {startsb}user@{endsb}host.xz:path/to/repo.git
+- {startsb}user@{endsb}host.xz:path/to/repo.git/

-To sync with a local directory, you can use:
+The ssh and git protocols additionally support ~username expansion:
+
+- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
+- git://host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
+- {startsb}user@{endsb}host.xz:/~{startsb}user{endsb}/path/to/repo.git/
+
+For local respositories, also supported by git natively, the following
+syntaxes may be used:

 - /path/to/repo.git/
 - file:///path/to/repo.git/

 ifndef::git-clone[]
-They are mostly equivalent, except when cloning.  See
-linkgit:git-clone[1] for details.
+These two syntaxes are mostly equivalent, except when cloning, when
+the former implies --local option. See linkgit:git-clone[1] for
+details.
 endif::git-clone[]

-ifdef::git-clone[]
-They are equivalent, except the former implies --local option.
-endif::git-clone[]
+When git doesn't know how to handle a certain transport protocol, it
+attempts to use the 'remote-<transport>' remote helper, if one
+exists. To explicitly request a remote helper, the following syntax
+may be used:
+
+- <transport>::<address>

+where <address> may be a path, a server and path, or an arbitrary
+URL-like string recognized by the specific remote helper being
+invoked. See linkgit:git-remote-helpers[1] for details.

 If there are a large number of similarly-named remote repositories and
 you want to use a different format for them (such that the URLs you
-- 
1.7.0.3
