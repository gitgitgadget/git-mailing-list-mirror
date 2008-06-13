From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [biseced bug] make info fails with master
Date: Thu, 12 Jun 2008 17:12:19 -0700
Message-ID: <7v4p7yyyzg.fsf@gitster.siamese.dyndns.org>
References: <20080605234016.GO29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>,
	"John J. Franey" <jjfraney@gmail.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 02:13:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6wuz-0000Yx-3S
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 02:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757619AbYFMAMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 20:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757621AbYFMAMb
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 20:12:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757601AbYFMAMa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 20:12:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9684523A0;
	Thu, 12 Jun 2008 20:12:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B9B33239E; Thu, 12 Jun 2008 20:12:22 -0400 (EDT)
In-Reply-To: <20080605234016.GO29404@genesis.frugalware.org> (Miklos Vajna's
 message of "Fri, 6 Jun 2008 01:40:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 68139E8C-38DD-11DD-88DB-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84816>

Miklos Vajna <vmiklos@frugalware.org> writes:

> make info seem to fails here recently.
> ...
> The commit obviously touches this part of the documentation but I don't see
> where the bug is.
>
> I'm not sure, maybe this is a bug in the toolchain?

I've made a few changes to work these around but haven't pushed the
results out.  Here is a preview of two relevant commits.

The *NOTE:* thing could be new but @pxref{[REMOTES]} thing has been with
us from very beginning and we already had a similar workaround for it.


diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5f55f64..d0f1595 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -38,7 +38,8 @@ include::merge-options.txt[]
 	for branch `<name>`, set configuration `branch.<name>.rebase`
 	to `true`.
 +
-*NOTE:* This is a potentially _dangerous_ mode of operation.
+[NOTE]
+This is a potentially _dangerous_ mode of operation.
 It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.


diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index e3d8e9f..dbc133c 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -11,7 +11,7 @@ while (<STDIN>) {
 	if (s/^\@top (.*)/\@node $1,,,Top/) {
 		push @menu, $1;
 	}
-	s/\(\@pxref{\[URLS\]}\)//;
+	s/\(\@pxref{\[(URLS|REMOTES)\]}\)//;
 	print TMP;
 }
 close TMP;
