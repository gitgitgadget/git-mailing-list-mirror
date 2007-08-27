From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusion about diffing branches
Date: Mon, 27 Aug 2007 10:06:21 -0700
Message-ID: <7vr6lozz3m.fsf@gitster.siamese.dyndns.org>
References: <20070826233555.GA7422@mediacenter.austin.rr.com>
	<7v6431omn8.fsf@gitster.siamese.dyndns.org>
	<20070827014056.GB7422@mediacenter.austin.rr.com>
	<7vlkbxmp50.fsf@gitster.siamese.dyndns.org>
	<20070827075009.GA31438@glandium.org>
	<38b2ab8a0708270621l63f3da56j4667014e62a5de92@mail.gmail.com>
	<20070827133314.GA9131@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 19:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPi2q-0004Tg-O2
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 19:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473AbXH0RGb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 13:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756182AbXH0RGb
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 13:06:31 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007AbXH0RG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 13:06:29 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 17ACA129531;
	Mon, 27 Aug 2007 13:06:45 -0400 (EDT)
In-Reply-To: <20070827133314.GA9131@glandium.org> (Mike Hommey's message of
	"Mon, 27 Aug 2007 15:33:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56860>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Aug 27, 2007 at 03:21:32PM +0200, Francis Moreau <francis.moro@gmail.com> wrote:
>> 
>> This "inconsistency" had already been raised before. Please refer to:
>> http://www.gelato.unsw.edu.au/archives/git/0612/35354.html
>> 
>> I shared and still share your feeling about that but it seems that
>> Junio and Linus don't...
>
> Actually, they may have a good point, cf. the thread you point.
> But it is annoying that it is not documented.

Would something like this reduce the annoyance factor?

---

 Documentation/git-diff.txt |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b36e705..04b62d9 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -42,14 +42,28 @@ tree and the index file, or the index file and the working tree.
 	branch name to compare with the tip of a different
 	branch.
 
-'git-diff' [--options] <commit> <commit> [--] [<path>...]::
+'git-diff' [--options] <commit1> <commit2> [--] [<path>...]::
 
 	This form is to view the changes between two <commit>,
 	for example, tips of two branches.
 
+'git-diff' [--options] <commit1>..<commit2> [--] [<path>...]::
+
+	This is identical to the previous one, just to make the
+	specification of two commits look similar to a commit
+	range notation.
+
+'git-diff' [--options] <commit1>...<commit2> [--] [<path>...]::
+
+	This compares the merge base of two commits and the
+	second commit.  Useful to view what happened in the
+	history that leads to the second commit since that
+	history forked from the history that leads to the first
+	commit.
+
 Just in case if you are doing something exotic, it should be
-noted that all of the <commit> in the above description can be
-any <tree-ish>.
+noted that all of the <commit> in the above description,
+except for the last two variants, can be any <tree-ish>.
 
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
