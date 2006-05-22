From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Tue, 23 May 2006 11:15:07 +1200
Message-ID: <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com>
References: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
	 <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
	 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	 <44720C66.6040304@gentoo.org>
	 <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
	 <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	 <20060522214128.GE16677@kiste.smurf.noris.de>
	 <7v8xotadm3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Matthias Urlichs" <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 01:15:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJcI-0002CX-8S
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWEVXPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWEVXPK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:15:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:30022 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751294AbWEVXPI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 19:15:08 -0400
Received: by wr-out-0506.google.com with SMTP id 50so729852wri
        for <git@vger.kernel.org>; Mon, 22 May 2006 16:15:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bpzooI3CR5AfCy0hG9KuiGX7LtDjhtrtWvMpLE6ummpVUKUAKbraE/abaqTkzB57oG/2z7Bj3zmH3/q/jf+6c3BlrJvtEyLaMVrPiP03lD1gcSRg6oCMhpkltBnievQRKQGnfk1m8jzWpxQOi6MTL6U6sy1dRLUNpeCnpWWV6Yg=
Received: by 10.54.121.3 with SMTP id t3mr5346987wrc;
        Mon, 22 May 2006 16:15:07 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Mon, 22 May 2006 16:15:07 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xotadm3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20548>

On 5/23/06, Junio C Hamano <junkio@cox.net> wrote:
> > I simply was too lazy to count the actual filenames' lengths. ;-)
>
> I think cvsimport predates that option, but these days that loop
> can be optimized by feeding --index-info from standard input.

Oh, yep, that'd be a good addition. I think we can also cut down on
the number of fork+exec calls (as Linus points out they are killing
us) by caching some data we should already have that we are repeatedly
asking from git-ref-parse.

Other TODOs from my reading of the code last night...

 - Switch from line-oriented reads to block reads when fetching files
from CVS. This gentoo has repo has some large binary blobs in it and
we end up slurping them into memory.

 - Stop abusing globals in commit() -- pass the commit data as parameters.

 - Further profiling? Whatever we are doing, we aren't doing it fast :(

Will be trying to do those things in the next few days, don't mind if
someone jumps in as well.



martin
