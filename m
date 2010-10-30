From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [WIP RFC/PATCH] WIP: git-sh-i18n--envsubst for a correct eval_gettext
Date: Sat, 30 Oct 2010 15:22:43 +0000
Message-ID: <1288452163-814-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 30 17:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCDGm-0002Bw-9c
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 17:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab0J3PWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 11:22:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61230 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab0J3PWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 11:22:52 -0400
Received: by wyf28 with SMTP id 28so4091984wyf.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=l+Ld/AK82eEpgLAKCYG2FjbbYSxaTZnSlhC5tC2cgms=;
        b=R0coZ3W32t5d+yW996kZ00WtlqzlEl2EGgx+ZQTlaRSdsqXmO86ftxDTTf45ugn8sA
         Y+3Vl+KP1WPPuW95OwSLOwJCVgrDtm6kD9ZOScbvk59CJ8sdCXQYm5ZkWP4KR1ToliB9
         R4RpGGXhZn1CgtgnHhFJtLsX+BDnNxzM0/R5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=OULjyJpRKLH2IRl64YpUbL/QTSIvMZ3uKrbYw1pGrWCtNaeWw1tTh1dkcT1CEt5gI2
         /+ug0AFjb+gyaWu69BlZCTpf3/h5th4Z/epEyV0O7VQNVVQYtbolrSIRH1tApFtPocNH
         R21Yy3+N/fdnogUMt6+fj1UExxRvr9KJNs8bo=
Received: by 10.216.71.85 with SMTP id q63mr13462254wed.53.1288452170328;
        Sat, 30 Oct 2010 08:22:50 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id x12sm2446709weq.42.2010.10.30.08.22.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 08:22:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.309.g4cea8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160400>

t/t0201-gettext-fallbacks.sh: test for broken eval_gettext

Add a test for the broken eval_gettext() variable interpolation
behavior.

Reported-by: Johannes Sixt <j.sixt@viscovery.net>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>

git-sh-i18n.sh: use envsubst

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>

WIP: add a git-sh-i18n--envsubst

I can't figure out how to make the Makefile read from
git-sh-i18n--envsubst.c and produce git-sh-i18n--envsubst, not
git-git-sh-i18n--envsubst.

I also can't see how to make it available to git tests.

If I name it sh-i18n--envsubst.c I'll get linking errors (about
xrealloc).
---

Heading out so I thought I'd dump a WIP patch here and ask if anyone
knows how to solve this Makefile issue I'm having.

I wanted to call the two programs
/{git-sh-i18n.sh,git-sh-i18n--envsubst.c}, but maybe going that route
is the wrong thing to do?

 .gitignore                   |    1 +
 Makefile                     |    3 +
 git-sh-i18n--envsubst.c      |  392 ++++++++++++++++++++++++++++++++++=
++++++++
 git-sh-i18n.sh               |    3 +-
 t/t0201-gettext-fallbacks.sh |   23 +++
 5 files changed, 420 insertions(+), 2 deletions(-)
 create mode 100644 git-sh-i18n--envsubst.c

diff --git a/.gitignore b/.gitignore
index 80ca718..d2d9ec2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -126,6 +126,7 @@
 /git-send-email
 /git-send-pack
 /git-sh-i18n
+/git-sh-i18n--envsubst
 /git-sh-setup
 /git-shell
 /git-shortlog
diff --git a/Makefile b/Makefile
index e1650ba..cdfe6bc 100644
--- a/Makefile
+++ b/Makefile
@@ -435,6 +435,7 @@ PROGRAM_OBJS +=3D shell.o
 PROGRAM_OBJS +=3D show-index.o
 PROGRAM_OBJS +=3D upload-pack.o
 PROGRAM_OBJS +=3D http-backend.o
+PROGRAM_OBJS +=3D git-sh-i18n--envsubst.o
=20
 PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
