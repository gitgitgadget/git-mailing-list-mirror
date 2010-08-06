From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH svnrdump-standalone] Sync with upstream
Date: Fri, 6 Aug 2010 13:37:36 -0500
Message-ID: <20100806183736.GA2985@burratino>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <7vsk3myuyo.fsf@alter.siamese.dyndns.org>
 <20100715105527.GC22574@debian>
 <20100806175709.GA2683@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 20:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhRp8-0006eb-Go
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 20:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943Ab0HFSjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 14:39:12 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61190 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935598Ab0HFSjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 14:39:07 -0400
Received: by ewy23 with SMTP id 23so2914575ewy.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PlR+NPxy0WGoCuwVvBc3jrWhZYroqX2SOscsYnvcZi4=;
        b=F6Gd3tkEgqk18P/Cfw5gOxT1lWmtD7iwXsBoBRmQwR1G7Kne6y3nJ8ZSInDAkKHc8c
         mr78qDVHUcWy24HKjir/qMuiv399BNHUS8mlA7hafs0199xZgrpwrbp+Cqcq3e2q4Msu
         2J7/kJ9ETPXDIihKXEBzdJr0VbDTTKUEcIUC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=opP1pbTgF8TjPaPKD3oH54m199+lymupS1u6vFI71/cAlQihrVYrLlflTH/KTEOSHk
         ZAEiWGwckffC9RcGv4P8YAEq+iYVxf20AZczTrjP8pTR1ouXVawMs+s/NH1CtvoyZqYa
         P0+034k6igiOyxKdpiZtOcJUwCQqKV4SF8ohc=
Received: by 10.213.26.13 with SMTP id b13mr4531385ebc.91.1281119945456;
        Fri, 06 Aug 2010 11:39:05 -0700 (PDT)
Received: from burratino ([66.99.1.133])
        by mx.google.com with ESMTPS id z55sm2773630eeh.15.2010.08.06.11.39.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 11:39:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806175709.GA2683@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152800>

Jonathan Nieder wrote:

