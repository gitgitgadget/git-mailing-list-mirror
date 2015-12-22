From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RefTree: Alternate ref backend
Date: Tue, 22 Dec 2015 16:41:43 +0100
Message-ID: <56796F37.1000600@alum.mit.edu>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>, Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 16:49:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBPBO-0000PX-J2
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 16:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbbLVPsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 10:48:51 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55967 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754381AbbLVPst (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 10:48:49 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2015 10:48:49 EST
X-AuditID: 1207440f-f79df6d000007c0f-8e-56796f3b1dd1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id BD.84.31759.B3F69765; Tue, 22 Dec 2015 10:41:47 -0500 (EST)
Received: from [192.168.69.130] (p4FC969CC.dip0.t-ipconnect.de [79.201.105.204])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBMFfifX032077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 22 Dec 2015 10:41:45 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqGudXxlmsOEpm8X8TScYLbqudDNZ
	/GjpYbaYf2giqwOLx7PePYwef87vYfVY8Pw+u8fnTXIBLFHcNkmJJWXBmel5+nYJ3Blr9l1i
	KmiRrHizr42lgXGVSBcjJ4eEgInErO83WCFsMYkL99azdTFycQgJXGaU+HFuAjOEc4FJYtXb
	1ywgVcIC2hLPu3+BdYgIOEr0vfrHBGILCQRIfLvwhhHEZhZwk3i+upcNxGYT0JVY1NPMBLFB
	TqK3exLYHF6gOYeO3mYHsVkEVCVudc1nBrFFBUIk9u7sgKoRlDg58wmYzSkQKLHswgsWiPnq
	En/mXWKGsOUlmrfOZp7AKDgLScssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRr
	opebWaKXmlK6iRES6vw7GLvWyxxiFOBgVOLhnbCgIkyINbGsuDL3EKMkB5OSKO/JzMowIb6k
	/JTKjMTijPii0pzU4kOMEhzMSiK8AUFAOd6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTU
	gtQimKwMB4eSBK9gHlCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCiG44uBUQyS
	4gHaawXSzltckJgLFIVoPcWoKCXOKwCSEABJZJTmwY2FJbBXjOJAXwrzZoBU8QCTH1z3K6DB
	TECD/6wrBxlckoiQkmpgTOeJ/HDsM2u1muSvxzmViteOluy1OZp4fo23UcP7rY6L6rnCgjay
	WLrtcwsIWGx4ZJbupkp3hp87TzLbdMpOqeOfuvf9hSe5U924uXauONiQ0lnUL/VR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282880>

On 12/17/2015 10:02 PM, Shawn Pearce wrote:
> I started playing around with the idea of storing references directly
> in Git. Exploiting the GITLINK tree entry, we can associate a name to
> any SHA-1.
> 
> By storing all references in a single tree, atomic transactions are
> possible. Its a simple compare-and-swap of a single 40 byte SHA-1.
> This of course leads to a bootstrapping problem, where do we store the
> 40 byte SHA-1? For this example its just $GIT_DIR/refs/txn/committed
> as a classical loose reference.

I like this general idea a lot, even while recognizing some practical
problems that other people have pointed out. I especially like the idea
of having truly atomic multi-reference updates.

I'm curious why you decided to store all of the references in a single
list, similar to the packed-refs file. This design means that the whole
object has to be rewritten whenever any reference is updated [1].
Certainly, storing the references in a single tree *object* is not a
requirement for having atomic transitions.

I would have expected a design where the layout of the references in
trees mimics the layout of loose references in the filesystem; e.g., one
tree object for "refs/", one for "refs/heads/" one for "refs/remotes/"
etc. This design would reduce the amount of rewriting that is needed
when one or a few references are updated.

Another reason that I find a hierarchical layout intriguing would be
that one could imagine using the SHA-1s of reference namespace subtrees
to speed up the negotiation phase of "git fetch". In the common case
that I use the local namespace "refs/remotes/origin" to track an
upstream repo, the SHA-1 of my "refs/remotes/origin" tree would usually
represent a complete description of the state of the upstream references
at the time that I last fetched. My client could tell the server

    have-tree $SHA1

, where $SHA1 is the hash of the tree representing
"refs/remotes/origin/". If the server keeps a reflog as you have
described (but hierarchically), then the server could look up $SHA1 and
immediately know the full set of references, and therefore of objects,
that I fetched last time. More generally, the negotiation could proceed
down the reference namespace tree and stop whenever commonality is found.

There are a lot of "if"s in that last paragraph, and maybe it's not
workable. For example, if I'm not pruning on fetch, then my reference
tree won't be identical to one that was ever present on the server and
this technique wouldn't necessarily help. But if, for example, we change
the default to pruning, or perhaps record some extra reftree SHA-1's,
then in most cases I would expect that this trick could reduce the
effort of negotiation to negligible in most cases, and reduce the time
of the whole fetch to negligible in the case that the clone is already
up-to-date.

Michael

[1] At GitHub, we store public repositories in networks with a shared
object store. The central repository in each network can have 10M+
references. So for us, rewriting that many references for every
reference update would be unworkable.

-- 
Michael Haggerty
mhagger@alum.mit.edu
