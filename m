From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: git-rev-list  in local commit order
Date: Sun, 15 May 2005 15:57:56 -0400 (EDT)
Message-ID: <4971.10.10.10.24.1116187076.squirrel@linux1>
References: <4127.10.10.10.24.1116107046.squirrel@linux1>
    <1116186533.11872.152.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:58:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXPFM-0006rZ-OU
	for gcvg-git@gmane.org; Sun, 15 May 2005 21:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVEOT6A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 15:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEOT6A
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 15:58:00 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:40395 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261152AbVEOT55 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 15:57:57 -0400
Received: from linux1 ([69.156.111.46]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050515195757.WPKH11463.simmts6-srv.bellnexxia.net@linux1>;
          Sun, 15 May 2005 15:57:57 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4FJvtxZ007358;
	Sun, 15 May 2005 15:57:56 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 15 May 2005 15:57:56 -0400 (EDT)
In-Reply-To: <1116186533.11872.152.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2005 3:48 pm, Thomas Gleixner said:
> On Sat, 2005-05-14 at 17:44 -0400, Sean wrote:
>> Attached is a preliminary hackish patch to sort git-rev-list in local
>> commit order.
>
> +unsigned long sha1_local_date(const unsigned char *sha1)
> +{
> +       struct stat st;
> +       if (find_sha1_file(sha1, &st))
> +               return st.st_mtime;
> +       return 0;
> +}
>
> Do you really want to base workflow and history information on file
> times ?

The local commit order just isn't all that important in many situations. 
And for situations where it is important, this proposal seems completely
adequate.   Mind you, the patch in question is complete crap.

> File times are local and completely error prone in distributed
> environments.

I disagree that they're inherently error prone, steps can be taken to make
them as secure as you desire.  Also, many people just will not care about
this local-commit-time as they will simply be tracking a remote
repository.   For applications like David Woodhouse's need to present the
newest commits first on a web page, this is _completely_ adequate.   I've
yet to see an intended use for this information that isn't completely
handled by this proposal.  Afterall, most people using git are getting by
just fine without such a facility today.

Regards,
Sean


