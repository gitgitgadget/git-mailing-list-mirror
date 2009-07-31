From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Teach git how to propagate a fix across a file split
Date: Fri, 31 Jul 2009 17:59:37 +0200
Message-ID: <20090731155937.GA31427@atjola.homenet>
References: <9e4733910905141400h735b0897kb4adeec41b0ea398@mail.gmail.com>
 <9e4733910907310819x1c6fe089l75ae619b31f9feda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 17:59:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWuWH-0006Fl-GQ
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 17:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbZGaP7h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 11:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbZGaP7h
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 11:59:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:35863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751838AbZGaP7h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 11:59:37 -0400
Received: (qmail invoked by alias); 31 Jul 2009 15:59:35 -0000
Received: from i59F55869.versanet.de (EHLO atjola.homenet) [89.245.88.105]
  by mail.gmx.net (mp065) with SMTP; 31 Jul 2009 17:59:35 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+GQo9QMpOGgienUMgOBx3dFuE73wtuEnHq6cBTUG
	RUpbcNGmVc2TfV
Content-Disposition: inline
In-Reply-To: <9e4733910907310819x1c6fe089l75ae619b31f9feda@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124573>

On 2009.07.31 11:19:28 -0400, Jon Smirl wrote:
> On Thu, May 14, 2009 at 5:00 PM, Jon Smirl<jonsmirl@gmail.com> wrote:
> > Are there any git merge experts looking for something to do? We jus=
t
> > hit this situation again merging some ALSA branches for 2.6.31.
> >
> > A basic problem description:
> > Pending change for 2.6.31 splits file A into A and B
> > Fix is added to 2.6.30 in file A
> > The fix in A is in a section that is going to be in file B for 2.6.=
31
> >
> > Merge the two branches and note that git totally messes up on the
> > merge. It can't figure out that the fix needs to go into file B.
>=20
> I just hit this problem again.
>=20
> It can happen in other forms. In this case I'm trying to rebase three
> year old patches forward (good old embedded vendor port and forget
> behavior). Part of these patches made a four line change to one file.
> About a year latter a 1,000 line section from this file was moved to
> another pre-existing file. When I rebase the four line change forward
> it generates a merge conflict over the entire 1,000 line section that
> was moved. This conflict is in the file the section was moved out of
> which is not what you want.
>=20
> To fix this I have to search for where the 1,000 lines section was
> moved to. After I find it I can redo the four line patch.

The search can be done via blame:
git blame -C -C --reverse <old_rev>.. -- <file>

That shows the contents of <file> as of <old_rev> and where those
contents are now (as of HEAD). Of course, if the contents were changed =
a
lot since they were moved, the results won't be very useful, as git
simply can't find the old code in the new files anymore.

HTH
Bj=F6rn
