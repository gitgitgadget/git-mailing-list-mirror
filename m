From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-show documentation
Date: Tue, 03 Jun 2008 23:42:26 -0700
Message-ID: <7vr6bdzood.fsf@gitster.siamese.dyndns.org>
References: <4845E6C5.8010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 08:43:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3mic-0007K9-RH
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 08:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYFDGmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 02:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbYFDGmm
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 02:42:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbYFDGml (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 02:42:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A0EB934DE;
	Wed,  4 Jun 2008 02:42:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C1C9C34DD; Wed,  4 Jun 2008 02:42:34 -0400 (EDT)
In-Reply-To: <4845E6C5.8010000@gmail.com> (Lea Wiemann's message of "Wed, 04
 Jun 2008 02:50:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6D06226C-3201-11DD-94A3-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83747>

Lea Wiemann <lewiemann@gmail.com> writes:

> Just in case someone wants to fix it, man git-log lists a --header
> option (by including rev-list-options.txt), but it doesn't actually
> support this option.  Perhaps rev-list-options.txt should be
> copy-and-pasted instead of included so local changes can be made to
> git-log.txt.

We already do conditional partial inclusion of that file, so reusing that
mechanism would be the cleanest.

I've looked at the generated files before and after this patch and the
differences looked reasonable.

-- >8 --
Documentation: git-log cannot use rev-list specific options

The log family and git-rev-list share the same set of options that come
from revision walking machinery, but they both have options unique to
them.  Notably, --header, --timestamp, --stdin and --quiet apply only to
rev-list.  Exclude them from the git-log documentation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/rev-list-options.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index dfcef79..05d5abe 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -34,17 +34,21 @@ format, often found in E-mail messages.
 `--date=default` shows timestamps in the original timezone
 (either committer's or author's).
 
+ifdef::git-rev-list[]
 --header::
 
 	Print the contents of the commit in raw-format; each record is
 	separated with a NUL character.
+endif::git-rev-list[]
 
 --parents::
 
 	Print the parents of the commit.
 
+ifdef::git-rev-list[]
 --timestamp::
 	Print the raw commit timestamp.
+endif::git-rev-list[]
 
 --left-right::
 
@@ -206,6 +210,7 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `$GIT_DIR/refs/` are listed on the
 	command line as '<commit>'.
 
+ifdef::git-rev-list[]
 --stdin::
 
 	In addition to the '<commit>' listed on the command
@@ -218,6 +223,7 @@ endif::git-rev-list[]
 	test the exit status to see if a range of objects is fully
 	connected (or not).  It is faster than redirecting stdout
 	to /dev/null as the output does not have to be formatted.
+endif::git-rev-list[]
 
 --cherry-pick::
 
