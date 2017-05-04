Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E4D207D6
	for <e@80x24.org>; Thu,  4 May 2017 22:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbdEDWBj (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 18:01:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33926 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdEDWBh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 18:01:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id z129so6217107wmb.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BB7kYSWrhRVMv6RtLbVJ3Q8J+iou7mqr/iM13ki7zCc=;
        b=X/VCshJR09mO9QPWlWMXWxTHKnv/pdp7P/mOmwcujrB4MI7M/xo93v+hRqzh8Vkw5d
         WjTSdtfAgrf7wgWEj+EAqtOnz4JXZUVjJROBMS8CeRjJ9K/mbkFBRJ7gv8oFYZSO2k5J
         aVNnXtzQGPHCyNfR5L0TPW83FwG2bAGQ/w6jDdbjqg1k3/H2sxTJ+d6DQQH1L7/VT1il
         VTVXmdS3208LAtw16JJUW3WS4emVJoisXjumzXNVgp82ragIfvpuWecrfOzR3T0ZRDgs
         VwWNgT8+TlhT5/S4t+QfdM1Pofcz8y8etcdSK9Sc2HKvyBWodII62BYzWM/r3lKgyxgl
         YTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BB7kYSWrhRVMv6RtLbVJ3Q8J+iou7mqr/iM13ki7zCc=;
        b=ndoPqniSV5ofUfTCL9Hy7yxtN7DmSP3aqn39EZtb6j6r1lDbIjBFqQFnlhxiXwrvv2
         vf84vLqwN440bq6MgAgRehFo2pml+EM/NoJYdtwh+iOYj2ukY7APJ1SQzT1IIReDSndm
         3oQ8c7KnUcBAqaVQrx/1anpMVgYIgNQLzLUqwelGJ4HhFQLueAwQ22KTZz7sHM45A0yp
         c3NF61DMIiGB4KmAP9hL09otIDwxGCKfMLj2WYEE2gzUl3MMys3eIO00O/Agjo6tpvas
         4pQbth6rS5uMnwGurQfEuQZl69elEgwfjFcr+iL3abGqvHtp40oc1Hy+CBRXrzaxgtTq
         hCXw==
X-Gm-Message-State: AN3rC/78LEeTsJFV5YVJTfYFkhmKLnvXlV0pePAMAE5HC0wh7LiWkxpz
        cYmLSC/dVPPSPQ==
X-Received: by 10.28.66.157 with SMTP id k29mr3639981wmi.84.1493935294341;
        Thu, 04 May 2017 15:01:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w136sm2424680wmd.0.2017.05.04.15.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 15:01:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?UTF-8?q?Ond=C5=99ej=20B=C3=ADlka?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/7] fixup! compat/regex: update the gawk regex engine from upstream
Date:   Thu,  4 May 2017 22:00:42 +0000
Message-Id: <20170504220043.25702-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170504220043.25702-1-avarab@gmail.com>
References: <20170504220043.25702-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 compat/regex/regex.h   | 120 +++++++++++++-----------
 compat/regex/regexec.c | 242 +++++++++++++++++++++++++------------------------
 2 files changed, 193 insertions(+), 169 deletions(-)

diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index 61c9683872..b602b5567f 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -1,10 +1,13 @@
-#include <stdio.h>
-#include <stddef.h>
+/*
+ * This is git.git's copy of gawk.git's regex engine. Please see that
+ * project for the latest version & to submit patches to this code,
+ * and git.git's compat/regex/README for information on how git's copy
+ * of this code is maintained.
+ */
 
 /* Definitions for data structures and routines for the regular
    expression library.
-   Copyright (C) 1985,1989-93,1995-98,2000,2001,2002,2003,2005,2006,2008
-   Free Software Foundation, Inc.
+   Copyright (C) 1985, 1989-2016 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
@@ -18,9 +21,8 @@
    Lesser General Public License for more details.
 
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
 #ifndef _REGEX_H
 #define _REGEX_H 1
@@ -75,10 +77,10 @@ typedef unsigned long int reg_syntax_t;
 /* If this bit is set, then ^ and $ are always anchors (outside bracket
      expressions, of course).
    If this bit is not set, then it depends:
-        ^  is an anchor if it is at the beginning of a regular
-           expression or after an open-group or an alternation operator;
-        $  is an anchor if it is at the end of a regular expression, or
-           before a close-group or an alternation operator.
+	^  is an anchor if it is at the beginning of a regular
+	   expression or after an open-group or an alternation operator;
+	$  is an anchor if it is at the end of a regular expression, or
+	   before a close-group or an alternation operator.
 
    This bit could be (re)combined with RE_CONTEXT_INDEP_OPS, because
    POSIX draft 11.2 says that * etc. in leading positions is undefined.
@@ -158,10 +160,18 @@ typedef unsigned long int reg_syntax_t;
    If not set, then the GNU regex operators are recognized. */
 # define RE_NO_GNU_OPS (RE_NO_POSIX_BACKTRACKING << 1)
 
+/* If this bit is set, turn on internal regex debugging.
+   If not set, and debugging was on, turn it off.
+   This only works if regex.c is compiled -DDEBUG.
+   We define this bit always, so that all that's needed to turn on
+   debugging is to recompile regex.c; the calling code can always have
+   this bit set, and it won't affect anything in the normal case. */
+# define RE_DEBUG (RE_NO_GNU_OPS << 1)
+
 /* If this bit is set, a syntactically invalid interval is treated as
    a string of ordinary characters.  For example, the ERE 'a{1' is
    treated as 'a\{1'.  */
