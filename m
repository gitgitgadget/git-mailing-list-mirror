From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 2/2] Reuse the same temp index in a transaction
Date: Mon, 14 Jul 2008 08:35:51 +0200
Message-ID: <20080714063551.GD20751@diana.vm.bytemark.co.uk>
References: <20080702060113.11361.39006.stgit@yoghurt> <20080702061314.11361.28297.stgit@yoghurt> <b0943d9e0807120324l7674c010w9a8e4a0bbdeeee65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:37:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIHgR-0002i6-Hk
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 08:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbYGNGf6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 02:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752990AbYGNGf6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 02:35:58 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3351 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbYGNGf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 02:35:57 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KIHf5-0005i7-00; Mon, 14 Jul 2008 07:35:51 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807120324l7674c010w9a8e4a0bbdeeee65@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88383>

On 2008-07-12 11:24:24 +0100, Catalin Marinas wrote:

> 2008/7/2 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Instead of making a new temp index every time we need one, just
> > keep reusing the same one. And keep track of which tree is
> > currently stored in it -- if we do several consecutive successful
> > pushes, it's always going to be the "right" tree so that we don't
> > have to call read-tree before each patch application.
> >
> > The motivation behind this change is of course that it makes
> > things faster.
> >
> > (The same simple test as in the previous patch -- pushing 250
> > patches in a 32k-file repository, with one file-level merge
> > necessary per push -- went from 0.36 to 0.19 seconds per patch
> > with this patch applied.)
>
> That's an impressive improvement (together with the previous patch).
> Is this with the new patch log infrastructure?

Yes, with all the bells and whistles -- in particular, with the
overhead of the simplified log. (But note that it's a synthetic
benchmark, and not a real linux-kernel patch series.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
