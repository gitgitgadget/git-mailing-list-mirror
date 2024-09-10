Received: from impout001.msg.chrl.nc.charter.net (impout001aa.msg.chrl.nc.charter.net [47.43.20.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1E1514DA
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941534; cv=none; b=ox+1oMQ0Ph1NVzgj7HcTo+PUNwVPcGCVolSBFVZVdV3uK6dUzwZWNC/vW7YC9JNo5GyIGGkJ41EeST4WnjUOHi5wOKudbVx5f2YoNxA1N2DLeSOkw7dVN4eORtdQ3w/wWG2gujuPn3KL66SgSYrwER81ROm2mE8WgWmA6NNRukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941534; c=relaxed/simple;
	bh=g7cDg7nzAcHanah8upVp/j5NTxtQl6meo7phSTMRwx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4KUSf39UCprHws6g4/XlCGoM2c3VSMt6tRXkuIlVBjI34RKWbLKzR2jGJNkRKS8wBpSNnYSAvclU6LXWPM0ONsxZvaDYJRH3gpr/9uFFob6g8r3212YH+itBr9lyJ8IOCNZbk9m7sLDotSZkbW0zZqAVP//pGeI3ToPQ6hpqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=yGYtreNk; arc=none smtp.client-ip=47.43.20.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="yGYtreNk"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id nsCys18E7ZJqtnsD3sAPjs; Tue, 10 Sep 2024 04:10:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1725941433;
	bh=g7cDg7nzAcHanah8upVp/j5NTxtQl6meo7phSTMRwx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yGYtreNkvbc7gv9nKN8M3BuDFqrhkPSGamnq8WoRUO1EWSdRgrSybAe1fNGbz0l/T
	 ZpkJf5Iz5gLfn6apqsXCx+a91zyGV05Lpk2OH7dYKzZcpl/a4YdhEABUy5KRbvEEjf
	 Y2S7s8ik8GUjFL6j74XT8uwB88hY75JfPpVV2iA6oHnpbAlj9BPn1lONf7gCrcqwCW
	 0LvkxBMdh0Y27KmJF5oneyFHuajzu9v3ba/A7vW2HJ7e+wbXWzpcurrKzMklQvNmYS
	 y1mabGbxSGISijcWS43F+N0tVGw6wVC2pQ1Lf2FLFImnH7ihRgyfcL4eMSJgfuMvyq
	 l4UogjVw06e2Q==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=GtNE+F1C c=1 sm=1 tr=0 ts=66dfc6b9
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=hOpmn2quAAAA:8 a=LqDmH63K4Xux3KnvLUsA:9
 a=i45p8BNiE2aENmjR:21 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] make chainlint output more newcomer-friendly
Date: Tue, 10 Sep 2024 00:10:10 -0400
Message-ID: <20240910041013.68948-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829091625.41297-1-ericsunshine@charter.net>
References: <20240829091625.41297-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFMdiF0aYnDTo2iuqevX2XOVlKhdzOcS7DUkb0bjmsa5TqGgL5cnh3PQQ6fEfvM+kd4lbOK+oADG5Yc8L7XoijnWJdhB09tDxpmAtOR3otbEone44pFK
 EQfLO1+8zaHfFSH/r62Caf8KcRTPGfOehGBst2CHjpKNk+UTEWQIAof15WRU5OYAT4l3vPYseoa5+juD4fQpx+a0YQwAxgj0ILgXbKde0HxPzgvSD06yWxNy
 NCCibEt1sk3ogOu5aLOeG6g9VWHyIENnsfCpC7hIAh5cWiJx2zKNRBwA8CC/6Ia4l30CDsI9Pychl1t1thFwog==

From: Eric Sunshine <sunshine@sunshineco.com>

This is a reroll of [1] which (hopefully) makes chainlint's problem
annotations more friendly and helpful for newcomers. In particular, it
ditches the cryptic "AMP", "LOOP", etc. and replaces them with proper
error messages.

Changes since v1:

* new patch [1/3] -- motivated by Junio's observation[2] about
  availability of structured problem information -- takes advantage of
  that information directly rather than post-processing "?!...?!"
  sequences in the output stream

* old patch [2/2] (now [3/3]) which drops "?!" decorations when emitting
  colored output to a terminal partially justified the change by
  claiming that the new "ERR" (or "ERR:") prefix is a good "needle" for
  a terminal's search feature, thus the noisy "?!" is no longer needed;
  however, I realized that "ERR" (or "ERR:") is, in fact, an awful
  needle since the string "err" (or "err:") is quite likely to
  legitimately appear in source text, hence I changed the prefix to
  "LINT:" (with the colon since Patrick found lack of colon
  confusing[3])

* rewrote commit messages based upon feedback from Junio[2,4]

* dropped an unused argument from the call to format_problem() which was
  an artifact used briefly during development of v1

Unfortunately, the included range-diff is a mess and pretty much useless
since half the changes from old patch [2/2] (now [3/3]) migrated to new
patch [1/3], and range-diff thinks that [1/3] is a rewrite of old [2/2]
and that old [2/2] is now entirely new [3/3] which is exactly opposite
what really happened, and I wasn't able to convince range-diff to
reconsider. Hence, I also included an interdiff which is easier to read
but doesn't show improvements to the commit messages.

[1]: https://lore.kernel.org/git/20240829091625.41297-1-ericsunshine@charter.net/
[2]: https://lore.kernel.org/git/xmqqv7zjwcgq.fsf@gitster.g/
[3]: https://lore.kernel.org/git/ZtBHbftK7vdTEz93@tanuki/
[4]: https://lore.kernel.org/git/xmqq7cbzxrry.fsf@gitster.g/

Eric Sunshine (3):
  chainlint: don't be fooled by "?!...?!" in test body
  chainlint: make error messages self-explanatory
  chainlint: reduce annotation noise-factor

 t/chainlint.pl                                | 42 +++++++++++++------
 t/chainlint/arithmetic-expansion.expect       |  2 +-
 t/chainlint/block.expect                      |  8 ++--
 t/chainlint/broken-chain.expect               |  2 +-
 t/chainlint/case.expect                       |  4 +-
 t/chainlint/chain-break-false.expect          |  2 +-
 t/chainlint/chained-block.expect              |  2 +-
 t/chainlint/chained-subshell.expect           |  4 +-
 t/chainlint/command-substitution.expect       |  2 +-
 t/chainlint/complex-if-in-cuddled-loop.expect |  2 +-
 t/chainlint/cuddled.expect                    |  4 +-
 t/chainlint/for-loop.expect                   |  8 ++--
 t/chainlint/function.expect                   |  4 +-
 t/chainlint/here-doc-body-indent.expect       |  2 +-
 t/chainlint/here-doc-body-pathological.expect |  4 +-
 t/chainlint/here-doc-body.expect              |  4 +-
 t/chainlint/here-doc-double.expect            |  2 +-
 t/chainlint/here-doc-indent-operator.expect   |  2 +-
 .../here-doc-multi-line-command-subst.expect  |  2 +-
 t/chainlint/here-doc-multi-line-string.expect |  2 +-
 t/chainlint/if-condition-split.expect         |  2 +-
 t/chainlint/if-in-loop.expect                 |  4 +-
 t/chainlint/if-then-else.expect               |  4 +-
 t/chainlint/inline-comment.expect             |  2 +-
 t/chainlint/loop-detect-failure.expect        |  2 +-
 t/chainlint/loop-in-if.expect                 |  8 ++--
 t/chainlint/multi-line-string.expect          |  2 +-
 t/chainlint/negated-one-liner.expect          |  4 +-
 t/chainlint/nested-cuddled-subshell.expect    |  6 +--
 t/chainlint/nested-here-doc.expect            |  2 +-
 t/chainlint/nested-loop-detect-failure.expect |  6 +--
 t/chainlint/nested-subshell-comment.expect    |  2 +-
 t/chainlint/nested-subshell.expect            |  2 +-
 t/chainlint/not-heredoc.expect                |  2 +-
 t/chainlint/one-liner-for-loop.expect         |  2 +-
 t/chainlint/one-liner.expect                  |  6 +--
 t/chainlint/pipe.expect                       |  2 +-
 t/chainlint/semicolon.expect                  | 12 +++---
 t/chainlint/subshell-here-doc.expect          |  2 +-
 t/chainlint/subshell-one-liner.expect         | 10 ++---
 t/chainlint/token-pasting.expect              |  8 ++--
 t/chainlint/unclosed-here-doc-indent.expect   |  2 +-
 t/chainlint/unclosed-here-doc.expect          |  2 +-
 t/chainlint/while-loop.expect                 |  8 ++--
 t/test-lib.sh                                 |  2 +-
 45 files changed, 113 insertions(+), 95 deletions(-)


Interdiff against v1:
diff --git a/t/chainlint.pl b/t/chainlint.pl
index 971ab9212a..f0598e3934 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -9,9 +9,9 @@
 # Input arguments are pathnames of shell scripts containing test definitions,
 # or globs referencing a collection of scripts. For each problem discovered,
 # the pathname of the script containing the test is printed along with the test
-# name and the test body with a `?!ERR?!` annotation at the location of each
-# detected problem, where "FOO" is a tag such as "AMP" which indicates a broken
-# &&-chain. Returns zero if no problems are discovered, otherwise non-zero.
+# name and the test body with a `?!LINT: ...?!` annotation at the location of
+# each detected problem, where "..." is an explanation of the problem. Returns
+# zero if no problems are discovered, otherwise non-zero.
 
 use warnings;
 use strict;
@@ -657,16 +657,17 @@ sub check_test {
 	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
 		my ($label, $token) = @$_;
 		my $pos = $token->[2];
-		my $err = format_problem($label, $token);
-		$checked .= substr($body, $start, $pos - $start) . " ?!ERR $err?! ";
+		my $err = format_problem($label);
+		$checked .= substr($body, $start, $pos - $start);
+		$checked .= ' ' unless $checked =~ /\s$/;
+		$checked .= "${erropen}LINT: $err$errclose";
+		$checked .= ' ' unless $pos >= length($body) ||
+		    substr($body, $pos, 1) =~ /^\s/;
 		$start = $pos;
 	}
 	$checked .= substr($body, $start);
 	$checked =~ s/^/$lineno++ . ' '/mge;
 	$checked =~ s/^\d+ \n//;
-	$checked =~ s/(\s) \?!/$1?!/mg;
-	$checked =~ s/\?! (\s)/?!$1/mg;
-	$checked =~ s/\?!([^?]+)\?!/$erropen$1$errclose/mg;
 	$checked =~ s/^\d+/$c->{dim}$&$c->{reset}/mg;
 	$checked .= "\n" unless $checked =~ /\n$/;
 	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
diff --git a/t/chainlint/arithmetic-expansion.expect b/t/chainlint/arithmetic-expansion.expect
index 2efd65dcbd..5677e16cad 100644
--- a/t/chainlint/arithmetic-expansion.expect
+++ b/t/chainlint/arithmetic-expansion.expect
@@ -4,6 +4,6 @@
 5 	baz
 6 ) &&
 7 (
-8 	bar=$((42 + 1)) ?!ERR missing '&&'?!
+8 	bar=$((42 + 1)) ?!LINT: missing '&&'?!
 9 	baz
 10 )
