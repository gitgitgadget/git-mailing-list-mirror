From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] compat/regex: get rid of old-style definition
Date: Thu, 19 Aug 2010 15:45:28 -0700
Message-ID: <7v39uadxx3.fsf_-_@alter.siamese.dyndns.org>
References: <201008191805.o7JI5Aw0002340@localhost.localdomain>
 <1282242601-2630-1-git-send-email-avarab@gmail.com>
 <7vtymq74mp.fsf@alter.siamese.dyndns.org>
 <AANLkTikod-o3GHqyFSu7yKJZMc1pgZUQm+pEb-ErAYDB@mail.gmail.com>
 <7vlj8271mm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 00:45:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmDrn-0002HJ-9A
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 00:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab0HSWpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 18:45:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab0HSWpj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 18:45:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70CC1CF425;
	Thu, 19 Aug 2010 18:45:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OaW3bB4rHfdqYGKt/aRCifhYExM=; b=wvpSfl
	Of48AlgZJ6acZlcD6w7McRtRs3w/+7zV4gI2TlU0X5Sb5ZGjWiGTwoflDo+4M3rK
	0ER3ahU6PKkgTuDrvDDBMDdCozfveSuQyVxsCNB/xX9DWDTO8uJmivakalmB8rqy
	9hAfjbG5UdPl/fDHIoRCEoFp6hn4kDRLVDo0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W2fIKxjbG3eHsHa99GRsPiKJ4v4ZSSDP
	2kvKRntsA/mmgxqThuJcFqUieDFYoDg4mTGAaVg5wI8wtU+JQRYohQ0gnOVQgcq6
	5MF5aaz9ECwNk6Lx1LYxx+Rj3JR0iherR1rFrymUFvlJJWtUuC5jRuxamguwH8yJ
	bTqT/FsvANI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CB0FCF424;
	Thu, 19 Aug 2010 18:45:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B839CF423; Thu, 19 Aug
 2010 18:45:30 -0400 (EDT)
In-Reply-To: <7vlj8271mm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 19 Aug 2010 14\:07\:13 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A56AA8C-ABE3-11DF-890A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153964>

These files mostly used ANSI style function definitions, but with small
number of old-style ones.  Convert them to consistently use ANSI style.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With this I can finish my semi-autobuild with the Meta/Make wrapper.
   For people who don't know, a checkout of the 'todo' branch lives in
   "Meta/" subdirectory in my local environments (not that I need the
   compatibility replacement in any of them, though...)

 compat/regex/regcomp.c |   23 ++++-------
 compat/regex/regexec.c |  101 ++++++++++++++++++++++--------------------------
 2 files changed, 55 insertions(+), 69 deletions(-)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 4a80056..8c96ed9 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -230,10 +230,9 @@ btowc (int c)
    are set in BUFP on entry.  */
 
 const char *
