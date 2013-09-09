From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C
 option
Date: Mon, 9 Sep 2013 21:47:43 +0800
Message-ID: <20130909134743.GA11335@gmail.com>
References: <20130903115944.GA29542@gmail.com>
 <xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
 <CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
 <20130904122020.GA25538@gmail.com>
 <CAPig+cRt9o=6Amhx6qTkzfk5R9aQfRZ=357BOVELm_hPsWE3WQ@mail.gmail.com>
 <CAEY4ZpNEae1UprRcpC8XUPP4XBQ89bDXP1A7yVcFdW405HZr0w@mail.gmail.com>
 <CAPig+cTNeqNhGwD-EZ3uszh5vJ4JeJ6L0RXdTsveb1FgXE5t3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1or-0006wA-7L
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab3IINrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 09:47:52 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:63976 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3IINru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:47:50 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so6246756pdj.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ojzTrttWlsbmOlRAEYyOpmpNmLw9Vl84s+HVGdTSOF0=;
        b=PD6i9v9hARxk2GUbjjRWRpdFr73yXaCeDjij98n7PF/oKuLT3znC9HvYwx+IboxIjf
         kKhWB0ykgfOsNz6JLlLn0zyXHaxqFziVY541fH5p0Zij+9JzcDjIteEZV2fl3etGANVv
         8PmFc9QAKJXmm/GMvGVH4zAZe7CXQMNzy86sVM1Y7xqQDbRGNuxLBf70LeE/cfICKYww
         8Zw1ADCgmfWOVwtjoLHxZ43HWuP42QJixXqHiHnOCqA5encBRWMiODwc6t/rMDugogax
         w0KD3815TYP3UoChv0AbJLd+v2k/0nQ2SQpb0P5tcoUvYM/VhV1K2Fbd/Plq+nSr8UaH
         XMJQ==
X-Received: by 10.67.30.100 with SMTP id kd4mr20645681pad.24.1378734470080;
        Mon, 09 Sep 2013 06:47:50 -0700 (PDT)
Received: from gmail.com ([60.53.81.107])
        by mx.google.com with ESMTPSA id ye1sm17727603pab.19.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:47:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cTNeqNhGwD-EZ3uszh5vJ4JeJ6L0RXdTsveb1FgXE5t3Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234327>

On Mon, Sep 09, 2013 at 01:01:33AM -0400, Eric Sunshine wrote:
> On Sun, Sep 8, 2013 at 9:49 PM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> Thanks for the reference. I did read that thread earlier. It doesn't
> really answer my question, but perhaps it's not terribly important
> since the interaction is documented. I was mainly asking if the choice
> of locking in one particular interpretation was deliberate even though
> other potentially valid (and perhaps more intuitive) interpretations
> exists. More below TL;DR if you care to read on.

Thanks for the clarification. Reroll of the patch to fix the
documentation is at the end of this mail.

> TL;DR
> 
> I was interested in knowing whether the exact interaction between -C
> and --work-tree and --git-dir was intentional (and desirable) or an
> "accident of implementation". I can see it going either way.

The implementation was the simplest one that I could think of for
achieving what I wanted -C to do. I can agree that the side effects with
any other options that handles path argument are "accident of
implementation" and there might be room for improvements, at the expense
of complexity.

> However, it would be equally valid for a user to expect the options to
> be evaluated sequentially such that the above command line would mean:
> 
>   work-tree = foo/bar
>   git-dir = foo/baz/moo
> 
> Is the former interpretation better than the latter possibly more
> intuitive interpretation? This is a genuine question. I'm not
> suggesting that one interpretation is better than the other, and it's
> possible that it won't matter in practice [1], but it might be good to
> know that alternate interpretations have been taken into consideration
> before locking in a particular behavior.
> 
> This is why I was asking if you had particular use-cases in mind where
> the former made more sense than the latter (or some other [2])
> interpretation. Since there are multiple potential interpretations, it
> might make sense to explain in the commit message why the one was
> chosen over the other(s), and such use-cases could help solidify that
> explanation.
> 

When I first experimented the interaction of -C with --git-dir and
--work-tree, I did feel its counter-intuitiveness side effect due to the
implementation. Consider -C's interaction with format-patch:

    $ git -C foo format-patch HEAD~3..

Based on the current implementation, the patch files generated by the
above would in the directory "foo" instead of where git was started
from.

Is it worth the complexity to ensure that subsequent git options,
builtin options, or builtins be aware of where git was started from vs.
the effective "new" directory that it chdir'd into due to the -C option?
I'm not sure about that at the moment. I foresee that it might not be
that simple to get that to work.

I took a look at GNU tar's -C implementation and it seems that for the
equivalent case,:

    $ tar Ccf foo/ foo.tar bar.txt baz.txt

GNU tar is aware of where it was called from and created the file
foo.tar there (instead of in foo/).

Tangent: This now reminds me of a feature that I wished git-grep had -
when run on a non-bare repository, I'd like git-grep to show me the
"usable" path from the point of view of where I started it from,
assuming $PWD is $HOME and my non-bare clone of git.git is in $HOME/src:

    $ git -C src/git grep main git.c
    src/git/git.c:           * Check remaining flags.
    src/git/git.c:int main(int argc, char **av)

instead of the what we have in the current behavior:

    $ git -C src/git grep main git.c
    git.c:           * Check remaining flags.
    git.c:int main(int argc, char **av)

Nazri
-- >8 --
Subject: git: run in a directory given with -C option

This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".