diff --git a/t/chainlint/block.expect b/t/chainlint/block.expect
index 28410b33ef..3d3f854c0d 100644
--- a/t/chainlint/block.expect
+++ b/t/chainlint/block.expect
@@ -1,20 +1,20 @@
 2 (
 3 	foo &&
 4 	{
-5 		echo a ?!ERR missing '&&'?!
+5 		echo a ?!LINT: missing '&&'?!
 6 		echo b
 7 	} &&
 8 	bar &&
 9 	{
 10 		echo c
-11 	} ?!ERR missing '&&'?!
+11 	} ?!LINT: missing '&&'?!
 12 	baz
 13 ) &&
 14 
 15 {
-16 	echo a; ?!ERR missing '&&'?! echo b
+16 	echo a; ?!LINT: missing '&&'?! echo b
 17 } &&
-18 { echo a; ?!ERR missing '&&'?! echo b; } &&
+18 { echo a; ?!LINT: missing '&&'?! echo b; } &&
 19 
 20 {
 21 	echo "${var}9" &&
diff --git a/t/chainlint/broken-chain.expect b/t/chainlint/broken-chain.expect
index 2a209df0a7..b7b1ce8509 100644
--- a/t/chainlint/broken-chain.expect
+++ b/t/chainlint/broken-chain.expect
@@ -1,6 +1,6 @@
 2 (
 3 	foo &&
-4 	bar ?!ERR missing '&&'?!
+4 	bar ?!LINT: missing '&&'?!
 5 	baz &&
 6 	wop
 7 )
diff --git a/t/chainlint/case.expect b/t/chainlint/case.expect
index d00b67b766..0a3b09e470 100644
--- a/t/chainlint/case.expect
+++ b/t/chainlint/case.expect
@@ -9,11 +9,11 @@
 10 	case "$x" in
 11 	x) foo ;;
 12 	*) bar ;;
-13 	esac ?!ERR missing '&&'?!
+13 	esac ?!LINT: missing '&&'?!
 14 	foobar
 15 ) &&
 16 (
 17 	case "$x" in 1) true;; esac &&
-18 	case "$y" in 2) false;; esac ?!ERR missing '&&'?!
+18 	case "$y" in 2) false;; esac ?!LINT: missing '&&'?!
 19 	foobar
 20 )
diff --git a/t/chainlint/chain-break-false.expect b/t/chainlint/chain-break-false.expect
index bfccc0d90f..f6a0a301e9 100644
--- a/t/chainlint/chain-break-false.expect
+++ b/t/chainlint/chain-break-false.expect
@@ -4,6 +4,6 @@
 5 	echo failed!
 6 	false
 7 else
-8 	echo it went okay ?!ERR missing '&&'?!
+8 	echo it went okay ?!LINT: missing '&&'?!
 9 	congratulate user
 10 fi
diff --git a/t/chainlint/chained-block.expect b/t/chainlint/chained-block.expect
index 293d9eac42..f2501bba90 100644
--- a/t/chainlint/chained-block.expect
+++ b/t/chainlint/chained-block.expect
@@ -1,5 +1,5 @@
 2 echo nobody home && {
-3 	test the doohicky ?!ERR missing '&&'?!
+3 	test the doohicky ?!LINT: missing '&&'?!
 4 	right now
 5 } &&
 6 
diff --git a/t/chainlint/chained-subshell.expect b/t/chainlint/chained-subshell.expect
index 2f5de4fead..93fb1a6578 100644
--- a/t/chainlint/chained-subshell.expect
+++ b/t/chainlint/chained-subshell.expect
@@ -1,10 +1,10 @@
 2 mkdir sub && (
 3 	cd sub &&
-4 	foo the bar ?!ERR missing '&&'?!
+4 	foo the bar ?!LINT: missing '&&'?!
 5 	nuff said
 6 ) &&
 7 
 8 cut "-d " -f actual | (read s1 s2 s3 &&
-9 test -f $s1 ?!ERR missing '&&'?!
+9 test -f $s1 ?!LINT: missing '&&'?!
 10 test $(cat $s2) = tree2path1 &&
 11 test $(cat $s3) = tree3path1)
diff --git a/t/chainlint/command-substitution.expect b/t/chainlint/command-substitution.expect
index 511c918cb5..73809fd585 100644
--- a/t/chainlint/command-substitution.expect
+++ b/t/chainlint/command-substitution.expect
@@ -4,6 +4,6 @@
 5 	baz
 6 ) &&
 7 (
-8 	bar=$(gobble blocks) ?!ERR missing '&&'?!
+8 	bar=$(gobble blocks) ?!LINT: missing '&&'?!
 9 	baz
 10 )
diff --git a/t/chainlint/complex-if-in-cuddled-loop.expect b/t/chainlint/complex-if-in-cuddled-loop.expect
index eb855378a1..e66bb2d5d0 100644
--- a/t/chainlint/complex-if-in-cuddled-loop.expect
+++ b/t/chainlint/complex-if-in-cuddled-loop.expect
@@ -4,6 +4,6 @@
 5      :
 6    else
 7      echo >file
-8    fi ?!ERR missing '|| exit 1'?!
+8    fi ?!LINT: missing '|| exit 1'?!
 9  done) &&
 10 test ! -f file
diff --git a/t/chainlint/cuddled.expect b/t/chainlint/cuddled.expect
index 65825c6879..1864b3fc8b 100644
--- a/t/chainlint/cuddled.expect
+++ b/t/chainlint/cuddled.expect
@@ -2,7 +2,7 @@
 3 	bar
 4 ) &&
 5 