-re_compile_pattern (pattern, length, bufp)
-    const char *pattern;
-    size_t length;
-    struct re_pattern_buffer *bufp;
+re_compile_pattern (const char *pattern,
+		    size_t length,
+		    struct re_pattern_buffer *bufp)
 {
   reg_errcode_t ret;
 
@@ -271,8 +270,7 @@ reg_syntax_t re_syntax_options;
    defined in regex.h.  We return the old syntax.  */
 
 reg_syntax_t
-re_set_syntax (syntax)
-    reg_syntax_t syntax;
+re_set_syntax (reg_syntax_t syntax)
 {
   reg_syntax_t ret = re_syntax_options;
 
@@ -284,8 +282,7 @@ weak_alias (__re_set_syntax, re_set_syntax)
 #endif
 
 int
-re_compile_fastmap (bufp)
-    struct re_pattern_buffer *bufp;
+re_compile_fastmap (struct re_pattern_buffer *bufp)
 {
   re_dfa_t *dfa = (re_dfa_t *) bufp->buffer;
   char *fastmap = bufp->fastmap;
@@ -484,10 +481,9 @@ re_compile_fastmap_iter (regex_t *bufp, const re_dfastate_t *init_state,
    the return codes and their meanings.)  */
 
 int
-regcomp (preg, pattern, cflags)
-    regex_t *__restrict preg;
-    const char *__restrict pattern;
-    int cflags;
+regcomp (regex_t *__restrict preg,
+	 const char *__restrict pattern,
+	 int cflags)
 {
   reg_errcode_t ret;
   reg_syntax_t syntax = ((cflags & REG_EXTENDED) ? RE_SYNTAX_POSIX_EXTENDED
@@ -650,8 +646,7 @@ free_dfa_content (re_dfa_t *dfa)
 /* Free dynamically allocated space used by PREG.  */
 
 void
-regfree (preg)
-    regex_t *preg;
+regfree (regex_t *preg)
 {
   re_dfa_t *dfa = (re_dfa_t *) preg->buffer;
   if (BE (dfa != NULL, 1))
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 0c2b054..b49585a 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -218,12 +218,12 @@ static reg_errcode_t extend_buffers (re_match_context_t *mctx)
    We return 0 if we find a match and REG_NOMATCH if not.  */
 
 int
-regexec (preg, string, nmatch, pmatch, eflags)
-    const regex_t *__restrict preg;
-    const char *__restrict string;
-    size_t nmatch;
-    regmatch_t pmatch[];
-    int eflags;
+regexec (
+	const regex_t *__restrict preg,
+	const char *__restrict string,
+	size_t nmatch,
+	regmatch_t pmatch[],
+	int eflags)
 {
   reg_errcode_t err;
   int start, length;
@@ -303,11 +303,11 @@ compat_symbol (libc, __compat_regexec, regexec, GLIBC_2_0);
    match was found and -2 indicates an internal error.  */
 
 int
-re_match (bufp, string, length, start, regs)
-    struct re_pattern_buffer *bufp;
-    const char *string;
-    int length, start;
-    struct re_registers *regs;
+re_match (struct re_pattern_buffer *bufp,
+	  const char *string,
+	  int length,
+	  int start,
+	  struct re_registers *regs)
 {
   return re_search_stub (bufp, string, length, start, 0, length, regs, 1);
 }
@@ -316,11 +316,10 @@ weak_alias (__re_match, re_match)
 #endif
 
 int
-re_search (bufp, string, length, start, range, regs)
-    struct re_pattern_buffer *bufp;
-    const char *string;
-    int length, start, range;
-    struct re_registers *regs;
+re_search (struct re_pattern_buffer *bufp,
+	   const char *string,
+	   int length, int start, int range,
+	   struct re_registers *regs)
 {
   return re_search_stub (bufp, string, length, start, range, length, regs, 0);
 }
@@ -329,11 +328,10 @@ weak_alias (__re_search, re_search)
 #endif
 
 int
-re_match_2 (bufp, string1, length1, string2, length2, start, regs, stop)
-    struct re_pattern_buffer *bufp;
-    const char *string1, *string2;
-    int length1, length2, start, stop;
-    struct re_registers *regs;
+re_match_2 (struct re_pattern_buffer *bufp,
+	    const char *string1, int length1,
+	    const char *string2, int length2, int start,
+	    struct re_registers *regs, int stop)
 {
   return re_search_2_stub (bufp, string1, length1, string2, length2,
 			   start, 0, regs, stop, 1);
@@ -343,11 +341,10 @@ weak_alias (__re_match_2, re_match_2)
 #endif
 
 int
-re_search_2 (bufp, string1, length1, string2, length2, start, range, regs, stop)
-    struct re_pattern_buffer *bufp;
-    const char *string1, *string2;
-    int length1, length2, start, range, stop;
-    struct re_registers *regs;
+re_search_2 (struct re_pattern_buffer *bufp,
+	     const char *string1, int length1,
+	     const char *string2, int length2, int start,
+	     int range, struct re_registers *regs,  int stop)
 {
   return re_search_2_stub (bufp, string1, length1, string2, length2,
 			   start, range, regs, stop, 0);
@@ -357,12 +354,11 @@ weak_alias (__re_search_2, re_search_2)
 #endif
 
 static int
-re_search_2_stub (bufp, string1, length1, string2, length2, start, range, regs,
-		  stop, ret_len)
-    struct re_pattern_buffer *bufp;
-    const char *string1, *string2;
-    int length1, length2, start, range, stop, ret_len;
-    struct re_registers *regs;
+re_search_2_stub (struct re_pattern_buffer *bufp,
+		  const char *string1, int length1,
+		  const char *string2, int length2, int start,
+		  int range, struct re_registers *regs,
+		  int stop, int ret_len)
 {
   const char *str;
   int rval;
@@ -402,11 +398,10 @@ re_search_2_stub (bufp, string1, length1, string2, length2, start, range, regs,
    otherwise the position of the match is returned.  */
 
 static int
-re_search_stub (bufp, string, length, start, range, stop, regs, ret_len)
-    struct re_pattern_buffer *bufp;
-    const char *string;
-    int length, start, range, stop, ret_len;
-    struct re_registers *regs;
+re_search_stub (struct re_pattern_buffer *bufp,
+		const char *string, int length, int start,
+		int range, int stop,
+		struct re_registers *regs, int ret_len)
 {
   reg_errcode_t result;
   regmatch_t *pmatch;
@@ -490,10 +485,9 @@ re_search_stub (bufp, string, length, start, range, stop, regs, ret_len)
 }
 
 static unsigned
-re_copy_regs (regs, pmatch, nregs, regs_allocated)
-    struct re_registers *regs;
-    regmatch_t *pmatch;
-    int nregs, regs_allocated;
+re_copy_regs (struct re_registers *regs,
+	      regmatch_t *pmatch,
+	      int nregs, int regs_allocated)
 {
   int rval = REGS_REALLOCATE;
   int i;
@@ -570,11 +564,11 @@ re_copy_regs (regs, pmatch, nregs, regs_allocated)
    freeing the old data.  */
 
 void
-re_set_registers (bufp, regs, num_regs, starts, ends)
-    struct re_pattern_buffer *bufp;
-    struct re_registers *regs;
-    unsigned num_regs;
-    regoff_t *starts, *ends;
+re_set_registers (struct re_pattern_buffer *bufp,
+		  struct re_registers *regs,
+		  unsigned num_regs,
+		  regoff_t *starts,
+		  regoff_t *ends)
 {
   if (num_regs)
     {
@@ -621,13 +615,11 @@ re_exec (s)
    (START + RANGE >= 0 && START + RANGE <= LENGTH)  */
 
 static reg_errcode_t
-re_search_internal (preg, string, length, start, range, stop, nmatch, pmatch,
-		    eflags)
-    const regex_t *preg;
-    const char *string;
-    int length, start, range, stop, eflags;
-    size_t nmatch;
-    regmatch_t pmatch[];
+re_search_internal (const regex_t *preg,
+		    const char *string,
+		    int length, int start, int range, int stop,
+		    size_t nmatch, regmatch_t pmatch[],
+		    int eflags)
 {
   reg_errcode_t err;
   const re_dfa_t *dfa = (const re_dfa_t *) preg->buffer;
@@ -947,8 +939,7 @@ re_search_internal (preg, string, length, start, range, stop, nmatch, pmatch,
 }
 
 static reg_errcode_t
-prune_impossible_nodes (mctx)
-     re_match_context_t *mctx;
+prune_impossible_nodes (re_match_context_t *mctx)
 {
   const re_dfa_t *const dfa = mctx->dfa;
   int halt_node, match_last;
-- 
1.7.2.1.364.gf88bdb
