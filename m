From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 00/13] Eliminate 'top' and 'bottom' files
Date: Mon, 17 Sep 2007 10:17:02 +0200
Message-ID: <20070917081702.GB8657@diana.vm.bytemark.co.uk>
References: <20070914222819.7001.55921.stgit@morpheus.local> <20070915234244.GD25507@diana.vm.bytemark.co.uk> <b0943d9e0709160028h41a67474g6b379a45c4c88432@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 10:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXBnR-00009N-Nr
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 10:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbXIQIRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 04:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbXIQIRI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 04:17:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2505 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbXIQIRH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 04:17:07 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IXBmw-0002Ni-00; Mon, 17 Sep 2007 09:17:02 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0709160028h41a67474g6b379a45c4c88432@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58394>

On 2007-09-16 08:28:53 +0100, Catalin Marinas wrote:

> We should get rid of top.old and bottom.old as well.

Yeah, I guess that data could be computed from the patch log?

> My question - does this conflict with the DAG patches in any way? I
> intend to include the them at some point, once I get a chance to
> test the performance penalty with a big tree like the Linux kernel.

I haven't been able to get rid of all the expensive DAG walking, so
I've been considering a different approach: continue using the current
applied and unapplied files if the existing HEAD =3D=3D top patch check
passes, and letting the assimilate command do a full DAG walk to
regenerate those files. (And by "full DAG walk", I mean walking from
HEAD down to the first commit with parents !=3D 1; the patches we see
are applied (in the order we see them), and the rest are unapplied.)

> Is there any patch which consists of more than one commit? Maybe
> only uncommit could generate one but I think we put some tests in
> place.

Uncommit does not generate such patches, unless I've made a thinko; I
don't approve of them. But I always assumed they could exist, since
the code (at least in places) seems careful to not assume anything
about the number of commits between top and bottom.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