-6 (cd foo ?!ERR missing '&&'?!
+6 (cd foo ?!LINT: missing '&&'?!
 7 	bar
 8 ) &&
 9 
@@ -13,5 +13,5 @@
 14 (cd foo &&
 15 	bar) &&
 16 
-17 (cd foo ?!ERR missing '&&'?!
+17 (cd foo ?!LINT: missing '&&'?!
 18 	bar)
diff --git a/t/chainlint/for-loop.expect b/t/chainlint/for-loop.expect
index df6fc1a35f..5029eacce3 100644
--- a/t/chainlint/for-loop.expect
+++ b/t/chainlint/for-loop.expect
@@ -1,14 +1,14 @@
 2 (
 3 	for i in a b c
 4 	do
-5 		echo $i ?!ERR missing '&&'?!
-6 		cat <<-\EOF ?!ERR missing '|| exit 1'?!
+5 		echo $i ?!LINT: missing '&&'?!
+6 		cat <<-\EOF ?!LINT: missing '|| exit 1'?!
 7 		bar
 8 		EOF
-9 	done ?!ERR missing '&&'?!
+9 	done ?!LINT: missing '&&'?!
 10 
 11 	for i in a b c; do
 12 		echo $i &&
-13 		cat $i ?!ERR missing '|| exit 1'?!
+13 		cat $i ?!LINT: missing '|| exit 1'?!
 14 	done
 15 )
diff --git a/t/chainlint/function.expect b/t/chainlint/function.expect
index 7a15be745b..9e46a3554a 100644
--- a/t/chainlint/function.expect
+++ b/t/chainlint/function.expect
@@ -4,8 +4,8 @@
 5 
 6 remove_object() {
 7 	file=$(sha1_file "$*") &&
-8 	test -e "$file" ?!ERR missing '&&'?!
+8 	test -e "$file" ?!LINT: missing '&&'?!
 9 	rm -f "$file"
-10 } ?!ERR missing '&&'?!
+10 } ?!LINT: missing '&&'?!
 11 
 12 sha1_file arg && remove_object arg
diff --git a/t/chainlint/here-doc-body-indent.expect b/t/chainlint/here-doc-body-indent.expect
index 1d7298c8ad..4306faee86 100644
--- a/t/chainlint/here-doc-body-indent.expect
+++ b/t/chainlint/here-doc-body-indent.expect
@@ -1,2 +1,2 @@
-2 	echo "we should find this" ?!ERR missing '&&'?!
+2 	echo "we should find this" ?!LINT: missing '&&'?!
 3 	echo "even though our heredoc has its indent stripped"
diff --git a/t/chainlint/here-doc-body-pathological.expect b/t/chainlint/here-doc-body-pathological.expect
index 828f232616..2f8ea03a47 100644
--- a/t/chainlint/here-doc-body-pathological.expect
+++ b/t/chainlint/here-doc-body-pathological.expect
@@ -1,7 +1,7 @@
-2 	echo "outer here-doc does not allow indented end-tag" ?!ERR missing '&&'?!
+2 	echo "outer here-doc does not allow indented end-tag" ?!LINT: missing '&&'?!
 3 	cat >file <<-\EOF &&
 4 	but this inner here-doc
 5 	does allow indented EOF
 6 	EOF
-7 	echo "missing chain after" ?!ERR missing '&&'?!
+7 	echo "missing chain after" ?!LINT: missing '&&'?!
 8 	echo "but this line is OK because it's the end"
diff --git a/t/chainlint/here-doc-body.expect b/t/chainlint/here-doc-body.expect
index 79b9603c1e..df8d79bc0a 100644
--- a/t/chainlint/here-doc-body.expect
+++ b/t/chainlint/here-doc-body.expect
@@ -1,7 +1,7 @@
-2 	echo "missing chain before" ?!ERR missing '&&'?!
+2 	echo "missing chain before" ?!LINT: missing '&&'?!
 3 	cat >file <<-\EOF &&
 4 	inside inner here-doc
 5 	these are not shell commands
 6 	EOF
-7 	echo "missing chain after" ?!ERR missing '&&'?!
+7 	echo "missing chain after" ?!LINT: missing '&&'?!
 8 	echo "but this line is OK because it's the end"
diff --git a/t/chainlint/here-doc-double.expect b/t/chainlint/here-doc-double.expect
index 9cb1a1a5e3..e5e981889f 100644
--- a/t/chainlint/here-doc-double.expect
+++ b/t/chainlint/here-doc-double.expect
@@ -1,2 +1,2 @@
-8 	echo "actual test commands" ?!ERR missing '&&'?!
+8 	echo "actual test commands" ?!LINT: missing '&&'?!
 9 	echo "that should be checked"
diff --git a/t/chainlint/here-doc-indent-operator.expect b/t/chainlint/here-doc-indent-operator.expect
index 2d61e5f49d..ec0e61505b 100644
--- a/t/chainlint/here-doc-indent-operator.expect
+++ b/t/chainlint/here-doc-indent-operator.expect
@@ -4,7 +4,7 @@
 5 chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
 6 EOF
 7 
-8 cat >expect << -EOF ?!ERR missing '&&'?!
+8 cat >expect << -EOF ?!LINT: missing '&&'?!
 9 this is not indented
 10 -EOF
 11 
diff --git a/t/chainlint/here-doc-multi-line-command-subst.expect b/t/chainlint/here-doc-multi-line-command-subst.expect
index 881e4d2098..8128f15b92 100644
--- a/t/chainlint/here-doc-multi-line-command-subst.expect
+++ b/t/chainlint/here-doc-multi-line-command-subst.expect
@@ -3,6 +3,6 @@
 4 		fossil
 5 		vegetable
 6 		END
-7 		wiffle) ?!ERR missing '&&'?!
+7 		wiffle) ?!LINT: missing '&&'?!
 8 	echo $x
 9 )
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
index 06c791e0a4..a03a04ff3d 100644
--- a/t/chainlint/here-doc-multi-line-string.expect
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -1,6 +1,6 @@
 2 (
 3 	cat <<-\TXT && echo "multi-line
-4 	string" ?!ERR missing '&&'?!
+4 	string" ?!LINT: missing '&&'?!
 5 	fizzle
 6 	TXT
 7 	bap
diff --git a/t/chainlint/if-condition-split.expect b/t/chainlint/if-condition-split.expect
index 5688d93a4f..6d2a03dfdb 100644
--- a/t/chainlint/if-condition-split.expect
+++ b/t/chainlint/if-condition-split.expect
@@ -2,6 +2,6 @@
 3    marcia ||
 4    kevin
 5 then
-6 	echo "nomads" ?!ERR missing '&&'?!
+6 	echo "nomads" ?!LINT: missing '&&'?!
 7 	echo "for sure"
 8 fi
diff --git a/t/chainlint/if-in-loop.expect b/t/chainlint/if-in-loop.expect
index 253b461f87..7e3ba740de 100644
--- a/t/chainlint/if-in-loop.expect
+++ b/t/chainlint/if-in-loop.expect
@@ -5,8 +5,8 @@
 6 		then
 7 			echo "err"
 8 			exit 1
-9 		fi ?!ERR missing '&&'?!
+9 		fi ?!LINT: missing '&&'?!
 10 		foo
-11 	done ?!ERR missing '&&'?!
+11 	done ?!LINT: missing '&&'?!
 12 	bar
 13 )
diff --git a/t/chainlint/if-then-else.expect b/t/chainlint/if-then-else.expect
index 1b3162759f..924caa2e4e 100644
--- a/t/chainlint/if-then-else.expect
+++ b/t/chainlint/if-then-else.expect
@@ -1,7 +1,7 @@
 2 (
 3 	if test -n ""
 4 	then
-5 		echo very ?!ERR missing '&&'?!
+5 		echo very ?!LINT: missing '&&'?!
 6 		echo empty
 7 	elif test -z ""
 8 	then
@@ -11,7 +11,7 @@
 12 		cat <<-\EOF
 13 		bar
 14 		EOF
-15 	fi ?!ERR missing '&&'?!
+15 	fi ?!LINT: missing '&&'?!
 16 	echo poodle
 17 ) &&
 18 (
diff --git a/t/chainlint/inline-comment.expect b/t/chainlint/inline-comment.expect
index fedc059a0c..4b4080124e 100644
--- a/t/chainlint/inline-comment.expect
+++ b/t/chainlint/inline-comment.expect
@@ -1,6 +1,6 @@
 2 (
 3 	foobar && # comment 1
-4 	barfoo ?!ERR missing '&&'?! # wrong position for &&
+4 	barfoo ?!LINT: missing '&&'?! # wrong position for &&
 5 	flibble "not a # comment"
 6 ) &&
 7 
diff --git a/t/chainlint/loop-detect-failure.expect b/t/chainlint/loop-detect-failure.expect
index 2d46f6d2eb..7d846b878d 100644
--- a/t/chainlint/loop-detect-failure.expect
+++ b/t/chainlint/loop-detect-failure.expect
@@ -11,5 +11,5 @@
 12 do
 13 	printf "%"$n"s" X > r2/large.$n &&
 14 	git -C r2 add large.$n &&
-15 	git -C r2 commit -m "$n" ?!ERR missing '|| return 1'?!
+15 	git -C r2 commit -m "$n" ?!LINT: missing '|| return 1'?!
 16 done
diff --git a/t/chainlint/loop-in-if.expect b/t/chainlint/loop-in-if.expect
index 8936d7ff2d..32e076ad1b 100644
--- a/t/chainlint/loop-in-if.expect
+++ b/t/chainlint/loop-in-if.expect
@@ -3,10 +3,10 @@
 4 	then
 5 		while true
 6 		do
-7 			echo "pop" ?!ERR missing '&&'?!
-8 			echo "glup" ?!ERR missing '|| exit 1'?!
-9 		done ?!ERR missing '&&'?!
+7 			echo "pop" ?!LINT: missing '&&'?!
+8 			echo "glup" ?!LINT: missing '|| exit 1'?!
+9 		done ?!LINT: missing '&&'?!
 10 		foo
-11 	fi ?!ERR missing '&&'?!
+11 	fi ?!LINT: missing '&&'?!
 12 	bar
 13 )
diff --git a/t/chainlint/multi-line-string.expect b/t/chainlint/multi-line-string.expect
index 3c3a1de75c..9d33297525 100644
--- a/t/chainlint/multi-line-string.expect
+++ b/t/chainlint/multi-line-string.expect
@@ -3,7 +3,7 @@
 4 		line 2
 5 		line 3" &&
 6 	y="line 1
-7 		line2" ?!ERR missing '&&'?!
+7 		line2" ?!LINT: missing '&&'?!
 8 	foobar
 9 ) &&
 10 (
diff --git a/t/chainlint/negated-one-liner.expect b/t/chainlint/negated-one-liner.expect
index 12bd65264a..0a6f3c29b2 100644
--- a/t/chainlint/negated-one-liner.expect
+++ b/t/chainlint/negated-one-liner.expect
@@ -1,5 +1,5 @@
 2 ! (foo && bar) &&
 3 ! (foo && bar) >baz &&
 4 
-5 ! (foo; ?!ERR missing '&&'?! bar) &&
-6 ! (foo; ?!ERR missing '&&'?! bar) >baz
+5 ! (foo; ?!LINT: missing '&&'?! bar) &&
+6 ! (foo; ?!LINT: missing '&&'?! bar) >baz
diff --git a/t/chainlint/nested-cuddled-subshell.expect b/t/chainlint/nested-cuddled-subshell.expect
index 3e947ea5e1..fec2c74274 100644
--- a/t/chainlint/nested-cuddled-subshell.expect
+++ b/t/chainlint/nested-cuddled-subshell.expect
@@ -5,7 +5,7 @@
 6 
 7 	(cd foo &&
 8 		bar
-9 	) ?!ERR missing '&&'?!
+9 	) ?!LINT: missing '&&'?!
 10 
 11 	(
 12 		cd foo &&
@@ -13,13 +13,13 @@
 14 
 15 	(
 16 		cd foo &&
-17 		bar) ?!ERR missing '&&'?!
+17 		bar) ?!LINT: missing '&&'?!
 18 
 19 	(cd foo &&
 20 		bar) &&
 21 
 22 	(cd foo &&
-23 		bar) ?!ERR missing '&&'?!
+23 		bar) ?!LINT: missing '&&'?!
 24 
 25 	foobar
 26 )
