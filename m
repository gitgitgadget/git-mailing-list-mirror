From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Convert "pop" to the lib infrastructure
Date: Fri, 3 Apr 2009 12:36:07 +0200
Message-ID: <20090403103607.GA9113@diana.vm.bytemark.co.uk>
References: <20090331113027.2524.60993.stgit@pc1117.cambridge.arm.com> <20090401120515.GA30918@diana.vm.bytemark.co.uk> <b0943d9e0904020920t1a5b87b3i6ac0b37fbcf2ec62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 12:38:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpgnZ-0004e8-Kg
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 12:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763525AbZDCKgY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2009 06:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763511AbZDCKgX
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 06:36:23 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:54324 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763491AbZDCKgW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 06:36:22 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lpgkp-0002OP-00; Fri, 03 Apr 2009 11:36:07 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0904020920t1a5b87b3i6ac0b37fbcf2ec62@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115523>

On 2009-04-02 17:20:45 +0100, Catalin Marinas wrote:

> 2009/4/1 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2009-03-31 12:30:27 +0100, Catalin Marinas wrote:
> >
> > > @@ -47,7 +47,7 @@ test_expect_success 'Try to reset with --hard' =
'
> > > =A0 =A0 =A0stg reset --hard master.stgit^~1 &&
> > > =A0 =A0 =A0stg status a > actual.txt &&
> > > =A0 =A0 =A0test_cmp expected.txt actual.txt &&
> > > - =A0 =A0test "$(echo $(stg series))" =3D "> p1 - p3 - p2"
> > > + =A0 =A0test "$(echo $(stg series))" =3D "> p1 - p2 - p3"
> > > =A0'
> >
> > Hmm, why this change in behavior? Something that should be noted
> > in the commit message?
> >
> > > @@ -47,7 +47,7 @@ test_expect_success 'Try to undo with --hard' '
> > > =A0 =A0 =A0stg undo --hard &&
> > > =A0 =A0 =A0stg status a > actual.txt &&
> > > =A0 =A0 =A0test_cmp expected.txt actual.txt &&
> > > - =A0 =A0test "$(echo $(stg series))" =3D "> p1 - p3 - p2"
> > > + =A0 =A0test "$(echo $(stg series))" =3D "> p1 - p2 - p3"
> > > =A0'
> >
> > And I guess this is the same.
>
> I think we now get a slightly different behaviour because of how the
> transactions are generated with the new infrastructure. In the above
> case, you have "pop p2 p3" and "push p3", the latter failing. The
> "pop p2 p3" command results in the stack being "> p1 - p2 - p3"
> while "push p3" performs a single step for pushing and reordering.
> The old push caused a reorder followed by a push.

Ah, OK. Hmm, I guess either behavior has its pros and cons. (Though I
guess the new behavior -- not changing the order when the push failed
-- might be slightly more intuitive.)

Add that explanation to the commit message, and I'll award you a

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
