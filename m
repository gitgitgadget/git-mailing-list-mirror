From: "Balasubramaniam, Arunan" <Arunan.Balasubramaniam@misys.com>
Subject: RE: Implementing commit signing
Date: Fri, 10 Oct 2008 15:19:37 +0100
Message-ID: <E74D836C8B2CEF4A89F47E8ACECEEF9B749001@maildub1.misys.global.ad>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
To: <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 16:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoIsp-00011w-Ft
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 16:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbYJJOVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 10:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757583AbYJJOVM
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 10:21:12 -0400
Received: from cluster-a.mailcontrol.com ([80.69.8.190]:41404 "EHLO
	cluster-a.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757024AbYJJOVL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Oct 2008 10:21:11 -0400
Received: from rly25a.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly25a.srv.mailcontrol.com (MailControl) with ESMTP id m9AEL1Fc020638
	for <git@vger.kernel.org>; Fri, 10 Oct 2008 15:21:07 +0100
Received: from submission.mailcontrol.com (submission.mailcontrol.com [86.111.216.190])
	by rly25a.srv.mailcontrol.com (MailControl) id m9AEKDew019642
	for git@vger.kernel.org; Fri, 10 Oct 2008 15:20:13 +0100
Received: from MailDub1.misys.global.ad ([193.120.150.89])
	by rly25a-eth0.srv.mailcontrol.com (envelope-sender Arunan.Balasubramaniam@misys.com) (MIMEDefang) with ESMTP id m9AEJnmb018879; Fri, 10 Oct 2008 15:20:13 +0100 (BST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Implementing commit signing
Thread-Index: AckqOO0Pd+Lxb9MNRMC3cFkJcD4BoAAh+Fwg
X-Scanned-By: MailControl A-08-50-15 (www.mailcontrol.com) on 10.65.1.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97935>


Shawn O. Pearce wrote:
> Well, the idea was to sign the diff, but in a way that would
> reasonably allow it to be applied with limited fuzz, such as what
> git-apply would accept.  Thus signed changes could be emailed out
> by git format-patch and git send-email, and applied with git am,
> and the signature is still valid so long as the committer didn't
> mess with the patch.
> 
> Obviously if a commit was reverted and then reapplied again later,
> yes, the signature on the reapply may actually be valid, as the
> parents weren't taken into consideration.

I have realized I have been mixing things up; I was talking about
authors but mostly thinking about committers. The solution you
proposed tracked the author, so my question about it being
reapplied was a bit meaningless since the signature did not say
anything about the committer. My apologies.

As with having separate author and committer fields, would it make
sense to allow author and committer signatures? Just leaving aside
the issue of how much text it would take up for now, the committer's
signature could be created as tag signatures are, while the
author's could be as you originally described and would track the
content. If it reapplied to a different parent, then the signature
would be OK, but the committer would be listed as the one who
reapplied it. This would match how rebase works.

A project operating like the Linux kernel with patches only pulled
and emailed might use the author signature without the committer
one. I don't think there is any case for committer signing only.

If you ever merged or rebased, you automatically strip any committer
signature. If the operation succeeds, and the diff against the
parent matches the original diff, you could reuse the original
author signature.

Arunan


"Misys" is the trade name for Misys plc (registered in England and Wales). Registration Number: 01360027. Registered office: One Kingdom Street, London W2 6BL, United Kingdom. For a list of Misys group operating companies please go to http://www.misys.com/html/about_us/group_operating_companies/. This email and any attachments have been scanned for known viruses using multiple scanners. This email message is intended for the named recipient only. It may be privileged and/or confidential. If you are not the named recipient of this email please notify us immediately and do not copy it or use it for any purpose, nor disclose its contents to any other person. This email does not constitute the commencement of legal relations between you and Misys plc. Please refer to the executed contract betw
 een you and the relevant member of the Misys group for the identity of the contracting party with which you are dealing. 