-# define RE_INVALID_INTERVAL_ORD (RE_NO_GNU_OPS << 1)
+# define RE_INVALID_INTERVAL_ORD (RE_DEBUG << 1)
 
 /* If this bit is set, then ignore case when matching.
    If not set, then case is significant.  */
@@ -178,7 +188,7 @@ typedef unsigned long int reg_syntax_t;
 
 /* If this bit is set, then no_sub will be set to 1 during
    re_compile_pattern.  */
-#define RE_NO_SUB (RE_CONTEXT_INVALID_DUP << 1)
+# define RE_NO_SUB (RE_CONTEXT_INVALID_DUP << 1)
 #endif
 
 /* This global variable defines the particular regexp syntax to use (for
@@ -199,13 +209,14 @@ extern reg_syntax_t re_syntax_options;
    | RE_NO_BK_PARENS              | RE_NO_BK_REFS			\
    | RE_NO_BK_VBAR                | RE_NO_EMPTY_RANGES			\
    | RE_DOT_NEWLINE		  | RE_CONTEXT_INDEP_ANCHORS		\
+   | RE_CHAR_CLASSES							\
    | RE_UNMATCHED_RIGHT_PAREN_ORD | RE_NO_GNU_OPS)
 
 #define RE_SYNTAX_GNU_AWK						\
   ((RE_SYNTAX_POSIX_EXTENDED | RE_BACKSLASH_ESCAPE_IN_LISTS		\
-   | RE_INVALID_INTERVAL_ORD)						\
+    | RE_INVALID_INTERVAL_ORD)						\
    & ~(RE_DOT_NOT_NULL | RE_CONTEXT_INDEP_OPS				\
-       | RE_CONTEXT_INVALID_OPS ))
+      | RE_CONTEXT_INVALID_OPS ))
 
 #define RE_SYNTAX_POSIX_AWK						\
   (RE_SYNTAX_POSIX_EXTENDED | RE_BACKSLASH_ESCAPE_IN_LISTS		\
@@ -323,7 +334,7 @@ typedef enum
   /* POSIX regcomp return error codes.  (In the order listed in the
      standard.)  */
   REG_BADPAT,		/* Invalid pattern.  */
-  REG_ECOLLATE,		/* Inalid collating element.  */
+  REG_ECOLLATE,		/* Invalid collating element.  */
   REG_ECTYPE,		/* Invalid character class name.  */
   REG_EESCAPE,		/* Trailing backslash.  */
   REG_ESUBREG,		/* Invalid back reference.  */
@@ -343,9 +354,9 @@ typedef enum
 
 /* This data structure represents a compiled pattern.  Before calling
    the pattern compiler, the fields `buffer', `allocated', `fastmap',
-   `translate', and `no_sub' can be set.  After the pattern has been
-   compiled, the `re_nsub' field is available.  All other fields are
-   private to the regex routines.  */
+   and `translate' can be set.  After the pattern has been compiled,
+   the fields `re_nsub', `not_bol' and `not_eol' are available.  All
+   other fields are private to the regex routines.  */
 
 #ifndef RE_TRANSLATE_TYPE
 # define __RE_TRANSLATE_TYPE unsigned char *
@@ -466,19 +477,24 @@ typedef struct
 #ifdef __USE_GNU
 /* Sets the current default syntax to SYNTAX, and return the old syntax.
    You can also simply assign to the `re_syntax_options' variable.  */
-extern reg_syntax_t re_set_syntax (reg_syntax_t __syntax);
+extern reg_syntax_t re_set_syntax (reg_syntax_t syntax);
 
 /* Compile the regular expression PATTERN, with length LENGTH
    and syntax given by the global `re_syntax_options', into the buffer
-   BUFFER.  Return NULL if successful, and an error string if not.  */
-extern const char *re_compile_pattern (const char *__pattern, size_t __length,
-				       struct re_pattern_buffer *__buffer);
+   BUFFER.  Return NULL if successful, and an error string if not.
+
+   To free the allocated storage, you must call `regfree' on BUFFER.
+   Note that the translate table must either have been initialised by
+   `regcomp', with a malloc'ed value, or set to NULL before calling
+   `regfree'.  */
+extern const char *re_compile_pattern (const char *pattern, size_t length,
+				       struct re_pattern_buffer *buffer);
 
 
 /* Compile a fastmap for the compiled pattern in BUFFER; used to
    accelerate searches.  Return 0 if successful and -2 if was an
    internal error.  */
-extern int re_compile_fastmap (struct re_pattern_buffer *__buffer);
+extern int re_compile_fastmap (struct re_pattern_buffer *buffer);
 
 
 /* Search in the string STRING (with length LENGTH) for the pattern
@@ -486,30 +502,30 @@ extern int re_compile_fastmap (struct re_pattern_buffer *__buffer);
    characters.  Return the starting position of the match, -1 for no
    match, or -2 for an internal error.  Also return register
    information in REGS (if REGS and BUFFER->no_sub are nonzero).  */
-extern int re_search (struct re_pattern_buffer *__buffer, const char *__cstring,
-		      int __length, int __start, int __range,
-		      struct re_registers *__regs);
+extern int re_search (struct re_pattern_buffer *buffer, const char *c_string,
+		      int length, int start, int range,
+		      struct re_registers *regs);
 
 
 /* Like `re_search', but search in the concatenation of STRING1 and
    STRING2.  Also, stop searching at index START + STOP.  */
