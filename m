From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 04 Jun 2006 03:42:29 -0700
Message-ID: <7v3belcicq.fsf@assigned-by-dhcp.cox.net>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	<7vodx9cm3g.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606040254n1449b62ta70c209ad8e1a0c@mail.gmail.com>
	<7vbqt9ck05.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606040333h1180bbep88fa90ea9928d062@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 12:42:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmq46-0004Tz-SC
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 12:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWFDKmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 06:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFDKmb
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 06:42:31 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59270 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932220AbWFDKma (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 06:42:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604104230.JBOE5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 06:42:30 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606040333h1180bbep88fa90ea9928d062@mail.gmail.com>
	(Marco Costalba's message of "Sun, 4 Jun 2006 12:33:34 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21262>

"Marco Costalba" <mcostalba@gmail.com> writes:

>> Sorry, in the example time flows from left to right.  If you
>> exclude g then you are excluding everything that is reachable
>> from g so you would not see "f".
>>
> From today git:
>
> tag list is:
>
> v1.3.3 1b9bc5a7b7434d771726011613a00cb202bd9f44
> v1.3.2 7abd7117ec57b8c3c2a469db62c7811fdac5c655
> v1.3.1 7d09fbe4ab7f080a8f8f5dcef7e0f3edf5e26019
> v1.3.0 4baff50551545e2b6825973ec37bcaf03edb95fe
>
> selected sha is ccb365047a1081455b767867f0887e7b4334f9d8
> (Allow "git repack" users to specify repacking window/depth)
>
> $ git-rev-list --topo-order ccb365047a1081455b767867f0887e7b4334f9d8
> ^1b9bc5a7b7434d771726011613a00cb202bd9f44
> ^7abd7117ec57b8c3c2a469db62c7811fdac5c655
> ^7d09fbe4ab7f080a8f8f5dcef7e0f3edf5e26019
> ^4baff50551545e2b6825973ec37bcaf03edb95fe
>
> ccb365047a1081455b767867f0887e7b4334f9d8
> ...
> cd2bdc5309461034e5cc58e1d3e87535ed9e093b
>
> Parent of cd2bdc5309461034e5cc58e1d3e87535ed9e093b is
>
> 4baff50551545e2b6825973ec37bcaf03edb95fe
>
> aka tag v1.3.0
>
> Am I missing something?

No, just that I am not getting what you are trying to prove
here.  The tags are all older than your chosen commit.

$ git-rev-list --topo-order ^v1.3.0 ^v1.3.1 ^v1.3.2 ^v1.3.3 e923eff

would show nothing -- and you propose to find out that commit is
between v1.3.1 and v1.3.2 by using the information that the
command gives an empty result but I do not know how?

$ git show-branch v1.3.1 e923eff v1.3.2

does show it is between these two, but that is because it avoids
the 2^N permutations by using 1-bit per revision that it wants to
check the reachability across.