It takes more keypresses to invoke git command in a different
directory than the current one without leaving the current
directory:

    1. (cd ~/foo && git status)
       git --git-dir=~/foo/.git --work-dir=~/foo status
       GIT_DIR=~/foo/.git GIT_WORK_TREE=~/foo git status
    2. (cd ../..; git grep foo)
    3. for d in d1 d2 d3; do (cd $d && git svn rebase); done

While doable the methods shown above are arguably more suitable for
scripting than quick command line invocations.

With this new option, the above can be done with fewer keystrokes:

    1. git -C ~/foo status
    2. git -C ../.. grep foo
    3. for d in d1 d2 d3; do git -C $d svn rebase; done

A new test script is added to verify the behavior of this option with
other path-related options like --git-dir and --work-tree.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 16 +++++++++-
 git.c                 | 13 +++++++-
 t/t0056-git-C.sh      | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100755 t/t0056-git-C.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 83edf30..6622037 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--help] [-c <name>=<value>]
+'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
@@ -395,6 +395,20 @@ displayed. See linkgit:git-help[1] for more information,
 because `git --help ...` is converted internally into `git
 help ...`.
 
+-C <path>::
+	Run as if git was started in '<path>' instead of the current working
+	directory.  When multiple '-C' options are given, each subsequent
+	non-absolute `-C <path>` is interpreted relative to the preceding `-C
+	<path>`.
++
+This option affects options that expect path name like '--git-dir' and
+'--work-tree' in that their interpretations of the path names would be
+made relative to the working directory caused by the '-C' option. For
+example the following invocations are equivalent:
+
+    git --git-dir=a.git --work-tree=b -C c status
+    git --git-dir=c/a.git --work-tree=c/b status
+
 -c <name>=<value>::
 	Pass a configuration parameter to the command. The value
 	given will override values from configuration files.
diff --git a/git.c b/git.c
index 2025f77..a2d99a7 100644
--- a/git.c
+++ b/git.c
@@ -7,7 +7,7 @@
 #include "commit.h"
 
 const char git_usage_string[] =
-	"git [--version] [--help] [-c name=value]\n"
+	"git [--version] [--help] [-C <path>] [-c name=value]\n"
 	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
 	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
@@ -153,6 +153,17 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			set_alternate_shallow_file((*argv)[0]);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "-C")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for -C.\n" );
+				usage(git_usage_string);
+			}
+			if (chdir((*argv)[1]))
+				die_errno("Cannot change to '%s'", (*argv)[1]);
+			if (envchanged)
+				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
new file mode 100755
index 0000000..c0006da
--- /dev/null
+++ b/t/t0056-git-C.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='"-C <path>" option and its effects on other path-related options'
+
+. ./test-lib.sh
+
+test_expect_success '"git -C <path>" runs git from the directory <path>' '
+	test_create_repo dir1 &&
+	echo 1 >dir1/a.txt &&
+	(cd dir1 && git add a.txt && git commit -m "initial in dir1") &&
+	echo "initial in dir1" >expected &&
+	git -C dir1 log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
+	test_create_repo dir1/dir2 &&
+	echo 1 >dir1/dir2/a.txt &&
+	git -C dir1/dir2 add a.txt &&
+	echo "initial in dir1/dir2" >expected &&
+	git -C dir1/dir2 commit -m "initial in dir1/dir2" &&
+	git -C dir1 -C dir2 log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --git-dir option: "-C c --git-dir=a.git" is equivalent to "--git-dir c/a.git"' '
+	mkdir c &&
+	mkdir c/a &&
+	mkdir c/a.git &&
+	(cd c/a.git && git init --bare) &&
+	echo 1 >c/a/a.txt &&
+	git --git-dir c/a.git --work-tree=c/a add a.txt &&
+	git --git-dir c/a.git --work-tree=c/a commit -m "initial" &&
+	git --git-dir=c/a.git log -1 --format=%s >expected &&
+	git -C c --git-dir=a.git log -1 --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "--git-dir=a.git -C c" is equivalent to "-C c --git-dir=a.git"' '
+	git -C c --git-dir=a.git log -1 --format=%s >expected &&
+	git --git-dir=a.git -C c log -1 --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --work-tree option: "-C c/a.git --work-tree=../a"  is equivalent to "--work-tree=c/a --git-dir=c/a.git"' '
+	rm c/a/a.txt &&
+	git --git-dir=c/a.git --work-tree=c/a status >expected &&
+	git -C c/a.git --work-tree=../a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "--work-tree=../a -C c/a.git" is equivalent to "-C c/a.git --work-tree=../a"' '
+	git -C c/a.git --work-tree=../a status >expected &&
+	git --work-tree=../a -C c/a.git status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --git-dir and --work-tree options - "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=c/a.git --work-tree=c/a"' '
+	git --git-dir=c/a.git --work-tree=c/a status >expected &&
+	git -C c --git-dir=a.git --work-tree=a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git -C c --work-tree=a"' '
+	git -C c --git-dir=a.git --work-tree=a status >expected &&
+	git --git-dir=a.git -C c --work-tree=a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git --work-tree=a -C c"' '
+	git -C c --git-dir=a.git --work-tree=a status >expected &&
+	git --git-dir=a.git --work-tree=a -C c status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Relative followed by fullpath: "-C ./here -C /there" is equivalent to "-C /there"' '
+	echo "initial in dir1/dir2" >expected &&
+	git -C dir1 -C "$(pwd)/dir1/dir2" log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.8.4.100.gd06f3e9
