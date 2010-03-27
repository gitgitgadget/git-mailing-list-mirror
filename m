From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 12:20:18 -0700
Message-ID: <20100327192018.GG10910@spearce.org>
References: <20100326222950.GB10910@spearce.org> <4BAD3C6E.4090604@gmail.com> <20100326230537.GC10910@spearce.org> <7v7hoyabiv.fsf@alter.siamese.dyndns.org> <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com> <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org> <alpine.LFD.2.00.1003262125120.694@xanadu.home> <20100327013443.GE10910@spearce.org> <7vvdci2vk8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 20:20:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvbYZ-0001h7-9H
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 20:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858Ab0C0TUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 15:20:23 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:62455 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab0C0TUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 15:20:22 -0400
Received: by ywh2 with SMTP id 2so4174961ywh.33
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 12:20:21 -0700 (PDT)
Received: by 10.101.143.9 with SMTP id v9mr3323930ann.169.1269717621319;
        Sat, 27 Mar 2010 12:20:21 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm2109465iwn.2.2010.03.27.12.20.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 12:20:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvdci2vk8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143345>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > But GitHub's approach here seems to be "Meh, its fine, don't worry
> > about it".
> >
> > Its *NOT* fine.  But Avery and Junio might disagree with me.  :-)
> 
> Did I ever say it is _fine_?  I thought I said "complain loudly".

I apologize if I misrepresented you above.
 
> That would at least give poor jgit users who have hit such a corrupted
> object a chance to get a controlled notice and ask for help (and get an
> insn to recover with filter-branch that appeared in this thread).

Well, there is "complain loudly but do it anyway" and "hard stop".

JGit currently has the leading '0' be a "hard stop".  Because this is
the fsck code running inside of the receive-pack service, validating
what the user sent is isn't malformed.  Its clearly malformed.

This only got discovered because Mike tried to take a repository
from GitHub and push it into Gerrit Code Review, where JGit's fsck
routine cannot be bypassed during receive-pack.

Are you suggesting JGit should change its behavior to be "complain
loudly but do it anyway"?  I'm open to making the code change there
if that is how you think a Git implementation should behave in
this case.  But I don't want to do it just to match CGit's behavior,
sometimes CGit can be wrong.  :-)

-- 
Shawn.