diff --git a/t/chainlint/nested-here-doc.expect b/t/chainlint/nested-here-doc.expect
index 107e5afb01..571f4c9514 100644
--- a/t/chainlint/nested-here-doc.expect
+++ b/t/chainlint/nested-here-doc.expect
@@ -18,7 +18,7 @@
 19 	toink
 20 	INPUT_END
 21 
-22 	cat <<-\EOT ?!ERR missing '&&'?!
+22 	cat <<-\EOT ?!LINT: missing '&&'?!
 23 	text goes here
 24 	data <<EOF
 25 		data goes here
diff --git a/t/chainlint/nested-loop-detect-failure.expect b/t/chainlint/nested-loop-detect-failure.expect
index 26557b05a1..b4aaa621a2 100644
--- a/t/chainlint/nested-loop-detect-failure.expect
+++ b/t/chainlint/nested-loop-detect-failure.expect
@@ -2,8 +2,8 @@
 3 do
 4 	for j in 0 1 2 3 4 5 6 7 8 9;
 5 	do
-6 		echo "$i$j" >"path$i$j" ?!ERR missing '|| return 1'?!
-7 	done ?!ERR missing '|| return 1'?!
+6 		echo "$i$j" >"path$i$j" ?!LINT: missing '|| return 1'?!
+7 	done ?!LINT: missing '|| return 1'?!
 8 done &&
 9 
 10 for i in 0 1 2 3 4 5 6 7 8 9;
@@ -18,7 +18,7 @@
 19 do
 20 	for j in 0 1 2 3 4 5 6 7 8 9;
 21 	do
-22 		echo "$i$j" >"path$i$j" ?!ERR missing '|| return 1'?!
+22 		echo "$i$j" >"path$i$j" ?!LINT: missing '|| return 1'?!
 23 	done || return 1
 24 done &&
 25 
diff --git a/t/chainlint/nested-subshell-comment.expect b/t/chainlint/nested-subshell-comment.expect
index c6891919c0..078c6f275f 100644
--- a/t/chainlint/nested-subshell-comment.expect
+++ b/t/chainlint/nested-subshell-comment.expect
@@ -6,6 +6,6 @@
 7 		# minor numbers of cows (or do they?)
 8 		baz &&
 9 		snaff
-10 	) ?!ERR missing '&&'?!
+10 	) ?!LINT: missing '&&'?!
 11 	fuzzy
 12 )
diff --git a/t/chainlint/nested-subshell.expect b/t/chainlint/nested-subshell.expect
index b98d723edf..a8d85d5d5b 100644
--- a/t/chainlint/nested-subshell.expect
+++ b/t/chainlint/nested-subshell.expect
@@ -7,7 +7,7 @@
 8 
 9 	cd foo &&
 10 	(
-11 		echo a ?!ERR missing '&&'?!
+11 		echo a ?!LINT: missing '&&'?!
 12 		echo b
 13 	) >file
 14 )
diff --git a/t/chainlint/not-heredoc.expect b/t/chainlint/not-heredoc.expect
index 9910621103..5d51705a7a 100644
--- a/t/chainlint/not-heredoc.expect
+++ b/t/chainlint/not-heredoc.expect
@@ -9,6 +9,6 @@
 10 	echo ourside &&
 11 	echo "=======" &&
 12 	echo theirside &&
-13 	echo ">>>>>>> theirs" ?!ERR missing '&&'?!
+13 	echo ">>>>>>> theirs" ?!LINT: missing '&&'?!
 14 	poodle
 15 ) >merged
diff --git a/t/chainlint/one-liner-for-loop.expect b/t/chainlint/one-liner-for-loop.expect
index 2eb2d5fcaf..e1fcbd3639 100644
--- a/t/chainlint/one-liner-for-loop.expect
+++ b/t/chainlint/one-liner-for-loop.expect
@@ -3,7 +3,7 @@
 4 	cd dir-rename-and-content &&
 5 	test_write_lines 1 2 3 4 5 >foo &&
 6 	mkdir olddir &&
-7 	for i in a b c; do echo $i >olddir/$i; ?!ERR missing '|| exit 1'?! done ?!ERR missing '&&'?!
+7 	for i in a b c; do echo $i >olddir/$i; ?!LINT: missing '|| exit 1'?! done ?!LINT: missing '&&'?!
 8 	git add foo olddir &&
 9 	git commit -m "original" &&
 10 )
diff --git a/t/chainlint/one-liner.expect b/t/chainlint/one-liner.expect
index 2c5826e6c4..5deeb05070 100644
--- a/t/chainlint/one-liner.expect
+++ b/t/chainlint/one-liner.expect
@@ -2,8 +2,8 @@
 3 (foo && bar) |
 4 (foo && bar) >baz &&
 5 
-6 (foo; ?!ERR missing '&&'?! bar) &&
-7 (foo; ?!ERR missing '&&'?! bar) |
-8 (foo; ?!ERR missing '&&'?! bar) >baz &&
+6 (foo; ?!LINT: missing '&&'?! bar) &&
+7 (foo; ?!LINT: missing '&&'?! bar) |
+8 (foo; ?!LINT: missing '&&'?! bar) >baz &&
 9 
 10 (foo "bar; baz")
diff --git a/t/chainlint/pipe.expect b/t/chainlint/pipe.expect
index a198d5bdb2..d947c76584 100644
--- a/t/chainlint/pipe.expect
+++ b/t/chainlint/pipe.expect
@@ -4,7 +4,7 @@
 5 	baz &&
 6 
 7 	fish |
-8 	cow ?!ERR missing '&&'?!
+8 	cow ?!LINT: missing '&&'?!
 9 
 10 	sunder
 11 )
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
index e22920bf2c..2b499fbe70 100644
--- a/t/chainlint/semicolon.expect
+++ b/t/chainlint/semicolon.expect
@@ -1,19 +1,19 @@
 2 (
-3 	cat foo ; ?!ERR missing '&&'?! echo bar ?!ERR missing '&&'?!
-4 	cat foo ; ?!ERR missing '&&'?! echo bar
+3 	cat foo ; ?!LINT: missing '&&'?! echo bar ?!LINT: missing '&&'?!
+4 	cat foo ; ?!LINT: missing '&&'?! echo bar
 5 ) &&
 6 (
-7 	cat foo ; ?!ERR missing '&&'?! echo bar &&
-8 	cat foo ; ?!ERR missing '&&'?! echo bar
+7 	cat foo ; ?!LINT: missing '&&'?! echo bar &&
+8 	cat foo ; ?!LINT: missing '&&'?! echo bar
 9 ) &&
 10 (
 11 	echo "foo; bar" &&
-12 	cat foo; ?!ERR missing '&&'?! echo bar
+12 	cat foo; ?!LINT: missing '&&'?! echo bar
 13 ) &&
 14 (
 15 	foo;
 16 ) &&
 17 (cd foo &&
 18 	for i in a b c; do
-19 		echo; ?!ERR missing '|| exit 1'?!
+19 		echo; ?!LINT: missing '|| exit 1'?!
 20 	done)
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 953d8084e5..e450caf948 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -6,7 +6,7 @@
 7 	nevermore...
 8 	EOF
 9 
-10 	cat <<EOF >bip ?!ERR missing '&&'?!
+10 	cat <<EOF >bip ?!LINT: missing '&&'?!
 11 	fish fly high
 12 EOF
 13 
diff --git a/t/chainlint/subshell-one-liner.expect b/t/chainlint/subshell-one-liner.expect
index f82296db66..265d996a21 100644
--- a/t/chainlint/subshell-one-liner.expect
+++ b/t/chainlint/subshell-one-liner.expect
@@ -3,17 +3,17 @@
 4 	(foo && bar) |
 5 	(foo && bar) >baz &&
 6 
-7 	(foo; ?!ERR missing '&&'?! bar) &&
-8 	(foo; ?!ERR missing '&&'?! bar) |
-9 	(foo; ?!ERR missing '&&'?! bar) >baz &&
+7 	(foo; ?!LINT: missing '&&'?! bar) &&
+8 	(foo; ?!LINT: missing '&&'?! bar) |
+9 	(foo; ?!LINT: missing '&&'?! bar) >baz &&
 10 
 11 	(foo || exit 1) &&
 12 	(foo || exit 1) |
 13 	(foo || exit 1) >baz &&
 14 
-15 	(foo && bar) ?!ERR missing '&&'?!
+15 	(foo && bar) ?!LINT: missing '&&'?!
 16 
-17 	(foo && bar; ?!ERR missing '&&'?! baz) ?!ERR missing '&&'?!
+17 	(foo && bar; ?!LINT: missing '&&'?! baz) ?!LINT: missing '&&'?!
 18 
 19 	foobar
 20 )