-extern int re_search_2 (struct re_pattern_buffer *__buffer,
-			const char *__string1, int __length1,
-			const char *__string2, int __length2, int __start,
-			int __range, struct re_registers *__regs, int __stop);
+extern int re_search_2 (struct re_pattern_buffer *buffer,
+			const char *string1, int length1,
+			const char *string2, int length2, int start,
+			int range, struct re_registers *regs, int stop);
 
 
 /* Like `re_search', but return how many characters in STRING the regexp
    in BUFFER matched, starting at position START.  */
-extern int re_match (struct re_pattern_buffer *__buffer, const char *__cstring,
-		     int __length, int __start, struct re_registers *__regs);
+extern int re_match (struct re_pattern_buffer *buffer, const char *c_string,
+		     int length, int start, struct re_registers *regs);
 
 
 /* Relates to `re_match' as `re_search_2' relates to `re_search'.  */
-extern int re_match_2 (struct re_pattern_buffer *__buffer,
-		       const char *__string1, int __length1,
-		       const char *__string2, int __length2, int __start,
-		       struct re_registers *__regs, int __stop);
+extern int re_match_2 (struct re_pattern_buffer *buffer,
+		       const char *string1, int length1,
+		       const char *string2, int length2, int start,
+		       struct re_registers *regs, int stop);
 
 
 /* Set REGS to hold NUM_REGS registers, storing them in STARTS and
@@ -524,13 +540,13 @@ extern int re_match_2 (struct re_pattern_buffer *__buffer,
    Unless this function is called, the first search or match using
    PATTERN_BUFFER will allocate its own register data, without
    freeing the old data.  */
-extern void re_set_registers (struct re_pattern_buffer *__buffer,
-			      struct re_registers *__regs,
-			      unsigned int __num_regs,
-			      regoff_t *__starts, regoff_t *__ends);
+extern void re_set_registers (struct re_pattern_buffer *buffer,
+			      struct re_registers *regs,
+			      unsigned int num_regs,
+			      regoff_t *starts, regoff_t *ends);
 #endif	/* Use GNU */
 
-#if defined _REGEX_RE_COMP || (defined _LIBC && defined __USE_BSD)
+#if defined _REGEX_RE_COMP || (defined _LIBC && defined __USE_MISC)
 # ifndef _CRAY
 /* 4.2 bsd compatibility.  */
 extern char *re_comp (const char *);
@@ -560,19 +576,19 @@ extern int re_exec (const char *);
 #endif
 
 /* POSIX compatibility.  */
-extern int regcomp (regex_t *__restrict __preg,
-		    const char *__restrict __pattern,
-		    int __cflags);
+extern int regcomp (regex_t *__restrict preg,
+		    const char *__restrict pattern,
+		    int cflags);
 
-extern int regexec (const regex_t *__restrict __preg,
-		    const char *__restrict __cstring, size_t __nmatch,
-		    regmatch_t __pmatch[__restrict_arr],
-		    int __eflags);
+extern int regexec (const regex_t *__restrict preg,
+		    const char *__restrict c_string, size_t nmatch,
+		    regmatch_t pmatch[__restrict_arr],
+		    int eflags);
 
-extern size_t regerror (int __errcode, const regex_t *__restrict __preg,
-			char *__restrict __errbuf, size_t __errbuf_size);
+extern size_t regerror (int errcode, const regex_t *__restrict preg,
+			char *__restrict errbuf, size_t errbuf_size);
 
-extern void regfree (regex_t *__preg);
+extern void regfree (regex_t *preg);
 
 
 #ifdef __cplusplus
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index eb5e1d4439..c79ff38b1c 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -1,5 +1,12 @@
+/*
+ * This is git.git's copy of gawk.git's regex engine. Please see that
+ * project for the latest version & to submit patches to this code,
+ * and git.git's compat/regex/README for information on how git's copy
+ * of this code is maintained.
+ */
+
 /* Extended regular expression matching and search library.
-   Copyright (C) 2002-2005, 2007, 2009, 2010 Free Software Foundation, Inc.
+   Copyright (C) 2002-2016 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Isamu Hasegawa <isamu@yamato.ibm.com>.
 
@@ -14,9 +21,12 @@
    Lesser General Public License for more details.
 
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifdef HAVE_STDINT_H
+#include <stdint.h>
+#endif /* HAVE_STDINT_H */
 
 static reg_errcode_t match_ctx_init (re_match_context_t *cache, int eflags,
 				     int n) internal_function;