=20
@@ -2016,6 +2017,8 @@ git-http-fetch$X: revision.o http.o http-walker.o=
 http-fetch.o $(GITLIBS)
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+git-sh-i18n--envsubst$X: git-sh-i18n--envsubst.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
)
=20
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
diff --git a/git-sh-i18n--envsubst.c b/git-sh-i18n--envsubst.c
new file mode 100644
index 0000000..3be7e8e
--- /dev/null
+++ b/git-sh-i18n--envsubst.c
@@ -0,0 +1,392 @@
+/* This is a modified version of
+   67d0871a8c:gettext-runtime/src/envsubst.c from the gettext.git
+   repository that does only the envsubst that we need in the
+   git-sh-i18n fallbacks.
+*/
+
+#include "git-compat-util.h"
+
+/* Substitution of environment variables in shell format strings.
+   Copyright (C) 2003-2007 Free Software Foundation, Inc.
+   Written by Bruno Haible <bruno@clisp.org>, 2003.
+
+   This program is free software; you can redistribute it and/or modif=
y
+   it under the terms of the GNU General Public License as published b=
y
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundat=
ion,
+   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA. =
 */
+
+#include <errno.h>
+#include <getopt.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+/* If true, substitution shall be performed on all variables.  */
+static bool all_variables;
+
+static void print_variables (const char *string);
+static void note_variables (const char *string);
+static void subst_from_stdin (void);
+
+int
+main (int argc, char *argv[])
+{
+  all_variables =3D true;
+  subst_from_stdin ();
+
+  exit (EXIT_SUCCESS);
+}
+
+/* Parse the string and invoke the callback each time a $VARIABLE or
+   ${VARIABLE} construct is seen, where VARIABLE is a nonempty sequenc=
e
+   of ASCII alphanumeric/underscore characters, starting with an ASCII
+   alphabetic/underscore character.
+   We allow only ASCII characters, to avoid dependencies w.r.t. the cu=
rrent
+   encoding: While "${\xe0}" looks like a variable access in ISO-8859-=
1
+   encoding, it doesn't look like one in the BIG5, BIG5-HKSCS, GBK, GB=
18030,
+   SHIFT_JIS, JOHAB encodings, because \xe0\x7d is a single character =
in these
+   encodings.  */
+static void
+find_variables (const char *string,
+		void (*callback) (const char *var_ptr, size_t var_len))
+{
+  for (; *string !=3D '\0';)
+    if (*string++ =3D=3D '$')
+      {
+	const char *variable_start;
+	const char *variable_end;
+	bool valid;
+	char c;
+
+	if (*string =3D=3D '{')
+	  string++;
+
+	variable_start =3D string;
+	c =3D *string;
+	if ((c >=3D 'A' && c <=3D 'Z') || (c >=3D 'a' && c <=3D 'z') || c =3D=
=3D '_')
+	  {
+	    do
+	      c =3D *++string;
+	    while ((c >=3D 'A' && c <=3D 'Z') || (c >=3D 'a' && c <=3D 'z')
+		   || (c >=3D '0' && c <=3D '9') || c =3D=3D '_');
+	    variable_end =3D string;
+
+	    if (variable_start[-1] =3D=3D '{')
+	      {
+		if (*string =3D=3D '}')
+		  {
+		    string++;
+		    valid =3D true;
+		  }
+		else
+		  valid =3D false;
+	      }
+	    else
+	      valid =3D true;
+
+	    if (valid)
+	      callback (variable_start, variable_end - variable_start);
+	  }
+      }
+}
+
+
+/* Print a variable to stdout, followed by a newline.  */
+static void
+print_variable (const char *var_ptr, size_t var_len)
+{
+  fwrite (var_ptr, var_len, 1, stdout);
+  putchar ('\n');
+}
+
+/* Print the variables contained in STRING to stdout, each one followe=
d by a
+   newline.  */
+static void
+print_variables (const char *string)
+{
+  find_variables (string, &print_variable);
+}
+
+
+/* Type describing list of immutable strings,
+   implemented using a dynamic array.  */
+typedef struct string_list_ty string_list_ty;
+struct string_list_ty
+{
+  const char **item;
+  size_t nitems;
+  size_t nitems_max;
+};
+
+/* Initialize an empty list of strings.  */
+static inline void
+string_list_init (string_list_ty *slp)
+{
+  slp->item =3D NULL;
+  slp->nitems =3D 0;
+  slp->nitems_max =3D 0;
+}
+
+/* Append a single string to the end of a list of strings.  */
+static inline void
+string_list_append (string_list_ty *slp, const char *s)
+{
+  /* Grow the list.  */
+  if (slp->nitems >=3D slp->nitems_max)
+    {
+      size_t nbytes;
+
+      slp->nitems_max =3D slp->nitems_max * 2 + 4;
+      nbytes =3D slp->nitems_max * sizeof (slp->item[0]);
+      slp->item =3D (const char **) xrealloc (slp->item, nbytes);
+    }
+
+  /* Add the string to the end of the list.  */
+  slp->item[slp->nitems++] =3D s;
+}
+
+/* Compare two strings given by reference.  */
+static int
+cmp_string (const void *pstr1, const void *pstr2)
+{
+  const char *str1 =3D *(const char **)pstr1;
+  const char *str2 =3D *(const char **)pstr2;
+
+  return strcmp (str1, str2);
+}
+
+/* Sort a list of strings.  */
+static inline void
+string_list_sort (string_list_ty *slp)
+{
+  if (slp->nitems > 0)
+    qsort (slp->item, slp->nitems, sizeof (slp->item[0]), cmp_string);
+}
+
+/* Test whether a string list contains a given string.  */
+static inline int
+string_list_member (const string_list_ty *slp, const char *s)
+{
+  size_t j;
+
+  for (j =3D 0; j < slp->nitems; ++j)
+    if (strcmp (slp->item[j], s) =3D=3D 0)
+      return 1;
+  return 0;
+}
+
+/* Test whether a sorted string list contains a given string.  */
+static int
+sorted_string_list_member (const string_list_ty *slp, const char *s)
+{
+  size_t j1, j2;
+
+  j1 =3D 0;
+  j2 =3D slp->nitems;
+  if (j2 > 0)
+    {
+      /* Binary search.  */
+      while (j2 - j1 > 1)
+	{
+	  /* Here we know that if s is in the list, it is at an index j
+	     with j1 <=3D j < j2.  */
+	  size_t j =3D (j1 + j2) >> 1;
+	  int result =3D strcmp (slp->item[j], s);
+
+	  if (result > 0)
+	    j2 =3D j;
+	  else if (result =3D=3D 0)
+	    return 1;
+	  else
+	    j1 =3D j + 1;
+	}
+      if (j2 > j1)
+	if (strcmp (slp->item[j1], s) =3D=3D 0)
+	  return 1;
+    }
+  return 0;
+}
+
+/* Destroy a list of strings.  */
+static inline void
+string_list_destroy (string_list_ty *slp)
+{
+  size_t j;
+
+  for (j =3D 0; j < slp->nitems; ++j)
+    free ((char *) slp->item[j]);
+  if (slp->item !=3D NULL)
+    free (slp->item);
+}
+
+
+/* Set of variables on which to perform substitution.
+   Used only if !all_variables.  */
+static string_list_ty variables_set;
+
+/* Adds a variable to variables_set.  */
+static void
+note_variable (const char *var_ptr, size_t var_len)
+{
+  char *string =3D xmalloc (var_len + 1);
+  memcpy (string, var_ptr, var_len);
+  string[var_len] =3D '\0';
+
+  string_list_append (&variables_set, string);
+}
+
+/* Stores the variables occurring in the string in variables_set.  */
+static void
+note_variables (const char *string)
+{
+  string_list_init (&variables_set);
+  find_variables (string, &note_variable);
+  string_list_sort (&variables_set);
+}
+
+
+static int
+do_getc ()
+{
+  int c =3D getc (stdin);
+
+  if (c =3D=3D EOF)
+    {
+      if (ferror (stdin))
+	error ("error while reading standard input");
+    }
+
+  return c;
+}
+
+static inline void
+do_ungetc (int c)
+{
+  if (c !=3D EOF)
+    ungetc (c, stdin);
+}
+
+/* Copies stdin to stdout, performing substitutions.  */
+static void
+subst_from_stdin ()
+{
+  static char *buffer;
+  static size_t bufmax;
+  static size_t buflen;
+  int c;
+
+  for (;;)
+    {
+      c =3D do_getc ();
+      if (c =3D=3D EOF)
+	break;
+      /* Look for $VARIABLE or ${VARIABLE}.  */
+      if (c =3D=3D '$')
+	{
+	  bool opening_brace =3D false;
+	  bool closing_brace =3D false;
+
+	  c =3D do_getc ();
+	  if (c =3D=3D '{')
+	    {
+	      opening_brace =3D true;
+	      c =3D do_getc ();
+	    }
+	  if ((c >=3D 'A' && c <=3D 'Z') || (c >=3D 'a' && c <=3D 'z') || c =3D=
=3D '_')
+	    {
+	      bool valid;
+
+	      /* Accumulate the VARIABLE in buffer.  */
+	      buflen =3D 0;
+	      do
+		{
+		  if (buflen >=3D bufmax)
+		    {
+		      bufmax =3D 2 * bufmax + 10;
+		      buffer =3D xrealloc (buffer, bufmax);
+		    }
+		  buffer[buflen++] =3D c;
+
+		  c =3D do_getc ();
+		}
+	      while ((c >=3D 'A' && c <=3D 'Z') || (c >=3D 'a' && c <=3D 'z')
+		     || (c >=3D '0' && c <=3D '9') || c =3D=3D '_');
+
+	      if (opening_brace)
+		{
+		  if (c =3D=3D '}')
+		    {
+		      closing_brace =3D true;
+		      valid =3D true;
+		    }
+		  else
+		    {
+		      valid =3D false;
+		      do_ungetc (c);
+		    }
+		}
+	      else
+		{
+		  valid =3D true;
+		  do_ungetc (c);
+		}
+
+	      if (valid)
+		{
+		  /* Terminate the variable in the buffer.  */
+		  if (buflen >=3D bufmax)
+		    {
+		      bufmax =3D 2 * bufmax + 10;
+		      buffer =3D xrealloc (buffer, bufmax);
+		    }
+		  buffer[buflen] =3D '\0';
+
+		  /* Test whether the variable shall be substituted.  */
+		  if (!all_variables
+		      && !sorted_string_list_member (&variables_set, buffer))
+		    valid =3D false;
+		}
+
+	      if (valid)
+		{
+		  /* Substitute the variable's value from the environment.  */
+		  const char *env_value =3D getenv (buffer);
+
+		  if (env_value !=3D NULL)
+		    fputs (env_value, stdout);
+		}
+	      else
+		{
+		  /* Perform no substitution at all.  Since the buffered input
+		     contains no other '$' than at the start, we can just
+		     output all the buffered contents.  */
+		  putchar ('$');
+		  if (opening_brace)
+		    putchar ('{');
+		  fwrite (buffer, buflen, 1, stdout);
+		  if (closing_brace)
+		    putchar ('}');
+		}
+	    }
+	  else
+	    {
+	      do_ungetc (c);
+	      putchar ('$');
+	      if (opening_brace)
+		putchar ('{');
+	    }
+	}
+      else
+	putchar (c);
+    }
+}
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index f8dd43a..b3b599a 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -55,8 +55,7 @@ then
 		}