diff --git a/t/chainlint/token-pasting.expect b/t/chainlint/token-pasting.expect
index aa64cf75f3..387189b6de 100644
--- a/t/chainlint/token-pasting.expect
+++ b/t/chainlint/token-pasting.expect
@@ -2,13 +2,13 @@
 3 git config filter.rot13.clean ./rot13.sh &&
 4 
 5 {
-6     echo "*.t filter=rot13" ?!ERR missing '&&'?!
+6     echo "*.t filter=rot13" ?!LINT: missing '&&'?!
 7     echo "*.i ident"
 8 } >.gitattributes &&
 9 
 10 {
-11     echo a b c d e f g h i j k l m ?!ERR missing '&&'?!
-12     echo n o p q r s t u v w x y z ?!ERR missing '&&'?!
+11     echo a b c d e f g h i j k l m ?!LINT: missing '&&'?!
+12     echo n o p q r s t u v w x y z ?!LINT: missing '&&'?!
 13     echo '$Id$'
 14 } >test &&
 15 cat test >test.t &&
@@ -19,7 +19,7 @@
 20 git checkout -- test test.t test.i &&
 21 
 22 echo "content-test2" >test2.o &&
-23 echo "content-test3 - filename with special characters" >"test3 'sq',$x=.o" ?!ERR missing '&&'?!
+23 echo "content-test3 - filename with special characters" >"test3 'sq',$x=.o" ?!LINT: missing '&&'?!
 24 
 25 downstream_url_for_sed=$(
 26 	printf "%sn" "$downstream_url" |
diff --git a/t/chainlint/unclosed-here-doc-indent.expect b/t/chainlint/unclosed-here-doc-indent.expect
index d5b9ab52ee..156906c85a 100644
--- a/t/chainlint/unclosed-here-doc-indent.expect
+++ b/t/chainlint/unclosed-here-doc-indent.expect
@@ -1,4 +1,4 @@
 2 command_which_is_run &&
-3 cat >expect <<-\EOF ?!ERR unclosed heredoc?! &&
+3 cat >expect <<-\EOF ?!LINT: unclosed heredoc?! &&
 4 we forget to end the here-doc
 5 command_which_is_gobbled
diff --git a/t/chainlint/unclosed-here-doc.expect b/t/chainlint/unclosed-here-doc.expect
index 8f6d260544..752c608862 100644
--- a/t/chainlint/unclosed-here-doc.expect
+++ b/t/chainlint/unclosed-here-doc.expect
@@ -1,5 +1,5 @@
 2 command_which_is_run &&
-3 cat >expect <<\EOF ?!ERR unclosed heredoc?! &&
+3 cat >expect <<\EOF ?!LINT: unclosed heredoc?! &&
 4 	we try to end the here-doc below,
 5 	but the indentation throws us off
 6 	since the operator is not "<<-".
diff --git a/t/chainlint/while-loop.expect b/t/chainlint/while-loop.expect
index 1cfd17b3c2..2ba5582165 100644
--- a/t/chainlint/while-loop.expect
+++ b/t/chainlint/while-loop.expect
@@ -1,14 +1,14 @@
 2 (
 3 	while true
 4 	do
-5 		echo foo ?!ERR missing '&&'?!
-6 		cat <<-\EOF ?!ERR missing '|| exit 1'?!
+5 		echo foo ?!LINT: missing '&&'?!
+6 		cat <<-\EOF ?!LINT: missing '|| exit 1'?!
 7 		bar
 8 		EOF
-9 	done ?!ERR missing '&&'?!
+9 	done ?!LINT: missing '&&'?!
 10 
 11 	while true; do
 12 		echo foo &&
-13 		cat bar ?!ERR missing '|| exit 1'?!
+13 		cat bar ?!LINT: missing '|| exit 1'?!
 14 	done
 15 )
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b652cb98cd..278d1215f1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1606,7 +1606,7 @@ if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&
    test "${GIT_TEST_EXT_CHAIN_LINT:-1}" != 0
 then
 	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
-		BUG "lint error (see 'ERR' annotations above)"
+		BUG "lint error (see 'LINT' annotations above)"
 fi
 
 # Last-minute variable setup


Range-diff against v1:
2:  93305d0bdf ! 1:  260a877ce1 chainlint: reduce annotation noise-factor
    @@ Metadata
     Author: Eric Sunshine <sunshine@sunshineco.com>
     
      ## Commit message ##
    -    chainlint: reduce annotation noise-factor
    +    chainlint: don't be fooled by "?!...?!" in test body
     
    -    When chainlint detects a problem in a test definition, it highlights the
    -    offending code with an "?!ERR ...?!" annotation. The rather curious "?!"
    -    delimiter was chosen to draw the reader's attention to the problem area.
    +    As originally implemented, chainlint did not collect structured
    +    information about detected problems. Instead, it merely emitted raw
    +    parse tokens (not the original test text), along with a "?!...?!"
    +    annotation directly into the output stream each time a problem was
    +    discovered. In order to report statistics (in --stats mode) and to
    +    adjust its exit code to indicate success or failure, it merely counts
    +    the number of times "?!...?!" appears in the output stream. An obvious
    +    shortcoming of this approach is that it can be fooled by a legitimate
    +    "?!...?!" sequence in the body of a test (though, only if an actual
    +    problem is detected in the test).
     
    -    Later, chainlint learned to color its output when sent to a terminal.
    -    Problem annotations are colored with a red background which stands out
    -    well from surrounding text, thus easily draws the reader's attention. As
    -    such, the additional "?!" decoration became superfluous (when output is
    -    colored), however the decoration was retained since it serves as a good
    -    needle when using the terminal's search feature to "jump" to the next
    -    problem.
    +    The situation did not improve when 7c04aa7390 (chainlint: colorize
    +    problem annotations and test delimiters, 2022-09-13) colored the
    +    annotations after-the-fact by searching for "?!...?!" in the output
    +    stream and inserting color codes. As above, a shortcoming is that this
    +    approach can incorrectly color a legitimate "?!...?!" sequence in a test
    +    body as if it is an error.
     
    -    Nevertheless, the "?!" decoration is noisy and ugly and makes it
    -    unnecessarily difficult for the reader to pluck the problem description
    -    from the annotation. For instance, it is easier to see at a glance what
    -    the problem is in:
    +    However, when 73c768dae9 (chainlint: annotate original test definition
    +    rather than token stream, 2022-11-08) taught chainlint to output the
    +    original test text verbatim, it started collecting structured
    +    information about detected problems.
     
    -        ERR missing '&&'
    -
    -    than in the noisier:
    -
    -        ?!ERR missing '&&'?!
    -
    -    Therefore drop the "!?" decoration when output is colored (but retain it
    -    otherwise).
    -
    -    Note that the preceding change gave all problem annotations a uniform
    -    "ERR" prefix which serves as a reasonably suitable replacement needle
    -    when searching in a terminal, so loss of "?!" in the output should not
    -    be overly problematic.
    +    Now that it is available, take advantage of the structured problem
    +    information to deterministically count the number of problems detected
    +    and to color the annotations directly, rather than scanning the output
    +    stream for "?!...?!" and performing these operations after-the-fact.
     
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
     
    @@ t/chainlint.pl: sub check_test {
     +	$self->{nerrs} += @$problems;
      	return unless $emit_all || @$problems;
      	my $c = main::fd_colors(1);
    -+	my ($erropen, $errclose) = -t 1 ? ("$c->{rev}$c->{red}", $c->{reset}) : ('?!', '?!');
      	my $start = 0;
    - 	my $checked = '';
    - 	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
     @@ t/chainlint.pl: sub check_test {
    + 	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
    + 		my ($label, $token) = @$_;
    + 		my $pos = $token->[2];
    +-		$checked .= substr($body, $start, $pos - $start) . " ?!$label?! ";
    ++		$checked .= substr($body, $start, $pos - $start);
    ++		$checked .= ' ' unless $checked =~ /\s$/;
    ++		$checked .= "$c->{rev}$c->{red}?!$label?!$c->{reset}";
    ++		$checked .= ' ' unless $pos >= length($body) ||
    ++		    substr($body, $pos, 1) =~ /^\s/;
    + 		$start = $pos;
    + 	}
    + 	$checked .= substr($body, $start);
    + 	$checked =~ s/^/$lineno++ . ' '/mge;
      	$checked =~ s/^\d+ \n//;
    - 	$checked =~ s/(\s) \?!/$1?!/mg;
    - 	$checked =~ s/\?! (\s)/?!$1/mg;
    +-	$checked =~ s/(\s) \?!/$1?!/mg;
    +-	$checked =~ s/\?! (\s)/?!$1/mg;
     -	$checked =~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
    -+	$checked =~ s/\?!([^?]+)\?!/$erropen$1$errclose/mg;
      	$checked =~ s/^\d+/$c->{dim}$&$c->{reset}/mg;
      	$checked .= "\n" unless $checked =~ /\n$/;
      	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
    @@ t/chainlint.pl: sub check_script {
      	}
      	return [$id, $nscripts, $ntests, $nerrs];
      }
    -
    - ## t/test-lib.sh ##
    -@@ t/test-lib.sh: if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&
    -    test "${GIT_TEST_EXT_CHAIN_LINT:-1}" != 0
    - then
    - 	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
    --		BUG "lint error (see '?!...!? annotations above)"
    -+		BUG "lint error (see 'ERR' annotations above)"
    - fi
    - 
    - # Last-minute variable setup
1:  0530fc13c6 ! 2:  5a4c1bd31a chainlint: make error messages self-explanatory
    @@ Commit message
         may understand that "?!AMP?!" is an abbreviation of "ampersand" and
         indicates a break in the &&-chain, this may not be obvious to newcomers.
     
    -    Similarly, although the annotation "?!LOOP?!" is understood by project
    -    regulars to indicate a missing `|| return 1` (or `|| exit 1` in a
    -    subshell), newcomers may find it more than a little perplexing. The
    -    "?!LOOP?!" case is particularly serious since it is likely that some
    -    newcomers are unaware that shell loops do not terminate automatically
    -    upon error, and it is more difficult for a newcomer to figure out how to
    -    correct the problem by examining surrounding code since `|| return 1`
    -    appears in test scrips relatively infrequently (compared, for instance,
    -    with &&-chaining).
    +    The "?!LOOP?!" case is particularly serious because that terse single
    +    word does nothing to convey that the loop body should end with
    +    "|| return 1" (or "|| exit 1" in a subshell) to ensure that a failing
    +    command in the body aborts the loop immediately. Moreover, unlike
    +    &&-chaining which is ubiquitous in Git tests, the "|| return 1" idiom is
    +    relatively infrequent, thus may be harder for a newcomer to discover by
    +    consulting nearby code.
     
    -    Address these shortcomings by emitting human-consumable messages which
    +    Address these shortcomings by emitting human-readable messages which
         both explain the problem and give a strong hint about how to correct it.
     
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
    @@ t/chainlint.pl
      # or globs referencing a collection of scripts. For each problem discovered,
      # the pathname of the script containing the test is printed along with the test
     -# name and the test body with a `?!FOO?!` annotation at the location of each
    -+# name and the test body with a `?!ERR?!` annotation at the location of each
    - # detected problem, where "FOO" is a tag such as "AMP" which indicates a broken
    - # &&-chain. Returns zero if no problems are discovered, otherwise non-zero.
    +-# detected problem, where "FOO" is a tag such as "AMP" which indicates a broken
    +-# &&-chain. Returns zero if no problems are discovered, otherwise non-zero.
    ++# name and the test body with a `?!LINT: ...?!` annotation at the location of
    ++# each detected problem, where "..." is an explanation of the problem. Returns
    ++# zero if no problems are discovered, otherwise non-zero.
      
    + use warnings;
    + use strict;
     @@ t/chainlint.pl: sub swallow_heredocs {
      			$self->{lineno} += () = $body =~ /\n/sg;
      			next;
    @@ t/chainlint.pl: sub check_test {
      	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
      		my ($label, $token) = @$_;
      		my $pos = $token->[2];
    --		$checked .= substr($body, $start, $pos - $start) . " ?!$label?! ";
    -+		my $err = format_problem($label, $token);
    -+		$checked .= substr($body, $start, $pos - $start) . " ?!ERR $err?! ";
    ++		my $err = format_problem($label);
    + 		$checked .= substr($body, $start, $pos - $start);
    + 		$checked .= ' ' unless $checked =~ /\s$/;
    +-		$checked .= "$c->{rev}$c->{red}?!$label?!$c->{reset}";
    ++		$checked .= "$c->{rev}$c->{red}?!LINT: $err?!$c->{reset}";
    + 		$checked .= ' ' unless $pos >= length($body) ||
    + 		    substr($body, $pos, 1) =~ /^\s/;
      		$start = $pos;
    - 	}
    - 	$checked .= substr($body, $start);
     
      ## t/chainlint/arithmetic-expansion.expect ##
     @@
    @@ t/chainlint/arithmetic-expansion.expect
      6 ) &&
      7 (
     -8 	bar=$((42 + 1)) ?!AMP?!
    -+8 	bar=$((42 + 1)) ?!ERR missing '&&'?!
    ++8 	bar=$((42 + 1)) ?!LINT: missing '&&'?!
      9 	baz
      10 )
     
    @@ t/chainlint/block.expect
      3 	foo &&
      4 	{
     -5 		echo a ?!AMP?!
    -+5 		echo a ?!ERR missing '&&'?!
    ++5 		echo a ?!LINT: missing '&&'?!
      6 		echo b
      7 	} &&
      8 	bar &&
      9 	{
      10 		echo c
     -11 	} ?!AMP?!
    -+11 	} ?!ERR missing '&&'?!
    ++11 	} ?!LINT: missing '&&'?!
      12 	baz
      13 ) &&
      14 
      15 {
     -16 	echo a; ?!AMP?! echo b
    -+16 	echo a; ?!ERR missing '&&'?! echo b
    ++16 	echo a; ?!LINT: missing '&&'?! echo b
      17 } &&
     -18 { echo a; ?!AMP?! echo b; } &&
    -+18 { echo a; ?!ERR missing '&&'?! echo b; } &&
    ++18 { echo a; ?!LINT: missing '&&'?! echo b; } &&
      19 
      20 {
      21 	echo "${var}9" &&
    @@ t/chainlint/broken-chain.expect
      2 (
      3 	foo &&
     -4 	bar ?!AMP?!
    -+4 	bar ?!ERR missing '&&'?!
    ++4 	bar ?!LINT: missing '&&'?!
      5 	baz &&
      6 	wop
      7 )
    @@ t/chainlint/case.expect
      11 	x) foo ;;
      12 	*) bar ;;
     -13 	esac ?!AMP?!
    -+13 	esac ?!ERR missing '&&'?!
    ++13 	esac ?!LINT: missing '&&'?!
      14 	foobar
      15 ) &&
      16 (
      17 	case "$x" in 1) true;; esac &&
     -18 	case "$y" in 2) false;; esac ?!AMP?!
    -+18 	case "$y" in 2) false;; esac ?!ERR missing '&&'?!
    ++18 	case "$y" in 2) false;; esac ?!LINT: missing '&&'?!
      19 	foobar
      20 )
     
    @@ t/chainlint/chain-break-false.expect
      6 	false
      7 else
     -8 	echo it went okay ?!AMP?!
    -+8 	echo it went okay ?!ERR missing '&&'?!
    ++8 	echo it went okay ?!LINT: missing '&&'?!
      9 	congratulate user
      10 fi
     
    @@ t/chainlint/chained-block.expect
     @@
      2 echo nobody home && {
     -3 	test the doohicky ?!AMP?!
    -+3 	test the doohicky ?!ERR missing '&&'?!
    ++3 	test the doohicky ?!LINT: missing '&&'?!
      4 	right now
      5 } &&
      6 
    @@ t/chainlint/chained-subshell.expect
      2 mkdir sub && (
      3 	cd sub &&
     -4 	foo the bar ?!AMP?!
    -+4 	foo the bar ?!ERR missing '&&'?!
    ++4 	foo the bar ?!LINT: missing '&&'?!
      5 	nuff said
      6 ) &&
      7 
      8 cut "-d " -f actual | (read s1 s2 s3 &&
     -9 test -f $s1 ?!AMP?!
    -+9 test -f $s1 ?!ERR missing '&&'?!
    ++9 test -f $s1 ?!LINT: missing '&&'?!
      10 test $(cat $s2) = tree2path1 &&
      11 test $(cat $s3) = tree3path1)
     
    @@ t/chainlint/command-substitution.expect
      6 ) &&
      7 (
     -8 	bar=$(gobble blocks) ?!AMP?!
    -+8 	bar=$(gobble blocks) ?!ERR missing '&&'?!
    ++8 	bar=$(gobble blocks) ?!LINT: missing '&&'?!
      9 	baz
      10 )
     
    @@ t/chainlint/complex-if-in-cuddled-loop.expect
      6    else
      7      echo >file
     -8    fi ?!LOOP?!
    -+8    fi ?!ERR missing '|| exit 1'?!
    ++8    fi ?!LINT: missing '|| exit 1'?!
      9  done) &&
      10 test ! -f file
     
    @@ t/chainlint/cuddled.expect
      4 ) &&
      5 
     -6 (cd foo ?!AMP?!
    -+6 (cd foo ?!ERR missing '&&'?!
    ++6 (cd foo ?!LINT: missing '&&'?!
      7 	bar
      8 ) &&
      9 
    @@ t/chainlint/cuddled.expect
      15 	bar) &&
      16 
     -17 (cd foo ?!AMP?!
    -+17 (cd foo ?!ERR missing '&&'?!
    ++17 (cd foo ?!LINT: missing '&&'?!
      18 	bar)
     
      ## t/chainlint/for-loop.expect ##
    @@ t/chainlint/for-loop.expect
      4 	do
     -5 		echo $i ?!AMP?!
     -6 		cat <<-\EOF ?!LOOP?!
    -+5 		echo $i ?!ERR missing '&&'?!
    -+6 		cat <<-\EOF ?!ERR missing '|| exit 1'?!
    ++5 		echo $i ?!LINT: missing '&&'?!
    ++6 		cat <<-\EOF ?!LINT: missing '|| exit 1'?!
      7 		bar
      8 		EOF
     -9 	done ?!AMP?!
    -+9 	done ?!ERR missing '&&'?!
    ++9 	done ?!LINT: missing '&&'?!
      10 
      11 	for i in a b c; do
      12 		echo $i &&
     -13 		cat $i ?!LOOP?!
    -+13 		cat $i ?!ERR missing '|| exit 1'?!
    ++13 		cat $i ?!LINT: missing '|| exit 1'?!
      14 	done
      15 )
     
    @@ t/chainlint/function.expect
      6 remove_object() {
      7 	file=$(sha1_file "$*") &&
     -8 	test -e "$file" ?!AMP?!
    -+8 	test -e "$file" ?!ERR missing '&&'?!
    ++8 	test -e "$file" ?!LINT: missing '&&'?!
      9 	rm -f "$file"
     -10 } ?!AMP?!
    -+10 } ?!ERR missing '&&'?!
    ++10 } ?!LINT: missing '&&'?!
      11 
      12 sha1_file arg && remove_object arg
     
      ## t/chainlint/here-doc-body-indent.expect ##
     @@
     -2 	echo "we should find this" ?!AMP?!
    -+2 	echo "we should find this" ?!ERR missing '&&'?!
    ++2 	echo "we should find this" ?!LINT: missing '&&'?!
      3 	echo "even though our heredoc has its indent stripped"
     
      ## t/chainlint/here-doc-body-pathological.expect ##
     @@
     -2 	echo "outer here-doc does not allow indented end-tag" ?!AMP?!
    -+2 	echo "outer here-doc does not allow indented end-tag" ?!ERR missing '&&'?!
    ++2 	echo "outer here-doc does not allow indented end-tag" ?!LINT: missing '&&'?!
      3 	cat >file <<-\EOF &&
      4 	but this inner here-doc
      5 	does allow indented EOF
      6 	EOF
     -7 	echo "missing chain after" ?!AMP?!
    -+7 	echo "missing chain after" ?!ERR missing '&&'?!
    ++7 	echo "missing chain after" ?!LINT: missing '&&'?!
      8 	echo "but this line is OK because it's the end"
     
      ## t/chainlint/here-doc-body.expect ##
     @@
     -2 	echo "missing chain before" ?!AMP?!
    -+2 	echo "missing chain before" ?!ERR missing '&&'?!
    ++2 	echo "missing chain before" ?!LINT: missing '&&'?!
      3 	cat >file <<-\EOF &&
      4 	inside inner here-doc
      5 	these are not shell commands
      6 	EOF
     -7 	echo "missing chain after" ?!AMP?!
    -+7 	echo "missing chain after" ?!ERR missing '&&'?!
    ++7 	echo "missing chain after" ?!LINT: missing '&&'?!
      8 	echo "but this line is OK because it's the end"
     
      ## t/chainlint/here-doc-double.expect ##
     @@
     -8 	echo "actual test commands" ?!AMP?!
    -+8 	echo "actual test commands" ?!ERR missing '&&'?!
    ++8 	echo "actual test commands" ?!LINT: missing '&&'?!
      9 	echo "that should be checked"
     
      ## t/chainlint/here-doc-indent-operator.expect ##
    @@ t/chainlint/here-doc-indent-operator.expect
      6 EOF
      7 
     -8 cat >expect << -EOF ?!AMP?!
    -+8 cat >expect << -EOF ?!ERR missing '&&'?!
    ++8 cat >expect << -EOF ?!LINT: missing '&&'?!
      9 this is not indented
      10 -EOF
      11 
    @@ t/chainlint/here-doc-multi-line-command-subst.expect
      5 		vegetable
      6 		END
     -7 		wiffle) ?!AMP?!
    -+7 		wiffle) ?!ERR missing '&&'?!
    ++7 		wiffle) ?!LINT: missing '&&'?!
      8 	echo $x
      9 )
     
    @@ t/chainlint/here-doc-multi-line-string.expect
      2 (
      3 	cat <<-\TXT && echo "multi-line
     -4 	string" ?!AMP?!
    -+4 	string" ?!ERR missing '&&'?!
    ++4 	string" ?!LINT: missing '&&'?!
      5 	fizzle
      6 	TXT
      7 	bap
    @@ t/chainlint/if-condition-split.expect
      4    kevin
      5 then
     -6 	echo "nomads" ?!AMP?!
    -+6 	echo "nomads" ?!ERR missing '&&'?!
    ++6 	echo "nomads" ?!LINT: missing '&&'?!
      7 	echo "for sure"
      8 fi
     
    @@ t/chainlint/if-in-loop.expect
      7 			echo "err"
      8 			exit 1
     -9 		fi ?!AMP?!
    -+9 		fi ?!ERR missing '&&'?!
    ++9 		fi ?!LINT: missing '&&'?!
      10 		foo
     -11 	done ?!AMP?!
    -+11 	done ?!ERR missing '&&'?!
    ++11 	done ?!LINT: missing '&&'?!
      12 	bar
      13 )
     
    @@ t/chainlint/if-then-else.expect
      3 	if test -n ""
      4 	then
     -5 		echo very ?!AMP?!
    -+5 		echo very ?!ERR missing '&&'?!
    ++5 		echo very ?!LINT: missing '&&'?!
      6 		echo empty
      7 	elif test -z ""
      8 	then
    @@ t/chainlint/if-then-else.expect
      13 		bar
      14 		EOF
     -15 	fi ?!AMP?!
    -+15 	fi ?!ERR missing '&&'?!
    ++15 	fi ?!LINT: missing '&&'?!
      16 	echo poodle
      17 ) &&
      18 (
    @@ t/chainlint/inline-comment.expect
      2 (
      3 	foobar && # comment 1
     -4 	barfoo ?!AMP?! # wrong position for &&
    -+4 	barfoo ?!ERR missing '&&'?! # wrong position for &&
    ++4 	barfoo ?!LINT: missing '&&'?! # wrong position for &&
      5 	flibble "not a # comment"
      6 ) &&
      7 
    @@ t/chainlint/loop-detect-failure.expect
      13 	printf "%"$n"s" X > r2/large.$n &&
      14 	git -C r2 add large.$n &&
     -15 	git -C r2 commit -m "$n" ?!LOOP?!
    -+15 	git -C r2 commit -m "$n" ?!ERR missing '|| return 1'?!
    ++15 	git -C r2 commit -m "$n" ?!LINT: missing '|| return 1'?!
      16 done
     
      ## t/chainlint/loop-in-if.expect ##
    @@ t/chainlint/loop-in-if.expect
     -7 			echo "pop" ?!AMP?!
     -8 			echo "glup" ?!LOOP?!
     -9 		done ?!AMP?!
    -+7 			echo "pop" ?!ERR missing '&&'?!
    -+8 			echo "glup" ?!ERR missing '|| exit 1'?!
    -+9 		done ?!ERR missing '&&'?!
    ++7 			echo "pop" ?!LINT: missing '&&'?!
    ++8 			echo "glup" ?!LINT: missing '|| exit 1'?!
    ++9 		done ?!LINT: missing '&&'?!
      10 		foo
     -11 	fi ?!AMP?!
    -+11 	fi ?!ERR missing '&&'?!
    ++11 	fi ?!LINT: missing '&&'?!
      12 	bar
      13 )
     
    @@ t/chainlint/multi-line-string.expect
      5 		line 3" &&
      6 	y="line 1
     -7 		line2" ?!AMP?!
    -+7 		line2" ?!ERR missing '&&'?!
    ++7 		line2" ?!LINT: missing '&&'?!
      8 	foobar
      9 ) &&
      10 (
    @@ t/chainlint/negated-one-liner.expect
      4 
     -5 ! (foo; ?!AMP?! bar) &&
     -6 ! (foo; ?!AMP?! bar) >baz
    -+5 ! (foo; ?!ERR missing '&&'?! bar) &&
    -+6 ! (foo; ?!ERR missing '&&'?! bar) >baz
    ++5 ! (foo; ?!LINT: missing '&&'?! bar) &&
    ++6 ! (foo; ?!LINT: missing '&&'?! bar) >baz
     
      ## t/chainlint/nested-cuddled-subshell.expect ##
     @@
    @@ t/chainlint/nested-cuddled-subshell.expect
      7 	(cd foo &&
      8 		bar
     -9 	) ?!AMP?!
    -+9 	) ?!ERR missing '&&'?!
    ++9 	) ?!LINT: missing '&&'?!
      10 
      11 	(
      12 		cd foo &&
    @@ t/chainlint/nested-cuddled-subshell.expect
      15 	(
      16 		cd foo &&
     -17 		bar) ?!AMP?!
    -+17 		bar) ?!ERR missing '&&'?!
    ++17 		bar) ?!LINT: missing '&&'?!
      18 
      19 	(cd foo &&
      20 		bar) &&
      21 
      22 	(cd foo &&
     -23 		bar) ?!AMP?!
    -+23 		bar) ?!ERR missing '&&'?!
    ++23 		bar) ?!LINT: missing '&&'?!
      24 
      25 	foobar
      26 )
    @@ t/chainlint/nested-here-doc.expect
      20 	INPUT_END
      21 
     -22 	cat <<-\EOT ?!AMP?!
    -+22 	cat <<-\EOT ?!ERR missing '&&'?!
    ++22 	cat <<-\EOT ?!LINT: missing '&&'?!
      23 	text goes here
      24 	data <<EOF
      25 		data goes here
    @@ t/chainlint/nested-loop-detect-failure.expect
      5 	do
     -6 		echo "$i$j" >"path$i$j" ?!LOOP?!
     -7 	done ?!LOOP?!
    -+6 		echo "$i$j" >"path$i$j" ?!ERR missing '|| return 1'?!
    -+7 	done ?!ERR missing '|| return 1'?!
    ++6 		echo "$i$j" >"path$i$j" ?!LINT: missing '|| return 1'?!
    ++7 	done ?!LINT: missing '|| return 1'?!
      8 done &&
      9 
      10 for i in 0 1 2 3 4 5 6 7 8 9;
    @@ t/chainlint/nested-loop-detect-failure.expect
      20 	for j in 0 1 2 3 4 5 6 7 8 9;
      21 	do
     -22 		echo "$i$j" >"path$i$j" ?!LOOP?!
    -+22 		echo "$i$j" >"path$i$j" ?!ERR missing '|| return 1'?!
    ++22 		echo "$i$j" >"path$i$j" ?!LINT: missing '|| return 1'?!
      23 	done || return 1
      24 done &&
      25 
    @@ t/chainlint/nested-subshell-comment.expect
      8 		baz &&
      9 		snaff
     -10 	) ?!AMP?!
    -+10 	) ?!ERR missing '&&'?!
    ++10 	) ?!LINT: missing '&&'?!
      11 	fuzzy
      12 )
     
    @@ t/chainlint/nested-subshell.expect
      9 	cd foo &&
      10 	(
     -11 		echo a ?!AMP?!
    -+11 		echo a ?!ERR missing '&&'?!
    ++11 		echo a ?!LINT: missing '&&'?!
      12 		echo b
      13 	) >file
      14 )
    @@ t/chainlint/not-heredoc.expect
      11 	echo "=======" &&
      12 	echo theirside &&
     -13 	echo ">>>>>>> theirs" ?!AMP?!
    -+13 	echo ">>>>>>> theirs" ?!ERR missing '&&'?!
    ++13 	echo ">>>>>>> theirs" ?!LINT: missing '&&'?!
      14 	poodle
      15 ) >merged
     
    @@ t/chainlint/one-liner-for-loop.expect
      5 	test_write_lines 1 2 3 4 5 >foo &&
      6 	mkdir olddir &&
     -7 	for i in a b c; do echo $i >olddir/$i; ?!LOOP?! done ?!AMP?!
    -+7 	for i in a b c; do echo $i >olddir/$i; ?!ERR missing '|| exit 1'?! done ?!ERR missing '&&'?!
    ++7 	for i in a b c; do echo $i >olddir/$i; ?!LINT: missing '|| exit 1'?! done ?!LINT: missing '&&'?!
      8 	git add foo olddir &&
      9 	git commit -m "original" &&
      10 )
    @@ t/chainlint/one-liner.expect
     -6 (foo; ?!AMP?! bar) &&
     -7 (foo; ?!AMP?! bar) |
     -8 (foo; ?!AMP?! bar) >baz &&
    -+6 (foo; ?!ERR missing '&&'?! bar) &&
    -+7 (foo; ?!ERR missing '&&'?! bar) |
    -+8 (foo; ?!ERR missing '&&'?! bar) >baz &&
    ++6 (foo; ?!LINT: missing '&&'?! bar) &&
    ++7 (foo; ?!LINT: missing '&&'?! bar) |
    ++8 (foo; ?!LINT: missing '&&'?! bar) >baz &&
      9 
      10 (foo "bar; baz")
     
    @@ t/chainlint/pipe.expect
      6 
      7 	fish |
     -8 	cow ?!AMP?!
    -+8 	cow ?!ERR missing '&&'?!
    ++8 	cow ?!LINT: missing '&&'?!
      9 
      10 	sunder
      11 )
    @@ t/chainlint/semicolon.expect
      2 (
     -3 	cat foo ; ?!AMP?! echo bar ?!AMP?!
     -4 	cat foo ; ?!AMP?! echo bar
    -+3 	cat foo ; ?!ERR missing '&&'?! echo bar ?!ERR missing '&&'?!
    -+4 	cat foo ; ?!ERR missing '&&'?! echo bar
    ++3 	cat foo ; ?!LINT: missing '&&'?! echo bar ?!LINT: missing '&&'?!
    ++4 	cat foo ; ?!LINT: missing '&&'?! echo bar
      5 ) &&
      6 (
     -7 	cat foo ; ?!AMP?! echo bar &&
     -8 	cat foo ; ?!AMP?! echo bar
    -+7 	cat foo ; ?!ERR missing '&&'?! echo bar &&
    -+8 	cat foo ; ?!ERR missing '&&'?! echo bar
    ++7 	cat foo ; ?!LINT: missing '&&'?! echo bar &&
    ++8 	cat foo ; ?!LINT: missing '&&'?! echo bar
      9 ) &&
      10 (
      11 	echo "foo; bar" &&
     -12 	cat foo; ?!AMP?! echo bar
    -+12 	cat foo; ?!ERR missing '&&'?! echo bar
    ++12 	cat foo; ?!LINT: missing '&&'?! echo bar
      13 ) &&
      14 (
      15 	foo;
    @@ t/chainlint/semicolon.expect
      17 (cd foo &&
      18 	for i in a b c; do
     -19 		echo; ?!LOOP?!
    -+19 		echo; ?!ERR missing '|| exit 1'?!
    ++19 		echo; ?!LINT: missing '|| exit 1'?!
      20 	done)
     
      ## t/chainlint/subshell-here-doc.expect ##
    @@ t/chainlint/subshell-here-doc.expect
      8 	EOF
      9 
     -10 	cat <<EOF >bip ?!AMP?!
    -+10 	cat <<EOF >bip ?!ERR missing '&&'?!
    ++10 	cat <<EOF >bip ?!LINT: missing '&&'?!
      11 	fish fly high
      12 EOF
      13 
    @@ t/chainlint/subshell-one-liner.expect
     -7 	(foo; ?!AMP?! bar) &&
     -8 	(foo; ?!AMP?! bar) |
     -9 	(foo; ?!AMP?! bar) >baz &&
    -+7 	(foo; ?!ERR missing '&&'?! bar) &&
    -+8 	(foo; ?!ERR missing '&&'?! bar) |
    -+9 	(foo; ?!ERR missing '&&'?! bar) >baz &&
    ++7 	(foo; ?!LINT: missing '&&'?! bar) &&
    ++8 	(foo; ?!LINT: missing '&&'?! bar) |
    ++9 	(foo; ?!LINT: missing '&&'?! bar) >baz &&
      10 
      11 	(foo || exit 1) &&
      12 	(foo || exit 1) |
      13 	(foo || exit 1) >baz &&
      14 
     -15 	(foo && bar) ?!AMP?!
    -+15 	(foo && bar) ?!ERR missing '&&'?!
    ++15 	(foo && bar) ?!LINT: missing '&&'?!
      16 
     -17 	(foo && bar; ?!AMP?! baz) ?!AMP?!
    -+17 	(foo && bar; ?!ERR missing '&&'?! baz) ?!ERR missing '&&'?!
    ++17 	(foo && bar; ?!LINT: missing '&&'?! baz) ?!LINT: missing '&&'?!
      18 
      19 	foobar
      20 )
    @@ t/chainlint/token-pasting.expect
      4 
      5 {
     -6     echo "*.t filter=rot13" ?!AMP?!
    -+6     echo "*.t filter=rot13" ?!ERR missing '&&'?!
    ++6     echo "*.t filter=rot13" ?!LINT: missing '&&'?!
      7     echo "*.i ident"
      8 } >.gitattributes &&
      9 
      10 {
     -11     echo a b c d e f g h i j k l m ?!AMP?!
     -12     echo n o p q r s t u v w x y z ?!AMP?!
    -+11     echo a b c d e f g h i j k l m ?!ERR missing '&&'?!
    -+12     echo n o p q r s t u v w x y z ?!ERR missing '&&'?!
    ++11     echo a b c d e f g h i j k l m ?!LINT: missing '&&'?!
    ++12     echo n o p q r s t u v w x y z ?!LINT: missing '&&'?!
      13     echo '$Id$'
      14 } >test &&
      15 cat test >test.t &&
    @@ t/chainlint/token-pasting.expect
      21 
      22 echo "content-test2" >test2.o &&
     -23 echo "content-test3 - filename with special characters" >"test3 'sq',$x=.o" ?!AMP?!
    -+23 echo "content-test3 - filename with special characters" >"test3 'sq',$x=.o" ?!ERR missing '&&'?!
    ++23 echo "content-test3 - filename with special characters" >"test3 'sq',$x=.o" ?!LINT: missing '&&'?!
      24 
      25 downstream_url_for_sed=$(
      26 	printf "%sn" "$downstream_url" |
    @@ t/chainlint/unclosed-here-doc-indent.expect
     @@
      2 command_which_is_run &&
     -3 cat >expect <<-\EOF ?!UNCLOSED-HEREDOC?! &&
    -+3 cat >expect <<-\EOF ?!ERR unclosed heredoc?! &&
    ++3 cat >expect <<-\EOF ?!LINT: unclosed heredoc?! &&
      4 we forget to end the here-doc
      5 command_which_is_gobbled
     
    @@ t/chainlint/unclosed-here-doc.expect
     @@
      2 command_which_is_run &&
     -3 cat >expect <<\EOF ?!UNCLOSED-HEREDOC?! &&
    -+3 cat >expect <<\EOF ?!ERR unclosed heredoc?! &&
    ++3 cat >expect <<\EOF ?!LINT: unclosed heredoc?! &&
      4 	we try to end the here-doc below,
      5 	but the indentation throws us off
      6 	since the operator is not "<<-".
    @@ t/chainlint/while-loop.expect
      4 	do
     -5 		echo foo ?!AMP?!
     -6 		cat <<-\EOF ?!LOOP?!
    -+5 		echo foo ?!ERR missing '&&'?!
    -+6 		cat <<-\EOF ?!ERR missing '|| exit 1'?!
    ++5 		echo foo ?!LINT: missing '&&'?!
    ++6 		cat <<-\EOF ?!LINT: missing '|| exit 1'?!
      7 		bar
      8 		EOF
     -9 	done ?!AMP?!
    -+9 	done ?!ERR missing '&&'?!
    ++9 	done ?!LINT: missing '&&'?!
      10 
      11 	while true; do
      12 		echo foo &&
     -13 		cat bar ?!LOOP?!
    -+13 		cat bar ?!ERR missing '|| exit 1'?!
    ++13 		cat bar ?!LINT: missing '|| exit 1'?!
      14 	done
      15 )
-:  ---------- > 3:  eee1e7fac7 chainlint: reduce annotation noise-factor
-- 
2.46.0

