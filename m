From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 3/3] Make old sha1 optional with git update-ref -d
Date: Mon, 26 May 2008 16:09:31 +0200
Message-ID: <20080526140931.GA18440@diana.vm.bytemark.co.uk>
References: <20080525161125.25087.18083.stgit@yoghurt> <20080525161440.25087.83011.stgit@yoghurt> <alpine.DEB.1.00.0805261149310.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 26 16:11:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0dPi-0001Pz-M1
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 16:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbYEZOKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 May 2008 10:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbYEZOKK
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 10:10:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1817 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbYEZOKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 10:10:09 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K0dOF-0004vn-00; Mon, 26 May 2008 15:09:31 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805261149310.30431@racer>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82935>

On 2008-05-26 11:51:12 +0100, Johannes Schindelin wrote:

> On Sun, 25 May 2008, Karl Hasselstr=F6m wrote:
>
> > Giving the old sha1 is already optional when changing a ref, and
> > it's quite handy when running update-ref manually. So make it
> > optional for deleting a ref too.
>
> Isn't this a bit dangerous, especially given that there is
> potentially _no_ reflog as a safeguard?
>
> So no, it is not the same as when changing a ref.
>
> I am mildly negative on this (having lost some remote branches,
> because they were deleted _together with the reflogs_ by "git push
> bla :x"),

Deleting the wrong thing is never a fun experience. The thing is, this
patch doesn't really make it any easier to delete the wrong thing.
Before, you'd

  git update-ref -d <ref> <some-other-way-to-point-to-the-same-commit>

if you wanted to play it safe, and

  git update-ref -d <ref> <ref>

if you thought you knew what you were doing. All this patch does is
make the second usage mode easier to type.

(One might argue that a user who doesn't know what she's doing will
have an easier time shooting herself in the foot when the oldvalue is
optional, but I was under the impression that ease of use without
consulting the man page shouldn't be a factor when designing the
plumbing UI.)

I do agree with you that branch deletion is one of the more
"dangerous" operations in git. But I don't think making update-ref
hard to use is the answer there; what we'd really need is for old
reflogs to stay around for a while before being deleted.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
