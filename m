From: "Balasubramaniam, Arunan" <Arunan.Balasubramaniam@misys.com>
Subject: RE: Implementing commit signing
Date: Thu, 9 Oct 2008 18:53:03 +0100
Message-ID: <E74D836C8B2CEF4A89F47E8ACECEEF9B748DCD@maildub1.misys.global.ad>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
To: <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 19:57:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnzkQ-00011n-Ah
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 19:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757167AbYJIRzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 13:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbYJIRzJ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 13:55:09 -0400
Received: from cluster-a.mailcontrol.com ([80.69.8.190]:53967 "EHLO
	cluster-a.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbYJIRzI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2008 13:55:08 -0400
Received: from rly29a.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly29a.srv.mailcontrol.com (MailControl) with ESMTP id m99HsQN3011009
	for <git@vger.kernel.org>; Thu, 9 Oct 2008 18:55:03 +0100
Received: from submission.mailcontrol.com (submission.mailcontrol.com [86.111.216.190])
	by rly29a.srv.mailcontrol.com (MailControl) id m99HrSfe006189
	for git@vger.kernel.org; Thu, 9 Oct 2008 18:53:28 +0100
Received: from MailDub1.misys.global.ad ([193.120.150.89])
	by rly29a-eth0.srv.mailcontrol.com (envelope-sender Arunan.Balasubramaniam@misys.com) (MIMEDefang) with ESMTP id m99HrBAQ005905; Thu, 09 Oct 2008 18:53:28 +0100 (BST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Implementing commit signing
Thread-Index: AckqJdx0R4RR7wG1T+KYolz6CxFpJAABKEmQ
X-Scanned-By: MailControl A-08-50-15 (www.mailcontrol.com) on 10.65.1.139
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97869>

Shawn,

thank you for such a detailed reply. I only have a few points:

Shawn O. Pearce wrote:
> "Balasubramaniam, Arunan" <Arunan.Balasubramaniam@misys.com> wrote:
> > I am looking at using Git within our organisation, and verifying the
> > source of
> > commits has been raised as a concern. GPG signing individual commits
has
> > been
> > discussed at least once on this list [1].
> 
> Another approach is to use a central Git server with SSH
> key authentication and install into every repository the
> contrib/hooks/update-paranoid hook as $GIT_DIR/hooks/update.
> This is actually what I did at my prior day-job.

We had looked at this sort of approach but are not hugely in favour of
it.
Engineers here operate in teams, with the work integrated and sent into
the
central repository by one person at regular intervals. We are leaning
toward
using our repositories in the same sort of manner. This is actually one
of
our reasons to move to DVCS. This is not to say we would not use a
central
server if it turned out to be our best option.

> But as I think about it more, if you signed the diff, excluding the
> line offsets in the hunk headers (so file paths, context and -/+
> lines), the "author" line and the message, leaving out the other
> fields of the commit message, it may be possible to still include
> the signature in an email formatted patch and carry it through a
> "git format-patch | git am" pipeline and still have it verify.

Would this be dangerous? If you were to leave out the parent fields in
the commit message, surely you could then reapply an old commit (that
say introduced a bug)?

> Its difficult to guage rejection without seeing the code behind it
> and considering the consequences of including that code.  A lot
> of these hypothetical discussions start out with a question like
> this, raise some good points, and then folks are waiting to see it
> implemented, but no code comes about.

I hope I disclaimed enough that I'm not promising to do it :) As much as
it
does interest me, we may end up using the centralised server model you
talked about or cleaning up the prototype I've been playing with that
amends
commits to add signature blocks or something else that suits. I am going
to
present some options to a higher power to decide what happens.

> >   2) If it were accepted into Git, would an equivalent patch be
accepted
> > into
> >      jgit? Would patches for UI to use it be accepted into egit?
> 
> Yes, absolutely, so long as the implementation in Java was reasonably
> sane.  E.g. we'd prefer you used a pure Java implementation of
> GnuPG, rather than say forking out to a Python script that execs
> some Haskell program to use a SOAP RPC to a remote signing service
> written in Tcl... ;-)

I don't think that there is a Java GPG implementation about, some
searching
didn't find any live looking projects . Would a JNI wrapper to say GPGME
(http://www.gnupg.org/related_software/gpgme/index.en.html) be
acceptable?

Thanks again,
Arunan


"Misys" is the trade name for Misys plc (registered in England and Wales). Registration Number: 01360027. Registered office: One Kingdom Street, London W2 6BL, United Kingdom. For a list of Misys group operating companies please go to http://www.misys.com/html/about_us/group_operating_companies/. This email and any attachments have been scanned for known viruses using multiple scanners. This email message is intended for the named recipient only. It may be privileged and/or confidential. If you are not the named recipient of this email please notify us immediately and do not copy it or use it for any purpose, nor disclose its contents to any other person. This email does not constitute the commencement of legal relations between you and Misys plc. Please refer to the executed contract betw
 een you and the relevant member of the Misys group for the identity of the contracting party with which you are dealing. 
