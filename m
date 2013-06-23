From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/14] t/t5505-remote: modernize style
Date: Sun, 23 Jun 2013 00:42:06 -0700
Message-ID: <7vehbtgto1.fsf@alter.siamese.dyndns.org>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
	<1371887901-5659-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 09:42:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqewB-0007xY-3V
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 09:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837Ab3FWHmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 03:42:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788Ab3FWHmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 03:42:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F1D926496;
	Sun, 23 Jun 2013 07:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=9tmHs/hfDnl6eVVUd3XXcw2whb8=; b=n/I0aJzJki+ogGeMfuZw
	yqlYiptEooaLhjoz81NV62Ip3BFrGvv6rrSi/rqAowXbAWnCeS9ScRkYNofy1j+9
	W7y/5h09uok+wuc03QUBlWQll0g4LQ85i0D1EBRziJkvtSb3fNTGxUsMJw3mIrWM
	49NT0U3z2Bm1wrzt+27/koQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YcsVtdByJLMyi2xL+/y3yEfGaPx1TMtKLU9H3fKtPj+Aul
	C3rv3l70lQGEHKVTqusMoqjNqWhpdrtiLEmRkzNiYOe5cyw1opWa3Sya9GclSTeF
	utw8PnFP9mkH+y6ZAu2aykl62cWF49QXuIMz5nqf4mK04djYJ14l3ca0qo0vE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 169BB26493;
	Sun, 23 Jun 2013 07:42:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4393E26492;
	Sun, 23 Jun 2013 07:42:08 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 683DEE3C-DBD8-11E2-8F53-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228725>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Modernize the style of all tests throughout the file:
> - Remove spurious blank lines.
> - Indent the test body.
> - Make sure that all lines end with &&, to make it easier to spot breaks
>   in the chain.
> - When executing something in a subshell, put the parenthesis on
>   separate lines and indent the body.  Also make sure that the first
>   statement in the subshell is a 'cd'.
> - When redirecting output, replace the > output forms with >output.
> - Use the <<-\EOF and <<-EOF forms of heredoc, not <<EOF.  Also, don't
>   de-indent the heredoc body.
> - When creating an empty file, use : >output form over >output for
>   clarity.

Everything except the last one is good, I think.

For the last one, I prefer ">output" moderately over ": >output", as
both are equally clear to people who write shell scripts, but this
preference is not strong enough to make me change ": >output" that
is originally in the file to ">output" in a patch.  In the very old
days, there were some implementations of shells that mishandled
">output" but those days are long gone.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5505-remote.sh | 813 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 440 insertions(+), 373 deletions(-)
>
> -cat > test/expect << EOF
> ...
> +cat >test/expect <<-EOF
>  * remote origin
>    Fetch URL: $(pwd)/one
>    Push  URL: $(pwd)/one

This one is questionable; if it is not indented with HT, there is no
point using the -EOF form.

> -cat > test/expect << EOF
> ...
> +cat >test/expect <<-EOF

Likewise.

> @@ -219,152 +220,187 @@ cat > test/expect << EOF
>  EOF
>  
>  test_expect_success 'show -n' '
> -	(mv one one.unreachable &&
> -	 cd test &&
> ...
> +	mv one one.unreachable &&
> +	(
> +		cd test &&

This is more than an indentation change, but I think it is a good
one.  I saw some others that moved "mkdir" out of the subshell to
chdir into that directory, which are also good changes.

>  cat >test/expect <<\EOF

Funny that you did not touch this one.

> -cat > one/expect << EOF
> +cat >one/expect <<-\EOF
>    apis/master

But this again is an unnecessary use of <<-

This smells like a largely blind conversion done with a script,
which needs a human proof-reader other than the submitter;
everything else looked good.


I'll queue with this fix-up squashed in.


 t/t5505-remote.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index f679ded..0e7dfa2 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -107,7 +107,7 @@ test_expect_success C_LOCALE_OUTPUT 'remove remote' '
 		check_remote_track origin master side &&
 		git for-each-ref "--format=%(refname)" refs/remotes |
 		sed -e "/^refs\/remotes\/origin\//d" >actual &&
-		: >expect &&
+		>expect &&
 		test_cmp expect actual
 	)
 '
@@ -139,7 +139,7 @@ test_expect_success 'remove remote protects local branches' '
 	)
 '
 
-cat >test/expect <<-EOF
+cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
   Push  URL: $(pwd)/one
@@ -202,7 +202,7 @@ test_expect_success 'show' '
 	)
 '
 
-cat >test/expect <<-EOF
+cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
   Push  URL: $(pwd)/one
@@ -262,7 +262,7 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
-cat >test/expect <<-\EOF
+cat >test/expect <<\EOF
 error: Multiple remote HEAD branches. Please choose one explicitly with:
   git remote set-head two another
   git remote set-head two master
@@ -276,7 +276,7 @@ test_expect_success 'set-head --auto fails w/multiple HEADs' '
 	)
 '
 
-cat >test/expect <<-\EOF
+cat >test/expect <<\EOF
 refs/remotes/origin/side2
 EOF
 
@@ -290,7 +290,7 @@ test_expect_success 'set-head explicit' '
 	)
 '
 
-cat >test/expect <<-EOF
+cat >test/expect <<EOF
 Pruning origin
 URL: $(pwd)/one
  * [would prune] origin/side2
@@ -483,7 +483,7 @@ EOF
 test_expect_success 'add with reachable tags (default)' '
 	(
 		cd one &&
-		: >foobar &&
+		>foobar &&
 		git add foobar &&
 		git commit -m "Foobar" &&
 		git tag -a -m "Foobar tag" foobar-tag &&
@@ -551,7 +551,7 @@ test_expect_success 'reject --no-no-tags' '
 	)
 '
 
-cat >one/expect <<-\EOF
+cat >one/expect <<\EOF
   apis/master
   apis/side
   drosophila/another
@@ -570,7 +570,7 @@ test_expect_success 'update' '
 	)
 '
 
-cat >one/expect <<-\EOF
+cat >one/expect <<\EOF
   drosophila/another
   drosophila/master
   drosophila/side
@@ -637,7 +637,7 @@ test_expect_success 'update default' '
 	)
 '
 
-cat >one/expect <<-\EOF
+cat >one/expect <<\EOF
   drosophila/another
   drosophila/master
   drosophila/side
@@ -732,7 +732,7 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 	)
 '
 
-cat >remotes_origin <<-EOF
+cat >remotes_origin <<EOF
 URL: $(pwd)/one
 Push: refs/heads/master:refs/heads/upstream
 Pull: refs/heads/master:refs/heads/origin
