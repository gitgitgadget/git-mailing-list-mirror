From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Fri, 28 Nov 2008 20:25:15 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811281938250.19665@iabervon.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de> <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de> <20081128192033.GF23984@spearce.org>
 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 02:26:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6EbT-00051N-KF
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 02:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbYK2BZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 20:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbYK2BZS
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 20:25:18 -0500
Received: from iabervon.org ([66.92.72.58]:50913 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbYK2BZR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 20:25:17 -0500
Received: (qmail 24559 invoked by uid 1000); 29 Nov 2008 01:25:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Nov 2008 01:25:15 -0000
In-Reply-To: <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101896>

On Fri, 28 Nov 2008, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > ...
> >> In other words, unless there is more interest in that feature, enough to 
> >> generate a well-understood design before a good implementation, I'd rather 
> >> see this patch series dropped.
> >
> > Ack.  I agree with every remark made by Dscho, and also want to cry "wolf".
> >
> > I haven't had time to read the patch series.  Its big and intrusive
> > and I just don't need the feature.
> 
> Well, "me neither".  Although I personally think resisting changes until
> it becomes absolutely necessary is a good discipline, we also need to
> recognise that there is a chicken-and-egg problem.  When you have a
> potentially useful feature, unless people actually try using it in the
> field, you won't discover the drawbacks in either the design nor the
> implementation, let alone any improvements.

I just looked over most of it (skipping the generic index extension 
portion). It looks to me like it's introducing an extra concept to avoid 
actually fixing maybe-bugs in the "assume unchanged" implementation 
when used with files that have been changed intentionally (with the user 
intending git to overlook this change). Sparse checkout is essentially a 
special case of this, where the user has changed the working directory 
radically (not populating it at all) and wants git to carry on as if this 
was not the case (with a certain amount of porcelain code to cause this to 
happen automatically).

If there's any need for this to be distinguished from "assume unchanged", 
I think it should be used with, not instead of, the CE_VALID bit; and it 
could probably use some bit in the stat info section, since we don't need 
stat info if we know by assumption that the entry is valid.

	-Daniel
*This .sig left intentionally blank*
