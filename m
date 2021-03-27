Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F3C433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 049E461971
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhC0XJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 19:09:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53040 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhC0XJI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 19:09:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 208FDB768E;
        Sat, 27 Mar 2021 19:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Meheh7N1jfD41VYqX61DzBLXDFg=; b=VBWPm6
        frlSmv+7+Za5il7VWfIXsBcNWE2WuCFF7gwWOYK1m3gzWgo4WuEUmnM22M4DaKTP
        reRyImt4zTEsR5k6feBWrce74dp4rAkJMEeKGhY8xd3r8WZGiGcfDiqJAhMKW5DO
        7MDhhEbwa7ichWC2TFCLO38/nSeEO52pUMfbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fMG9jKUpcKTowaASv/2eslwnUahKIzeo
        FNGsp6d88y8S0nkwGOnLQonepcjmuX9GYdo5ky1BUW2pqfNdmjICvI2no8mAHt1p
        wZABxjnFoDgticEAajYXfBx2TM9yrEReHnWlo7LpccwPWJIRJdp83jvUWAs/FnMd
        oKJQO5iZYmA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04669B768D;
        Sat, 27 Mar 2021 19:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3EA68B768B;
        Sat, 27 Mar 2021 19:09:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
References: <20210327173938.59391-1-raykar.ath@gmail.com>
        <xmqq5z1cqki7.fsf@gitster.g>
Date:   Sat, 27 Mar 2021 16:09:06 -0700
In-Reply-To: <xmqq5z1cqki7.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        27 Mar 2021 15:50:24 -0700")
Message-ID: <xmqq1rc0qjn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E6D499E-8F51-11EB-A9C9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Atharva Raykar <raykar.ath@gmail.com> writes:
> ...
>> +           (ChangeMe 'suite-name tests)))))))
>> \ No newline at end of file
>
> Is there a good reason to leave the final line incomplete?  ...
> I am also trying to figure out what you wanted to achieve ...

Taking all of them together, here is what I hope you may agree as
its improved version.  The only differences from what you posted are
corrections to all the "\ No newline at end of file" and the simplification
of the pattern (remove "a dot" from the alternative and add \t next
to SP).  Without changes, the new tests still pass so ... ;-)

    diff --git c/userdiff.c w/userdiff.c
    index 5fd0eb31ec..685fe712aa 100644
    --- c/userdiff.c
    +++ w/userdiff.c
    @@ -193,12 +193,8 @@ PATTERNS("rust",
             "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
     PATTERNS("scheme",
             "^[\t ]*(\\(define-?.*)$",
    -	 /*
    -	  * Scheme allows symbol names to have any character,
    -	  * as long as it is not a form of a parenthesis.
    -	  * The spaces must be escaped.
    -	  */
    -	 "(\\.|[^][)(\\}\\{ ])+"),
    +	 /* whitespace separated tokens, but parentheses also can delimit words */
    +	 "([^][)(\\}\\{ \t])+"),
     PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
             "[={}\"]|[^={}\" \t]+"),
     PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",

----- >8 ---------- >8 ---------- >8 ---------- >8 ---------- >8 -----
From: Atharva Raykar <raykar.ath@gmail.com>
Date: Sat, 27 Mar 2021 23:09:38 +0530
Subject: [PATCH] userdiff: add support for Scheme

Add a diff driver for Scheme (R5RS and R6RS) which
recognizes top level and local `define` forms,
whether it is a function definition, binding, syntax
definition or a user-defined `define-xyzzy` form.

The rationale for picking `define` forms for the
hunk headers is because it is usually the only
significant form for defining the structure of the
program, and it is a common pattern for schemers to
have local function definitions to hide their
visibility, so it is not only the top level
`define`'s that are of interest. Schemers also
extend the language with macros to provide their
own define forms (for example, something like a
`define-test-suite`) which is also captured in the
hunk header.

Since the identifier syntax is quite forgiving, we start
our word regexp from "words delimited by whitespaces" and
then loosen to include various forms of parentheses characters
to word-delimiters.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
[jc: simplified word regex and its explanation; fixed whitespace errors]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitattributes.txt    | 2 ++
 t/t4018-diff-funcname.sh           | 1 +
 t/t4018/scheme-define-syntax       | 8 ++++++++
 t/t4018/scheme-local-define        | 4 ++++
 t/t4018/scheme-top-level-define    | 4 ++++
 t/t4018/scheme-user-defined-define | 6 ++++++
 t/t4034-diff-words.sh              | 1 +
 t/t4034/scheme/expect              | 9 +++++++++
 t/t4034/scheme/post                | 4 ++++
 t/t4034/scheme/pre                 | 4 ++++
 userdiff.c                         | 4 ++++
 11 files changed, 47 insertions(+)
 create mode 100644 t/t4018/scheme-define-syntax
 create mode 100644 t/t4018/scheme-local-define
 create mode 100644 t/t4018/scheme-top-level-define
 create mode 100644 t/t4018/scheme-user-defined-define
 create mode 100644 t/t4034/scheme/expect
 create mode 100644 t/t4034/scheme/post
 create mode 100644 t/t4034/scheme/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 0a60472bb5..cfcfa800c2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -845,6 +845,8 @@ patterns are available:
 
 - `rust` suitable for source code in the Rust language.
 
