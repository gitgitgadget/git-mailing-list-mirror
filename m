From: Miles Bader <miles@gnu.org>
Subject: Re: blobs (once more)
Date: Thu, 07 Apr 2011 14:20:47 +0900
Message-ID: <buo4o6abpsg.fsf@dhlpc061.dev.necel.com>
References: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Thu Apr 07 07:20:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7heL-0000FV-KA
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 07:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab1DGFUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 01:20:50 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:38140 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab1DGFUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 01:20:50 -0400
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LJ900K7BO6OID50@relmlor4.idc.renesas.com> for
 git@vger.kernel.org; Thu, 07 Apr 2011 14:20:48 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LJ900FUKO6OKUB0@relmlir3.idc.renesas.com> for
 git@vger.kernel.org; Thu, 07 Apr 2011 14:20:48 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 8CD6248070; Thu, 07 Apr 2011 14:20:48 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 7B5D948087; Thu,
 07 Apr 2011 14:20:48 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac4.idc.renesas.com with ESMTP id QAB29226; Thu,
 07 Apr 2011 14:20:48 +0900
X-IronPort-AV: E=Sophos;i="4.63,314,1299423600";   d="scan'208";a="20430120"
Received: from unknown (HELO relay21.aps.necel.com) ([10.29.19.50])
 by relmlii2.idc.renesas.com with ESMTP; Thu, 07 Apr 2011 14:20:48 +0900
Received: from relay21.aps.necel.com ([10.29.19.50] [10.29.19.50])
 by relay21.aps.necel.com with ESMTP; Thu, 07 Apr 2011 14:20:48 +0900
Received: from dhlpc061 ([10.114.97.243] [10.114.97.243])
 by relay21.aps.necel.com with ESMTP; Thu, 07 Apr 2011 14:20:47 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id A7B8152E1E1; Thu,
 07 Apr 2011 14:20:47 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171042>

Pau Garcia i Quiles <pgquiles@elpauer.org> writes:
> The usual answer to the "I need to put binaries in the repository"
> question has been "no, you do not". Well, we do. We are in heavy
> development now, therefore today's version may depend on a certain
> version of a third-party shared library (DLL) which we only can get in
> binary form, and tomorrow's version may depend on the next version of
> that library, and you cannot mix today's source with yesterday's
> third-party DLL. I. e. to be able to use the code from 7 days ago at
> 11.07 AM you need "git checkout" to "return" our source AND the
> binaries we were using back then. This is something ClearCase manages
> satisfactorily.

If it were me, I'd just store the huge binaries in some sort of separate
remote filesystem, and then store the remote-file-system _paths_ to them
in git (in a simple text file).

Then either use the build system or some sort of git filter to make sure
that the actual library was installed before building based on the path
read from the file in git.

[This would be a pain as a _general_ solution (for git), because it
involves coordination with a the remote file system, etc, but for an
organization like yours setting up a system for a specific product, it
should be fairly easy to set up and maintain -- and particularly so if
the main use is to store 3rd party library releases, as they're
typically not going to be something that anybody will want to checkin,
but rather installed by a small set of people.]

-Miles

-- 
Circus, n. A place where horses, ponies and elephants are permitted to see
men, women and children acting the fool.
