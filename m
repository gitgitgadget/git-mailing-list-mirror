From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Expected Behavior?
Date: Fri, 11 Nov 2005 08:54:43 +1300
Message-ID: <46a038f90511101154p4ef99cddv82d56272921a80ac@mail.gmail.com>
References: <E1EZKOB-0002j5-VY@jdl.com>
	 <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	 <20051108210332.GB23265@c165.ib.student.liu.se>
	 <20051109112452.GD30496@pasky.or.cz>
	 <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com>
	 <20051109231248.GL16061@pasky.or.cz>
	 <46a038f90511091543h520f6a84k3e3b14c2e502989f@mail.gmail.com>
	 <20051109234925.GL30496@pasky.or.cz>
	 <46a038f90511091847t70567e50o2303f1dc7ada2464@mail.gmail.com>
	 <20051110193430.GU30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>,
	Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 20:57:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaIVT-0005hq-Ud
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVKJTyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVKJTyp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:54:45 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:35171 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750948AbVKJTyo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 14:54:44 -0500
Received: by xproxy.gmail.com with SMTP id s6so793381wxc
        for <git@vger.kernel.org>; Thu, 10 Nov 2005 11:54:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kdCsLMi9sfIuApHge7lOfkd/W1N6/RZh6S/jdZQERK/Tm/dD7yRpWNepjasZtsnIY4d3eMZIurXXUGWuVbI3tV0d29lkk7i99Ak1MLbSGC3EAMPU1k0bxILS2I+3RaJ/4+22eW0sGL1TpkycVjhjop1W6DC3tc4eakHfa9kHve0=
Received: by 10.64.208.4 with SMTP id f4mr893312qbg;
        Thu, 10 Nov 2005 11:54:43 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Thu, 10 Nov 2005 11:54:43 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051110193430.GU30496@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11514>

On 11/11/05, Petr Baudis <pasky@suse.cz> wrote:
> Well, basically like right now ;-).

Exactly. Which isn't documented, and has several subtleties that I
don't know of.

> Merging is a two-stage process, where the two stages are isolated and
> the latter does not interfere with the former. The former one is doing
> the actual content merge, and that's what cg-merge does. The latter one
> is recording the merge in history, and that's what cg-commit does.

There are some semantics to exchange info between cg-merge and
cg-commit and for handling the index while the user is resolving
conflicts or reviewing the merge before committing. I'm not familiar
with them, and I'm unsure what the design is...

 - how do cg-merge and cg-commit pass around the parents, commit msg,
files being merged vs dirty files on tree, etc? (easy: those lowercase
temp files in .git)
 - how do you run cg-status/cg-diff without messing up the index? does
running cg-status or cg-diff stand any risk of accidentally marking
for inclusion dirty files that are not part of the merge? hopefully
not, and then what's the technique?
 - should cg-status show more about the status of the index ?
 - how does cg-commit know whether conflicts have been resolved at
all? (perhaps it doesn't even try!)
 - how do you reset the 'we are merging' status?

Anyway, that's off the top of my head, and probably shows you that I'm
not 200% familiar with all the tricks available for handling the
index.

cheers,



martin