> Delete all files and copy in newer versions from Subversion
> upstream (http://svn.apache.org/repos/asf/subversion/trunk@982862).

Here=E2=80=99s the =E2=80=9Cwhile at it=E2=80=9D part:

> While at it, port for an out-of-tree build against svn 1.6:
>=20
>  - include a stripped-down version of the autoconf-generated
>    Makefile for Linux and a .gitignore file listing build
>    products;
>=20
>  - use apr_hash_clear directly instead of svn_hash__clear
>    (since the latter=E2=80=99s signature has changed);
>=20
>  - build and use an svn17_compat module for functions used
>    that were added in Subversion 1.7.
>=20
> In theory, the svn17_compat module could shrink over time
> as simpler compatibility shims are devised.
>
> The result builds and all dump tests pass.
>
> Caveats: Most load tests do not pass.  Chances are this will only
> build against libsvn 1.6, not 1.7, since I did not do the appropriate
> identifier-renaming dance.

Most of this patch is Subversion code.

The rest, which is my own doing, I place in the public domain.
You may freely use, modify, distribute, and relicense it.

 .gitignore      |    5 +
 Makefile        |   35 +++
 dump_editor.c   |    9 +-
 svn17_compat.c  |  842 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 svn17_compat.h  |  179 ++++++++++++
 svnrdump.c      |    5 +-
 svntest/main.py |   17 +-
 7 files changed, 1076 insertions(+), 16 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 Makefile
 create mode 100644 svn17_compat.c
 create mode 100644 svn17_compat.h

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..af251b1
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,5 @@
+*.lo
+*.o
+*.pyc
+/svn-test-work/
+/svnrdump
diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..b022411
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,35 @@
+CC=3Dgcc
+PYTHON=3Dpython
+LIBTOOL=3Dlibtool
+LTFLAGS=3D--tag=3DCC --silent
+CFLAGS=3D-g -O2 -pthread -Wall -Werror=3Dimplicit-function-declaration
+EXEEXT=3D
+CPPFLAGS=3D-DLINUX=3D2 -D_REENTRANT -D_GNU_SOURCE -D_LARGEFILE64_SOURC=
E
+LDFLAGS=3D
+COMPILE=3D$(CC) $(CPPFLAGS) $(CFLAGS) $(INCLUDES)
+LINK=3D$(LIBTOOL) $(LTFLAGS) --mode=3Dlink $(CC) $(CFLAGS)
+LT_COMPILE=3D$(LIBTOOL) $(LTFLAGS) --mode=3Dcompile $(COMPILE) $(CFLAG=
S)
+
+INCLUDES=3D-I/usr/include/subversion-1 -I/usr/include/apr-1.0
+LIBS=3D-lsvn_client-1 -lsvn_ra-1 -lsvn_repos-1 -lsvn_delta-1 -lsvn_sub=
r-1 -lapr-1
+OBJECTS=3Ddump_editor.lo load_editor.lo svnrdump.lo svn17_compat.lo
+
+.SUFFIXES: .c .lo
+
+svnrdump$(EXEEXT): $(OBJECTS)
+	$(LINK) $(LDFLAGS) -o svnrdump$(EXEEXT) $(OBJECTS) $(LIBS)
+
+.c.lo:
+	$(LT_COMPILE) -o $@ -c $<
+
+dump_editor.lo: dump_editor.c dump_editor.h svn17_compat.h
+load_editor.lo: load_editor.c load_editor.h
+svnrdump.lo: svnrdump.c dump_editor.h load_editor.h svn17_compat.h
+svn17_compat.lo: svn17_compat.c svn17_compat.h
+
+check: svnrdump$(EXEEXT) svnrdump_tests.py
+	$(PYTHON) svnrdump_tests.py
+
+clean:
+	$(RM) svnrdump$(EXEEXT)
+	$(RM) *.lo *.o
diff --git a/dump_editor.c b/dump_editor.c
index dac9d15..72ad04f 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -29,6 +29,7 @@
 #include "svn_props.h"
 #include "svn_dirent_uri.h"
=20
+#include "svn17_compat.h"
 #include "dump_editor.h"
=20
 #define ARE_VALID_COPY_ARGS(p,r) ((p) && SVN_IS_VALID_REVNUM(r))
@@ -166,8 +167,8 @@ dump_props(struct dump_edit_baton *eb,
       SVN_ERR(svn_stream_printf(eb->stream, pool, "\n\n"));
=20
       /* Cleanup so that data is never dumped twice. */
-      svn_hash__clear(eb->props, pool);
-      svn_hash__clear(eb->deleted_props, pool);
+      apr_hash_clear(eb->props);
+      apr_hash_clear(eb->deleted_props);
       if (trigger_var)
         *trigger_var =3D FALSE;
     }
@@ -711,8 +712,8 @@ close_file(void *file_baton,
=20
       /* Cleanup */
       eb->dump_props =3D eb->dump_props_pending =3D FALSE;
-      svn_hash__clear(eb->props, pool);
-      svn_hash__clear(eb->deleted_props, pool);
+      apr_hash_clear(eb->props);
+      apr_hash_clear(eb->deleted_props);
     }
=20
   /* Dump the text */
diff --git a/svn17_compat.c b/svn17_compat.c
new file mode 100644
index 0000000..e6d8774
--- /dev/null
+++ b/svn17_compat.c
@@ -0,0 +1,842 @@
+/*
+ * svn17_compat.c :   a library to make Subversion 1.6 look like 1.7.
+ *
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *    This file is derived from code licensed to the Apache
+ *    Software Foundation (ASF) under one or more contributor
+ *    license agreements.  See the NOTICE file distributed with
+ *    this file for additional information regarding copyright
+ *    ownership.  The ASF licenses those portions to you under
+ *    the Apache License, Version 2.0 (the "License"); you may
+ *    not use those portions except in compliance with the
+ *    License.  You may obtain a copy of the License at
+ *
+ *       http://www.apache.org/licenses/LICENSE-2.0
+ *
+ *    Unless required by applicable law or agreed to in writing,
+ *    software distributed under the License is distributed on an
+ *    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
+ *    KIND, either express or implied.  See the License for the
+ *    specific language governing permissions and limitations
+ *    under the License.
+ *
+ *    Any code in this file not licensed from the ASF is
+ *    original code in the public domain.  You may freely use,
+ *    modify, distribute, and relicense such code.
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+=0C
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+
+#include <apr.h>
+#include <apr_strings.h>
+#include <apr_hash.h>
+#include <apr_lib.h>
+#include <apr_errno.h>
+#include <apr_pools.h>
+
+#include <svn_error.h>
+#include <svn_config.h>
+#include <svn_io.h>
+#include <svn_dirent_uri.h>
+#include <svn_path.h>
+#include "svn17_compat.h"
+
+/* TRUE if s is the canonical empty path, FALSE otherwise
+   From libsvn_subr/dirent_uri.c. */
+#define SVN_PATH_IS_EMPTY(s) ((s)[0] =3D=3D '\0')
+
+/* Path type definition. Used only by internal functions.
+   From libsvn_subr/dirent_uri.c. */
+typedef enum {
+  type_uri,
+  type_dirent,
+  type_relpath
+} path_type_t;
+
+/* Here is the BNF for path components in a URI. "pchar" is a
+   character in a path component.
+
+      pchar       =3D unreserved | escaped |
+                    ":" | "@" | "&" | "=3D" | "+" | "$" | ","
+      unreserved  =3D alphanum | mark
+      mark        =3D "-" | "_" | "." | "!" | "~" | "*" | "'" | "(" | =
")"
+
+   Note that "escaped" doesn't really apply to what users can put in
+   their paths, so that really means the set of characters is:
+
+      alphanum | mark | ":" | "@" | "&" | "=3D" | "+" | "$" | ","
+
+   From libsvn_subr/path.c. */
+static const char svn_uri__char_validity[256] =3D {
+  0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
+  0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
+  0, 1, 0, 0, 1, 0, 1, 1,   1, 1, 1, 1, 1, 1, 1, 1,
+  1, 1, 1, 1, 1, 1, 1, 1,   1, 1, 1, 0, 0, 1, 0, 0,
+
+  /* 64 */
+  1, 1, 1, 1, 1, 1, 1, 1,   1, 1, 1, 1, 1, 1, 1, 1,
+  1, 1, 1, 1, 1, 1, 1, 1,   1, 1, 1, 0, 0, 0, 0, 1,
+  0, 1, 1, 1, 1, 1, 1, 1,   1, 1, 1, 1, 1, 1, 1, 1,
+  1, 1, 1, 1, 1, 1, 1, 1,   1, 1, 1, 0, 0, 0, 1, 0,
+
+  /* 128 */
+  0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
+  0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
+  0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
+  0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
+
+  /* 192 */
+  0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
+  0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
+  0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
+  0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
+};
+
+/* From libsvn_subr/dirent_uri.c. */
+static svn_boolean_t
+svn_uri_is_canonical(const char *uri, apr_pool_t *pool)
+{
+  const char *ptr =3D uri, *seg =3D uri;
+  const char *schema_data =3D NULL;
+
+  /* URI is canonical if it has:
+   *  - no '.' segments
+   *  - no closing '/', unless for the root path '/' itself
+   *  - no '//'
+   *  - lowercase URL scheme
+   *  - lowercase URL hostname
+   */
+
+  if (*uri =3D=3D '\0')
+    return TRUE;
+
+  /* Maybe parse hostname and scheme. */
+  if (*ptr !=3D '/')
+    {
+      while (*ptr && (*ptr !=3D '/') && (*ptr !=3D ':'))
+        ptr++;
+
+      if (*ptr =3D=3D ':' && *(ptr+1) =3D=3D '/' && *(ptr+2) =3D=3D '/=
')
+        {
+          /* Found a scheme, check that it's all lowercase. */
+          ptr =3D uri;
+          while (*ptr !=3D ':')
+            {
+              if (*ptr >=3D 'A' && *ptr <=3D 'Z')
+                return FALSE;
+              ptr++;
+            }
+          /* Skip :// */
+          ptr +=3D 3;
+
+          /* This might be the hostname */
+          seg =3D ptr;
+          while (*ptr && (*ptr !=3D '/') && (*ptr !=3D '@'))
+            ptr++;
+
+          if (! *ptr)
+            return TRUE;
+
+          if (*ptr =3D=3D '@')
+            seg =3D ptr + 1;
+
+          /* Found a hostname, check that it's all lowercase. */
+          ptr =3D seg;
+          while (*ptr && *ptr !=3D '/')
+            {
+              if (*ptr >=3D 'A' && *ptr <=3D 'Z')
+                return FALSE;
+              ptr++;
+            }
+
+          schema_data =3D ptr;
+        }
+      else
+        {
+          /* Didn't find a scheme; finish the segment. */
+          while (*ptr && *ptr !=3D '/')
+            ptr++;
+        }
+    }
+
+#ifdef SVN_USE_DOS_PATHS
+  if (schema_data && *ptr =3D=3D '/')
+    {
+      /* If this is a file url, ptr now points to the third '/' in
+         file:///C:/path. Check that if we have such a URL the drive
+         letter is in uppercase. */
+      if (strncmp(uri, "file:", 5) =3D=3D 0 &&
+          ! (*(ptr+1) >=3D 'A' && *(ptr+1) <=3D 'Z') &&
+          *(ptr+2) =3D=3D ':')
+        return FALSE;
+    }
+#endif /* SVN_USE_DOS_PATHS */
+
+  /* Now validate the rest of the URI. */
+  while(1)
+    {
+      apr_size_t seglen =3D ptr - seg;
+
+      if (seglen =3D=3D 1 && *seg =3D=3D '.')
+        return FALSE;  /*  /./   */
+
+      if (*ptr =3D=3D '/' && *(ptr+1) =3D=3D '/')
+        return FALSE;  /*  //    */
+
+      if (! *ptr && *(ptr - 1) =3D=3D '/' && ptr - 1 !=3D uri)
+        return FALSE;  /* foo/  */
+
+      if (! *ptr)
+        break;
+
+      if (*ptr =3D=3D '/')
+        ptr++;
+      seg =3D ptr;
+
+
+      while (*ptr && (*ptr !=3D '/'))
+        ptr++;
+    }
+
+  if (schema_data)
+    {
+      ptr =3D schema_data;
+
+      while (*ptr)
+        {
+          if (*ptr =3D=3D '%')
+            {
+              char digitz[3];
+              int val;
+
+              /* Can't use apr_isxdigit() because lower case letters a=
re
+                 not in our canonical format */
+              if (((*(ptr+1) < '0' || (*ptr+1) > '9'))
+                  && (*(ptr+1) < 'A' || (*ptr+1) > 'F'))
+                return FALSE;
+              else if (((*(ptr+2) < '0' || (*ptr+2) > '9'))
+                  && (*(ptr+2) < 'A' || (*ptr+2) > 'F'))
+                return FALSE;
+
+              digitz[0] =3D *(++ptr);
+              digitz[1] =3D *(++ptr);
+              digitz[2] =3D '\0';
+              val =3D (int)strtol(digitz, NULL, 16);
+
+              if (svn_uri__char_validity[val])
+                return FALSE; /* Should not have been escaped */
+            }
+          else if (*ptr !=3D '/' && !svn_uri__char_validity[(unsigned =
char)*ptr])
+            return FALSE; /* Character should have been escaped */
+          ptr++;
+        }
+    }
+
+  return TRUE;
+}
+
+/* From libsvn_subr/dirent_uri.c. */
+static svn_boolean_t
+svn_uri_is_absolute(const char *uri)
+{
+  /* uri is absolute if it starts with '/' */
+  if (uri && uri[0] =3D=3D '/')
+    return TRUE;
+
+  /* URLs are absolute. */
+  return svn_path_is_url(uri);
+}
+
+/* Calculates the length occupied by the schema defined root of URI
+   From libsvn_subr/dirent_uri.c. */
+static apr_size_t
+uri_schema_root_length(const char *uri, apr_size_t len)
+{
+  apr_size_t i;
+
+  for (i =3D 0; i < len; i++)
+    {
+      if (uri[i] =3D=3D '/')
+        {
+          if (i > 0 && uri[i-1] =3D=3D ':' && i < len-1 && uri[i+1] =3D=
=3D '/')
+            {
+              /* We have an absolute uri */
+              if (i =3D=3D 5 && strncmp("file", uri, 4) =3D=3D 0)
+                return 7; /* file:// */
+              else
+                {
+                  for (i +=3D 2; i < len; i++)
+                    if (uri[i] =3D=3D '/')
+                      return i;
+
+                  return len; /* Only a hostname is found */
+                }
+            }
+          else
+            return 0;
+        }
+    }
+
+  return 0;
+}
+
+/* From libsvn_subr/dirent_uri.c. */
+char *
+svn_uri_join(const char *base, const char *component, apr_pool_t *pool=
)
+{
+  apr_size_t blen =3D strlen(base);
+  apr_size_t clen =3D strlen(component);
+  char *path;
+
+  assert(svn_uri_is_canonical(base, pool));
+  assert(svn_uri_is_canonical(component, pool));
+
+  /* If either is empty return the other */
+  if (SVN_PATH_IS_EMPTY(base))
+    return apr_pmemdup(pool, component, clen + 1);
+  if (SVN_PATH_IS_EMPTY(component))
+    return apr_pmemdup(pool, base, blen + 1);
+
+  /* If the component is absolute, then return it.  */
+  if (svn_uri_is_absolute(component))
+    {
+      if (*component !=3D '/')
+        return apr_pmemdup(pool, component, clen + 1);
+      else
+        {
+          /* The uri is not absolute enough; use only the root from ba=
se */
+          apr_size_t n =3D uri_schema_root_length(base, blen);
+
+          path =3D apr_palloc(pool, n + clen + 1);
+
+          if (n > 0)
+            memcpy(path, base, n);
+
+          memcpy(path + n, component, clen + 1); /* Include '\0' */
+
+          return path;
+        }
+    }
+
+  if (blen =3D=3D 1 && base[0] =3D=3D '/')
+    blen =3D 0; /* Ignore base, just return separator + component */
+
+  /* Construct the new, combined path. */
+  path =3D apr_palloc(pool, blen + 1 + clen + 1);
+  memcpy(path, base, blen);
+  path[blen] =3D '/';
+  memcpy(path + blen + 1, component, clen + 1);
+
+  return path;
+}
+
+/* From libsvn_subr/dirent_uri.c. */
+static svn_boolean_t
+svn_relpath_is_canonical(const char *relpath,
+                         apr_pool_t *pool)
+{
+  const char *ptr =3D relpath, *seg =3D relpath;
+
+  /* RELPATH is canonical if it has:
+   *  - no '.' segments
+   *  - no start and closing '/'
+   *  - no '//'
+   */
+
+  if (*relpath =3D=3D '\0')
+    return TRUE;
+
+  if (*ptr =3D=3D '/')
+    return FALSE;
+
+  /* Now validate the rest of the path. */
+  while(1)
+    {
+      apr_size_t seglen =3D ptr - seg;
+
+      if (seglen =3D=3D 1 && *seg =3D=3D '.')
+        return FALSE;  /*  /./   */
+
+      if (*ptr =3D=3D '/' && *(ptr+1) =3D=3D '/')
+        return FALSE;  /*  //    */
+
+      if (! *ptr && *(ptr - 1) =3D=3D '/')
+        return FALSE;  /* foo/  */
+
+      if (! *ptr)
+        break;
+
+      if (*ptr =3D=3D '/')
+        ptr++;
+      seg =3D ptr;
+
+      while (*ptr && (*ptr !=3D '/'))
+        ptr++;
+    }
+
+  return TRUE;
+}
+
+/* From libsvn_subr/dirent_uri.c. */
+const char *
+svn_relpath_basename(const char *relpath,
+                     apr_pool_t *pool)
+{
+  apr_size_t len =3D strlen(relpath);
+  apr_size_t start;
+
+  assert(!pool || svn_relpath_is_canonical(relpath, pool));
+
+  start =3D len;
+  while (start > 0 && relpath[start - 1] !=3D '/')
+    --start;
+
+  if (pool)
+    return apr_pstrmemdup(pool, relpath + start, len - start);
+  else
+    return relpath + start;
+}
+
+/* From libsvn_subr/dirent_uri.c. */
+const char *
+svn_dirent_basename(const char *dirent, apr_pool_t *pool)
+{
+  apr_size_t len =3D strlen(dirent);
+  apr_size_t start;
+
+  assert(!pool || svn_dirent_is_canonical(dirent, pool));
+
+  if (svn_dirent_is_root(dirent, len))
+    return "";
+  else
+    {
+      start =3D len;
+      while (start > 0 && dirent[start - 1] !=3D '/'
+#ifdef SVN_USE_DOS_PATHS
+             && dirent[start - 1] !=3D ':'
+#endif
+            )
+        --start;
+    }
+
+  if (pool)
+    return apr_pstrmemdup(pool, dirent + start, len - start);
+  else
+    return dirent + start;
+}
+
+/* Locale insensitive tolower() for converting parts of dirents and ur=
ls
+   while canonicalizing.  From libsvn_subr/dirent_uri.c. */
+static char
+canonicalize_to_lower(char c)
+{
+  if (c < 'A' || c > 'Z')
+    return c;
+  else
+    return c - 'A' + 'a';
+}
+
+/* Locale insensitive toupper() for converting parts of dirents and ur=
ls
+   while canonicalizing.  From libsvn_subr/dirent_uri.c. */
+static char
+canonicalize_to_upper(char c)
+{
+  if (c < 'a' || c > 'z')
+    return c;
+  else
+    return c - 'a' + 'A';
+}
+
+
+/* Return the canonicalized version of PATH, of type TYPE, allocated i=
n
+ * POOL.  From libsvn_subr/dirent_uri.c.
+ */
+static const char *
+canonicalize(path_type_t type, const char *path, apr_pool_t *pool)
+{
+  char *canon, *dst;
+  const char *src;
+  apr_size_t seglen;
+  apr_size_t schemelen =3D 0;
+  apr_size_t canon_segments =3D 0;
+  svn_boolean_t url =3D FALSE;
+  char *schema_data =3D NULL;
+
+  /* "" is already canonical, so just return it; note that later code
+     depends on path not being zero-length.  */
+  if (SVN_PATH_IS_EMPTY(path))
+    return "";
+
+  dst =3D canon =3D apr_pcalloc(pool, strlen(path) + 1);
+
+  /* If this is supposed to be an URI and it starts with "scheme://", =
then
+     copy the scheme, host name, etc. to DST and set URL =3D TRUE. */
+  src =3D path;
+  if (type =3D=3D type_uri && *src !=3D '/')
+    {
+      while (*src && (*src !=3D '/') && (*src !=3D ':'))
+        src++;
+
+      if (*src =3D=3D ':' && *(src+1) =3D=3D '/' && *(src+2) =3D=3D '/=
')
+        {
+          const char *seg;
+
+          url =3D TRUE;
+
+          /* Found a scheme, convert to lowercase and copy to dst. */
+          src =3D path;
+          while (*src !=3D ':')
+            {
+              *(dst++) =3D canonicalize_to_lower((*src++));
+              schemelen++;
+            }
+          *(dst++) =3D ':';
+          *(dst++) =3D '/';
+          *(dst++) =3D '/';
+          src +=3D 3;
+          schemelen +=3D 3;
+
+          /* This might be the hostname */
+          seg =3D src;
+          while (*src && (*src !=3D '/') && (*src !=3D '@'))
+            src++;
+
+          if (*src =3D=3D '@')
+            {
+              /* Copy the username & password. */
+              seglen =3D src - seg + 1;
+              memcpy(dst, seg, seglen);
+              dst +=3D seglen;
+              src++;
+            }
+          else
+            src =3D seg;
+
+          /* Found a hostname, convert to lowercase and copy to dst. *=
/
+          while (*src && (*src !=3D '/'))
+            *(dst++) =3D canonicalize_to_lower((*src++));
+
+          /* Copy trailing slash, or null-terminator. */
+          *(dst) =3D *(src);
+
+          /* Move src and dst forward only if we are not
+           * at null-terminator yet. */
+          if (*src)
+            {
+              src++;
+              dst++;
+              schema_data =3D dst;
+            }
+
+          canon_segments =3D 1;
+        }
+    }
+
+  /* Copy to DST any separator or drive letter that must come before t=
he
+     first regular path segment. */
+  if (! url && type !=3D type_relpath)
+    {
+      src =3D path;
+      /* If this is an absolute path, then just copy over the initial
+         separator character. */
+      if (*src =3D=3D '/')
+        {
+          *(dst++) =3D *(src++);
+
+#ifdef SVN_USE_DOS_PATHS
+          /* On Windows permit two leading separator characters which =
means an
+           * UNC path. */
+          if ((type =3D=3D type_dirent) && *src =3D=3D '/')
+            *(dst++) =3D *(src++);
+#endif /* SVN_USE_DOS_PATHS */
+        }
+#ifdef SVN_USE_DOS_PATHS
+      /* On Windows the first segment can be a drive letter, which we =
normalize
+         to upper case. */
+      else if (type =3D=3D type_dirent &&
+               ((*src >=3D 'a' && *src <=3D 'z') ||
+                (*src >=3D 'A' && *src <=3D 'Z')) &&
+               (src[1] =3D=3D ':'))
+        {
+          *(dst++) =3D canonicalize_to_upper(*(src++));
+          /* Leave the ':' to be processed as (or as part of) a path s=
egment
+             by the following code block, so we need not care whether =
it has
+             a slash after it. */
+        }
+#endif /* SVN_USE_DOS_PATHS */
+    }
+
+  while (*src)
+    {
+      /* Parse each segment, find the closing '/' */
+      const char *next =3D src;
+      while (*next && (*next !=3D '/'))
+        ++next;
+
+      seglen =3D next - src;
+
+      if (seglen =3D=3D 0 || (seglen =3D=3D 1 && src[0] =3D=3D '.'))
+        {
+          /* Noop segment, so do nothing. */
+        }
+#ifdef SVN_USE_DOS_PATHS
+      /* If this is the first path segment of a file:// URI and it con=
tains a
+         windows drive letter, convert the drive letter to upper case.=
 */
+      else if (url && canon_segments =3D=3D 1 && seglen =3D=3D 2 &&
+               (strncmp(canon, "file:", 5) =3D=3D 0) &&
+               src[0] >=3D 'a' && src[0] <=3D 'z' && src[1] =3D=3D ':'=
)
+        {
+          *(dst++) =3D canonicalize_to_upper(src[0]);
+          *(dst++) =3D ':';
+          if (*next)
+            *(dst++) =3D *next;
+          canon_segments++;
+        }
+#endif /* SVN_USE_DOS_PATHS */
+      else
+        {
+          /* An actual segment, append it to the destination path */
+          if (*next)
+            seglen++;
+          memcpy(dst, src, seglen);
+          dst +=3D seglen;
+          canon_segments++;
+        }
+
+      /* Skip over trailing slash to the next segment. */
+      src =3D next;
+      if (*src)
+        src++;
+    }
+
+  /* Remove the trailing slash if there was at least one
+   * canonical segment and the last segment ends with a slash.
+   *
+   * But keep in mind that, for URLs, the scheme counts as a
+   * canonical segment -- so if path is ONLY a scheme (such
+   * as "https://") we should NOT remove the trailing slash. */
+  if ((canon_segments > 0 && *(dst - 1) =3D=3D '/')
+      && ! (url && path[schemelen] =3D=3D '\0'))
+    {
+      dst --;
+    }
+
+  *dst =3D '\0';
+
+#ifdef SVN_USE_DOS_PATHS
+  /* Skip leading double slashes when there are less than 2
+   * canon segments. UNC paths *MUST* have two segments. */
+  if ((type =3D=3D type_dirent) && canon[0] =3D=3D '/' && canon[1] =3D=
=3D '/')
+    {
+      if (canon_segments < 2)
+        return canon + 1;
+      else
+        {
+          /* Now we're sure this is a valid UNC path, convert the serv=
er name
+             (the first path segment) to lowercase as Windows treats i=
t as case
+             insensitive.
+             Note: normally the share name is treated as case insensit=
ive too,
+             but it seems to be possible to configure Samba to treat t=
hose as
+             case sensitive, so better leave that alone. */
+          dst =3D canon + 2;
+          while (*dst && *dst !=3D '/')
+            *(dst++) =3D canonicalize_to_lower(*dst);
+        }
+    }
+#endif /* SVN_USE_DOS_PATHS */
+
+  /* Check the normalization of characters in a uri */
+  if (schema_data)
+    {
+      int need_extra =3D 0;
+      src =3D schema_data;
+
+      while (*src)
+        {
+          switch (*src)
+            {
+              case '/':
+                break;
+              case '%':
+                if (!apr_isxdigit(*(src+1)) || !apr_isxdigit(*(src+2))=
)
+                  need_extra +=3D 2;
+                else
+                  src +=3D 2;
+                break;
+              default:
+                if (!svn_uri__char_validity[(unsigned char)*src])
+                  need_extra +=3D 2;
+                break;
+            }
+          src++;
+        }
+
+      if (need_extra > 0)
+        {
+          apr_size_t pre_schema_size =3D (apr_size_t)(schema_data - ca=
non);
+
+          dst =3D apr_palloc(pool, (apr_size_t)(src - canon) + need_ex=
tra + 1);
+          memcpy(dst, canon, pre_schema_size);
+          canon =3D dst;
+
+          dst +=3D pre_schema_size;
+        }
+      else
+        dst =3D schema_data;
+
+      src =3D schema_data;
+
+      while (*src)
+        {
+          switch (*src)
+            {
+              case '/':
+                *(dst++) =3D '/';
+                break;
+              case '%':
+                if (!apr_isxdigit(*(src+1)) || !apr_isxdigit(*(src+2))=
)
+                  {
+                    *(dst++) =3D '%';
+                    *(dst++) =3D '2';
+                    *(dst++) =3D '5';
+                  }
+                else
+                  {
+                    char digitz[3];
+                    int val;
+
+                    digitz[0] =3D *(++src);
+                    digitz[1] =3D *(++src);
+                    digitz[2] =3D 0;
+
+                    val =3D (int)strtol(digitz, NULL, 16);
+
+                    if (svn_uri__char_validity[(unsigned char)val])
+                      *(dst++) =3D (char)val;
+                    else
+                      {
+                        *(dst++) =3D '%';
+                        *(dst++) =3D canonicalize_to_upper(digitz[0]);
+                        *(dst++) =3D canonicalize_to_upper(digitz[1]);
+                      }
+                  }
+                break;
+              default:
+                if (!svn_uri__char_validity[(unsigned char)*src])
+                  {
+                    apr_snprintf(dst, 4, "%%%02X", (unsigned char)*src=
);
+                    dst +=3D 3;
+                  }
+                else
+                  *(dst++) =3D *src;
+                break;
+            }
+          src++;
+        }
+      *dst =3D '\0';
+    }
+
+  return canon;
+}
+
+/* From libsvn_subr/dirent_uri.c. */
+const char *
+svn_uri_canonicalize(const char *uri, apr_pool_t *pool)
+{
+  return canonicalize(type_uri, uri, pool);
+}
+
+/* New code (public domain). */
+svn_error_t *
+svn_io_remove_file2(const char *path,
+                   svn_boolean_t ignore_enoent,
+                   apr_pool_t *scratch_pool)
+{
+  svn_error_t *err =3D svn_io_remove_file(path, scratch_pool);
+  if (ignore_enoent && err && APR_STATUS_IS_ENOENT(err->apr_err))
+    {
+      svn_error_clear(err);
+      return SVN_NO_ERROR;
+    }
+  return err;
+}
+
+/* From libsvn_subr/cmdline.c. */
+svn_error_t *
+svn_cmdline__apply_config_options(apr_hash_t *config,
+                                  const apr_array_header_t *config_opt=
ions,
+                                  const char *prefix,
+                                  const char *argument_name)
+{
+  int i;
+
+  for (i =3D 0; i < config_options->nelts; i++)
+   {
+     svn_config_t *cfg;
+     svn_cmdline__config_argument_t *arg =3D
+                          APR_ARRAY_IDX(config_options, i,
+                                        svn_cmdline__config_argument_t=
 *);
+
+     cfg =3D apr_hash_get(config, arg->file, APR_HASH_KEY_STRING);
+
+     if (cfg)
+       {
+         svn_config_set(cfg, arg->section, arg->option, arg->value);
+       }
+     else
+       {
+         svn_error_t *err =3D svn_error_createf(SVN_ERR_CL_ARG_PARSING=
_ERROR, NULL,
+             _("Unrecognized file in argument of %s"), argument_name);
+
+         svn_handle_warning2(stderr, err, prefix);
+         svn_error_clear(err);
+       }
+    }
+
+  return SVN_NO_ERROR;
+}
+
+/* From libsvn_subr/cmdline.c. */
+svn_error_t *
+svn_cmdline__parse_config_option(apr_array_header_t *config_options,
+                                 const char *opt_arg,
+                                 apr_pool_t *pool)
+{
+  svn_cmdline__config_argument_t *config_option;
+  const char *first_colon, *second_colon, *equals_sign;
+  apr_size_t len =3D strlen(opt_arg);
+  if ((first_colon =3D strchr(opt_arg, ':')) && (first_colon !=3D opt_=
arg))
+    {
+      if ((second_colon =3D strchr(first_colon + 1, ':')) &&
+          (second_colon !=3D first_colon + 1))
+        {
+          if ((equals_sign =3D strchr(second_colon + 1, '=3D')) &&
+              (equals_sign !=3D second_colon + 1))
+            {
+              config_option =3D apr_pcalloc(pool, sizeof(*config_optio=
n));
+              config_option->file =3D apr_pstrndup(pool, opt_arg,
+                                                 first_colon - opt_arg=
);
+              config_option->section =3D apr_pstrndup(pool, first_colo=
n + 1,
+                                                    second_colon - fir=
st_colon - 1);
+              config_option->option =3D apr_pstrndup(pool, second_colo=
n + 1,
+                                                   equals_sign - secon=
d_colon -
+1);
+
+              if (! (strchr(config_option->option, ':')))
+                {
+                  config_option->value =3D apr_pstrndup(pool, equals_s=
ign + 1,
+                                                      opt_arg + len - =
equals_sign - 1);
+                  APR_ARRAY_PUSH(config_options, svn_cmdline__config_a=
rgument_t
+*)
+                                       =3D config_option;
+                  return SVN_NO_ERROR;
+                }
+            }
+        }
+    }
+  return svn_error_create(SVN_ERR_CL_ARG_PARSING_ERROR, NULL,
+                          _("Invalid syntax of argument of --config-op=
tion"));
+}
diff --git a/svn17_compat.h b/svn17_compat.h
new file mode 100644
index 0000000..2c48cd6
--- /dev/null
+++ b/svn17_compat.h
@@ -0,0 +1,179 @@
+/**
+ * @copyright
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *    This file is derived from code licensed to the Apache
+ *    Software Foundation (ASF) under one or more contributor
+ *    license agreements.  See the NOTICE file distributed with
+ *    this file for additional information regarding copyright
+ *    ownership.  The ASF licenses those portions to you under
+ *    the Apache License, Version 2.0 (the "License"); you may
+ *    not use those portions except in compliance with the
+ *    License.  You may obtain a copy of the License at
+ *
+ *       http://www.apache.org/licenses/LICENSE-2.0
+ *
+ *    Unless required by applicable law or agreed to in writing,
+ *    software distributed under the License is distributed on an
+ *    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
+ *    KIND, either express or implied.  See the License for the
+ *    specific language governing permissions and limitations
+ *    under the License.
+ *
+ *    Any code in this file not licensed from the ASF is
+ *    original code in the public domain.  You may freely use,
+ *    modify, distribute, and relicense such code.
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * @endcopyright
+ *
+ * @file compat.h
+ * @brief SVN 1.7 compatibility routines.
+ */
+
+#ifndef SVN17_COMPAT_H
+#define SVN17_COMPAT_H
+
+#include <apr.h>
+#include <apr_pools.h>
+
+#include <svn_types.h>
+
+/** Join a valid base uri (@a base) with a relative path or uri
+ * (@a component), allocating the result in @a pool. @a component need
+ * not be a single component: it can be a relative path or a '/'
+ * prefixed relative path to join component to the root path of @a bas=
e.
+ *
+ * If @a component is the empty path, then @a base will be copied and
+ * returned.
+ *
+ * If the @a component is an absolute uri, then it is copied and retur=
ned.
+ *
+ * If @a component starts with a '/' and @a base contains a scheme, th=
e
+ * scheme defined joining rules are applied.
+ *
+ * From svn_dirent_uri.h.
+ */
+char *
+svn_uri_join(const char *base,
+             const char *component,
+             apr_pool_t *pool);
+
+/** Get the basename of the specified canonicalized @a relpath.  The
+ * basename is defined as the last component of the relpath.  If the @=
a
+ * relpath has only one component then that is returned. The returned
+ * value will have no slashes in it.
+ *
+ * Example: svn_relpath_basename("/trunk/foo/bar") -> "bar"
+ *
+ * The returned basename will be allocated in @a pool. If @a
+ * pool is NULL a pointer to the basename in @a relpath is returned.
+ *
+ * @note If an empty string is passed, then an empty string will be re=
turned.
+ *
+ * From svn_dirent_uri.h.
+ */
+const char *
+svn_relpath_basename(const char *uri,
+                     apr_pool_t *pool);
+
+/** Gets the name of the specified canonicalized @a dirent as it is kn=
own
+ * within its parent directory. If the @a dirent is root, return "". T=
he
+ * returned value will not have slashes in it.
+ *
+ * Example: svn_dirent_basename("/foo/bar") -> "bar"
+ *
+ * The returned basename will be allocated in @a pool. If @a pool is N=
ULL
+ * a pointer to the basename in @a dirent is returned.
+ *
+ * @note If an empty string is passed, then an empty string will be re=
turned.
+ *
+ * From svn_dirent_uri.h.
+ */
+const char *
+svn_dirent_basename(const char *dirent,
+                    apr_pool_t *pool);
+
+/** Return a new uri like @a uri, but transformed such that some types
+ * of uri specification redundancies are removed.
+ *
+ * This involves collapsing redundant "/./" elements, removing
+ * multiple adjacent separator characters, removing trailing
+ * separator characters, and possibly other semantically inoperative
+ * transformations.
+ *
+ * If @a uri starts with a schema, this function also normalizes the
+ * escaping of the path component by unescaping characters that don't
+ * need escaping and escaping characters that do need escaping but
+ * weren't.
+ *
+ * This functions supports URLs.
+ *
+ * The returned uri may be statically allocated or allocated from @a p=
ool.
+ *
+ * From svn_dirent_uri.h.
+ */
+const char *
+svn_uri_canonicalize(const char *uri,
+                     apr_pool_t *pool);
+
+/** Remove file @a path, a utf8-encoded path.  This wraps apr_file_rem=
ove(),
+ * converting any error to a Subversion error. If @a ignore_enoent is =
TRUE, and
+ * the file is not present (APR_STATUS_IS_ENOENT returns TRUE), then n=
o
+ * error will be returned.
+ *
+ * From svn_io.h.
+ */
+svn_error_t *
+svn_io_remove_file2(const char *path,
+                   svn_boolean_t ignore_enoent,
+                   apr_pool_t *scratch_pool);
+
+/* From svn_private_config.h.
+ */
+#define PACKAGE_NAME "subversion"
+#define N_(x) x
+#include <locale.h>
+#include <libintl.h>
+#define _(x) dgettext(PACKAGE_NAME, x)
+
+/** Sets the config options in @a config_options, an apr array contain=
ing
+ * svn_cmdline__config_argument_t* elements to the configuration in @a=
 cfg,
+ * a hash mapping of <tt>const char *</tt> configuration file names to
+ * @c svn_config_t *'s. Write warnings to stderr.
+ *
+ * Use @a prefix as prefix and @a argument_name in warning messages.
+ *
+ * From private/svn_cmdline_private.h.
+ */
+svn_error_t *
+svn_cmdline__apply_config_options(apr_hash_t *config,
+                                  const apr_array_header_t *config_opt=
ions,
+                                  const char *prefix,
+                                  const char *argument_name);
+
+/** Container for config options parsed with svn_cmdline__parse_config=
_option
+ *
+ * From private/svn_cmdline_private.h.
+ */
+typedef struct svn_cmdline__config_argument_t
+{
+  const char *file;
+  const char *section;
+  const char *option;
+  const char *value;
+} svn_cmdline__config_argument_t;
+
+/** Parser for 'FILE:SECTION:OPTION=3D[VALUE]'-style option arguments.
+ *
+ * Parses @a opt_arg and places its value in @a config_options, an apr=
 array
+ * containing svn_cmdline__config_argument_t* elements, allocating the=
 option
+ * data in @a pool
+ *
+ * From private/svn_cmdline_private.h.
+ */
+svn_error_t *
+svn_cmdline__parse_config_option(apr_array_header_t *config_options,
+                                 const char *opt_arg,
+                                 apr_pool_t *pool);
+
+
+#endif /* SVN17_COMPAT_H */
diff --git a/svnrdump.c b/svnrdump.c
index daf826e..a320b24 100644
--- a/svnrdump.c
+++ b/svnrdump.c
@@ -30,15 +30,14 @@
 #include "svn_repos.h"
 #include "svn_path.h"
 #include "svn_utf.h"
-#include "svn_private_config.h"
 #include "svn_string.h"
 #include "svn_props.h"
+#include "svn_dirent_uri.h"
=20
+#include "svn17_compat.h"
 #include "dump_editor.h"
 #include "load_editor.h"
=20
-#include "private/svn_cmdline_private.h"
-
 static svn_opt_subcommand_t dump_cmd, load_cmd;
=20
 enum svn_svnrdump__longopt_t
diff --git a/svntest/main.py b/svntest/main.py
index 2c59101..3e938d6 100644
--- a/svntest/main.py
+++ b/svntest/main.py
@@ -149,15 +149,14 @@ def url2pathname(path):
 # The locations of the svn, svnadmin and svnlook binaries, relative to
 # the only scripts that import this file right now (they live in ../).
 # Use --bin to override these defaults.
-svn_binary =3D os.path.abspath('../../svn/svn' + _exe)
-svnadmin_binary =3D os.path.abspath('../../svnadmin/svnadmin' + _exe)
-svnlook_binary =3D os.path.abspath('../../svnlook/svnlook' + _exe)
-svnrdump_binary =3D os.path.abspath('../../svnrdump/svnrdump' + _exe)
-svnsync_binary =3D os.path.abspath('../../svnsync/svnsync' + _exe)
-svnversion_binary =3D os.path.abspath('../../svnversion/svnversion' + =
_exe)
-svndumpfilter_binary =3D os.path.abspath('../../svndumpfilter/svndumpf=
ilter' + \
-                                       _exe)
-entriesdump_binary =3D os.path.abspath('entries-dump' + _exe)
+svn_binary =3D 'svn'
+svnadmin_binary =3D 'svnadmin'
+svnlook_binary =3D 'svnlook'
+svnrdump_binary =3D os.path.abspath('./svnrdump' + _exe)
+svnsync_binary =3D 'svnsync'
+svnversion_binary =3D 'svnversion'
+svndumpfilter_binary =3D 'svndumpfilter'
+entriesdump_binary =3D 'entries-dump'
=20
 # Location to the pristine repository, will be calculated from test_ar=
ea_url
 # when we know what the user specified for --url.
--=20
1.7.2.1.544.ga752d.dirty
