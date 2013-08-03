From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git replace: should it check for object type, and can it replace merges?
Date: Sat, 3 Aug 2013 17:46:37 +0200
Message-ID: <87zjsyydya.fsf@hexa.v.cablecom.net>
References: <24928554D0C34B4696DAD74F569E2E17@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Aug 03 17:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5e39-00025O-9m
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 17:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab3HCPq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 11:46:58 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:6746 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215Ab3HCPqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 11:46:40 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 17:46:27 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 17:46:37 +0200
In-Reply-To: <24928554D0C34B4696DAD74F569E2E17@PhilipOakley> (Philip Oakley's
	message of "Sat, 3 Aug 2013 16:13:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231599>

"Philip Oakley" <philipoakley@iee.org> writes:

> A recent comment http://stackoverflow.com/a/18027030/717355 on a
> question I asked two years ago about 'grafts' and 'replace' indicates
> that users think that 'git replace' can't replace a merge commit. The
> documentation doesn't have any examples and gives the naive impression
> that one should only replace a simple commit with another simple
> commit.
>
> Having looked at the code, I realised that anything can be replaced
> with anything, which is perhaps not what was intended. A simple
> thought is that the replace should be like-for-like with regard to
> object type, though that would not include replacing a sub-module for
> a tree (and vice versa).

Off hand I cannot come up with any case where you can replace one object
with one of a different type, keeping the history valid.

To back that up:

* Refs can be "replaced" simply by changing the ref itself.

* Annotated tags contain the type of the tagged object.

* The tree/parent lines in commits must be a tree and commits, resp.

* The object types referred to by trees are specified in the 'mode'
  field:
    100644 and 100755    blob
    160000               commit
    040000               tree
  (these are the only valid modes)

* Blobs don't point at anything.

So yes:

> Should 'git replace' check the object types to ensure they are sensible?

I think that would be a very good thing to check.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