@@ -40,18 +50,18 @@ static reg_errcode_t re_search_internal (const regex_t *preg,
 					 const char *string, int length,
 					 int start, int range, int stop,
 					 size_t nmatch, regmatch_t pmatch[],
-					 int eflags);
+					 int eflags) internal_function;
 static int re_search_2_stub (struct re_pattern_buffer *bufp,
 			     const char *string1, int length1,
 			     const char *string2, int length2,
 			     int start, int range, struct re_registers *regs,
-			     int stop, int ret_len);
+			     int stop, int ret_len) internal_function;
 static int re_search_stub (struct re_pattern_buffer *bufp,
 			   const char *string, int length, int start,
 			   int range, int stop, struct re_registers *regs,
-			   int ret_len);
+			   int ret_len) internal_function;
 static unsigned re_copy_regs (struct re_registers *regs, regmatch_t *pmatch,
-			      int nregs, int regs_allocated);
+			      int nregs, int regs_allocated) internal_function;
 static reg_errcode_t prune_impossible_nodes (re_match_context_t *mctx);
 static int check_matching (re_match_context_t *mctx, int fl_longest_match,
 			   int *p_match_first) internal_function;
@@ -197,8 +207,17 @@ static int group_nodes_into_DFAstates (const re_dfa_t *dfa,
 static int check_node_accept (const re_match_context_t *mctx,
 			      const re_token_t *node, int idx)
      internal_function;
-static reg_errcode_t extend_buffers (re_match_context_t *mctx)
+static reg_errcode_t extend_buffers (re_match_context_t *mctx, int min_len)
      internal_function;
+
+#ifdef GAWK
+#undef MIN	/* safety */
+static int
+MIN(size_t a, size_t b)
+{
+	return (a < b ? a : b);
+}
+#endif
 
 /* Entry point for POSIX code.  */
 
@@ -217,12 +236,8 @@ static reg_errcode_t extend_buffers (re_match_context_t *mctx)
    We return 0 if we find a match and REG_NOMATCH if not.  */
 
 int
-regexec (
-	const regex_t *__restrict preg,
-	const char *__restrict string,
-	size_t nmatch,
-	regmatch_t pmatch[],
-	int eflags)
+regexec (const regex_t *__restrict preg, const char *__restrict string,
+	 size_t nmatch, regmatch_t pmatch[], int eflags)
 {
   reg_errcode_t err;
   int start, length;
@@ -293,7 +308,7 @@ compat_symbol (libc, __compat_regexec, regexec, GLIBC_2_0);
    concerned.
 
    If REGS is not NULL, and BUFP->no_sub is not set, the offsets of the match
-   and all groups is stroed in REGS.  (For the "_2" variants, the offsets are
+   and all groups is stored in REGS.  (For the "_2" variants, the offsets are
    computed relative to the concatenation, not relative to the individual
    strings.)
 
@@ -302,11 +317,8 @@ compat_symbol (libc, __compat_regexec, regexec, GLIBC_2_0);
    match was found and -2 indicates an internal error.  */
 
 int
-re_match (struct re_pattern_buffer *bufp,
-	  const char *string,
-	  int length,
-	  int start,
-	  struct re_registers *regs)
+re_match (struct re_pattern_buffer *bufp, const char *string, int length,
+	  int start, struct re_registers *regs)
 {
   return re_search_stub (bufp, string, length, start, 0, length, regs, 1);
 }
@@ -315,10 +327,8 @@ weak_alias (__re_match, re_match)
 #endif
 
 int
-re_search (struct re_pattern_buffer *bufp,
-	   const char *string,
-	   int length, int start, int range,
-	   struct re_registers *regs)
+re_search (struct re_pattern_buffer *bufp, const char *string, int length,
+	   int start, int range, struct re_registers *regs)
 {
   return re_search_stub (bufp, string, length, start, range, length, regs, 0);
 }
@@ -327,8 +337,7 @@ weak_alias (__re_search, re_search)
 #endif
 
 int
-re_match_2 (struct re_pattern_buffer *bufp,
-	    const char *string1, int length1,
+re_match_2 (struct re_pattern_buffer *bufp, const char *string1, int length1,
 	    const char *string2, int length2, int start,
 	    struct re_registers *regs, int stop)
 {
@@ -340,10 +349,9 @@ weak_alias (__re_match_2, re_match_2)
 #endif
 
 int
-re_search_2 (struct re_pattern_buffer *bufp,
-	     const char *string1, int length1,
-	     const char *string2, int length2, int start,
-	     int range, struct re_registers *regs,  int stop)
+re_search_2 (struct re_pattern_buffer *bufp, const char *string1, int length1,
+	     const char *string2, int length2, int start, int range,
+	     struct re_registers *regs, int stop)
 {
   return re_search_2_stub (bufp, string1, length1, string2, length2,
 			   start, range, regs, stop, 0);
@@ -353,32 +361,37 @@ weak_alias (__re_search_2, re_search_2)
 #endif
 
 static int
-re_search_2_stub (struct re_pattern_buffer *bufp,
-		  const char *string1, int length1,
-		  const char *string2, int length2, int start,
+internal_function
+re_search_2_stub (struct re_pattern_buffer *bufp, const char *string1,
+		  int length1, const char *string2, int length2, int start,
 		  int range, struct re_registers *regs,
 		  int stop, int ret_len)
 {
   const char *str;
   int rval;
-  int len = length1 + length2;
-  int free_str = 0;
+  int len;
+  char *s = NULL;
 
-  if (BE (length1 < 0 || length2 < 0 || stop < 0, 0))
+  if (BE ((length1 < 0 || length2 < 0 || stop < 0
+           || INT_ADD_WRAPV (length1, length2, &len)),
+          0))
     return -2;
 
   /* Concatenate the strings.  */
   if (length2 > 0)
     if (length1 > 0)
       {
-	char *s = re_malloc (char, len);
+	s = re_malloc (char, len);
 
 	if (BE (s == NULL, 0))
 	  return -2;
+#ifdef _LIBC
+	memcpy (__mempcpy (s, string1, length1), string2, length2);
+#else
 	memcpy (s, string1, length1);
 	memcpy (s + length1, string2, length2);
+#endif
 	str = s;
-	free_str = 1;
       }
     else
       str = string2;
@@ -386,8 +399,7 @@ re_search_2_stub (struct re_pattern_buffer *bufp,
     str = string1;
 
   rval = re_search_stub (bufp, str, len, start, range, stop, regs, ret_len);
-  if (free_str)
-    re_free ((char *) str);
+  re_free (s);
   return rval;
 }
 
@@ -397,10 +409,10 @@ re_search_2_stub (struct re_pattern_buffer *bufp,
    otherwise the position of the match is returned.  */
 
 static int
-re_search_stub (struct re_pattern_buffer *bufp,
-		const char *string, int length, int start,
-		int range, int stop,
-		struct re_registers *regs, int ret_len)
+internal_function
+re_search_stub (struct re_pattern_buffer *bufp, const char *string, int length,
+		int start, int range, int stop, struct re_registers *regs,
+		int ret_len)
 {
   reg_errcode_t result;
   regmatch_t *pmatch;
@@ -455,7 +467,7 @@ re_search_stub (struct re_pattern_buffer *bufp,
 
   rval = 0;
 
-  /* I hope we needn't fill their regs with -1's when no match was found.  */
+  /* I hope we needn't fill ther regs with -1's when no match was found.  */
   if (result != REG_NOERROR)
     rval = -1;
   else if (regs != NULL)
@@ -484,9 +496,9 @@ re_search_stub (struct re_pattern_buffer *bufp,
 }
 
 static unsigned
-re_copy_regs (struct re_registers *regs,
-	      regmatch_t *pmatch,
-	      int nregs, int regs_allocated)
+internal_function
+re_copy_regs (struct re_registers *regs, regmatch_t *pmatch, int nregs,
+	      int regs_allocated)
 {
   int rval = REGS_REALLOCATE;
   int i;
@@ -563,11 +575,8 @@ re_copy_regs (struct re_registers *regs,
    freeing the old data.  */
 
 void
-re_set_registers (struct re_pattern_buffer *bufp,
-		  struct re_registers *regs,
-		  unsigned num_regs,
-		  regoff_t *starts,
-		  regoff_t *ends)
+re_set_registers (struct re_pattern_buffer *bufp, struct re_registers *regs,
+		  unsigned num_regs, regoff_t *starts, regoff_t *ends)
 {
   if (num_regs)
     {
@@ -595,8 +604,7 @@ int
 # ifdef _LIBC
 weak_function
 # endif
-re_exec (s)
-     const char *s;
+re_exec (const char *s)
 {
   return 0 == regexec (&re_comp_buf, s, 0, NULL, 0);
 }
@@ -606,7 +614,7 @@ re_exec (s)
 
 /* Searches for a compiled pattern PREG in the string STRING, whose
    length is LENGTH.  NMATCH, PMATCH, and EFLAGS have the same
-   mingings with regexec.  START, and RANGE have the same meanings
+   meaning as with regexec.  START, and RANGE have the same meanings
    with re_search.
    Return REG_NOERROR if we find a match, and REG_NOMATCH if not,
    otherwise return the error code.
@@ -614,11 +622,10 @@ re_exec (s)
    (START + RANGE >= 0 && START + RANGE <= LENGTH)  */
 
 static reg_errcode_t
-re_search_internal (const regex_t *preg,
-		    const char *string,
-		    int length, int start, int range, int stop,
-		    size_t nmatch, regmatch_t pmatch[],
-		    int eflags)
+__attribute_warn_unused_result__ internal_function
+re_search_internal (const regex_t *preg, const char *string, int length,
+		    int start, int range, int stop, size_t nmatch,
+		    regmatch_t pmatch[], int eflags)
 {
   reg_errcode_t err;
   const re_dfa_t *dfa = (const re_dfa_t *) preg->buffer;
@@ -644,7 +651,7 @@ re_search_internal (const regex_t *preg,
   nmatch -= extra_nmatch;
 
   /* Check if the DFA haven't been compiled.  */
-  if (BE (preg->used == 0 || dfa->init_state == NULL
+  if (BE (preg->used == 0 || dfa == NULL || dfa->init_state == NULL
 	  || dfa->init_state_word == NULL || dfa->init_state_nl == NULL
 	  || dfa->init_state_begbuf == NULL, 0))
     return REG_NOMATCH;
@@ -671,7 +678,8 @@ re_search_internal (const regex_t *preg,
   fl_longest_match = (nmatch != 0 || dfa->nbackref);
 
   err = re_string_allocate (&mctx.input, string, length, dfa->nodes_len + 1,
-			    preg->translate, preg->syntax & RE_ICASE, dfa);
+			    preg->translate, (preg->syntax & RE_ICASE) != 0,
+			    dfa);
   if (BE (err != REG_NOERROR, 0))
     goto free_return;
   mctx.input.stop = stop;
@@ -888,7 +896,7 @@ re_search_internal (const regex_t *preg,
 	    goto free_return;
 	}
 
-      /* At last, add the offset to the each registers, since we slided
+      /* At last, add the offset to each register, since we slid
 	 the buffers so that we could assume that the matching starts
 	 from 0.  */
       for (reg_idx = 0; reg_idx < nmatch; ++reg_idx)
@@ -1033,7 +1041,7 @@ prune_impossible_nodes (re_match_context_t *mctx)
    since initial states may have constraints like "\<", "^", etc..  */
 
 static inline re_dfastate_t *
-__attribute ((always_inline)) internal_function
+__attribute__ ((always_inline)) internal_function
 acquire_init_state_context (reg_errcode_t *err, const re_match_context_t *mctx,
 			    int idx)
 {
@@ -1071,11 +1079,11 @@ acquire_init_state_context (reg_errcode_t *err, const re_match_context_t *mctx,
    FL_LONGEST_MATCH means we want the POSIX longest matching.
    If P_MATCH_FIRST is not NULL, and the match fails, it is set to the
    next place where we may want to try matching.
-   Note that the matcher assume that the matching starts from the current
+   Note that the matcher assume that the maching starts from the current
    index of the buffer.  */
 
 static int
-internal_function
+internal_function __attribute_warn_unused_result__
 check_matching (re_match_context_t *mctx, int fl_longest_match,
 		int *p_match_first)
 {
@@ -1140,11 +1148,12 @@ check_matching (re_match_context_t *mctx, int fl_longest_match,
       re_dfastate_t *old_state = cur_state;
       int next_char_idx = re_string_cur_idx (&mctx->input) + 1;
 
-      if (BE (next_char_idx >= mctx->input.bufs_len, 0)
+      if ((BE (next_char_idx >= mctx->input.bufs_len, 0)
+	   && mctx->input.bufs_len < mctx->input.len)
 	  || (BE (next_char_idx >= mctx->input.valid_len, 0)
 	      && mctx->input.valid_len < mctx->input.len))
 	{
-	  err = extend_buffers (mctx);
+	  err = extend_buffers (mctx, next_char_idx + 1);
 	  if (BE (err != REG_NOERROR, 0))
 	    {
 	      assert (err == REG_ESPACE);
@@ -1348,7 +1357,7 @@ proceed_next_node (const re_match_context_t *mctx, int nregs, regmatch_t *regs,
 }
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 push_fail_stack (struct re_fail_stack_t *fs, int str_idx, int dest_node,
 		 int nregs, regmatch_t *regs, re_node_set *eps_via_nodes)
 {
@@ -1395,7 +1404,7 @@ pop_fail_stack (struct re_fail_stack_t *fs, int *pidx, int nregs,
    pmatch[i].rm_so == pmatch[i].rm_eo == -1 for 0 < i < nmatch.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 set_regs (const regex_t *preg, const re_match_context_t *mctx, size_t nmatch,
 	  regmatch_t *pmatch, int fl_backtrack)
 {
@@ -1651,7 +1660,7 @@ sift_states_backward (const re_match_context_t *mctx, re_sift_context_t *sctx)
 }
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 build_sifted_states (const re_match_context_t *mctx, re_sift_context_t *sctx,
 		     int str_idx, re_node_set *cur_dest)
 {
@@ -1718,12 +1727,13 @@ clean_state_log_if_needed (re_match_context_t *mctx, int next_state_log_idx)
 {
   int top = mctx->state_log_top;
 
-  if (next_state_log_idx >= mctx->input.bufs_len
+  if ((next_state_log_idx >= mctx->input.bufs_len
+       && mctx->input.bufs_len < mctx->input.len)
       || (next_state_log_idx >= mctx->input.valid_len
 	  && mctx->input.valid_len < mctx->input.len))
     {
       reg_errcode_t err;
-      err = extend_buffers (mctx);
+      err = extend_buffers (mctx, next_state_log_idx + 1);
       if (BE (err != REG_NOERROR, 0))
 	return err;
     }
@@ -1813,7 +1823,7 @@ update_cur_sifted_state (const re_match_context_t *mctx,
 }
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 add_epsilon_src_nodes (const re_dfa_t *dfa, re_node_set *dest_nodes,
 		       const re_node_set *candidates)
 {
@@ -2126,7 +2136,7 @@ check_subexp_limits (const re_dfa_t *dfa, re_node_set *dest_nodes,
 }
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 sift_states_bkref (const re_match_context_t *mctx, re_sift_context_t *sctx,
 		   int str_idx, const re_node_set *candidates)
 {
@@ -2239,7 +2249,7 @@ sift_states_iter_mb (const re_match_context_t *mctx, re_sift_context_t *sctx,
 			    dfa->nexts[node_idx]))
     /* The node can't accept the `multi byte', or the
        destination was already thrown away, then the node
-       couldn't accept the current input `multi byte'.   */
+       could't accept the current input `multi byte'.   */
     naccepted = 0;
   /* Otherwise, it is sure that the node could accept
      `naccepted' bytes input.  */
@@ -2256,7 +2266,7 @@ sift_states_iter_mb (const re_match_context_t *mctx, re_sift_context_t *sctx,
    update the destination of STATE_LOG.  */
 
 static re_dfastate_t *
-internal_function
+internal_function __attribute_warn_unused_result__
 transit_state (reg_errcode_t *err, re_match_context_t *mctx,
 	       re_dfastate_t *state)
 {
@@ -2313,7 +2323,7 @@ transit_state (reg_errcode_t *err, re_match_context_t *mctx,
 }
 
 /* Update the state_log if we need */
-static re_dfastate_t *
+re_dfastate_t *
 internal_function
 merge_state_with_log (reg_errcode_t *err, re_match_context_t *mctx,
 		      re_dfastate_t *next_state)
@@ -2326,7 +2336,7 @@ merge_state_with_log (reg_errcode_t *err, re_match_context_t *mctx,
       mctx->state_log[cur_idx] = next_state;
       mctx->state_log_top = cur_idx;
     }
-  else if (mctx->state_log[cur_idx] == NULL)
+  else if (mctx->state_log[cur_idx] == 0)
     {
       mctx->state_log[cur_idx] = next_state;
     }
@@ -2421,7 +2431,7 @@ find_recover_state (reg_errcode_t *err, re_match_context_t *mctx)
 /* From the node set CUR_NODES, pick up the nodes whose types are
    OP_OPEN_SUBEXP and which have corresponding back references in the regular
    expression. And register them to use them later for evaluating the
-   correspoding back references.  */
+   corresponding back references.  */
 
 static reg_errcode_t
 internal_function
@@ -2681,7 +2691,7 @@ transit_state_bkref (re_match_context_t *mctx, const re_node_set *nodes)
    delay these checking for prune_impossible_nodes().  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 get_subexp (re_match_context_t *mctx, int bkref_node, int bkref_str_idx)
 {
   const re_dfa_t *const dfa = mctx->dfa;
@@ -2777,7 +2787,7 @@ get_subexp (re_match_context_t *mctx, int bkref_node, int bkref_str_idx)
 		  if (bkref_str_off >= mctx->input.len)
 		    break;
 
-		  err = extend_buffers (mctx);
+		  err = extend_buffers (mctx, bkref_str_off + 1);
 		  if (BE (err != REG_NOERROR, 0))
 		    return err;
 
@@ -2881,7 +2891,7 @@ find_subexp_node (const re_dfa_t *dfa, const re_node_set *nodes,
    Return REG_NOERROR if it can arrive, or REG_NOMATCH otherwise.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 check_arrival (re_match_context_t *mctx, state_array_t *path, int top_node,
 	       int top_str, int last_node, int last_str, int type)
 {
@@ -3042,7 +3052,7 @@ check_arrival (re_match_context_t *mctx, state_array_t *path, int top_node,
 	 Can't we unify them?  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 check_arrival_add_next_nodes (re_match_context_t *mctx, int str_idx,
 			      re_node_set *cur_nodes, re_node_set *next_nodes)
 {
@@ -3176,7 +3186,7 @@ check_arrival_expand_ecl (const re_dfa_t *dfa, re_node_set *cur_nodes,
    problematic append it to DST_NODES.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 check_arrival_expand_ecl_sub (const re_dfa_t *dfa, re_node_set *dst_nodes,
 			      int target, int ex_subexp, int type)
 {
@@ -3220,7 +3230,7 @@ check_arrival_expand_ecl_sub (const re_dfa_t *dfa, re_node_set *dst_nodes,
    in MCTX->BKREF_ENTS.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 expand_bkref_cache (re_match_context_t *mctx, re_node_set *cur_nodes,
 		    int cur_str, int subexp_num, int type)
 {
@@ -3357,12 +3367,14 @@ build_trtable (const re_dfa_t *dfa, re_dfastate_t *state)
   if (BE (ndests <= 0, 0))
     {
       if (dests_node_malloced)
-	free (dests_alloc);
+	re_free (dests_alloc);
       /* Return 0 in case of an error, 1 otherwise.  */
       if (ndests == 0)
 	{
 	  state->trtable = (re_dfastate_t **)
 	    calloc (sizeof (re_dfastate_t *), SBC_MAX);
+	  if (BE (state->trtable == NULL, 0))
+	    return 0;
 	  return 1;
 	}
       return 0;
@@ -3387,18 +3399,18 @@ build_trtable (const re_dfa_t *dfa, re_dfastate_t *state)
   else
 #endif
     {
-      dest_states = (re_dfastate_t **)
-	malloc (ndests * 3 * sizeof (re_dfastate_t *));
+      dest_states =
+	re_malloc (re_dfastate_t *, ndests * 3);
       if (BE (dest_states == NULL, 0))
 	{
 out_free:
 	  if (dest_states_malloced)
-	    free (dest_states);
+	    re_free (dest_states);
 	  re_node_set_free (&follows);
 	  for (i = 0; i < ndests; ++i)
 	    re_node_set_free (dests_node + i);
 	  if (dests_node_malloced)
-	    free (dests_alloc);
+	    re_free (dests_alloc);
 	  return 0;
 	}
       dest_states_malloced = true;
@@ -3529,14 +3541,14 @@ build_trtable (const re_dfa_t *dfa, re_dfastate_t *state)
     }
 
   if (dest_states_malloced)
-    free (dest_states);
+    re_free (dest_states);
 
   re_node_set_free (&follows);
   for (i = 0; i < ndests; ++i)
     re_node_set_free (dests_node + i);
 
   if (dests_node_malloced)
-    free (dests_alloc);
+    re_free (dests_alloc);
 
   return 1;
 }
@@ -3736,6 +3748,10 @@ group_nodes_into_DFAstates (const re_dfa_t *dfa, const re_dfastate_t *state,
    one collating element like '.', '[a-z]', opposite to the other nodes
    can only accept one byte.  */
 
+# ifdef _LIBC
+#  include <locale/weight.h>
+# endif
+
 static int
 internal_function
 check_node_accept_bytes (const re_dfa_t *dfa, int node_idx,
@@ -3857,8 +3873,6 @@ check_node_accept_bytes (const re_dfa_t *dfa, int node_idx,
 	  const int32_t *table, *indirect;
 	  const unsigned char *weights, *extra;
 	  const char *collseqwc;
-	  /* This #include defines a local function!  */
-#  include <locale/weight.h>
 
 	  /* match with collating_symbol?  */
 	  if (cset->ncoll_syms)
@@ -3914,7 +3928,7 @@ check_node_accept_bytes (const re_dfa_t *dfa, int node_idx,
 		_NL_CURRENT (LC_COLLATE, _NL_COLLATE_EXTRAMB);
 	      indirect = (const int32_t *)
 		_NL_CURRENT (LC_COLLATE, _NL_COLLATE_INDIRECTMB);
-	      int32_t idx = findidx (&cp);
+	      int32_t idx = findidx (table, indirect, extra, &cp, elem_len);
 	      if (idx > 0)
 		for (i = 0; i < cset->nequiv_classes; ++i)
 		  {
@@ -3945,18 +3959,10 @@ check_node_accept_bytes (const re_dfa_t *dfa, int node_idx,
 # endif /* _LIBC */
 	{
 	  /* match with range expression?  */
-#if __GNUC__ >= 2
-	  wchar_t cmp_buf[] = {L'\0', L'\0', wc, L'\0', L'\0', L'\0'};
-#else
-	  wchar_t cmp_buf[] = {L'\0', L'\0', L'\0', L'\0', L'\0', L'\0'};
-	  cmp_buf[2] = wc;
-#endif
 	  for (i = 0; i < cset->nranges; ++i)
 	    {
-	      cmp_buf[0] = cset->range_starts[i];
-	      cmp_buf[4] = cset->range_ends[i];
-	      if (wcscoll (cmp_buf, cmp_buf + 2) <= 0
-		  && wcscoll (cmp_buf + 2, cmp_buf + 4) <= 0)
+              if (cset->range_starts[i] <= wc
+                  && wc <= cset->range_ends[i])
 		{
 		  match_len = char_len;
 		  goto check_node_accept_bytes_match;
@@ -4025,7 +4031,7 @@ find_collation_sequence_value (const unsigned char *mbs, size_t mbs_len)
 	  /* Skip the collation sequence value.  */
 	  idx += sizeof (uint32_t);
 	  /* Skip the wide char sequence of the collating element.  */
-	  idx = idx + sizeof (uint32_t) * (extra[idx] + 1);
+	  idx = idx + sizeof (uint32_t) * (*(int32_t *) (extra + idx) + 1);
 	  /* If we found the entry, return the sequence value.  */
 	  if (found)
 	    return *(uint32_t *) (extra + idx);
@@ -4092,8 +4098,8 @@ check_node_accept (const re_match_context_t *mctx, const re_token_t *node,
 /* Extend the buffers, if the buffers have run out.  */
 
 static reg_errcode_t
-internal_function
-extend_buffers (re_match_context_t *mctx)
+internal_function __attribute_warn_unused_result__
+extend_buffers (re_match_context_t *mctx, int min_len)
 {
   reg_errcode_t ret;
   re_string_t *pstr = &mctx->input;
@@ -4102,8 +4108,10 @@ extend_buffers (re_match_context_t *mctx)
   if (BE (INT_MAX / 2 / sizeof (re_dfastate_t *) <= pstr->bufs_len, 0))
     return REG_ESPACE;
 
-  /* Double the lengthes of the buffers.  */
-  ret = re_string_realloc_buffers (pstr, pstr->bufs_len * 2);
+  /* Double the lengthes of the buffers, but allocate at least MIN_LEN.  */
+  ret = re_string_realloc_buffers (pstr,
+				   MAX (min_len,
+					MIN (pstr->len, pstr->bufs_len * 2)));
   if (BE (ret != REG_NOERROR, 0))
     return ret;
 
@@ -4155,7 +4163,7 @@ extend_buffers (re_match_context_t *mctx)
 /* Initialize MCTX.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 match_ctx_init (re_match_context_t *mctx, int eflags, int n)
 {
   mctx->eflags = eflags;
@@ -4203,7 +4211,7 @@ match_ctx_clean (re_match_context_t *mctx)
 	  re_free (top->path->array);
 	  re_free (top->path);
 	}
-      free (top);
+      re_free (top);
     }
 
   mctx->nsub_tops = 0;
@@ -4228,7 +4236,7 @@ match_ctx_free (re_match_context_t *mctx)
 */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 match_ctx_add_entry (re_match_context_t *mctx, int node, int str_idx, int from,
 		     int to)
 {
@@ -4300,7 +4308,7 @@ search_cur_bkref_entry (const re_match_context_t *mctx, int str_idx)
    at STR_IDX.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 match_ctx_add_subtop (re_match_context_t *mctx, int node, int str_idx)
 {
 #ifdef DEBUG
-- 
2.11.0

