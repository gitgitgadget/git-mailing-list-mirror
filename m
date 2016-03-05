From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] git reset --hard gives clean working tree
Date: Sat, 5 Mar 2016 08:23:22 +0100
Message-ID: <56DA896A.3050201@web.de>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
 <1455207366-24892-1-git-send-email-tboegi@web.de>
 <xmqqy4arw089.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Sat Mar 05 08:23:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac6Yp-0003Ku-QF
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 08:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbcCEHXc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2016 02:23:32 -0500
Received: from mout.web.de ([212.227.17.12]:56386 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbcCEHXa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 02:23:30 -0500
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LqDYi-1ZyO5r0KgK-00djcK; Sat, 05 Mar 2016 08:23:23
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <xmqqy4arw089.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:urJ3TsW3c7fGoqKjW+zEOK5E8ZCodu04znAJxflXgax/GPv9mfl
 Q5isvgYOX0L2QBZKUm9L+GSfAZutp/Y7MGjYfSp+pbWxY2H2L6YRePkwoFIT0uewHTzvwk9
 PkwCKwQ+8iBo16tA3+gEnVuKkkfQ+7LMEwvRNMAoN6ePmnXogsvxwhTVf+wSA17SoGzPn/V
 fXzg595i0H5+5jMLioXAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:36D+0fRhQ80=:CoAj2QSUCBSf2I5FLN93T9
 KY7fbv8I6WEhHbU+WBI4u8Py0O5bGIP0sjFYIbWZexjrE9YlKxSJfMtcwEsZ2y69bluur5JeJ
 6OufQTICifqtKVzrK4o5129h95tkvoiRhY2Ef7aXxgTalhIfxFaaesdU6Hu5Ur6Xl76DhsWk2
 5x2xKXThiHpk6Jehcjb7gMNrGrFemgRNX8Vixwqvn7L0jQMI/28sk5cKlR/wnWAKfWsqMQSO1
 jNq8stIqW9qj8fD4ipf/1i+3xqPaUgdWax8xS9d7ykyUJ+AG86soynUUdrUCbhW1u/7iKqMz1
 ifVkLppqk2qdADgsq8t+Y4QZpu9Etjy8ao9UtlffEJ0mv90CUMDBA7UTKirqpGiu6Z+1YT5+e
 V0kEye4A6bGWuAWOSyLIdzRp579sr3krK+Asy5UuGHuO8BpjesEZfu+4ZMUxXkT8S1/G6tLAB
 MaS47S91Xm0PuegGZmQl2v2vpT5ASCW8/9R4jopSQS3LpyIaZld5VZ4CfKmm2ojZoRjhnx4kk
 9no93OnRdLmq34han9dQEa6Ao9ZiLJ+a9fvpSi8UdAfZ+19dbYy2ehj20ixD9JmFl4cMVHtf3
 WpzF1nroOiWfrBh6e/PA0Zbmi/FzZAe4XBoKAv3VDcwTckcUGYqXaeiuSaJj3HqnY9RrkQqCy
 wZPcM2jbdj3ailw2fIxLR0K4P1RU2LIN7Nqjc0m+WHbOUr1Ge4khUnNs6gb3RHunzwFmLBnA9
 JEfjn1/JkBlcXY2vmgcz8pM/URcEOrS41iLCFHpwaJ/jaQJwuJpvaVM+EX5GMRw7wkN5d/U7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288299>



On 11.02.16 19:49, Junio C Hamano wrote:
> tboegi@web.de writes:
>
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>
>> We define the working tree file is clean if either:
>>
>>   * the result of running convert_to_git() on the working tree
>>     contents matches what is in the index (because that would mean
>>     doing another "git add" on the path is a no-op); OR
>>
>>   * the result of running convert_to_working_tree() on the content
>>     in the index matches what is in the working tree (because that
>>     would mean doing another "git checkout -f" on the path is a
>>     no-op).
>>
>> Add an extra check in ce_compare_data() in read_cache.c, and adjust
>> the test cases in t0025:
>> When a file has CRLF in the index, and is checked out into the worki=
ng tree,
>> but left unchabged, it is not normalized at the next commit.
>> Whenever the file is changed in the working tree, a line is added/de=
leted
>> or dos2unix is run, it may be normalized at the next commit,
>> depending on .gitattributes.
>>
>> This patch is a result of a longer discussion on the mailing list,
>> how to fix the flaky t0025.
> Currently, the codepaths that want to stop if it would lose
> information from the index and/or the working tree for the path run
> an equivalent of "diff-files path" to see there is any difference.
> This indeed is overly strict for a path that has contents in the
> index that wouldn't have been created by "clean" conversion (I am
> using this word to mean anything convert_to_git() does, not limited
> to the "clean" filter).
>
> And it is sensible to allow them to proceed if the contents in the
> working tree file for the path match what would be created by
> "smudge" conversion of the contents in the index.
>
> But breaking "diff-files" is not the right way to do so.  Teaching
> "Am I safe to proceed" callers that paths that do not pass
> "diff-files" test may still be safe to work on is.
>
> I did not continue the approach I illustrated because I realized and
> finally convinced myself that touching ce_compare_data() is a wrong
> solution--it breaks "diff-files".
>
> Imagine if you have contents in the index that wouldn't have been
> left by a "clean" conversion of what is in the working tree.  You
> then run "git checkout -f".  Now the contents in the working tree
> will still not convert back to what is in the index with another
> "clean" conversion, but it should pass the "Am I safe to proceed"
> check, namely, it matches what convert_to_worktree() would give.
>
> But imagine further what would happen when you add an extra blank
> line at the end of the file in the working tree (i.e. "echo >>file")
> and then run "diff-files -p".
>
> The illustration patch I gave broke "diff-files" in such a way that
> before such an addition of an extra blank line, it would have said
> "No changes".  And if you run "diff-files" after adding that extra
> blank line, you will see whole bunch of changes, not just the extra
> blank line at the end.
>
> This is sufficient to convince me that the approach is broken.
[]
Would something like this make sense?
(The main part is in diff.c, the rest needs some polishing)

