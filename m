From: Eugene Sajine <euguess@gmail.com>
Subject: need help with syncing two bare repos
Date: Fri, 3 Aug 2012 14:29:44 -0400
Message-ID: <CAPZPVFax6wa9QYOMxghhWK6LJaYWS2+WCbWQLA+LE53TdNXJhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 20:29:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxMdD-0002VW-K3
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 20:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab2HCS3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 14:29:47 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37680 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab2HCS3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 14:29:46 -0400
Received: by lbbgm6 with SMTP id gm6so1787267lbb.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tBixIU1og9SidOcK0mFNx598KPw3NEdaH+KjkD1e6tk=;
        b=Vmvzrmh6OGPrAz69PEIxVkIwo4I5WN2YaaSrSzm5fjSRwQ5Fr1MQJKxjqcvm7iO/rn
         HaQeIfbFDqLUdMatZEMbFz6PZKhlJZR2mjcMFK3JG5t+BMXla2s0necC91bbsZug5kTw
         2VyvZxoWXN3lYRSsDWfAlfxgdAeHZYxix/G++V5jFjzZiO9Z9dv3ecu0Z2MnH4oMWGYr
         soXC/mbPCR2KmXeQfl4HXjQGajIwrr7G6SrK+zWSNzuOY8EvhiZcvT6wcfNdjoxXYhz4
         TeOi2oLPcQAOL6R/MgREcu3daM8WrJsHKr38poo6IsNJ4WvEE2Lv3TaTVT/WFa50wLJO
         YWzw==
Received: by 10.112.40.33 with SMTP id u1mr1018528lbk.28.1344018584768; Fri,
 03 Aug 2012 11:29:44 -0700 (PDT)
Received: by 10.112.82.163 with HTTP; Fri, 3 Aug 2012 11:29:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202848>

Hi,

Could somebody please advise about how to address the following:

I have a bare repo (bareA) on one server in network1 and i have a
mirror of it on another server (bareB) in network2
BareB is updated periodically - no problem here
If bareA dies users are supposed to move seamlessly to bareB.
When bareA goes back up users are moved back but before it starts
serving repos (before git-daemon starts) it updates from bareB.

Now the problem i have is if bareA doesn't actually die, but the
connection between two networks drops.
In this case users from network2 will stop seeing bareA, they will
start working with bareB, while users in netwrok1 will continue
to work with bareA.

What would be the best way of syncing the bareB back to bareA when
connection is restored?

I think the best variant would be to do something like:

$ git pull --rebase /refs/heads/*:/refs/heads/*
$ git push origin /refs/heads/*:/refs/heads/*

but pull will not work on bare repos as i understand and there might
be conflicts that will lead to unknown (for me) state of bare repos

May be I'm looking into wrong direction? May be simple two way rsync
will do the job? But I'm a bit reluctant to rely on rsync because I'm
afraid it may screw up the repository information.

Any ideas are much appreciated!

Thanks,
Eugene
