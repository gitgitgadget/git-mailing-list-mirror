From: Clark Williams <clark.williams@gmail.com>
Subject: [StGit PATCH] compressed import v3
Date: Thu, 12 Jun 2008 16:32:50 -0500
Message-ID: <48519602.2090103@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010608080503000908030407"
Cc: git@vger.kernel.org
To: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 23:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6uQi-00038g-GR
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 23:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYFLVdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 17:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbYFLVdF
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 17:33:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:36295 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbYFLVdC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 17:33:02 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1440689wxd.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:x-enigmail-version
         :content-type;
        bh=eT0HPPsMGQ4br2wHYcHBsj1wwmGZl6oa/i2NWyvN0nc=;
        b=r7tz1VanMPlSp92dwzPzyIwbOUGskzzcoRbrIGZicr7tjUhFI4H2i71514fyeg5XWs
         wj+Cn1JsFQuiDtHeifiYve/6s4zwQdP4KMW4bkjXdHk24nH2mN6lNEKjrY7utWDg+Dr/
         72d2LR9OXBpLgViinOmaGu0iIn3nmYqe4gR60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-enigmail-version:content-type;
        b=SLhRaAyQFYYy3w3AYdl2PQYFd4YD/3ZGeU7I3L0MiCIY7Jpgo5Vw6vkHmHnvQc3vid
         t4tB2A3rIVjvCnb00+ocyNMpyoCHl7ghrvSKuYvYcUNt9q3ziekDik/vbgdl4X7eMoZy
         yyIiapZk1Yb4fhG1rBEgZfkCuqqfpOOPe0gsU=
Received: by 10.70.43.16 with SMTP id q16mr1911307wxq.82.1213306378230;
        Thu, 12 Jun 2008 14:32:58 -0700 (PDT)
Received: from ?172.16.17.168? ( [66.187.231.200])
        by mx.google.com with ESMTPS id h15sm2868746wxd.38.2008.06.12.14.32.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 14:32:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84800>

This is a multi-part message in MIME format.
--------------010608080503000908030407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl/Catalin, et al,

Attached is my latest stab at StGit importing patches from compressed files. This
version doesn't try to differentiate by the file extension; it just tries to open
gzip or bz2 files and if those fail it reverts to text. I'm not completely happy with
it, but I've spent about as much time on it as I can afford to (for this week anyway).

Yeah, yeah, Karl, there are four new tests in t1800-import. Let me know if you think
there should be more (more for compressed input that is; I'm not crazy enough to sign
up to write more tests for *everything*). :)

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhRlgIACgkQqA4JVb61b9d2ygCfTUPc5I9eXM4947VTrTZ+mO0H
+vIAoJJACG94TdnyUIac73lB4UYCZVlG
=sa3t
-----END PGP SIGNATURE-----

--------------010608080503000908030407
Content-Type: text/x-patch;
 name="compressed-input.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compressed-input.patch"

Patch to allow import from compressed files (gzip and bzip2)

From: Clark Williams <williams@redhat.com>

Signed-off-by: Clark Williams <williams@redhat.com>
---

 stgit/commands/imprt.py |   42 ++++++++++++++++++++++++++++++++++++------
 t/t1800-import.sh       |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 4a4b792..fc5cdce 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -175,14 +175,49 @@ def __create_patch(filename, message, author_name, author_email,
                                  backup = False)
         out.done()
 
+def __mkpatchname(name, suffix):
+    if name.lower().endswith(suffix.lower()):
+        return name[:-len(suffix)]
+    return name
+
+def __gethandleandname(filename):
+    """return a file handle and a patch name derived from filename
+    """
+    # see if it's a gzip'ed patch
+    try:
+        import gzip
+        f = gzip.open(filename)
+        f.read(1)
+        f.seek(0)
+        return (f, __mkpatchname(filename, '.gz'))
+    except IOError, e:
+            pass
+    # see if it's a bzip2'ed patch
+    try:
+        import bz2
+        f = bz2.BZ2File(filename)
+        f.read(1)
+        f.seek(0)
+        return (f, __mkpatchname(filename, '.bz2'))
+    except IOError, e:
+            pass
+    # plain old file...
+    return (open(filename), filename)
+
 def __import_file(filename, options, patch = None):
     """Import a patch from a file or standard input
     """
+    pname = None
     if filename:
-        f = file(filename)
+        (f, pname) = __gethandleandname(filename)
     else:
         f = sys.stdin
 
+    if patch:
+        pname = patch
+    elif not pname:
+        pname = filename
+
     if options.mail:
         try:
             msg = email.message_from_file(f)
@@ -197,11 +232,6 @@ def __import_file(filename, options, patch = None):
     if filename:
         f.close()
 
-    if patch:
-        pname = patch
-    else:
-        pname = filename
-
     __create_patch(pname, message, author_name, author_email,
                    author_date, diff, options)
 
diff --git a/t/t1800-import.sh b/t/t1800-import.sh
index 8c8c9a0..1352743 100755
--- a/t/t1800-import.sh
+++ b/t/t1800-import.sh
@@ -80,4 +80,46 @@ test_expect_success \
     stg delete ..
     '
 
+test_expect_success \
+    'Apply a bzip2 patch created with "git diff"' \
+    '
+    bzip2 -c ../t1800-import/git-diff >../t1800-import/bzip2-git-diff &&
+    stg import ../t1800-import/bzip2-git-diff &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") = 1 ] &&
+    rm ../t1800-import/bzip2-git-diff &&
+    stg delete .. 
+    '
+test_expect_success \
+    'Apply a bzip2 patch with a .bz2 suffix' \
+    '
+    bzip2 -c ../t1800-import/git-diff >../t1800-import/git-diff.bz2 &&
+    stg import ../t1800-import/git-diff.bz2 &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") = 1 ] &&
+    rm ../t1800-import/git-diff.bz2 &&
+    stg delete .. 
+    '
+
+test_expect_success \
+    'Apply a gzip patch created with GNU diff' \
+    '
+    gzip -c ../t1800-import/gnu-diff >../t1800-import/gzip-gnu-diff &&
+    stg import ../t1800-import/gzip-gnu-diff &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") = 1 ] &&
+    rm ../t1800-import/gzip-gnu-diff &&
+    stg delete ..
+    '
+test_expect_success \
+    'Apply a gzip patch with a .gz suffix' \
+    '
+    gzip -c ../t1800-import/gnu-diff >../t1800-import/gnu-diff.gz &&
+    stg import ../t1800-import/gnu-diff.gz &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") = 1 ] &&
+    rm ../t1800-import/gnu-diff.gz &&
+    stg delete ..
+    '
+
 test_done

--------------010608080503000908030407--