commit e494c31fd2f0f8a638ff14d1b8ae3f3a6d56a107
Author: Torsten B=C3=B6gershausen <tboegi@web.de>
Date:   Sat Mar 5 07:51:08 2016 +0100

    Text files needs to be normalized before diffing
  =20
    Whenever a text file is stored with CRLF in the index, Git changes
    CRLF into LF at the next commit.
    (text file means the attribute "text" or "crlf" of "eol" is set).
  =20
    "git diff" reports that all lines with CRLF in the index as changed=
 to LF.
    After cloning a repo, the work tree is not considered clean by Git,=
 even if
    the user didn't change a single line.
  =20
    Avoid to report lines as changed by converting the content from the=
 index into
    LF before running diff.

diff --git a/convert.c b/convert.c
index f524b8d..af8248d 100644
--- a/convert.c
+++ b/convert.c
@@ -231,9 +231,9 @@ static int has_cr_in_index(const char *path)
     return has_cr;
 }
=20
-static int crlf_to_git(const char *path, const char *src, size_t len,
-               struct strbuf *buf,
-               enum crlf_action crlf_action, enum safe_crlf checksafe)
+static int crlf_to_git_internal(const char *path, const char *src, siz=
e_t len,
+                struct strbuf *buf,
+                enum crlf_action crlf_action, enum safe_crlf checksafe=
)
 {
     struct text_stat stats;
     char *dst;
@@ -852,7 +852,17 @@ const char *get_convert_attr_ascii(const char *pat=
h)
     return "";
 }
=20
-int convert_to_git(const char *path, const char *src, size_t len,
+int convert_crlf_to_git(const char *path, const char *src, size_t len,
+            struct strbuf *buf,
+            enum safe_crlf checksafe)
+{
+    struct conv_attrs ca;
+    convert_attrs(&ca, path);
+    return crlf_to_git_internal(path, src, len, buf,
+                    ca.crlf_action, checksafe);
+
+}
+    int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
     int ret =3D 0;
@@ -874,7 +884,7 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
         src =3D dst->buf;
         len =3D dst->len;
     }
