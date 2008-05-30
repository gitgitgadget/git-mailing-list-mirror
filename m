From: David Dillow <dave@thedillows.org>
Subject: Re: reducing prune sync()s
Date: Thu, 29 May 2008 21:51:35 -0400
Message-ID: <1212112295.3094.3.camel@obelisk.thedillows.org>
References: <20080529205743.GC17123@redhat.com>
	 <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Frank Ch. Eigler" <fche@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Fri May 30 03:52:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1tnF-0003xl-Bv
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 03:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbYE3Bvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 21:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYE3Bvl
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 21:51:41 -0400
Received: from smtp.knology.net ([24.214.63.101]:34949 "EHLO smtp.knology.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333AbYE3Bvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 21:51:40 -0400
Received: (qmail 1968 invoked by uid 0); 30 May 2008 01:51:37 -0000
Received: from unknown (HELO shed.thedillows.org) (75.76.31.149)
  by smtp7.knology.net with SMTP; 30 May 2008 01:51:37 -0000
Received: from [192.168.1.10] (obelisk.gig.thedillows.org [192.168.1.10])
	by shed.thedillows.org (8.13.8/8.13.8) with ESMTP id m4U1paxN002216;
	Thu, 29 May 2008 21:51:36 -0400
In-Reply-To: <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org>
X-Mailer: Evolution 2.12.3 (2.12.3-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83263>


On Thu, 2008-05-29 at 17:27 -0700, Linus Torvalds wrote:
> That would be much better. The code was ported from shell script, and 
> there is no fsync() in shell, but the rule should basically be that you 
> can remove all the objects that correspond to a pack-file after you have 
> made sure that the pack-file (and it's index - we can re-generate the pack 
> index, but realistically speaking it's *much* better to not have to) is 
> stable on disk.

Even if the data is stable on disk, don't we also need to ensure the
pack's connectivity to the namespace is also stable? Without an fsync()
of the directory that contains it, could it go away?

Of course, this is me recollecting a several-year-old exchange on LKML,
so I don't know if it is still needed or not, or on systems other than
Linux.

Dave
