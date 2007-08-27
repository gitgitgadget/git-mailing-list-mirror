From: Mike Hommey <mh@glandium.org>
Subject: Re: Confusion about diffing branches
Date: Mon, 27 Aug 2007 19:24:52 +0200
Organization: glandium.org
Message-ID: <20070827172452.GA10041@glandium.org>
References: <20070826233555.GA7422@mediacenter.austin.rr.com> <7v6431omn8.fsf@gitster.siamese.dyndns.org> <20070827014056.GB7422@mediacenter.austin.rr.com> <7vlkbxmp50.fsf@gitster.siamese.dyndns.org> <20070827075009.GA31438@glandium.org> <38b2ab8a0708270621l63f3da56j4667014e62a5de92@mail.gmail.com> <20070827133314.GA9131@glandium.org> <7vr6lozz3m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Cc: Francis Moreau <francis.moro@gmail.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 19:31:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPiMi-0001vT-8N
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 19:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbXH0R05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 13:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756622AbXH0R05
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 13:26:57 -0400
Received: from vawad.err.no ([85.19.200.177]:37007 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755954AbXH0R04 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 13:26:56 -0400
Received: from aputeaux-153-1-29-74.w82-124.abo.wanadoo.fr ([82.124.191.74] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IPiM2-0007sB-6o; Mon, 27 Aug 2007 19:26:37 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IPiKa-0002ca-6S; Mon, 27 Aug 2007 19:24:52 +0200
Content-Disposition: inline
In-Reply-To: <7vr6lozz3m.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56865>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 27, 2007 at 10:06:21AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Mon, Aug 27, 2007 at 03:21:32PM +0200, Francis Moreau <francis.moro@gmail.com> wrote:
> >> 
> >> This "inconsistency" had already been raised before. Please refer to:
> >> http://www.gelato.unsw.edu.au/archives/git/0612/35354.html
> >> 
> >> I shared and still share your feeling about that but it seems that
> >> Junio and Linus don't...
> >
> > Actually, they may have a good point, cf. the thread you point.
> > But it is annoying that it is not documented.
> 
> Would something like this reduce the annoyance factor?

I was actually working on the attached diff, though I'm not really
convinced by my wording.

Mike

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

 Documentation/git-diff.txt |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b36e705..082ac0b 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -43,9 +43,22 @@ tree and the index file, or the index file and the working tree.
 	branch.
 
 'git-diff' [--options] <commit> <commit> [--] [<path>...]::
+'git-diff' [--options] <commit>..<commit> [--] [<path>...]::
 
-	This form is to view the changes between two <commit>,
-	for example, tips of two branches.
+	These forms are to view the changes between two <commit>,
+	for example, tips of two branches. In the second form,
+	omitting any one of both <commit> will have the same effect
+	as using HEAD.
+
+'git-diff' [--options] <commit>...<commit> [--] [<path>...]::
+
+	This form is to view the changes on the branch containing
+	and up to the second <commit>, starting at a common ancestor
+	of both <commit>.
+	"git-diff A...B" is equivalent to
+	"git-diff `git-merge-base A B` B"
+	You can omit any one of both <commit>, which has the same
+	effect as using HEAD.
 
 Just in case if you are doing something exotic, it should be
 noted that all of the <commit> in the above description can be
@@ -54,6 +67,9 @@ any <tree-ish>.
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
 
+Be careful that despite looking like so, both "<commit>..<commit>"
+and "<commit>...<commit>" forms are NOT ranges as described in
+the "SPECIFYING RANGES" section in gitlink:git-rev-parse[1].
 
 OPTIONS
 -------
@@ -97,6 +113,18 @@ the tip of the current branch, but limit the comparison to the
 file "test".
 <3> Compare the version before the last commit and the last commit.
 
+Comparing branches::
++
+------------
+$ git diff topic master    <1>
+$ git diff topic..master   <2>
+$ git diff topic...master  <2>
+------------
++
+<1> Changes between the tips of the topic and the master branches.
+<2> Same as <1>
+<3> Changes that occured on the master branch since when the topic
+branch was started off it.
 
 Limiting the diff output::
 +

--9amGYk9869ThD9tj--
