From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 12:48:31 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707031159580.9434@woody.linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
 <20070702142557.eba61ccd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
 <20070702145601.a0dcef0f.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
 <7vhcomuofl.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
 <Pine.LNX.4.64.0707031303130.4071@racer.site>
 <4d8e3fd30707030521k6cb3129dy9193344e9e1eccf7@mail.gmail.com>
 <20070703183947.GE5322@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>, quilt-dev@nongnu.org,
	Paul Eggert <eggert@cs.ucla.edu>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:48:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5oMo-0006rR-6d
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 21:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760857AbXGCTsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 15:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760854AbXGCTsu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 15:48:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55925 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760857AbXGCTst (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 15:48:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l63Jmbvo025749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2007 12:48:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l63JmV6K011800;
	Tue, 3 Jul 2007 12:48:31 -0700
In-Reply-To: <20070703183947.GE5322@thunk.org>
X-Spam-Status: No, hits=-2.639 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51530>


[ Paul Eggert added to Cc: I'm not sure he actually maintains "patch" 
  or cares any more, but hopefully he at least knows who does ]

On Tue, 3 Jul 2007, Theodore Tso wrote:
> 
> Or people could submit a bug report/feature request/patch to the
> patch(1) maintainer.  :-)

Is there such a thing?

The latest official version of patch from GNU is 2.5.4 from 1999, I think.

I'm finding references to 2.5.9 in distributions (from 2003), but 2.5.4 is 
the latest I see on the GNU mirror at kernel.org, and that's also what 
Fedora 7 has too, it seems, so the 2.5.9 thing seems to be something 
unofficial or at least not widely known about..

Anyway, I tried to look at the patch sources, but I had to stop. That 
whole "intuit_diff_type()" function is probably designed as an initiation 
rite for any patch programmers, and to make sure that you have to be 
really serious about wanting to send patches before you can become part of 
the "in crowd". It's "mental hazing".

Yeah, git-apply sources aren't necessarily a thing of great beauty either, 
but in comparison to patch, I think it's a work of art. Of course, part of 
it is that it doesn't try to parse 'ed' scripts etc, but a large part of 
it really is that "patch" is an old program that has grown over time, and 
not seen a lot of cleanups, I suspect.

IOW, I tried to see how easy it would be to dismiss the code that 
takes care of "indent", but it wasn't totally obvious. It's set in many 
different places, and the logic for "skip_this_patch" is a bit confusing.

Anyway, with Paul Eggert Cc'd, maybe he can help us sort it out.

Paul - the issue here isn't actually with git at all, but the fact that 
Andrew Morton noticed that he cannot apply one of the series of patches he 
has with "patch" (well, with his scripts that are designed _around_ 
patch, to be exact).

The reason? Part of the patch *description* looked like this:

    [SCSI] 53c700: Amiga 4000T NCR53c710 SCSI

    New driver for the Amiga 4000T built-in NCR53c710 SCSI controller, using the
    53c700 SCSI core.

where it really *was* indented by four characters (and that's where git 
comes in: git indents the patch descriptions exactly so that you cannot 
*possibly* confuse the patch itself with the description).

It turns out that "patch" would actually think there is a patch there: the 
line

    53c700 SCSI core.

was determined to be an ed-script ("53c700") _despite_ the fact that it's 
indented.

Andrew was able to fix that particular damage by using "-u" and forcing 
anything but unified diffs to be ignored, but that isn't an option for all 
quilt users, since some projects use old-fashioned context diffs or a 
mixture.

Besides, the explanations can certainly contain patch fragments anyway (in 
the kernel, we put things like example code in them).

And it really boils down to a really simple thing: when scripting, you DO 
NOT WANT "patch" to make random guesses. And that whole "indentation" 
thing by patch is a pure guess, and should simply NOT BE DONE. And there's 
no way to tell patch to not do it.

So Paul, you're our only hope.

I'm personally trying to tell people not to use "patch" at all (this isn't 
the first time patch has done insane things by default, but it's the first 
time you cannot even _disable_ the insane behaviour), but Ted has a point: 
regardless of whether people learn to use "git-apply" to apply patches, 
the old "patch" binary would be better off just improved.

In this case, the improvement would be to simply ignore indented patches 
(preferably by default, but at least have the option to do so).

		Linus
