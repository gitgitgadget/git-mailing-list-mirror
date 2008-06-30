From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/2] Try "stg sink" without applied patches
Date: Mon, 30 Jun 2008 10:44:33 +0200
Message-ID: <20080630084433.GA20712@diana.vm.bytemark.co.uk>
References: <20080629224440.9267.3591.stgit@yoghurt> <20080629224541.9267.19258.stgit@yoghurt> <bd6139dc0806300053m4325104dx145cd8840c630453@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org,
	Erik Sandberg <mandolaerik@gmail.com>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Jun 30 10:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDF1V-000203-TW
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 10:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbYF3IpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 04:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbYF3IpH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 04:45:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2548 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbYF3IpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 04:45:06 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KDEzx-0005Qv-00; Mon, 30 Jun 2008 09:44:33 +0100
Content-Disposition: inline
In-Reply-To: <bd6139dc0806300053m4325104dx145cd8840c630453@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86892>

On 2008-06-30 09:53:22 +0200, Sverre Rabbelier wrote:

> On Mon, Jun 30, 2008 at 12:45 AM, Karl Hasselstr=F6m <kha@treskal.com=
> wrote:
>
> > (The implicit sink testcase actually passes, but that's just
> > because the test suite can't distinguish between a program bug and
> > an orderly abort.)
>
> Yes it can, that's where "test_must_fail" comes in.
>
> > +test_expect_success 'sink without applied patches' '
> > +    test_must_fail stg sink
> > +'
> > +
>
> Like that.

Well, except that

  1. test_must_fail doesn't even exist in StGit's test-lib.sh, because
     I've omitted it on purpose when stealing good stuff from git's
     test-lib.sh, because

  2. StGit is written in Python, so random bugs virtually never cause
     segfaults and stuff, they just raise various exceptions.

That said, StGit (especially in the master branch -- but this patch
was against stable, where this is much less true) does exit with
different exit codes depending on what kind of exception interrupted
the program, and all exceptions not on a certain list cause it to exit
with an exit code that means there's a bug (see the end of
stgit/main.py for details). So writing a test_must_fail with sane
behavior is perfectly doable and not actually all that hard.

Patch? :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