+- `scheme` suitable for source code in the Scheme language.
+
 - `tex` suitable for source code for LaTeX documents.
 
 
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9675bc17db..823ea96acb 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -48,6 +48,7 @@ diffpatterns="
 	python
 	ruby
 	rust
+	scheme
 	tex
 	custom1
 	custom2
diff --git a/t/t4018/scheme-define-syntax b/t/t4018/scheme-define-syntax
new file mode 100644
index 0000000000..33fa50c844
--- /dev/null
+++ b/t/t4018/scheme-define-syntax
@@ -0,0 +1,8 @@
+(define-syntax define-test-suite RIGHT
+  (syntax-rules ()
+    ((_ suite-name (name test) ChangeMe ...)
+     (define suite-name
+       (let ((tests
+              `((name . ,test) ...)))
+         (lambda ()
+           (ChangeMe 'suite-name tests)))))))
diff --git a/t/t4018/scheme-local-define b/t/t4018/scheme-local-define
new file mode 100644
index 0000000000..bc6d8aebbe
--- /dev/null
+++ b/t/t4018/scheme-local-define
@@ -0,0 +1,4 @@
+(define (higher-order)
+  (define local-function RIGHT
+    (lambda (x)
+     (car "this is" "ChangeMe"))))
diff --git a/t/t4018/scheme-top-level-define b/t/t4018/scheme-top-level-define
new file mode 100644
index 0000000000..624743c22b
--- /dev/null
+++ b/t/t4018/scheme-top-level-define
@@ -0,0 +1,4 @@
+(define (some-func x y z) RIGHT
+  (let ((a x)
+        (b y))
+        (ChangeMe a b)))
diff --git a/t/t4018/scheme-user-defined-define b/t/t4018/scheme-user-defined-define
new file mode 100644
index 0000000000..70e403c5e2
--- /dev/null
+++ b/t/t4018/scheme-user-defined-define
@@ -0,0 +1,6 @@
+(define-test-suite record-case-tests RIGHT
+  (record-case-1 (lambda (fail)
+                   (let ((a (make-foo 1 2)))
+                     (record-case a
+                       ((bar x) (ChangeMe))
+                       ((foo a b) (+ a b)))))))
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 56f1e62a97..ee7721ab91 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -325,6 +325,7 @@ test_language_driver perl
 test_language_driver php
 test_language_driver python
 test_language_driver ruby
+test_language_driver scheme
 test_language_driver tex
 
 test_expect_success 'word-diff with diff.sbe' '
diff --git a/t/t4034/scheme/expect b/t/t4034/scheme/expect
new file mode 100644
index 0000000000..eed21e803c
--- /dev/null
+++ b/t/t4034/scheme/expect
@@ -0,0 +1,9 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 6a5efba..7c4a6b4 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,4 +1,4 @@<RESET>
+(define (<RED>myfunc a b<RESET><GREEN>my-func first second<RESET>)
+  ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
+  (let ((c (<RED>+ a b<RESET><GREEN>add1 first<RESET>)))
+    (format "one more than the total is %d" (<RED>add1<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
diff --git a/t/t4034/scheme/post b/t/t4034/scheme/post
new file mode 100644
index 0000000000..28f59c6584
--- /dev/null
+++ b/t/t4034/scheme/post
@@ -0,0 +1,4 @@
+(define (my-func first second)
+  ; This is a (moderately) cool function.
+  (let ((c (add1 first)))
+    (format "one more than the total is %d" (+ c second))))
diff --git a/t/t4034/scheme/pre b/t/t4034/scheme/pre
new file mode 100644
index 0000000000..4bd0069493
--- /dev/null
+++ b/t/t4034/scheme/pre
@@ -0,0 +1,4 @@
+(define (myfunc a b)
+  ; This is a really cool function.
+  (let ((c (+ a b)))
+    (format "one more than the total is %d" (add1 c))))
diff --git a/userdiff.c b/userdiff.c
index 3f81a2261c..685fe712aa 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -191,6 +191,10 @@ PATTERNS("rust",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
 	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
+PATTERNS("scheme",
+	 "^[\t ]*(\\(define-?.*)$",
+	 /* whitespace separated tokens, but parentheses also can delimit words */
+	 "([^][)(\\}\\{ \t])+"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-- 
2.31.1-255-g3df2b433e7

