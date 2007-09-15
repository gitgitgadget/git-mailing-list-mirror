From: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sat, 15 Sep 2007 18:22:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0709151819200.19941@alpha.polcom.net>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 18:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWarH-0002IH-Bp
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 18:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbXIOQu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 12:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbXIOQu6
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 12:50:58 -0400
Received: from alpha.lp.pl ([194.1.144.4]:45244 "EHLO alpha.polcom.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752042AbXIOQu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 12:50:58 -0400
X-Greylist: delayed 1676 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Sep 2007 12:50:57 EDT
Received: from localhost (localhost [127.0.0.1])
	by alpha.polcom.net (Postfix) with ESMTP id C2CB6505B1E;
	Sat, 15 Sep 2007 18:22:59 +0200 (CEST)
In-Reply-To: <20070915145437.GA12875@piper.oerlikon.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58261>

On Sat, 15 Sep 2007, martin f krafft wrote:
> also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.09.15.1610 +0200]:
>> No.  Git is a source code management system.  Everything else that
>> you can do with it is a bonus, a second class citizen.  Should we
>> really try to support your use case, we will invariably affect the
>> primary use case.
>
> I thought git was primarily a content tracker... so it all comes
> down to how to define content, doesn't it? But either way, we need
> not discuss that because that definition depends a lot on context
> and purpose and thus cannot be answered once and for all.
>
> I understand that for the primary use case, tracking nothing more
> than +x makes sense and should not be interfered with. This is why
> I was proposing a policy-based approach. The primary use case is
> unaffected, it's the default policy. Someone may choose to track
> other mode bits or file/inode attributes, according to one of
> several policies available with git, or even a custom policy. In
> that case, the repository needs to be appropriately configured.
>
> The reason why I say this should be done inside git rather than with
> hooks and an external tool, such as metastore is quite simple: git
> knows about every content entity in any tree of a repo and already
> has a data node for each object. Rather than introducing a parallel
> object database (shadow hierarchy or single file), it would make
> a lot more sense and be way more robust to attach additional
> information to these object nodes, wouldn't it?
>
> So with "appropriately configured" above, I meant that one should be
> able to say
>
>  git-config core.track all
>
> or
>
>  git-config core.track mode+attr
>
> or the default:
>
>  git-config core.track 7666
>  (read that as a umask, which masks out everything but the three
>  x bits. I made it 7666 instead of 7677 because core.umask and
>  core.sharedrepository then override the group and world bits if
>  needed)
>
> and have git do the right thing, rather than expecting those who
> want to track more than the executable bit to assemble a brittle set
> of hooks and metadata collectors+applicators and hope it all works.
>
> I understand also that this is not top priority for git, which is
> why I said earlier in the thread that the real difficulty might be
> to get Junio to accept a patch. But I think that the patch would be
> rather contained and small, having it all configurable would make it
> unintrusive, and if we all test it real well, it should pass as
> a bonus. After all, git can e.g upload patches to IMAP boxes, which
> in my world clearly is bonus material as well.

I also think such configuration option would be cool.

Not only for tracking /etc or /home but also for example for "web 
applications" (for example in PHP). In that case file and directory 
permissions can be as important as the source code tracked and it is pain 
to chmod (and sometimes chown) all files to different values after each 
checkout. Not speaking about potential race.


Thanks,

Grzegorz Kulewski