-    ret |=3D crlf_to_git(path, src, len, dst, ca.crlf_action, checksaf=
e);
+    ret |=3D crlf_to_git_internal(path, src, len, dst, ca.crlf_action,=
 checksafe);
     if (ret && dst) {
         src =3D dst->buf;
         len =3D dst->len;
@@ -894,7 +904,7 @@ void convert_to_git_filter_fd(const char *path, int=
 fd, struct strbuf *dst,
     if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
         die("%s: clean filter '%s' failed", path, ca.drv->name);
=20
-    crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksa=
fe);
+    crlf_to_git_internal(path, dst->buf, dst->len, dst, ca.crlf_action=
, checksafe);
     ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
=20
diff --git a/convert.h b/convert.h
index ccf436b..11eff02 100644
--- a/convert.h
+++ b/convert.h
@@ -52,6 +52,9 @@ extern void convert_to_git_filter_fd(const char *path=
, int fd,
                      struct strbuf *dst,
                      enum safe_crlf checksafe);
 extern int would_convert_to_git_filter_fd(const char *path);
+extern int convert_crlf_to_git(const char *path, const char *src, size=
_t len,
+                   struct strbuf *buf,
+                   enum safe_crlf checksafe);
=20
 /*****************************************************************
  *
diff --git a/diff.c b/diff.c
index 059123c..8710a36 100644
--- a/diff.c
+++ b/diff.c
@@ -2730,6 +2730,7 @@ static int diff_populate_gitlink(struct diff_file=
spec *s, int size_only)
  */
 int diff_populate_filespec(struct diff_filespec *s, unsigned int flags=
)
 {
+    struct strbuf buf =3D STRBUF_INIT;
     int size_only =3D flags & CHECK_SIZE_ONLY;
     int err =3D 0;
     /*
@@ -2756,7 +2757,6 @@ int diff_populate_filespec(struct diff_filespec *=
s, unsigned int flags)
=20
     if (!s->sha1_valid ||
         reuse_worktree_file(s->path, s->sha1, 0)) {
-        struct strbuf buf =3D STRBUF_INIT;
         struct stat st;
         int fd;
=20
@@ -2826,6 +2826,12 @@ int diff_populate_filespec(struct diff_filespec =
*s, unsigned int flags)
         if (!s->data)
             die("unable to read %s", sha1_to_hex(s->sha1));
         s->should_free =3D 1;
+        if (convert_crlf_to_git(s->path, s->data, s->size,
+                    &buf, SAFE_CRLF_FALSE)) {
+            size_t size =3D 0;
+            s->data =3D strbuf_detach(&buf, &size);
+            s->size =3D size;
+        }
     }
     return 0;
 }
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index c164b46..dd1645b 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -39,7 +39,7 @@ test_expect_success 'default settings cause no change=
s' '
     test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
-test_expect_success 'crlf=3Dtrue causes a CRLF file to be normalized' =
'
+test_expect_success 'crlf=3Dtrue on a CRLF file git diff is empty' '
=20
     # Backwards compatibility check
     rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
@@ -49,19 +49,18 @@ test_expect_success 'crlf=3Dtrue causes a CRLF file=
 to be normalized' '
     # Note, "normalized" means that git will normalize it if added
     has_cr CRLFonly &&
     CRLFonlydiff=3D$(git diff CRLFonly) &&
-    test -n "$CRLFonlydiff"
+    test -z "$CRLFonlydiff"
 '
=20
-test_expect_success 'text=3Dtrue causes a CRLF file to be normalized' =
'
+test_expect_success 'eol=3Dcrlf gives CRLF with no diff' '
=20
     rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-    echo "CRLFonly text" > .gitattributes &&
+    echo "CRLFonly text eol=3Dcrlf" > .gitattributes &&
     git read-tree --reset -u HEAD &&
-
-    # Note, "normalized" means that git will normalize it if added
-    has_cr CRLFonly &&
-    CRLFonlydiff=3D$(git diff CRLFonly) &&
-    test -n "$CRLFonlydiff"
+    >expect &&
+    git diff CRLFonly | tr "\015" Q >actual &&
+    test_cmp expect actual &&
+    has_cr CRLFonly
 '
=20
 test_expect_success 'eol=3Dcrlf gives a normalized file CRLFs with aut=
ocrlf=3Dfalse' '
@@ -114,7 +113,7 @@ test_expect_success 'autocrlf=3Dtrue does not norma=
lize CRLF files' '
     test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
-test_expect_success 'text=3Dauto, autocrlf=3Dtrue _does_ normalize CRL=
=46 files' '
+test_expect_success 'text=3Dauto, autocrlf=3Dtrue git diff is empty' '
=20
     rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
     git config core.autocrlf true &&
@@ -126,7 +125,7 @@ test_expect_success 'text=3Dauto, autocrlf=3Dtrue _=
does_ normalize CRLF files' '
     LFonlydiff=3D$(git diff LFonly) &&
     CRLFonlydiff=3D$(git diff CRLFonly) &&
     LFwithNULdiff=3D$(git diff LFwithNUL) &&
-    test -z "$LFonlydiff" -a -n "$CRLFonlydiff" -a -z "$LFwithNULdiff"
+    test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
 test_expect_success 'text=3Dauto, autocrlf=3Dtrue does not normalize b=
inary files' '
