From: Stephen Bash <bash@genarts.com>
Subject: Re: git bundle format [OT]
Date: Mon, 26 Nov 2012 16:31:09 -0500 (EST)
Message-ID: <484658581.104406.1353965469300.JavaMail.root@genarts.com>
References: <871B6C10EBEFE342A772D1159D13208537ABF6D3@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jason J CTR Pyeron (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:31:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td6H5-000155-Lw
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab2KZVbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 16:31:16 -0500
Received: from hq.genarts.com ([173.9.65.1]:33426 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754589Ab2KZVbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 16:31:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 0CC38BE21C9;
	Mon, 26 Nov 2012 16:31:15 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPPYVnrUqes5; Mon, 26 Nov 2012 16:31:09 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 560E8BE1BED;
	Mon, 26 Nov 2012 16:31:09 -0500 (EST)
In-Reply-To: <871B6C10EBEFE342A772D1159D13208537ABF6D3@umechphj.easf.csd.disa.mil>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC23 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210498>

----- Original Message -----
> From: "Jason J CTR Pyeron (US)" <jason.j.pyeron.ctr@mail.mil>
> Sent: Monday, November 26, 2012 4:06:59 PM
> Subject: RE: git bundle format [OT]
> 
> > First, a shot out of left field: how about a patch based workflow?
> > (similar to the mailing list, just replace email with sneakernet)
> > Patches are plain text and simple to review (preferable to an
> > "opaque" binary format?).
> 
> This is to only address the accidental development on a high side.
> Using this or any process should come with shame or punishment for
> wasting resources/time by not developing on a low side to start
> with.

Ah, if only more of those I (previously) worked with thought as you do :)

> But accepting reality there will be times where code and its
> metadata (commit logs, etc) will be created on a high side and
> should be brought back to the low side.

Using git format-patch and git am it's possible to retain the commit messages (and other associated metadata).  But again, I'm not the expert on this :)  I've made it work a few times to test patches from this list, but so far I've avoided serious integration into the mailing list workflow.

> >   2) Do the diffs applied to public repo contain any sensitive
> >   data?
> 
> That is a great question. Can the change of code while neither the
> original or the resultant be secret while the change imply or
> demonstrate the secret. I think the answer is yes.

In actual fact I was thinking about the simple case where the result included an "Eek! 3.1415926 cannot show up in this code!" (sometimes that's easier to see in a diff than a full text blob).  Obviously the first line of defense should catch such mistakes.  But yes, your point is also a good one.  I'd be hard pressed to argue that a particular series of commits leaks information on their own, but they can certainly corroborate other available information.

> > Question 2 is relatively straight forward and lead me to the patch
> > idea.  I would:
> >   - Bundle the public repository
> >   - Init a new repo in the secure space from the public bundle
> >   - Fetch from the to-be-sanitized bundle into the new repo
> >   - Examine commits (diffs) introduced by branches in the to-be-
> >   sanitized bundle
> >   - Perhaps get a list of all the objects in the to-be-sanitized
> >   bundle and do a git-cat-file on each of them (if the bundle is
> >   assembled correctly it shouldn't have any unreachable objects...).
> >   This step may be extraneous after the previous.
> 
> Here we would be missing the metadata that goes along with the
> commit. Especially the SHA sums.

Ah sorry, I guess I wasn't complete.  Once that process has been done on the high side one has to go back to question 1 and see if it's safe to move the bundle out to repeat the process on the low side. 
 
Stephen
