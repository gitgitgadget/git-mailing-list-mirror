From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Fri, 19 May 2006 16:58:25 -0700
Message-ID: <20060519235825.GA3289@kroah.com>
References: <Pine.LNX.4.64.0605161001190.3866@g5.osdl.org> <m1bqtx6el6.fsf@ebiederm.dsl.xmission.com> <7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net> <m13bf95ixo.fsf@ebiederm.dsl.xmission.com> <7v1wut2p5z.fsf@assigned-by-dhcp.cox.net> <m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com> <7vsln8cwn6.fsf@assigned-by-dhcp.cox.net> <m1zmhg31cm.fsf@ebiederm.dsl.xmission.com> <7vy7x09qet.fsf@assigned-by-dhcp.cox.net> <m1ejyr38xx.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 02:00:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhEtX-0005pB-5d
	for gcvg-git@gmane.org; Sat, 20 May 2006 02:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWETAAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 20:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWETAAc
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 20:00:32 -0400
Received: from mail.suse.de ([195.135.220.2]:14035 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751435AbWETAAb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 20:00:31 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id A0D92EFF0;
	Sat, 20 May 2006 02:00:30 +0200 (CEST)
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m1ejyr38xx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20366>

On Thu, May 18, 2006 at 04:48:26AM -0600, Eric W. Biederman wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > ebiederm@xmission.com (Eric W. Biederman) writes:
> >
> >> Junio C Hamano <junkio@cox.net> writes:
> >>
> >>> What's the expected workflow for you to work on a 1300 patch
> >>> series you get from Andrew in the next installment to deal with
> >>> 88 unattributed patches?  Answer the question 88 times and make
> >>> sure you get the answers right every time?  Or abort and
> >>> hand-edit them to help mailinfo to notice the correct
> >>> attribution and re-run?
> >>
> >> For the internal consumption case it isn't a big deal.  I
> >> can specify --author with something bogus and it works. 
> >
> > Yes.
> >
> >>> I know I am guilty of suggesting "going interactive", but I have
> >>> a feeling that having an optional file that maps patch-name to
> >>> author might be easier to work with.  If the old patches are
> >>> recycled in the updated -mm set, you probably can reuse the
> >>> mapping for them, adding entries for newly introduced "unnamed"
> >>> patches as needed.
> >>
> >> Short of getting the script where it has a sane restart in the
> >> middle mode going interactive and asking questions makes a lot
> >> of sense.  Especially with smaller trees.
> >
> > Yes perhaps on smaller trees, but that does not mean much.  For
> > smaller trees and/or smaller patch series almost anything would
> > do.
> 
> Yes, a smaller patch series, that is what I meant.
> Most quilt trees that I know about are in needed small.

$ quilt series | wc -l
207

And that is about "normal" for me.  Sometimes it grows to about 500+
patches, but that only happens when there's a longer kernel release
cycle.

Another tree that I work on all the time is about 700+ patches, and yet
another 2000+.  So you might re-evaluate your statement about "small"
quilt series :)

In looking at your script, it doesn't seem to be able to handle patches
in quilt that are in mbox format.  Any thoughts to allow this to handle
the attribution properly?

Right now my development flow has me converting my quilt tree to one big
mbox file and then using 'git applymbox' to import it before asking
Linus to pull from it.

With your script I could skip at least one step, which would save me
some time...

thanks,

greg k-h