=20
 		eval_gettext () {
-			gettext_eval=3D"printf '%s' \"$1\""
-			printf "%s" "`eval \"$gettext_eval\"`"
+			printf "%s" "$1" | /home/avar/g/git/git-git-sh-i18n--envsubst
 		}
 	fi
 else
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.s=
h
index 7a85d9b..682c602 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -46,4 +46,27 @@ test_expect_success NO_GETTEXT_POISON 'eval_gettext:=
 our eval_gettext() fallback
     test_cmp expect actual
 '
=20
+test_expect_success NO_GETTEXT_POISON 'eval_gettext: our eval_gettext(=
) fallback can interpolate whitespace variables' '
+    git_am_cmdline=3D"git am" &&
+    export git_am_cmdline &&
+    printf "test git am" >expect &&
+    eval_gettext "test \$git_am_cmdline" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success NO_GETTEXT_POISON 'eval_gettext: git am $cmdline b=
ug' '
+    cmdline=3D"git am -3" &&
+    export cmdline &&
+    cat >expect <<EOF &&
+When you have resolved this problem run "git am -3 --resolved".
+If you would prefer to skip this patch, instead run "git am -3 --skip"=
=2E
+To restore the original branch and stop patching run "git am -3 --abor=
t".
+EOF
+    eval_gettext "When you have resolved this problem run \"\$cmdline =
--resolved\".
+If you would prefer to skip this patch, instead run \"\$cmdline --skip=
\".
+To restore the original branch and stop patching run \"\$cmdline --abo=
rt\"." >actual &&
+    echo >>actual &&
+    test_cmp expect actual
+'
+
 test_done
--=20
1.7.3.2.309.g4cea8.dirty
