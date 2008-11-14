From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 14 Nov 2008 00:08:22 -0500
Message-ID: <20081114050822.GA23963@foursquare.net>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org> <20081107071231.GA4063@blimp.localdomain> <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org> <20081109102528.GA5463@blimp.localdomain> <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de> <81b0412b0811101224gcffc958o6dbfcdc45e022874@mail.gmail.com> <alpine.DEB.1.00.0811102230330.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 14 06:16:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0r2R-0005Gh-4I
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 06:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbYKNFO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 00:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbYKNFO4
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 00:14:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:46899 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbYKNFOz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 00:14:55 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Nov 2008 00:14:53 EST
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id mAE58Ml7026919;
	Fri, 14 Nov 2008 00:08:23 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811102230330.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100951>

On Mon, Nov 10, 2008 at 10:31:32PM +0100, Johannes Schindelin wrote:
> On Mon, 10 Nov 2008, Alex Riesen wrote:
> > for cs in HEAD^..HEAD HEAD~10; do
> >   case "$cs"; in
> >   *..*)
> >      git format-patch --stdout "$cs"
> >      ;;
> >   *)
> >      git show --pretty=email "$cs"
> >      ;;
> >   esac
> > done
> > 
> > At least, this is what I have in mind and how I expect it to work.
> 
> That is not the way git-show is implemented (it uses setup_revisions() to 
> check for validity and to parse the arguments), and I cannot think of any 
> way to make this work without ugly workarounds.

Would it be possible to add "range" support to a subset of commands by
using a git-range wrapper?

Hypothetical, pie-in-the-sky idea:

	git range HEAD^..HEAD HEAD~10 -- show --pretty=email
	git range HEAD^..HEAD HEAD~10 -- log
	git range HEAD^..HEAD HEAD~10 -- cherry-pick

Which would call the given command for each of the commits found in all
the specified ranges and lists.  git-range could have an internal list
of supported git subcommands that it would massage the parameter lists for.

I find this both elegant and ugly at the same time. :-)

- Chris
