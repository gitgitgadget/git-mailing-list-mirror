From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Enable and fix support for base less merges.
Date: Wed, 05 Oct 2005 14:22:29 -0700
Message-ID: <7v64sbk6ay.fsf@assigned-by-dhcp.cox.net>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
	<4340A01F.7040901@gmail.com> <7vfyrjw8qb.fsf@assigned-by-dhcp.cox.net>
	<20051003061309.GA1712@c165.ib.student.liu.se>
	<46a038f90510022334k63884c6x377104e7eca29c48@mail.gmail.com>
	<20051004060755.GA1687@c165.ib.student.liu.se>
	<46a038f90510032322t6623c8d4y969e4e00bf4dfe26@mail.gmail.com>
	<20051005203230.GB1833@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 23:22:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENGih-0005xx-MU
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 23:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbVJEVWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 17:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVJEVWb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 17:22:31 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:31464 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030306AbVJEVWa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 17:22:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005212217.MENO2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 17:22:17 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051005203230.GB1833@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Wed, 5 Oct 2005 22:32:30 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9733>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> Anyway, the idea I have thought about is to use (probably
> base64-encoded) xdelta diffs for the binary files. With this approach
> git diffs could look like:
>
> diff --git --xdelta a/foo b/foo
> <base64-encoded xdelta data>
>
> Is this approach reasonable?

If we continue to operate within 3-way merge paradigm of
"merging his changes to common ancestor into mine", more
appropriate would be to make the use of "merge" a bit more
configurable.  As HPA mentioned, XML for example is a text file
not binary, but textual merge of it often produces less than
usable results, especially when it is machine generated, meant
to be consumed by machines, and optimized for compactness.  Just
like we made merge strategy backends pluggable to git-merge,
strategy backends, after making their own decision on what 3
blobs to use for 3-way file-level merge, can be told which
low-level merge program to use (merge, diff3, wiggle, ...).
