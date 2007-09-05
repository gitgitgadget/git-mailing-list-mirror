From: Mike Hommey <mh@glandium.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 21:20:33 +0200
Organization: glandium.org
Message-ID: <20070905192033.GA4681@glandium.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905174427.GC13314@fieldses.org> <Pine.LNX.4.64.0709051339420.30020@torch.nrlssc.navy.mil> <85642phqtn.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:22:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0Sj-0005Hi-UF
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868AbXIETWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbXIETWs
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:22:48 -0400
Received: from vawad.err.no ([85.19.200.177]:48095 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755065AbXIETWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 15:22:48 -0400
Received: from aputeaux-153-1-85-89.w86-205.abo.wanadoo.fr ([86.205.43.89] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IT0SM-0001nM-5s; Wed, 05 Sep 2007 21:22:32 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IT0QT-0001Ep-3V; Wed, 05 Sep 2007 21:20:33 +0200
Content-Disposition: inline
In-Reply-To: <85642phqtn.fsf@lola.goethe.zz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57752>

On Wed, Sep 05, 2007 at 09:09:40PM +0200, David Kastrup <dak@gnu.org> wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
> > On Wed, 5 Sep 2007, J. Bruce Fields wrote:
> >
> >> Well, this may just prove I'm an idiot, but one of the reasons I rarely
> >> run it is that I have trouble remembering exactly what it does; in
> >> particular,
> >>
> >> 	- does it prune anything that might be needed by a repo I
> >> 	  cloned with -s?
> >
> >     YES! yikes.
> >
> > This is about the best argument put forth so far for not
> > automatically running git-gc.
> 
> Well, it could also mean that if git finds a dead symbolic link when
> looking up an object, it should check the corresponding link target
> directory for a pack file with the respective object...  and if it
> finds such a pack file, create a link to it and use it.

The problem here is that the clone could be having refs on objects from
the origin that don't have refs left there. git-gc might, at some point,
prune these refs, and the clone would have dangling refs. That could
easily happen, for example, if you rebase a branch in the origin, but
still have a clone with the original branch.

Mike
