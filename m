From: Junio C Hamano <junkio@cox.net>
Subject: Re: Proper Publishing of a Repository
Date: Wed, 22 Mar 2006 12:47:06 -0800
Message-ID: <7v3bha8awl.fsf@assigned-by-dhcp.cox.net>
References: <1143055072.4527.142.camel@cashmere.sps.mot.com>
	<20060322221630.e65baca0.tihirvon@gmail.com>
	<1143059181.4527.162.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 21:47:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMAEb-0005kQ-EC
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 21:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWCVUrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 15:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWCVUrK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 15:47:10 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:16102 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932295AbWCVUrI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 15:47:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060322204707.HTYV15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 15:47:07 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1143059181.4527.162.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Wed, 22 Mar 2006 14:26:21 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17828>

Jon Loeliger <jdl@freescale.com> writes:

> On Wed, 2006-03-22 at 14:16, Timo Hirvonen wrote:
>> Jon Loeliger <jdl@freescale.com> wrote:
>>
>> > All this on the linux kernel over HTTP.
>> 
>> Use git:// protocol (git-daemon) if possible.  It is much faster.
>
> Trust me, if it were an option, I would.  It isn't.
>
> So, I think git-prune-packed was the answer here...

It really depends on who your audiences are.  By packing
everything in a single pack, you are optimizing for the initial
cloners but punishing incremental updaters.

Since your tree is derived from Linus tree, anybody who is
interested in your tree is very likely nterested in Linus tree
and chances are that she has a recent copy of it locally.  In
such a case, I would not be surprised if:

	$ git clone -l -s -n /local-linux-2.6.git/ jdl-linux.git
        $ cd jdl-linux.git
        $ git fetch http://jdl.com/jdl-linux.git master:refs/heads/jdl

goes a lot faster if you have loose objects around in the
repository.
